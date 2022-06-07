# Licensed to Elasticsearch B.V. under one or more contributor
# license agreements. See the NOTICE file distributed with
# this work for additional information regarding copyright
# ownership. Elasticsearch B.V. licenses this file to you under
# the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

require "treetop/runtime"
require "logstash/config/config_ast"

module LogStashConfig
  include Treetop::Runtime

  def root
    @root ||= :config
  end

  module Config0
    def _
      elements[0]
    end

    def plugin_section
      elements[1]
    end
  end

  module Config1
    def _1
      elements[0]
    end

    def plugin_section
      elements[1]
    end

    def _2
      elements[2]
    end

    def _3
      elements[4]
    end
  end

  def _nt_config
    start_index = index
    if node_cache[:config].has_key?(index)
      cached = node_cache[:config][index]
      if cached
        node_cache[:config][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt__
    s0 << r1
    if r1
      r2 = _nt_plugin_section
      s0 << r2
      if r2
        r3 = _nt__
        s0 << r3
        if r3
          s4, i4 = [], index
          loop do
            i5, s5 = index, []
            r6 = _nt__
            s5 << r6
            if r6
              r7 = _nt_plugin_section
              s5 << r7
            end
            if s5.last
              r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
              r5.extend(Config0)
            else
              @index = i5
              r5 = nil
            end
            if r5
              s4 << r5
            else
              break
            end
          end
          r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
          s0 << r4
          if r4
            r8 = _nt__
            s0 << r8
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::Config,input, i0...index, s0)
      r0.extend(Config1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:config][start_index] = r0

    r0
  end

  module Comment0
  end

  def _nt_comment
    start_index = index
    if node_cache[:comment].has_key?(index)
      cached = node_cache[:comment][index]
      if cached
        node_cache[:comment][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      i1, s1 = index, []
      r3 = _nt_whitespace
      if r3
        r2 = r3
      else
        r2 = instantiate_node(SyntaxNode,input, index...index)
      end
      s1 << r2
      if r2
        if (match_len = has_terminal?("#", false, index))
          r4 = true
          @index += match_len
        else
          terminal_parse_failure('"#"')
          r4 = nil
        end
        s1 << r4
        if r4
          s5, i5 = [], index
          loop do
            if has_terminal?(@regexps[gr = '\A[^\\r\\n]'] ||= Regexp.new(gr), :regexp, index)
              r6 = true
              @index += 1
            else
              terminal_parse_failure('[^\\r\\n]')
              r6 = nil
            end
            if r6
              s5 << r6
            else
              break
            end
          end
          r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
          s1 << r5
          if r5
            if (match_len = has_terminal?("\r", false, index))
              r8 = true
              @index += match_len
            else
              terminal_parse_failure('"\\r"')
              r8 = nil
            end
            if r8
              r7 = r8
            else
              r7 = instantiate_node(SyntaxNode,input, index...index)
            end
            s1 << r7
            if r7
              if (match_len = has_terminal?("\n", false, index))
                r9 = true
                @index += match_len
              else
                terminal_parse_failure('"\\n"')
                r9 = nil
              end
              s1 << r9
            end
          end
        end
      end
      if s1.last
        r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
        r1.extend(Comment0)
      else
        @index = i1
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      @index = i0
      r0 = nil
    else
      r0 = instantiate_node(LogStash::Config::AST::Comment,input, i0...index, s0)
    end

    node_cache[:comment][start_index] = r0

    r0
  end

  def _nt__
    start_index = index
    if node_cache[:_].has_key?(index)
      cached = node_cache[:_][index]
      if cached
        node_cache[:_][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      i1 = index
      r2 = _nt_comment
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r1 = r2
      else
        r3 = _nt_whitespace
        if r3
          r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
          r1 = r3
        else
          @index = i1
          r1 = nil
        end
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = instantiate_node(LogStash::Config::AST::Whitespace,input, i0...index, s0)

    node_cache[:_][start_index] = r0

    r0
  end

  def _nt_whitespace
    start_index = index
    if node_cache[:whitespace].has_key?(index)
      cached = node_cache[:whitespace][index]
      if cached
        node_cache[:whitespace][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      if has_terminal?(@regexps[gr = '\A[ \\t\\r\\n]'] ||= Regexp.new(gr), :regexp, index)
        r1 = true
        @index += 1
      else
        terminal_parse_failure('[ \\t\\r\\n]')
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      @index = i0
      r0 = nil
    else
      r0 = instantiate_node(LogStash::Config::AST::Whitespace,input, i0...index, s0)
    end

    node_cache[:whitespace][start_index] = r0

    r0
  end

  module PluginSection0
    def branch_or_plugin
      elements[0]
    end

    def _
      elements[1]
    end
  end

  module PluginSection1
    def plugin_type
      elements[0]
    end

    def _1
      elements[1]
    end

    def _2
      elements[3]
    end

  end

  def _nt_plugin_section
    start_index = index
    if node_cache[:plugin_section].has_key?(index)
      cached = node_cache[:plugin_section][index]
      if cached
        node_cache[:plugin_section][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_plugin_type
    s0 << r1
    if r1
      r2 = _nt__
      s0 << r2
      if r2
        if (match_len = has_terminal?("{", false, index))
          r3 = true
          @index += match_len
        else
          terminal_parse_failure('"{"')
          r3 = nil
        end
        s0 << r3
        if r3
          r4 = _nt__
          s0 << r4
          if r4
            s5, i5 = [], index
            loop do
              i6, s6 = index, []
              r7 = _nt_branch_or_plugin
              s6 << r7
              if r7
                r8 = _nt__
                s6 << r8
              end
              if s6.last
                r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
                r6.extend(PluginSection0)
              else
                @index = i6
                r6 = nil
              end
              if r6
                s5 << r6
              else
                break
              end
            end
            r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
            s0 << r5
            if r5
              if (match_len = has_terminal?("}", false, index))
                r9 = true
                @index += match_len
              else
                terminal_parse_failure('"}"')
                r9 = nil
              end
              s0 << r9
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::PluginSection,input, i0...index, s0)
      r0.extend(PluginSection1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:plugin_section][start_index] = r0

    r0
  end

  def _nt_branch_or_plugin
    start_index = index
    if node_cache[:branch_or_plugin].has_key?(index)
      cached = node_cache[:branch_or_plugin][index]
      if cached
        node_cache[:branch_or_plugin][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_branch
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      r2 = _nt_plugin
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:branch_or_plugin][start_index] = r0

    r0
  end

  def _nt_plugin_type
    start_index = index
    if node_cache[:plugin_type].has_key?(index)
      cached = node_cache[:plugin_type][index]
      if cached
        node_cache[:plugin_type][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    if (match_len = has_terminal?("input", false, index))
      r1 = instantiate_node(SyntaxNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure('"input"')
      r1 = nil
    end
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      if (match_len = has_terminal?("filter", false, index))
        r2 = instantiate_node(SyntaxNode,input, index...(index + match_len))
        @index += match_len
      else
        terminal_parse_failure('"filter"')
        r2 = nil
      end
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        if (match_len = has_terminal?("output", false, index))
          r3 = instantiate_node(SyntaxNode,input, index...(index + match_len))
          @index += match_len
        else
          terminal_parse_failure('"output"')
          r3 = nil
        end
        if r3
          r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
          r0 = r3
        else
          @index = i0
          r0 = nil
        end
      end
    end

    node_cache[:plugin_type][start_index] = r0

    r0
  end

  module Plugins0
    def _
      elements[0]
    end

    def plugin
      elements[1]
    end
  end

  module Plugins1
    def plugin
      elements[0]
    end

  end

  def _nt_plugins
    start_index = index
    if node_cache[:plugins].has_key?(index)
      cached = node_cache[:plugins][index]
      if cached
        node_cache[:plugins][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i1, s1 = index, []
    r2 = _nt_plugin
    s1 << r2
    if r2
      s3, i3 = [], index
      loop do
        i4, s4 = index, []
        r5 = _nt__
        s4 << r5
        if r5
          r6 = _nt_plugin
          s4 << r6
        end
        if s4.last
          r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
          r4.extend(Plugins0)
        else
          @index = i4
          r4 = nil
        end
        if r4
          s3 << r4
        else
          break
        end
      end
      r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
      s1 << r3
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Plugins1)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r0 = instantiate_node(SyntaxNode,input, index...index)
    end

    node_cache[:plugins][start_index] = r0

    r0
  end

  module Plugin0
    def whitespace
      elements[0]
    end

    def _
      elements[1]
    end

    def attribute
      elements[2]
    end
  end

  module Plugin1
    def attribute
      elements[0]
    end

  end

  module Plugin2
    def name
      elements[0]
    end

    def _1
      elements[1]
    end

    def _2
      elements[3]
    end

    def attributes
      elements[4]
    end

    def _3
      elements[5]
    end

  end

  def _nt_plugin
    start_index = index
    if node_cache[:plugin].has_key?(index)
      cached = node_cache[:plugin][index]
      if cached
        node_cache[:plugin][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_name
    s0 << r1
    if r1
      r2 = _nt__
      s0 << r2
      if r2
        if (match_len = has_terminal?("{", false, index))
          r3 = true
          @index += match_len
        else
          terminal_parse_failure('"{"')
          r3 = nil
        end
        s0 << r3
        if r3
          r4 = _nt__
          s0 << r4
          if r4
            i6, s6 = index, []
            r7 = _nt_attribute
            s6 << r7
            if r7
              s8, i8 = [], index
              loop do
                i9, s9 = index, []
                r10 = _nt_whitespace
                s9 << r10
                if r10
                  r11 = _nt__
                  s9 << r11
                  if r11
                    r12 = _nt_attribute
                    s9 << r12
                  end
                end
                if s9.last
                  r9 = instantiate_node(SyntaxNode,input, i9...index, s9)
                  r9.extend(Plugin0)
                else
                  @index = i9
                  r9 = nil
                end
                if r9
                  s8 << r9
                else
                  break
                end
              end
              r8 = instantiate_node(SyntaxNode,input, i8...index, s8)
              s6 << r8
            end
            if s6.last
              r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
              r6.extend(Plugin1)
            else
              @index = i6
              r6 = nil
            end
            if r6
              r5 = r6
            else
              r5 = instantiate_node(SyntaxNode,input, index...index)
            end
            s0 << r5
            if r5
              r13 = _nt__
              s0 << r13
              if r13
                if (match_len = has_terminal?("}", false, index))
                  r14 = true
                  @index += match_len
                else
                  terminal_parse_failure('"}"')
                  r14 = nil
                end
                s0 << r14
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::Plugin,input, i0...index, s0)
      r0.extend(Plugin2)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:plugin][start_index] = r0

    r0
  end

  def _nt_name
    start_index = index
    if node_cache[:name].has_key?(index)
      cached = node_cache[:name][index]
      if cached
        node_cache[:name][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    s1, i1 = [], index
    loop do
      if has_terminal?(@regexps[gr = '\A[A-Za-z0-9_-]'] ||= Regexp.new(gr), :regexp, index)
        r2 = true
        @index += 1
      else
        terminal_parse_failure('[A-Za-z0-9_-]')
        r2 = nil
      end
      if r2
        s1 << r2
      else
        break
      end
    end
    if s1.empty?
      @index = i1
      r1 = nil
    else
      r1 = instantiate_node(LogStash::Config::AST::Name,input, i1...index, s1)
    end
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      r3 = _nt_string
      if r3
        r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
        r0 = r3
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:name][start_index] = r0

    r0
  end

  module Attribute0
    def name
      elements[0]
    end

    def _1
      elements[1]
    end

    def _2
      elements[3]
    end

    def value
      elements[4]
    end
  end

  def _nt_attribute
    start_index = index
    if node_cache[:attribute].has_key?(index)
      cached = node_cache[:attribute][index]
      if cached
        node_cache[:attribute][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_name
    s0 << r1
    if r1
      r2 = _nt__
      s0 << r2
      if r2
        if (match_len = has_terminal?("=>", false, index))
          r3 = instantiate_node(SyntaxNode,input, index...(index + match_len))
          @index += match_len
        else
          terminal_parse_failure('"=>"')
          r3 = nil
        end
        s0 << r3
        if r3
          r4 = _nt__
          s0 << r4
          if r4
            r5 = _nt_value
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::Attribute,input, i0...index, s0)
      r0.extend(Attribute0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:attribute][start_index] = r0

    r0
  end

  def _nt_value
    start_index = index
    if node_cache[:value].has_key?(index)
      cached = node_cache[:value][index]
      if cached
        node_cache[:value][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_plugin
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      r2 = _nt_bareword
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        r3 = _nt_string
        if r3
          r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
          r0 = r3
        else
          r4 = _nt_number
          if r4
            r4 = SyntaxNode.new(input, (index-1)...index) if r4 == true
            r0 = r4
          else
            r5 = _nt_array
            if r5
              r5 = SyntaxNode.new(input, (index-1)...index) if r5 == true
              r0 = r5
            else
              r6 = _nt_hash
              if r6
                r6 = SyntaxNode.new(input, (index-1)...index) if r6 == true
                r0 = r6
              else
                @index = i0
                r0 = nil
              end
            end
          end
        end
      end
    end

    node_cache[:value][start_index] = r0

    r0
  end

  def _nt_array_value
    start_index = index
    if node_cache[:array_value].has_key?(index)
      cached = node_cache[:array_value][index]
      if cached
        node_cache[:array_value][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_bareword
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      r2 = _nt_string
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        r3 = _nt_number
        if r3
          r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
          r0 = r3
        else
          r4 = _nt_array
          if r4
            r4 = SyntaxNode.new(input, (index-1)...index) if r4 == true
            r0 = r4
          else
            r5 = _nt_hash
            if r5
              r5 = SyntaxNode.new(input, (index-1)...index) if r5 == true
              r0 = r5
            else
              @index = i0
              r0 = nil
            end
          end
        end
      end
    end

    node_cache[:array_value][start_index] = r0

    r0
  end

  module Bareword0
  end

  def _nt_bareword
    start_index = index
    if node_cache[:bareword].has_key?(index)
      cached = node_cache[:bareword][index]
      if cached
        node_cache[:bareword][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?(@regexps[gr = '\A[A-Za-z_]'] ||= Regexp.new(gr), :regexp, index)
      r1 = true
      @index += 1
    else
      terminal_parse_failure('[A-Za-z_]')
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        if has_terminal?(@regexps[gr = '\A[A-Za-z0-9_]'] ||= Regexp.new(gr), :regexp, index)
          r3 = true
          @index += 1
        else
          terminal_parse_failure('[A-Za-z0-9_]')
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      if s2.empty?
        @index = i2
        r2 = nil
      else
        r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::Bareword,input, i0...index, s0)
      r0.extend(Bareword0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:bareword][start_index] = r0

    r0
  end

  module DoubleQuotedString0
  end

  module DoubleQuotedString1
  end

  def _nt_double_quoted_string
    start_index = index
    if node_cache[:double_quoted_string].has_key?(index)
      cached = node_cache[:double_quoted_string][index]
      if cached
        node_cache[:double_quoted_string][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?('"', false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure('\'"\'')
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3 = index
        if (match_len = has_terminal?('\"', false, index))
          r4 = instantiate_node(SyntaxNode,input, index...(index + match_len))
          @index += match_len
        else
          terminal_parse_failure('\'\\"\'')
          r4 = nil
        end
        if r4
          r4 = SyntaxNode.new(input, (index-1)...index) if r4 == true
          r3 = r4
        else
          i5, s5 = index, []
          i6 = index
          if (match_len = has_terminal?('"', false, index))
            r7 = true
            @index += match_len
          else
            terminal_parse_failure('\'"\'')
            r7 = nil
          end
          if r7
            @index = i6
            r6 = nil
            terminal_parse_failure('\'"\'', true)
          else
            @terminal_failures.pop
            @index = i6
            r6 = instantiate_node(SyntaxNode,input, index...index)
          end
          s5 << r6
          if r6
            if index < input_length
              r8 = true
              @index += 1
            else
              terminal_parse_failure("any character")
              r8 = nil
            end
            s5 << r8
          end
          if s5.last
            r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
            r5.extend(DoubleQuotedString0)
          else
            @index = i5
            r5 = nil
          end
          if r5
            r5 = SyntaxNode.new(input, (index-1)...index) if r5 == true
            r3 = r5
          else
            @index = i3
            r3 = nil
          end
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
      if r2
        if (match_len = has_terminal?('"', false, index))
          r9 = true
          @index += match_len
        else
          terminal_parse_failure('\'"\'')
          r9 = nil
        end
        s0 << r9
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::String,input, i0...index, s0)
      r0.extend(DoubleQuotedString1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:double_quoted_string][start_index] = r0

    r0
  end

  module SingleQuotedString0
  end

  module SingleQuotedString1
  end

  def _nt_single_quoted_string
    start_index = index
    if node_cache[:single_quoted_string].has_key?(index)
      cached = node_cache[:single_quoted_string][index]
      if cached
        node_cache[:single_quoted_string][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?("'", false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure('"\'"')
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3 = index
        if (match_len = has_terminal?("\\'", false, index))
          r4 = instantiate_node(SyntaxNode,input, index...(index + match_len))
          @index += match_len
        else
          terminal_parse_failure('"\\\\\'"')
          r4 = nil
        end
        if r4
          r4 = SyntaxNode.new(input, (index-1)...index) if r4 == true
          r3 = r4
        else
          i5, s5 = index, []
          i6 = index
          if (match_len = has_terminal?("'", false, index))
            r7 = true
            @index += match_len
          else
            terminal_parse_failure('"\'"')
            r7 = nil
          end
          if r7
            @index = i6
            r6 = nil
            terminal_parse_failure('"\'"', true)
          else
            @terminal_failures.pop
            @index = i6
            r6 = instantiate_node(SyntaxNode,input, index...index)
          end
          s5 << r6
          if r6
            if index < input_length
              r8 = true
              @index += 1
            else
              terminal_parse_failure("any character")
              r8 = nil
            end
            s5 << r8
          end
          if s5.last
            r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
            r5.extend(SingleQuotedString0)
          else
            @index = i5
            r5 = nil
          end
          if r5
            r5 = SyntaxNode.new(input, (index-1)...index) if r5 == true
            r3 = r5
          else
            @index = i3
            r3 = nil
          end
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
      if r2
        if (match_len = has_terminal?("'", false, index))
          r9 = true
          @index += match_len
        else
          terminal_parse_failure('"\'"')
          r9 = nil
        end
        s0 << r9
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::String,input, i0...index, s0)
      r0.extend(SingleQuotedString1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:single_quoted_string][start_index] = r0

    r0
  end

  def _nt_string
    start_index = index
    if node_cache[:string].has_key?(index)
      cached = node_cache[:string][index]
      if cached
        node_cache[:string][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_double_quoted_string
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      r2 = _nt_single_quoted_string
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:string][start_index] = r0

    r0
  end

  module Regexp0
  end

  module Regexp1
  end

  def _nt_regexp
    start_index = index
    if node_cache[:regexp].has_key?(index)
      cached = node_cache[:regexp][index]
      if cached
        node_cache[:regexp][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?('/', false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure('\'/\'')
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3 = index
        if (match_len = has_terminal?('\/', false, index))
          r4 = instantiate_node(SyntaxNode,input, index...(index + match_len))
          @index += match_len
        else
          terminal_parse_failure('\'\\/\'')
          r4 = nil
        end
        if r4
          r4 = SyntaxNode.new(input, (index-1)...index) if r4 == true
          r3 = r4
        else
          i5, s5 = index, []
          i6 = index
          if (match_len = has_terminal?('/', false, index))
            r7 = true
            @index += match_len
          else
            terminal_parse_failure('\'/\'')
            r7 = nil
          end
          if r7
            @index = i6
            r6 = nil
            terminal_parse_failure('\'/\'', true)
          else
            @terminal_failures.pop
            @index = i6
            r6 = instantiate_node(SyntaxNode,input, index...index)
          end
          s5 << r6
          if r6
            if index < input_length
              r8 = true
              @index += 1
            else
              terminal_parse_failure("any character")
              r8 = nil
            end
            s5 << r8
          end
          if s5.last
            r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
            r5.extend(Regexp0)
          else
            @index = i5
            r5 = nil
          end
          if r5
            r5 = SyntaxNode.new(input, (index-1)...index) if r5 == true
            r3 = r5
          else
            @index = i3
            r3 = nil
          end
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
      if r2
        if (match_len = has_terminal?('/', false, index))
          r9 = true
          @index += match_len
        else
          terminal_parse_failure('\'/\'')
          r9 = nil
        end
        s0 << r9
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::RegExp,input, i0...index, s0)
      r0.extend(Regexp1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:regexp][start_index] = r0

    r0
  end

  module Number0
  end

  module Number1
  end

  def _nt_number
    start_index = index
    if node_cache[:number].has_key?(index)
      cached = node_cache[:number][index]
      if cached
        node_cache[:number][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?("-", false, index))
      r2 = true
      @index += match_len
    else
      terminal_parse_failure('"-"')
      r2 = nil
    end
    if r2
      r1 = r2
    else
      r1 = instantiate_node(SyntaxNode,input, index...index)
    end
    s0 << r1
    if r1
      s3, i3 = [], index
      loop do
        if has_terminal?(@regexps[gr = '\A[0-9]'] ||= Regexp.new(gr), :regexp, index)
          r4 = true
          @index += 1
        else
          terminal_parse_failure('[0-9]')
          r4 = nil
        end
        if r4
          s3 << r4
        else
          break
        end
      end
      if s3.empty?
        @index = i3
        r3 = nil
      else
        r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
      end
      s0 << r3
      if r3
        i6, s6 = index, []
        if (match_len = has_terminal?(".", false, index))
          r7 = true
          @index += match_len
        else
          terminal_parse_failure('"."')
          r7 = nil
        end
        s6 << r7
        if r7
          s8, i8 = [], index
          loop do
            if has_terminal?(@regexps[gr = '\A[0-9]'] ||= Regexp.new(gr), :regexp, index)
              r9 = true
              @index += 1
            else
              terminal_parse_failure('[0-9]')
              r9 = nil
            end
            if r9
              s8 << r9
            else
              break
            end
          end
          r8 = instantiate_node(SyntaxNode,input, i8...index, s8)
          s6 << r8
        end
        if s6.last
          r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
          r6.extend(Number0)
        else
          @index = i6
          r6 = nil
        end
        if r6
          r5 = r6
        else
          r5 = instantiate_node(SyntaxNode,input, index...index)
        end
        s0 << r5
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::Number,input, i0...index, s0)
      r0.extend(Number1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:number][start_index] = r0

    r0
  end

  module Array0
    def _1
      elements[0]
    end

    def _2
      elements[2]
    end

    def value
      elements[3]
    end
  end

  module Array1
    def value
      elements[0]
    end

  end

  module Array2
    def _1
      elements[1]
    end

    def _2
      elements[3]
    end

  end

  def _nt_array
    start_index = index
    if node_cache[:array].has_key?(index)
      cached = node_cache[:array][index]
      if cached
        node_cache[:array][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?("[", false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure('"["')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt__
      s0 << r2
      if r2
        i4, s4 = index, []
        r5 = _nt_value
        s4 << r5
        if r5
          s6, i6 = [], index
          loop do
            i7, s7 = index, []
            r8 = _nt__
            s7 << r8
            if r8
              if (match_len = has_terminal?(",", false, index))
                r9 = true
                @index += match_len
              else
                terminal_parse_failure('","')
                r9 = nil
              end
              s7 << r9
              if r9
                r10 = _nt__
                s7 << r10
                if r10
                  r11 = _nt_value
                  s7 << r11
                end
              end
            end
            if s7.last
              r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
              r7.extend(Array0)
            else
              @index = i7
              r7 = nil
            end
            if r7
              s6 << r7
            else
              break
            end
          end
          r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
          s4 << r6
        end
        if s4.last
          r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
          r4.extend(Array1)
        else
          @index = i4
          r4 = nil
        end
        if r4
          r3 = r4
        else
          r3 = instantiate_node(SyntaxNode,input, index...index)
        end
        s0 << r3
        if r3
          r12 = _nt__
          s0 << r12
          if r12
            if (match_len = has_terminal?("]", false, index))
              r13 = true
              @index += match_len
            else
              terminal_parse_failure('"]"')
              r13 = nil
            end
            s0 << r13
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::Array,input, i0...index, s0)
      r0.extend(Array2)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:array][start_index] = r0

    r0
  end

  module Hash0
    def _1
      elements[1]
    end

    def _2
      elements[3]
    end

  end

  def _nt_hash
    start_index = index
    if node_cache[:hash].has_key?(index)
      cached = node_cache[:hash][index]
      if cached
        node_cache[:hash][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?("{", false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure('"{"')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt__
      s0 << r2
      if r2
        r4 = _nt_hashentries
        if r4
          r3 = r4
        else
          r3 = instantiate_node(SyntaxNode,input, index...index)
        end
        s0 << r3
        if r3
          r5 = _nt__
          s0 << r5
          if r5
            if (match_len = has_terminal?("}", false, index))
              r6 = true
              @index += match_len
            else
              terminal_parse_failure('"}"')
              r6 = nil
            end
            s0 << r6
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::Hash,input, i0...index, s0)
      r0.extend(Hash0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:hash][start_index] = r0

    r0
  end

  module Hashentries0
    def whitespace
      elements[0]
    end

    def hashentry
      elements[1]
    end
  end

  module Hashentries1
    def hashentry
      elements[0]
    end

  end

  def _nt_hashentries
    start_index = index
    if node_cache[:hashentries].has_key?(index)
      cached = node_cache[:hashentries][index]
      if cached
        node_cache[:hashentries][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_hashentry
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3, s3 = index, []
        r4 = _nt_whitespace
        s3 << r4
        if r4
          r5 = _nt_hashentry
          s3 << r5
        end
        if s3.last
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
          r3.extend(Hashentries0)
        else
          @index = i3
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::HashEntries,input, i0...index, s0)
      r0.extend(Hashentries1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:hashentries][start_index] = r0

    r0
  end

  module Hashentry0
    def name
      elements[0]
    end

    def _1
      elements[1]
    end

    def _2
      elements[3]
    end

    def value
      elements[4]
    end
  end

  def _nt_hashentry
    start_index = index
    if node_cache[:hashentry].has_key?(index)
      cached = node_cache[:hashentry][index]
      if cached
        node_cache[:hashentry][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    i1 = index
    r2 = _nt_number
    if r2
      r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
      r1 = r2
    else
      r3 = _nt_bareword
      if r3
        r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
        r1 = r3
      else
        r4 = _nt_string
        if r4
          r4 = SyntaxNode.new(input, (index-1)...index) if r4 == true
          r1 = r4
        else
          @index = i1
          r1 = nil
        end
      end
    end
    s0 << r1
    if r1
      r5 = _nt__
      s0 << r5
      if r5
        if (match_len = has_terminal?("=>", false, index))
          r6 = instantiate_node(SyntaxNode,input, index...(index + match_len))
          @index += match_len
        else
          terminal_parse_failure('"=>"')
          r6 = nil
        end
        s0 << r6
        if r6
          r7 = _nt__
          s0 << r7
          if r7
            r8 = _nt_value
            s0 << r8
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::HashEntry,input, i0...index, s0)
      r0.extend(Hashentry0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:hashentry][start_index] = r0

    r0
  end

  module Branch0
    def _
      elements[0]
    end

    def else_if
      elements[1]
    end
  end

  module Branch1
    def _
      elements[0]
    end

    def else
      elements[1]
    end
  end

  module Branch2
    def if
      elements[0]
    end

  end

  def _nt_branch
    start_index = index
    if node_cache[:branch].has_key?(index)
      cached = node_cache[:branch][index]
      if cached
        node_cache[:branch][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_if
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3, s3 = index, []
        r4 = _nt__
        s3 << r4
        if r4
          r5 = _nt_else_if
          s3 << r5
        end
        if s3.last
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
          r3.extend(Branch0)
        else
          @index = i3
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
      if r2
        i7, s7 = index, []
        r8 = _nt__
        s7 << r8
        if r8
          r9 = _nt_else
          s7 << r9
        end
        if s7.last
          r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
          r7.extend(Branch1)
        else
          @index = i7
          r7 = nil
        end
        if r7
          r6 = r7
        else
          r6 = instantiate_node(SyntaxNode,input, index...index)
        end
        s0 << r6
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::Branch,input, i0...index, s0)
      r0.extend(Branch2)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:branch][start_index] = r0

    r0
  end

  module If0
    def branch_or_plugin
      elements[0]
    end

    def _
      elements[1]
    end
  end

  module If1
    def _1
      elements[1]
    end

    def condition
      elements[2]
    end

    def _2
      elements[3]
    end

    def _3
      elements[5]
    end

  end

  def _nt_if
    start_index = index
    if node_cache[:if].has_key?(index)
      cached = node_cache[:if][index]
      if cached
        node_cache[:if][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?("if", false, index))
      r1 = instantiate_node(SyntaxNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure('"if"')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt__
      s0 << r2
      if r2
        r3 = _nt_condition
        s0 << r3
        if r3
          r4 = _nt__
          s0 << r4
          if r4
            if (match_len = has_terminal?("{", false, index))
              r5 = true
              @index += match_len
            else
              terminal_parse_failure('"{"')
              r5 = nil
            end
            s0 << r5
            if r5
              r6 = _nt__
              s0 << r6
              if r6
                s7, i7 = [], index
                loop do
                  i8, s8 = index, []
                  r9 = _nt_branch_or_plugin
                  s8 << r9
                  if r9
                    r10 = _nt__
                    s8 << r10
                  end
                  if s8.last
                    r8 = instantiate_node(SyntaxNode,input, i8...index, s8)
                    r8.extend(If0)
                  else
                    @index = i8
                    r8 = nil
                  end
                  if r8
                    s7 << r8
                  else
                    break
                  end
                end
                r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
                s0 << r7
                if r7
                  if (match_len = has_terminal?("}", false, index))
                    r11 = true
                    @index += match_len
                  else
                    terminal_parse_failure('"}"')
                    r11 = nil
                  end
                  s0 << r11
                end
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::If,input, i0...index, s0)
      r0.extend(If1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:if][start_index] = r0

    r0
  end

  module ElseIf0
    def branch_or_plugin
      elements[0]
    end

    def _
      elements[1]
    end
  end

  module ElseIf1
    def _1
      elements[1]
    end

    def _2
      elements[3]
    end

    def condition
      elements[4]
    end

    def _3
      elements[5]
    end

    def _4
      elements[7]
    end

  end

  def _nt_else_if
    start_index = index
    if node_cache[:else_if].has_key?(index)
      cached = node_cache[:else_if][index]
      if cached
        node_cache[:else_if][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?("else", false, index))
      r1 = instantiate_node(SyntaxNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure('"else"')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt__
      s0 << r2
      if r2
        if (match_len = has_terminal?("if", false, index))
          r3 = instantiate_node(SyntaxNode,input, index...(index + match_len))
          @index += match_len
        else
          terminal_parse_failure('"if"')
          r3 = nil
        end
        s0 << r3
        if r3
          r4 = _nt__
          s0 << r4
          if r4
            r5 = _nt_condition
            s0 << r5
            if r5
              r6 = _nt__
              s0 << r6
              if r6
                if (match_len = has_terminal?("{", false, index))
                  r7 = true
                  @index += match_len
                else
                  terminal_parse_failure('"{"')
                  r7 = nil
                end
                s0 << r7
                if r7
                  r8 = _nt__
                  s0 << r8
                  if r8
                    s9, i9 = [], index
                    loop do
                      i10, s10 = index, []
                      r11 = _nt_branch_or_plugin
                      s10 << r11
                      if r11
                        r12 = _nt__
                        s10 << r12
                      end
                      if s10.last
                        r10 = instantiate_node(SyntaxNode,input, i10...index, s10)
                        r10.extend(ElseIf0)
                      else
                        @index = i10
                        r10 = nil
                      end
                      if r10
                        s9 << r10
                      else
                        break
                      end
                    end
                    r9 = instantiate_node(SyntaxNode,input, i9...index, s9)
                    s0 << r9
                    if r9
                      if (match_len = has_terminal?("}", false, index))
                        r13 = true
                        @index += match_len
                      else
                        terminal_parse_failure('"}"')
                        r13 = nil
                      end
                      s0 << r13
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::Elsif,input, i0...index, s0)
      r0.extend(ElseIf1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:else_if][start_index] = r0

    r0
  end

  module Else0
    def branch_or_plugin
      elements[0]
    end

    def _
      elements[1]
    end
  end

  module Else1
    def _1
      elements[1]
    end

    def _2
      elements[3]
    end

  end

  def _nt_else
    start_index = index
    if node_cache[:else].has_key?(index)
      cached = node_cache[:else][index]
      if cached
        node_cache[:else][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?("else", false, index))
      r1 = instantiate_node(SyntaxNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure('"else"')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt__
      s0 << r2
      if r2
        if (match_len = has_terminal?("{", false, index))
          r3 = true
          @index += match_len
        else
          terminal_parse_failure('"{"')
          r3 = nil
        end
        s0 << r3
        if r3
          r4 = _nt__
          s0 << r4
          if r4
            s5, i5 = [], index
            loop do
              i6, s6 = index, []
              r7 = _nt_branch_or_plugin
              s6 << r7
              if r7
                r8 = _nt__
                s6 << r8
              end
              if s6.last
                r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
                r6.extend(Else0)
              else
                @index = i6
                r6 = nil
              end
              if r6
                s5 << r6
              else
                break
              end
            end
            r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
            s0 << r5
            if r5
              if (match_len = has_terminal?("}", false, index))
                r9 = true
                @index += match_len
              else
                terminal_parse_failure('"}"')
                r9 = nil
              end
              s0 << r9
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::Else,input, i0...index, s0)
      r0.extend(Else1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:else][start_index] = r0

    r0
  end

  module Condition0
    def _1
      elements[0]
    end

    def boolean_operator
      elements[1]
    end

    def _2
      elements[2]
    end

    def expression
      elements[3]
    end
  end

  module Condition1
    def expression
      elements[0]
    end

  end

  def _nt_condition
    start_index = index
    if node_cache[:condition].has_key?(index)
      cached = node_cache[:condition][index]
      if cached
        node_cache[:condition][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_expression
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3, s3 = index, []
        r4 = _nt__
        s3 << r4
        if r4
          r5 = _nt_boolean_operator
          s3 << r5
          if r5
            r6 = _nt__
            s3 << r6
            if r6
              r7 = _nt_expression
              s3 << r7
            end
          end
        end
        if s3.last
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
          r3.extend(Condition0)
        else
          @index = i3
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::Condition,input, i0...index, s0)
      r0.extend(Condition1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:condition][start_index] = r0

    r0
  end

  module Expression0
    def _1
      elements[1]
    end

    def condition
      elements[2]
    end

    def _2
      elements[3]
    end

  end

  def _nt_expression
    start_index = index
    if node_cache[:expression].has_key?(index)
      cached = node_cache[:expression][index]
      if cached
        node_cache[:expression][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if (match_len = has_terminal?("(", false, index))
      r2 = true
      @index += match_len
    else
      terminal_parse_failure('"("')
      r2 = nil
    end
    s1 << r2
    if r2
      r3 = _nt__
      s1 << r3
      if r3
        r4 = _nt_condition
        s1 << r4
        if r4
          r5 = _nt__
          s1 << r5
          if r5
            if (match_len = has_terminal?(")", false, index))
              r6 = true
              @index += match_len
            else
              terminal_parse_failure('")"')
              r6 = nil
            end
            s1 << r6
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Expression0)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
      r0.extend(LogStash::Config::AST::Expression)
    else
      r7 = _nt_negative_expression
      if r7
        r7 = SyntaxNode.new(input, (index-1)...index) if r7 == true
        r0 = r7
        r0.extend(LogStash::Config::AST::Expression)
      else
        r8 = _nt_in_expression
        if r8
          r8 = SyntaxNode.new(input, (index-1)...index) if r8 == true
          r0 = r8
          r0.extend(LogStash::Config::AST::Expression)
        else
          r9 = _nt_not_in_expression
          if r9
            r9 = SyntaxNode.new(input, (index-1)...index) if r9 == true
            r0 = r9
            r0.extend(LogStash::Config::AST::Expression)
          else
            r10 = _nt_compare_expression
            if r10
              r10 = SyntaxNode.new(input, (index-1)...index) if r10 == true
              r0 = r10
              r0.extend(LogStash::Config::AST::Expression)
            else
              r11 = _nt_regexp_expression
              if r11
                r11 = SyntaxNode.new(input, (index-1)...index) if r11 == true
                r0 = r11
                r0.extend(LogStash::Config::AST::Expression)
              else
                r12 = _nt_rvalue
                if r12
                  r12 = SyntaxNode.new(input, (index-1)...index) if r12 == true
                  r0 = r12
                  r0.extend(LogStash::Config::AST::Expression)
                else
                  @index = i0
                  r0 = nil
                end
              end
            end
          end
        end
      end
    end

    node_cache[:expression][start_index] = r0

    r0
  end

  module NegativeExpression0
    def _1
      elements[1]
    end

    def _2
      elements[3]
    end

    def condition
      elements[4]
    end

    def _3
      elements[5]
    end

  end

  module NegativeExpression1
    def _
      elements[1]
    end

    def selector
      elements[2]
    end
  end

  def _nt_negative_expression
    start_index = index
    if node_cache[:negative_expression].has_key?(index)
      cached = node_cache[:negative_expression][index]
      if cached
        node_cache[:negative_expression][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if (match_len = has_terminal?("!", false, index))
      r2 = true
      @index += match_len
    else
      terminal_parse_failure('"!"')
      r2 = nil
    end
    s1 << r2
    if r2
      r3 = _nt__
      s1 << r3
      if r3
        if (match_len = has_terminal?("(", false, index))
          r4 = true
          @index += match_len
        else
          terminal_parse_failure('"("')
          r4 = nil
        end
        s1 << r4
        if r4
          r5 = _nt__
          s1 << r5
          if r5
            r6 = _nt_condition
            s1 << r6
            if r6
              r7 = _nt__
              s1 << r7
              if r7
                if (match_len = has_terminal?(")", false, index))
                  r8 = true
                  @index += match_len
                else
                  terminal_parse_failure('")"')
                  r8 = nil
                end
                s1 << r8
              end
            end
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(NegativeExpression0)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
      r0.extend(LogStash::Config::AST::NegativeExpression)
    else
      i9, s9 = index, []
      if (match_len = has_terminal?("!", false, index))
        r10 = true
        @index += match_len
      else
        terminal_parse_failure('"!"')
        r10 = nil
      end
      s9 << r10
      if r10
        r11 = _nt__
        s9 << r11
        if r11
          r12 = _nt_selector
          s9 << r12
        end
      end
      if s9.last
        r9 = instantiate_node(SyntaxNode,input, i9...index, s9)
        r9.extend(NegativeExpression1)
      else
        @index = i9
        r9 = nil
      end
      if r9
        r9 = SyntaxNode.new(input, (index-1)...index) if r9 == true
        r0 = r9
        r0.extend(LogStash::Config::AST::NegativeExpression)
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:negative_expression][start_index] = r0

    r0
  end

  module InExpression0
    def rvalue1
      elements[0]
    end

    def _1
      elements[1]
    end

    def in_operator
      elements[2]
    end

    def _2
      elements[3]
    end

    def rvalue2
      elements[4]
    end
  end

  def _nt_in_expression
    start_index = index
    if node_cache[:in_expression].has_key?(index)
      cached = node_cache[:in_expression][index]
      if cached
        node_cache[:in_expression][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_rvalue
    s0 << r1
    if r1
      r2 = _nt__
      s0 << r2
      if r2
        r3 = _nt_in_operator
        s0 << r3
        if r3
          r4 = _nt__
          s0 << r4
          if r4
            r5 = _nt_rvalue
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::InExpression,input, i0...index, s0)
      r0.extend(InExpression0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:in_expression][start_index] = r0

    r0
  end

  module NotInExpression0
    def rvalue1
      elements[0]
    end

    def _1
      elements[1]
    end

    def not_in_operator
      elements[2]
    end

    def _2
      elements[3]
    end

    def rvalue2
      elements[4]
    end
  end

  def _nt_not_in_expression
    start_index = index
    if node_cache[:not_in_expression].has_key?(index)
      cached = node_cache[:not_in_expression][index]
      if cached
        node_cache[:not_in_expression][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_rvalue
    s0 << r1
    if r1
      r2 = _nt__
      s0 << r2
      if r2
        r3 = _nt_not_in_operator
        s0 << r3
        if r3
          r4 = _nt__
          s0 << r4
          if r4
            r5 = _nt_rvalue
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::NotInExpression,input, i0...index, s0)
      r0.extend(NotInExpression0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:not_in_expression][start_index] = r0

    r0
  end

  def _nt_in_operator
    start_index = index
    if node_cache[:in_operator].has_key?(index)
      cached = node_cache[:in_operator][index]
      if cached
        node_cache[:in_operator][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    if (match_len = has_terminal?("in", false, index))
      r0 = instantiate_node(SyntaxNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure('"in"')
      r0 = nil
    end

    node_cache[:in_operator][start_index] = r0

    r0
  end

  module NotInOperator0
    def _
      elements[1]
    end

  end

  def _nt_not_in_operator
    start_index = index
    if node_cache[:not_in_operator].has_key?(index)
      cached = node_cache[:not_in_operator][index]
      if cached
        node_cache[:not_in_operator][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?("not ", false, index))
      r1 = instantiate_node(SyntaxNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure('"not "')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt__
      s0 << r2
      if r2
        if (match_len = has_terminal?("in", false, index))
          r3 = instantiate_node(SyntaxNode,input, index...(index + match_len))
          @index += match_len
        else
          terminal_parse_failure('"in"')
          r3 = nil
        end
        s0 << r3
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(NotInOperator0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:not_in_operator][start_index] = r0

    r0
  end

  def _nt_rvalue
    start_index = index
    if node_cache[:rvalue].has_key?(index)
      cached = node_cache[:rvalue][index]
      if cached
        node_cache[:rvalue][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_string
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      r2 = _nt_number
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        r3 = _nt_selector
        if r3
          r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
          r0 = r3
        else
          r4 = _nt_array
          if r4
            r4 = SyntaxNode.new(input, (index-1)...index) if r4 == true
            r0 = r4
          else
            r5 = _nt_method_call
            if r5
              r5 = SyntaxNode.new(input, (index-1)...index) if r5 == true
              r0 = r5
            else
              r6 = _nt_regexp
              if r6
                r6 = SyntaxNode.new(input, (index-1)...index) if r6 == true
                r0 = r6
              else
                @index = i0
                r0 = nil
              end
            end
          end
        end
      end
    end

    node_cache[:rvalue][start_index] = r0

    r0
  end

  module MethodCall0
    def _1
      elements[0]
    end

    def _2
      elements[2]
    end

    def rvalue
      elements[3]
    end
  end

  module MethodCall1
    def rvalue
      elements[0]
    end

  end

  module MethodCall2
    def method
      elements[0]
    end

    def _1
      elements[1]
    end

    def _2
      elements[3]
    end

    def _3
      elements[5]
    end

  end

  def _nt_method_call
    start_index = index
    if node_cache[:method_call].has_key?(index)
      cached = node_cache[:method_call][index]
      if cached
        node_cache[:method_call][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_method
    s0 << r1
    if r1
      r2 = _nt__
      s0 << r2
      if r2
        if (match_len = has_terminal?("(", false, index))
          r3 = true
          @index += match_len
        else
          terminal_parse_failure('"("')
          r3 = nil
        end
        s0 << r3
        if r3
          r4 = _nt__
          s0 << r4
          if r4
            i6, s6 = index, []
            r7 = _nt_rvalue
            s6 << r7
            if r7
              s8, i8 = [], index
              loop do
                i9, s9 = index, []
                r10 = _nt__
                s9 << r10
                if r10
                  if (match_len = has_terminal?(",", false, index))
                    r11 = true
                    @index += match_len
                  else
                    terminal_parse_failure('","')
                    r11 = nil
                  end
                  s9 << r11
                  if r11
                    r12 = _nt__
                    s9 << r12
                    if r12
                      r13 = _nt_rvalue
                      s9 << r13
                    end
                  end
                end
                if s9.last
                  r9 = instantiate_node(SyntaxNode,input, i9...index, s9)
                  r9.extend(MethodCall0)
                else
                  @index = i9
                  r9 = nil
                end
                if r9
                  s8 << r9
                else
                  break
                end
              end
              r8 = instantiate_node(SyntaxNode,input, i8...index, s8)
              s6 << r8
            end
            if s6.last
              r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
              r6.extend(MethodCall1)
            else
              @index = i6
              r6 = nil
            end
            if r6
              r5 = r6
            else
              r5 = instantiate_node(SyntaxNode,input, index...index)
            end
            s0 << r5
            if r5
              r14 = _nt__
              s0 << r14
              if r14
                if (match_len = has_terminal?(")", false, index))
                  r15 = true
                  @index += match_len
                else
                  terminal_parse_failure('")"')
                  r15 = nil
                end
                s0 << r15
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::MethodCall,input, i0...index, s0)
      r0.extend(MethodCall2)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:method_call][start_index] = r0

    r0
  end

  def _nt_method
    start_index = index
    if node_cache[:method].has_key?(index)
      cached = node_cache[:method][index]
      if cached
        node_cache[:method][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    r0 = _nt_bareword

    node_cache[:method][start_index] = r0

    r0
  end

  module CompareExpression0
    def rvalue1
      elements[0]
    end

    def _1
      elements[1]
    end

    def compare_operator
      elements[2]
    end

    def _2
      elements[3]
    end

    def rvalue2
      elements[4]
    end
  end

  def _nt_compare_expression
    start_index = index
    if node_cache[:compare_expression].has_key?(index)
      cached = node_cache[:compare_expression][index]
      if cached
        node_cache[:compare_expression][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_rvalue
    s0 << r1
    if r1
      r2 = _nt__
      s0 << r2
      if r2
        r3 = _nt_compare_operator
        s0 << r3
        if r3
          r4 = _nt__
          s0 << r4
          if r4
            r5 = _nt_rvalue
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::ComparisonExpression,input, i0...index, s0)
      r0.extend(CompareExpression0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:compare_expression][start_index] = r0

    r0
  end

  def _nt_compare_operator
    start_index = index
    if node_cache[:compare_operator].has_key?(index)
      cached = node_cache[:compare_operator][index]
      if cached
        node_cache[:compare_operator][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    if (match_len = has_terminal?("==", false, index))
      r1 = instantiate_node(SyntaxNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure('"=="')
      r1 = nil
    end
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
      r0.extend(LogStash::Config::AST::ComparisonOperator)
    else
      if (match_len = has_terminal?("!=", false, index))
        r2 = instantiate_node(SyntaxNode,input, index...(index + match_len))
        @index += match_len
      else
        terminal_parse_failure('"!="')
        r2 = nil
      end
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
        r0.extend(LogStash::Config::AST::ComparisonOperator)
      else
        if (match_len = has_terminal?("<=", false, index))
          r3 = instantiate_node(SyntaxNode,input, index...(index + match_len))
          @index += match_len
        else
          terminal_parse_failure('"<="')
          r3 = nil
        end
        if r3
          r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
          r0 = r3
          r0.extend(LogStash::Config::AST::ComparisonOperator)
        else
          if (match_len = has_terminal?(">=", false, index))
            r4 = instantiate_node(SyntaxNode,input, index...(index + match_len))
            @index += match_len
          else
            terminal_parse_failure('">="')
            r4 = nil
          end
          if r4
            r4 = SyntaxNode.new(input, (index-1)...index) if r4 == true
            r0 = r4
            r0.extend(LogStash::Config::AST::ComparisonOperator)
          else
            if (match_len = has_terminal?("<", false, index))
              r5 = true
              @index += match_len
            else
              terminal_parse_failure('"<"')
              r5 = nil
            end
            if r5
              r5 = SyntaxNode.new(input, (index-1)...index) if r5 == true
              r0 = r5
              r0.extend(LogStash::Config::AST::ComparisonOperator)
            else
              if (match_len = has_terminal?(">", false, index))
                r6 = true
                @index += match_len
              else
                terminal_parse_failure('">"')
                r6 = nil
              end
              if r6
                r6 = SyntaxNode.new(input, (index-1)...index) if r6 == true
                r0 = r6
                r0.extend(LogStash::Config::AST::ComparisonOperator)
              else
                @index = i0
                r0 = nil
              end
            end
          end
        end
      end
    end

    node_cache[:compare_operator][start_index] = r0

    r0
  end

  module RegexpExpression0
    def rvalue
      elements[0]
    end

    def _1
      elements[1]
    end

    def regexp_operator
      elements[2]
    end

    def _2
      elements[3]
    end

  end

  def _nt_regexp_expression
    start_index = index
    if node_cache[:regexp_expression].has_key?(index)
      cached = node_cache[:regexp_expression][index]
      if cached
        node_cache[:regexp_expression][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_rvalue
    s0 << r1
    if r1
      r2 = _nt__
      s0 << r2
      if r2
        r3 = _nt_regexp_operator
        s0 << r3
        if r3
          r4 = _nt__
          s0 << r4
          if r4
            i5 = index
            r6 = _nt_string
            if r6
              r6 = SyntaxNode.new(input, (index-1)...index) if r6 == true
              r5 = r6
            else
              r7 = _nt_regexp
              if r7
                r7 = SyntaxNode.new(input, (index-1)...index) if r7 == true
                r5 = r7
              else
                @index = i5
                r5 = nil
              end
            end
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::RegexpExpression,input, i0...index, s0)
      r0.extend(RegexpExpression0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:regexp_expression][start_index] = r0

    r0
  end

  def _nt_regexp_operator
    start_index = index
    if node_cache[:regexp_operator].has_key?(index)
      cached = node_cache[:regexp_operator][index]
      if cached
        node_cache[:regexp_operator][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    if (match_len = has_terminal?("=~", false, index))
      r1 = instantiate_node(SyntaxNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure('"=~"')
      r1 = nil
    end
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
      r0.extend(LogStash::Config::AST::RegExpOperator)
    else
      if (match_len = has_terminal?("!~", false, index))
        r2 = instantiate_node(SyntaxNode,input, index...(index + match_len))
        @index += match_len
      else
        terminal_parse_failure('"!~"')
        r2 = nil
      end
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
        r0.extend(LogStash::Config::AST::RegExpOperator)
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:regexp_operator][start_index] = r0

    r0
  end

  def _nt_boolean_operator
    start_index = index
    if node_cache[:boolean_operator].has_key?(index)
      cached = node_cache[:boolean_operator][index]
      if cached
        node_cache[:boolean_operator][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    if (match_len = has_terminal?("and", false, index))
      r1 = instantiate_node(SyntaxNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure('"and"')
      r1 = nil
    end
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
      r0.extend(LogStash::Config::AST::BooleanOperator)
    else
      if (match_len = has_terminal?("or", false, index))
        r2 = instantiate_node(SyntaxNode,input, index...(index + match_len))
        @index += match_len
      else
        terminal_parse_failure('"or"')
        r2 = nil
      end
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
        r0.extend(LogStash::Config::AST::BooleanOperator)
      else
        if (match_len = has_terminal?("xor", false, index))
          r3 = instantiate_node(SyntaxNode,input, index...(index + match_len))
          @index += match_len
        else
          terminal_parse_failure('"xor"')
          r3 = nil
        end
        if r3
          r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
          r0 = r3
          r0.extend(LogStash::Config::AST::BooleanOperator)
        else
          if (match_len = has_terminal?("nand", false, index))
            r4 = instantiate_node(SyntaxNode,input, index...(index + match_len))
            @index += match_len
          else
            terminal_parse_failure('"nand"')
            r4 = nil
          end
          if r4
            r4 = SyntaxNode.new(input, (index-1)...index) if r4 == true
            r0 = r4
            r0.extend(LogStash::Config::AST::BooleanOperator)
          else
            @index = i0
            r0 = nil
          end
        end
      end
    end

    node_cache[:boolean_operator][start_index] = r0

    r0
  end

  def _nt_selector
    start_index = index
    if node_cache[:selector].has_key?(index)
      cached = node_cache[:selector][index]
      if cached
        node_cache[:selector][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      r1 = _nt_selector_element
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      @index = i0
      r0 = nil
    else
      r0 = instantiate_node(LogStash::Config::AST::Selector,input, i0...index, s0)
    end

    node_cache[:selector][start_index] = r0

    r0
  end

  module SelectorElement0
  end

  def _nt_selector_element
    start_index = index
    if node_cache[:selector_element].has_key?(index)
      cached = node_cache[:selector_element][index]
      if cached
        node_cache[:selector_element][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?("[", false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure('"["')
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        if has_terminal?(@regexps[gr = '\A[^\\]\\[,]'] ||= Regexp.new(gr), :regexp, index)
          r3 = true
          @index += 1
        else
          terminal_parse_failure('[^\\]\\[,]')
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      if s2.empty?
        @index = i2
        r2 = nil
      else
        r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      end
      s0 << r2
      if r2
        if (match_len = has_terminal?("]", false, index))
          r4 = true
          @index += match_len
        else
          terminal_parse_failure('"]"')
          r4 = nil
        end
        s0 << r4
      end
    end
    if s0.last
      r0 = instantiate_node(LogStash::Config::AST::SelectorElement,input, i0...index, s0)
      r0.extend(SelectorElement0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:selector_element][start_index] = r0

    r0
  end

end

class LogStashConfigParser < Treetop::Runtime::CompiledParser
  include LogStashConfig
end
