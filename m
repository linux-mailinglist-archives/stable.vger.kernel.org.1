Return-Path: <stable+bounces-4555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F198047FB
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B881F21CD6
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AD38BF8;
	Tue,  5 Dec 2023 03:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BHqcb74o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94D46FB0;
	Tue,  5 Dec 2023 03:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9D2C433C8;
	Tue,  5 Dec 2023 03:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747870;
	bh=pNh2TOKUjJs5KR2HtaFWONJyUvgCbNKT9F/XAeKupyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BHqcb74owvaDCPodCMor3QJyU70H+DMxBcoyFqV7VtkathS4AjEIVQiYX1myDINZf
	 VKRo4Qfr53g/9zJAMF1MQ1GI1b+YvjihmCvE8dAFPcdDe+p9B6TcJe6K1oknMAnXyO
	 Vmv1C06+xN+79yqL7iH66o70gSmXov9+CX17pvw4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun1@huawei.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 29/94] ext4: using nofail preallocation in ext4_es_insert_extent()
Date: Tue,  5 Dec 2023 12:16:57 +0900
Message-ID: <20231205031524.530172134@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031522.815119918@linuxfoundation.org>
References: <20231205031522.815119918@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 2a69c450083db164596c75c0f5b4d9c4c0e18eba ]

Similar to in ext4_es_insert_delayed_block(), we use preallocations that
do not fail to avoid inconsistencies, but we do not care about es that are
not must be kept, and we return 0 even if such es memory allocation fails.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230424033846.4732-9-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 8e387c89e96b ("ext4: make sure allocate pending entry not fail")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents_status.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index fea538a66a16e..c4922b8c9d333 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -832,8 +832,11 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 {
 	struct extent_status newes;
 	ext4_lblk_t end = lblk + len - 1;
-	int err = 0;
+	int err1 = 0;
+	int err2 = 0;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct extent_status *es1 = NULL;
+	struct extent_status *es2 = NULL;
 
 	es_debug("add [%u/%u) %llu %x to extent status tree of inode %lu\n",
 		 lblk, len, pblk, status, inode->i_ino);
@@ -858,29 +861,40 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	ext4_es_insert_extent_check(inode, &newes);
 
+retry:
+	if (err1 && !es1)
+		es1 = __es_alloc_extent(true);
+	if ((err1 || err2) && !es2)
+		es2 = __es_alloc_extent(true);
 	write_lock(&EXT4_I(inode)->i_es_lock);
-	err = __es_remove_extent(inode, lblk, end, NULL, NULL);
-	if (err != 0)
+
+	err1 = __es_remove_extent(inode, lblk, end, NULL, es1);
+	if (err1 != 0)
+		goto error;
+
+	err2 = __es_insert_extent(inode, &newes, es2);
+	if (err2 == -ENOMEM && !ext4_es_must_keep(&newes))
+		err2 = 0;
+	if (err2 != 0)
 		goto error;
-retry:
-	err = __es_insert_extent(inode, &newes, NULL);
-	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
-					  128, EXT4_I(inode)))
-		goto retry;
-	if (err == -ENOMEM && !ext4_es_must_keep(&newes))
-		err = 0;
 
 	if (sbi->s_cluster_ratio > 1 && test_opt(inode->i_sb, DELALLOC) &&
 	    (status & EXTENT_STATUS_WRITTEN ||
 	     status & EXTENT_STATUS_UNWRITTEN))
 		__revise_pending(inode, lblk, len);
 
+	/* es is pre-allocated but not used, free it. */
+	if (es1 && !es1->es_len)
+		__es_free_extent(es1);
+	if (es2 && !es2->es_len)
+		__es_free_extent(es2);
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
+	if (err1 || err2)
+		goto retry;
 
 	ext4_es_print_tree(inode);
-
-	return err;
+	return 0;
 }
 
 /*
-- 
2.42.0




