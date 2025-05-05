Return-Path: <stable+bounces-139765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BBBAA9F2C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8CEA7AB3C4
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B8D27D77F;
	Mon,  5 May 2025 22:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQbz0t5i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA88B27D771;
	Mon,  5 May 2025 22:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483293; cv=none; b=ZT2P4wKsY/GGFqstrMtDoWykZKvwKI2mePYLudPB4IJPU1McCvhSaY5uxJG4zMGbdF+7H80Bycj3Hg+4C9gxzigj5nukzBkVUorHcYCMQIfyZpwv4rtAa/QBAqdxzgFlUwInd3isrq45PRqPWwljY7Mll44G39nNP3Sf4w9oysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483293; c=relaxed/simple;
	bh=FT1+EpWzCIAZtvIhc/cjhHbSYAHWTHUfdnFhRyM0jss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O9MlZ6UoLJPkuXLC/2drc20zKF0BXuMS0vFGEh26fAe8IC5LXNDWNeSigYDAvSGrF73ElSP3x1mH0xCNrya4UaKPjHLL0ECmm7rM2PMMQGFu7WTNGWMwTTJ99gdV34VZTsVwzpfzESqGczhcxzuvDg1FxTH9IzlwSqPi5ZDtGF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQbz0t5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D37C4CEED;
	Mon,  5 May 2025 22:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483293;
	bh=FT1+EpWzCIAZtvIhc/cjhHbSYAHWTHUfdnFhRyM0jss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qQbz0t5iLML0wYSTLdXFznpPqBZWG86kIkpjHePFm0kZGh4bJrouwNzO+D9AWPVQ0
	 r3Lmum6i0W96+rWHjqgy9Ma9e8XZ2tmQu4fZXGG4o6LNVaqrTWYrJzYHxB0YS2SeJd
	 JGvBM8tG+5ssrUXlh104SgiAxoKYVLZEWtiRumqtyrL+TtkDjwEfx0BkmqWaLNwNCS
	 LSjGgfn5pgQSDAe4TrMxVrVNd4H8rV6GmjGJUqgU6TOoIidk2m5lUTm46jc+wXiSzB
	 U08Qhvz9XhzB8b4EAZt4YGtp+y7eJl50WIQrsEoaGVQUlpVEq6l4PvHECrIh/Z/hM6
	 yUsiwZoMAHpLg==
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
Subject: [PATCH AUTOSEL 6.14 018/642] tracing: Mark binary printing functions with __printf() attribute
Date: Mon,  5 May 2025 18:03:54 -0400
Message-Id: <20250505221419.2672473-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index ccadd8c657e1a..fd853bf0000d2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3322,10 +3322,9 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
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
 	struct ring_buffer_event *event;
 	int len = 0, size;
@@ -3375,7 +3374,6 @@ __trace_array_vprintk(struct trace_buffer *buffer,
 	return len;
 }
 
-__printf(3, 0)
 int trace_array_vprintk(struct trace_array *tr,
 			unsigned long ip, const char *fmt, va_list args)
 {
@@ -3405,7 +3403,6 @@ int trace_array_vprintk(struct trace_array *tr,
  * Note, trace_array_init_printk() must be called on @tr before this
  * can be used.
  */
-__printf(3, 0)
 int trace_array_printk(struct trace_array *tr,
 		       unsigned long ip, const char *fmt, ...)
 {
@@ -3450,7 +3447,6 @@ int trace_array_init_printk(struct trace_array *tr)
 }
 EXPORT_SYMBOL_GPL(trace_array_init_printk);
 
-__printf(3, 4)
 int trace_array_printk_buf(struct trace_buffer *buffer,
 			   unsigned long ip, const char *fmt, ...)
 {
@@ -3466,7 +3462,6 @@ int trace_array_printk_buf(struct trace_buffer *buffer,
 	return ret;
 }
 
-__printf(2, 0)
 int trace_vprintk(unsigned long ip, const char *fmt, va_list args)
 {
 	return trace_array_vprintk(printk_trace, ip, fmt, args);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index abe8169c3e879..ccf3874823f5f 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -837,13 +837,15 @@ static inline void __init disable_tracing_selftest(const char *reason)
 
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


