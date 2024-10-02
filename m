Return-Path: <stable+bounces-79528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C2C98D8ED
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F261C21DD3
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAE11D1510;
	Wed,  2 Oct 2024 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Qm/2W0fm"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015371D14EB
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877714; cv=none; b=OZ4YHHg+BJ3o5NYGbs95yuoGGMZ3e79D2nOiO7URn29BkOl5V09LVscvEovH40hPfm5BXp5EDuKHmJr3TMqVc792N/1FuGQu07+VSXvfPb9P9k9v0zdZ/MbviAS3cSAsGAxP0/BDJTJQoVUO70gsWGGO2fF4vXeH0sKZcEoYydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877714; c=relaxed/simple;
	bh=MNe1ldIv0+MPUp14reoa+3dzxyUpDf1suZBWlAbAHo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svEm1r0tPFUQVU+5I3dAsTXdKbOdA6jUbANyxX7e5RkzJliJHRlooHk2X48sdnmQNZ9RicS+fGVhuqhMvXlaF+3Ex7WIHrGvrtLy6hkgxk4BKDGHdUrqSxz7UDW638Jsc/48AG2q0cOyRcKsu3gx5NpP8WyfUOQbaKG4gCbHwxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Qm/2W0fm; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HKe+VWbd5lVGEOPukRFiLh5DN1Xmy5p/xwN9fOn6nRo=; b=Qm/2W0fm5bHofUpU3IxbxNsaD0
	0cmtUPLmQjiFyaXACZIA4uhP5MY5usrOlL/u8uE2v6lAQzh3htUwHOfmXSFWnOtJk5be3O2aHM1nY
	aXAKL0PP9Ii2Q5sYhBdQTsQ8I4iMCIy4oGY/OKefHAfDjFqE5T4GJkwqduHNbjIQm68Myy1RqRO5L
	vogepslsPMht8BlMpwfPaa+oplpgIe7ODLvHlojvxpwO7uFK0sEqauleq+yBvDAi+ft30gxbrPiPa
	IqWcCtcz8ahWvKcvAyl0RmE+H3ES0RkgXgBBVf6LXIcxLtSeOYm/Gdlib7T3dzsKJRgbpdr2gKEVT
	6UNHcHLA==;
Received: from 179-125-71-238-dinamico.pombonet.net.br ([179.125.71.238] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1svzvJ-003tUy-GH; Wed, 02 Oct 2024 16:01:50 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Christoph Hellwig <hch@infradead.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	kernel-dev@igalia.com
Subject: [PATCH 5.15,6.1 2/3] blk-integrity: convert to struct device_attribute
Date: Wed,  2 Oct 2024 11:01:21 -0300
Message-Id: <20241002140123.2311471-3-cascardo@igalia.com>
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

Upstream commit 76b8c319f02715e14abdbbbdd6508e83a1059bcc.

An upcoming patch will register the integrity attributes directly with
the struct device kobject.
For this the attributes have to be implemented in terms of
struct device_attribute.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Link: https://lore.kernel.org/r/20230309-kobj_release-gendisk_integrity-v3-2-ceccb4493c46@weissschuh.net
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 block/blk-integrity.c | 127 +++++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 65 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 7131f0d30f11..91a502b01fc7 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -212,21 +212,15 @@ bool blk_integrity_merge_bio(struct request_queue *q, struct request *req,
 	return true;
 }
 
-struct integrity_sysfs_entry {
-	struct attribute attr;
-	ssize_t (*show)(struct blk_integrity *, char *);
-	ssize_t (*store)(struct blk_integrity *, const char *, size_t);
-};
-
 static ssize_t integrity_attr_show(struct kobject *kobj, struct attribute *attr,
 				   char *page)
 {
 	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
-	struct blk_integrity *bi = &disk->queue->integrity;
-	struct integrity_sysfs_entry *entry =
-		container_of(attr, struct integrity_sysfs_entry, attr);
+	struct device *dev = disk_to_dev(disk);
+	struct device_attribute *dev_attr =
+		container_of(attr, struct device_attribute, attr);
 
-	return entry->show(bi, page);
+	return dev_attr->show(dev, dev_attr, page);
 }
 
 static ssize_t integrity_attr_store(struct kobject *kobj,
@@ -234,38 +228,53 @@ static ssize_t integrity_attr_store(struct kobject *kobj,
 				    size_t count)
 {
 	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
-	struct blk_integrity *bi = &disk->queue->integrity;
-	struct integrity_sysfs_entry *entry =
-		container_of(attr, struct integrity_sysfs_entry, attr);
-	ssize_t ret = 0;
+	struct device *dev = disk_to_dev(disk);
+	struct device_attribute *dev_attr =
+		container_of(attr, struct device_attribute, attr);
 
-	if (entry->store)
-		ret = entry->store(bi, page, count);
+	if (!dev_attr->store)
+		return 0;
+	return dev_attr->store(dev, dev_attr, page, count);
+}
 
-	return ret;
+static inline struct blk_integrity *dev_to_bi(struct device *dev)
+{
+	return &dev_to_disk(dev)->queue->integrity;
 }
 
-static ssize_t integrity_format_show(struct blk_integrity *bi, char *page)
+static ssize_t format_show(struct device *dev, struct device_attribute *attr,
+			   char *page)
 {
+	struct blk_integrity *bi = dev_to_bi(dev);
+
 	if (bi->profile && bi->profile->name)
 		return sysfs_emit(page, "%s\n", bi->profile->name);
 	return sysfs_emit(page, "none\n");
 }
 
-static ssize_t integrity_tag_size_show(struct blk_integrity *bi, char *page)
+static ssize_t tag_size_show(struct device *dev, struct device_attribute *attr,
+			     char *page)
 {
+	struct blk_integrity *bi = dev_to_bi(dev);
+
 	return sysfs_emit(page, "%u\n", bi->tag_size);
 }
 
-static ssize_t integrity_interval_show(struct blk_integrity *bi, char *page)
+static ssize_t protection_interval_bytes_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *page)
 {
+	struct blk_integrity *bi = dev_to_bi(dev);
+
 	return sysfs_emit(page, "%u\n",
 			  bi->interval_exp ? 1 << bi->interval_exp : 0);
 }
 
-static ssize_t integrity_verify_store(struct blk_integrity *bi,
-				      const char *page, size_t count)
+static ssize_t read_verify_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *page, size_t count)
 {
+	struct blk_integrity *bi = dev_to_bi(dev);
 	char *p = (char *) page;
 	unsigned long val = simple_strtoul(p, &p, 10);
 
@@ -277,14 +286,20 @@ static ssize_t integrity_verify_store(struct blk_integrity *bi,
 	return count;
 }
 
-static ssize_t integrity_verify_show(struct blk_integrity *bi, char *page)
+static ssize_t read_verify_show(struct device *dev,
+				struct device_attribute *attr, char *page)
 {
+	struct blk_integrity *bi = dev_to_bi(dev);
+
 	return sysfs_emit(page, "%d\n", !!(bi->flags & BLK_INTEGRITY_VERIFY));
 }
 
-static ssize_t integrity_generate_store(struct blk_integrity *bi,
-					const char *page, size_t count)
+static ssize_t write_generate_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *page, size_t count)
 {
+	struct blk_integrity *bi = dev_to_bi(dev);
+
 	char *p = (char *) page;
 	unsigned long val = simple_strtoul(p, &p, 10);
 
@@ -296,57 +311,39 @@ static ssize_t integrity_generate_store(struct blk_integrity *bi,
 	return count;
 }
 
-static ssize_t integrity_generate_show(struct blk_integrity *bi, char *page)
+static ssize_t write_generate_show(struct device *dev,
+				   struct device_attribute *attr, char *page)
 {
+	struct blk_integrity *bi = dev_to_bi(dev);
+
 	return sysfs_emit(page, "%d\n", !!(bi->flags & BLK_INTEGRITY_GENERATE));
 }
 
-static ssize_t integrity_device_show(struct blk_integrity *bi, char *page)
+static ssize_t device_is_integrity_capable_show(struct device *dev,
+						struct device_attribute *attr,
+						char *page)
 {
+	struct blk_integrity *bi = dev_to_bi(dev);
+
 	return sysfs_emit(page, "%u\n",
 			  !!(bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE));
 }
 
-static struct integrity_sysfs_entry integrity_format_entry = {
-	.attr = { .name = "format", .mode = 0444 },
-	.show = integrity_format_show,
-};
-
-static struct integrity_sysfs_entry integrity_tag_size_entry = {
-	.attr = { .name = "tag_size", .mode = 0444 },
-	.show = integrity_tag_size_show,
-};
-
-static struct integrity_sysfs_entry integrity_interval_entry = {
-	.attr = { .name = "protection_interval_bytes", .mode = 0444 },
-	.show = integrity_interval_show,
-};
-
-static struct integrity_sysfs_entry integrity_verify_entry = {
-	.attr = { .name = "read_verify", .mode = 0644 },
-	.show = integrity_verify_show,
-	.store = integrity_verify_store,
-};
-
-static struct integrity_sysfs_entry integrity_generate_entry = {
-	.attr = { .name = "write_generate", .mode = 0644 },
-	.show = integrity_generate_show,
-	.store = integrity_generate_store,
-};
-
-static struct integrity_sysfs_entry integrity_device_entry = {
-	.attr = { .name = "device_is_integrity_capable", .mode = 0444 },
-	.show = integrity_device_show,
-};
+static DEVICE_ATTR_RO(format);
+static DEVICE_ATTR_RO(tag_size);
+static DEVICE_ATTR_RO(protection_interval_bytes);
+static DEVICE_ATTR_RW(read_verify);
+static DEVICE_ATTR_RW(write_generate);
+static DEVICE_ATTR_RO(device_is_integrity_capable);
 
 static struct attribute *integrity_attrs[] = {
-	&integrity_format_entry.attr,
-	&integrity_tag_size_entry.attr,
-	&integrity_interval_entry.attr,
-	&integrity_verify_entry.attr,
-	&integrity_generate_entry.attr,
-	&integrity_device_entry.attr,
-	NULL,
+	&dev_attr_format.attr,
+	&dev_attr_tag_size.attr,
+	&dev_attr_protection_interval_bytes.attr,
+	&dev_attr_read_verify.attr,
+	&dev_attr_write_generate.attr,
+	&dev_attr_device_is_integrity_capable.attr,
+	NULL
 };
 ATTRIBUTE_GROUPS(integrity);
 
-- 
2.34.1


