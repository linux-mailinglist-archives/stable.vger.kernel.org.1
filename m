Return-Path: <stable+bounces-172596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C75B328D4
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB9C5A26A9
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 13:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735D5245014;
	Sat, 23 Aug 2025 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAoAR1Ne"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B44243399
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755956630; cv=none; b=CiJG3HBhcj+E5YXE9X23FybL9J+9fAcOp/Oq5mNw8tshkH6eokGNsf7OMrSAJloFxrWOVi4UOUuog4x1ATyogPJ+vf7oRufQi9Z0jbTG/Eng5rEI9Hdxibsi8my0WfASKVDOkojQDR6SzsJgYPNv7ws6104BEoMPezxplqXV/XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755956630; c=relaxed/simple;
	bh=QPyL9FaJuuPyrsICzcrcMdqXlnoJgXA2Z3uwvHiCB28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d52qkZTwrqVEN4+GD+LTeTzQDtkN0QUmn2ON4agCig0E4tCjPRctBlF0EMVrVKXtqCxtHHUjYEIl/P+8zx0siVtNJ28u9Z+GldINmrfuWJQo1tNO7knIiTwx8TGFkYSN+nAk6ZZ7KZk+jJRfU0oL6PFh5dC14ZDEa/sjg9q4D00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAoAR1Ne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB63C4CEF4;
	Sat, 23 Aug 2025 13:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755956629;
	bh=QPyL9FaJuuPyrsICzcrcMdqXlnoJgXA2Z3uwvHiCB28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fAoAR1NepNU+qv/+TLkiO0iXkfHqeJYasZ04+piobhjzXssfuRvjKTHGrI5HwaJCk
	 8v+xiuzFM50e2zprw/H/AS8IyE5CyyW2wiAFjVBBvwm9NzNjlJiXmlIWXR/UZANU6Z
	 4rkeK1pbl7jcOy4zgQygBUyL6pzyjyL7dSaslxsRafQB/7hBCP83ZnqRFKHWHWopCa
	 JqdD3On43sccCQKVrpB9WicZl/uj6aUP+eV/bC/8dAt0TQcFJfEUUvs7qX2QSE9y0r
	 aiY6N5g9bthtgptX62gUQsFFZUH2WExQH0E1NVJNr1WgUu5jeinna3hWCgLZIamMIk
	 lB2WcRFkIHfMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>,
	Eric Auger <eric.auger@redhat.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 2/2] iommu/virtio: Make instance lookup robust
Date: Sat, 23 Aug 2025 09:43:46 -0400
Message-ID: <20250823134346.2145572-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823134346.2145572-1-sashal@kernel.org>
References: <2025082258-exert-mousy-2b51@gregkh>
 <20250823134346.2145572-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 72b6f7cd89cea8251979b65528d302f9c0ed37bf ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/virtio-iommu.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

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
-- 
2.50.1


