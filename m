Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF8D76159D
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjGYLbG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjGYLbF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:31:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC981F2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:31:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A33C615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753B0C433C8;
        Tue, 25 Jul 2023 11:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284662;
        bh=dSx4dT3gBy1aEJP67MAfqh2C/mDEXfg3fgMNTmNTWtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Too1zwNumXhoGP26rCC4MFbNUGqvbInJJkPv5MDB0eD5yVJvCJYIxxT79r7OhUfwc
         OZLdQNU6btmbHDwTuGEWo1tihaPuSqEswE+9BOuRKEjTsX02f+vza1Ekwz4lBlmAiN
         0YjpqprpOEZ8x0ykBxgsAbFC58njNfmRcA2Wj2+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Brian Norris <briannorris@chromium.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 5.10 408/509] drm/atomic: Allow vblank-enabled + self-refresh "disable"
Date:   Tue, 25 Jul 2023 12:45:47 +0200
Message-ID: <20230725104612.401579011@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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

From: Brian Norris <briannorris@chromium.org>

commit 9d0e3cac3517942a6e00eeecfe583a98715edb16 upstream.

The self-refresh helper framework overloads "disable" to sometimes mean
"go into self-refresh mode," and this mode activates automatically
(e.g., after some period of unchanging display output). In such cases,
the display pipe is still considered "on", and user-space is not aware
that we went into self-refresh mode. Thus, users may expect that
vblank-related features (such as DRM_IOCTL_WAIT_VBLANK) still work
properly.

However, we trigger the WARN_ONCE() here if a CRTC driver tries to leave
vblank enabled.

Add a different expectation: that CRTCs *should* leave vblank enabled
when going into self-refresh.

This patch is preparation for another patch -- "drm/rockchip: vop: Leave
vblank enabled in self-refresh" -- which resolves conflicts between the
above self-refresh behavior and the API tests in IGT's kms_vblank test
module.

== Some alternatives discussed: ==

It's likely that on many display controllers, vblank interrupts will
turn off when the CRTC is disabled, and so in some cases, self-refresh
may not support vblank. To support such cases, we might consider
additions to the generic helpers such that we fire vblank events based
on a timer.

However, there is currently only one driver using the common
self-refresh helpers (i.e., rockchip), and at least as of commit
bed030a49f3e ("drm/rockchip: Don't fully disable vop on self refresh"),
the CRTC hardware is powered enough to continue to generate vblank
interrupts.

So we chose the simpler option of leaving vblank interrupts enabled. We
can reevaluate this decision and perhaps augment the helpers if/when we
gain a second driver that has different requirements.

v3:
 * include discussion summary

v2:
 * add 'ret != 0' warning case for self-refresh
 * describe failing test case and relation to drm/rockchip patch better

Cc: <stable@vger.kernel.org> # dependency for "drm/rockchip: vop: Leave
                             # vblank enabled in self-refresh"
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230109171809.v3.1.I3904f697863649eb1be540ecca147a66e42bfad7@changeid
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_atomic_helper.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1113,7 +1113,16 @@ disable_outputs(struct drm_device *dev,
 			continue;
 
 		ret = drm_crtc_vblank_get(crtc);
-		WARN_ONCE(ret != -EINVAL, "driver forgot to call drm_crtc_vblank_off()\n");
+		/*
+		 * Self-refresh is not a true "disable"; ensure vblank remains
+		 * enabled.
+		 */
+		if (new_crtc_state->self_refresh_active)
+			WARN_ONCE(ret != 0,
+				  "driver disabled vblank in self-refresh\n");
+		else
+			WARN_ONCE(ret != -EINVAL,
+				  "driver forgot to call drm_crtc_vblank_off()\n");
 		if (ret == 0)
 			drm_crtc_vblank_put(crtc);
 	}


