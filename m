Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE5476AD00
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjHAJZW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjHAJZC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:25:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B752D7E
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:23:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8747E614F5
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A758C433C7;
        Tue,  1 Aug 2023 09:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881830;
        bh=rwgP3lqA5k0OP4yaS3FooERxQ1rdwFL0Uuu1kVKlOoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ud4PvIQ5VdZBqI/xX9cbbcSxsKuygiYRIGlen2Fbz/5APR2HM/Vm2kG1eOJaFGZSb
         gX3NxeHmMF2Fv/ajSK3TbnXTGBytHnwzsM8TeVzX21S+JbR90OYYhoadX1RHi3lcmt
         +bhayTrui/HUQz32bQ/umN/dctEtgXIkwi4aZjGk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Flora Cui <flora.cui@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 044/155] drm/amdgpu: fix vkms crtc settings
Date:   Tue,  1 Aug 2023 11:19:16 +0200
Message-ID: <20230801091911.752485569@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Flora Cui <flora.cui@amd.com>

[ Upstream commit deefd07eedb7baa25956c8365373e6a58c81565a ]

otherwise adev->mode_info.crtcs[] is NULL

Signed-off-by: Flora Cui <flora.cui@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: b42ae87a7b38 ("drm/amdgpu/vkms: relax timer deactivation by hrtimer_try_to_cancel")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 42 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h |  5 ++-
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 7d58bf410be05..24251cdf95073 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -16,6 +16,8 @@
 #include "ivsrcid/ivsrcid_vislands30.h"
 #include "amdgpu_vkms.h"
 #include "amdgpu_display.h"
+#include "atom.h"
+#include "amdgpu_irq.h"
 
 /**
  * DOC: amdgpu_vkms
@@ -41,14 +43,13 @@ static const u32 amdgpu_vkms_formats[] = {
 
 static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
 {
-	struct amdgpu_vkms_output *output = container_of(timer,
-							 struct amdgpu_vkms_output,
-							 vblank_hrtimer);
-	struct drm_crtc *crtc = &output->crtc;
+	struct amdgpu_crtc *amdgpu_crtc = container_of(timer, struct amdgpu_crtc, vblank_timer);
+	struct drm_crtc *crtc = &amdgpu_crtc->base;
+	struct amdgpu_vkms_output *output = drm_crtc_to_amdgpu_vkms_output(crtc);
 	u64 ret_overrun;
 	bool ret;
 
-	ret_overrun = hrtimer_forward_now(&output->vblank_hrtimer,
+	ret_overrun = hrtimer_forward_now(&amdgpu_crtc->vblank_timer,
 					  output->period_ns);
 	WARN_ON(ret_overrun != 1);
 
@@ -65,22 +66,21 @@ static int amdgpu_vkms_enable_vblank(struct drm_crtc *crtc)
 	unsigned int pipe = drm_crtc_index(crtc);
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
 	struct amdgpu_vkms_output *out = drm_crtc_to_amdgpu_vkms_output(crtc);
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
 	drm_calc_timestamping_constants(crtc, &crtc->mode);
 
-	hrtimer_init(&out->vblank_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	out->vblank_hrtimer.function = &amdgpu_vkms_vblank_simulate;
 	out->period_ns = ktime_set(0, vblank->framedur_ns);
-	hrtimer_start(&out->vblank_hrtimer, out->period_ns, HRTIMER_MODE_REL);
+	hrtimer_start(&amdgpu_crtc->vblank_timer, out->period_ns, HRTIMER_MODE_REL);
 
 	return 0;
 }
 
 static void amdgpu_vkms_disable_vblank(struct drm_crtc *crtc)
 {
-	struct amdgpu_vkms_output *out = drm_crtc_to_amdgpu_vkms_output(crtc);
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
-	hrtimer_cancel(&out->vblank_hrtimer);
+	hrtimer_cancel(&amdgpu_crtc->vblank_timer);
 }
 
 static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,
@@ -92,13 +92,14 @@ static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,
 	unsigned int pipe = crtc->index;
 	struct amdgpu_vkms_output *output = drm_crtc_to_amdgpu_vkms_output(crtc);
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
 	if (!READ_ONCE(vblank->enabled)) {
 		*vblank_time = ktime_get();
 		return true;
 	}
 
-	*vblank_time = READ_ONCE(output->vblank_hrtimer.node.expires);
+	*vblank_time = READ_ONCE(amdgpu_crtc->vblank_timer.node.expires);
 
 	if (WARN_ON(*vblank_time == vblank->time))
 		return true;
@@ -166,6 +167,8 @@ static const struct drm_crtc_helper_funcs amdgpu_vkms_crtc_helper_funcs = {
 static int amdgpu_vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 			  struct drm_plane *primary, struct drm_plane *cursor)
 {
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	int ret;
 
 	ret = drm_crtc_init_with_planes(dev, crtc, primary, cursor,
@@ -177,6 +180,17 @@ static int amdgpu_vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 
 	drm_crtc_helper_add(crtc, &amdgpu_vkms_crtc_helper_funcs);
 
+	amdgpu_crtc->crtc_id = drm_crtc_index(crtc);
+	adev->mode_info.crtcs[drm_crtc_index(crtc)] = amdgpu_crtc;
+
+	amdgpu_crtc->pll_id = ATOM_PPLL_INVALID;
+	amdgpu_crtc->encoder = NULL;
+	amdgpu_crtc->connector = NULL;
+	amdgpu_crtc->vsync_timer_enabled = AMDGPU_IRQ_STATE_DISABLE;
+
+	hrtimer_init(&amdgpu_crtc->vblank_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	amdgpu_crtc->vblank_timer.function = &amdgpu_vkms_vblank_simulate;
+
 	return ret;
 }
 
@@ -402,7 +416,7 @@ int amdgpu_vkms_output_init(struct drm_device *dev,
 {
 	struct drm_connector *connector = &output->connector;
 	struct drm_encoder *encoder = &output->encoder;
-	struct drm_crtc *crtc = &output->crtc;
+	struct drm_crtc *crtc = &output->crtc.base;
 	struct drm_plane *primary, *cursor = NULL;
 	int ret;
 
@@ -505,8 +519,8 @@ static int amdgpu_vkms_sw_fini(void *handle)
 	int i = 0;
 
 	for (i = 0; i < adev->mode_info.num_crtc; i++)
-		if (adev->amdgpu_vkms_output[i].vblank_hrtimer.function)
-			hrtimer_cancel(&adev->amdgpu_vkms_output[i].vblank_hrtimer);
+		if (adev->mode_info.crtcs[i])
+			hrtimer_cancel(&adev->mode_info.crtcs[i]->vblank_timer);
 
 	kfree(adev->mode_info.bios_hardcoded_edid);
 	kfree(adev->amdgpu_vkms_output);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h
index 97f1b79c0724e..4f8722ff37c25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h
@@ -10,15 +10,14 @@
 #define YRES_MAX  16384
 
 #define drm_crtc_to_amdgpu_vkms_output(target) \
-	container_of(target, struct amdgpu_vkms_output, crtc)
+	container_of(target, struct amdgpu_vkms_output, crtc.base)
 
 extern const struct amdgpu_ip_block_version amdgpu_vkms_ip_block;
 
 struct amdgpu_vkms_output {
-	struct drm_crtc crtc;
+	struct amdgpu_crtc crtc;
 	struct drm_encoder encoder;
 	struct drm_connector connector;
-	struct hrtimer vblank_hrtimer;
 	ktime_t period_ns;
 	struct drm_pending_vblank_event *event;
 };
-- 
2.39.2



