Return-Path: <stable+bounces-210859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA7ON2E6cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-210859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:43:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B42B85D7FE
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E4C25CC49E
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072C329ACD7;
	Wed, 21 Jan 2026 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tu/tYJgb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BA38B7BD;
	Wed, 21 Jan 2026 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019627; cv=none; b=lKJXjlownCBrOR5mClPnVXPVJdxJyB7mOyGUMLZF4lAi6SPLCEfLf7T256i3EURaIJiTVJSYInsAVeVYtaQa+35yt/ind7DWx+DzpTBUVIKjuvS2EIxhYN0bJwlAWAKQA7w0OQl37BXOd1j2WPitGLUWj9sLww7Pj4F5bukPgu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019627; c=relaxed/simple;
	bh=QELLNZJD5hpxzdUVTERT7kcd5IMxuJ0QM42tvzFLWmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AaDo6KOPqbME+zGB25ArcQ6sDig43mf0TH7rl1IJR6JK+wrT1FvwUjIeFgtwL+kKjy6Iuuvke7mRQlKkAHTMaeMvI+trq2FOYQ3yKVJSDbYMt1XF7X/iLD5zFAYVmbxWXsBDw8uYguh+//T3PKKTPE9qxiJ14M6JFnxlayt6na4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tu/tYJgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE1EC4CEF1;
	Wed, 21 Jan 2026 18:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019627;
	bh=QELLNZJD5hpxzdUVTERT7kcd5IMxuJ0QM42tvzFLWmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tu/tYJgbI8ZGB+YvvvCqnxdWFROqmJL1VaKkPWaofqQuZJUtk5moOooal6azLxB/n
	 3uYlkBXX5pUHq+skUjHvMWheeuyQnil1nocyE4t8CRjOclLb7BJ2P+dkSRmCT/BfAL
	 tcVKXOhPJEvENXFZvEa8NBOgxFSRraGTtR9MvieY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 027/139] btrfs: factor out init_space_info() from create_space_info()
Date: Wed, 21 Jan 2026 19:14:35 +0100
Message-ID: <20260121181412.433064978@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210859-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,wdc.com:email,suse.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: B42B85D7FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naohiro Aota <naohiro.aota@wdc.com>

[ Upstream commit ac5578fef380e68e539a2238ba63dd978a450ef2 ]

Factor out initialization of the space_info struct, which is used in a
later patch. There is no functional change.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: a11224a016d6 ("btrfs: fix memory leaks in create_space_info() error paths")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/space-info.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d5a9cd8a4fd8d..6497398fb4e2e 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -225,19 +225,11 @@ void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_info,
 	WRITE_ONCE(space_info->chunk_size, chunk_size);
 }
 
-static int create_space_info(struct btrfs_fs_info *info, u64 flags)
+static void init_space_info(struct btrfs_fs_info *info,
+			    struct btrfs_space_info *space_info, u64 flags)
 {
-
-	struct btrfs_space_info *space_info;
-	int i;
-	int ret;
-
-	space_info = kzalloc(sizeof(*space_info), GFP_NOFS);
-	if (!space_info)
-		return -ENOMEM;
-
 	space_info->fs_info = info;
-	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++)
+	for (int i = 0; i < BTRFS_NR_RAID_TYPES; i++)
 		INIT_LIST_HEAD(&space_info->block_groups[i]);
 	init_rwsem(&space_info->groups_sem);
 	spin_lock_init(&space_info->lock);
@@ -251,6 +243,19 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 
 	if (btrfs_is_zoned(info))
 		space_info->bg_reclaim_threshold = BTRFS_DEFAULT_ZONED_RECLAIM_THRESH;
+}
+
+static int create_space_info(struct btrfs_fs_info *info, u64 flags)
+{
+
+	struct btrfs_space_info *space_info;
+	int ret;
+
+	space_info = kzalloc(sizeof(*space_info), GFP_NOFS);
+	if (!space_info)
+		return -ENOMEM;
+
+	init_space_info(info, space_info, flags);
 
 	ret = btrfs_sysfs_add_space_info_type(info, space_info);
 	if (ret)
-- 
2.51.0




