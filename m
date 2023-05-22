Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF0B70C4F3
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 20:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjEVSGH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 14:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjEVSGG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 14:06:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874A1DC
        for <stable@vger.kernel.org>; Mon, 22 May 2023 11:06:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1763762607
        for <stable@vger.kernel.org>; Mon, 22 May 2023 18:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C1DC433D2;
        Mon, 22 May 2023 18:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684778764;
        bh=41Lm9jN+sNF83IBYKWHXBBRQC/b6VQUdr8HPbva1FkY=;
        h=Subject:To:Cc:From:Date:From;
        b=oOf/iC87Jke2Z8syMlj7ERbMXXSf7Wr/u3vNNxEsWKwOao5C/Q9IS6UEUExJwuqWd
         PzOcO04YmyfOX64w/WUB4g2N0elK7T+aCh3/QZ9hPltW7XL+tOLlTrLdUH8Hy+mUCm
         yLBGMKOA7qljmaOfAh0IOhmOYST3kESKmxZ1cAtY=
Subject: FAILED: patch "[PATCH] fprobe: add recursion detection in fprobe_exit_handler" failed to apply to 6.1-stable tree
To:     zegao2021@gmail.com, mhiramat@kernel.org, zegao@tencent.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 22 May 2023 19:05:53 +0100
Message-ID: <2023052253-squabble-matchbook-63eb@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
git cherry-pick -x 2752741080f84f9b2fc93fa92735315d10a415bf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052253-squabble-matchbook-63eb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

2752741080f8 ("fprobe: add recursion detection in fprobe_exit_handler")
76d0de5729c0 ("fprobe: Pass entry_data to handlers")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2752741080f84f9b2fc93fa92735315d10a415bf Mon Sep 17 00:00:00 2001
From: Ze Gao <zegao2021@gmail.com>
Date: Wed, 17 May 2023 11:45:08 +0800
Subject: [PATCH] fprobe: add recursion detection in fprobe_exit_handler

fprobe_hander and fprobe_kprobe_handler has guarded ftrace recursion
detection but fprobe_exit_handler has not, which possibly introduce
recursive calls if the fprobe exit callback calls any traceable
functions. Checking in fprobe_hander or fprobe_kprobe_handler
is not enough and misses this case.

So add recursion free guard the same way as fprobe_hander. Since
ftrace recursion check does not employ ip(s), so here use entry_ip and
entry_parent_ip the same as fprobe_handler.

Link: https://lore.kernel.org/all/20230517034510.15639-4-zegao@tencent.com/

Fixes: 5b0ab78998e3 ("fprobe: Add exit_handler support")
Signed-off-by: Ze Gao <zegao@tencent.com>
Cc: stable@vger.kernel.org
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 7a692c02f787..18d36842faf5 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -17,6 +17,7 @@
 struct fprobe_rethook_node {
 	struct rethook_node node;
 	unsigned long entry_ip;
+	unsigned long entry_parent_ip;
 	char data[];
 };
 
@@ -39,6 +40,7 @@ static inline void __fprobe_handler(unsigned long ip, unsigned long parent_ip,
 		}
 		fpr = container_of(rh, struct fprobe_rethook_node, node);
 		fpr->entry_ip = ip;
+		fpr->entry_parent_ip = parent_ip;
 		if (fp->entry_data_size)
 			entry_data = fpr->data;
 	}
@@ -114,14 +116,26 @@ static void fprobe_exit_handler(struct rethook_node *rh, void *data,
 {
 	struct fprobe *fp = (struct fprobe *)data;
 	struct fprobe_rethook_node *fpr;
+	int bit;
 
 	if (!fp || fprobe_disabled(fp))
 		return;
 
 	fpr = container_of(rh, struct fprobe_rethook_node, node);
 
+	/*
+	 * we need to assure no calls to traceable functions in-between the
+	 * end of fprobe_handler and the beginning of fprobe_exit_handler.
+	 */
+	bit = ftrace_test_recursion_trylock(fpr->entry_ip, fpr->entry_parent_ip);
+	if (bit < 0) {
+		fp->nmissed++;
+		return;
+	}
+
 	fp->exit_handler(fp, fpr->entry_ip, regs,
 			 fp->entry_data_size ? (void *)fpr->data : NULL);
+	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(fprobe_exit_handler);
 

