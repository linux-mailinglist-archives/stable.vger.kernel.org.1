Return-Path: <stable+bounces-221685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAtoGU2Yo2lIHwUAu9opvQ
	(envelope-from <stable+bounces-221685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:37:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C920A1CB270
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F34373035BCA
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1AE2EA749;
	Sun,  1 Mar 2026 01:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcR+Ngjl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8209A299A84;
	Sun,  1 Mar 2026 01:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328887; cv=none; b=u4aRnitBYMt50q3pHgRIqmTyT6zd33rRFhGZqypkYEZBy7eZJ9gc1j3YavpE70JDM5mX9uRLcw1/erpFySj7LrI6pd3MufYO1LHxirITFoxttejo8p6+dsy/y+7s46g0ey6bqM1/nSx0UOWyblnzVioYU9Ue6OtFP0bMHVsr2pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328887; c=relaxed/simple;
	bh=xShNqWjlR6nGVg/RJITDIBASqnj0RHTd2lxSzpWpuUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SNq9zLRtpoCTrPG9uIGu+crqqpGS4Jc2338W6Q3Sn7a7mxAY4gk4FRLYHmXF7vV1QOI1sQkTPV893pYaUGVGDXwqhv5HLUU2ClMxAd/n85CYEl50nrhBpygs9Fm7Fd/CXv6llbpamMUSOXnADA1WKBsgeq7gJXi/lFM0t2yXaW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcR+Ngjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41E3C19421;
	Sun,  1 Mar 2026 01:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328887;
	bh=xShNqWjlR6nGVg/RJITDIBASqnj0RHTd2lxSzpWpuUo=;
	h=From:To:Cc:Subject:Date:From;
	b=fcR+NgjlKzfmZnHj6uOCD0Jd+b/VPbjYcqgKfJneCGKFjbYWpy1/cRVPVxXO7IsY6
	 YT3btMqy0oPEeKcW71HjoblBQtr0FVwM8JXJKdquJEkS/CvD/iIGD65pn6wVODEpfk
	 wcoZ3ZJR0rueYgK0S7nXdglhU0Tn6JYB4g2hafm9FNp2pscZWKSujt3L0+MJylVT6t
	 vY0fwYQxHE8FBFis/MFXdblQOJQxbX5O5je4VAPHiI882gNozY23/hZ/zBAm+WZ2N8
	 1ujX8W55X/+HmwsVeDuim+qnSEfEtF6tG2fiSS8J/mDiyUwusl9U/nX1KD58kGpWhw
	 M5sSk60Z7qJDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jinpu.wang@ionos.com
Cc: Yu Kuai <yukuai@fnnas.com>,
	linux-raid@vger.kernel.org
Subject: FAILED: Patch "md/bitmap: fix GPF in write_page caused by resize race" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:34:45 -0500
Message-ID: <20260301013445.1694320-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-221685-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: C920A1CB270
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 46ef85f854dfa9d5226b3c1c46493d79556c9589 Mon Sep 17 00:00:00 2001
From: Jack Wang <jinpu.wang@ionos.com>
Date: Tue, 20 Jan 2026 11:24:56 +0100
Subject: [PATCH] md/bitmap: fix GPF in write_page caused by resize race

A General Protection Fault occurs in write_page() during array resize:
RIP: 0010:write_page+0x22b/0x3c0 [md_mod]

This is a use-after-free race between bitmap_daemon_work() and
__bitmap_resize(). The daemon iterates over `bitmap->storage.filemap`
without locking, while the resize path frees that storage via
md_bitmap_file_unmap(). `quiesce()` does not stop the md thread,
allowing concurrent access to freed pages.

Fix by holding `mddev->bitmap_info.mutex` during the bitmap update.

Link: https://lore.kernel.org/linux-raid/20260120102456.25169-1-jinpu.wang@ionos.com
Closes: https://lore.kernel.org/linux-raid/CAMGffE=Mbfp=7xD_hYxXk1PAaCZNSEAVeQGKGy7YF9f2S4=NEA@mail.gmail.com/T/#u
Cc: stable@vger.kernel.org
Fixes: d60b479d177a ("md/bitmap: add bitmap_resize function to allow bitmap resizing.")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 drivers/md/md-bitmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index dbe4c4b9a1daf..1d4a050dab3ab 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2453,6 +2453,7 @@ static int __bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 		memcpy(page_address(store.sb_page),
 		       page_address(bitmap->storage.sb_page),
 		       sizeof(bitmap_super_t));
+	mutex_lock(&bitmap->mddev->bitmap_info.mutex);
 	spin_lock_irq(&bitmap->counts.lock);
 	md_bitmap_file_unmap(&bitmap->storage);
 	bitmap->storage = store;
@@ -2560,7 +2561,7 @@ static int __bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 			set_page_attr(bitmap, i, BITMAP_PAGE_DIRTY);
 	}
 	spin_unlock_irq(&bitmap->counts.lock);
-
+	mutex_unlock(&bitmap->mddev->bitmap_info.mutex);
 	if (!init) {
 		__bitmap_unplug(bitmap);
 		bitmap->mddev->pers->quiesce(bitmap->mddev, 0);
-- 
2.51.0





