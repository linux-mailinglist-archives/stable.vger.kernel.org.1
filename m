Return-Path: <stable+bounces-86667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DF79A2AB4
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 19:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D4F1C20B9F
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 17:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A1C1DF993;
	Thu, 17 Oct 2024 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hpmDC4p9"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6914B1DF992
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185611; cv=none; b=UqvP9Mlu4oV8jMc0JsQryl7BrmrpQncTmf+GGN8O7TlheVbs4OnVOdO7oKjObnU1IhOi3+hND2WBS+kg6nnJ6q/3frrsoRcYxLHsUWooYIErE0lFc46eaw4BRDButGVq5OE1tBkrQyLR5jHvqFNnjRtQxyE9IiX/dbEYEy+8+PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185611; c=relaxed/simple;
	bh=zWjx88eTYqXkcFPraFuqdEU3NgIXdgu1bqE42wkyNEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VLhNc9yT1P8Smdc0TBH9u5a1B7WK5Xi41JrvYQherivU+hnslHbZEYD4e7FKJ/Li2b2HppRG8pW9TEbBdiKHF9FxWGoXT799k+1UlxUJYTTM1SshJ0cOqoKynhjW+4gJNgxhHJ/mLvT4uJOB21kcISQLWyiVsQszcNWK1WzKr+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hpmDC4p9; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=09upd4quJ659EW5Ba6h+UBUyhzaPoRE4f7AzeCzkLT4=; b=hpmDC4p9pR9r84s6WFJ1TlovTO
	UHVJcVKK1dSNcuOo88yX12nTW3zF4T0lD8c2aPQv1cjxf60BBWXOE8eEAmahrDmTf2s4R34IkOs1G
	iFve7yEiXvtVInguwTEhmznllQG5RfcBRagv65fFPjEMCF80z4iPyQyf4D/Pgu8wpPnw72Vo/BumA
	stO28Qe3r15I2BxjuuegYoFjvr3N+cyg5tX1JcuIb3jb8H0GV7MjWsd4qSgXsgyDC5fkbx4Ze4ifP
	r90eh6vuOaWUvFyFKxpSopLZDGJCrtDcenStLl/kJMcNz6Asv1GghlJwmMpgtl6B6OwpjTXeaGLmO
	HtyD7i+w==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1UAN-00Biqr-7E; Thu, 17 Oct 2024 19:20:03 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 16/19] udf: Convert udf_link() to new directory iteration code
Date: Thu, 17 Oct 2024 14:19:12 -0300
Message-Id: <20241017171915.311132-17-cascardo@igalia.com>
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

[ Upstream commit dbfb102d16fb780c84f41adbaeb7eac907c415dc ]

Convert udf_link() to use new directory iteration code for adding entry
into the directory.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/namei.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 7984abb79de1..4370867a274a 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1222,27 +1222,21 @@ static int udf_link(struct dentry *old_dentry, struct inode *dir,
 		    struct dentry *dentry)
 {
 	struct inode *inode = d_inode(old_dentry);
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc cfi, *fi;
+	struct udf_fileident_iter iter;
 	int err;
 
-	fi = udf_add_entry(dir, dentry, &fibh, &cfi, &err);
-	if (!fi) {
+	err = udf_fiiter_add_entry(dir, dentry, &iter);
+	if (err)
 		return err;
-	}
-	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
-	cfi.icb.extLocation = cpu_to_lelb(UDF_I(inode)->i_location);
+	iter.fi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
+	iter.fi.icb.extLocation = cpu_to_lelb(UDF_I(inode)->i_location);
 	if (UDF_SB(inode->i_sb)->s_lvid_bh) {
-		*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
+		*(__le32 *)((struct allocDescImpUse *)iter.fi.icb.impUse)->impUse =
 			cpu_to_le32(lvid_get_unique_id(inode->i_sb));
 	}
-	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
-	if (UDF_I(dir)->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		mark_inode_dirty(dir);
+	udf_fiiter_write_fi(&iter, NULL);
+	udf_fiiter_release(&iter);
 
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
 	inc_nlink(inode);
 	inode->i_ctime = current_time(inode);
 	mark_inode_dirty(inode);
-- 
2.34.1


