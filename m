Return-Path: <stable+bounces-172394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6368B31A67
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 15:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C73FB0168F
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 13:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0840D30146C;
	Fri, 22 Aug 2025 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RKGO0C+H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AF13043C1
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870902; cv=none; b=cCuFFaq5MeWM4VtaWRp/qmtGZKyeDw1MR9iHoEUfQDemhgHlxeWHbCZ/27tKiuYfmWt9aaHDJU23DtDgQyacvnxpCdtJrXZ7kClPMuRTbYe0ZbsBEQkFEm5orkoE74FYUBHWaTvfCCtF12ghkIN4Dnk/0OJFce9phomK8g2Ka1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870902; c=relaxed/simple;
	bh=ZVtG+4mZEw6uQGNiFEKWK9YIvBN3J3nTWwLMbVtijqk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZrfaCemiAAOVxs9IedkYst6Rme3SGF5ywXHXANSILBwXF2xBmGDtN9WAN19fkBhBUyuEvnFh1gQrxD8SsdmgT0XTUqL/mhPEh+WO5pVMFx4bpqWsUScERJ2uiBke5As2hHEKBUPC77JdDHryUKWHWz+Vz4JGhm2Xtcu8PEjvQ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RKGO0C+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12E2C4CEED;
	Fri, 22 Aug 2025 13:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755870902;
	bh=ZVtG+4mZEw6uQGNiFEKWK9YIvBN3J3nTWwLMbVtijqk=;
	h=Subject:To:Cc:From:Date:From;
	b=RKGO0C+HvQ5PNeVakfuMWpCtQf8sY0HAZnFExiIMfAfar1l62nwP9PK//64XgUpXv
	 s/qd9zPq1QuQ4oBk/AwCFDfm0gcjLdikPL0xZ+9zV2ZV7or/AwIViDBRJYptBX1J39
	 V8UFrLqAraTXe9JjpOzCFQTpHSuUSByD0iX21JGo=
Subject: FAILED: patch "[PATCH] iommu/virtio: Make instance lookup robust" failed to apply to 6.16-stable tree
To: robin.murphy@arm.com,eric.auger@redhat.com,joerg.roedel@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 15:54:58 +0200
Message-ID: <2025082258-exert-mousy-2b51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x 72b6f7cd89cea8251979b65528d302f9c0ed37bf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082258-exert-mousy-2b51@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 72b6f7cd89cea8251979b65528d302f9c0ed37bf Mon Sep 17 00:00:00 2001
From: Robin Murphy <robin.murphy@arm.com>
Date: Thu, 14 Aug 2025 17:47:16 +0100
Subject: [PATCH] iommu/virtio: Make instance lookup robust

Much like arm-smmu in commit 7d835134d4e1 ("iommu/arm-smmu: Make
instance lookup robust"), virtio-iommu appears to have the same issue
where iommu_device_register() makes the IOMMU instance visible to other
API callers (including itself) straight away, but internally the
instance isn't ready to recognise itself for viommu_probe_device() to
work correctly until after viommu_probe() has returned. This matters a
lot more now that bus_iommu_probe() has the DT/VIOT knowledge to probe
client devices the way that was always intended. Tweak the lookup and
initialisation in much the same way as for arm-smmu, to ensure that what
we register is functional and ready to go.

Cc: stable@vger.kernel.org
Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Link: https://lore.kernel.org/r/308911aaa1f5be32a3a709996c7bd6cf71d30f33.1755190036.git.robin.murphy@arm.com
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 532db1de201b..b39d6f134ab2 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -998,8 +998,7 @@ static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
 	iommu_dma_get_resv_regions(dev, head);
 }
 
-static const struct iommu_ops viommu_ops;
-static struct virtio_driver virtio_iommu_drv;
+static const struct bus_type *virtio_bus_type;
 
 static int viommu_match_node(struct device *dev, const void *data)
 {
@@ -1008,8 +1007,9 @@ static int viommu_match_node(struct device *dev, const void *data)
 
 static struct viommu_dev *viommu_get_by_fwnode(struct fwnode_handle *fwnode)
 {
-	struct device *dev = driver_find_device(&virtio_iommu_drv.driver, NULL,
-						fwnode, viommu_match_node);
+	struct device *dev = bus_find_device(virtio_bus_type, NULL, fwnode,
+					     viommu_match_node);
+
 	put_device(dev);
 
 	return dev ? dev_to_virtio(dev)->priv : NULL;
@@ -1160,6 +1160,9 @@ static int viommu_probe(struct virtio_device *vdev)
 	if (!viommu)
 		return -ENOMEM;
 
+	/* Borrow this for easy lookups later */
+	virtio_bus_type = dev->bus;
+
 	spin_lock_init(&viommu->request_lock);
 	ida_init(&viommu->domain_ids);
 	viommu->dev = dev;
@@ -1229,10 +1232,10 @@ static int viommu_probe(struct virtio_device *vdev)
 	if (ret)
 		goto err_free_vqs;
 
-	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
-
 	vdev->priv = viommu;
 
+	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
+
 	dev_info(dev, "input address: %u bits\n",
 		 order_base_2(viommu->geometry.aperture_end));
 	dev_info(dev, "page mask: %#llx\n", viommu->pgsize_bitmap);


