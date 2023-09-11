Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33D079B1C4
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbjIKVKT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238887AbjIKOHS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:07:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5334CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:07:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0DDC433C7;
        Mon, 11 Sep 2023 14:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441234;
        bh=8UXoYR89kglgjd/TpPPt3PlE9SsE8GNVRODH1kYA+XI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ajsg3RhxHx5Auat+c8eH75vBxxcJgg3M2Ql6TJuP8fCLOKWaNDA8zrWC7PMNWuhMF
         8WIrap2YBaTNm2WCmwfg0l0oV225PUMJsNLY1aYh4VFyR+olXN67lk6xzvv4shXwUJ
         NWk1ymjujkKOjCt7uCsR+EWRBhUbKN2ZWasgeI+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 315/739] drm/amdgpu: Sort the includes in amdgpu/amdgpu_drv.c
Date:   Mon, 11 Sep 2023 15:41:54 +0200
Message-ID: <20230911134659.909167273@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit e2e42edfe8533af7b30f505d41d44e0d180065da ]

Sort the include files that are included in amdgpu_drv.c alphabetically.

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Acked-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 4e2abc197f11 ("drm/amdgpu: Move vram, gtt & flash defines to amdgpu_ ttm & _psp.h")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0593ef8fe0a63..8d16190e6b046 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -26,30 +26,29 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_generic.h>
 #include <drm/drm_gem.h>
-#include <drm/drm_vblank.h>
 #include <drm/drm_managed.h>
-#include "amdgpu_drv.h"
-
 #include <drm/drm_pciids.h>
-#include <linux/module.h>
-#include <linux/pm_runtime.h>
-#include <linux/vga_switcheroo.h>
 #include <drm/drm_probe_helper.h>
-#include <linux/mmu_notifier.h>
-#include <linux/suspend.h>
+#include <drm/drm_vblank.h>
+
 #include <linux/cc_platform.h>
 #include <linux/dynamic_debug.h>
+#include <linux/module.h>
+#include <linux/mmu_notifier.h>
+#include <linux/pm_runtime.h>
+#include <linux/suspend.h>
+#include <linux/vga_switcheroo.h>
 
 #include "amdgpu.h"
-#include "amdgpu_irq.h"
+#include "amdgpu_amdkfd.h"
 #include "amdgpu_dma_buf.h"
-#include "amdgpu_sched.h"
+#include "amdgpu_drv.h"
 #include "amdgpu_fdinfo.h"
-#include "amdgpu_amdkfd.h"
-
+#include "amdgpu_irq.h"
 #include "amdgpu_ras.h"
-#include "amdgpu_xgmi.h"
 #include "amdgpu_reset.h"
+#include "amdgpu_sched.h"
+#include "amdgpu_xgmi.h"
 #include "../amdxcp/amdgpu_xcp_drv.h"
 
 /*
-- 
2.40.1



