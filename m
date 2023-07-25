Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C95761288
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjGYLDn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbjGYLDR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:03:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4035849CC
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:00:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCB496164D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D193AC433C8;
        Tue, 25 Jul 2023 10:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282790;
        bh=pFwe/pqEAna/s82laSAN18vkyZ87QG3lvq79eEPGKds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nl844KJq9KjQS20jTNU6yd7opVyrlBltmuZleQTsujNEWdxzJ68ekSmdsg4Ac8BtX
         hPA2C2mmK8zP8YBTLF8wyrHBTCuYXmGKOm2Bcsgywvn3LjyLXJeGU3J+00GCSQjlq/
         zIgYAp+2E0JrN2htzpRcp6zW9TsYfL5uDWuQgPlI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 027/183] drm/amdgpu/vkms: relax timer deactivation by hrtimer_try_to_cancel
Date:   Tue, 25 Jul 2023 12:44:15 +0200
Message-ID: <20230725104508.887513461@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Guchun Chen <guchun.chen@amd.com>

commit b42ae87a7b3878afaf4c3852ca66c025a5b996e0 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -55,8 +55,9 @@ static enum hrtimer_restart amdgpu_vkms_
 		DRM_WARN("%s: vblank timer overrun\n", __func__);
 
 	ret = drm_crtc_handle_vblank(crtc);
+	/* Don't queue timer again when vblank is disabled. */
 	if (!ret)
-		DRM_ERROR("amdgpu_vkms failure on handling vblank");
+		return HRTIMER_NORESTART;
 
 	return HRTIMER_RESTART;
 }
@@ -81,7 +82,7 @@ static void amdgpu_vkms_disable_vblank(s
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
-	hrtimer_cancel(&amdgpu_crtc->vblank_timer);
+	hrtimer_try_to_cancel(&amdgpu_crtc->vblank_timer);
 }
 
 static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,


