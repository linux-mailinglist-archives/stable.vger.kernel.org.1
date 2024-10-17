Return-Path: <stable+bounces-86698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7109A2E5C
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 22:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9284A1C220BA
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 20:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2A0227BAB;
	Thu, 17 Oct 2024 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="exJVfDeL"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F291D0E1F
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196437; cv=none; b=e55yHM7UA/p4IByTU1ovQ4u3U2pUmN10VuW9aoc1zjDUkuxutATkFEmV1lc6uv/pAmAz0+6tMMglKFsuq4oRunz20ZttpNJ4mMocFwJgYzJ96HkJeXhLtS813M+b/SF10/x0gaVxAlQaikd1lpGmwlqfX/nRo/bwyo5vQTpvMfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196437; c=relaxed/simple;
	bh=PxztNmgBbh7QSuCmryEF4xXg/xVcupnAP9vgrboMW1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UY+WpkCh/bu1cV8/4HOxf6DHn0lDEMWrq1fhnEeBllVbRrjDEB9H6wcXEsM2Hi4KrgpjBMMaaDqR9CIg0J/HbUu+8PuElleNmIBzV9yYs+aNWgJ0dFxa4UcR6K+eYDQNXwQwMyuZQCqEoo3nBE4DtHu38sKZuMh1xgwu9GJuJfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=exJVfDeL; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ETH2U5OO793Rt2kkQrsXT9S/Q9UyJjGKv0wbmsriSSo=; b=exJVfDeLQ/6M/LgLJSxvw9LSP9
	pwJTNWIpOQFXBDrd8n673tPhwR2cY6M9NP1HfSK6KhD8wZXXODvAtTbjiKny2uQXhjq9Q7JfjGxvb
	/8DVval3C+SkzN6xNe9dnTkX56cnpqB+U0BlAFo1/zLPS7aDfBoT6wjVuyurWuQBDMAvEXfZE6Ejy
	epYBqKQXlX0cfaX4ESgJy22gCoKdBKUCQoxFnF/JlwjWzdFwRXysgv5F9uRlma6Ike/e4u/2VbEMK
	JPrLpuNhcYMvHVTM6wb0aKodoTxx/TBruQE8gIWpKubPS5Rf/2+kdznGG7qO1wOjqeQfrKmhEpiZ7
	bNfU6yQA==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1Wyz-00BmZ7-Is; Thu, 17 Oct 2024 22:20:30 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.15 08/20] udf: Convert udf_lookup() to use new directory iteration code
Date: Thu, 17 Oct 2024 17:19:50 -0300
Message-Id: <20241017202002.406428-9-cascardo@igalia.com>
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

[ Upstream commit 200918b34d158cdaee531db7e0c80b92c57e66f1 ]

Convert udf_lookup() to use udf_fiiter_find_entry() for looking up
directory entries.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/namei.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 16837278ab3b..02fa9482e9ce 100644
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


