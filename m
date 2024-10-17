Return-Path: <stable+bounces-86662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767449A2AB0
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 19:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8BDC1C20CC5
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 17:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D431DF99C;
	Thu, 17 Oct 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SC5vU/U6"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906891DF991
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185599; cv=none; b=EP9w1o8z3/njZvNk9ydQToqhybJF28EmuYuj2PQzHak5q+BVu6iHsKbGeDXwryRZMX7lDz2Cu0MvSyl87Gh2k8XUDhaK5xqxKxM1GKUWW60DoMDaR2kId9B3+5FmPRJwaG84WoBMxkLNYo6/Zkanwl4xcim4VZSoC0/N5tyEQUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185599; c=relaxed/simple;
	bh=7E6yNUl9ZEP7DqF9V2HGDqLYsUlpXqqszQmcpud22l4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NOAAqoNwkIVuhQ029QZFjw+BUmUfZPb8kKWTwVyH/GzH6H3dFVrW83tYR6JU6kFo5UqRkwSnDG445QbV+6j+tJG11S22b54NOApieNoI/K1caJUOMSIWmbcMqLthT2pli9pQLs+2GMXOAw1CVyk4MCXS5FnoL64KR/JaC+Pr9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SC5vU/U6; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7PlnpV6T6iLzaENUglMn3hXxCHuA1Wnzyljx3q7Oj8M=; b=SC5vU/U68recv4JGB9APelr4dc
	yNuMasYZ1se6CdgonNy2F65CiVHfnYwVd2GHzOzJfF6OLMSKf111ZNSao/p/Tw5jB83mRZa3NPdUL
	647/v2TlN4JFUoRjozrlCyRx/0QBMPjzn8IjtXf74XyVKlKYgEO8VcupyGp+nRQJlSnF6Z90rrrOO
	RGwejxsfFTjAhTtZidLS3K2ng7jBMOBei8nlPfjNZYVU/hwjbzowNxyRk1atbHgjaWbJFfPnn1qKU
	k+SNxSr3OQBb6L/gd87tyQr/RMqlvnRsUMxweyHJ5yLdpPrTGZxYaCpZM6ZaqmHK0vtCv5+CyX+k/
	g/BuaOsw==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1UAE-00Biqr-3R; Thu, 17 Oct 2024 19:19:54 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 12/19] udf: Convert udf_unlink() to new directory iteration code
Date: Thu, 17 Oct 2024 14:19:08 -0300
Message-Id: <20241017171915.311132-13-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017171915.311132-1-cascardo@igalia.com>
References: <20241017171915.311132-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit 6ec01a8020b54e278fecd1efe8603f8eb38fed84 ]

Convert udf_unlink() to new directory iteration code.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/namei.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 42780b5386ca..39508a2e25c9 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -933,24 +933,17 @@ static int udf_rmdir(struct inode *dir, struct dentry *dentry)
 
 static int udf_unlink(struct inode *dir, struct dentry *dentry)
 {
-	int retval;
+	int ret;
 	struct inode *inode = d_inode(dentry);
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc *fi;
-	struct fileIdentDesc cfi;
+	struct udf_fileident_iter iter;
 	struct kernel_lb_addr tloc;
 
-	retval = -ENOENT;
-	fi = udf_find_entry(dir, &dentry->d_name, &fibh, &cfi);
-
-	if (IS_ERR_OR_NULL(fi)) {
-		if (fi)
-			retval = PTR_ERR(fi);
+	ret = udf_fiiter_find_entry(dir, &dentry->d_name, &iter);
+	if (ret)
 		goto out;
-	}
 
-	retval = -EIO;
-	tloc = lelb_to_cpu(cfi.icb.extLocation);
+	ret = -EFSCORRUPTED;
+	tloc = lelb_to_cpu(iter.fi.icb.extLocation);
 	if (udf_get_lb_pblock(dir->i_sb, &tloc, 0) != inode->i_ino)
 		goto end_unlink;
 
@@ -959,22 +952,16 @@ static int udf_unlink(struct inode *dir, struct dentry *dentry)
 			  inode->i_ino, inode->i_nlink);
 		set_nlink(inode, 1);
 	}
-	retval = udf_delete_entry(dir, fi, &fibh, &cfi);
-	if (retval)
-		goto end_unlink;
+	udf_fiiter_delete_entry(&iter);
 	dir->i_ctime = dir->i_mtime = current_time(dir);
 	mark_inode_dirty(dir);
 	inode_dec_link_count(inode);
 	inode->i_ctime = dir->i_ctime;
-	retval = 0;
-
+	ret = 0;
 end_unlink:
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-
+	udf_fiiter_release(&iter);
 out:
-	return retval;
+	return ret;
 }
 
 static int udf_symlink(struct user_namespace *mnt_userns, struct inode *dir,
-- 
2.34.1


