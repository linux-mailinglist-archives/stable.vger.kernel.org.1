Return-Path: <stable+bounces-83074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77774995513
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 18:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ECA31F26E59
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2067B1E0E16;
	Tue,  8 Oct 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ojn4jyEh"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108881E0DEB
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406401; cv=none; b=lu5LHZ84uPbNa0QZLJTBXGQwedpYl5LIckxZhxrjY3g97kofFyR1Tzj6pHJmgGhn9GuOhWSvHmuDBlUcLYlvEAeIsRHMthdOMXgwRLg3tWXDWkcSFVu0R9F3dC+UBw2S8WwbSZGoEH9RtvovDZF7QbJus5XQaNufktE9SXbD7t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406401; c=relaxed/simple;
	bh=i5WTkrkzTWhsE7Nh7SqWHANpe4IwY4VTeXa+zSOEouI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMyJcJl2iFnQAbQXMMS4STqTA3JGqijpxby7Eq2aYsxYWJmZvFD0qRzo3l6RR2a1c1kM+5Cy6GZ8O1mxcKyM0bwz+uFjxG+nllnTB8aRT5++BXdxx935cfEbRYr3ToiT1tjNQuZYKoY13Qu8K6/f6bVe4MmJQDHumbV8dS3ltck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ojn4jyEh; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yPQaY7xRzgZbrepa7mjE/ANK7D4phjDzwj9CRhc503M=; b=ojn4jyEhodkdZzSL4ARfXWo0kr
	sZ7A26SBDPf02h4ugypimTZx0ddxgGD8iDm2Mxc9cr7KfRI90WFdfrTyzjsI1tJYWMs0mbo0JLFjN
	lPxrg4ho21uwBIxvAD5RXVFOnElPkts1ZTJ6kV6K701otIaol5RjDkFrBuq7z5fHs5BM9q+1AkLin
	G3WaFKPzqwgmPItuaBsaPUBJxW08UE/N1UbkfwP91qd38zKDYm2XkEeV7eU/PQJ5DmZGJlFggDrsA
	ecCGaEqeq6Vz45miJnoeWasAuyYZEqQf0nq6OFVcwCm2+giDH4VJvhr5sOXZXuZF0+vhSkoCm4k9q
	9mJ0pS/w==;
Received: from 179-125-64-236-dinamico.pombonet.net.br ([179.125.64.236] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1syDSX-006dsM-Hw; Tue, 08 Oct 2024 18:53:18 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Jens Axboe <axboe@kernel.dk>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Christoph Hellwig <hch@infradead.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	kernel-dev@igalia.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5.15 1/3] blk-integrity: use sysfs_emit
Date: Tue,  8 Oct 2024 13:53:05 -0300
Message-Id: <20241008165307.4170334-2-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008165307.4170334-1-cascardo@igalia.com>
References: <20241008165307.4170334-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

Upstream commit 3315e169b446249c1b61ff988d157238f4b2c5a0.

The correct way to emit data into sysfs is via sysfs_emit(), use it.

Also perform some trivial syntactic cleanups.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Link: https://lore.kernel.org/r/20230309-kobj_release-gendisk_integrity-v3-1-ceccb4493c46@weissschuh.net
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 block/blk-integrity.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index e2d88611d5bf..7131f0d30f11 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -248,20 +248,19 @@ static ssize_t integrity_attr_store(struct kobject *kobj,
 static ssize_t integrity_format_show(struct blk_integrity *bi, char *page)
 {
 	if (bi->profile && bi->profile->name)
-		return sprintf(page, "%s\n", bi->profile->name);
-	else
-		return sprintf(page, "none\n");
+		return sysfs_emit(page, "%s\n", bi->profile->name);
+	return sysfs_emit(page, "none\n");
 }
 
 static ssize_t integrity_tag_size_show(struct blk_integrity *bi, char *page)
 {
-	return sprintf(page, "%u\n", bi->tag_size);
+	return sysfs_emit(page, "%u\n", bi->tag_size);
 }
 
 static ssize_t integrity_interval_show(struct blk_integrity *bi, char *page)
 {
-	return sprintf(page, "%u\n",
-		       bi->interval_exp ? 1 << bi->interval_exp : 0);
+	return sysfs_emit(page, "%u\n",
+			  bi->interval_exp ? 1 << bi->interval_exp : 0);
 }
 
 static ssize_t integrity_verify_store(struct blk_integrity *bi,
@@ -280,7 +279,7 @@ static ssize_t integrity_verify_store(struct blk_integrity *bi,
 
 static ssize_t integrity_verify_show(struct blk_integrity *bi, char *page)
 {
-	return sprintf(page, "%d\n", (bi->flags & BLK_INTEGRITY_VERIFY) != 0);
+	return sysfs_emit(page, "%d\n", !!(bi->flags & BLK_INTEGRITY_VERIFY));
 }
 
 static ssize_t integrity_generate_store(struct blk_integrity *bi,
@@ -299,13 +298,13 @@ static ssize_t integrity_generate_store(struct blk_integrity *bi,
 
 static ssize_t integrity_generate_show(struct blk_integrity *bi, char *page)
 {
-	return sprintf(page, "%d\n", (bi->flags & BLK_INTEGRITY_GENERATE) != 0);
+	return sysfs_emit(page, "%d\n", !!(bi->flags & BLK_INTEGRITY_GENERATE));
 }
 
 static ssize_t integrity_device_show(struct blk_integrity *bi, char *page)
 {
-	return sprintf(page, "%u\n",
-		       (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE) != 0);
+	return sysfs_emit(page, "%u\n",
+			  !!(bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE));
 }
 
 static struct integrity_sysfs_entry integrity_format_entry = {
-- 
2.34.1

