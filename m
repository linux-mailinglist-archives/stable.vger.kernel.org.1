Return-Path: <stable+bounces-3494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9A77FF5EF
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C2B2818BB
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B6754FB5;
	Thu, 30 Nov 2023 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xWWRfR0X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E475524C1;
	Thu, 30 Nov 2023 16:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB52C433C7;
	Thu, 30 Nov 2023 16:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361974;
	bh=5p055QthmRTyZLMnhrJrZmnZ45/vnNdpwM7HWXE06gA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xWWRfR0XLhcU8htxuKMPQDwGe7/7NXTaStAA8Nqvv7EWuJmp6BH84XXYbrB+G9oLs
	 Px+ZQmtka/qv4ZcWyDUKtfJzxW6sj/twnFoMiztLEKuoI8xiySt7HqoWv4/BaX+VYh
	 j48prJyfcv2vtxN9Au2qie/piC2cwqICfwCDHW00=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun1@huawei.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 37/69] ext4: using nofail preallocation in ext4_es_remove_extent()
Date: Thu, 30 Nov 2023 16:22:34 +0000
Message-ID: <20231130162134.293744180@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162133.035359406@linuxfoundation.org>
References: <20231130162133.035359406@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit e9fe2b882bd5b26b987c9ba110c2222796f72af5 ]

If __es_remove_extent() returns an error it means that when splitting
extent, allocating an extent that must be kept failed, where returning
an error directly would cause the extent tree to be inconsistent. So we
use GFP_NOFAIL to pre-allocate an extent_status and pass it to
__es_remove_extent() to avoid this problem.

In addition, since the allocated memory is outside the i_es_lock, the
extent_status tree may change and the pre-allocated extent_status is
no longer needed, so we release the pre-allocated extent_status when
es->es_len is not initialized.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230424033846.4732-7-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 8e387c89e96b ("ext4: make sure allocate pending entry not fail")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents_status.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 10550d62a6763..4af825eb0cb45 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1457,6 +1457,7 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	ext4_lblk_t end;
 	int err = 0;
 	int reserved = 0;
+	struct extent_status *es = NULL;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return 0;
@@ -1471,17 +1472,25 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	end = lblk + len - 1;
 	BUG_ON(end < lblk);
 
+retry:
+	if (err && !es)
+		es = __es_alloc_extent(true);
 	/*
 	 * ext4_clear_inode() depends on us taking i_es_lock unconditionally
 	 * so that we are sure __es_shrink() is done with the inode before it
 	 * is reclaimed.
 	 */
 	write_lock(&EXT4_I(inode)->i_es_lock);
-	err = __es_remove_extent(inode, lblk, end, &reserved, NULL);
+	err = __es_remove_extent(inode, lblk, end, &reserved, es);
+	if (es && !es->es_len)
+		__es_free_extent(es);
 	write_unlock(&EXT4_I(inode)->i_es_lock);
+	if (err)
+		goto retry;
+
 	ext4_es_print_tree(inode);
 	ext4_da_release_space(inode, reserved);
-	return err;
+	return 0;
 }
 
 static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
-- 
2.42.0




