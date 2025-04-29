Return-Path: <stable+bounces-138577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADD5AA1904
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309DE3ACF78
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05C224633C;
	Tue, 29 Apr 2025 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="087OsH5U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3E42AE96;
	Tue, 29 Apr 2025 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949691; cv=none; b=I7o5Dn7iwMw9pOEiDu5AzMm92vLwcNEzhLPrTuev6C6s6+eC5afq88dm4zCokBsgvcRfr9HocRQXSdlrG/K4n1qmqUsz63Noh7JPDfRJzXrHzSwzSmg37ifZx/ALW8a8zBY5WPrwuvyAJkfQlx82Y2YUb3bzVC3sA2z6c7i53hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949691; c=relaxed/simple;
	bh=C6J/u5s4GkPcLO8tnGV4eBizfzbvsgH0FmEMozPJuXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfGAkr8S8wComiDZAv4LoxvkQ6/YWAcDJ+kxliRQ8gRaAd83ba5sZfcu5VRNobFLFP+l1bJmKd6IThm6/IX69UY3mOfRU70idTtVRQm98Gi2Jp79A0MWyOcGUGJ/u6G2vLJD1azzfio3Z5nUjdTxHGuPB6vzqCIpMZUuz8vYjKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=087OsH5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD9EC4CEE3;
	Tue, 29 Apr 2025 18:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949691;
	bh=C6J/u5s4GkPcLO8tnGV4eBizfzbvsgH0FmEMozPJuXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=087OsH5UqbZzXtolMGPDWg7rEWCjIZoBJxRAqOy8wvOzpc/HOByLUBlZQ1v/UWvim
	 QLEmsNF/vhKRBhM1CRk0ubKVTvYyOD4owHTjbviclJu5Bk7xFYsLTbOG03izt+mX7h
	 FhAtUxv1hBIzV9bE7Bwx62b53MSSdjWXcCBHAHsQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Valentin Schneider <vschneid@redhat.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 003/167] tracing: Add __cpumask to denote a trace event field that is a cpumask_t
Date: Tue, 29 Apr 2025 18:41:51 +0200
Message-ID: <20250429161051.887929162@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161051.743239894@linuxfoundation.org>
References: <20250429161051.743239894@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

[ Upstream commit 8230f27b1ccc4b8976c137e3d6d690f9d4ffca8d ]

The trace events have a __bitmask field that can be used for anything
that requires bitmasks. Although currently it is only used for CPU
masks, it could be used in the future for any type of bitmasks.

There is some user space tooling that wants to know if a field is a CPU
mask and not just some random unsigned long bitmask. Introduce
"__cpumask()" helper functions that work the same as the current
__bitmask() helpers but displays in the format file:

  field:__data_loc cpumask_t *[] mask;    offset:36;      size:4; signed:0;

Instead of:

  field:__data_loc unsigned long[] mask;  offset:32;      size:4; signed:0;

The main difference is the type. Instead of "unsigned long" it is
"cpumask_t *". Note, this type field needs to be a real type in the
__dynamic_array() logic that both __cpumask and__bitmask use, but the
comparison field requires it to be a scalar type whereas cpumask_t is a
structure (non-scalar). But everything works when making it a pointer.

Valentin added changes to remove the need of passing in "nr_bits" and the
__cpumask will always use nr_cpumask_bits as its size.

Link: https://lkml.kernel.org/r/20221014080456.1d32b989@rorschach.local.home

Requested-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: ea8d7647f9dd ("tracing: Verify event formats that have "%*p.."")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/bpf_probe.h                    |  6 ++++
 include/trace/perf.h                         |  6 ++++
 include/trace/stages/stage1_struct_define.h  |  6 ++++
 include/trace/stages/stage2_data_offsets.h   |  6 ++++
 include/trace/stages/stage3_trace_output.h   |  6 ++++
 include/trace/stages/stage4_event_fields.h   |  6 ++++
 include/trace/stages/stage5_get_offsets.h    |  6 ++++
 include/trace/stages/stage6_event_callback.h | 20 ++++++++++++
 include/trace/stages/stage7_class_define.h   |  2 ++
 samples/trace_events/trace-events-sample.c   |  2 +-
 samples/trace_events/trace-events-sample.h   | 34 +++++++++++++++-----
 11 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 6a13220d2d27b..155c495b89ead 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -21,6 +21,9 @@
 #undef __get_bitmask
 #define __get_bitmask(field) (char *)__get_dynamic_array(field)
 
+#undef __get_cpumask
+#define __get_cpumask(field) (char *)__get_dynamic_array(field)
+
 #undef __get_sockaddr
 #define __get_sockaddr(field) ((struct sockaddr *)__get_dynamic_array(field))
 
@@ -40,6 +43,9 @@
 #undef __get_rel_bitmask
 #define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
 
+#undef __get_rel_cpumask
+#define __get_rel_cpumask(field) (char *)__get_rel_dynamic_array(field)
+
 #undef __get_rel_sockaddr
 #define __get_rel_sockaddr(field) ((struct sockaddr *)__get_rel_dynamic_array(field))
 
diff --git a/include/trace/perf.h b/include/trace/perf.h
index 5800d13146c3d..8f3bf1e177070 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -21,6 +21,9 @@
 #undef __get_bitmask
 #define __get_bitmask(field) (char *)__get_dynamic_array(field)
 
+#undef __get_cpumask
+#define __get_cpumask(field) (char *)__get_dynamic_array(field)
+
 #undef __get_sockaddr
 #define __get_sockaddr(field) ((struct sockaddr *)__get_dynamic_array(field))
 
@@ -41,6 +44,9 @@
 #undef __get_rel_bitmask
 #define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
 
+#undef __get_rel_cpumask
+#define __get_rel_cpumask(field) (char *)__get_rel_dynamic_array(field)
+
 #undef __get_rel_sockaddr
 #define __get_rel_sockaddr(field) ((struct sockaddr *)__get_rel_dynamic_array(field))
 
diff --git a/include/trace/stages/stage1_struct_define.h b/include/trace/stages/stage1_struct_define.h
index 1b7bab60434c1..69e0dae453bfa 100644
--- a/include/trace/stages/stage1_struct_define.h
+++ b/include/trace/stages/stage1_struct_define.h
@@ -32,6 +32,9 @@
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
 
+#undef __cpumask
+#define __cpumask(item) __dynamic_array(char, item, -1)
+
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
 
@@ -47,6 +50,9 @@
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(char, item, -1)
 
+#undef __rel_cpumask
+#define __rel_cpumask(item) __rel_dynamic_array(char, item, -1)
+
 #undef __rel_sockaddr
 #define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
 
diff --git a/include/trace/stages/stage2_data_offsets.h b/include/trace/stages/stage2_data_offsets.h
index 1b7a8f764fddd..469b6a64293de 100644
--- a/include/trace/stages/stage2_data_offsets.h
+++ b/include/trace/stages/stage2_data_offsets.h
@@ -38,6 +38,9 @@
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
+#undef __cpumask
+#define __cpumask(item) __dynamic_array(unsigned long, item, -1)
+
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
 
@@ -53,5 +56,8 @@
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
 
+#undef __rel_cpumask
+#define __rel_cpumask(item) __rel_dynamic_array(unsigned long, item, -1)
+
 #undef __rel_sockaddr
 #define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index e3b183e9d18ea..66374df61ed30 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -42,6 +42,9 @@
 		trace_print_bitmask_seq(p, __bitmask, __bitmask_size);	\
 	})
 
+#undef __get_cpumask
+#define __get_cpumask(field) __get_bitmask(field)
+
 #undef __get_rel_bitmask
 #define __get_rel_bitmask(field)						\
 	({								\
@@ -51,6 +54,9 @@
 		trace_print_bitmask_seq(p, __bitmask, __bitmask_size);	\
 	})
 
+#undef __get_rel_cpumask
+#define __get_rel_cpumask(field) __get_rel_bitmask(field)
+
 #undef __get_sockaddr
 #define __get_sockaddr(field)	((struct sockaddr *)__get_dynamic_array(field))
 
diff --git a/include/trace/stages/stage4_event_fields.h b/include/trace/stages/stage4_event_fields.h
index fae467ccd0c3c..5e7ebe69de8c1 100644
--- a/include/trace/stages/stage4_event_fields.h
+++ b/include/trace/stages/stage4_event_fields.h
@@ -47,6 +47,9 @@
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
+#undef __cpumask
+#define __cpumask(item) __dynamic_array(cpumask_t *, item, -1)
+
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
 
@@ -65,5 +68,8 @@
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
 
+#undef __rel_cpumask
+#define __rel_cpumask(item) __rel_dynamic_array(cpumask_t *, item, -1)
+
 #undef __rel_sockaddr
 #define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/stages/stage5_get_offsets.h
index def36fbb8c5cd..e30a13be46ba5 100644
--- a/include/trace/stages/stage5_get_offsets.h
+++ b/include/trace/stages/stage5_get_offsets.h
@@ -95,10 +95,16 @@
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item,	\
 					 __bitmask_size_in_longs(nr_bits))
 
+#undef __cpumask
+#define __cpumask(item) __bitmask(item, nr_cpumask_bits)
+
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item,	\
 					 __bitmask_size_in_longs(nr_bits))
 
+#undef __rel_cpumask
+#define __rel_cpumask(item) __rel_bitmask(item, nr_cpumask_bits)
+
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
 
diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 3c554a5853204..49c32394b53fb 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -57,6 +57,16 @@
 #define __assign_bitmask(dst, src, nr_bits)					\
 	memcpy(__get_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
 
+#undef __cpumask
+#define __cpumask(item) __dynamic_array(unsigned long, item, -1)
+
+#undef __get_cpumask
+#define __get_cpumask(field) (char *)__get_dynamic_array(field)
+
+#undef __assign_cpumask
+#define __assign_cpumask(dst, src)					\
+	memcpy(__get_cpumask(dst), (src), __bitmask_size_in_bytes(nr_cpumask_bits))
+
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
 
@@ -98,6 +108,16 @@
 #define __assign_rel_bitmask(dst, src, nr_bits)					\
 	memcpy(__get_rel_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
 
+#undef __rel_cpumask
+#define __rel_cpumask(item) __rel_dynamic_array(unsigned long, item, -1)
+
+#undef __get_rel_cpumask
+#define __get_rel_cpumask(field) (char *)__get_rel_dynamic_array(field)
+
+#undef __assign_rel_cpumask
+#define __assign_rel_cpumask(dst, src)					\
+	memcpy(__get_rel_cpumask(dst), (src), __bitmask_size_in_bytes(nr_cpumask_bits))
+
 #undef __rel_sockaddr
 #define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
 
diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
index 8a7ec24c246dd..8795429f388b0 100644
--- a/include/trace/stages/stage7_class_define.h
+++ b/include/trace/stages/stage7_class_define.h
@@ -13,11 +13,13 @@
 #undef __get_dynamic_array_len
 #undef __get_str
 #undef __get_bitmask
+#undef __get_cpumask
 #undef __get_sockaddr
 #undef __get_rel_dynamic_array
 #undef __get_rel_dynamic_array_len
 #undef __get_rel_str
 #undef __get_rel_bitmask
+#undef __get_rel_cpumask
 #undef __get_rel_sockaddr
 #undef __print_array
 #undef __print_hex_dump
diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
index 608c4ae3b08a3..ecc7db237f2ef 100644
--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -50,7 +50,7 @@ static void do_simple_thread_func(int cnt, const char *fmt, ...)
 
 	trace_foo_with_template_print("I have to be different", cnt);
 
-	trace_foo_rel_loc("Hello __rel_loc", cnt, bitmask);
+	trace_foo_rel_loc("Hello __rel_loc", cnt, bitmask, current->cpus_ptr);
 }
 
 static void simple_thread_func(int cnt)
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 1a92226202fc5..fb4548a44153c 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -200,6 +200,16 @@
  *
  *         __assign_bitmask(target_cpus, cpumask_bits(bar), nr_cpumask_bits);
  *
+ *   __cpumask: This is pretty much the same as __bitmask but is specific for
+ *         CPU masks. The type displayed to the user via the format files will
+ *         be "cpumaks_t" such that user space may deal with them differently
+ *         if they choose to do so, and the bits is always set to nr_cpumask_bits.
+ *
+ *         __cpumask(target_cpu)
+ *
+ *         To assign a cpumask, use the __assign_cpumask() helper macro.
+ *
+ *         __assign_cpumask(target_cpus, cpumask_bits(bar));
  *
  * fast_assign: This is a C like function that is used to store the items
  *    into the ring buffer. A special variable called "__entry" will be the
@@ -212,8 +222,8 @@
  *    This is also used to print out the data from the trace files.
  *    Again, the __entry macro is used to access the data from the ring buffer.
  *
- *    Note, __dynamic_array, __string, and __bitmask require special helpers
- *       to access the data.
+ *    Note, __dynamic_array, __string, __bitmask and __cpumask require special
+ *       helpers to access the data.
  *
  *      For __dynamic_array(int, foo, bar) use __get_dynamic_array(foo)
  *            Use __get_dynamic_array_len(foo) to get the length of the array
@@ -226,6 +236,8 @@
  *
  *      For __bitmask(target_cpus, nr_cpumask_bits) use __get_bitmask(target_cpus)
  *
+ *      For __cpumask(target_cpus) use __get_cpumask(target_cpus)
+ *
  *
  * Note, that for both the assign and the printk, __entry is the handler
  * to the data structure in the ring buffer, and is defined by the
@@ -288,6 +300,7 @@ TRACE_EVENT(foo_bar,
 		__dynamic_array(int,	list,   __length_of(lst))
 		__string(	str,	string			)
 		__bitmask(	cpus,	num_possible_cpus()	)
+		__cpumask(	cpum				)
 		__vstring(	vstr,	fmt,	va		)
 	),
 
@@ -299,9 +312,10 @@ TRACE_EVENT(foo_bar,
 		__assign_str(str, string);
 		__assign_vstr(vstr, fmt, va);
 		__assign_bitmask(cpus, cpumask_bits(mask), num_possible_cpus());
+		__assign_cpumask(cpum, cpumask_bits(mask));
 	),
 
-	TP_printk("foo %s %d %s %s %s %s (%s) %s", __entry->foo, __entry->bar,
+	TP_printk("foo %s %d %s %s %s %s (%s) (%s) %s", __entry->foo, __entry->bar,
 
 /*
  * Notice here the use of some helper functions. This includes:
@@ -345,7 +359,8 @@ TRACE_EVENT(foo_bar,
 		  __print_array(__get_dynamic_array(list),
 				__get_dynamic_array_len(list) / sizeof(int),
 				sizeof(int)),
-		  __get_str(str), __get_bitmask(cpus), __get_str(vstr))
+		  __get_str(str), __get_bitmask(cpus), __get_cpumask(cpus),
+		  __get_str(vstr))
 );
 
 /*
@@ -542,15 +557,16 @@ DEFINE_EVENT_PRINT(foo_template, foo_with_template_print,
 
 TRACE_EVENT(foo_rel_loc,
 
-	TP_PROTO(const char *foo, int bar, unsigned long *mask),
+	TP_PROTO(const char *foo, int bar, unsigned long *mask, const cpumask_t *cpus),
 
-	TP_ARGS(foo, bar, mask),
+	TP_ARGS(foo, bar, mask, cpus),
 
 	TP_STRUCT__entry(
 		__rel_string(	foo,	foo	)
 		__field(	int,	bar	)
 		__rel_bitmask(	bitmask,
 			BITS_PER_BYTE * sizeof(unsigned long)	)
+		__rel_cpumask(	cpumask )
 	),
 
 	TP_fast_assign(
@@ -558,10 +574,12 @@ TRACE_EVENT(foo_rel_loc,
 		__entry->bar = bar;
 		__assign_rel_bitmask(bitmask, mask,
 			BITS_PER_BYTE * sizeof(unsigned long));
+		__assign_rel_cpumask(cpumask, cpus);
 	),
 
-	TP_printk("foo_rel_loc %s, %d, %s", __get_rel_str(foo), __entry->bar,
-		  __get_rel_bitmask(bitmask))
+	TP_printk("foo_rel_loc %s, %d, %s, %s", __get_rel_str(foo), __entry->bar,
+		  __get_rel_bitmask(bitmask),
+		  __get_rel_cpumask(cpumask))
 );
 #endif
 
-- 
2.39.5




