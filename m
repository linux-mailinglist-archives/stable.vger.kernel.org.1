Return-Path: <stable+bounces-150288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EB3ACB7AB
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69CDA225E9
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D704F227E8E;
	Mon,  2 Jun 2025 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rkVIQ36n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D53227E80;
	Mon,  2 Jun 2025 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876647; cv=none; b=CAzjRg2GNonW2OkkbTBS7lQvDt/AHGCNeU+0WIrIEwS8aOcfnbxJ20fEWTzaCiWa5sCBopTy/E+0e++GM6t0ieta5QPTa/WbFTbQ0g5oc/rqstJIoUNntCSrU7+DVxg561B04e+kZFVqLQV8o8praoe7woxHukla7wKfEdQx+hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876647; c=relaxed/simple;
	bh=lGRa8qNKjbdLqidzDoIlFyoOhYzaTSxFWloEJgnsJHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kckhqYwzZVBZYBf9HLbh0ow1azjinV9gfo6Naq8fIbp0g6oqDrhzUWJLpoalu0jsjfoTrvY44JnIF4YuRIBjtZXrrPeDEJwgB5JmVsUANhoowNlJAF2CL2lHx5vbwhPaxrhk/Lx9RKdkJYD9tu+DgUVRnyazi12QBQ2fdGCPVuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rkVIQ36n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5A1C4CEEB;
	Mon,  2 Jun 2025 15:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748876647;
	bh=lGRa8qNKjbdLqidzDoIlFyoOhYzaTSxFWloEJgnsJHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rkVIQ36nb1XaaB+z9X7pJg861eRJh9TxXvN2ukPVfRzNcEF7qhUIWFg4jaPU3r+Bp
	 HCKYh9rL+t7epfm4EiVLVGGR5gs7E0oTKQVC7twc7EsEUJx3ACsD6yjAdywYV+mh6t
	 bhfgIIL0WIgesxz9uYohAqyo4dRVDiRXxN62w0NU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 029/325] tracing: Mark binary printing functions with __printf() attribute
Date: Mon,  2 Jun 2025 15:45:05 +0200
Message-ID: <20250602134320.931908156@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 2a70a447184c9..bb4d84f1c58cc 100644
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
index 5a2c650d9e1c1..c230cbd25aee8 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -77,8 +77,8 @@ extern __printf(2, 3)
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
@@ -100,8 +100,8 @@ extern int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
 static inline void trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
 {
 }
-static inline void
-trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary)
+static inline __printf(2, 0)
+void trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary)
 {
 }
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9da29583dfbc7..9e0b9c9a7dff9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3422,10 +3422,9 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
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
@@ -3478,7 +3477,6 @@ __trace_array_vprintk(struct trace_buffer *buffer,
 	return len;
 }
 
-__printf(3, 0)
 int trace_array_vprintk(struct trace_array *tr,
 			unsigned long ip, const char *fmt, va_list args)
 {
@@ -3505,7 +3503,6 @@ int trace_array_vprintk(struct trace_array *tr,
  * Note, trace_array_init_printk() must be called on @tr before this
  * can be used.
  */
-__printf(3, 0)
 int trace_array_printk(struct trace_array *tr,
 		       unsigned long ip, const char *fmt, ...)
 {
@@ -3550,7 +3547,6 @@ int trace_array_init_printk(struct trace_array *tr)
 }
 EXPORT_SYMBOL_GPL(trace_array_init_printk);
 
-__printf(3, 4)
 int trace_array_printk_buf(struct trace_buffer *buffer,
 			   unsigned long ip, const char *fmt, ...)
 {
@@ -3566,7 +3562,6 @@ int trace_array_printk_buf(struct trace_buffer *buffer,
 	return ret;
 }
 
-__printf(2, 0)
 int trace_vprintk(unsigned long ip, const char *fmt, va_list args)
 {
 	return trace_array_vprintk(&global_trace, ip, fmt, args);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index aad7fcd84617c..49b297ca7fc72 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -780,13 +780,15 @@ static inline void __init disable_tracing_selftest(const char *reason)
 
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




