Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002677A68CE
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 18:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjISQYg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 12:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjISQYg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 12:24:36 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCFABE
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 09:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ThHPhp7D+dumngpb/ciY77jVjG2fyzljgAXJo4aqbkA=; b=DR8WXB+hcnA5vaPwiNRZn9PD2r
        Ux7mkyummnyx9m9iD4Eydgs5lh/Qs7IMQqwUQf1nNMhG7TzmplQzjRTzbAhcU+7dNupjuy+rpxVww
        bZkOmLCPUV/7VRHC4flId66mMCwG0f5/iktK1Af9MQWehVntE3DUrU+kW7+Jp6DrafUXmsi/9GqcX
        UQwwm5nbGyo7fLLPZcrWaqTEZCWFoQRLTpWlDfeD2FJzmIyM3s8j7SXx9hHGtrlGdgB2Gh9lceJ42
        a7XJvTXDezA3Gf2TOz1g34yLwfpAODjMfYgkyHbpraJzRfAO7o3G5ap0ebHaIlF7hL9KzwYQREdbC
        LXEePvKw==;
Received: from [38.44.68.151] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qidWS-006Aw0-Rl; Tue, 19 Sep 2023 18:24:25 +0200
From:   Melissa Wen <mwen@igalia.com>
To:     stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15.y] drm/amd/display: enable cursor degamma for DCN3+ DRM legacy gamma
Date:   Tue, 19 Sep 2023 15:24:05 -0100
Message-Id: <20230919162405.1173166-1-mwen@igalia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023091617-deserve-animal-a57e@gregkh>
References: <2023091617-deserve-animal-a57e@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

For DRM legacy gamma, AMD display manager applies implicit sRGB degamma
using a pre-defined sRGB transfer function. It works fine for DCN2
family where degamma ROM and custom curves go to the same color block.
But, on DCN3+, degamma is split into two blocks: degamma ROM for
pre-defined TFs and `gamma correction` for user/custom curves and
degamma ROM settings doesn't apply to cursor plane. To get DRM legacy
gamma working as expected, enable cursor degamma ROM for implict sRGB
degamma on HW with this configuration.

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2803
Fixes: 96b020e2163f ("drm/amd/display: check attr flag before set cursor degamma on DCN3+")
Signed-off-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 57a943ebfcdb4a97fbb409640234bdb44bfa1953)
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4cf33abfb7cc..dd7e0f8c3706 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8790,6 +8790,13 @@ static void handle_cursor_update(struct drm_plane *plane,
 	attributes.rotation_angle    = 0;
 	attributes.attribute_flags.value = 0;
 
+	/* Enable cursor degamma ROM on DCN3+ for implicit sRGB degamma in DRM
+	 * legacy gamma setup.
+	 */
+	if (crtc_state->cm_is_degamma_srgb &&
+	    adev->dm.dc->caps.color.dpp.gamma_corr)
+		attributes.attribute_flags.bits.ENABLE_CURSOR_DEGAMMA = 1;
+
 	attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
 
 	if (crtc_state->stream) {
-- 
2.40.1

