Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A253A7BEFFD
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 02:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379264AbjJJAxA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 20:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379217AbjJJAw7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 20:52:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7927E9E;
        Mon,  9 Oct 2023 17:52:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9924CC433C8;
        Tue, 10 Oct 2023 00:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696899178;
        bh=lWIJZFVAITmmAckP9ZBNoeV80iKH9hrKMtBD4bdfGUs=;
        h=Date:To:From:Subject:From;
        b=IjiilYUcVUzkpQs5VzMxaPgiJtWaPYTMefK56V9qshM+/oq/TQlraDG47fOlUknXo
         3nOH6YLfleQOGd6ZPS9wSt39BiPlnnnqRAwiYIG8nhN6TZ/bcnaZnMODHUax+a51Cj
         EMbpOg34HGPHNzwd55Jq3VnY+fE/A+5cwoge3TQU=
Date:   Mon, 09 Oct 2023 17:52:39 -0700
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org, sj@kernel.org,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-damon-sysfs-check-damos-regions-update-progress-from-before_terminate.patch added to mm-hotfixes-unstable branch
Message-Id: <20231010005256.9924CC433C8@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch titled
     Subject: mm/damon/sysfs: check DAMOS regions update progress from before_terminate()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-damon-sysfs-check-damos-regions-update-progress-from-before_terminate.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-damon-sysfs-check-damos-regions-update-progress-from-before_terminate.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: SeongJae Park <sj@kernel.org>
Subject: mm/damon/sysfs: check DAMOS regions update progress from before_terminate()
Date: Sat, 7 Oct 2023 20:04:32 +0000

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
---

 mm/damon/sysfs.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/mm/damon/sysfs.c~mm-damon-sysfs-check-damos-regions-update-progress-from-before_terminate
+++ a/mm/damon/sysfs.c
@@ -1208,6 +1208,8 @@ static int damon_sysfs_set_targets(struc
 	return 0;
 }
 
+static bool damon_sysfs_schemes_regions_updating;
+
 static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
@@ -1219,8 +1221,10 @@ static void damon_sysfs_before_terminate
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
 
@@ -1340,7 +1344,6 @@ static int damon_sysfs_commit_input(stru
 static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 {
 	struct damon_sysfs_kdamond *kdamond;
-	static bool damon_sysfs_schemes_regions_updating;
 	bool total_bytes_only = false;
 	int err = 0;
 
_

Patches currently in -mm which might be from sj@kernel.org are

mm-damon-sysfs-check-damos-regions-update-progress-from-before_terminate.patch

