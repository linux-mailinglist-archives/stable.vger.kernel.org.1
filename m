Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDBF7A81C4
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjITMsY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjITMsW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:48:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEBA99
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:48:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BB4C433C8;
        Wed, 20 Sep 2023 12:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695214095;
        bh=xSeb2beHuQdVTGXkwJXw1fh9/4lCK+Sfyjrpv8kLsYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XBdPg61LDjC8EXMw8KtPwW/3wRCvp/XGNKOqVeoaIikCZNUWTMPbYkfj5Sbyy/xNq
         KpNn7QhLFJl9yXpK/kt/DtUvNtqmMPQ9bPdeJFb5NBLaL32VOEnQVh1L+bjWUVudDC
         yY0DFiFvIjQPWfkazi6/fRaILVtIddhGOrBq68sk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Melissa Wen <mwen@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15 110/110] drm/amd/display: enable cursor degamma for DCN3+ DRM legacy gamma
Date:   Wed, 20 Sep 2023 13:32:48 +0200
Message-ID: <20230920112834.531212725@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
References: <20230920112830.377666128@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Melissa Wen <mwen@igalia.com>

commit 57a943ebfcdb4a97fbb409640234bdb44bfa1953 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8794,6 +8794,13 @@ static void handle_cursor_update(struct
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


