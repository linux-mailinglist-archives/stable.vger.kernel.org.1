Return-Path: <stable+bounces-62603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE3D93FE28
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 21:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40EA21C2261E
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 19:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44523187322;
	Mon, 29 Jul 2024 19:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc/K2TBd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F91084D34
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722280632; cv=none; b=cQ5py5NLlMoxMGb3uijmVriarmR4powBiFjv68TwLAZX+T5P8X8qk9duFcy4O/TsiXNIHOfwUyy3Ulna42/lqNuOOouteGj2JfU3yBzTEfUz/ltn+luuaPWBL1XPRsslIp1dLSOd9fcggV5YihSQ5FTiuyqSgh4wZWIVKbNBWIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722280632; c=relaxed/simple;
	bh=oTOd9gPP4QrERl3DWb+wVhK1wYBB10A1Sk/cxYrPoXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kRBUo7yuva9h9pRGfKvQpQBH/xcXDpN7suaUxwtf6CxgD7rYDtCwfY94WkuT4lYnoMiZZyy6Mn5ZNq+kK+qCCRUQNq7pTOXPhEMkYmvIolXZ8BHbMlQY6vTQ5h8ulBbhlPlDCUxaPx/F4NIaCfgasyEFb2WzgBIiU58n9CLyZuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jc/K2TBd; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7a103ac7be3so2054478a12.3
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722280629; x=1722885429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eeSq1lntMEqxIYgZnhZF+MXAqb+lpD75LFy3m84qBto=;
        b=jc/K2TBdNbRFAP4+6RQqhvXmf830c3MMttHAB/xlVA7p6rzlYcb+vfFvVZkdFHlEy5
         bl5CGMX2y7ORNppHcQA4O9hvz0IBRUK39pa7jThhcvA1SFFe/ch6Yw9lOWhqpli5Cwjg
         G6ZwA+9YqLonj77E+DPmfMccV40ZbhCMqMkAaMPWh1p79+zu+NKVtpXdjeNb4aRx39We
         c8gy1TxoD3dV15k2G7Qjc/EbFXGpnU4YDlqPHyJIsxWEGzS01WXRiFonle8o8lUjjrtk
         NuM9aWNFCjuso3Y6daHM+8gdNiPWbCFJOHh6CPQ69lAnKLWVIS3vFLzkW4ZB2BhqT74J
         ghyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722280629; x=1722885429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeSq1lntMEqxIYgZnhZF+MXAqb+lpD75LFy3m84qBto=;
        b=HigNMcVYb1eeD0GUvGyCL+0RdegYqkSV54pVkdxyCY0q69APUUo+LtmMS/Mhu1EWgB
         Asqi7BICd7hcMydrMRcftAm8nJ4YzWPeW4EbL2f5dpHDAGAVcHxe8hQiGYJcQdAgaADP
         MeS6DUpaLo9RjO/HPjQWOgCq1U5TNa5Xxc+WtE43BW3W+exdeoZmV/a0kfmV3IdVUgsO
         DJBTKaBkJJIgSN5UCkQiUwhARV04kVPA7t+BjlPf165j6AVXcvMW6BmSSO+5GK7QGYT0
         BvTTKLqjZbNkT+dr5gaGfOIZQnkDQHxe3ZMixotb1HUMNh9eqimITAe92PI7lAxi7fBk
         x6Fw==
X-Gm-Message-State: AOJu0Yykom9g5XuVl6H9WT942gjdKOmbuyR+7195UeyJ9EGZ9UNGBOTc
	4+nqj8a+7lQgXrg+XxAoA3DP284FIk8fnbI39LwRsfTJuBAjgh8aZN3CPg==
X-Google-Smtp-Source: AGHT+IHe1Wf5ZXuLKVucbq/n+GtuFERBuNGBdnaCtqkXsp1d0HIUKc9cAYhqTvaabApRdR5C3ep+Ug==
X-Received: by 2002:a05:6a21:998a:b0:1c4:9397:ff98 with SMTP id adf61e73a8af0-1c4a12a9998mr7844969637.18.1722280629294;
        Mon, 29 Jul 2024 12:17:09 -0700 (PDT)
Received: from carrot.. (i222-151-34-139.s42.a014.ap.plala.or.jp. [222.151.34.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e18a4sm7167487b3a.9.2024.07.29.12.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 12:17:08 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.19 5.4 5.10 5.15 6.1 6.6] nilfs2: handle inconsistent state in nilfs_btnode_create_block()
Date: Tue, 30 Jul 2024 04:17:04 +0900
Message-Id: <20240729191704.10301-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 4811f7af6090e8f5a398fbdd766f903ef6c0d787 upstream.

Syzbot reported that a buffer state inconsistency was detected in
nilfs_btnode_create_block(), triggering a kernel bug.

It is not appropriate to treat this inconsistency as a bug; it can occur
if the argument block address (the buffer index of the newly created
block) is a virtual block number and has been reallocated due to
corruption of the bitmap used to manage its allocation state.

So, modify nilfs_btnode_create_block() and its callers to treat it as a
possible filesystem error, rather than triggering a kernel bug.

Link: https://lkml.kernel.org/r/20240725052007.4562-1-konishi.ryusuke@gmail.com
Fixes: a60be987d45d ("nilfs2: B-tree node cache")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+89cc4f2324ed37988b60@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=89cc4f2324ed37988b60
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
Please apply this patch to the stable trees indicated by the subject
prefix instead of the failed patches or the one I asked you to drop.

This patch is tailored to take page/folio conversion into account and
can be applied from v4.11 to v6.7.

Also, all the builds and tests I did on each stable tree passed.

Thanks,
Ryusuke Konishi

 fs/nilfs2/btnode.c | 25 ++++++++++++++++++++-----
 fs/nilfs2/btree.c  |  4 ++--
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index 5710833ac1cc..8fe348bceabe 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -51,12 +51,21 @@ nilfs_btnode_create_block(struct address_space *btnc, __u64 blocknr)
 
 	bh = nilfs_grab_buffer(inode, btnc, blocknr, BIT(BH_NILFS_Node));
 	if (unlikely(!bh))
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	if (unlikely(buffer_mapped(bh) || buffer_uptodate(bh) ||
 		     buffer_dirty(bh))) {
-		brelse(bh);
-		BUG();
+		/*
+		 * The block buffer at the specified new address was already
+		 * in use.  This can happen if it is a virtual block number
+		 * and has been reallocated due to corruption of the bitmap
+		 * used to manage its allocation state (if not, the buffer
+		 * clearing of an abandoned b-tree node is missing somewhere).
+		 */
+		nilfs_error(inode->i_sb,
+			    "state inconsistency probably due to duplicate use of b-tree node block address %llu (ino=%lu)",
+			    (unsigned long long)blocknr, inode->i_ino);
+		goto failed;
 	}
 	memset(bh->b_data, 0, i_blocksize(inode));
 	bh->b_bdev = inode->i_sb->s_bdev;
@@ -67,6 +76,12 @@ nilfs_btnode_create_block(struct address_space *btnc, __u64 blocknr)
 	unlock_page(bh->b_page);
 	put_page(bh->b_page);
 	return bh;
+
+failed:
+	unlock_page(bh->b_page);
+	put_page(bh->b_page);
+	brelse(bh);
+	return ERR_PTR(-EIO);
 }
 
 int nilfs_btnode_submit_block(struct address_space *btnc, __u64 blocknr,
@@ -217,8 +232,8 @@ int nilfs_btnode_prepare_change_key(struct address_space *btnc,
 	}
 
 	nbh = nilfs_btnode_create_block(btnc, newkey);
-	if (!nbh)
-		return -ENOMEM;
+	if (IS_ERR(nbh))
+		return PTR_ERR(nbh);
 
 	BUG_ON(nbh == obh);
 	ctxt->newbh = nbh;
diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 65659fa0372e..598f05867059 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -63,8 +63,8 @@ static int nilfs_btree_get_new_block(const struct nilfs_bmap *btree,
 	struct buffer_head *bh;
 
 	bh = nilfs_btnode_create_block(btnc, ptr);
-	if (!bh)
-		return -ENOMEM;
+	if (IS_ERR(bh))
+		return PTR_ERR(bh);
 
 	set_buffer_nilfs_volatile(bh);
 	*bhp = bh;
-- 
2.43.5


