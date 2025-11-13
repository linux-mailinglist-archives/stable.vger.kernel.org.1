Return-Path: <stable+bounces-194674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81685C56BD0
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 11:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C15B3A8B7A
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 09:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33420199949;
	Thu, 13 Nov 2025 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="3BHoG2oX"
X-Original-To: stable@vger.kernel.org
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07392DF6E9
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027940; cv=none; b=gLWT+SQXLGZVJX91XafrQ7WZa/iEtwUipN4uIXEAvy3tBYiRG+3cERm4RT4qxDb5SvVNazAXeNEARwTbYUSJR9uk/oWC2aeqgXYX7e6kvKdERo54dz7YhYyzeWYc2u8KBgwyuIa7w0pluIJT4y+yObhrJpVxzk12jR37mHDAfdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027940; c=relaxed/simple;
	bh=S0XQYH+9ZbHqc28bXFiqEcDVwrRVT0R6MegPxWrfi5Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=bgz7SLbTEBC23AcDbJa91qrdFwlUzpNfzudXefH9aPo7M05FckcnkNvclA41b73LMu9vWQ9pgW6Q4Ejgef5g/JMwUPXsUkz8D/dPg5c/weYNFGZGq24BVxS2yHb/u7RFGplcGWqKCt1NBfTK+JzvizQSkt/1CvDe7KSR292fnhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=3BHoG2oX; arc=none smtp.client-ip=120.232.169.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=3BHoG2oXIvZiHnH0WR3x9VWryKhPF0Zhy8C8VdzwuqtLyqZ5MCmuW2RCbLuKsdqd8tTvCL2KEhxaA
	 wJ8x6ahy3GvMXjrieJYhowDXvaan+KYqMj9DMaMv7UKgifP2fulo0yb9aZ9GvfiVDDOeQo+3wKyoul
	 L6hWfStRcF7JlYM4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[117.129.7.61])
	by rmsmtp-lg-appmail-39-12053 (RichMail) with SMTP id 2f156915ab1e329-3054c;
	Thu, 13 Nov 2025 17:55:45 +0800 (CST)
X-RM-TRANSID:2f156915ab1e329-3054c
From: Rajani Kantha <681739313@139.com>
To: yebin10@huawei.com,
	jack@suse.cz,
	tytso@mit.edu,
	stable@vger.kernel.org
Subject: [PATCH 6.12.y 1/2] ext4: introduce ITAIL helper
Date: Thu, 13 Nov 2025 17:55:36 +0800
Message-Id: <20251113095537.1831-2-681739313@139.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251113095537.1831-1-681739313@139.com>
References: <20251113095537.1831-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 69f3a3039b0d0003de008659cafd5a1eaaa0a7a4 ]

Introduce ITAIL helper to get the bound of xattr in inode.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250208063141.1539283-2-yebin@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 fs/ext4/xattr.c | 10 +++++-----
 fs/ext4/xattr.h |  3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 5ddfa4801bb3..cfc2229370b6 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -653,7 +653,7 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
 		return error;
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = ITAIL(inode, raw_inode);
 	error = xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
@@ -797,7 +797,7 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 		return error;
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = ITAIL(inode, raw_inode);
 	error = xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
@@ -883,7 +883,7 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 			goto out;
 		raw_inode = ext4_raw_inode(&iloc);
 		header = IHDR(inode, raw_inode);
-		end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+		end = ITAIL(inode, raw_inode);
 		ret = xattr_check_inode(inode, header, end);
 		if (ret)
 			goto out;
@@ -2249,7 +2249,7 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
 	header = IHDR(inode, raw_inode);
 	is->s.base = is->s.first = IFIRST(header);
 	is->s.here = is->s.first;
-	is->s.end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	is->s.end = ITAIL(inode, raw_inode);
 	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
 		error = xattr_check_inode(inode, header, is->s.end);
 		if (error)
@@ -2800,7 +2800,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 	 */
 
 	base = IFIRST(header);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = ITAIL(inode, raw_inode);
 	min_offs = end - base;
 	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
 
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index b25c2d7b5f99..5197f17ffd9a 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -67,6 +67,9 @@ struct ext4_xattr_entry {
 		((void *)raw_inode + \
 		EXT4_GOOD_OLD_INODE_SIZE + \
 		EXT4_I(inode)->i_extra_isize))
+#define ITAIL(inode, raw_inode) \
+	((void *)(raw_inode) + \
+	 EXT4_SB((inode)->i_sb)->s_inode_size)
 #define IFIRST(hdr) ((struct ext4_xattr_entry *)((hdr)+1))
 
 /*
-- 
2.17.1



