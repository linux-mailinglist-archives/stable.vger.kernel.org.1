Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE5876159E
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbjGYLbI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbjGYLbI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:31:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC4019C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:31:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A1E96168E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EE7C433C7;
        Tue, 25 Jul 2023 11:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284665;
        bh=PJa6LnwHH+imW43OkH9In8SQd82SQqbP1Gy2+ZATfpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BKsLdVmJkJoY44HdWsty6zqjeDLakeFyJJuRMZS0/6dvzzFOyeqvdnz2UMeDur2dI
         X4rmn2JeqmMVPxYUL+CZajuB/6OJytPM3cGUZdgS5rs5aZMzrWEmUOwwU4D4V7EbuV
         qN4EwpEusbe1Bm++Q1Nv7Sh5M7zl1eSLcl0JO1yo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "kernelci.org bot" <bot@kernelci.org>,
        Brian Norris <briannorris@chromium.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 5.10 409/509] drm/rockchip: vop: Leave vblank enabled in self-refresh
Date:   Tue, 25 Jul 2023 12:45:48 +0200
Message-ID: <20230725104612.441363261@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Brian Norris <briannorris@chromium.org>

commit 2bdba9d4a3baa758c2ca7f5b37b35c7b3391dc42 upstream.

If we disable vblank when entering self-refresh, vblank APIs (like
DRM_IOCTL_WAIT_VBLANK) no longer work. But user space is not aware when
we enter self-refresh, so this appears to be an API violation -- that
DRM_IOCTL_WAIT_VBLANK fails with EINVAL whenever the display is idle and
enters self-refresh.

The downstream driver used by many of these systems never used to
disable vblank for PSR, and in fact, even upstream, we didn't do that
until radically redesigning the state machine in commit 6c836d965bad
("drm/rockchip: Use the helpers for PSR").

Thus, it seems like a reasonable API fix to simply restore that
behavior, and leave vblank enabled.

Note that this appears to potentially unbalance the
drm_crtc_vblank_{off,on}() calls in some cases, but:
(a) drm_crtc_vblank_on() documents this as OK and
(b) if I do the naive balancing, I find state machine issues such that
    we're not in sync properly; so it's easier to take advantage of (a).

This issue was exposed by IGT's kms_vblank tests, and reported by
KernelCI. The bug has been around a while (longer than KernelCI
noticed), but was only exposed once self-refresh was bugfixed more
recently, and so KernelCI could properly test it. Some other notes in:

  https://lore.kernel.org/dri-devel/Y6OCg9BPnJvimQLT@google.com/
  Re: renesas/master bisection: igt-kms-rockchip.kms_vblank.pipe-A-wait-forked on rk3399-gru-kevin

== Backporting notes: ==

Marking as 'Fixes' commit 6c836d965bad ("drm/rockchip: Use the helpers
for PSR"), but it probably depends on commit bed030a49f3e
("drm/rockchip: Don't fully disable vop on self refresh") as well.

We also need the previous patch ("drm/atomic: Allow vblank-enabled +
self-refresh "disable""), of course.

v3:
 * no update

v2:
 * skip unnecessary lock/unlock

Fixes: 6c836d965bad ("drm/rockchip: Use the helpers for PSR")
Cc: <stable@vger.kernel.org>
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Link: https://lore.kernel.org/dri-devel/Y5itf0+yNIQa6fU4@sirena.org.uk/
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230109171809.v3.2.Ic07cba4ab9a7bd3618a9e4258b8f92ea7d10ae5a@changeid
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -702,13 +702,13 @@ static void vop_crtc_atomic_disable(stru
 	if (crtc->state->self_refresh_active)
 		rockchip_drm_set_win_enabled(crtc, false);
 
+	if (crtc->state->self_refresh_active)
+		goto out;
+
 	mutex_lock(&vop->vop_lock);
 
 	drm_crtc_vblank_off(crtc);
 
-	if (crtc->state->self_refresh_active)
-		goto out;
-
 	/*
 	 * Vop standby will take effect at end of current frame,
 	 * if dsp hold valid irq happen, it means standby complete.
@@ -740,9 +740,9 @@ static void vop_crtc_atomic_disable(stru
 	vop_core_clks_disable(vop);
 	pm_runtime_put(vop->dev);
 
-out:
 	mutex_unlock(&vop->vop_lock);
 
+out:
 	if (crtc->state->event && !crtc->state->active) {
 		spin_lock_irq(&crtc->dev->event_lock);
 		drm_crtc_send_vblank_event(crtc, crtc->state->event);


