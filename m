Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCAD75CA3A
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjGUOjV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjGUOjT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:39:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA4D2D7B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:39:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80FD561CD1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99682C433C8;
        Fri, 21 Jul 2023 14:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689950357;
        bh=Sl9deBsrMZ/BCbSv96zLbvmj3mwew2cIAJlbE1bklDo=;
        h=Subject:To:Cc:From:Date:From;
        b=iefPa0chOGuGjRkfHxRltlk+ErkeWcCP9t2I+zraTYAolfeFF/R9nISKy9VQqCGOo
         2xPXNSbbNkzfyisF6OY2UJ67+BxDaj1hDN3VROI49ECzdjoTPj9Efc5fazre+/dRDP
         Na4q2mOBwZ1rEKbRXKP2x7PxgvWBzjJ8w20K/rV8=
Subject: FAILED: patch "[PATCH] tracing/probes: Fix to update dynamic data counter if" failed to apply to 5.10-stable tree
To:     mhiramat@kernel.org, rostedt@goodmis.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:39:14 +0200
Message-ID: <2023072113-repave-bootleg-b466@gregkh>
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
git cherry-pick -x e38e2c6a9efc435f9de344b7c91f7697e01b47d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072113-repave-bootleg-b466@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

e38e2c6a9efc ("tracing/probes: Fix to update dynamic data counter if fetcharg uses it")
8565a45d0858 ("tracing/probes: Have process_fetch_insn() take a void * instead of pt_regs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e38e2c6a9efc435f9de344b7c91f7697e01b47d5 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Tue, 11 Jul 2023 23:15:48 +0900
Subject: [PATCH] tracing/probes: Fix to update dynamic data counter if
 fetcharg uses it

Fix to update dynamic data counter ('dyndata') and max length ('maxlen')
only if the fetcharg uses the dynamic data. Also get out arg->dynamic
from unlikely(). This makes dynamic data address wrong if
process_fetch_insn() returns error on !arg->dynamic case.

Link: https://lore.kernel.org/all/168908494781.123124.8160245359962103684.stgit@devnote2/

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Link: https://lore.kernel.org/all/20230710233400.5aaf024e@gandalf.local.home/
Fixes: 9178412ddf5a ("tracing: probeevent: Return consumed bytes of dynamic area")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index ed9d57c6b041..185da001f4c3 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -267,11 +267,13 @@ store_trace_args(void *data, struct trace_probe *tp, void *rec,
 		if (unlikely(arg->dynamic))
 			*dl = make_data_loc(maxlen, dyndata - base);
 		ret = process_fetch_insn(arg->code, rec, dl, base);
-		if (unlikely(ret < 0 && arg->dynamic)) {
-			*dl = make_data_loc(0, dyndata - base);
-		} else {
-			dyndata += ret;
-			maxlen -= ret;
+		if (arg->dynamic) {
+			if (unlikely(ret < 0)) {
+				*dl = make_data_loc(0, dyndata - base);
+			} else {
+				dyndata += ret;
+				maxlen -= ret;
+			}
 		}
 	}
 }

