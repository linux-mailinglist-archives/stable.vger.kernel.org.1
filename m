Return-Path: <stable+bounces-86665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 754E49A2AB3
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 19:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214CA1F22E57
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 17:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5A51DF995;
	Thu, 17 Oct 2024 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eZyVBpiL"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB0E1DF991
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185606; cv=none; b=Kvj08/aY9lDiiGhYbsNZjl+U6eO3oIVcEvvxuSkYvgYRXn76y18KV91nJylm1nnq4cGGa4bsF0MD0q8FPJj/N0rqVOLZ3FJXOaKDOFRyc0xlzMWEMMQXkHVfW/6n/scIiwTquMq1tSZaLnHgMm6jBFit3xJNXjoZw8NJYnjp2h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185606; c=relaxed/simple;
	bh=eJnMhdMCbgJOzUf5AnbhhVamj6qweDTSuICY3wkDUbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AJ6N4x4s1PVjCFXbL9taQ9/nuj1Yujwu2AkanXFG+4+lXzqMyrg0vyqNuanWdjBaY/VD5rk6ENkNJ/PRF8mj7tEkJeGXGkFCpZAuzyhFXDkwxpXwCiKkHSgfdXckqF6JA5BBGz/fVuCxKL1mPq5f8YdpBg1GE5GgA6HKqt4jCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eZyVBpiL; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GBP+CaMEl7MnqmxMwGqUJojqh1ffnB2fUKJYzNuvtes=; b=eZyVBpiLh56Nr8RM4dbBcQz3rm
	JN94LvAhDy5C1hltr5vf+jivnYAmwbDBlF6t7oigcwX+LClrGnstpdRXNJTpY/82gta/gAgXclF0Z
	UkAVxbo+2oKCa4nSKZ8+bfFuXAN1fjsbOYNvut/sQcTudrvh0ZSL6jx6LNG2fd99OJbFu+iRPwtYy
	HotoM48UtbVAbAeZFbiZZ4tEc6LEZus3Ea4CJ4mrKLr/SwZHC1+qgNnkdvYMwe6zU+g9tzxZAJYkz
	DP1jw6t08eJRcssvb4F3c+VoqWydgnSX4TaNKpNZb4kp1Krr1Qv+CdwZNhdFI8rukSPP2BtgDiZFI
	OQn7l6EA==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1UAI-00Biqr-QM; Thu, 17 Oct 2024 19:19:59 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 14/19] udf: Convert udf_add_nondir() to new directory iteration
Date: Thu, 17 Oct 2024 14:19:10 -0300
Message-Id: <20241017171915.311132-15-cascardo@igalia.com>
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

[ Upstream commit ef91f9998bece00cf7f82ad26177f910a7124b25 ]

Convert udf_add_nondir() to new directory iteration code.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/namei.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index bdf237dee120..0c3b06030f9d 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -847,26 +847,23 @@ static int udf_add_nondir(struct dentry *dentry, struct inode *inode)
 {
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	struct inode *dir = d_inode(dentry->d_parent);
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc cfi, *fi;
+	struct udf_fileident_iter iter;
 	int err;
 
-	fi = udf_add_entry(dir, dentry, &fibh, &cfi, &err);
-	if (unlikely(!fi)) {
+	err = udf_fiiter_add_entry(dir, dentry, &iter);
+	if (err) {
 		inode_dec_link_count(inode);
 		discard_new_inode(inode);
 		return err;
 	}
-	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
-	cfi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
-	*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
+	iter.fi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
+	iter.fi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
+	*(__le32 *)((struct allocDescImpUse *)iter.fi.icb.impUse)->impUse =
 		cpu_to_le32(iinfo->i_unique & 0x00000000FFFFFFFFUL);
-	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
+	udf_fiiter_write_fi(&iter, NULL);
 	dir->i_ctime = dir->i_mtime = current_time(dir);
 	mark_inode_dirty(dir);
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
+	udf_fiiter_release(&iter);
 	d_instantiate_new(dentry, inode);
 
 	return 0;
-- 
2.34.1


