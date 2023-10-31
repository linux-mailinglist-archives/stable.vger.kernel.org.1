Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0E57DD568
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjJaRua (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236433AbjJaRu3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:50:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD8DA2
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:50:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EF7C433C7;
        Tue, 31 Oct 2023 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774627;
        bh=4H1KD4EIJqyj4jWsfqDh//7hBjCmlLfxS6FDIihUkio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1NC+Izfmra6GPjr7mt3drKQ3ws+BRULq+YopPK0fK/UuLyVVSOY06z0XuK+duzo/
         IVvryb59bvMNQTHpORS575HadQSEmzPn+QVn+60v6+aDIeeWZMBGetxxmGj3+Boeg9
         KDkvlmBXvo4eNzn8lVO9jgm0wa0X3e95CME79vlQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.5 111/112] mm/damon/sysfs: check DAMOS regions update progress from before_terminate()
Date:   Tue, 31 Oct 2023 18:01:52 +0100
Message-ID: <20231031165904.762790861@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SeongJae Park <sj@kernel.org>

commit 76b7069bcc89dec33f03eb08abee165d0306b754 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/sysfs.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1202,6 +1202,8 @@ static int damon_sysfs_set_targets(struc
 	return 0;
 }
 
+static bool damon_sysfs_schemes_regions_updating;
+
 static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
@@ -1209,10 +1211,12 @@ static void damon_sysfs_before_terminate
 
 	/* damon_sysfs_schemes_update_regions_stop() might not yet called */
 	kdamond = damon_sysfs_cmd_request.kdamond;
-	if (kdamond && damon_sysfs_cmd_request.cmd ==
+	if (kdamond && (damon_sysfs_cmd_request.cmd ==
 			DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS &&
+			damon_sysfs_schemes_regions_updating) &&
 			ctx == kdamond->damon_ctx) {
 		damon_sysfs_schemes_update_regions_stop(ctx);
+		damon_sysfs_schemes_regions_updating = false;
 		mutex_unlock(&damon_sysfs_lock);
 	}
 
@@ -1331,7 +1335,6 @@ static int damon_sysfs_commit_input(stru
 static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 {
 	struct damon_sysfs_kdamond *kdamond;
-	static bool damon_sysfs_schemes_regions_updating;
 	int err = 0;
 
 	/* avoid deadlock due to concurrent state_store('off') */


