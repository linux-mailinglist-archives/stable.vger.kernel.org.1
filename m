Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC366FA4F8
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjEHKFE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbjEHKFD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:05:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7574D30141
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:05:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF22A62325
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111CAC433D2;
        Mon,  8 May 2023 10:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540300;
        bh=zyOrVQfyiVGSzlJ02zp9McXJCsDtpoaXYIMLqJ1OnmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GlOYD4IQLpP0d57yCQ9GBawKGC06AFa1bX+s10KkvIwE2xCCTOAT0x7DzLeUOjSMy
         bODMFmD7rdpbjrfFi2O1muUJBgGgMmKrvj5zsATRIH0867bPqX0CV7sEgs1VVU9Z7T
         Dceiv67ikPI2hkWQzC0oiwcDVYcCIWeM0xyJaogI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shashank Gupta <shashank.gupta@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 279/611] crypto: qat - fix concurrency issue when device state changes
Date:   Mon,  8 May 2023 11:42:01 +0200
Message-Id: <20230508094431.449760160@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shashank Gupta <shashank.gupta@intel.com>

[ Upstream commit 1bdc85550a2b59bb7f62ead7173134e66dd2d60e ]

The sysfs `state` attribute is not protected against race conditions.
If multiple processes perform a device state transition on the same
device in parallel, unexpected behaviors might occur.

For transitioning the device state, adf_sysfs.c calls the functions
adf_dev_init(), adf_dev_start(), adf_dev_stop() and adf_dev_shutdown()
which are unprotected and interdependent on each other. To perform a
state transition, these functions needs to be called in a specific
order:
  * device up:   adf_dev_init() -> adf_dev_start()
  * device down: adf_dev_stop() -> adf_dev_shutdown()

This change introduces the functions adf_dev_up() and adf_dev_down()
which wrap the state machine functions and protect them with a
per-device lock. These are then used in adf_sysfs.c instead of the
individual state transition functions.

Fixes: 5ee52118ac14 ("crypto: qat - expose device state through sysfs for 4xxx")
Signed-off-by: Shashank Gupta <shashank.gupta@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../crypto/qat/qat_common/adf_accel_devices.h |  1 +
 .../crypto/qat/qat_common/adf_common_drv.h    |  3 +
 drivers/crypto/qat/qat_common/adf_dev_mgr.c   |  2 +
 drivers/crypto/qat/qat_common/adf_init.c      | 64 +++++++++++++++++++
 drivers/crypto/qat/qat_common/adf_sysfs.c     | 23 +------
 5 files changed, 73 insertions(+), 20 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index 0a55a4f34dcfd..20f50d0e65f89 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -296,6 +296,7 @@ struct adf_accel_dev {
 			u8 pf_compat_ver;
 		} vf;
 	};
+	struct mutex state_lock; /* protect state of the device */
 	bool is_vf;
 	u32 accel_id;
 };
diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index 7bb477c3ce25f..bff613eec5c4b 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -58,6 +58,9 @@ void adf_dev_stop(struct adf_accel_dev *accel_dev);
 void adf_dev_shutdown(struct adf_accel_dev *accel_dev);
 int adf_dev_shutdown_cache_cfg(struct adf_accel_dev *accel_dev);
 
+int adf_dev_up(struct adf_accel_dev *accel_dev, bool init_config);
+int adf_dev_down(struct adf_accel_dev *accel_dev, bool cache_config);
+
 void adf_devmgr_update_class_index(struct adf_hw_device_data *hw_data);
 void adf_clean_vf_map(bool);
 
diff --git a/drivers/crypto/qat/qat_common/adf_dev_mgr.c b/drivers/crypto/qat/qat_common/adf_dev_mgr.c
index 4c752eed10fea..86ee36feefad3 100644
--- a/drivers/crypto/qat/qat_common/adf_dev_mgr.c
+++ b/drivers/crypto/qat/qat_common/adf_dev_mgr.c
@@ -223,6 +223,7 @@ int adf_devmgr_add_dev(struct adf_accel_dev *accel_dev,
 		map->attached = true;
 		list_add_tail(&map->list, &vfs_table);
 	}
+	mutex_init(&accel_dev->state_lock);
 unlock:
 	mutex_unlock(&table_lock);
 	return ret;
@@ -269,6 +270,7 @@ void adf_devmgr_rm_dev(struct adf_accel_dev *accel_dev,
 		}
 	}
 unlock:
+	mutex_destroy(&accel_dev->state_lock);
 	list_del(&accel_dev->list);
 	mutex_unlock(&table_lock);
 }
diff --git a/drivers/crypto/qat/qat_common/adf_init.c b/drivers/crypto/qat/qat_common/adf_init.c
index 33a9a46d69494..d6f3314246179 100644
--- a/drivers/crypto/qat/qat_common/adf_init.c
+++ b/drivers/crypto/qat/qat_common/adf_init.c
@@ -389,3 +389,67 @@ int adf_dev_shutdown_cache_cfg(struct adf_accel_dev *accel_dev)
 
 	return 0;
 }
+
+int adf_dev_down(struct adf_accel_dev *accel_dev, bool reconfig)
+{
+	int ret = 0;
+
+	if (!accel_dev)
+		return -EINVAL;
+
+	mutex_lock(&accel_dev->state_lock);
+
+	if (!adf_dev_started(accel_dev)) {
+		dev_info(&GET_DEV(accel_dev), "Device qat_dev%d already down\n",
+			 accel_dev->accel_id);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (reconfig) {
+		ret = adf_dev_shutdown_cache_cfg(accel_dev);
+		goto out;
+	}
+
+	adf_dev_stop(accel_dev);
+	adf_dev_shutdown(accel_dev);
+
+out:
+	mutex_unlock(&accel_dev->state_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(adf_dev_down);
+
+int adf_dev_up(struct adf_accel_dev *accel_dev, bool config)
+{
+	int ret = 0;
+
+	if (!accel_dev)
+		return -EINVAL;
+
+	mutex_lock(&accel_dev->state_lock);
+
+	if (adf_dev_started(accel_dev)) {
+		dev_info(&GET_DEV(accel_dev), "Device qat_dev%d already up\n",
+			 accel_dev->accel_id);
+		ret = -EALREADY;
+		goto out;
+	}
+
+	if (config && GET_HW_DATA(accel_dev)->dev_config) {
+		ret = GET_HW_DATA(accel_dev)->dev_config(accel_dev);
+		if (unlikely(ret))
+			goto out;
+	}
+
+	ret = adf_dev_init(accel_dev);
+	if (unlikely(ret))
+		goto out;
+
+	ret = adf_dev_start(accel_dev);
+
+out:
+	mutex_unlock(&accel_dev->state_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(adf_dev_up);
diff --git a/drivers/crypto/qat/qat_common/adf_sysfs.c b/drivers/crypto/qat/qat_common/adf_sysfs.c
index e8b078e719c20..3eb6611ab1b11 100644
--- a/drivers/crypto/qat/qat_common/adf_sysfs.c
+++ b/drivers/crypto/qat/qat_common/adf_sysfs.c
@@ -50,38 +50,21 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
 
 	switch (ret) {
 	case DEV_DOWN:
-		if (!adf_dev_started(accel_dev)) {
-			dev_info(dev, "Device qat_dev%d already down\n",
-				 accel_id);
-			return -EINVAL;
-		}
-
 		dev_info(dev, "Stopping device qat_dev%d\n", accel_id);
 
-		ret = adf_dev_shutdown_cache_cfg(accel_dev);
+		ret = adf_dev_down(accel_dev, true);
 		if (ret < 0)
 			return -EINVAL;
 
 		break;
 	case DEV_UP:
-		if (adf_dev_started(accel_dev)) {
-			dev_info(dev, "Device qat_dev%d already up\n",
-				 accel_id);
-			return -EINVAL;
-		}
-
 		dev_info(dev, "Starting device qat_dev%d\n", accel_id);
 
-		ret = GET_HW_DATA(accel_dev)->dev_config(accel_dev);
-		if (!ret)
-			ret = adf_dev_init(accel_dev);
-		if (!ret)
-			ret = adf_dev_start(accel_dev);
-
+		ret = adf_dev_up(accel_dev, true);
 		if (ret < 0) {
 			dev_err(dev, "Failed to start device qat_dev%d\n",
 				accel_id);
-			adf_dev_shutdown_cache_cfg(accel_dev);
+			adf_dev_down(accel_dev, true);
 			return ret;
 		}
 		break;
-- 
2.39.2



