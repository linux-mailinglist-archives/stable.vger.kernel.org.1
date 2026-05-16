Return-Path: <stable+bounces-249028-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBfEF+TACGrC3wMAu9opvQ
	(envelope-from <stable+bounces-249028-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:09:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D210655D766
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D4F730086E2
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD4C35E1A4;
	Sat, 16 May 2026 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7Hq05HQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1068F405C31
	for <stable@vger.kernel.org>; Sat, 16 May 2026 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778958561; cv=none; b=V6fcrRmGBrF00x0BdBwwz3A+lTunrrCZ1wvpTDZPfmtVj58CGnJKLYvdNhD8+WA6TmHO6imLuv3e/YxlJtZLpQ0un6JNWg5CXMtg8RFgnwOJQn4tayraw3GZRoJbdPud3Y5dEqbTxHNvsrVHOyhlQ7EjKI+Q9bZ93cKJw4eAu5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778958561; c=relaxed/simple;
	bh=FH/KORPj1srGtx2xVCHqe7VEqiQgEtQVwyr1tatchwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yo9c0p5k/T4vMxUH4WKsaND2vmYynn0Aavq7nPcdDYXws/KA2fFDPsQcW7m8h6y/rjvieVuUy5UXpIMvWcg6+pt568HUHKgktxvCxae9vYO/KCiKzgYqw+sT4NzlNnkkk8ydGDE/vnVUswYLcElDXaZgVCDeRb/KCvRssTMWBdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7Hq05HQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D3CC19425;
	Sat, 16 May 2026 19:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778958560;
	bh=FH/KORPj1srGtx2xVCHqe7VEqiQgEtQVwyr1tatchwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e7Hq05HQQgYQuQWShPmU/HrhpjdPpMTbV2qSQTabTCT4SKbQuhi+3Uv/k8mngAwEx
	 vbb4Mef0HbytF8S9c7m7wElfC1OxptzKZ6lBpVtErWvrZfohVQdwWU7UpBNplIgv1J
	 ZnGf5UAiPFmJAzzyFFtUlUdS8OnS+lRwN97laV0RYTRr6hMC7bF/mj/SkAJ2k7sjXa
	 2AsE8mkalJXf0sjQ1xIFnfS35UvP+wXI2m3a1TKp9wibArxQjzCsm4mGW6ow1UtEZ7
	 v/SbiWnIw92MoLnfNw6IkJFkmq9pQlBhgRomri12yNZqI0kFZP8ktcharqy1PDPpMF
	 xLSONSU9Tfgbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] btrfs: use inode already stored in local variable at btrfs_rmdir()
Date: Sat, 16 May 2026 15:09:16 -0400
Message-ID: <20260516190918.4017278-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051231-sandworm-portable-73a6@gregkh>
References: <2026051231-sandworm-portable-73a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D210655D766
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249028-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:email]
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 9f82a4ed34d870b5719f9b95f7da4f74d3325a6f ]

There's no need to call d_inode(dentry) when calling btrfs_unlink_inode()
since we have already stored that in a local inode variable. So just use
the local variable to make the code less verbose.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 999757231c49 ("btrfs: fix missing last_unlink_trans update when removing a directory")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 28024c827b756..981526b7ad684 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4801,8 +4801,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 		goto out;
 
 	/* now the directory is empty */
-	ret = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(d_inode(dentry)),
-				 &fname.disk_name);
+	ret = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(inode), &fname.disk_name);
 	if (!ret)
 		btrfs_i_size_write(BTRFS_I(inode), 0);
 out:
-- 
2.53.0


