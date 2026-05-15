Return-Path: <stable+bounces-247796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJONGskyB2pktAIAu9opvQ
	(envelope-from <stable+bounces-247796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:50:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E80551B03
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB00F303D4EC
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A102DFF04;
	Fri, 15 May 2026 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMDqc15y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7867D21018A
	for <stable@vger.kernel.org>; Fri, 15 May 2026 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778856503; cv=none; b=txaaz3kcGAcHAdYP3tGJqNhdxUbck+VKQVyTnAs4r0I9ryaJ99lMjAl11ShlhlqqyOJRlyERf/6k83H0U4qYytSwrMGekOT2MXQXAUnfkJr81CJz43Z2hZsqJjYednr/VujHBV7Hpa1nCZFcs2vfyukElg2+opkiLwDCdxWHcMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778856503; c=relaxed/simple;
	bh=3MSnHW46LOfwscS3cUUT9HgHCMBu3eub42uafQzQ0eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUQwDWeEh35Mv+0w5dCaE/3LM1KOIfgeB+nSdGseGem+mrry4vQVgB0Ul+VkJLVUGST9jpRgOQWktEpWvR9E9ZLjs3ZiO5Rz5x20dBn1jtQGXandFg7iWJrR4yZ+b/jpRXlgt6iOOe9g4Wg9a8/E+VnrNAjXAAGpuDipQras+AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMDqc15y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64501C2BCB0;
	Fri, 15 May 2026 14:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778856503;
	bh=3MSnHW46LOfwscS3cUUT9HgHCMBu3eub42uafQzQ0eA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BMDqc15yjYv/JOnEB/xt9lXVU63rsspFn0TbH2A0BMf9kUUbjNLw26yUt3UOCelqd
	 V0HikAURTYY/EQwF9AcAb9HoEqmZZz9rG2gCByj88QupBtfsbFYHXg6T+sH4HUW9Sr
	 PDdVx23y5oSntW7NsQjNnBZGSQsMR4zDN9kXZi0hx/GkFSuEDlTV96n8z956x59hOu
	 GNBsbekdGUEJk7BcgbzryF37nfBdN0UF3hMHB8MR5mphVJa6ZG8AB1YIZOe69T0x78
	 p6TPLahI1zzZ47Wh5nL1pm9YtPIIVX5pxY/loj4lKoLAo5hdXJHsK9czpIVsbboTxN
	 PY+Khi544v43Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] btrfs: remove fs_info argument from btrfs_sysfs_add_space_info_type()
Date: Fri, 15 May 2026 10:48:19 -0400
Message-ID: <20260515144820.3248893-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051235-front-pushup-165a@gregkh>
References: <2026051235-front-pushup-165a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D8E80551B03
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247796-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,wdc.com:email]
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
index 12f8f55bb9938..292789a1b84b9 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -262,7 +262,7 @@ static int create_space_info_sub_group(struct btrfs_space_info *parent, u64 flag
 	sub_group->parent = parent;
 	sub_group->subgroup_id = id;
 
-	ret = btrfs_sysfs_add_space_info_type(fs_info, sub_group);
+	ret = btrfs_sysfs_add_space_info_type(sub_group);
 	if (ret) {
 		kfree(sub_group);
 		parent->sub_group[index] = NULL;
@@ -291,7 +291,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 			goto out_free;
 	}
 
-	ret = btrfs_sysfs_add_space_info_type(info, space_info);
+	ret = btrfs_sysfs_add_space_info_type(space_info);
 	if (ret)
 		goto out_free;
 
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 9609579d2289c..6f01b89add673 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1674,13 +1674,12 @@ static const char *alloc_name(struct btrfs_space_info *space_info)
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
index 86c7eef128731..9a781ba14db04 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -27,8 +27,7 @@ void __cold btrfs_exit_sysfs(void);
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


