Return-Path: <stable+bounces-86659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE63E9A2AAF
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 19:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2E31C20757
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 17:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DCA1DF998;
	Thu, 17 Oct 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lN1P5wIW"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647D21DF991
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185593; cv=none; b=gxl5Ec6gSKOrGgdD0bafR1Lak7hEHjXKoK1QP8qix3JGlK59PCNgcUY/xEGyZ2jMDJzOTd+dm0tQFC7lYVTvBtPvm0wQYoADjHBBBrI1Q9ZIGsywoV/5nRilLOn8GORotrWC/UWyXu7DDS5qEtSYa4t9cdrhC3dBBFRnQRKc0jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185593; c=relaxed/simple;
	bh=6QdATZoCGSls9fuT2MHPYPSCtRYQ7Vb3SfMuPk4WkKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hwT5BgDavEn97Bujc8xlOxLao/vSM996sjo8ZWACr19CmqEY21lWuXGRl7zzkezkjhQBpzS61GvkBFceiKDZJP79nyw1Z8A3zuRimeMHhX2dZGq85JlFJCloeer097RkjkWrvvhx87aP0uX8tSQgYDCDmKIaAhyLI+ROmtIGWUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lN1P5wIW; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8g8Rq9nFeETye44OIkgdRYnyCvkXgGutH67mgVlqTaE=; b=lN1P5wIWWP2PLZ9f4QgpoTwqR9
	fjhekOXm1SwrzbGhp3JdA3609XCl5iazR+1YubYsqq6nsrJPBzuyv/Z2LMfYnZLQJOuGkvOsQpMlg
	MzAHvNXmnIC4GXXTy48mKONVHBMNXhc5UHncZJI2SowoBkBPVa4oyld0oD54Y0GYo3VK7IQ66/JCZ
	9wxi0Uh0Qq4hPtkgyH7rZf7bJKBvEEuX8a8CtOHaTj1k/a6L/ARA2+ei/9hwVKZKY5MGOAi/PQS+w
	sFzFuPeCrWFy1B2oLmt5tTa2iepGYRs28NW7AEizZFag0SsJkqO9IclpBh5Awe+FukHMrCBoJ5f3I
	eN9tybgg==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1UA7-00Biqr-BK; Thu, 17 Oct 2024 19:19:47 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 09/19] udf: Convert udf_get_parent() to new directory iteration code
Date: Thu, 17 Oct 2024 14:19:05 -0300
Message-Id: <20241017171915.311132-10-cascardo@igalia.com>
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

[ Upstream commit 9b06fbef4202363d74bba5459ddd231db6d3b1af ]

Convert udf_get_parent() to use udf_fiiter_find_entry().

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/namei.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 93449f9203ca..6fbd06b33cd4 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1366,17 +1366,15 @@ static struct dentry *udf_get_parent(struct dentry *child)
 {
 	struct kernel_lb_addr tloc;
 	struct inode *inode = NULL;
-	struct fileIdentDesc cfi;
-	struct udf_fileident_bh fibh;
-
-	if (!udf_find_entry(d_inode(child), &dotdot_name, &fibh, &cfi))
-		return ERR_PTR(-EACCES);
+	struct udf_fileident_iter iter;
+	int err;
 
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
+	err = udf_fiiter_find_entry(d_inode(child), &dotdot_name, &iter);
+	if (err)
+		return ERR_PTR(err);
 
-	tloc = lelb_to_cpu(cfi.icb.extLocation);
+	tloc = lelb_to_cpu(iter.fi.icb.extLocation);
+	udf_fiiter_release(&iter);
 	inode = udf_iget(child->d_sb, &tloc);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
-- 
2.34.1


