Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4807552A1
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjGPUKG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjGPUKE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:10:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4E2199
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:10:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3512E60E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438B7C433C8;
        Sun, 16 Jul 2023 20:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538197;
        bh=0z5LVC64C3WRwKBXQHV3cvK/+o9LRQxAWrPVkFcbe5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DnWCga29zj+uULwrHFyaSp19x6epHy9Y7s8hW6Z0moygCpi4fPBn7r5n2MNDI/m3f
         UrjkvShPOP2DP8McI+/Il/K/4M1lOk5rxjsMuyCLseyQYohdyGaGaQ7rL8tg7uu3L5
         vIDvLDsTrqXpHzPFuNixii/HOb7WYI0Ua1E0nvdE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Matt Roper <matthew.d.roper@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 348/800] drm/i915/display: Move display device info to header under display/
Date:   Sun, 16 Jul 2023 21:43:21 +0200
Message-ID: <20230716194957.162427895@linuxfoundation.org>
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

From: Matt Roper <matthew.d.roper@intel.com>

[ Upstream commit 05aa8e0135094ae3d1e6837b5457a740266d7cfc ]

Moving display-specific substructure definitions will help keep display
more self-contained and make it easier to re-use in other drivers (i.e.,
Xe) in the future.

Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230523195609.73627-2-matthew.d.roper@intel.com
Stable-dep-of: 19db2062094c ("drm/i915: No 10bit gamma on desktop gen3 parts")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/i915/display/intel_display_device.h   | 60 +++++++++++++++++++
 drivers/gpu/drm/i915/intel_device_info.h      | 49 +--------------
 2 files changed, 62 insertions(+), 47 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/display/intel_display_device.h

diff --git a/drivers/gpu/drm/i915/display/intel_display_device.h b/drivers/gpu/drm/i915/display/intel_display_device.h
new file mode 100644
index 0000000000000..c689d582dbf13
--- /dev/null
+++ b/drivers/gpu/drm/i915/display/intel_display_device.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2023 Intel Corporation
+ */
+
+#ifndef __INTEL_DISPLAY_DEVICE_H__
+#define __INTEL_DISPLAY_DEVICE_H__
+
+#include <linux/types.h>
+
+#include "display/intel_display_limits.h"
+
+#define DEV_INFO_DISPLAY_FOR_EACH_FLAG(func) \
+	/* Keep in alphabetical order */ \
+	func(cursor_needs_physical); \
+	func(has_cdclk_crawl); \
+	func(has_cdclk_squash); \
+	func(has_ddi); \
+	func(has_dp_mst); \
+	func(has_dsb); \
+	func(has_fpga_dbg); \
+	func(has_gmch); \
+	func(has_hotplug); \
+	func(has_hti); \
+	func(has_ipc); \
+	func(has_overlay); \
+	func(has_psr); \
+	func(has_psr_hw_tracking); \
+	func(overlay_needs_physical); \
+	func(supports_tv);
+
+struct intel_display_device_info {
+	u8 abox_mask;
+
+	struct {
+		u16 size; /* in blocks */
+		u8 slice_mask;
+	} dbuf;
+
+#define DEFINE_FLAG(name) u8 name:1
+	DEV_INFO_DISPLAY_FOR_EACH_FLAG(DEFINE_FLAG);
+#undef DEFINE_FLAG
+
+	/* Global register offset for the display engine */
+	u32 mmio_offset;
+
+	/* Register offsets for the various display pipes and transcoders */
+	u32 pipe_offsets[I915_MAX_TRANSCODERS];
+	u32 trans_offsets[I915_MAX_TRANSCODERS];
+	u32 cursor_offsets[I915_MAX_PIPES];
+
+	struct {
+		u32 degamma_lut_size;
+		u32 gamma_lut_size;
+		u32 degamma_lut_tests;
+		u32 gamma_lut_tests;
+	} color;
+};
+
+#endif
diff --git a/drivers/gpu/drm/i915/intel_device_info.h b/drivers/gpu/drm/i915/intel_device_info.h
index f032f2500f505..c14bc3f5d0fa1 100644
--- a/drivers/gpu/drm/i915/intel_device_info.h
+++ b/drivers/gpu/drm/i915/intel_device_info.h
@@ -29,7 +29,7 @@
 
 #include "intel_step.h"
 
-#include "display/intel_display_limits.h"
+#include "display/intel_display_device.h"
 
 #include "gt/intel_engine_types.h"
 #include "gt/intel_context_types.h"
@@ -180,25 +180,6 @@ enum intel_ppgtt_type {
 	func(unfenced_needs_alignment); \
 	func(hws_needs_physical);
 
-#define DEV_INFO_DISPLAY_FOR_EACH_FLAG(func) \
-	/* Keep in alphabetical order */ \
-	func(cursor_needs_physical); \
-	func(has_cdclk_crawl); \
-	func(has_cdclk_squash); \
-	func(has_ddi); \
-	func(has_dp_mst); \
-	func(has_dsb); \
-	func(has_fpga_dbg); \
-	func(has_gmch); \
-	func(has_hotplug); \
-	func(has_hti); \
-	func(has_ipc); \
-	func(has_overlay); \
-	func(has_psr); \
-	func(has_psr_hw_tracking); \
-	func(overlay_needs_physical); \
-	func(supports_tv);
-
 struct intel_ip_version {
 	u8 ver;
 	u8 rel;
@@ -276,33 +257,7 @@ struct intel_device_info {
 	DEV_INFO_FOR_EACH_FLAG(DEFINE_FLAG);
 #undef DEFINE_FLAG
 
-	struct {
-		u8 abox_mask;
-
-		struct {
-			u16 size; /* in blocks */
-			u8 slice_mask;
-		} dbuf;
-
-#define DEFINE_FLAG(name) u8 name:1
-		DEV_INFO_DISPLAY_FOR_EACH_FLAG(DEFINE_FLAG);
-#undef DEFINE_FLAG
-
-		/* Global register offset for the display engine */
-		u32 mmio_offset;
-
-		/* Register offsets for the various display pipes and transcoders */
-		u32 pipe_offsets[I915_MAX_TRANSCODERS];
-		u32 trans_offsets[I915_MAX_TRANSCODERS];
-		u32 cursor_offsets[I915_MAX_PIPES];
-
-		struct {
-			u32 degamma_lut_size;
-			u32 gamma_lut_size;
-			u32 degamma_lut_tests;
-			u32 gamma_lut_tests;
-		} color;
-	} display;
+	struct intel_display_device_info display;
 
 	/*
 	 * Initial runtime info. Do not access outside of i915_driver_create().
-- 
2.39.2



