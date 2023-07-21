Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F44D75CA38
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjGUOjV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjGUOi5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:38:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1B830D2
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:38:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFC4761CB7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CECEC433C7;
        Fri, 21 Jul 2023 14:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689950334;
        bh=Af+Bm2G/ViHm6EETvtodZS1spmJV7kMChVmNtWUaPZ4=;
        h=Subject:To:Cc:From:Date:From;
        b=GhKd+OECKUN6Dv9RVn5cIt/+hBxbiHurWrB6oDnvfFjTjOBIWlQv1RyH7tuiVxuCg
         5mTxI02QMkyMnCu/zKgjPNh/QPAwduoLr/QNkbHZ27ThgFKfRa6kUWSB/Vn457160K
         pAzObxg74o6rGglPL0uulbDvwkyJZ8Naf5RkQljs=
Subject: FAILED: patch "[PATCH] tracing/probes: Fix to avoid double count of the string" failed to apply to 5.4-stable tree
To:     mhiramat@kernel.org, dan.carpenter@linaro.org, rostedt@goodmis.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:38:41 +0200
Message-ID: <2023072141-stride-endorphin-a57a@gregkh>
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 66bcf65d6cf0ca6540e2341e88ee7ef02dbdda08
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072141-stride-endorphin-a57a@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

66bcf65d6cf0 ("tracing/probes: Fix to avoid double count of the string length on the array")
b26a124cbfa8 ("tracing/probes: Add symstr type for dynamic events")
7491e2c44278 ("tracing: Add a probe that attaches to trace events")
007517a01995 ("tracing/probe: Change traceprobe_set_print_fmt() to take a type")
fcd9db51df8e ("tracing/probe: Have traceprobe_parse_probe_arg() take a const arg")
bc87cf0a08d4 ("trace: Add a generic function to read/write u64 values from tracefs")
d262271d0483 ("tracing/dynevent: Delegate parsing to create function")
d4d704637d93 ("tracing: Add synthetic event error logging")
9bbb33291f8e ("tracing: Check that the synthetic event and field names are legal")
42d120e2dda5 ("tracing: Move is_good_name() from trace_probe.h to trace.h")
bd82631d7ccd ("tracing: Add support for dynamic strings to synthetic events")
8fbeb52a598c ("tracing: Fix parse_synth_field() error handling")
3aa8fdc37d16 ("tracing/probe: Fix memleak in fetch_op_data operations")
726721a51838 ("tracing: Move synthetic events to a separate file")
1b94b3aed367 ("tracing: Check state.disabled in synth event trace functions")
91ad64a84e9e ("Merge tag 'trace-v5.6-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 66bcf65d6cf0ca6540e2341e88ee7ef02dbdda08 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Tue, 11 Jul 2023 23:15:29 +0900
Subject: [PATCH] tracing/probes: Fix to avoid double count of the string
 length on the array

If an array is specified with the ustring or symstr, the length of the
strings are accumlated on both of 'ret' and 'total', which means the
length is double counted.
Just set the length to the 'ret' value for avoiding double counting.

Link: https://lore.kernel.org/all/168908492917.123124.15076463491122036025.stgit@devnote2/

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain/
Fixes: 88903c464321 ("tracing/probe: Add ustring type for user-space string")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 00707630788d..4735c5cb76fa 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -156,11 +156,11 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 			code++;
 			goto array;
 		case FETCH_OP_ST_USTRING:
-			ret += fetch_store_strlen_user(val + code->offset);
+			ret = fetch_store_strlen_user(val + code->offset);
 			code++;
 			goto array;
 		case FETCH_OP_ST_SYMSTR:
-			ret += fetch_store_symstrlen(val + code->offset);
+			ret = fetch_store_symstrlen(val + code->offset);
 			code++;
 			goto array;
 		default:

