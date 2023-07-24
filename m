Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6271275EB5F
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 08:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjGXGSo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 02:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjGXGSo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 02:18:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6300BE4E
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 23:18:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3CA260EE2
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 06:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B279C433C7;
        Mon, 24 Jul 2023 06:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690179520;
        bh=5kqaOIA3G8uM2YXMBZAwjO6gK0M3KScMm6auNDE6XGs=;
        h=Subject:To:Cc:From:Date:From;
        b=PI5690ctgUfB1HdTiyJb4cTrj0PgxGTqbxMP5aGHeZHqZo6gbURXCnNGWDO7H9Lby
         fY9YXOZ84AeM+ohG93Fquwak3PNzhvJ92MEQWxSjO7aV5EP2cabvbYEJSdKNSKatu3
         5Syi76FNhlibqKvHl8o0+Hp0bg96pOSONSwIWdnw=
Subject: FAILED: patch "[PATCH] ext4: fix off by one issue in" failed to apply to 4.19-stable tree
To:     ojaswin@linux.ibm.com, tytso@mit.edu
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 24 Jul 2023 08:18:34 +0200
Message-ID: <2023072434-stylist-reflex-c474@gregkh>
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


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 5d5460fa7932bed3a9082a6a8852cfbdb46acbe8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072434-stylist-reflex-c474@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

5d5460fa7932 ("ext4: fix off by one issue in ext4_mb_choose_next_group_best_avail()")
f52f3d2b9fba ("ext4: Give symbolic names to mballoc criterias")
7e170922f06b ("ext4: Add allocation criteria 1.5 (CR1_5)")
1b4200112108 ("ext4: Avoid scanning smaller extents in BG during CR1")
3ef5d2638796 ("ext4: Add counter to track successful allocation of goal length")
fdd9a00943a5 ("ext4: Add per CR extent scanned counter")
4eb7a4a1a33b ("ext4: Convert mballoc cr (criteria) to enum")
c3defd99d58c ("ext4: treat stripe in block unit")
361eb69fc99f ("ext4: Remove the logic to trim inode PAs")
3872778664e3 ("ext4: Use rbtrees to manage PAs instead of inode i_prealloc_list")
a8e38fd37cff ("ext4: Convert pa->pa_inode_list and pa->pa_obj_lock into a union")
93cdf49f6eca ("ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()")
0830344c953a ("ext4: Abstract out overlap fix/check logic in ext4_mb_normalize_request()")
7692094ac513 ("ext4: Move overlap assert logic into a separate function")
bcf434992145 ("ext4: Refactor code in ext4_mb_normalize_request() and ext4_mb_use_preallocated()")
e86a718228b6 ("ext4: Stop searching if PA doesn't satisfy non-extent file")
91a48aaf59d0 ("ext4: avoid unnecessary pointer dereference in ext4_mb_normalize_request")
83e80a6e3543 ("ext4: use buckets for cr 1 block scan instead of rbtree")
4fca50d440cc ("ext4: make mballoc try target group first even with mb_optimize_scan")
cf4ff938b47f ("ext4: correct the judgment of BUG in ext4_mb_normalize_request")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5d5460fa7932bed3a9082a6a8852cfbdb46acbe8 Mon Sep 17 00:00:00 2001
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Date: Fri, 9 Jun 2023 16:04:03 +0530
Subject: [PATCH] ext4: fix off by one issue in
 ext4_mb_choose_next_group_best_avail()

In ext4_mb_choose_next_group_best_avail(), we want the start order to be
1 less than goal length and the min_order to be, at max, 1 more than the
original length. This commit fixes an off by one issue that arose due to
the fact that 1 << fls(n) > (n).

After all the processing:

order = 1 order below goal len
min_order = maximum of the three:-
             - order - trim_order
             - 1 order below B2C(s_stripe)
             - 1 order above original len

Cc: stable@kernel.org
Fixes: 33122aa930 ("ext4: Add allocation criteria 1.5 (CR1_5)")
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://lore.kernel.org/r/20230609103403.112807-1-ojaswin@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a2475b8c9fb5..456150ef6111 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1006,14 +1006,11 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
 	 * fls() instead since we need to know the actual length while modifying
 	 * goal length.
 	 */
-	order = fls(ac->ac_g_ex.fe_len);
+	order = fls(ac->ac_g_ex.fe_len) - 1;
 	min_order = order - sbi->s_mb_best_avail_max_trim_order;
 	if (min_order < 0)
 		min_order = 0;
 
-	if (1 << min_order < ac->ac_o_ex.fe_len)
-		min_order = fls(ac->ac_o_ex.fe_len) + 1;
-
 	if (sbi->s_stripe > 0) {
 		/*
 		 * We are assuming that stripe size is always a multiple of
@@ -1021,9 +1018,16 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
 		 */
 		num_stripe_clusters = EXT4_NUM_B2C(sbi, sbi->s_stripe);
 		if (1 << min_order < num_stripe_clusters)
-			min_order = fls(num_stripe_clusters);
+			/*
+			 * We consider 1 order less because later we round
+			 * up the goal len to num_stripe_clusters
+			 */
+			min_order = fls(num_stripe_clusters) - 1;
 	}
 
+	if (1 << min_order < ac->ac_o_ex.fe_len)
+		min_order = fls(ac->ac_o_ex.fe_len);
+
 	for (i = order; i >= min_order; i--) {
 		int frag_order;
 		/*

