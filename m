Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BED070345F
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243006AbjEOQro (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242933AbjEOQrk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:47:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B3B59FD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:47:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2151C62921
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE26CC433D2;
        Mon, 15 May 2023 16:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169240;
        bh=9DKgt/JDPUYmyZ/wbVYvDukfctL4AqyJnAp9frN8dHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=18XObNpU7MYRn1mw1iK8BD115v0KNnjuK7r5sgOJ3ZH/Tg+8lfQKo0liL7mnfxSIs
         Fv93IdkjcI/oZ5aDQSdBVsBMGyuKjY6YpBBVF/Nx4APfkmhqoVzOWEWz2TGnqkoOON
         EtzMkLoc7mm2SB4uK0P2IJOrCbPhqEJKyICguM94=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hawking Zhang <Hawking.Zhang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Rex Zhu <Rex.Zhu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 157/191] drm/amdgpu: Put enable gfx off feature to a delay thread
Date:   Mon, 15 May 2023 18:26:34 +0200
Message-Id: <20230515161713.123794861@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
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

From: Rex Zhu <Rex.Zhu@amd.com>

[ Upstream commit 1e317b99f0c244bd8830918fdae9715210baf4fe ]

delay to enable gfx off feature to avoid gfx on/off frequently
suggested by Alex and Evan.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Rex Zhu <Rex.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 2397e3d8d2e1 ("drm/amdgpu: add a missing lock for AMDGPU_SCHED")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  8 ++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 624864148f1d6..45e6dfa330adc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -954,6 +954,8 @@ struct amdgpu_gfx {
 	bool                            gfx_off_state; /* true: enabled, false: disabled */
 	struct mutex                    gfx_off_mutex;
 	uint32_t                        gfx_off_req_count; /* default 1, enable gfx off: dec 1, disable gfx off: add 1 */
+	struct delayed_work             gfx_off_delay_work;
+
 	/* pipe reservation */
 	struct mutex			pipe_reserve_mutex;
 	DECLARE_BITMAP			(pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fed1097c64690..787cbeea8dc55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1927,6 +1927,19 @@ static void amdgpu_device_ip_late_init_func_handler(struct work_struct *work)
 		DRM_ERROR("ib ring test failed (%d).\n", r);
 }
 
+static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
+{
+	struct amdgpu_device *adev =
+		container_of(work, struct amdgpu_device, gfx.gfx_off_delay_work.work);
+
+	mutex_lock(&adev->gfx.gfx_off_mutex);
+	if (!adev->gfx.gfx_off_state && !adev->gfx.gfx_off_req_count) {
+		if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true))
+			adev->gfx.gfx_off_state = true;
+	}
+	mutex_unlock(&adev->gfx.gfx_off_mutex);
+}
+
 /**
  * amdgpu_device_ip_suspend_phase1 - run suspend for hardware IPs (phase 1)
  *
@@ -2396,6 +2409,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	INIT_DELAYED_WORK(&adev->late_init_work,
 			  amdgpu_device_ip_late_init_func_handler);
+	INIT_DELAYED_WORK(&adev->gfx.gfx_off_delay_work,
+			  amdgpu_device_delay_enable_gfx_off);
 
 	adev->gfx.gfx_off_req_count = 1;
 	adev->pm.ac_power = power_supply_is_system_supplied() > 0 ? true : false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 889d1266f3ae7..af42c2464a598 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -26,6 +26,9 @@
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
 
+/* 0.5 second timeout */
+#define GFX_OFF_DELAY_ENABLE         msecs_to_jiffies(500)
+
 /*
  * GPU scratch registers helpers function.
  */
@@ -360,6 +363,7 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 	if (!adev->powerplay.pp_funcs->set_powergating_by_smu)
 		return;
 
+
 	mutex_lock(&adev->gfx.gfx_off_mutex);
 
 	if (!enable)
@@ -368,11 +372,11 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 		adev->gfx.gfx_off_req_count--;
 
 	if (enable && !adev->gfx.gfx_off_state && !adev->gfx.gfx_off_req_count) {
-		if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true))
-			adev->gfx.gfx_off_state = true;
+		schedule_delayed_work(&adev->gfx.gfx_off_delay_work, GFX_OFF_DELAY_ENABLE);
 	} else if (!enable && adev->gfx.gfx_off_state) {
 		if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, false))
 			adev->gfx.gfx_off_state = false;
 	}
+
 	mutex_unlock(&adev->gfx.gfx_off_mutex);
 }
-- 
2.39.2



