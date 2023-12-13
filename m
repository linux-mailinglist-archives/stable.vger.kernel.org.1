Return-Path: <stable+bounces-6110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8886F80D8CC
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2AE1C21619
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105CE51C2A;
	Mon, 11 Dec 2023 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KKdKrw66"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64265102A;
	Mon, 11 Dec 2023 18:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4BBC433C8;
	Mon, 11 Dec 2023 18:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320539;
	bh=Q0vNbTJylSnT/noXcRtOMwdcqpynSbX+8gfe2lSJZaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KKdKrw66clPhLYt1Vm5g7pWLQ1iMTZ+2FpRI2Xg20gAF/623+H4jCa4sBUwkgMJvX
	 vWnRMZKZHhmR0GhUiVBUbg5VGp7qquv4q8PD/4vdEYedSBdPz+hlXlqNTeO795y0qn
	 lxljD/ldsWq1c9jutOAM7MyO2V96bTsy7dcsgFjY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	Robin Murphy <robin.murphy@arm.com>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 6.1 098/194] iommu: Avoid more races around device probe
Date: Mon, 11 Dec 2023 19:21:28 +0100
Message-ID: <20231211182040.824741249@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>

commit a2e7e59a94269484a83386972ca07c22fd188854 upstream.

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
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/scan.c      |    7 ++++++-
 drivers/iommu/iommu.c    |   19 +++++++++----------
 drivers/iommu/of_iommu.c |   12 +++++++++---
 include/linux/iommu.h    |    1 +
 4 files changed, 25 insertions(+), 14 deletions(-)

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1563,17 +1563,22 @@ static const struct iommu_ops *acpi_iomm
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
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -278,12 +278,13 @@ static void dev_iommu_free(struct device
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
@@ -295,11 +296,9 @@ static int __iommu_probe_device(struct d
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
@@ -326,7 +325,6 @@ static int __iommu_probe_device(struct d
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 
-	mutex_unlock(&iommu_probe_device_lock);
 	iommu_device_link(iommu_dev, dev);
 
 	return 0;
@@ -341,9 +339,6 @@ out_module_put:
 err_free:
 	dev_iommu_free(dev);
 
-err_unlock:
-	mutex_unlock(&iommu_probe_device_lock);
-
 	return ret;
 }
 
@@ -353,7 +348,9 @@ int iommu_probe_device(struct device *de
 	struct iommu_group *group;
 	int ret;
 
+	mutex_lock(&iommu_probe_device_lock);
 	ret = __iommu_probe_device(dev, NULL);
+	mutex_unlock(&iommu_probe_device_lock);
 	if (ret)
 		goto err_out;
 
@@ -1684,7 +1681,9 @@ static int probe_iommu_group(struct devi
 		return 0;
 	}
 
+	mutex_lock(&iommu_probe_device_lock);
 	ret = __iommu_probe_device(dev, group_list);
+	mutex_unlock(&iommu_probe_device_lock);
 	if (ret == -ENODEV)
 		ret = 0;
 
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -112,16 +112,20 @@ const struct iommu_ops *of_iommu_configu
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
@@ -155,6 +159,8 @@ const struct iommu_ops *of_iommu_configu
 		fwspec = dev_iommu_fwspec_get(dev);
 		ops    = fwspec->ops;
 	}
+	mutex_unlock(&iommu_probe_device_lock);
+
 	/*
 	 * If we have reason to believe the IOMMU driver missed the initial
 	 * probe for dev, replay it to get things in order.
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -657,6 +657,7 @@ static inline void dev_iommu_priv_set(st
 	dev->iommu->priv = priv;
 }
 
+extern struct mutex iommu_probe_device_lock;
 int iommu_probe_device(struct device *dev);
 void iommu_release_device(struct device *dev);
 



