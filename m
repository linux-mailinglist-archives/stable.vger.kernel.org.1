Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68EB75E241
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 16:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjGWOCy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 10:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjGWOCx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 10:02:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F37E6
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 07:02:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EE0960BB8
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 14:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8111AC433C8;
        Sun, 23 Jul 2023 14:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690120967;
        bh=cSiOZowXggGTbw3B1EtaN8kchKIz8eNHbCezQIr3K+k=;
        h=Subject:To:Cc:From:Date:From;
        b=xlR+1IuPPlrTvpmHSirRUJxFkD8hRIWEBcUrPHmNOdYI2HzSoqHcAoW1wD3g0ZuTX
         vn/a4q1/axxIJxU/yhz/A//S+EeqVVMsxal0Vszy9U8IeRcGO4n+FGPAsRPnos0ZFO
         9z/qshlvMgGajiGab4DWhKIlYmiwfKlopnal6D50=
Subject: FAILED: patch "[PATCH] drm/amdgpu/vkms: relax timer deactivation by" failed to apply to 5.15-stable tree
To:     guchun.chen@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 23 Jul 2023 16:02:45 +0200
Message-ID: <2023072344-gyration-coveted-1049@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b42ae87a7b3878afaf4c3852ca66c025a5b996e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072344-gyration-coveted-1049@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

b42ae87a7b38 ("drm/amdgpu/vkms: relax timer deactivation by hrtimer_try_to_cancel")
deefd07eedb7 ("drm/amdgpu: fix vkms crtc settings")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b42ae87a7b3878afaf4c3852ca66c025a5b996e0 Mon Sep 17 00:00:00 2001
From: Guchun Chen <guchun.chen@amd.com>
Date: Thu, 6 Jul 2023 15:57:21 +0800
Subject: [PATCH] drm/amdgpu/vkms: relax timer deactivation by
 hrtimer_try_to_cancel
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In below thousands of screen rotation loop tests with virtual display
enabled, a CPU hard lockup issue may happen, leading system to unresponsive
and crash.

do {
	xrandr --output Virtual --rotate inverted
	xrandr --output Virtual --rotate right
	xrandr --output Virtual --rotate left
	xrandr --output Virtual --rotate normal
} while (1);

NMI watchdog: Watchdog detected hard LOCKUP on cpu 1

? hrtimer_run_softirq+0x140/0x140
? store_vblank+0xe0/0xe0 [drm]
hrtimer_cancel+0x15/0x30
amdgpu_vkms_disable_vblank+0x15/0x30 [amdgpu]
drm_vblank_disable_and_save+0x185/0x1f0 [drm]
drm_crtc_vblank_off+0x159/0x4c0 [drm]
? record_print_text.cold+0x11/0x11
? wait_for_completion_timeout+0x232/0x280
? drm_crtc_wait_one_vblank+0x40/0x40 [drm]
? bit_wait_io_timeout+0xe0/0xe0
? wait_for_completion_interruptible+0x1d7/0x320
? mutex_unlock+0x81/0xd0
amdgpu_vkms_crtc_atomic_disable

It's caused by a stuck in lock dependency in such scenario on different
CPUs.

CPU1                                             CPU2
drm_crtc_vblank_off                              hrtimer_interrupt
    grab event_lock (irq disabled)                   __hrtimer_run_queues
        grab vbl_lock/vblank_time_block                  amdgpu_vkms_vblank_simulate
            amdgpu_vkms_disable_vblank                       drm_handle_vblank
                hrtimer_cancel                                         grab dev->event_lock

So CPU1 stucks in hrtimer_cancel as timer callback is running endless on
current clock base, as that timer queue on CPU2 has no chance to finish it
because of failing to hold the lock. So NMI watchdog will throw the errors
after its threshold, and all later CPUs are impacted/blocked.

So use hrtimer_try_to_cancel to fix this, as disable_vblank callback
does not need to wait the handler to finish. And also it's not necessary
to check the return value of hrtimer_try_to_cancel, because even if it's
-1 which means current timer callback is running, it will be reprogrammed
in hrtimer_start with calling enable_vblank to make it works.

v2: only re-arm timer when vblank is enabled (Christian) and add a Fixes
tag as well

v3: drop warn printing (Christian)

v4: drop superfluous check of blank->enabled in timer function, as it's
guaranteed in drm_handle_vblank (Christian)

Fixes: 84ec374bd580 ("drm/amdgpu: create amdgpu_vkms (v4)")
Cc: stable@vger.kernel.org
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 53ff91fc6cf6..d0748bcfad16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -55,8 +55,9 @@ static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
 		DRM_WARN("%s: vblank timer overrun\n", __func__);
 
 	ret = drm_crtc_handle_vblank(crtc);
+	/* Don't queue timer again when vblank is disabled. */
 	if (!ret)
-		DRM_ERROR("amdgpu_vkms failure on handling vblank");
+		return HRTIMER_NORESTART;
 
 	return HRTIMER_RESTART;
 }
@@ -81,7 +82,7 @@ static void amdgpu_vkms_disable_vblank(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
-	hrtimer_cancel(&amdgpu_crtc->vblank_timer);
+	hrtimer_try_to_cancel(&amdgpu_crtc->vblank_timer);
 }
 
 static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,

