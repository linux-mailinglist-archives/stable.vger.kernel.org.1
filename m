Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261E075CA36
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGUOir (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjGUOin (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:38:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0592D7B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5F6661CD0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF4EC433C7;
        Fri, 21 Jul 2023 14:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689950321;
        bh=H9+UPUot8wThCl7i4wqyt1Gf3RaCn1xsCJ7/6yMQiB4=;
        h=Subject:To:Cc:From:Date:From;
        b=WbiwbyyvrqXrIk348SGhX05gghxEBbvgUNvyMa2dIv+8TrSolGQlCEdqeP0pFZeOb
         TOL7Wt5n6pOBdR2kX+R6Y2tmCRu4zwz6YLkX1vK1B37wzy8ugWhSQ2trwNKSPucHfa
         BW3EmwDAui9h/GEu71J9t6j1tJtXGr7/zRtvgPcU=
Subject: FAILED: patch "[PATCH] tracing/probes: Fix to avoid double count of the string" failed to apply to 6.1-stable tree
To:     mhiramat@kernel.org, dan.carpenter@linaro.org, rostedt@goodmis.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:38:38 +0200
Message-ID: <2023072138-nervous-shorten-9868@gregkh>
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
git cherry-pick -x 66bcf65d6cf0ca6540e2341e88ee7ef02dbdda08
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072138-nervous-shorten-9868@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

66bcf65d6cf0 ("tracing/probes: Fix to avoid double count of the string length on the array")
b26a124cbfa8 ("tracing/probes: Add symstr type for dynamic events")

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

