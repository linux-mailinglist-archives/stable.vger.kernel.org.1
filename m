Return-Path: <stable+bounces-86669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBA99A2AB6
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 19:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A78F1F237A8
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 17:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2601DE2C8;
	Thu, 17 Oct 2024 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FOsClONM"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73691DF98B
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185615; cv=none; b=lxsRWkZG8bE44dDNC8KqDnTJ2hCcxeGjaqlC/0s4ngwQXiHX9dmsMbOgAXo7MO175weipuxiWTGDOmaFF9d3pELkySP7KarNkHXXtBnUrkdQ2hgSPkdOTG9ptpULoIfq9hyGx/N/DdosXuon4IhY5BtqQAfrT3FE8uOlO3RxEt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185615; c=relaxed/simple;
	bh=XgYvbA/+7+pVwW94Id7FvxByt66pqD61vL+2iH3Tmwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KTFTIjoTWp+pQPrim5AABSbc35GgbgTfaMxgPpDPF0k5PtMN8TaeJm/1JQbhlZdzn5XlawNuZLTIqSKABJLdurEjEjkYWbCWMH2M8qMnHQAkHskZqZuut4r13taMrFJaCVLYxulGmGMCnbkSrwu5SF082Ky6t14QjojsjjKGoMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FOsClONM; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=culot6hwRKJOB4DfrHq0feye3yg8jesz4QyzV1mRj9U=; b=FOsClONMwV/91pro2zYdczEcVy
	gn4hAacH3PiwvLhRmrY+nQlPxaCodVE6gzq8SADCEXXSYPw8lxu+PXgywahvvRMoM/tfNfuplhTv3
	W0taB4zpIL+cCD2/2AVaUbW3/AwfwRlwisYuxWsDinq5E4Vc8q9MBYyfxMux2WYgoo+32fBksZ1fy
	Pt/EK/hhHJUCjy4Mkzb8hLDjOitJzM5fGWB6vjeoWZo3sfwFziGcMDIN82axO+Jbp54+Ic/ID31xI
	kPW6M6tyYTGS0Al2v5CAnAk18ztKFZMyIQFBxKxKZAcl/MD876qCMKIVzd1Fgglg/B0mpmU82XR2X
	OqjERrCA==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1UAS-00Biqr-OA; Thu, 17 Oct 2024 19:20:09 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 18/19] udf: Handle error when expanding directory
Date: Thu, 17 Oct 2024 14:19:14 -0300
Message-Id: <20241017171915.311132-19-cascardo@igalia.com>
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

[ Upstream commit 33e9a53cd9f099b138578f8e1a3d60775ff8cbba ]

When there is an error when adding extent to the directory to expand it,
make sure to propagate the error up properly. This is not expected to
happen currently but let's make the code more futureproof.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/namei.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 75d029ae3d7d..7271aa8d7557 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -192,8 +192,13 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	epos.bh = NULL;
 	epos.block = iinfo->i_location;
 	epos.offset = udf_file_entry_alloc_offset(inode);
-	udf_add_aext(inode, &epos, &eloc, inode->i_size, 0);
+	ret = udf_add_aext(inode, &epos, &eloc, inode->i_size, 0);
 	brelse(epos.bh);
+	if (ret < 0) {
+		*err = ret;
+		udf_free_blocks(inode->i_sb, inode, &eloc, 0, 1);
+		return NULL;
+	}
 	mark_inode_dirty(inode);
 
 	/* Now fixup tags in moved directory entries */
-- 
2.34.1


