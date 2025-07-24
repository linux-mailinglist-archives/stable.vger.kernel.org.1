Return-Path: <stable+bounces-164542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B94B0FF04
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 04:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2671C87010
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA13D1C84B2;
	Thu, 24 Jul 2025 02:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBOAqLQw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795EE22097
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 02:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753325857; cv=none; b=hPNxGKKqTjU04Rt0kbrz054xMjETQ6Tgze+gtO1UEhsbeFI5BIozatvE9j0UNojeaCBf26J0ZkY2p+CKrs07K09TU5i9Ga0ZNu+nyMexjb067P10J/W3Jp+o+1VDHayQt/EJEHch+uF0Y7If/+VjINiv9SWGYBTVb6c8CBBUKpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753325857; c=relaxed/simple;
	bh=wgkzBaRS+gEQ4tSTqzVwOzW2BvY0pTAiasdtCVsLaVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XoPw8nq9KlxNT99gOnllVQe7oNwH74nBc26GNrpzIDRRokmH/0kvopBedsrqZbj9QPnfNyGtVzdfcfJTj0GyUwW0LQiDqw5WnnGh8zN4cpa2rL2L+FaGSqO0BK0TGct6Sd2Ib7TNbTdGH+ZyFhuOUrtUTfNXTYXGhBGjNCM5ZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBOAqLQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6179C4CEF1;
	Thu, 24 Jul 2025 02:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753325857;
	bh=wgkzBaRS+gEQ4tSTqzVwOzW2BvY0pTAiasdtCVsLaVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iBOAqLQwic0qldzdDTk3pxnnVfeZjQ3hotrQc/9p9Q0nViRyPXp+hdb4Uqn2bxTJM
	 WLAfmPWYT7koi++KsalVRKcSR0QG66f/W6jokoVws04TuBGwf9ENZrs5o+2vRmuOq7
	 93PS5jOGL4BzbxPwpSFvxycvWmpYEq8xNrqO+/7Ycmk5noTktBnhg/ibSTMafUj1vq
	 XafcIy3SlNXLPL/62vUFnHSrgUXJKkl+AxXV8tf3Jtn965grsXo4oHBbI4GDiRLghY
	 gzfGf1Mg3xIR13WFBsJvU3fMzfq/K4LucbjKu5eNquIbCw/eE0tYb2y/ycs2syLixw
	 fpfo+sWLO/n/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun1@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 09/11] ext4: fix incorrect punch max_end
Date: Wed, 23 Jul 2025 22:57:16 -0400
Message-Id: <20250724025718.1277650-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724025718.1277650-1-sashal@kernel.org>
References: <2025062009-junior-thriving-f882@gregkh>
 <20250724025718.1277650-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 29ec9bed2395061350249ae356fb300dd82a78e7 ]

For the extents based inodes, the maxbytes should be sb->s_maxbytes
instead of sbi->s_bitmap_maxbytes. Additionally, for the calculation of
max_end, the -sb->s_blocksize operation is necessary only for
indirect-block based inodes. Correct the maxbytes and max_end value to
correct the behavior of punch hole.

Fixes: 2da376228a24 ("ext4: limit length to bitmap_maxbytes - blocksize in punch_hole")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Link: https://patch.msgid.link/20250506012009.3896990-2-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/inode.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ca98f04fcf556..fe1d19d920a96 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3992,7 +3992,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	struct inode *inode = file_inode(file);
 	struct super_block *sb = inode->i_sb;
 	ext4_lblk_t start_lblk, end_lblk;
-	loff_t max_end = EXT4_SB(sb)->s_bitmap_maxbytes - sb->s_blocksize;
+	loff_t max_end = sb->s_maxbytes;
 	loff_t end = offset + length;
 	handle_t *handle;
 	unsigned int credits;
@@ -4001,14 +4001,20 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	trace_ext4_punch_hole(inode, offset, length, 0);
 	WARN_ON_ONCE(!inode_is_locked(inode));
 
+	/*
+	 * For indirect-block based inodes, make sure that the hole within
+	 * one block before last range.
+	 */
+	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		max_end = EXT4_SB(sb)->s_bitmap_maxbytes - sb->s_blocksize;
+
 	/* No need to punch hole beyond i_size */
 	if (offset >= inode->i_size)
 		return 0;
 
 	/*
 	 * If the hole extends beyond i_size, set the hole to end after
-	 * the page that contains i_size, and also make sure that the hole
-	 * within one block before last range.
+	 * the page that contains i_size.
 	 */
 	if (end > inode->i_size)
 		end = round_up(inode->i_size, PAGE_SIZE);
-- 
2.39.5


