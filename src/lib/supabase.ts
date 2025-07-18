import { createClient } from '@supabase/supabase-js'

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!

export const supabase = createClient(supabaseUrl, supabaseAnonKey)

export type Database = {
  public: {
    Tables: {
      profiles: {
        Row: {
          id: string
          email: string
          full_name: string | null
          avatar_url: string | null
          role: 'admin' | 'user'
          department: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id: string
          email: string
          full_name?: string | null
          avatar_url?: string | null
          role?: 'admin' | 'user'
          department?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          email?: string
          full_name?: string | null
          avatar_url?: string | null
          role?: 'admin' | 'user'
          department?: string | null
          created_at?: string
          updated_at?: string
        }
      }
      courses: {
        Row: {
          id: string
          title: string
          description: string | null
          thumbnail_url: string | null
          category: string | null
          duration: number | null
          level: 'beginner' | 'intermediate' | 'advanced'
          is_published: boolean
          created_by: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          title: string
          description?: string | null
          thumbnail_url?: string | null
          category?: string | null
          duration?: number | null
          level?: 'beginner' | 'intermediate' | 'advanced'
          is_published?: boolean
          created_by: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          title?: string
          description?: string | null
          thumbnail_url?: string | null
          category?: string | null
          duration?: number | null
          level?: 'beginner' | 'intermediate' | 'advanced'
          is_published?: boolean
          created_by?: string
          created_at?: string
          updated_at?: string
        }
      }
      videos: {
        Row: {
          id: string
          course_id: string
          title: string
          description: string | null
          video_url: string
          duration: number | null
          order_index: number
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          course_id: string
          title: string
          description?: string | null
          video_url: string
          duration?: number | null
          order_index: number
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          course_id?: string
          title?: string
          description?: string | null
          video_url?: string
          duration?: number | null
          order_index?: number
          created_at?: string
          updated_at?: string
        }
      }
      user_progress: {
        Row: {
          id: string
          user_id: string
          course_id: string
          video_id: string | null
          completed: boolean
          progress_percentage: number
          last_watched_at: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          user_id: string
          course_id: string
          video_id?: string | null
          completed?: boolean
          progress_percentage?: number
          last_watched_at?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          course_id?: string
          video_id?: string | null
          completed?: boolean
          progress_percentage?: number
          last_watched_at?: string | null
          created_at?: string
          updated_at?: string
        }
      }
    }
  }
}