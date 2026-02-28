Return-Path: <stable+bounces-220327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePSLIGgxo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:18:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D50461C5A2B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 290CA3276F72
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EFC397302;
	Sat, 28 Feb 2026 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TG85iRbI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040E647ECDF;
	Sat, 28 Feb 2026 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300228; cv=none; b=MSNvJtI34vidAJ+cRYPNsJd/u8WN7rT/+MA23oDv789cEkKq13ZduVzmuY0UZ7CcTwRDvaAt2ef+cEGICVFRtSDUSruChG9bFzPpUISXa49/JBxxuUUf3kMo/zRYhJg03U0t4xZxjdgLp6Phn29jH3YLN7Y7zrVRl/5wtHE8Qqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300228; c=relaxed/simple;
	bh=lrmkfEUu4w0lrbRBiahKpHE0krA3exWJACHWwDbLqs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=It2G13v/Xh7MNjFBasLJxbUuq2pSRYT/j0WgpTUuwuC7eQcSu+xBAiSk37uq6FfYus7ymQtTiDXywFlzrCQn1vYq7BMNw1s404U1oEw5u2J8D4mpV63VYYi/XwdKms4EHqUjLJWO7M7+P0EKeQN426c0nZ4Lh+f4Po5zCKgJJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TG85iRbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F19C116D0;
	Sat, 28 Feb 2026 17:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300227;
	bh=lrmkfEUu4w0lrbRBiahKpHE0krA3exWJACHWwDbLqs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TG85iRbIS/BqqTLSV3+01yHlzRrmMdgcdbN/ryqAVEyZVMihp1LVKz8oPXLh56qpv
	 jNhOP29zgzyyE+SS5FyVAiWtwyfAX3PiPXBdA5s2rqk61Nt7es6QmFBFe1e1AknH8z
	 X5NJ5dh4rH3o2eVCCHUps4fDU5RZ9Iy+LHZ9wqC+yJGUvEZMEVBeOoqCCBkyDUNMVj
	 RixbQp0PSsW4ubpklVf06DDqUtwQjnX3GskzFMPL0ipOPCbaPGNcmCnDx1JIevXdmr
	 yosdvvQfFt4ho5XDk1TxSCm1GYKIA/wOyqd7MpDbdP0nAaoHo3wIG+VNdUHkz1jKS7
	 FiiKkwVjE3w1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	syzbot+9131ddfd7870623b719f@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 249/844] jfs: nlink overflow in jfs_rename
Date: Sat, 28 Feb 2026 12:22:42 -0500
Message-ID: <20260228173244.1509663-250-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[xs4all.nl,syzkaller.appspotmail.com,oracle.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220327-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,9131ddfd7870623b719f];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,xs4all.nl:email,syzbot.org:url]
X-Rspamd-Queue-Id: D50461C5A2B
X-Rspamd-Action: no action

From: Jori Koolstra <jkoolstra@xs4all.nl>

[ Upstream commit 9218dc26fd922b09858ecd3666ed57dfd8098da8 ]

If nlink is maximal for a directory (-1) and inside that directory you
perform a rename for some child directory (not moving from the parent),
then the nlink of the first directory is first incremented and later
decremented. Normally this is fine, but when nlink = -1 this causes a
wrap around to 0, and then drop_nlink issues a warning.

After applying the patch syzbot no longer issues any warnings. I also
ran some basic fs tests to look for any regressions.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
Reported-by: syzbot+9131ddfd7870623b719f@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=9131ddfd7870623b719f
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/namei.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 65a218eba8faf..7879c049632b3 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -1228,7 +1228,7 @@ static int jfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 				jfs_err("jfs_rename: dtInsert returned -EIO");
 			goto out_tx;
 		}
-		if (S_ISDIR(old_ip->i_mode))
+		if (S_ISDIR(old_ip->i_mode) && old_dir != new_dir)
 			inc_nlink(new_dir);
 	}
 	/*
@@ -1244,7 +1244,9 @@ static int jfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		goto out_tx;
 	}
 	if (S_ISDIR(old_ip->i_mode)) {
-		drop_nlink(old_dir);
+		if (new_ip || old_dir != new_dir)
+			drop_nlink(old_dir);
+
 		if (old_dir != new_dir) {
 			/*
 			 * Change inode number of parent for moved directory
-- 
2.51.0


