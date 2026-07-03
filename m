Return-Path: <stable+bounces-271792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TaZsDVvBR2o0ewAAu9opvQ
	(envelope-from <stable+bounces-271792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:04:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 528A17033A5
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:04:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ospiV9lE;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271792-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271792-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D6C1302736D
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064D023815B;
	Fri,  3 Jul 2026 14:02:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560C3D7D7F
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 14:02:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087377; cv=none; b=pjRJlNTQ0v22IOBPcAcjjmvS012Er7emg3qkIkdQ7OuGwDzoD1qhADfQsLPBwR4DiMlzVOFZxAdGwXBnDmHaEA6kFxfRR6J9McYk9Hp3v9ocl1x/kfp950Qu6uRcr0DQJlqh3djskac7ou9kFGj0vPAl/HWR4WOaK6gUCYGg3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087377; c=relaxed/simple;
	bh=KIirS9jCCrqf9F3eAzfxUpZi8vjMIlgWXF4MK/NmiM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWLSV01qA4s/4D75ELDIhOlC+c4gt65MO01/Y/BmOOMAxdg2bujHIZChilj9PjADVsboSlcCmRNN/Ys/Qtt8oHYFTm9sSbEFwug5gdbmaBHrz51WNTWMfWPO7boImRQW4S3rZ9jWa97slZ5Z5JoyHZvsmAzK6RTIjHQ7Saoi9Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ospiV9lE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9551F000E9;
	Fri,  3 Jul 2026 14:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783087376;
	bh=bTAWY9pCSqMVcwkFTZLA8O9aOpvXf14ih+t5YMQy9Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ospiV9lEiDcC8tWiImtQhyVJBmFZh5ExNC0q+HZaRKge7jG2uUjoKzTgDXxcP4yJB
	 WFB5JOcI6537Vlkc0gM8yOX6iqRMPq83IQ303H+LBKNKFC/HxCpH6J0xpp2pLyBsc9
	 QmGiC1OuTKR3wde30ZfvDTgU09EHBOWYsLjdYChbABSCKrh72m8JrGY0+nY3I7s9xn
	 /Ou1rF4BbVeZn2GpC+t2x3VxpENsd93gu94VNK3psQAEGkioJTRHgLI9iUdCBjQeNz
	 I+9OR13w7QDbnU99JKsXtGeHvaYs79ltAlEVpI5ivhMGdHc7riQ30uprVOCDehPdh0
	 N6MHt440b4cPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>,
	stable@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: keep atomic write retry from zeroing original data
Date: Fri,  3 Jul 2026 10:02:51 -0400
Message-ID: <20260703140251.9905-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070203-junior-occupancy-679e@gregkh>
References: <2026070203-junior-occupancy-679e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:qwjhust@gmail.com,m:stable@kernel.org,m:qiwenjie@xiaomi.com,m:chao@kernel.org,m:jaegeuk@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-271792-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,xiaomi.com];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xiaomi.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 528A17033A5

From: Wenjie Qi <qwjhust@gmail.com>

[ Upstream commit 6d874b65aadce56ac78f76129dbcfc2599b638f8 ]

A partial atomic write reserves a block in the COW inode before reading the
original data page for the untouched bytes in that page.

If that read fails, write_begin returns an error but leaves the COW inode
entry as NEW_ADDR. A retry of the same partial write then finds the COW
entry, treats it as existing COW data, and f2fs_write_begin() zeroes the
whole folio because blkaddr is NEW_ADDR.

If the retry is committed, the bytes outside the retried write range are
committed as zeroes instead of preserving the original file contents.

Only use the COW inode as the read source when it already has a real data
block. If the COW entry is still NEW_ADDR, treat it as a reservation to
reuse: keep reading the old data from the original inode and avoid
reserving or accounting the same atomic block again.

Cc: stable@kernel.org
Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b9c841ab72f10c..cf3fb57d9b9b0e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3561,6 +3561,7 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 	pgoff_t index = page->index;
 	int err = 0;
 	block_t ori_blk_addr = NULL_ADDR;
+	bool cow_has_reserved_block = false;
 
 	/* If pos is beyond the end of file, reserve a new block in COW inode */
 	if ((pos & PAGE_MASK) >= i_size_read(inode))
@@ -3570,8 +3571,10 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 	err = __find_data_block(cow_inode, index, blk_addr);
 	if (err)
 		return err;
-	else if (*blk_addr != NULL_ADDR)
+	else if (__is_valid_data_blkaddr(*blk_addr))
 		return 0;
+	else if (*blk_addr == NEW_ADDR)
+		cow_has_reserved_block = true;
 
 	/* Look for the block in the original inode */
 	err = __find_data_block(inode, index, &ori_blk_addr);
@@ -3580,10 +3583,13 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 
 reserve_block:
 	/* Finally, we should reserve a new block in COW inode for the update */
-	err = __reserve_data_block(cow_inode, index, blk_addr, node_changed);
-	if (err)
-		return err;
-	inc_atomic_write_cnt(inode);
+	if (!cow_has_reserved_block) {
+		err = __reserve_data_block(cow_inode, index, blk_addr,
+					   node_changed);
+		if (err)
+			return err;
+		inc_atomic_write_cnt(inode);
+	}
 
 	if (ori_blk_addr != NULL_ADDR)
 		*blk_addr = ori_blk_addr;
-- 
2.53.0


