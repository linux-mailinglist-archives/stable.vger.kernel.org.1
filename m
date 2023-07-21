Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F1975CA41
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjGUOkZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjGUOkO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:40:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF372D7B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:40:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C943F61CB8
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1511C433C8;
        Fri, 21 Jul 2023 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689950412;
        bh=AMcP02aZtJLs+wloglE3TIE4/5pRusKBZPlzNk7OEl8=;
        h=Subject:To:Cc:From:Date:From;
        b=zpHHGARBx958jELSUunwEo0ZHwCMb1++/mKN2GZF/oi2LUXeVTJ2Qyllx6KHet3Kv
         b+TEROsO1ZlDmHCfWDNLvB/b5lvLv4vC2/NptcMGlGN1WNXp/8cig11004wFxYettM
         2jE6zkUv+aZJalodZObCE2DN4uV/29WsjnetwqSU=
Subject: FAILED: patch "[PATCH] tracing/probes: Fix to record 0-length data_loc in" failed to apply to 5.10-stable tree
To:     mhiramat@kernel.org, rostedt@goodmis.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:40:05 +0200
Message-ID: <2023072105-drop-down-yearling-a66f@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 797311bce5c2ac90b8d65e357603cfd410d36ebb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072105-drop-down-yearling-a66f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

797311bce5c2 ("tracing/probes: Fix to record 0-length data_loc in fetch_store_string*() if fails")
4ed8f337dee3 ("Revert "tracing: Add "(fault)" name injection to kernel probes"")
e38e2c6a9efc ("tracing/probes: Fix to update dynamic data counter if fetcharg uses it")
00cf3d672a9d ("tracing: Allow synthetic events to pass around stacktraces")
f1d3cbfaafc1 ("tracing: Move duplicate code of trace_kprobe/eprobe.c into header")
7491e2c44278 ("tracing: Add a probe that attaches to trace events")
8565a45d0858 ("tracing/probes: Have process_fetch_insn() take a void * instead of pt_regs")
007517a01995 ("tracing/probe: Change traceprobe_set_print_fmt() to take a type")
3b13911a2fd0 ("tracing: Synthetic event field_pos is an index not a boolean")
bc87cf0a08d4 ("trace: Add a generic function to read/write u64 values from tracefs")
d262271d0483 ("tracing/dynevent: Delegate parsing to create function")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 797311bce5c2ac90b8d65e357603cfd410d36ebb Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Tue, 11 Jul 2023 23:16:07 +0900
Subject: [PATCH] tracing/probes: Fix to record 0-length data_loc in
 fetch_store_string*() if fails

Fix to record 0-length data to data_loc in fetch_store_string*() if it fails
to get the string data.
Currently those expect that the data_loc is updated by store_trace_args() if
it returns the error code. However, that does not work correctly if the
argument is an array of strings. In that case, store_trace_args() only clears
the first entry of the array (which may have no error) and leaves other
entries. So it should be cleared by fetch_store_string*() itself.
Also, 'dyndata' and 'maxlen' in store_trace_args() should be updated
only if it is used (ret > 0 and argument is a dynamic data.)

Link: https://lore.kernel.org/all/168908496683.123124.4761206188794205601.stgit@devnote2/

Fixes: 40b53b771806 ("tracing: probeevent: Add array type support")
Cc: stable@vger.kernel.org
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/trace_probe_kernel.h b/kernel/trace/trace_probe_kernel.h
index 6deae2ce34f8..bb723eefd7b7 100644
--- a/kernel/trace/trace_probe_kernel.h
+++ b/kernel/trace/trace_probe_kernel.h
@@ -37,6 +37,13 @@ fetch_store_strlen(unsigned long addr)
 	return (ret < 0) ? ret : len;
 }
 
+static nokprobe_inline void set_data_loc(int ret, void *dest, void *__dest, void *base)
+{
+	if (ret < 0)
+		ret = 0;
+	*(u32 *)dest = make_data_loc(ret, __dest - base);
+}
+
 /*
  * Fetch a null-terminated string from user. Caller MUST set *(u32 *)buf
  * with max length and relative data location.
@@ -55,8 +62,7 @@ fetch_store_string_user(unsigned long addr, void *dest, void *base)
 	__dest = get_loc_data(dest, base);
 
 	ret = strncpy_from_user_nofault(__dest, uaddr, maxlen);
-	if (ret >= 0)
-		*(u32 *)dest = make_data_loc(ret, __dest - base);
+	set_data_loc(ret, dest, __dest, base);
 
 	return ret;
 }
@@ -87,8 +93,7 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 	 * probing.
 	 */
 	ret = strncpy_from_kernel_nofault(__dest, (void *)addr, maxlen);
-	if (ret >= 0)
-		*(u32 *)dest = make_data_loc(ret, __dest - base);
+	set_data_loc(ret, dest, __dest, base);
 
 	return ret;
 }
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 185da001f4c3..3935b347f874 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -267,13 +267,9 @@ store_trace_args(void *data, struct trace_probe *tp, void *rec,
 		if (unlikely(arg->dynamic))
 			*dl = make_data_loc(maxlen, dyndata - base);
 		ret = process_fetch_insn(arg->code, rec, dl, base);
-		if (arg->dynamic) {
-			if (unlikely(ret < 0)) {
-				*dl = make_data_loc(0, dyndata - base);
-			} else {
-				dyndata += ret;
-				maxlen -= ret;
-			}
+		if (arg->dynamic && likely(ret > 0)) {
+			dyndata += ret;
+			maxlen -= ret;
 		}
 	}
 }
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 8b92e34ff0c8..7b47e9a2c010 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -170,7 +170,8 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 			 */
 			ret++;
 		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
-	}
+	} else
+		*(u32 *)dest = make_data_loc(0, (void *)dst - base);
 
 	return ret;
 }

