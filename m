Return-Path: <stable+bounces-217986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLIjLBUcnmntTQQAu9opvQ
	(envelope-from <stable+bounces-217986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 22:45:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DA518CECB
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 22:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 222823042270
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 21:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83E933C511;
	Tue, 24 Feb 2026 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RjfL5p6P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B0F284894
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771969550; cv=none; b=ldeNBcgg6nj/zpZOdgBoiwgE5eMryyKPnX/E0fUcRwhvv/vrxJG/IyB3QzwbliNeUnAGRwpUWi/rE9r92pd5YpEgJMauZp2cG/Tx7I6ma2AqqlXP8B88HgqkVHSFWpXNfWf18uP8tE6xqybvBTUSre5NfNR7T/tKpxDzs06EN1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771969550; c=relaxed/simple;
	bh=6l06Bg79uqCzFIjSlG74PD7ilWQKV+hBBgUlHOL7Nb4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P4p8Q5gSkEi0+7kxja1zetkzt8oI9bTg9zdRxhpmVTeJ341Z5vMCh8+0S9zJ7lpQtI7TAuLPvw8oH70Knzz/6gElBig+AGt1zMhqahyVEoBLM3Rc/NAaahwedjWp4s8Pxo0hdvtMIv+bOnoqqKqgj2mNU9K1KS+9UMJJmS2L4Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RjfL5p6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661E3C116D0;
	Tue, 24 Feb 2026 21:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771969550;
	bh=6l06Bg79uqCzFIjSlG74PD7ilWQKV+hBBgUlHOL7Nb4=;
	h=Subject:To:Cc:From:Date:From;
	b=RjfL5p6PgC5Q16KgRBIfqsUrmqgNvivmlPqXn4ILn7rrAybdfj30S6XHPmHTfotpK
	 t8ayHfhPe8zEIvRY+1kwiXlNaNqpoEF1qJuJl4uLQYeVCq2t4PcaTRl1qsr6Oq+Ul6
	 De9XCkXHa/rDtRXT04LMlcBLvp7iGs1cmoIXMEMI=
Subject: FAILED: patch "[PATCH] ext4: always allocate blocks only from groups inode can use" failed to apply to 5.10-stable tree
To: jack@suse.cz,libaokun1@huawei.com,pfalcato@suse.de,tytso@mit.edu,yi.zhang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Feb 2026 13:45:37 -0800
Message-ID: <2026022437-selector-book-ca29@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217986-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,msgid.link:url,gregkh:email,huawei.com:email]
X-Rspamd-Queue-Id: 26DA518CECB
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4865c768b563deff1b6a6384e74a62f143427b42
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026022437-selector-book-ca29@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4865c768b563deff1b6a6384e74a62f143427b42 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 14 Jan 2026 19:28:18 +0100
Subject: [PATCH] ext4: always allocate blocks only from groups inode can use

For filesystems with more than 2^32 blocks inodes using indirect block
based format cannot use blocks beyond the 32-bit limit.
ext4_mb_scan_groups_linear() takes care to not select these unsupported
groups for such inodes however other functions selecting groups for
allocation don't. So far this is harmless because the other selection
functions are used only with mb_optimize_scan and this is currently
disabled for inodes with indirect blocks however in the following patch
we want to enable mb_optimize_scan regardless of inode format.

Reviewed-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Acked-by: Pedro Falcato <pfalcato@suse.de>
Cc: stable@kernel.org
Link: https://patch.msgid.link/20260114182836.14120-3-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index dd29558ad753..910b454b4a21 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -892,6 +892,21 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
 	}
 }
 
+static ext4_group_t ext4_get_allocation_groups_count(
+				struct ext4_allocation_context *ac)
+{
+	ext4_group_t ngroups = ext4_get_groups_count(ac->ac_sb);
+
+	/* non-extent files are limited to low blocks/groups */
+	if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)))
+		ngroups = EXT4_SB(ac->ac_sb)->s_blockfile_groups;
+
+	/* Pairs with smp_wmb() in ext4_update_super() */
+	smp_rmb();
+
+	return ngroups;
+}
+
 static int ext4_mb_scan_groups_xa_range(struct ext4_allocation_context *ac,
 					struct xarray *xa,
 					ext4_group_t start, ext4_group_t end)
@@ -899,7 +914,7 @@ static int ext4_mb_scan_groups_xa_range(struct ext4_allocation_context *ac,
 	struct super_block *sb = ac->ac_sb;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	enum criteria cr = ac->ac_criteria;
-	ext4_group_t ngroups = ext4_get_groups_count(sb);
+	ext4_group_t ngroups = ext4_get_allocation_groups_count(ac);
 	unsigned long group = start;
 	struct ext4_group_info *grp;
 
@@ -951,7 +966,7 @@ static int ext4_mb_scan_groups_p2_aligned(struct ext4_allocation_context *ac,
 	ext4_group_t start, end;
 
 	start = group;
-	end = ext4_get_groups_count(ac->ac_sb);
+	end = ext4_get_allocation_groups_count(ac);
 wrap_around:
 	for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
 		ret = ext4_mb_scan_groups_largest_free_order_range(ac, i,
@@ -1001,7 +1016,7 @@ static int ext4_mb_scan_groups_goal_fast(struct ext4_allocation_context *ac,
 	ext4_group_t start, end;
 
 	start = group;
-	end = ext4_get_groups_count(ac->ac_sb);
+	end = ext4_get_allocation_groups_count(ac);
 wrap_around:
 	i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
 	for (; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
@@ -1083,7 +1098,7 @@ static int ext4_mb_scan_groups_best_avail(struct ext4_allocation_context *ac,
 		min_order = fls(ac->ac_o_ex.fe_len);
 
 	start = group;
-	end = ext4_get_groups_count(ac->ac_sb);
+	end = ext4_get_allocation_groups_count(ac);
 wrap_around:
 	for (i = order; i >= min_order; i--) {
 		int frag_order;
@@ -1182,11 +1197,7 @@ static int ext4_mb_scan_groups(struct ext4_allocation_context *ac)
 	int ret = 0;
 	ext4_group_t start;
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
-	ext4_group_t ngroups = ext4_get_groups_count(ac->ac_sb);
-
-	/* non-extent files are limited to low blocks/groups */
-	if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)))
-		ngroups = sbi->s_blockfile_groups;
+	ext4_group_t ngroups = ext4_get_allocation_groups_count(ac);
 
 	/* searching for the right group start from the goal value specified */
 	start = ac->ac_g_ex.fe_group;


