Return-Path: <stable+bounces-86697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B0E9A2E5E
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 22:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AC3CB21EEC
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 20:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59331227BBC;
	Thu, 17 Oct 2024 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dWulxXfc"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2F821D198
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196437; cv=none; b=I5/WNWcg2dTAEAYaHt2Isd3x/XF/WWSmdQrP/PCPKzCzgUxdN79lqEpHPaZ6znx0m7C0C8fCzdV3uB0g9XJEfbJcQjVq24mDffZuPkq/RqgJRtqCDJYXXvnviPafU8vj6dMFpY7lq2u1KiyLVOk3DayQoksFyDl1nYqEhbNDU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196437; c=relaxed/simple;
	bh=++VTVPUNTlTNuoCNNY+LBeClgdQko4yh70ECbcjGAHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XhJy/cUaiUSi1pC+Rgem1c6oTsRmGClAAzC9JtRFspvJy77s5phvY3aZ3m+b07u3seK7bgHNDx9lkr86aR9B9zTpuhcXpZnWrFRxu8iYupwk0t7jE77/Xf2xeum+HrYoUeqYBZDXdgOyD3TaNiBYGEHcYKvyVcz92571hByi+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dWulxXfc; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Ko+rUuRgySvdeU6FdGBA1CfUKQ+qve8s54K7YfqJoNY=; b=dWulxXfciaKqhBUg3annVhJztU
	J5n985y5K2T+qkj/39xQQnusK0LiH3gkpkFUeatQvV12TW9BDQ90DW8lrh+CrIUoI/Drm6kETt5+U
	xQCEKrpKSuR+kf+xgINv8tzNV+pAOyXnCP91eLLvP1R1HpTti/2XubB+wyNIub6DEubUEMqEn8rqI
	O9UbqIrJnA1a5cM5m2me0a/hWt9BcHJ7JWbBNPq/0pumV8MypvquGbsO+tI+SfNoj7oWfB4wP395y
	4Bqr+Aha84qrSe7Ihh6RRA7aE08JLeXDKrX5PV16GmWNlgToTexvvSA03ZefMtBsN1kNbecHO9L4t
	TqDL4fCA==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1Wz1-00BmZ7-R3; Thu, 17 Oct 2024 22:20:32 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.15 09/20] udf: Convert udf_get_parent() to new directory iteration code
Date: Thu, 17 Oct 2024 17:19:51 -0300
Message-Id: <20241017202002.406428-10-cascardo@igalia.com>
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

[ Upstream commit 9b06fbef4202363d74bba5459ddd231db6d3b1af ]

Convert udf_get_parent() to use udf_fiiter_find_entry().

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/namei.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 02fa9482e9ce..bc847e709fe6 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1368,17 +1368,15 @@ static struct dentry *udf_get_parent(struct dentry *child)
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


