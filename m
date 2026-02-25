Return-Path: <stable+bounces-219169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFK/AvBonmm2VAQAu9opvQ
	(envelope-from <stable+bounces-219169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:13:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDFD19122C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 123BD307652F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5E928851F;
	Wed, 25 Feb 2026 03:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HF6jQUrf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415FF288C08
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 03:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771989226; cv=none; b=bZS21+veN+Ljzv8h6eHSfwW5LdT8O0ojI8uus3FxJI9Wz7wPnDONPmZ2RHNMDVKH/Zs3WeaXs4S8rUoKet65gJYRp9ZHBaEkh+lt1fyG1jFUdwQA+38l8sK66fZw3rWg6Zl5HXha2xLLumcdTeLpAT/VQcc2MkvzNeBMiuzIDzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771989226; c=relaxed/simple;
	bh=Jxcik/i9FOlgBswWN9DaXJ/lRbfmlpSrhiLYmwzxuY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T77rHlHQ7BXJbcfh8BUaR+idnXK2Q4ChcoDNSeccDmMEBOKkkHX1HddkZeN9E5bFGFJjEJ47UASTbSHmqpIHFTvptT7fGV3GNzHda6Hs2y7L1fa9Z9Ilen4k25+GQ773SZrNfqj230L/rlSru7r/DRcjSZEd76AUtPJtr+iIqz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF6jQUrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7C4C116D0;
	Wed, 25 Feb 2026 03:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771989226;
	bh=Jxcik/i9FOlgBswWN9DaXJ/lRbfmlpSrhiLYmwzxuY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HF6jQUrf6pODHCZU5vsIWSocnrwrEZuHffIPYUl/J5DOCP6z8Z+Qwiqs14p4ha1zU
	 8A255mYGZTc1UfELGLdzgYfDfM9xcrKk28DkgTqT2o0vu5EUHoA/vovXluYPeD3y+O
	 HIsZGWwgJLjmWTIl8yYvv59DZ9KliFPoRnJIeIlkEhaLx7uae5EFfHUlXO+hdVMrZf
	 mUWNJ8g43WBZb9PalpymYdq/Qz+fskX5P+805upCAty56wgp8cq0eakol5pNWaTG+o
	 UD5qSGPBb/aI/I+fPEL9ybLLXzcCe3ob/DhCb3Z3svHVr4e94yZh/3Ur/u+BP7Ym0U
	 xyqNX3Q6+yfuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/7] ext4: make ext4_es_remove_extent() return void
Date: Tue, 24 Feb 2026 22:13:37 -0500
Message-ID: <20260225031343.3858545-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026022439-revered-giddily-d324@gregkh>
References: <2026022439-revered-giddily-d324@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-219169-lists,stable=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email,huawei.com:email]
X-Rspamd-Queue-Id: 7DDFD19122C
X-Rspamd-Action: no action

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit ed5d285b3f2a9a37ff778c5e440daf49351fcc4d ]

Now ext4_es_remove_extent() never fails, so make it return void.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230424033846.4732-10-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 1bf6974822d1 ("ext4: don't zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c        | 34 ++++++----------------------------
 fs/ext4/extents_status.c | 12 ++++++------
 fs/ext4/extents_status.h |  4 ++--
 fs/ext4/inline.c         | 12 ++----------
 fs/ext4/inode.c          |  8 ++------
 5 files changed, 18 insertions(+), 52 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 1aad4ae0e7ae4..8100e20475f30 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4457,15 +4457,8 @@ int ext4_ext_truncate(handle_t *handle, struct inode *inode)
 
 	last_block = (inode->i_size + sb->s_blocksize - 1)
 			>> EXT4_BLOCK_SIZE_BITS(sb);
-retry:
-	err = ext4_es_remove_extent(inode, last_block,
-				    EXT_MAX_BLOCKS - last_block);
-	if (err == -ENOMEM) {
-		memalloc_retry_wait(GFP_ATOMIC);
-		goto retry;
-	}
-	if (err)
-		return err;
+	ext4_es_remove_extent(inode, last_block, EXT_MAX_BLOCKS - last_block);
+
 retry_remove_space:
 	err = ext4_ext_remove_space(inode, last_block, EXT_MAX_BLOCKS - 1);
 	if (err == -ENOMEM) {
@@ -5412,13 +5405,7 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 
 	down_write(&EXT4_I(inode)->i_data_sem);
 	ext4_discard_preallocations(inode, 0);
-
-	ret = ext4_es_remove_extent(inode, punch_start,
-				    EXT_MAX_BLOCKS - punch_start);
-	if (ret) {
-		up_write(&EXT4_I(inode)->i_data_sem);
-		goto out_stop;
-	}
+	ext4_es_remove_extent(inode, punch_start, EXT_MAX_BLOCKS - punch_start);
 
 	ret = ext4_ext_remove_space(inode, punch_start, punch_stop - 1);
 	if (ret) {
@@ -5604,12 +5591,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 		ext4_free_ext_path(path);
 	}
 
-	ret = ext4_es_remove_extent(inode, offset_lblk,
-			EXT_MAX_BLOCKS - offset_lblk);
-	if (ret) {
-		up_write(&EXT4_I(inode)->i_data_sem);
-		goto out_stop;
-	}
+	ext4_es_remove_extent(inode, offset_lblk, EXT_MAX_BLOCKS - offset_lblk);
 
 	/*
 	 * if offset_lblk lies in a hole which is at start of file, use
@@ -5668,12 +5650,8 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 	BUG_ON(!inode_is_locked(inode1));
 	BUG_ON(!inode_is_locked(inode2));
 
-	*erp = ext4_es_remove_extent(inode1, lblk1, count);
-	if (unlikely(*erp))
-		return 0;
-	*erp = ext4_es_remove_extent(inode2, lblk2, count);
-	if (unlikely(*erp))
-		return 0;
+	ext4_es_remove_extent(inode1, lblk1, count);
+	ext4_es_remove_extent(inode2, lblk2, count);
 
 	while (count) {
 		struct ext4_extent *ex1, *ex2, tmp_ex;
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 592229027af72..862a8308cd9b0 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1494,10 +1494,10 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
  * @len - number of blocks to remove
  *
  * Reduces block/cluster reservation count and for bigalloc cancels pending
- * reservations as needed. Returns 0 on success, error code on failure.
+ * reservations as needed.
  */
-int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			  ext4_lblk_t len)
+void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
+			   ext4_lblk_t len)
 {
 	ext4_lblk_t end;
 	int err = 0;
@@ -1505,14 +1505,14 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	struct extent_status *es = NULL;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
-		return 0;
+		return;
 
 	trace_ext4_es_remove_extent(inode, lblk, len);
 	es_debug("remove [%u/%u) from extent status tree of inode %lu\n",
 		 lblk, len, inode->i_ino);
 
 	if (!len)
-		return err;
+		return;
 
 	end = lblk + len - 1;
 	BUG_ON(end < lblk);
@@ -1539,7 +1539,7 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	ext4_es_print_tree(inode);
 	ext4_da_release_space(inode, reserved);
-	return 0;
+	return;
 }
 
 static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 481ec4381bee6..1d1247bbfd477 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -133,8 +133,8 @@ extern void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 extern void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 				 ext4_lblk_t len, ext4_fsblk_t pblk,
 				 unsigned int status);
-extern int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-				 ext4_lblk_t len);
+extern void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
+				  ext4_lblk_t len);
 extern void ext4_es_find_extent_range(struct inode *inode,
 				      int (*match_fn)(struct extent_status *es),
 				      ext4_lblk_t lblk, ext4_lblk_t end,
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index a1fb99d2b472b..c15ea7589945f 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -2004,16 +2004,8 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 		 * the extent status cache must be cleared to avoid leaving
 		 * behind stale delayed allocated extent entries
 		 */
-		if (!ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
-retry:
-			err = ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
-			if (err == -ENOMEM) {
-				memalloc_retry_wait(GFP_ATOMIC);
-				goto retry;
-			}
-			if (err)
-				goto out_error;
-		}
+		if (!ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
+			ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
 
 		/* Clear the content in the xattr space. */
 		if (inline_size > EXT4_MIN_INLINE_DATA_SIZE) {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bf1f8319e2d74..79619f3db984f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4134,12 +4134,8 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 		down_write(&EXT4_I(inode)->i_data_sem);
 		ext4_discard_preallocations(inode, 0);
 
-		ret = ext4_es_remove_extent(inode, first_block,
-					    stop_block - first_block);
-		if (ret) {
-			up_write(&EXT4_I(inode)->i_data_sem);
-			goto out_stop;
-		}
+		ext4_es_remove_extent(inode, first_block,
+				      stop_block - first_block);
 
 		if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 			ret = ext4_ext_remove_space(inode, first_block,
-- 
2.51.0


