Return-Path: <stable+bounces-265717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BQ1bIBePMWq2mgUAu9opvQ
	(envelope-from <stable+bounces-265717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:59:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B9E693B1F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:59:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=jCkAFRaM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265717-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265717-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0AF0316094D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745E34779B3;
	Tue, 16 Jun 2026 17:57:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484C63AA1BA;
	Tue, 16 Jun 2026 17:57:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632626; cv=none; b=acNJ8ZcI4eG9D2OC7zcZUVss/j2ADlaBJbGPr0s4AxDNksz4AlqtZHwsEu29ALnyc/06YWtiACrJNyaeT3Hp4+RUk5BQph6PtGS51kldbtjUBbP8T79E4mma6t5K+yYE9GmsvdlnGAz8bw5kFQI5WeAUIVJdL25LtRV27ovt6ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632626; c=relaxed/simple;
	bh=P/ZjwVMLCMeoefWtAOD8x411rLJS91LYJyqhG/n15iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gakzAgNIjXxQCzgniS3jpEqy8TFk/7rtegMTkiE6OGc+KrzOaOB/3YsVCzoQoBjZxB6muP4w1XQF3/KQdlZcOz4/0Z82E6XrJl8FtIKksuWRR0K3neurkqzjx1YXm22st1eyN0TcNmXCQWc/h0/aoN7rx7MgS8pGvluVUgjMdI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jCkAFRaM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30261F000E9;
	Tue, 16 Jun 2026 17:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781632624;
	bh=YmessaQAvjp12kmWFc0Fek87G2LpFiyGQLWTl/lsstg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jCkAFRaMYLpL5leMnfjohUqe/fvyhw3vBoDO5jRKEzKS7Y65cOTXvKdhKJSiK32Y4
	 Is6AijjuxqiAZgf8S1TtmEuZdzxqBUVdaHz7227Itg18OevPGrhPsP3WGZyCj6Q4ur
	 o7KJojtGRbGFoZp7nj8+gil/asb72/2QjdKsq7dY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 414/522] btrfs: remove fs_info argument from btrfs_sysfs_add_space_info_type()
Date: Tue, 16 Jun 2026 20:29:21 +0530
Message-ID: <20260616145145.409950967@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265717-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:johannes.thumshirn@wdc.com,m:fdmanana@suse.com,m:dsterba@suse.com,m:sashal@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wdc.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9B9E693B1F

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/space-info.c |    4 ++--
 fs/btrfs/sysfs.c      |    5 ++---
 fs/btrfs/sysfs.h      |    3 +--
 3 files changed, 5 insertions(+), 7 deletions(-)

--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -259,7 +259,7 @@ static int create_space_info_sub_group(s
 	sub_group->parent = parent;
 	sub_group->subgroup_id = id;
 
-	ret = btrfs_sysfs_add_space_info_type(fs_info, sub_group);
+	ret = btrfs_sysfs_add_space_info_type(sub_group);
 	if (ret) {
 		kfree(sub_group);
 		parent->sub_group[index] = NULL;
@@ -288,7 +288,7 @@ static int create_space_info(struct btrf
 			goto out_free;
 	}
 
-	ret = btrfs_sysfs_add_space_info_type(info, space_info);
+	ret = btrfs_sysfs_add_space_info_type(space_info);
 	if (ret)
 		return ret;
 
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1618,13 +1618,12 @@ static const char *alloc_name(struct btr
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
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -28,8 +28,7 @@ void __cold btrfs_exit_sysfs(void);
 int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info);
 void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info);
 void btrfs_sysfs_add_block_group_type(struct btrfs_block_group *cache);
-int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *space_info);
+int btrfs_sysfs_add_space_info_type(struct btrfs_space_info *space_info);
 void btrfs_sysfs_remove_space_info(struct btrfs_space_info *space_info);
 void btrfs_sysfs_update_devid(struct btrfs_device *device);
 



