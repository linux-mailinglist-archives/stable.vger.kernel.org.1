Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09AB719DEC
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjFAN1h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbjFAN1Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:27:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965A2E4A
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:27:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77724644AB
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D71C433EF;
        Thu,  1 Jun 2023 13:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626026;
        bh=XUeEaJx8O5Ql4cHjKXrktV9MBQ7NFKrSs1iCs1SeYdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QDcfV+3h0SwZBkfk+5rQHPM8qnpfFNXZkTwL/8rgINfKrc5nzelfPwQfjtcIylpWW
         oumk854sR3uZrlnEXll0icWbjQ6e6Z/plePXrommLYxUXvxIoDsrW/JOGUBYRMgL41
         lOnZzajgwmLDzWYszR5NkHqx68UlT53rS0UGkt2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Imre Deak <imre.deak@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Mika Kahola <mika.kahola@intel.com>
Subject: [PATCH 6.3 21/45] drm/i915: Move shared DPLL disabling into CRTC disable hook
Date:   Thu,  1 Jun 2023 14:21:17 +0100
Message-Id: <20230601131939.678247433@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Imre Deak <imre.deak@intel.com>

[ Upstream commit 3acac2d06a7e0f0b182b86b25bb8a2e9b3300406 ]

The spec requires disabling the PLL on TC ports before disconnecting the
port's PHY. Prepare for that by moving the PLL disabling to the CRTC
disable hook, while disconnecting the PHY will be moved to the
post_pll_disable() encoder hook in the next patch.

v2: Move the call from intel_crtc_disable_noatomic() as well.

Reviewed-by: Mika Kahola <mika.kahola@intel.com> # v1
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230323142035.1432621-27-imre.deak@intel.com
Stable-dep-of: 45dfbd992923 ("drm/i915: Fix PIPEDMC disabling for a bigjoiner configuration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_display.c       | 5 ++++-
 drivers/gpu/drm/i915/display/intel_modeset_setup.c | 1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 2bef50ab0ad19..df4c6e000961c 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -2000,6 +2000,8 @@ static void ilk_crtc_disable(struct intel_atomic_state *state,
 
 	intel_set_cpu_fifo_underrun_reporting(dev_priv, pipe, true);
 	intel_set_pch_fifo_underrun_reporting(dev_priv, pipe, true);
+
+	intel_disable_shared_dpll(old_crtc_state);
 }
 
 static void hsw_crtc_disable(struct intel_atomic_state *state,
@@ -2018,6 +2020,8 @@ static void hsw_crtc_disable(struct intel_atomic_state *state,
 		intel_encoders_post_disable(state, crtc);
 	}
 
+	intel_disable_shared_dpll(old_crtc_state);
+
 	intel_dmc_disable_pipe(i915, crtc->pipe);
 }
 
@@ -7140,7 +7144,6 @@ static void intel_old_crtc_state_disables(struct intel_atomic_state *state,
 	dev_priv->display.funcs.display->crtc_disable(state, crtc);
 	crtc->active = false;
 	intel_fbc_disable(crtc);
-	intel_disable_shared_dpll(old_crtc_state);
 
 	if (!new_crtc_state->hw.active)
 		intel_initial_watermarks(state, crtc);
diff --git a/drivers/gpu/drm/i915/display/intel_modeset_setup.c b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
index 52cdbd4fc2fa0..48b726e408057 100644
--- a/drivers/gpu/drm/i915/display/intel_modeset_setup.c
+++ b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
@@ -96,7 +96,6 @@ static void intel_crtc_disable_noatomic(struct intel_crtc *crtc,
 
 	intel_fbc_disable(crtc);
 	intel_update_watermarks(i915);
-	intel_disable_shared_dpll(crtc_state);
 
 	intel_display_power_put_all_in_set(i915, &crtc->enabled_power_domains);
 
-- 
2.39.2



