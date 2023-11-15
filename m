Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1807ECFFB
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbjKOTwF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbjKOTwE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:52:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A41C2
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:52:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD80C433CA;
        Wed, 15 Nov 2023 19:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077921;
        bh=/62rK45NygKJex226Q1ECYmBDdrvoU660QIPeh6Aobk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q36LG+cJj9NMU0TGVZk3S5jEO6awM8BzpyIMcF32bSipyRoMT+trVeUIxbS2RHJQf
         mkzhB0mzakB7iAS5xqyLrOvu/ccroFf1+lS5x8UQaCQ3YtHQGH86oFfgZThRrEJDgv
         zJae5Pk7+HFVhxg+Q9dEwBdqisyXv4IUoA2g/iBg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 603/603] btrfs: make found_logical_ret parameter mandatory for function queue_scrub_stripe()
Date:   Wed, 15 Nov 2023 14:19:08 -0500
Message-ID: <20231115191652.738588225@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 47e2b06b7b5cb356a987ba3429550c3a89ea89d6 ]

[BUG]
There is a compilation warning reported on commit ae76d8e3e135 ("btrfs:
scrub: fix grouping of read IO"), where gcc (14.0.0 20231022 experimental)
is reporting the following uninitialized variable:

  fs/btrfs/scrub.c: In function ‘scrub_simple_mirror.isra’:
  fs/btrfs/scrub.c:2075:29: error: ‘found_logical’ may be used uninitialized [-Werror=maybe-uninitialized[https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wmaybe-uninitialized]]
   2075 |                 cur_logical = found_logical + BTRFS_STRIPE_LEN;
  fs/btrfs/scrub.c:2040:21: note: ‘found_logical’ was declared here
   2040 |                 u64 found_logical;
        |                     ^~~~~~~~~~~~~

[CAUSE]
This is a false alert, as @found_logical is passed as parameter
@found_logical_ret of function queue_scrub_stripe().

As long as queue_scrub_stripe() returned 0, we would update
@found_logical_ret.  And if queue_scrub_stripe() returned >0 or <0, the
caller would not utilized @found_logical, thus there should be nothing
wrong.

Although the triggering gcc is still experimental, it looks like the
extra check on "if (found_logical_ret)" can sometimes confuse the
compiler.

Meanwhile the only caller of queue_scrub_stripe() is always passing a
valid pointer, there is no need for such check at all.

[FIX]
Although the report itself is a false alert, we can still make it more
explicit by:

- Replace the check for @found_logical_ret with ASSERT()

- Initialize @found_logical to U64_MAX

- Add one extra ASSERT() to make sure @found_logical got updated

Link: https://lore.kernel.org/linux-btrfs/87fs1x1p93.fsf@gentoo.org/
Fixes: ae76d8e3e135 ("btrfs: scrub: fix grouping of read IO")
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/scrub.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index b877203f1dc5a..4445a52a07076 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1798,6 +1798,9 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
 	 */
 	ASSERT(sctx->cur_stripe < SCRUB_TOTAL_STRIPES);
 
+	/* @found_logical_ret must be specified. */
+	ASSERT(found_logical_ret);
+
 	stripe = &sctx->stripes[sctx->cur_stripe];
 	scrub_reset_stripe(stripe);
 	ret = scrub_find_fill_first_stripe(bg, &sctx->extent_path,
@@ -1806,8 +1809,7 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
 	/* Either >0 as no more extents or <0 for error. */
 	if (ret)
 		return ret;
-	if (found_logical_ret)
-		*found_logical_ret = stripe->logical;
+	*found_logical_ret = stripe->logical;
 	sctx->cur_stripe++;
 
 	/* We filled one group, submit it. */
@@ -2010,7 +2012,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 
 	/* Go through each extent items inside the logical range */
 	while (cur_logical < logical_end) {
-		u64 found_logical;
+		u64 found_logical = U64_MAX;
 		u64 cur_physical = physical + cur_logical - logical_start;
 
 		/* Canceled? */
@@ -2045,6 +2047,8 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 		if (ret < 0)
 			break;
 
+		/* queue_scrub_stripe() returned 0, @found_logical must be updated. */
+		ASSERT(found_logical != U64_MAX);
 		cur_logical = found_logical + BTRFS_STRIPE_LEN;
 
 		/* Don't hold CPU for too long time */
-- 
2.42.0



