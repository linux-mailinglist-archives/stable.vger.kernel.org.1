Return-Path: <stable+bounces-222267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKRTHiCuo2kmJwUAu9opvQ
	(envelope-from <stable+bounces-222267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:10:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2411CE461
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C441934C8F34
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C862C21F2;
	Sun,  1 Mar 2026 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKRX/EGa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650672F39BE;
	Sun,  1 Mar 2026 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330451; cv=none; b=pvPRomwtHbpXFKKs7UNpOLfPJlRw/90K7in7JcAkO14G/lCB0/Xhf9GM2vwGZr5IijG/ew/TSnZTdb0nvjUcFu19Yj3mFZe3ajjLVtISjk0Usn6hIwOau3QAPm7ug9EJFebcchwSHN1ZIKdVcRB3/ZSJuAto/H0sAYaw1nZWw2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330451; c=relaxed/simple;
	bh=0XOShKdmT12Y2li2eUj6/XuRKA/XoGZbwEZ0CLOBNd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OuSgnROIxKPoBYyehJdbuBbQl1VpfbyzpNTh0E1ikS3D7SbnDHQrgMTrxEg1/E3qr0eXArpTIkPxVRKU55FRBAD9mnJKzpGq72pEh1Y6W4qP5XdgI+zJxY35/Mh1RwMrhcCHGUnNyQ8ewXKfVWXPKYaZc3kkU1VBXRCemHCVrn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKRX/EGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B74C19424;
	Sun,  1 Mar 2026 02:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330451;
	bh=0XOShKdmT12Y2li2eUj6/XuRKA/XoGZbwEZ0CLOBNd0=;
	h=From:To:Cc:Subject:Date:From;
	b=VKRX/EGa69TtdZb1af4ev1q+MNW4pvWT6Yq37ehaurAW8BqCGUmLABb5o77izLLlO
	 1j8GpLtbADDRD7wXsW1uT3DO6iUg9GaJRh8bHyQ2kGsTlgwOuvgNc8G5xSuadeZ7wT
	 7a0WnIiFcFB+QHhtxww8VJ8fNsmNDn8TDFoc5KY/9btggvbx517AFmnepQm+1IEaFU
	 itVOP3nqfbb6ft+fAj371oddxL+bIEEeS7vyOPpTMmR5mQORfZi1Xq1tAeASLt8UMZ
	 fMrrvwFAgKSR012yZ3YTRGKgIt1OQ/BxjmXKx9Hc3MNAgfr+t5KgDtOvpSPLxTmuGV
	 nVY/AXikHpmbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yi.zhang@huawei.com
Cc: Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: FAILED: Patch "ext4: drop extent cache when splitting extent fails" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:00:49 -0500
Message-ID: <20260301020049.1727723-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222267-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:email]
X-Rspamd-Queue-Id: DE2411CE461
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 79b592e8f1b435796cbc2722190368e3e8ffd7a1 Mon Sep 17 00:00:00 2001
From: Zhang Yi <yi.zhang@huawei.com>
Date: Sat, 29 Nov 2025 18:32:39 +0800
Subject: [PATCH] ext4: drop extent cache when splitting extent fails

When the split extent fails, we might leave some extents still being
processed and return an error directly, which will result in stale
extent entries remaining in the extent status tree. So drop all of the
remaining potentially stale extents if the splitting fails.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Cc: stable@kernel.org
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Message-ID: <20251129103247.686136-8-yi.zhang@huaweicloud.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/extents.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 1094e49234513..945995d68c4d3 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3267,7 +3267,7 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 
 	err = PTR_ERR(path);
 	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
-		return path;
+		goto out_path;
 
 	/*
 	 * Get a new path to try to zeroout or fix the extent length.
@@ -3281,7 +3281,7 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 	if (IS_ERR(path)) {
 		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
 				 split, PTR_ERR(path));
-		return path;
+		goto out_path;
 	}
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
@@ -3358,6 +3358,10 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 		ext4_free_ext_path(path);
 		path = ERR_PTR(err);
 	}
+out_path:
+	if (IS_ERR(path))
+		/* Remove all remaining potentially stale extents. */
+		ext4_es_remove_extent(inode, ee_block, ee_len);
 	ext4_ext_show_leaf(inode, path);
 	return path;
 }
-- 
2.51.0





