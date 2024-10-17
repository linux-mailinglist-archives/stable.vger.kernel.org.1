Return-Path: <stable+bounces-86700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F939A2E61
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 22:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6103DB2216B
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 20:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B40F1DFE2A;
	Thu, 17 Oct 2024 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="erPj8nqQ"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3D31D07BA
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196443; cv=none; b=ex6Ea5KVE/OHslrLgWzKE8KtOOrbZhDZD9xjGMFXost7PX6j9yC8Hgw6GfihVzmxF0NB8dCiRhKsQIojHaWNvVCBm/K/tTuBxOE0KAJiB9PxZMKlV+ulRSwRPx4GmLiX/et33N6Lm7+hhut01fxwNRKIEHbU6bfDzZRt9cgGUm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196443; c=relaxed/simple;
	bh=cR5D0Fgfdcr6Z9WZuzQKkKsD1SSKYpDuaYacibRDLYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PsTts/y6deZDbw1woeFmnKxFRJu2/MHOt1YwzOCkUMYyjoi5I2ALrM0ClcAx7WyzfEWt+J6W/zLsaEIhvQAkwU9ua51Q6LlkyFbrhLz6XmhB/pr0cdWEWeaoZbwi6SN83bdu385R+SVufagF++h39tm94ODaf1/w6jq+x0ZQJ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=erPj8nqQ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kJgp7Uoxc1E0sbIjYmETB6uX2FeTPltuyZOneqUYp+I=; b=erPj8nqQUmoU61+odbeo5/rbMZ
	AqnvR6z2zwzDt/0BKTRphpFuoDI5D9s7QIhmCVvtZC9DmMppbcj0Nt1n5+x7bHygdCrXkb8dcCHAt
	27wfowTfyKbeRq31gaRFpzyThF1DZrg9p9zt8gZ3S73m0iUR9G00KXTV/EMwNtmioedDVx5sCcori
	6dysYWrlw44Lm+LQm2bek1TrzH7m3wcGnbWJJ8SFQXDm5bX2FH//qX00t6uQTh42WjDNol8btLA4/
	bzzhe5wSIlCAjUZ6Vuw2MRm5RMWzq/gqUgaOuaC2YiuO4ZXksfJEHddnbJU1mkT6s/XtOtQ4ryKon
	lOfyxN3w==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1Wz8-00BmZ7-Fo; Thu, 17 Oct 2024 22:20:39 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.15 12/20] udf: Convert udf_unlink() to new directory iteration code
Date: Thu, 17 Oct 2024 17:19:54 -0300
Message-Id: <20241017202002.406428-13-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017202002.406428-1-cascardo@igalia.com>
References: <20241017202002.406428-1-cascardo@igalia.com>
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
index 432e325f955a..0ed0e4a0b186 100644
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


