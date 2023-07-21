Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD6475CD96
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjGUQNK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjGUQMt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:12:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A612C4237
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:12:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83A4C61D2D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FEFC433C7;
        Fri, 21 Jul 2023 16:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955943;
        bh=7+rYtToEZBfhNGTjKMIX7gmfFZmGxCuJKCHIgCEYuNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HXC93Gxwo2dpCy25p9G73NGGFW7i+AEnMIBkV562Of4+qSBJXCegfgBuNSnWg4fjs
         E0DEtAnm70gySffP/IGot5hAXa+xW6GwNSEXms4118Ot9og4FIRhij/vMGcab5TgzC
         lzsZEXkFC+uouJwYZIjgInTS3RU/RngD3VdlRGkA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 085/292] drm/i915: Dont preserve dpll_hw_state for slave crtc in Bigjoiner
Date:   Fri, 21 Jul 2023 18:03:14 +0200
Message-ID: <20230721160532.455970286@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
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

From: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>

[ Upstream commit 5c413188c68da0e4bffc93de1c80257e20741e69 ]

If we are using Bigjoiner dpll_hw_state is supposed to be exactly
same as for master crtc, so no need to save it's state for slave crtc.

Signed-off-by: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
Fixes: 0ff0e219d9b8 ("drm/i915: Compute clocks earlier")
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230628141017.18937-1-stanislav.lisovskiy@intel.com
(cherry picked from commit cbaf758809952c95ec00e796695049babb08bb60)
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_display.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 7749f95d5d02a..a805b57f3d912 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -4968,7 +4968,6 @@ copy_bigjoiner_crtc_state_modeset(struct intel_atomic_state *state,
 	saved_state->uapi = slave_crtc_state->uapi;
 	saved_state->scaler_state = slave_crtc_state->scaler_state;
 	saved_state->shared_dpll = slave_crtc_state->shared_dpll;
-	saved_state->dpll_hw_state = slave_crtc_state->dpll_hw_state;
 	saved_state->crc_enabled = slave_crtc_state->crc_enabled;
 
 	intel_crtc_free_hw_state(slave_crtc_state);
-- 
2.39.2



