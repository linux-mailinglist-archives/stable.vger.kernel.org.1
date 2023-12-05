Return-Path: <stable+bounces-4689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205A7805819
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 16:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA06281D9D
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 15:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB0367E7B;
	Tue,  5 Dec 2023 15:02:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65773129
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 07:02:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B23D2139F;
	Tue,  5 Dec 2023 07:02:46 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 69B6B3F6C4;
	Tue,  5 Dec 2023 07:01:59 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: stable@vger.kernel.org
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 6.1.y] iommu: Avoid more races around device probe
Date: Tue,  5 Dec 2023 15:01:45 +0000
Message-Id: <4a349b612b726d42b35611368f0f49e447e16dff.1701788504.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <2023120303-purposely-museum-96a7@gregkh>
References: <2023120303-purposely-museum-96a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It turns out there are more subtle races beyond just the main part of
__iommu_probe_device() itself running in parallel - the dev_iommu_free()
on the way out of an unsuccessful probe can still manage to trip up
concurrent accesses to a device's fwspec. Thus, extend the scope of
iommu_probe_device_lock() to also serialise fwspec creation and initial
retrieval.

Reported-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Link: https://lore.kernel.org/linux-iommu/e2e20e1c-6450-4ac5-9804-b0000acdf7de@quicinc.com/
Fixes: 01657bc14a39 ("iommu: Avoid races around device probe")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: André Draszik <andre.draszik@linaro.org>
Tested-by: André Draszik <andre.draszik@linaro.org>
Link: https://lore.kernel.org/r/16f433658661d7cadfea51e7c65da95826112a2b.1700071477.git.robin.murphy@arm.com
Cc: stable@vger.kernel.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
(cherry picked from commit a2e7e59a94269484a83386972ca07c22fd188854)
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/acpi/scan.c      |  7 ++++++-
 drivers/iommu/iommu.c    | 19 +++++++++----------
 drivers/iommu/of_iommu.c | 12 +++++++++---
 include/linux/iommu.h    |  1 +
 4 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a0e347f6f97e..94154a849a3e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1563,17 +1563,22 @@ static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
 	int err;
 	const struct iommu_ops *ops;
 
+	/* Serialise to make dev->iommu stable under our potential fwspec */
+	mutex_lock(&iommu_probe_device_lock);
 	/*
 	 * If we already translated the fwspec there is nothing left to do,
 	 * return the iommu_ops.
 	 */
 	ops = acpi_iommu_fwspec_ops(dev);
-	if (ops)
+	if (ops) {
+		mutex_unlock(&iommu_probe_device_lock);
 		return ops;
+	}
 
 	err = iort_iommu_configure_id(dev, id_in);
 	if (err && err != -EPROBE_DEFER)
 		err = viot_iommu_configure(dev);
+	mutex_unlock(&iommu_probe_device_lock);
 
 	/*
 	 * If we have reason to believe the IOMMU driver missed the initial
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2bcd1f23d07d..8b3897239477 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -278,12 +278,13 @@ static void dev_iommu_free(struct device *dev)
 	kfree(param);
 }
 
+DEFINE_MUTEX(iommu_probe_device_lock);
+
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 	struct iommu_device *iommu_dev;
 	struct iommu_group *group;
-	static DEFINE_MUTEX(iommu_probe_device_lock);
 	int ret;
 
 	if (!ops)
@@ -295,11 +296,9 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	 * probably be able to use device_lock() here to minimise the scope,
 	 * but for now enforcing a simple global ordering is fine.
 	 */
-	mutex_lock(&iommu_probe_device_lock);
-	if (!dev_iommu_get(dev)) {
-		ret = -ENOMEM;
-		goto err_unlock;
-	}
+	lockdep_assert_held(&iommu_probe_device_lock);
+	if (!dev_iommu_get(dev))
+		return -ENOMEM;
 
 	if (!try_module_get(ops->owner)) {
 		ret = -EINVAL;
@@ -326,7 +325,6 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 
-	mutex_unlock(&iommu_probe_device_lock);
 	iommu_device_link(iommu_dev, dev);
 
 	return 0;
@@ -341,9 +339,6 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 err_free:
 	dev_iommu_free(dev);
 
-err_unlock:
-	mutex_unlock(&iommu_probe_device_lock);
-
 	return ret;
 }
 
@@ -353,7 +348,9 @@ int iommu_probe_device(struct device *dev)
 	struct iommu_group *group;
 	int ret;
 
+	mutex_lock(&iommu_probe_device_lock);
 	ret = __iommu_probe_device(dev, NULL);
+	mutex_unlock(&iommu_probe_device_lock);
 	if (ret)
 		goto err_out;
 
@@ -1684,7 +1681,9 @@ static int probe_iommu_group(struct device *dev, void *data)
 		return 0;
 	}
 
+	mutex_lock(&iommu_probe_device_lock);
 	ret = __iommu_probe_device(dev, group_list);
+	mutex_unlock(&iommu_probe_device_lock);
 	if (ret == -ENODEV)
 		ret = 0;
 
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5696314ae69e..1fa1db3be852 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -112,16 +112,20 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 					   const u32 *id)
 {
 	const struct iommu_ops *ops = NULL;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct iommu_fwspec *fwspec;
 	int err = NO_IOMMU;
 
 	if (!master_np)
 		return NULL;
 
+	/* Serialise to make dev->iommu stable under our potential fwspec */
+	mutex_lock(&iommu_probe_device_lock);
+	fwspec = dev_iommu_fwspec_get(dev);
 	if (fwspec) {
-		if (fwspec->ops)
+		if (fwspec->ops) {
+			mutex_unlock(&iommu_probe_device_lock);
 			return fwspec->ops;
-
+		}
 		/* In the deferred case, start again from scratch */
 		iommu_fwspec_free(dev);
 	}
@@ -155,6 +159,8 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		fwspec = dev_iommu_fwspec_get(dev);
 		ops    = fwspec->ops;
 	}
+	mutex_unlock(&iommu_probe_device_lock);
+
 	/*
 	 * If we have reason to believe the IOMMU driver missed the initial
 	 * probe for dev, replay it to get things in order.
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3c9da1f8979e..9d87090953bc 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -657,6 +657,7 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
 	dev->iommu->priv = priv;
 }
 
+extern struct mutex iommu_probe_device_lock;
 int iommu_probe_device(struct device *dev);
 void iommu_release_device(struct device *dev);
 
-- 
2.39.2.101.g768bb238c484.dirty


