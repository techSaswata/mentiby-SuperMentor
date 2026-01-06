-- =============================================
-- CREATE MENTOR ATTENDANCE TABLE
-- Run this in MAIN DATABASE (not Database B)
-- =============================================

CREATE TABLE IF NOT EXISTS public.mentor_attendance (
  mentor_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT,
  total_classes INTEGER DEFAULT 0,
  present INTEGER DEFAULT 0,
  absent INTEGER DEFAULT 0,
  special_attendance INTEGER DEFAULT 0,  -- Classes taken on behalf of other mentors
  attendance_percent DECIMAL(5,2) DEFAULT 0,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS idx_mentor_attendance_percent 
ON mentor_attendance(attendance_percent);

-- Enable RLS (optional - adjust based on your security needs)
ALTER TABLE mentor_attendance ENABLE ROW LEVEL SECURITY;

-- Allow authenticated users to read
CREATE POLICY "Allow authenticated read" ON mentor_attendance
  FOR SELECT TO authenticated USING (true);

-- Allow service role full access
CREATE POLICY "Allow service role all" ON mentor_attendance
  FOR ALL TO service_role USING (true);

-- =============================================
-- USAGE:
-- 
-- To calculate/update mentor attendance, call:
-- POST /api/mentor-attendance
-- 
-- To fetch current attendance data, call:
-- GET /api/mentor-attendance
-- =============================================

