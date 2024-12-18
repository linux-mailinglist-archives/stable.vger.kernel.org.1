Return-Path: <stable+bounces-105131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F7D9F5F6F
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 08:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2A11891BD9
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 07:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87823156F5E;
	Wed, 18 Dec 2024 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gXFbJEF+"
X-Original-To: stable@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5DF15382E
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734507594; cv=none; b=Q4DnTj6S2n0rlaLk8jqqezU9dRBfJlwxpuk96dr4gLPy1rg29qC+DTE/nvgvUbpbrMkGSvtrdeBktDo/ysQUhkPw4Ll4Alr27IZ4YQ9lVVJmqeWXDkj/OOsyEQPEALNiVrqKx5TVuizoIqVEhGKejnjfe00w1kRXsGuH8ULx2lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734507594; c=relaxed/simple;
	bh=ORbTe+GxqWIjsE/FS/LxlyqNyE4nkarEA9CFg0f2O6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPhDxZ0abkdKWoQYCnVPv88Yf1tHRUJDh1zd7IM3UBSrkxxvH53/zWSm+AfE9WwcNIIU/fkv/ZklARvt2xuIOvc6pbfTZ8pB2fbdL184Ya71PkADpMjYmTNnK9yOeN5Ije/zNpiCAvBy96sheEk7hKkq9RkVm2zzZ6f9otzA5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gXFbJEF+; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734507583; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=vdSVyoMB0y9/Ui3J906Gv8Qnits7tU5YvWYi4N8ibKY=;
	b=gXFbJEF+392B4+L47ui9+IX34PFx00CUZOsCRa8cQz/vSb5uDMTDSBr9tIES9kc2zUZPnzEBVrt/CEB439+iFkmP5t6hZ72N/edu+SCI6GLfM6TlSifCGjhmu+vuBEwyp5rY7iYGaeDUf2KTQFdMhuh+2z7y10MWkCDA35AAIE4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLlkMIl_1734507581 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Dec 2024 15:39:43 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: allison.karlitskaya@redhat.com,
	linux-erofs@lists.ozlabs.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Colin Walters <walters@verbum.org>
Subject: [PATCH 5.4.y 2/2] erofs: fix incorrect symlink detection in fast symlink
Date: Wed, 18 Dec 2024 15:39:38 +0800
Message-ID: <20241218073938.459812-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218073938.459812-1-hsiangkao@linux.alibaba.com>
References: <20241218073938.459812-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 9ed50b8231e37b1ae863f5dec8153b98d9f389b4 upstream.

Fast symlink can be used if the on-disk symlink data is stored
in the same block as the on-disk inode, so we don’t need to trigger
another I/O for symlink data.  However, currently fs correction could be
reported _incorrectly_ if inode xattrs are too large.

In fact, these should be valid images although they cannot be handled as
fast symlinks.

Many thanks to Colin for reporting this!

Reported-by: Colin Walters <walters@verbum.org>
Reported-by: https://honggfuzz.dev/
Link: https://lore.kernel.org/r/bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com
Fixes: 431339ba9042 ("staging: erofs: add inode operations")
[ Note that it's a runtime misbehavior instead of a security issue. ]
Link: https://lore.kernel.org/r/20240909031911.1174718-1-hsiangkao@linux.alibaba.com
[ Gao Xiang: fix 5.4.y build warning due to `check_add_overflow`. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index ba981076d6f2..af90d3d70a08 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -198,11 +198,14 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
 			      unsigned int m_pofs)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
+	loff_t off;
 	char *lnk;
 
-	/* if it cannot be handled with fast symlink scheme */
-	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
-	    inode->i_size >= PAGE_SIZE || inode->i_size < 0) {
+	m_pofs += vi->xattr_isize;
+	/* check if it cannot be handled with fast symlink scheme */
+	if (vi->datalayout != EROFS_INODE_FLAT_INLINE || inode->i_size < 0 ||
+	    check_add_overflow((loff_t)m_pofs, inode->i_size, &off) ||
+	    off > i_blocksize(inode)) {
 		inode->i_op = &erofs_symlink_iops;
 		return 0;
 	}
@@ -211,17 +214,6 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
 	if (!lnk)
 		return -ENOMEM;
 
-	m_pofs += vi->xattr_isize;
-	/* inline symlink data shouldn't cross page boundary as well */
-	if (m_pofs + inode->i_size > PAGE_SIZE) {
-		kfree(lnk);
-		erofs_err(inode->i_sb,
-			  "inline data cross block boundary @ nid %llu",
-			  vi->nid);
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
-	}
-
 	memcpy(lnk, data + m_pofs, inode->i_size);
 	lnk[inode->i_size] = '\0';
 
-- 
2.43.5


