Return-Path: <stable+bounces-219686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDMMOU08n2kiZgQAu9opvQ
	(envelope-from <stable+bounces-219686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 19:15:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB8919C1A1
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 19:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9B57300617A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 18:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7E020DD52;
	Wed, 25 Feb 2026 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3EvvTqQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF06014A8E
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043338; cv=none; b=TbSmJUBh/fqRgKexnhxGvomCwhWQgIc09GT2Vv5XXbUJMtcg9KioXUlZsuv+Cn3ghUXM2I4TAPXINlPNUz5O1T4vaO6wVLYFH/eaU9KXwHwVjfGxKh0fjRjpOIdbaFvO4eMzWgFmp47iCy7B7Zm2xLUQQA7tGC82TAw6m4Y/GGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043338; c=relaxed/simple;
	bh=gPVJB1xaAGq4mOg+yofzGvCAfFfANZ6ZS2PZvoeq1I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSKq0cet0rFuz4JIktqy1h1uffmBbP40w0Zh/1sge6YqVxAZK6+0fuDih10vQ0sVaRVKMDLyr9cHk3jPOOpjeTfmLVmFD1Efz0yysm97/sQXY5pSsqKFU93cYMHaIcJmAimV8o7LpT+ZBHMWxiPKOCngznynsLF+ZMPZzHPldPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3EvvTqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DADC116D0;
	Wed, 25 Feb 2026 18:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772043338;
	bh=gPVJB1xaAGq4mOg+yofzGvCAfFfANZ6ZS2PZvoeq1I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y3EvvTqQdYuypBNqal4CE+jOnAJSM+gUC4QYt2T0dWunDgtOAEmNEnHVZMUBKX2nh
	 wKlTN23O4uEKl7x5ikRAUWa+m85pyFsyvbM3pdLqjHHobOgU6vCa9A5Q2a4sMTv9kq
	 ZU2YtXvcth/WeGuzwtB1VvmRr53wgUoelMEoQ9BeAqm4r4n6VgTc4O7opZ/itmoExy
	 obUs9U36L3hffvBziLnKYXFqYrGv5JieL+HQguL5louNx0FVOKpK9ittCyCkH5slyd
	 vJ0qOyYzhj7kP+hpnWlMlcG1lzt0gms5oPfgMWWi8KHIzT3/cHTKbDO7fyVcQeiNWi
	 /PEf4I66Gzu9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun1@huawei.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Pedro Falcato <pfalcato@suse.de>,
	stable@kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ext4: always allocate blocks only from groups inode can use
Date: Wed, 25 Feb 2026 13:15:35 -0500
Message-ID: <20260225181535.912817-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026022434-hazelnut-twistable-eb07@gregkh>
References: <2026022434-hazelnut-twistable-eb07@gregkh>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219686-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,msgid.link:url,suse.cz:email,huawei.com:email]
X-Rspamd-Queue-Id: 4DB8919C1A1
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
index 5ba161bd66a3e..44a16895f76a2 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -883,6 +883,21 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
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
@@ -2816,10 +2831,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
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


