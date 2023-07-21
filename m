Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23D975D18F
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjGUSuL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGUSuI (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:50:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E9630CA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:50:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 886C861D6D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C782C433C8;
        Fri, 21 Jul 2023 18:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965406;
        bh=CgEyd9sSzyrDm8jaeQqVBkUQk5gkCnj3KLxUVT5nxXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xzAWyIAcZa9ntvgwNWWgPNjw8dUp1E238Ccr8hA3mnDv65mB/CA05lbcYelCUEuqz
         laQREUuoYEoT9Wzr4p5k3Ygz6lnEjdHk7EBeGZm3TG2rHWgU3Yi1lcqXe1h3MohTYa
         OLOyer0ecHiwm4lJ2EmwcechzF3EDE+8t8vcWV00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.4 272/292] Revert "tracing: Add "(fault)" name injection to kernel probes"
Date:   Fri, 21 Jul 2023 18:06:21 +0200
Message-ID: <20230721160540.622757469@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

commit 4ed8f337dee32df71435689c19d22e4ee846e15a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace.h              |    2 ++
 kernel/trace/trace_probe.c        |    2 +-
 kernel/trace/trace_probe_kernel.h |   31 ++++++-------------------------
 3 files changed, 9 insertions(+), 26 deletions(-)

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
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -65,7 +65,7 @@ int PRINT_TYPE_FUNC_NAME(string)(struct
 	int len = *(u32 *)data >> 16;
 
 	if (!len)
-		trace_seq_puts(s, "(fault)");
+		trace_seq_puts(s, FAULT_STRING);
 	else
 		trace_seq_printf(s, "\"%s\"",
 				 (const char *)get_loc_data(data, ent));
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
@@ -76,7 +55,8 @@ fetch_store_string_user(unsigned long ad
 	__dest = get_loc_data(dest, base);
 
 	ret = strncpy_from_user_nofault(__dest, uaddr, maxlen);
-	set_data_loc(ret, dest, __dest, base, maxlen);
+	if (ret >= 0)
+		*(u32 *)dest = make_data_loc(ret, __dest - base);
 
 	return ret;
 }
@@ -107,7 +87,8 @@ fetch_store_string(unsigned long addr, v
 	 * probing.
 	 */
 	ret = strncpy_from_kernel_nofault(__dest, (void *)addr, maxlen);
-	set_data_loc(ret, dest, __dest, base, maxlen);
+	if (ret >= 0)
+		*(u32 *)dest = make_data_loc(ret, __dest - base);
 
 	return ret;
 }


