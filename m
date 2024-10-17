Return-Path: <stable+bounces-86658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D606F9A2AAE
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 19:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D91B1F21CFC
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 17:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2D41DFD8C;
	Thu, 17 Oct 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="K2gBVmDC"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1081DF998
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185592; cv=none; b=H1JHMtuZd5tIOEqkMNTX30LqFUuW6yMkdGZ2LsxzQ0J7gnjyHQMkZp3zKaoPCCzPJFuG6EfhDk+eeiskGTG9ca0zM+lGE8BXURrtTKYDOjev/Bjp/FdtmOdeBILGfr4Ey/em89Cn088h6jWHMc8tAJnZXEbzZ6zTcZ1+WAH5Pek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185592; c=relaxed/simple;
	bh=gx0CU9qu+2qjo6CV9eIm4ZPTn7bOOUhdQ1vzE9LIX9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bKygaahwrh/zVrrf6biS9cs90VJ/dO0mTCmKagK0s+vJ3u1wmem0Aymllk0TSAOec5g6dXS+NZdE9HTaezY6nHaNsiXSPnqbj+uK5Taftd+ietVCC46aJtJKu+80RsVAz0m+gxVG0CPiSnrQvZ89fpDw2ltO7QzqpRQbhMDydrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=K2gBVmDC; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/sHr5XUzqAT9BKeBx/KFc+qu7He0V+gXKzZBnWoxgHE=; b=K2gBVmDCoo1xMwNtGF6TRiZBg+
	vrUNQySaK3GoAOVI++8EQeikqYwZ4subwDFPlRBjSjLo6GoZhM+GVlQCNA6S/OtYR7eoyMAfAtRc1
	mynhUfXGvqa8GyOGLndwUfmQxwxByZNgIFh+StvvLMxjD7v9G9Yijaodq1OPC9usVjDDux7itoUfW
	43pHCeYZmkDLaWS2XdSICJ9/mxSB0DUVmqpfZYsrCWSEM/7YZuaHnnZrTOUKoalEpa/0sejOfiBRL
	jVLqQxnPVThKZHVnZ3MNPFJIW3+Xg7VrtJ45KBnRvShbwv14OQPiUW6N1qtyiPNTYdxtuvdVmrH++
	A2p0BFug==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1UA5-00Biqr-85; Thu, 17 Oct 2024 19:19:45 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 08/19] udf: Convert udf_lookup() to use new directory iteration code
Date: Thu, 17 Oct 2024 14:19:04 -0300
Message-Id: <20241017171915.311132-9-cascardo@igalia.com>
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

[ Upstream commit 200918b34d158cdaee531db7e0c80b92c57e66f1 ]

Convert udf_lookup() to use udf_fiiter_find_entry() for looking up
directory entries.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/namei.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 1f8c91e953bb..93449f9203ca 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -366,25 +366,22 @@ static struct dentry *udf_lookup(struct inode *dir, struct dentry *dentry,
 				 unsigned int flags)
 {
 	struct inode *inode = NULL;
-	struct fileIdentDesc cfi;
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc *fi;
+	struct udf_fileident_iter iter;
+	int err;
 
 	if (dentry->d_name.len > UDF_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	fi = udf_find_entry(dir, &dentry->d_name, &fibh, &cfi);
-	if (IS_ERR(fi))
-		return ERR_CAST(fi);
+	err = udf_fiiter_find_entry(dir, &dentry->d_name, &iter);
+	if (err < 0 && err != -ENOENT)
+		return ERR_PTR(err);
 
-	if (fi) {
+	if (err == 0) {
 		struct kernel_lb_addr loc;
 
-		if (fibh.sbh != fibh.ebh)
-			brelse(fibh.ebh);
-		brelse(fibh.sbh);
+		loc = lelb_to_cpu(iter.fi.icb.extLocation);
+		udf_fiiter_release(&iter);
 
-		loc = lelb_to_cpu(cfi.icb.extLocation);
 		inode = udf_iget(dir->i_sb, &loc);
 		if (IS_ERR(inode))
 			return ERR_CAST(inode);
-- 
2.34.1


