Return-Path: <stable+bounces-79526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C70A98D8EA
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2D21C20D49
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17BC1D1501;
	Wed,  2 Oct 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KaMTRPmT"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A359F1D0DDC
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877712; cv=none; b=br+dEo5i0Tc2Avub3zf863FAAmGrqe1NMSr6v6WR0AVCPXXOgKbp7ANKhgJQXPYifyo9KkCN9hhWpdGgCREBKCCDm2OpZqZStFVXtUB72HW5ldF1wJ1J4wZorr97Zs2gpJjFBI8qyCXIoJ99deIKzpmvUGk15kFLaPkMEnXZFqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877712; c=relaxed/simple;
	bh=i5WTkrkzTWhsE7Nh7SqWHANpe4IwY4VTeXa+zSOEouI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBf7whlomlIaoczyp5yjVm580HsOxIIhvdP2b6oezRnMB4NfhwtZAiN3KoXbjIBDZBZ2932euL7evKiZuY8bUmBriDdyJUHlUwnm5t+fS7rraJeBO6DqBGql/P5ucGztAiGSUVxT3Ilw0DEeY5ZqthNUYG9lGaD4JbweBP2G06s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KaMTRPmT; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yPQaY7xRzgZbrepa7mjE/ANK7D4phjDzwj9CRhc503M=; b=KaMTRPmTcqF/qlrgAoBD1k4mxi
	ohcl01lrfLZkjLHY1g4GJsvHTkDTg34gLRIjGZy35BJE41peQ6Z+OEOA69GoB3IwvIP6Q1+ByUWJx
	BfNTTGaJXJ0izvuEsIjHkSGRAAD67+8JCIP/6yu0EtQ8nBVMqw4tW+TBf8YWvdws4UvbAjFIi4VUI
	c+VPqDyBXKrf3T3c1RFT23POeQyldRc5ibFv86WqhKQ0f2grX2cTnOBRO/ekUFkkksgiQX6DYMm1q
	qAt/dkd71ZO0LJD57dASACKXlIkr3Op5GuKYLrmMdKNYUoqG/ttfcu0xzEBBvPJkfSPMbgCTxofqp
	M5QvdKkQ==;
Received: from 179-125-71-238-dinamico.pombonet.net.br ([179.125.71.238] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1svzvG-003tUy-0l; Wed, 02 Oct 2024 16:01:46 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Christoph Hellwig <hch@infradead.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	kernel-dev@igalia.com
Subject: [PATCH 5.15,6.1 1/3] blk-integrity: use sysfs_emit
Date: Wed,  2 Oct 2024 11:01:20 -0300
Message-Id: <20241002140123.2311471-2-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002140123.2311471-1-cascardo@igalia.com>
References: <20241002140123.2311471-1-cascardo@igalia.com>
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


