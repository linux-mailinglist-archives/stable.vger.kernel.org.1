Return-Path: <stable+bounces-220485-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI0eKFs5o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220485-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:52:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BCC1C656E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA1C33097224
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EC43C54AE;
	Sat, 28 Feb 2026 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1wFAJ+v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D063C5CBE;
	Sat, 28 Feb 2026 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300371; cv=none; b=SORTvzgAdGSytH03ldCyGJh+CapCmIOyJW7TszL2sJvwbj8tn4Gy4uoI9eMUBqFxJFQADgVyv1oNYDzD1EwuKZE+6dBG/sM43xNbWYi1uOcE9gua35E96Nna8gtUQQtj5GKansFj53hHhbn/Gmg8q5gUJ59j5Owr+xsUt5dy1g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300371; c=relaxed/simple;
	bh=HEIzHM/hG9YWHaa0ZiDSP3b5QM4WNh/Zah3RMKXgBwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYKfgRzbybJMZRglpJ0wjLa9jfxikwq0sDWVEpQjzzsiqx8DRtCWJvCjB5V7UFtiOPrr5tFZLyaXn0k3YZkaU4l8dwK1MPNUKVuy+DE70QscvdPuI8sGAAP/dN3s9nNty42/0+Hb0H7pBVVdYWmk911CjL/69Vlyomq8cA2IrJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1wFAJ+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9697C19423;
	Sat, 28 Feb 2026 17:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300371;
	bh=HEIzHM/hG9YWHaa0ZiDSP3b5QM4WNh/Zah3RMKXgBwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u1wFAJ+vnV9XyceYdAK15AjUB3bE0bd3azfaoHMc/cRRU7QGd4htr/uwMRIWxl027
	 T75eUYKUnD+mACm00qajrFVU3vQSDB2ivyB1rw8YlLAUWoo4vu5HR8a95wxubq6fmH
	 7slJvBH99JtKNxCaAxBa7WU6aKqlSmpTHgTiOD3DLkdkZ/xwgdeP2I/yyptb6AAkgN
	 PFmfSebF+TSyev3bFeUzrQ7AWdi0iWkG7XK/KiTw/oEHdtBDalzoXbOUSvOE2TVO3U
	 QnR22kiAJ7L8wqnkb2xjGONDheoF95P9QTxEYVZSrcGr8GD4WuxtQm3S6ulzcEyj7v
	 nYpT+QFPnpRmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 406/844] fs/ntfs3: handle attr_set_size() errors when truncating files
Date: Sat, 28 Feb 2026 12:25:19 -0500
Message-ID: <20260228173244.1509663-407-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-220485-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 82BCC1C656E
X-Rspamd-Action: no action

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 576248a34b927e93b2fd3fff7df735ba73ad7d01 ]

If attr_set_size() fails while truncating down, the error is silently
ignored and the inode may be left in an inconsistent state.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/file.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 5120bd7851694..13d014b878f6c 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -505,8 +505,8 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
 {
 	struct super_block *sb = inode->i_sb;
 	struct ntfs_inode *ni = ntfs_i(inode);
-	int err, dirty = 0;
 	u64 new_valid;
+	int err;
 
 	if (!S_ISREG(inode->i_mode))
 		return 0;
@@ -522,7 +522,6 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
 	}
 
 	new_valid = ntfs_up_block(sb, min_t(u64, ni->i_valid, new_size));
-
 	truncate_setsize(inode, new_size);
 
 	ni_lock(ni);
@@ -536,20 +535,19 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
 		ni->i_valid = new_valid;
 
 	ni_unlock(ni);
+	if (unlikely(err))
+		return err;
 
 	ni->std_fa |= FILE_ATTRIBUTE_ARCHIVE;
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	if (!IS_DIRSYNC(inode)) {
-		dirty = 1;
+		mark_inode_dirty(inode);
 	} else {
 		err = ntfs_sync_inode(inode);
 		if (err)
 			return err;
 	}
 
-	if (dirty)
-		mark_inode_dirty(inode);
-
 	return 0;
 }
 
-- 
2.51.0


