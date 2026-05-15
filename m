Return-Path: <stable+bounces-247739-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGaUEMQTB2rgrQIAu9opvQ
	(envelope-from <stable+bounces-247739-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:38:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A486054FB46
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F89830DDD3A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35C347D948;
	Fri, 15 May 2026 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lhlyflm4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6F947ECD0
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847331; cv=none; b=oA3iCqDKsMaIaZ23QvKeIDQ1WdR7GSd08XKoFoaTDk9Ue2iNlBdhcIVvEAA/YcWQ5enu6KVd1U0lWDeD46wxw4NeNDYjrNZPrYvekRIrENEZB8pOCpzL226AgPdvquvevsmThBRFKFKx5gc79152wWKIDRq1945YMSZ6UBMwQNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847331; c=relaxed/simple;
	bh=UtaIFRI3aWnYM0U65Zw5vkrDA/YM4S6SIsKkmWeOOLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZj6oj1WBPHUHyaW9njAvXXtwm1KHZGigWnkpFrsKLyiX1/qBDd8P4Gmx6aeOCxG6e3HvH/cNRkCAFHB3qcPora1HDEq/CyukWp2P5G7Tu+j74mAnhu1ldNgY9gwinMNufN2vSkNQwovrzM5Tot+PPcHXw+e5zLFEeRgFfY8OZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lhlyflm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29C2C2BCB7;
	Fri, 15 May 2026 12:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778847330;
	bh=UtaIFRI3aWnYM0U65Zw5vkrDA/YM4S6SIsKkmWeOOLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lhlyflm4mgbMTnn+vnn2wy4iWRTkuIiLZfsJ9dQ/pMDmYBM0+A+MNedrid/YFlbre
	 DBsNqwtc/K1U05g702sHJtQMvwRn6Hqy9ncVQ90zLiQ2X5wSpcapAWIsr92yrG+qj+
	 ITmlqTHLDoN3BIXs9E7v0VPWmEOj2/s9HfSqsLrt9YdL9SvCf7GmeCvmDs5XgGDEsU
	 fD3yMkuIHLKEInNXCLqsfVIroYUou71UzIDE9WpRp9xgjYSrzY0+RDNo2ZA3sL1qaP
	 s7GnKt2tuaTnFZ7PkDsMH9cAVLl0kxIPziLwsgUthjMxEqEY1ZKFtDp7HeIVS/jcMN
	 puJzA7bEhnHxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] btrfs: remove fs_info argument from btrfs_sysfs_add_space_info_type()
Date: Fri, 15 May 2026 08:15:27 -0400
Message-ID: <20260515121528.3130102-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051235-rockband-barrel-a707@gregkh>
References: <2026051235-rockband-barrel-a707@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A486054FB46
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247739-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 771af6ff72e0ed0eb8bf97e5ae4fa5094e0c5d1d ]

We don't need it since we can grab fs_info from the given space_info.
So remove the fs_info argument.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: a7449edf9614 ("btrfs: fix double free in create_space_info_sub_group() error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/space-info.c | 4 ++--
 fs/btrfs/sysfs.c      | 5 ++---
 fs/btrfs/sysfs.h      | 3 +--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 7da0e739762af..d059bf5eaa098 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -265,7 +265,7 @@ static int create_space_info_sub_group(struct btrfs_space_info *parent, u64 flag
 	sub_group->parent = parent;
 	sub_group->subgroup_id = id;
 
-	ret = btrfs_sysfs_add_space_info_type(fs_info, sub_group);
+	ret = btrfs_sysfs_add_space_info_type(sub_group);
 	if (ret) {
 		kfree(sub_group);
 		parent->sub_group[index] = NULL;
@@ -294,7 +294,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 			goto out_free;
 	}
 
-	ret = btrfs_sysfs_add_space_info_type(info, space_info);
+	ret = btrfs_sysfs_add_space_info_type(space_info);
 	if (ret)
 		return ret;
 
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index ea13e3eee7d90..8f195e769ecf0 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1825,13 +1825,12 @@ static const char *alloc_name(struct btrfs_space_info *space_info)
  * Create a sysfs entry for a space info type at path
  * /sys/fs/btrfs/UUID/allocation/TYPE
  */
-int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *space_info)
+int btrfs_sysfs_add_space_info_type(struct btrfs_space_info *space_info)
 {
 	int ret;
 
 	ret = kobject_init_and_add(&space_info->kobj, &space_info_ktype,
-				   fs_info->space_info_kobj, "%s",
+				   space_info->fs_info->space_info_kobj, "%s",
 				   alloc_name(space_info));
 	if (ret) {
 		kobject_put(&space_info->kobj);
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index e6a284c59809c..ec834a4af2e5d 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -36,8 +36,7 @@ void __cold btrfs_exit_sysfs(void);
 int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info);
 void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info);
 void btrfs_sysfs_add_block_group_type(struct btrfs_block_group *cache);
-int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *space_info);
+int btrfs_sysfs_add_space_info_type(struct btrfs_space_info *space_info);
 void btrfs_sysfs_remove_space_info(struct btrfs_space_info *space_info);
 void btrfs_sysfs_update_devid(struct btrfs_device *device);
 
-- 
2.53.0


