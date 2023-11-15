Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53F47ECC53
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjKOT3m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjKOT3l (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:29:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C05E130
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:29:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83871C433C8;
        Wed, 15 Nov 2023 19:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076575;
        bh=8ASizStuYFsqtA4bXzo3F95lGtMeG255Wt+bDYZJ+Rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1bldZIdEb9VOFybMrP46BrrKQ7v773clcEOfqoDACfQCpJsZ6X3Wck6BIWTZm+Xur
         c17a7WioDSfcjTFYv+nN6g3XI0c1IEot89072BvX4fegGm88OfA0C6HTSpwVnFRWdK
         mD10+edjDUTqOEYNYXL7Pf7qA/AZ/4EZYpUj/g/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 316/550] crypto: qat - fix state machines cleanup paths
Date:   Wed, 15 Nov 2023 14:15:00 -0500
Message-ID: <20231115191622.701966542@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit c9ca9756f376f51f985130a0e599d956065d4c44 ]

Commit 1bdc85550a2b ("crypto: qat - fix concurrency issue when device
state changes") introduced the function adf_dev_down() which wraps the
functions adf_dev_stop() and adf_dev_shutdown().
In a subsequent change, the sequence adf_dev_stop() followed by
adf_dev_shutdown() was then replaced across the driver with just a call
to the function adf_dev_down().

The functions adf_dev_stop() and adf_dev_shutdown() are called in error
paths to stop the accelerator and free up resources and can be called
even if the counterparts adf_dev_init() and adf_dev_start() did not
complete successfully.
However, the implementation of adf_dev_down() prevents the stop/shutdown
sequence if the device is found already down.
For example, if adf_dev_init() fails, the device status is not set as
started and therefore a call to adf_dev_down() won't be calling
adf_dev_shutdown() to undo what adf_dev_init() did.

Do not check if a device is started in adf_dev_down() but do the
equivalent check in adf_sysfs.c when handling a DEV_DOWN command from
the user.

Fixes: 2b60f79c7b81 ("crypto: qat - replace state machine calls")
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Adam Guerin <adam.guerin@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_common/adf_init.c  | 7 -------
 drivers/crypto/intel/qat/qat_common/adf_sysfs.c | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_init.c b/drivers/crypto/intel/qat/qat_common/adf_init.c
index 826179c985241..8e66a77499f58 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_init.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_init.c
@@ -412,13 +412,6 @@ int adf_dev_down(struct adf_accel_dev *accel_dev, bool reconfig)
 
 	mutex_lock(&accel_dev->state_lock);
 
-	if (!adf_dev_started(accel_dev)) {
-		dev_info(&GET_DEV(accel_dev), "Device qat_dev%d already down\n",
-			 accel_dev->accel_id);
-		ret = -EINVAL;
-		goto out;
-	}
-
 	if (reconfig) {
 		ret = adf_dev_shutdown_cache_cfg(accel_dev);
 		goto out;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_sysfs.c b/drivers/crypto/intel/qat/qat_common/adf_sysfs.c
index a74d2f9303670..a8f33558d7cb8 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_sysfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_sysfs.c
@@ -52,6 +52,13 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
 	case DEV_DOWN:
 		dev_info(dev, "Stopping device qat_dev%d\n", accel_id);
 
+		if (!adf_dev_started(accel_dev)) {
+			dev_info(&GET_DEV(accel_dev), "Device qat_dev%d already down\n",
+				 accel_id);
+
+			break;
+		}
+
 		ret = adf_dev_down(accel_dev, true);
 		if (ret < 0)
 			return -EINVAL;
-- 
2.42.0



