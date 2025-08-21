Return-Path: <stable+bounces-172195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8502FB3001B
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72243A26EC4
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1603A2DAFDD;
	Thu, 21 Aug 2025 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiTsplYi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F3E2DE6F8
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793716; cv=none; b=DCh5HYCnno3nGnpT6u/itCFt3+NjMX3eYSOS5ljI2FIOGL92bllDxlYgQD9dYFSpKofWOyJCpeb2EkZRJqP1BAU7+Vv9ZePOaFAOBOli65NmjEnTt5eaTr6aFWpOcb2cSispsbb9a45N3WH76S0Hp57nGmZYgtA9aNn16PEb4MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793716; c=relaxed/simple;
	bh=kkxMIHFiLTWr8twpwbtMYZTXsjNJmiM++vxneTdoKKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Okf6DhWcodYzcwZpcafW5BlwrIEIuHulXWtte8jOv0ShXmJAqZapmuexnsndTu5ZkYd1Nj48QNUcczttzcBkL2Quzo6zt4iSag1q7id6+7HFKUq8QXwwBgybqBU+JPYX7OpkosfeEzCjMwrmslVXWZJbUWVdvgYqV18b/myIkOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiTsplYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628AFC4CEEB;
	Thu, 21 Aug 2025 16:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755793716;
	bh=kkxMIHFiLTWr8twpwbtMYZTXsjNJmiM++vxneTdoKKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uiTsplYiiEAFlffRbt8Id417xNsOJyVd+ITsslMD5hkhoSVba0Vw8IKIL95eJRZ4C
	 UEEmYOcVP7zMufD4ErFQOnK3EvGMzPqATCIdvIp8NCB9hPMVSDdIrMlBTUda4R5Oea
	 YHrP1HtdTBteUeSWmdm4cgUXnZ6WMaWLvRP8LXZUgsIq86CPaGC9NMIyK4QuFg8hpq
	 H2kBFYzhP47Y9bfaqvthBQAVBpih0UOSEuA+VCleRy36tXELd1Dd+C0AdHXEFoRoS2
	 daAw1dozRhNhjNHEwxFIq8V6RhKtNqxt6LD3Hz2Fj1vuOQYXKG/y0rLXmh9GK1YYPx
	 3EDgcDgFIzs+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Alex Elder <elder@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Takashi Iwai <tiwai@suse.de>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] PM: runtime: Simplify pm_runtime_get_if_active() usage
Date: Thu, 21 Aug 2025 12:28:32 -0400
Message-ID: <20250821162833.814231-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082128-casually-sensuous-5677@gregkh>
References: <2025082128-casually-sensuous-5677@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit c0ef3df8dbaef51ee4cfd58a471adf2eaee6f6b3 ]

There are two ways to opportunistically increment a device's runtime PM
usage count, calling either pm_runtime_get_if_active() or
pm_runtime_get_if_in_use(). The former has an argument to tell whether to
ignore the usage count or not, and the latter simply calls the former with
ign_usage_count set to false. The other users that want to ignore the
usage_count will have to explicitly set that argument to true which is a
bit cumbersome.

To make this function more practical to use, remove the ign_usage_count
argument from the function. The main implementation is in a static
function called pm_runtime_get_conditional() and implementations of
pm_runtime_get_if_active() and pm_runtime_get_if_in_use() are moved to
runtime.c.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Takashi Iwai <tiwai@suse.de> # sound/
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com> # drivers/accel/ivpu/
Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com> # drivers/gpu/drm/i915/
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com> # drivers/pci/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ Removed changes to code that didn't exist in older trees ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/power/runtime_pm.rst      |  5 ++--
 drivers/base/power/runtime.c            | 35 +++++++++++++++++++++++--
 drivers/gpu/drm/i915/intel_runtime_pm.c |  5 +++-
 drivers/media/i2c/ccs/ccs-core.c        |  2 +-
 drivers/net/ipa/ipa_smp2p.c             |  2 +-
 drivers/pci/pci.c                       |  2 +-
 drivers/ufs/core/ufshcd-priv.h          |  2 +-
 include/linux/pm_runtime.h              | 18 +++----------
 sound/hda/hdac_device.c                 |  2 +-
 9 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index b6d5a3a8febc..f6a7cffdc129 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -398,10 +398,9 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
       nonzero, increment the counter and return 1; otherwise return 0 without
       changing the counter
 
-  `int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count);`
+  `int pm_runtime_get_if_active(struct device *dev);`
     - return -EINVAL if 'power.disable_depth' is nonzero; otherwise, if the
-      runtime PM status is RPM_ACTIVE, and either ign_usage_count is true
-      or the device's usage_count is non-zero, increment the counter and
+      runtime PM status is RPM_ACTIVE, increment the counter and
       return 1; otherwise return 0 without changing the counter
 
   `void pm_runtime_put_noidle(struct device *dev);`
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 0d43bf5b6cec..d5ac30249cac 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1175,7 +1175,7 @@ int __pm_runtime_resume(struct device *dev, int rpmflags)
 EXPORT_SYMBOL_GPL(__pm_runtime_resume);
 
 /**
- * pm_runtime_get_if_active - Conditionally bump up device usage counter.
+ * pm_runtime_get_conditional - Conditionally bump up device usage counter.
  * @dev: Device to handle.
  * @ign_usage_count: Whether or not to look at the current usage counter value.
  *
@@ -1196,7 +1196,7 @@ EXPORT_SYMBOL_GPL(__pm_runtime_resume);
  * The caller is responsible for decrementing the runtime PM usage counter of
  * @dev after this function has returned a positive value for it.
  */
-int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count)
+static int pm_runtime_get_conditional(struct device *dev, bool ign_usage_count)
 {
 	unsigned long flags;
 	int retval;
@@ -1217,8 +1217,39 @@ int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count)
 
 	return retval;
 }
+
+/**
+ * pm_runtime_get_if_active - Bump up runtime PM usage counter if the device is
+ *			      in active state
+ * @dev: Target device.
+ *
+ * Increment the runtime PM usage counter of @dev if its runtime PM status is
+ * %RPM_ACTIVE, in which case it returns 1. If the device is in a different
+ * state, 0 is returned. -EINVAL is returned if runtime PM is disabled for the
+ * device, in which case also the usage_count will remain unmodified.
+ */
+int pm_runtime_get_if_active(struct device *dev)
+{
+	return pm_runtime_get_conditional(dev, true);
+}
 EXPORT_SYMBOL_GPL(pm_runtime_get_if_active);
 
+/**
+ * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
+ * @dev: Target device.
+ *
+ * Increment the runtime PM usage counter of @dev if its runtime PM status is
+ * %RPM_ACTIVE and its runtime PM usage counter is greater than 0, in which case
+ * it returns 1. If the device is in a different state or its usage_count is 0,
+ * 0 is returned. -EINVAL is returned if runtime PM is disabled for the device,
+ * in which case also the usage_count will remain unmodified.
+ */
+int pm_runtime_get_if_in_use(struct device *dev)
+{
+	return pm_runtime_get_conditional(dev, false);
+}
+EXPORT_SYMBOL_GPL(pm_runtime_get_if_in_use);
+
 /**
  * __pm_runtime_set_status - Set runtime PM status of a device.
  * @dev: Device to handle.
diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
index 6d8e5e5c0cba..37c963d33bb7 100644
--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -434,7 +434,10 @@ static intel_wakeref_t __intel_runtime_pm_get_if_active(struct intel_runtime_pm
 		 * function, since the power state is undefined. This applies
 		 * atm to the late/early system suspend/resume handlers.
 		 */
-		if (pm_runtime_get_if_active(rpm->kdev, ignore_usecount) <= 0)
+		if ((ignore_usecount &&
+		     pm_runtime_get_if_active(rpm->kdev) <= 0) ||
+		    (!ignore_usecount &&
+		     pm_runtime_get_if_in_use(rpm->kdev) <= 0))
 			return 0;
 	}
 
diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 364026124257..4d31b2bb8f09 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -665,7 +665,7 @@ static int ccs_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	}
 
-	pm_status = pm_runtime_get_if_active(&client->dev, true);
+	pm_status = pm_runtime_get_if_active(&client->dev);
 	if (!pm_status)
 		return 0;
 
diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index 5620dc271fac..cbf3d4761ce3 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -92,7 +92,7 @@ static void ipa_smp2p_notify(struct ipa_smp2p *smp2p)
 		return;
 
 	dev = &smp2p->ipa->pdev->dev;
-	smp2p->power_on = pm_runtime_get_if_active(dev, true) > 0;
+	smp2p->power_on = pm_runtime_get_if_active(dev) > 0;
 
 	/* Signal whether the IPA power is enabled */
 	mask = BIT(smp2p->enabled_bit);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4541dfbf0e1b..456401afd7e5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2475,7 +2475,7 @@ static void pci_pme_list_scan(struct work_struct *work)
 			 * course of the call.
 			 */
 			if (bdev) {
-				bref = pm_runtime_get_if_active(bdev, true);
+				bref = pm_runtime_get_if_active(bdev);
 				if (!bref)
 					continue;
 
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index dffc932285ac..e33466609052 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -326,7 +326,7 @@ static inline int ufshcd_rpm_get_sync(struct ufs_hba *hba)
 
 static inline int ufshcd_rpm_get_if_active(struct ufs_hba *hba)
 {
-	return pm_runtime_get_if_active(&hba->ufs_device_wlun->sdev_gendev, true);
+	return pm_runtime_get_if_active(&hba->ufs_device_wlun->sdev_gendev);
 }
 
 static inline int ufshcd_rpm_put_sync(struct ufs_hba *hba)
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 406855d73901..4b74f0f012a5 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -73,7 +73,8 @@ extern int pm_runtime_force_resume(struct device *dev);
 extern int __pm_runtime_idle(struct device *dev, int rpmflags);
 extern int __pm_runtime_suspend(struct device *dev, int rpmflags);
 extern int __pm_runtime_resume(struct device *dev, int rpmflags);
-extern int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count);
+extern int pm_runtime_get_if_active(struct device *dev);
+extern int pm_runtime_get_if_in_use(struct device *dev);
 extern int pm_schedule_suspend(struct device *dev, unsigned int delay);
 extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
 extern int pm_runtime_barrier(struct device *dev);
@@ -95,18 +96,6 @@ extern void pm_runtime_release_supplier(struct device_link *link);
 
 extern int devm_pm_runtime_enable(struct device *dev);
 
-/**
- * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
- * @dev: Target device.
- *
- * Increment the runtime PM usage counter of @dev if its runtime PM status is
- * %RPM_ACTIVE and its runtime PM usage counter is greater than 0.
- */
-static inline int pm_runtime_get_if_in_use(struct device *dev)
-{
-	return pm_runtime_get_if_active(dev, false);
-}
-
 /**
  * pm_suspend_ignore_children - Set runtime PM behavior regarding children.
  * @dev: Target device.
@@ -277,8 +266,7 @@ static inline int pm_runtime_get_if_in_use(struct device *dev)
 {
 	return -EINVAL;
 }
-static inline int pm_runtime_get_if_active(struct device *dev,
-					   bool ign_usage_count)
+static inline int pm_runtime_get_if_active(struct device *dev)
 {
 	return -EINVAL;
 }
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index bbf7bcdb449a..0a9223c18d77 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -611,7 +611,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_power_up_pm);
 int snd_hdac_keep_power_up(struct hdac_device *codec)
 {
 	if (!atomic_inc_not_zero(&codec->in_pm)) {
-		int ret = pm_runtime_get_if_active(&codec->dev, true);
+		int ret = pm_runtime_get_if_active(&codec->dev);
 		if (!ret)
 			return -1;
 		if (ret < 0)
-- 
2.50.1


