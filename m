Return-Path: <stable+bounces-86694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4889A2E58
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 22:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56B828447E
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 20:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF5F1DFE2A;
	Thu, 17 Oct 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sAVKrWkT"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8C821D198
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196429; cv=none; b=gAanB63H+/sBLQ5YnFWcGFNOcAG2E5hUAN0kefHuhpMzgjiPyNUyKxwoLBby9qtorcAMU+Xo6dULEXoWr4ZQXNe8t1Prj6etih4xMXTZmO1OnXfPPf2tnIICXnOiBcNC1DK+0Wyesf0gCE/cjJN3EdDtV1XM71uzziM3XDhtABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196429; c=relaxed/simple;
	bh=lv/mC76UwEBxDxjtQqUmQvXtiSsN0QYRW6oZiNqHRPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y7oboCRA0xO5vutGTa7Jpt98/BMifhXcV9uJ2eQeXKolrEbIUQqejjDGmbMPkR42ttkrua12X5zeKSWWL/7aSjcfpRy+HX42dlZb6wTiZyfaDQRC+wlu4EhBwTwctIwDLpepX5qVgIGbFtMIyyb/r1X7DUVL9cswxv/0Kglfw2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sAVKrWkT; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FIdT0aVCXQxwITSUNSL5e5iqVbrZ6MnlQyOqBr3el8g=; b=sAVKrWkTnZ7IU01vDucqTe65Lk
	UtCgY+17EUycLvESCbOri/e2nYF9b3RcBDFmluWfuisfJg8GNop/z3sj1e5xFn5xXpU6jX6blf+Ep
	mjni2JLREIKVt9o39CxVlv1rF2tsjwfKDygJQe34ms3UCn49WjST39jQ/0CEcEeEBnO87bjWgFSTX
	PZqzKaOSB+2pG+bfV3UJiMhGJQf4zytR1ZQQv7QcnDDYlK5H1o+tJ3Tm2jcsetDJ1MhvOj1gVFOva
	+4GMv9Io+VMrsx9cvJzZ+z09bkPaEykMWjt1H7DMDlfSICY2g/AYZjtmK3mGdDD0gYGGTnzO0BwnK
	/RDWpYeg==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1Wys-00BmZ7-3a; Thu, 17 Oct 2024 22:20:22 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.15 05/20] udf: Provide function to mark entry as deleted using new directory iteration code
Date: Thu, 17 Oct 2024 17:19:47 -0300
Message-Id: <20241017202002.406428-6-cascardo@igalia.com>
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

[ Upstream commit 4cca7e3df7bea8661a0c2a70c0d250e9aa5cedb4 ]

Provide function udf_fiiter_delete_entry() to mark directory entry as
deleted using new directory iteration code.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/namei.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 61a7a7ab9aa7..7019ee58da10 100644
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


