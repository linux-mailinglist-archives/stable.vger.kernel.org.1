Return-Path: <stable+bounces-86655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE91F9A2AAC
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 19:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49732831E2
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 17:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4561A1DF99F;
	Thu, 17 Oct 2024 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Rzn799Ei"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114141DF998
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185586; cv=none; b=JCsHJl2Pt/TdZUXzga/8pg7a7Dd9tamCadTiOQqTAKML/4i2e+pFm8+Y3T1Qi/Ksm9PitRrwWoJIKg11BNQmz4XH1KaswCgRSBxlTs7u1Txol9vOEaEUGLRdrzA8IaTYb6tZleSylRiDFmz0sfp0tyRlPTv8vysyMcsSWa2gnVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185586; c=relaxed/simple;
	bh=rlIkNb70kPbS4slTQJoloim+kzrbYINGgAI/PLS9+g8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iz2Pr1adbWtQ2Azsc3p9QazQ6eSxNLupqW5DT5gIIWDu5/7nTzZZI8rTm6cXDmxOuWabLS0fd3GUCpDRllCjj0dnmVbs4BLTTIFtAwTrD90MNjkRLpR5A4g7SMpp9frTcvkGV8vcIW2oIkDMFEnPikZqO5Kvr41oOc+UuyUX4n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Rzn799Ei; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8YoDlDzK25gV5jK81yAyz+ndfKPjePDD1TGVaIVAUJc=; b=Rzn799EiqCdgHlFgsKOI0wcglv
	k/f8ymNOCUok+WllMIknCeLtEXil9eKpC+dgDVZ1pVU45YMlGH0vcf3cg0kgCshIQgyi2lApVnAP9
	CW5u+H+yvyyWJpORvgoWipnAhj/IQeyOQg0Om9j1xrs8s1wPRZGEYKtFnpehwDXJLyWVLkzQcF8+H
	Gc1ObiosoAfXmv6bOyZfj/m+Y3AHy2qEXFloPYUFBFLYvpshAowwW5PocpJnYh+Q+JHDxXCJn3bm9
	CuXDU6rdTerI1WkA3BDjb6NJMYWuVEOCt2sQII+u96qjyst3z1n665f92pYcUGXRrYor5k0WL1EMk
	q4GEwvUQ==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1U9y-00Biqr-Km; Thu, 17 Oct 2024 19:19:39 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 05/19] udf: Provide function to mark entry as deleted using new directory iteration code
Date: Thu, 17 Oct 2024 14:19:01 -0300
Message-Id: <20241017171915.311132-6-cascardo@igalia.com>
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

[ Upstream commit 4cca7e3df7bea8661a0c2a70c0d250e9aa5cedb4 ]

Provide function udf_fiiter_delete_entry() to mark directory entry as
deleted using new directory iteration code.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/namei.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index d1d803b4fee8..f9e7fe80a066 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -714,6 +714,16 @@ static struct fileIdentDesc *udf_add_entry(struct inode *dir,
 	return fi;
 }
 
+static void udf_fiiter_delete_entry(struct udf_fileident_iter *iter)
+{
+	iter->fi.fileCharacteristics |= FID_FILE_CHAR_DELETED;
+
+	if (UDF_QUERY_FLAG(iter->dir->i_sb, UDF_FLAG_STRICT))
+		memset(&iter->fi.icb, 0x00, sizeof(struct long_ad));
+
+	udf_fiiter_write_fi(iter, NULL);
+}
+
 static int udf_delete_entry(struct inode *inode, struct fileIdentDesc *fi,
 			    struct udf_fileident_bh *fibh,
 			    struct fileIdentDesc *cfi)
-- 
2.34.1


