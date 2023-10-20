Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1D27D16E7
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 22:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjJTUXa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 16:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjJTUX2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 16:23:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5CAD66
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 13:23:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D8DC433C7;
        Fri, 20 Oct 2023 20:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697833407;
        bh=ny27s5sECPGtFBGwyTF5KA3x2b5VWyZgBTlQMrJVQ7w=;
        h=Subject:To:Cc:From:Date:From;
        b=tyffRjVWG1aNUTZkqwKCUF2QcJ7NR+RkJfWnuykeG2el1PWfb5PSrqFgjlU+v7/js
         MnKU2AQxH1syTh++2PrKZXKeVwSPvsaXjRvRWKwDK10A7Q0eTFdQ350aCPT+mt99tq
         OztQwxx3eTBKmj2xeJkcFW3eMK41Qj5R8JcDixyE=
Subject: FAILED: patch "[PATCH] fprobe: Fix to ensure the number of active retprobes is not" failed to apply to 6.1-stable tree
To:     mhiramat@kernel.org, wuqiang.matt@bytedance.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 22:23:24 +0200
Message-ID: <2023102023-rubble-eggshell-ae24@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
git cherry-pick -x 700b2b439766e8aab8a7174991198497345bd411
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102023-rubble-eggshell-ae24@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 700b2b439766e8aab8a7174991198497345bd411 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Tue, 17 Oct 2023 08:49:45 +0900
Subject: [PATCH] fprobe: Fix to ensure the number of active retprobes is not
 zero

The number of active retprobes can be zero but it is not acceptable,
so return EINVAL error if detected.

Link: https://lore.kernel.org/all/169750018550.186853.11198884812017796410.stgit@devnote2/

Reported-by: wuqiang.matt <wuqiang.matt@bytedance.com>
Closes: https://lore.kernel.org/all/20231016222103.cb9f426edc60220eabd8aa6a@kernel.org/
Fixes: 5b0ab78998e3 ("fprobe: Add exit_handler support")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 3b21f4063258..881f90f0cbcf 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -189,7 +189,7 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 {
 	int i, size;
 
-	if (num < 0)
+	if (num <= 0)
 		return -EINVAL;
 
 	if (!fp->exit_handler) {
@@ -202,8 +202,8 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 		size = fp->nr_maxactive;
 	else
 		size = num * num_possible_cpus() * 2;
-	if (size < 0)
-		return -E2BIG;
+	if (size <= 0)
+		return -EINVAL;
 
 	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler);
 	if (!fp->rethook)

