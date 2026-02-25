Return-Path: <stable+bounces-219562-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNsRCKyhnmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219562-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:15:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA5E193274
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA56C323BA4C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676A82F9DB5;
	Wed, 25 Feb 2026 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G7tcqPve"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBD7332ECB;
	Wed, 25 Feb 2026 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002798; cv=none; b=MmAmEZfKehvqZzEw0tCADN/4iCwEt4febfDQIz5eo2EOzCWiLcyGDB7IBPdjylSCvLstuDe6atWvqk+fyCImuQ4+k+i0bfInagyQDAjuMGRwNKQN80bF0VMC+JWXzRZGu8ha13xFPIWaV5qMM7U7XFRhe8krVanbeT//mNFzQ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002798; c=relaxed/simple;
	bh=6GpdQymy9470807eKOQUNONLkQNRFrkfqWoUXEFOnww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WN5aixWtTm4dOjJA+A9JVL4MJLtPP6yqp4GoLL6zxAM1Vs97MBDIBgLKDW/zoutzbJG8SE4QU+V0eNN+m43F5ausuvCXJjvu86ONLw2k4Zbb690pnPFlJYjhgc0Yj6EnIeueulKBVKfrs/4SX89GOauUMFXNZ/G/peGuXVNkwGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G7tcqPve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03669C116D0;
	Wed, 25 Feb 2026 06:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002798;
	bh=6GpdQymy9470807eKOQUNONLkQNRFrkfqWoUXEFOnww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G7tcqPveeC4z0xFAzBd+Nbk0mbvL8WFmzk4RAgmp7iseD333HIkVTzTKQa1xIDzyE
	 +JnZN4JyiZRYsdz0eOK6zG1UVMkMc8iZNietf34akBIyst8t1ESlvVWqGe2QVPB1V3
	 4UsA6ACoEgV15/KklLg8ixZ/5tfDHPGVRnAisPnc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 603/641] btrfs: reduce block group critical section in btrfs_free_reserved_bytes()
Date: Tue, 24 Feb 2026 17:25:29 -0800
Message-ID: <20260225012403.126415990@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219562-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.com:email]
X-Rspamd-Queue-Id: 7DA5E193274
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 8b6fa164ab59f9e3f24e627fe09a0234783e7a8b ]

There's no need to update the space_info fields (bytes_reserved,
max_extent_size, bytes_readonly, bytes_zone_unusable) while holding the
block group's spinlock. So move those updates to happen after we unlock
the block group (and while holding the space_info locked of course), so
that all we do under the block group's critical section is to update the
block group itself.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 5870ec7c8fe5 ("btrfs: reset block group size class when it becomes empty")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 035b04e7658d1..144868f02e2aa 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3859,21 +3859,24 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache, u64 num_bytes,
 			       bool is_delalloc)
 {
 	struct btrfs_space_info *space_info = cache->space_info;
+	bool bg_ro;
 
 	spin_lock(&space_info->lock);
 	spin_lock(&cache->lock);
-	if (cache->ro)
+	bg_ro = cache->ro;
+	cache->reserved -= num_bytes;
+	if (is_delalloc)
+		cache->delalloc_bytes -= num_bytes;
+	spin_unlock(&cache->lock);
+
+	if (bg_ro)
 		space_info->bytes_readonly += num_bytes;
 	else if (btrfs_is_zoned(cache->fs_info))
 		space_info->bytes_zone_unusable += num_bytes;
-	cache->reserved -= num_bytes;
+
 	space_info->bytes_reserved -= num_bytes;
 	space_info->max_extent_size = 0;
 
-	if (is_delalloc)
-		cache->delalloc_bytes -= num_bytes;
-	spin_unlock(&cache->lock);
-
 	btrfs_try_granting_tickets(space_info);
 	spin_unlock(&space_info->lock);
 }
-- 
2.51.0




