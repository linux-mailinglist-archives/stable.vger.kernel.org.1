Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CF670C648
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbjEVTQa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjEVTQH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:16:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC847E54
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:16:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C21E62710
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65053C433D2;
        Mon, 22 May 2023 19:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684782960;
        bh=iqEGhcmnC9N81FJnowv8a1aG1lQGPLyxF963jezKm6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pcakH2w1eXk9MJI1c0O4fsUD7NIoAPdjUL9tV3tgkc1NKhqXE1oCURanCQKL8uf4y
         MXGPIhtqcFx57o9OjlOkcHd8Z/EEs8UhkW/5K9VuBNg6iElPALmYRQZmV50IU3KHHG
         DQJPR6IMNk3yy1UUqulBEp0LT0T0tyN4CJ+tQ8hs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jan Kara <jack@suse.cz>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 063/203] ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()
Date:   Mon, 22 May 2023 20:08:07 +0100
Message-Id: <20230522190356.736796199@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

[ Upstream commit 93cdf49f6eca5e23f6546b8f28457b2e6a6961d9 ]

When the length of best extent found is less than the length of goal extent
we need to make sure that the best extent atleast covers the start of the
original request. This is done by adjusting the ac_b_ex.fe_logical (logical
start) of the extent.

While doing so, the current logic sometimes results in the best extent's
logical range overflowing the goal extent. Since this best extent is later
added to the inode preallocation list, we have a possibility of introducing
overlapping preallocations. This is discussed in detail here [1].

As per Jan's suggestion, to fix this, replace the existing logic with the
below logic for adjusting best extent as it keeps fragmentation in check
while ensuring logical range of best extent doesn't overflow out of goal
extent:

1. Check if best extent can be kept at end of goal range and still cover
   original start.
2. Else, check if best extent can be kept at start of goal range and still
   cover original start.
3. Else, keep the best extent at start of original request.

Also, add a few extra BUG_ONs that might help catch errors faster.

[1] https://lore.kernel.org/r/Y+OGkVvzPN0RMv0O@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/f96aca6d415b36d1f90db86c1a8cd7e2e9d7ab0e.1679731817.git.ojaswin@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 49 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index de51963c701f7..e8f5f05bddb3f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4333,6 +4333,7 @@ static void ext4_mb_use_inode_pa(struct ext4_allocation_context *ac,
 	BUG_ON(start < pa->pa_pstart);
 	BUG_ON(end > pa->pa_pstart + EXT4_C2B(sbi, pa->pa_len));
 	BUG_ON(pa->pa_free < len);
+	BUG_ON(ac->ac_b_ex.fe_len <= 0);
 	pa->pa_free -= len;
 
 	mb_debug(ac->ac_sb, "use %llu/%d from inode pa %p\n", start, len, pa);
@@ -4662,10 +4663,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 	pa = ac->ac_pa;
 
 	if (ac->ac_b_ex.fe_len < ac->ac_g_ex.fe_len) {
-		int winl;
-		int wins;
-		int win;
-		int offs;
+		int new_bex_start;
+		int new_bex_end;
 
 		/* we can't allocate as much as normalizer wants.
 		 * so, found space must get proper lstart
@@ -4673,26 +4672,40 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		BUG_ON(ac->ac_g_ex.fe_logical > ac->ac_o_ex.fe_logical);
 		BUG_ON(ac->ac_g_ex.fe_len < ac->ac_o_ex.fe_len);
 
-		/* we're limited by original request in that
-		 * logical block must be covered any way
-		 * winl is window we can move our chunk within */
-		winl = ac->ac_o_ex.fe_logical - ac->ac_g_ex.fe_logical;
+		/*
+		 * Use the below logic for adjusting best extent as it keeps
+		 * fragmentation in check while ensuring logical range of best
+		 * extent doesn't overflow out of goal extent:
+		 *
+		 * 1. Check if best ex can be kept at end of goal and still
+		 *    cover original start
+		 * 2. Else, check if best ex can be kept at start of goal and
+		 *    still cover original start
+		 * 3. Else, keep the best ex at start of original request.
+		 */
+		new_bex_end = ac->ac_g_ex.fe_logical +
+			EXT4_C2B(sbi, ac->ac_g_ex.fe_len);
+		new_bex_start = new_bex_end - EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
+		if (ac->ac_o_ex.fe_logical >= new_bex_start)
+			goto adjust_bex;
 
-		/* also, we should cover whole original request */
-		wins = EXT4_C2B(sbi, ac->ac_b_ex.fe_len - ac->ac_o_ex.fe_len);
+		new_bex_start = ac->ac_g_ex.fe_logical;
+		new_bex_end =
+			new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
+		if (ac->ac_o_ex.fe_logical < new_bex_end)
+			goto adjust_bex;
 
-		/* the smallest one defines real window */
-		win = min(winl, wins);
+		new_bex_start = ac->ac_o_ex.fe_logical;
+		new_bex_end =
+			new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
 
-		offs = ac->ac_o_ex.fe_logical %
-			EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
-		if (offs && offs < win)
-			win = offs;
+adjust_bex:
+		ac->ac_b_ex.fe_logical = new_bex_start;
 
-		ac->ac_b_ex.fe_logical = ac->ac_o_ex.fe_logical -
-			EXT4_NUM_B2C(sbi, win);
 		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
 		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
+		BUG_ON(new_bex_end > (ac->ac_g_ex.fe_logical +
+				      EXT4_C2B(sbi, ac->ac_g_ex.fe_len)));
 	}
 
 	/* preallocation can change ac_b_ex, thus we store actually
-- 
2.39.2



