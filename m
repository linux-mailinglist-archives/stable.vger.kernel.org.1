Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A1C75CA3D
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjGUOkX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjGUOjv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:39:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC1B30C7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:39:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73CD161CC7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86840C433C8;
        Fri, 21 Jul 2023 14:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689950388;
        bh=YJy2nZpkXVBfHxjX86a1Tpd5Y4Ij/jY/vM3YfIcPjjU=;
        h=Subject:To:Cc:From:Date:From;
        b=aL8+E/iecknfdHtN195aI4iGA/mfWQJH8W/RG5Va7RbOaQIKW0r4OHpgRcu7WIl+A
         DK4FI8hSdPVs0kn9+mnqGqr6Au9BreSMs6Y2pZqhmFlYk3VqyhKN6NEPtOX6B9KZFQ
         9dZ8RZhK0BSdptlUAJu34SU5A6t0dFrWsc+uWybw=
Subject: FAILED: patch "[PATCH] Revert "tracing: Add "(fault)" name injection to kernel" failed to apply to 6.1-stable tree
To:     mhiramat@kernel.org, akpm@linux-foundation.org,
        rostedt@goodmis.org, zanussi@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:39:46 +0200
Message-ID: <2023072146-thus-data-323d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4ed8f337dee32df71435689c19d22e4ee846e15a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072146-thus-data-323d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

4ed8f337dee3 ("Revert "tracing: Add "(fault)" name injection to kernel probes"")
00cf3d672a9d ("tracing: Allow synthetic events to pass around stacktraces")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4ed8f337dee32df71435689c19d22e4ee846e15a Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Tue, 11 Jul 2023 23:15:57 +0900
Subject: [PATCH] Revert "tracing: Add "(fault)" name injection to kernel
 probes"

This reverts commit 2e9906f84fc7c99388bb7123ade167250d50f1c0.

It was turned out that commit 2e9906f84fc7 ("tracing: Add "(fault)"
name injection to kernel probes") did not work correctly and probe
events still show just '(fault)' (instead of '"(fault)"'). Also,
current '(fault)' is more explicit that it faulted.

This also moves FAULT_STRING macro to trace.h so that synthetic
event can keep using it, and uses it in trace_probe.c too.

Link: https://lore.kernel.org/all/168908495772.123124.1250788051922100079.stgit@devnote2/
Link: https://lore.kernel.org/all/20230706230642.3793a593@rorschach.local.home/

Cc: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 79bdefe9261b..eee1f3ca4749 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -113,6 +113,8 @@ enum trace_type {
 #define MEM_FAIL(condition, fmt, ...)					\
 	DO_ONCE_LITE_IF(condition, pr_err, "ERROR: " fmt, ##__VA_ARGS__)
 
+#define FAULT_STRING "(fault)"
+
 #define HIST_STACKTRACE_DEPTH	16
 #define HIST_STACKTRACE_SIZE	(HIST_STACKTRACE_DEPTH * sizeof(unsigned long))
 #define HIST_STACKTRACE_SKIP	5
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 2d2616678295..591399ddcee5 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -65,7 +65,7 @@ int PRINT_TYPE_FUNC_NAME(string)(struct trace_seq *s, void *data, void *ent)
 	int len = *(u32 *)data >> 16;
 
 	if (!len)
-		trace_seq_puts(s, "(fault)");
+		trace_seq_puts(s, FAULT_STRING);
 	else
 		trace_seq_printf(s, "\"%s\"",
 				 (const char *)get_loc_data(data, ent));
diff --git a/kernel/trace/trace_probe_kernel.h b/kernel/trace/trace_probe_kernel.h
index c4e1d4c03a85..6deae2ce34f8 100644
--- a/kernel/trace/trace_probe_kernel.h
+++ b/kernel/trace/trace_probe_kernel.h
@@ -2,8 +2,6 @@
 #ifndef __TRACE_PROBE_KERNEL_H_
 #define __TRACE_PROBE_KERNEL_H_
 
-#define FAULT_STRING "(fault)"
-
 /*
  * This depends on trace_probe.h, but can not include it due to
  * the way trace_probe_tmpl.h is used by trace_kprobe.c and trace_eprobe.c.
@@ -15,16 +13,8 @@ static nokprobe_inline int
 fetch_store_strlen_user(unsigned long addr)
 {
 	const void __user *uaddr =  (__force const void __user *)addr;
-	int ret;
 
-	ret = strnlen_user_nofault(uaddr, MAX_STRING_SIZE);
-	/*
-	 * strnlen_user_nofault returns zero on fault, insert the
-	 * FAULT_STRING when that occurs.
-	 */
-	if (ret <= 0)
-		return strlen(FAULT_STRING) + 1;
-	return ret;
+	return strnlen_user_nofault(uaddr, MAX_STRING_SIZE);
 }
 
 /* Return the length of string -- including null terminal byte */
@@ -44,18 +34,7 @@ fetch_store_strlen(unsigned long addr)
 		len++;
 	} while (c && ret == 0 && len < MAX_STRING_SIZE);
 
-	/* For faults, return enough to hold the FAULT_STRING */
-	return (ret < 0) ? strlen(FAULT_STRING) + 1 : len;
-}
-
-static nokprobe_inline void set_data_loc(int ret, void *dest, void *__dest, void *base, int len)
-{
-	if (ret >= 0) {
-		*(u32 *)dest = make_data_loc(ret, __dest - base);
-	} else {
-		strscpy(__dest, FAULT_STRING, len);
-		ret = strlen(__dest) + 1;
-	}
+	return (ret < 0) ? ret : len;
 }
 
 /*
@@ -76,7 +55,8 @@ fetch_store_string_user(unsigned long addr, void *dest, void *base)
 	__dest = get_loc_data(dest, base);
 
 	ret = strncpy_from_user_nofault(__dest, uaddr, maxlen);
-	set_data_loc(ret, dest, __dest, base, maxlen);
+	if (ret >= 0)
+		*(u32 *)dest = make_data_loc(ret, __dest - base);
 
 	return ret;
 }
@@ -107,7 +87,8 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 	 * probing.
 	 */
 	ret = strncpy_from_kernel_nofault(__dest, (void *)addr, maxlen);
-	set_data_loc(ret, dest, __dest, base, maxlen);
+	if (ret >= 0)
+		*(u32 *)dest = make_data_loc(ret, __dest - base);
 
 	return ret;
 }

