Return-Path: <stable+bounces-140407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10330AAA88E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBB59875E1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6A534CE4B;
	Mon,  5 May 2025 22:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OO6UTbIf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B964534CE44;
	Mon,  5 May 2025 22:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484791; cv=none; b=ICVmndEgmXc8nHWn54QP9ncMaEWEJRMXmhVO0BODeV1l85mNd1b3qyr3/yH990o4QFyqnkgqRK+phshj0csA45v1cDoQG+iTlxcgfb1K/L7mXIASLRwB7hgQ52MqQYRIY8q7JlsmwbTTBwHOML3k/vBkIeMQJILQzmWyRGiGxjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484791; c=relaxed/simple;
	bh=Jzozhf5AputwBTicm/dikZl86njAwSd+yzO7tbFjBxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gj5NdzS0Qsia0OBR+E+j4nMSShQJx3qJn/TESkzwoh/gseKEcZlhi8Ohd49nHifqnu7tGwAJywYOLk0RnIHpqOAEiNWIEY+sCv04p6xGquLObnBylYa+DcUnmi/YAfFGoZMNiNUpsaPG14ebNwAJrF2D1PiEAuQtIpqWUkO71qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OO6UTbIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEF7C4AF09;
	Mon,  5 May 2025 22:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484791;
	bh=Jzozhf5AputwBTicm/dikZl86njAwSd+yzO7tbFjBxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OO6UTbIfzjTIMLH1m2ITaLt6jaXoc3hs8Zy5iNAf5xzcO6PM/mXWR321EQUx4BAqm
	 EJRnYNAQYXXaBVZFDGKY3J8lM1Rqmazw/GJba9tHObG+VzGIrFZPJ4zfOqK4gSAmfV
	 hmyOxITRwzDT2DAc9hQ/AvogAK3+e1Xz/SoBQ0zrbPUtddKGRhHLAGE8N2yneVdJ+9
	 ZddIzFv4YOhNyvE12XJV6/j1VcmTtaUVVu9qnavOMySPiQKRtIBNyiuEsoZE5jvyix
	 hn5PVcNcS4LhFDYBimT3bmos2LWo1NKF9JB2Gr6KdIr7RbO8gaj3cJzz+n+XpOkTiA
	 FmaV167+2E+Fw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 016/486] tracing: Mark binary printing functions with __printf() attribute
Date: Mon,  5 May 2025 18:31:32 -0400
Message-Id: <20250505223922.2682012-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 196a062641fe68d9bfe0ad36b6cd7628c99ad22c ]

Binary printing functions are using printf() type of format, and compiler
is not happy about them as is:

kernel/trace/trace.c:3292:9: error: function ‘trace_vbprintk’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
kernel/trace/trace_seq.c:182:9: error: function ‘trace_seq_bprintf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]

Fix the compilation errors by adding __printf() attribute.

While at it, move existing __printf() attributes from the implementations
to the declarations. IT also fixes incorrect attribute parameters that are
used for trace_array_printk().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20250321144822.324050-4-andriy.shevchenko@linux.intel.com
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/trace.h     |  4 ++--
 include/linux/trace_seq.h |  8 ++++----
 kernel/trace/trace.c      | 11 +++--------
 kernel/trace/trace.h      | 16 +++++++++-------
 4 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index fdcd76b7be83d..7eaad857dee04 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -72,8 +72,8 @@ static inline int unregister_ftrace_export(struct trace_export *export)
 static inline void trace_printk_init_buffers(void)
 {
 }
-static inline int trace_array_printk(struct trace_array *tr, unsigned long ip,
-				     const char *fmt, ...)
+static inline __printf(3, 4)
+int trace_array_printk(struct trace_array *tr, unsigned long ip, const char *fmt, ...)
 {
 	return 0;
 }
diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 1ef95c0287f05..a93ed5ac32265 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -88,8 +88,8 @@ extern __printf(2, 3)
 void trace_seq_printf(struct trace_seq *s, const char *fmt, ...);
 extern __printf(2, 0)
 void trace_seq_vprintf(struct trace_seq *s, const char *fmt, va_list args);
-extern void
-trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary);
+extern __printf(2, 0)
+void trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary);
 extern int trace_print_seq(struct seq_file *m, struct trace_seq *s);
 extern int trace_seq_to_user(struct trace_seq *s, char __user *ubuf,
 			     int cnt);
@@ -113,8 +113,8 @@ static inline __printf(2, 3)
 void trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
 {
 }
-static inline void
-trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary)
+static inline __printf(2, 0)
+void trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary)
 {
 }
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ffe1422ab03f8..f7bc6a819bcfd 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3343,10 +3343,9 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 }
 EXPORT_SYMBOL_GPL(trace_vbprintk);
 
-__printf(3, 0)
-static int
-__trace_array_vprintk(struct trace_buffer *buffer,
-		      unsigned long ip, const char *fmt, va_list args)
+static __printf(3, 0)
+int __trace_array_vprintk(struct trace_buffer *buffer,
+			  unsigned long ip, const char *fmt, va_list args)
 {
 	struct trace_event_call *call = &event_print;
 	struct ring_buffer_event *event;
@@ -3399,7 +3398,6 @@ __trace_array_vprintk(struct trace_buffer *buffer,
 	return len;
 }
 
-__printf(3, 0)
 int trace_array_vprintk(struct trace_array *tr,
 			unsigned long ip, const char *fmt, va_list args)
 {
@@ -3429,7 +3427,6 @@ int trace_array_vprintk(struct trace_array *tr,
  * Note, trace_array_init_printk() must be called on @tr before this
  * can be used.
  */
-__printf(3, 0)
 int trace_array_printk(struct trace_array *tr,
 		       unsigned long ip, const char *fmt, ...)
 {
@@ -3474,7 +3471,6 @@ int trace_array_init_printk(struct trace_array *tr)
 }
 EXPORT_SYMBOL_GPL(trace_array_init_printk);
 
-__printf(3, 4)
 int trace_array_printk_buf(struct trace_buffer *buffer,
 			   unsigned long ip, const char *fmt, ...)
 {
@@ -3490,7 +3486,6 @@ int trace_array_printk_buf(struct trace_buffer *buffer,
 	return ret;
 }
 
-__printf(2, 0)
 int trace_vprintk(unsigned long ip, const char *fmt, va_list args)
 {
 	return trace_array_vprintk(printk_trace, ip, fmt, args);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 04ea327198ba8..82da3ac140242 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -818,13 +818,15 @@ static inline void __init disable_tracing_selftest(const char *reason)
 
 extern void *head_page(struct trace_array_cpu *data);
 extern unsigned long long ns2usecs(u64 nsec);
-extern int
-trace_vbprintk(unsigned long ip, const char *fmt, va_list args);
-extern int
-trace_vprintk(unsigned long ip, const char *fmt, va_list args);
-extern int
-trace_array_vprintk(struct trace_array *tr,
-		    unsigned long ip, const char *fmt, va_list args);
+
+__printf(2, 0)
+int trace_vbprintk(unsigned long ip, const char *fmt, va_list args);
+__printf(2, 0)
+int trace_vprintk(unsigned long ip, const char *fmt, va_list args);
+__printf(3, 0)
+int trace_array_vprintk(struct trace_array *tr,
+			unsigned long ip, const char *fmt, va_list args);
+__printf(3, 4)
 int trace_array_printk_buf(struct trace_buffer *buffer,
 			   unsigned long ip, const char *fmt, ...);
 void trace_printk_seq(struct trace_seq *s);
-- 
2.39.5


