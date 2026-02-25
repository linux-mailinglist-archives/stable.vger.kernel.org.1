Return-Path: <stable+bounces-219696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLegFDxQn2k7aAQAu9opvQ
	(envelope-from <stable+bounces-219696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 20:40:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 478DE19CC9A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 20:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C593300E6AD
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 19:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1143EDAD6;
	Wed, 25 Feb 2026 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDTzxMJi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC6D3D668E
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048437; cv=none; b=Q6bMTsC54XOz/7XSkEobb0+u7epseXT4F6EAhTI/khTPVSuz2XLYOPwould64a5tLp8zieV17l6asikdRnrUNx1qOmvpRtuGfGdYZBvf0Mt0hTAcr+W3Cu7WMm6S69kYUYgBaf5hGPub5S+UbdujXrbj3guud4xzvrajMru+IPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048437; c=relaxed/simple;
	bh=m+6R/gAaY4MtcfPJaKxphqfAl397ASBmd/12bikQzS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rI2jeAuBsEqUqMP4NDJsusI5IEvrt6C2UYRmWrEldF+ioKrjgWEfOCkYXwMHn/M9U+CVQd97VaY+rN81yiC0WQal7Nv50AJwB32kNyp/GIXh0EXzbzNYNw/JbjZXMihfouUnlhEvlW32KPjpoNGf7vM99ls4axYl1NE1QxWc8xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDTzxMJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CA9C19421;
	Wed, 25 Feb 2026 19:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772048436;
	bh=m+6R/gAaY4MtcfPJaKxphqfAl397ASBmd/12bikQzS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sDTzxMJigtYaSgPRdI60wuZagUamXYyvQ2hbLB5bk1+7oGdoHRZf/UpItQGB6JjLU
	 PJDxjpdGL1BZIPPE+/bgfTe35Gk6HfEs9vTmzDc6fdM58oxPPtHJDAa3sDRL7IfmPz
	 ahnLxkxSIH0kSAO+uEV1e/3hDjobMfvUjmb3ka3qCSWNBqH6VtDIDIgLc2pSA6jHeI
	 57c78/9zG8moN3/jm1ZBMGlr8FreOzccgEfhO10fdTmgAfKIkajjIHrodxLxPN9mmA
	 YcATL9ILRFY+R4LJcCopdH89bR8SBttk+b0RPbgK5SZgzPgZ8ndxxDJU0IjWjimKJ6
	 ATUFr+MLetdBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun1@huawei.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Pedro Falcato <pfalcato@suse.de>,
	stable@kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ext4: always allocate blocks only from groups inode can use
Date: Wed, 25 Feb 2026 14:40:32 -0500
Message-ID: <20260225194032.1016421-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026022435-designer-unmoral-b6e7@gregkh>
References: <2026022435-designer-unmoral-b6e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219696-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 478DE19CC9A
X-Rspamd-Action: no action

From: Jan Kara <jack@suse.cz>

[ Upstream commit 4865c768b563deff1b6a6384e74a62f143427b42 ]

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
[ Drop a few hunks not needed in older trees ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index da0c63897190b..7a6b8a6bd10bc 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -871,6 +871,21 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
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
 /*
  * Choose next group by traversing largest_free_order lists. Updates *new_cr if
  * cr level needs an update.
@@ -2658,10 +2673,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
 	sb = ac->ac_sb;
 	sbi = EXT4_SB(sb);
-	ngroups = ext4_get_groups_count(sb);
-	/* non-extent files are limited to low blocks/groups */
-	if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)))
-		ngroups = sbi->s_blockfile_groups;
+	ngroups = ext4_get_allocation_groups_count(ac);
 
 	BUG_ON(ac->ac_status == AC_STATUS_FOUND);
 
-- 
2.51.0


