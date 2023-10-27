Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40317D977A
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 14:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345799AbjJ0MOX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 08:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345739AbjJ0MOW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 08:14:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CACFA
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 05:14:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216A7C433C7;
        Fri, 27 Oct 2023 12:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698408859;
        bh=GVFWjVm2GdRjjpjb6vmgrAn9sWxqUA18pg1pPq45qQ0=;
        h=Subject:To:Cc:From:Date:From;
        b=cpN1tkPOQEEx9zVcNCjqH+mm79CDlLmM0izWTDS18sYcQ11t5dPIpASPL1Bi1tJ5O
         PTZESDwHZThNtRWu1aFFVtdDIF3FkxIWvUSTYntYLLo7vnWEhEQCv3PwcjDSZEghAY
         hrJDXpRCoH6kCw4f+tFpa25IlkJa1tiFGNffkxG4=
Subject: FAILED: patch "[PATCH] mm/damon/sysfs: check DAMOS regions update progress from" failed to apply to 6.5-stable tree
To:     sj@kernel.org, akpm@linux-foundation.org, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 27 Oct 2023 14:14:16 +0200
Message-ID: <2023102716-prudishly-reggae-1b29@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 76b7069bcc89dec33f03eb08abee165d0306b754
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102716-prudishly-reggae-1b29@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 76b7069bcc89dec33f03eb08abee165d0306b754 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 7 Oct 2023 20:04:32 +0000
Subject: [PATCH] mm/damon/sysfs: check DAMOS regions update progress from
 before_terminate()

DAMON_SYSFS can receive DAMOS tried regions update request while kdamond
is already out of the main loop and before_terminate callback
(damon_sysfs_before_terminate() in this case) is not yet called.  And
damon_sysfs_handle_cmd() can further be finished before the callback is
invoked.  Then, damon_sysfs_before_terminate() unlocks damon_sysfs_lock,
which is not locked by anyone.  This happens because the callback function
assumes damon_sysfs_cmd_request_callback() should be called before it.
Check if the assumption was true before doing the unlock, to avoid this
problem.

Link: https://lkml.kernel.org/r/20231007200432.3110-1-sj@kernel.org
Fixes: f1d13cacabe1 ("mm/damon/sysfs: implement DAMOS tried regions update command")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>	[6.2.x]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b86ba7b0a921..f60e56150feb 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1208,6 +1208,8 @@ static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 	return 0;
 }
 
+static bool damon_sysfs_schemes_regions_updating;
+
 static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
@@ -1219,8 +1221,10 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 	cmd = damon_sysfs_cmd_request.cmd;
 	if (kdamond && ctx == kdamond->damon_ctx &&
 			(cmd == DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS ||
-			 cmd == DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES)) {
+			 cmd == DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES) &&
+			damon_sysfs_schemes_regions_updating) {
 		damon_sysfs_schemes_update_regions_stop(ctx);
+		damon_sysfs_schemes_regions_updating = false;
 		mutex_unlock(&damon_sysfs_lock);
 	}
 
@@ -1340,7 +1344,6 @@ static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
 static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 {
 	struct damon_sysfs_kdamond *kdamond;
-	static bool damon_sysfs_schemes_regions_updating;
 	bool total_bytes_only = false;
 	int err = 0;
 

