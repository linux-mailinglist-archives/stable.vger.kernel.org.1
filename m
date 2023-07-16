Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE36755293
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjGPUJ3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjGPUJ2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:09:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8BB9B
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:09:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EA3060EBC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBEBC433C7;
        Sun, 16 Jul 2023 20:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538166;
        bh=3qz8EJ7hTRGXbin7BuhpUZTN1bx4XT97fLb9vNacx28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yrzuSEhQLodWb2Z/B6RuE1EDlYhEaJcV0uXkTJ4Em39qaPhsY3a+gz5tUfoBjGkrA
         27qMjPIUWxGOD0iBuOL9SGrbQtf/FRLewEci++vHMnQcfdb9McLkApX2wJUb3A8cET
         FyN9PNpZMvFCGGZpTssgEuHz4F2JLyCNn/92rGEI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jani Nikula <jani.nikula@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 347/800] drm/i915: hide mkwrite_device_info() better
Date:   Sun, 16 Jul 2023 21:43:20 +0200
Message-ID: <20230716194957.140001589@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit 446a20c9ba622bb531f1705eab88b64d478ee434 ]

The goal has been to just make device info a pointer to static const
data, i.e. the static const structs in i915_pci.c. See [1]. However,
there were issues with intel_device_info_runtime_init() clearing the
display sub-struct of device info on the !HAS_DISPLAY() path, which
consequently disables a lot of display functionality, like it
should. Looks like we'd have to cover all those paths, and maybe
sprinkle HAS_DISPLAY() checks in them, which we haven't gotten around
to.

In the mean time, hide mkwrite_device_info() better within
intel_device_info.c by adding a intel_device_info_driver_create() for
the very early initialization of the device info and initial runtime
info. This also lets us declutter i915_drv.h a bit, and stops promoting
mkwrite_device_info() as something that could be used.

[1] https://lore.kernel.org/r/a0422f0a8ac055f65b7922bcd3119b180a41e79e.1655712106.git.jani.nikula@intel.com

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230411105643.292416-1-jani.nikula@intel.com
Stable-dep-of: 19db2062094c ("drm/i915: No 10bit gamma on desktop gen3 parts")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/i915_driver.c       | 12 ++--------
 drivers/gpu/drm/i915/i915_drv.h          |  7 ------
 drivers/gpu/drm/i915/intel_device_info.c | 29 ++++++++++++++++++++++++
 drivers/gpu/drm/i915/intel_device_info.h |  2 ++
 4 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 93fdc40d724fa..2980ccdef6cd6 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -720,8 +720,6 @@ i915_driver_create(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct intel_device_info *match_info =
 		(struct intel_device_info *)ent->driver_data;
-	struct intel_device_info *device_info;
-	struct intel_runtime_info *runtime;
 	struct drm_i915_private *i915;
 
 	i915 = devm_drm_dev_alloc(&pdev->dev, &i915_drm_driver,
@@ -734,14 +732,8 @@ i915_driver_create(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Device parameters start as a copy of module parameters. */
 	i915_params_copy(&i915->params, &i915_modparams);
 
-	/* Setup the write-once "constant" device info */
-	device_info = mkwrite_device_info(i915);
-	memcpy(device_info, match_info, sizeof(*device_info));
-
-	/* Initialize initial runtime info from static const data and pdev. */
-	runtime = RUNTIME_INFO(i915);
-	memcpy(runtime, &INTEL_INFO(i915)->__runtime, sizeof(*runtime));
-	runtime->device_id = pdev->device;
+	/* Set up device info and initial runtime info. */
+	intel_device_info_driver_create(i915, pdev->device, match_info);
 
 	return i915;
 }
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index e771fdc3099c2..fe7eeafe9cff6 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -931,11 +931,4 @@ IS_SUBPLATFORM(const struct drm_i915_private *i915,
 #define HAS_LMEMBAR_SMEM_STOLEN(i915) (!HAS_LMEM(i915) && \
 				       GRAPHICS_VER_FULL(i915) >= IP_VER(12, 70))
 
-/* intel_device_info.c */
-static inline struct intel_device_info *
-mkwrite_device_info(struct drm_i915_private *dev_priv)
-{
-	return (struct intel_device_info *)INTEL_INFO(dev_priv);
-}
-
 #endif
diff --git a/drivers/gpu/drm/i915/intel_device_info.c b/drivers/gpu/drm/i915/intel_device_info.c
index fc5cd14adfccb..4e23be2995bf6 100644
--- a/drivers/gpu/drm/i915/intel_device_info.c
+++ b/drivers/gpu/drm/i915/intel_device_info.c
@@ -381,6 +381,13 @@ void intel_device_info_runtime_init_early(struct drm_i915_private *i915)
 	intel_device_info_subplatform_init(i915);
 }
 
+/* FIXME: Remove this, and make device info a const pointer to rodata. */
+static struct intel_device_info *
+mkwrite_device_info(struct drm_i915_private *i915)
+{
+	return (struct intel_device_info *)INTEL_INFO(i915);
+}
+
 /**
  * intel_device_info_runtime_init - initialize runtime info
  * @dev_priv: the i915 device
@@ -548,6 +555,28 @@ void intel_device_info_runtime_init(struct drm_i915_private *dev_priv)
 		dev_priv->drm.driver_features &= ~DRIVER_ATOMIC;
 }
 
+/*
+ * Set up device info and initial runtime info at driver create.
+ *
+ * Note: i915 is only an allocated blob of memory at this point.
+ */
+void intel_device_info_driver_create(struct drm_i915_private *i915,
+				     u16 device_id,
+				     const struct intel_device_info *match_info)
+{
+	struct intel_device_info *info;
+	struct intel_runtime_info *runtime;
+
+	/* Setup the write-once "constant" device info */
+	info = mkwrite_device_info(i915);
+	memcpy(info, match_info, sizeof(*info));
+
+	/* Initialize initial runtime info from static const data and pdev. */
+	runtime = RUNTIME_INFO(i915);
+	memcpy(runtime, &INTEL_INFO(i915)->__runtime, sizeof(*runtime));
+	runtime->device_id = device_id;
+}
+
 void intel_driver_caps_print(const struct intel_driver_caps *caps,
 			     struct drm_printer *p)
 {
diff --git a/drivers/gpu/drm/i915/intel_device_info.h b/drivers/gpu/drm/i915/intel_device_info.h
index 080a4557899b6..f032f2500f505 100644
--- a/drivers/gpu/drm/i915/intel_device_info.h
+++ b/drivers/gpu/drm/i915/intel_device_info.h
@@ -317,6 +317,8 @@ struct intel_driver_caps {
 
 const char *intel_platform_name(enum intel_platform platform);
 
+void intel_device_info_driver_create(struct drm_i915_private *i915, u16 device_id,
+				     const struct intel_device_info *match_info);
 void intel_device_info_runtime_init_early(struct drm_i915_private *dev_priv);
 void intel_device_info_runtime_init(struct drm_i915_private *dev_priv);
 
-- 
2.39.2



