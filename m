Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEDA79B6AE
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354131AbjIKVwe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbjIKOHV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:07:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899FBCF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:07:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D07C433C7;
        Mon, 11 Sep 2023 14:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441237;
        bh=UT964tAIl/2ScxzmhfoL8Yfx3xQJ2wzCgjXowk5GO4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ok9sXDGq+cmc77fVD9x26nYrmc5RVumMgg5Yf5iFx+ustLLqwIVzWv9l9P1CpM5n3
         paKdWnh3+gCyq+CWj1fSDNrvleAknhPR2cVkYtG8Dq2/aMoo2MlEvmI76zMnBugdhA
         PfgbnNLsLKiQFMazFb9QVllKvFWHh7cNYt0ifk98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 316/739] drm/amdgpu: Move vram, gtt & flash defines to amdgpu_ ttm & _psp.h
Date:   Mon, 11 Sep 2023 15:41:55 +0200
Message-ID: <20230911134659.936903239@linuxfoundation.org>
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

[ Upstream commit 4e2abc197f11e25b5813d4c42dada19d36b04666 ]

As amdgpu.h is getting decomposed, move vram and gtt extern defines into
amdgpu_ttm.h & flash extern to amdgpu_psp.h

Fixes: f9acfafc3458 ("drm/amdgpu: Move externs to amdgpu.h file from amdgpu_drv.c")
Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Acked-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 8d16190e6b046..e06009966428f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -45,6 +45,7 @@
 #include "amdgpu_drv.h"
 #include "amdgpu_fdinfo.h"
 #include "amdgpu_irq.h"
+#include "amdgpu_psp.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_reset.h"
 #include "amdgpu_sched.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 2cae0b1a0b8ac..c162d018cf259 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -39,6 +39,8 @@
 #define PSP_TMR_ALIGNMENT	0x100000
 #define PSP_FW_NAME_LEN		0x24
 
+extern const struct attribute_group amdgpu_flash_attr_group;
+
 enum psp_shared_mem_size {
 	PSP_ASD_SHARED_MEM_SIZE				= 0x0,
 	PSP_XGMI_SHARED_MEM_SIZE			= 0x4000,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 6d0d66e40db93..96732897f87a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -39,6 +39,9 @@
 
 #define AMDGPU_POISON	0xd0bed0be
 
+extern const struct attribute_group amdgpu_vram_mgr_attr_group;
+extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
+
 struct hmm_range;
 
 struct amdgpu_gtt_mgr {
-- 
2.40.1



