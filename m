Return-Path: <stable+bounces-3776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 380DF802446
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 14:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5881F21128
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEFCF9C4;
	Sun,  3 Dec 2023 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L9bvOosL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD106C2EE
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 13:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83B8C433C7;
	Sun,  3 Dec 2023 13:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701610626;
	bh=I9mxRUj46EdlYqaeF2ed48M+kULzN9K2COgfuZ42R/E=;
	h=Subject:To:Cc:From:Date:From;
	b=L9bvOosLeWtjFyaA1U7qVXi+HQo80zaTvkp4MkhXkAkPnDJ3nj9J+5xHQRtwZcihy
	 /UOAKsP59ycb4SejozsSFnmNOiPtjAUd8qppZG43x/Q8azMYjhB6/rNkL1HHOn0hkb
	 FGAQT9/uuAj+olkPgZnYh7Q4S7dlW144aKtInUj8=
Subject: FAILED: patch "[PATCH] iommu: Avoid more races around device probe" failed to apply to 6.1-stable tree
To: robin.murphy@arm.com,andre.draszik@linaro.org,gregkh@linuxfoundation.org,jroedel@suse.de,quic_zhenhuah@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 14:37:03 +0100
Message-ID: <2023120303-purposely-museum-96a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a2e7e59a94269484a83386972ca07c22fd188854
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120303-purposely-museum-96a7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

a2e7e59a9426 ("iommu: Avoid more races around device probe")
fa0828036488 ("iommu: Split iommu_group_add_device()")
14891af3799e ("iommu: Move the iommu driver sysfs setup into iommu_init/deinit_device()")
aa0958570f24 ("iommu: Add iommu_init/deinit_device() paired functions")
df15d76dcaca ("iommu: Simplify the __iommu_group_remove_device() flow")
7bdb99622f7e ("iommu: Inline iommu_group_get_for_dev() into __iommu_probe_device()")
5665d15d3cb7 ("iommu: Use iommu_group_ref_get/put() for dev->iommu_group")
6eb4da8cf545 ("iommu: Have __iommu_probe_device() check for already probed devices")
0046a4337eae ("iommu: Remove iommu_group_do_dma_first_attach() from iommu_group_add_device()")
d257344c6619 ("iommu: Replace __iommu_group_dma_first_attach() with set_domain")
dcf40ed3a20d ("iommu: Make __iommu_group_set_domain() handle error unwind")
3006b15b364a ("iommu: Add for_each_group_device()")
dba9ca9d41f5 ("iommu: Same critical region for device release and removal")
293f2564f3dd ("iommu: Split iommu_group_remove_device() into helpers")
143c7bc6496c ("Merge tag 'for-linus-iommufd' of git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a2e7e59a94269484a83386972ca07c22fd188854 Mon Sep 17 00:00:00 2001
From: Robin Murphy <robin.murphy@arm.com>
Date: Wed, 15 Nov 2023 18:25:44 +0000
Subject: [PATCH] iommu: Avoid more races around device probe
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

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fa5dd71a80fa..02bb2cce423f 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1568,17 +1568,22 @@ static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
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
index c9a05bb49bfa..33e2a9b5d339 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -485,11 +485,12 @@ static void iommu_deinit_device(struct device *dev)
 	dev_iommu_free(dev);
 }
 
+DEFINE_MUTEX(iommu_probe_device_lock);
+
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 	struct iommu_group *group;
-	static DEFINE_MUTEX(iommu_probe_device_lock);
 	struct group_device *gdev;
 	int ret;
 
@@ -502,17 +503,15 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	 * probably be able to use device_lock() here to minimise the scope,
 	 * but for now enforcing a simple global ordering is fine.
 	 */
-	mutex_lock(&iommu_probe_device_lock);
+	lockdep_assert_held(&iommu_probe_device_lock);
 
 	/* Device is probed already if in a group */
-	if (dev->iommu_group) {
-		ret = 0;
-		goto out_unlock;
-	}
+	if (dev->iommu_group)
+		return 0;
 
 	ret = iommu_init_device(dev, ops);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	group = dev->iommu_group;
 	gdev = iommu_group_alloc_device(group, dev);
@@ -548,7 +547,6 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 			list_add_tail(&group->entry, group_list);
 	}
 	mutex_unlock(&group->mutex);
-	mutex_unlock(&iommu_probe_device_lock);
 
 	if (dev_is_pci(dev))
 		iommu_dma_set_pci_32bit_workaround(dev);
@@ -562,8 +560,6 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	iommu_deinit_device(dev);
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
-out_unlock:
-	mutex_unlock(&iommu_probe_device_lock);
 
 	return ret;
 }
@@ -573,7 +569,9 @@ int iommu_probe_device(struct device *dev)
 	const struct iommu_ops *ops;
 	int ret;
 
+	mutex_lock(&iommu_probe_device_lock);
 	ret = __iommu_probe_device(dev, NULL);
+	mutex_unlock(&iommu_probe_device_lock);
 	if (ret)
 		return ret;
 
@@ -1822,7 +1820,9 @@ static int probe_iommu_group(struct device *dev, void *data)
 	struct list_head *group_list = data;
 	int ret;
 
+	mutex_lock(&iommu_probe_device_lock);
 	ret = __iommu_probe_device(dev, group_list);
+	mutex_unlock(&iommu_probe_device_lock);
 	if (ret == -ENODEV)
 		ret = 0;
 
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 157b286e36bf..c25b4ae6aeee 100644
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
index ec289c1016f5..6291aa7b079b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -845,6 +845,7 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
 	dev->iommu->priv = priv;
 }
 
+extern struct mutex iommu_probe_device_lock;
 int iommu_probe_device(struct device *dev);
 
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);


