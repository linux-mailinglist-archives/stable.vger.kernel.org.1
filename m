Return-Path: <stable+bounces-83076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9CC995515
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 18:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F1A1C24A28
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 16:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E441E0E1F;
	Tue,  8 Oct 2024 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="N6za2VVc"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9A01E0E1C
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406408; cv=none; b=geeIiwhu7aPK4ElOQa93PEfRMCu8O1ukH6S4KqW3lri2rhucMH/28Mq8uRjfJycY0b1npw8IMN9MBdHuaG2rpzoecaVdZHWbLNPu7A8NtnwzlISIJ8Mq78ZLcZY+Cdp/rn/0es2DiH8ztpgfB4Ya9uKfvoKvrD0bZsNO/PGMgbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406408; c=relaxed/simple;
	bh=rL0MaoaPRUFNOqhcp1c45TPTF2EMiFWUdnqQcNH+NTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2qbhhtjafv+bVk5lsu1MnrpIRlWGSjmdm/IVNFN/RTm/Lif2FH6IXEZdudheifKZ/Vxs8b3Wt+m9Vu7BDOjZbIK3DMjD/TynD6/7JNbkehpT2GluKOIBBZyu53fxE6OR3Qkm1hwN5qLbo4bwhNXeHgW4vHEjzxprkMwklg6NcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=N6za2VVc; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AMUlgTG0A/opBPXFTsxFfv7mFV+HOzteHoWz27wt99Q=; b=N6za2VVcLnSsh21iAjKOKaJPji
	zNhK3jF65H3dvw+gjP380XZ6laOfVkKFhfcB1pk8T0bQXLZaezNQnC7SPddKA4scxRRMdNFRj4W/f
	LmIAoIqfafSKoYtT+dopsSQ8Nxks26D65jWmnTmOYBebcOOL9NIDWbDPGFEm81OIUeHdzqV9jZRG0
	+MpYTzWU8cxPSjly5jOCNaGbHSvZMyeAB9zcD4+L4NvjqyWS9Jx4cmfpZN0KlBb79ggJKxc7HqLl7
	HX3wB22gQw3bnER/uEMIeBaAo5qt/OqXTmgal/zXsb+SCuNVvZUQPfw4MuytOGTcLy118UfotCi3U
	ZThEtIZw==;
Received: from 179-125-64-236-dinamico.pombonet.net.br ([179.125.64.236] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1syDSe-006dsM-Gj; Tue, 08 Oct 2024 18:53:25 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Jens Axboe <axboe@kernel.dk>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Christoph Hellwig <hch@infradead.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	kernel-dev@igalia.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5.15 3/3] blk-integrity: register sysfs attributes on struct device
Date: Tue,  8 Oct 2024 13:53:07 -0300
Message-Id: <20241008165307.4170334-4-cascardo@igalia.com>
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

Upstream commit ff53cd52d9bdbf4074d2bbe9b591729997780bd3.

The "integrity" kobject only acted as a holder for static sysfs entries.
It also was embedded into struct gendisk without managing it, violating
assumptions of the driver core.

Instead register the sysfs entries directly onto the struct device.

Also drop the now unused member integrity_kobj from struct gendisk.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Link: https://lore.kernel.org/r/20230309-kobj_release-gendisk_integrity-v3-3-ceccb4493c46@weissschuh.net
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[cascardo: conflict because of constification of integrity_ktype]
[cascardo: struct gendisk is defined at include/linux/genhd.h]
[cascardo: there is no blk_trace_attr_group]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 block/blk-integrity.c | 55 +++----------------------------------------
 block/blk.h           | 10 +-------
 block/genhd.c         | 12 ++++------
 include/linux/genhd.h |  3 ---
 4 files changed, 8 insertions(+), 72 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 8868b1e01d58..fbbb38cc9e8a 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -212,31 +212,6 @@ bool blk_integrity_merge_bio(struct request_queue *q, struct request *req,
 	return true;
 }
 
-static ssize_t integrity_attr_show(struct kobject *kobj, struct attribute *attr,
-				   char *page)
-{
-	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
-	struct device *dev = disk_to_dev(disk);
-	struct device_attribute *dev_attr =
-		container_of(attr, struct device_attribute, attr);
-
-	return dev_attr->show(dev, dev_attr, page);
-}
-
-static ssize_t integrity_attr_store(struct kobject *kobj,
-				    struct attribute *attr, const char *page,
-				    size_t count)
-{
-	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
-	struct device *dev = disk_to_dev(disk);
-	struct device_attribute *dev_attr =
-		container_of(attr, struct device_attribute, attr);
-
-	if (!dev_attr->store)
-		return 0;
-	return dev_attr->store(dev, dev_attr, page, count);
-}
-
 static inline struct blk_integrity *dev_to_bi(struct device *dev)
 {
 	return &dev_to_disk(dev)->queue->integrity;
@@ -345,16 +320,10 @@ static struct attribute *integrity_attrs[] = {
 	&dev_attr_device_is_integrity_capable.attr,
 	NULL
 };
-ATTRIBUTE_GROUPS(integrity);
 
-static const struct sysfs_ops integrity_ops = {
-	.show	= &integrity_attr_show,
-	.store	= &integrity_attr_store,
-};
-
-static struct kobj_type integrity_ktype = {
-	.default_groups = integrity_groups,
-	.sysfs_ops	= &integrity_ops,
+const struct attribute_group blk_integrity_attr_group = {
+	.name = "integrity",
+	.attrs = integrity_attrs,
 };
 
 static blk_status_t blk_integrity_nop_fn(struct blk_integrity_iter *iter)
@@ -431,21 +400,3 @@ void blk_integrity_unregister(struct gendisk *disk)
 	memset(bi, 0, sizeof(*bi));
 }
 EXPORT_SYMBOL(blk_integrity_unregister);
-
-int blk_integrity_add(struct gendisk *disk)
-{
-	int ret;
-
-	ret = kobject_init_and_add(&disk->integrity_kobj, &integrity_ktype,
-				   &disk_to_dev(disk)->kobj, "%s", "integrity");
-	if (!ret)
-		kobject_uevent(&disk->integrity_kobj, KOBJ_ADD);
-	return ret;
-}
-
-void blk_integrity_del(struct gendisk *disk)
-{
-	kobject_uevent(&disk->integrity_kobj, KOBJ_REMOVE);
-	kobject_del(&disk->integrity_kobj);
-	kobject_put(&disk->integrity_kobj);
-}
diff --git a/block/blk.h b/block/blk.h
index aab72194d226..e90a5e348512 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -130,8 +130,7 @@ static inline bool integrity_req_gap_front_merge(struct request *req,
 				bip_next->bip_vec[0].bv_offset);
 }
 
-int blk_integrity_add(struct gendisk *disk);
-void blk_integrity_del(struct gendisk *);
+extern const struct attribute_group blk_integrity_attr_group;
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 static inline bool blk_integrity_merge_rq(struct request_queue *rq,
 		struct request *r1, struct request *r2)
@@ -164,13 +163,6 @@ static inline bool bio_integrity_endio(struct bio *bio)
 static inline void bio_integrity_free(struct bio *bio)
 {
 }
-static inline int blk_integrity_add(struct gendisk *disk)
-{
-	return 0;
-}
-static inline void blk_integrity_del(struct gendisk *disk)
-{
-}
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
 unsigned long blk_rq_timeout(unsigned long timeout);
diff --git a/block/genhd.c b/block/genhd.c
index 4d28f1d5f9b0..88d1a6385a24 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -467,15 +467,11 @@ int device_add_disk(struct device *parent, struct gendisk *disk,
 	 */
 	pm_runtime_set_memalloc_noio(ddev, true);
 
-	ret = blk_integrity_add(disk);
-	if (ret)
-		goto out_del_block_link;
-
 	disk->part0->bd_holder_dir =
 		kobject_create_and_add("holders", &ddev->kobj);
 	if (!disk->part0->bd_holder_dir) {
 		ret = -ENOMEM;
-		goto out_del_integrity;
+		goto out_del_block_link;
 	}
 	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
 	if (!disk->slave_dir) {
@@ -535,8 +531,6 @@ int device_add_disk(struct device *parent, struct gendisk *disk,
 	disk->slave_dir = NULL;
 out_put_holder_dir:
 	kobject_put(disk->part0->bd_holder_dir);
-out_del_integrity:
-	blk_integrity_del(disk);
 out_del_block_link:
 	if (!sysfs_deprecated)
 		sysfs_remove_link(block_depr, dev_name(ddev));
@@ -592,7 +586,6 @@ void del_gendisk(struct gendisk *disk)
 	if (WARN_ON_ONCE(!disk_live(disk) && !(disk->flags & GENHD_FL_HIDDEN)))
 		return;
 
-	blk_integrity_del(disk);
 	disk_del_events(disk);
 
 	mutex_lock(&disk->open_mutex);
@@ -1084,6 +1077,9 @@ static struct attribute_group disk_attr_group = {
 
 static const struct attribute_group *disk_attr_groups[] = {
 	&disk_attr_group,
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	&blk_integrity_attr_group,
+#endif
 	NULL
 };
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 690b7f7996d1..3f49a3a30e9b 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -144,9 +144,6 @@ struct gendisk {
 	struct timer_rand_state *random;
 	atomic_t sync_io;		/* RAID */
 	struct disk_events *ev;
-#ifdef  CONFIG_BLK_DEV_INTEGRITY
-	struct kobject integrity_kobj;
-#endif	/* CONFIG_BLK_DEV_INTEGRITY */
 #if IS_ENABLED(CONFIG_CDROM)
 	struct cdrom_device_info *cdi;
 #endif
-- 
2.34.1

