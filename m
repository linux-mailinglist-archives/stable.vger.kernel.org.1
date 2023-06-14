Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5844A719DED
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjFAN1j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbjFAN11 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:27:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0289A10D8
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:27:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8124644CC
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BD4C433EF;
        Thu,  1 Jun 2023 13:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626029;
        bh=AuWkn0cGR/4t4dFzzB6Ssg1RmVdzV/AP4ldZK4QR+hE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0LwfS+EO+iN9YkKUynxzDdlbnSliGx5AiHfX/vOofXKB2N1eq8dwNkVaw/JNjfQPz
         LhNtGoXNLsSOX2W1kBzvLPJqzhjDM4wg8H6Nqr2FDHXq8eZzVTi+aPS+CmzwTL6GBX
         wHbK3BNIoWSzyGAurbf4Fo5Hkjhzjm0l20XeqcvQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mika Kahola <mika.kahola@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 22/45] drm/i915: Disable DPLLs before disconnecting the TC PHY
Date:   Thu,  1 Jun 2023 14:21:18 +0100
Message-Id: <20230601131939.719965868@linuxfoundation.org>
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

[ Upstream commit b108bdd0e22a402bd3e4a6391acbb6aefad31a9e ]

Bspec requires disabling the DPLLs on TC ports before disconnecting the
port's PHY. Add a post_pll_disable encoder hook and move the call to
disconnect the port's PHY from the post_disable hook to the new hook.

Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230323142035.1432621-28-imre.deak@intel.com
Stable-dep-of: 45dfbd992923 ("drm/i915: Fix PIPEDMC disabling for a bigjoiner configuration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_ddi.c     | 15 ++++++++++++---
 drivers/gpu/drm/i915/display/intel_display.c |  2 ++
 drivers/gpu/drm/i915/display/intel_dp_mst.c  | 15 +++++++++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 254559abedfba..379050d228941 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -2731,9 +2731,6 @@ static void intel_ddi_post_disable(struct intel_atomic_state *state,
 				   const struct drm_connector_state *old_conn_state)
 {
 	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
-	struct intel_digital_port *dig_port = enc_to_dig_port(encoder);
-	enum phy phy = intel_port_to_phy(dev_priv, encoder->port);
-	bool is_tc_port = intel_phy_is_tc(dev_priv, phy);
 	struct intel_crtc *slave_crtc;
 
 	if (!intel_crtc_has_type(old_crtc_state, INTEL_OUTPUT_DP_MST)) {
@@ -2783,6 +2780,17 @@ static void intel_ddi_post_disable(struct intel_atomic_state *state,
 	else
 		intel_ddi_post_disable_dp(state, encoder, old_crtc_state,
 					  old_conn_state);
+}
+
+static void intel_ddi_post_pll_disable(struct intel_atomic_state *state,
+				       struct intel_encoder *encoder,
+				       const struct intel_crtc_state *old_crtc_state,
+				       const struct drm_connector_state *old_conn_state)
+{
+	struct drm_i915_private *i915 = to_i915(encoder->base.dev);
+	struct intel_digital_port *dig_port = enc_to_dig_port(encoder);
+	enum phy phy = intel_port_to_phy(i915, encoder->port);
+	bool is_tc_port = intel_phy_is_tc(i915, phy);
 
 	main_link_aux_power_domain_put(dig_port, old_crtc_state);
 
@@ -4381,6 +4389,7 @@ void intel_ddi_init(struct drm_i915_private *dev_priv, enum port port)
 	encoder->pre_pll_enable = intel_ddi_pre_pll_enable;
 	encoder->pre_enable = intel_ddi_pre_enable;
 	encoder->disable = intel_disable_ddi;
+	encoder->post_pll_disable = intel_ddi_post_pll_disable;
 	encoder->post_disable = intel_ddi_post_disable;
 	encoder->update_pipe = intel_ddi_update_pipe;
 	encoder->get_hw_state = intel_ddi_get_hw_state;
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index df4c6e000961c..963680ea6fedd 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -2022,6 +2022,8 @@ static void hsw_crtc_disable(struct intel_atomic_state *state,
 
 	intel_disable_shared_dpll(old_crtc_state);
 
+	intel_encoders_post_pll_disable(state, crtc);
+
 	intel_dmc_disable_pipe(i915, crtc->pipe);
 }
 
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 7c9b328bc2d73..a93018ce0e312 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -623,6 +623,20 @@ static void intel_mst_post_disable_dp(struct intel_atomic_state *state,
 		    intel_dp->active_mst_links);
 }
 
+static void intel_mst_post_pll_disable_dp(struct intel_atomic_state *state,
+					  struct intel_encoder *encoder,
+					  const struct intel_crtc_state *old_crtc_state,
+					  const struct drm_connector_state *old_conn_state)
+{
+	struct intel_dp_mst_encoder *intel_mst = enc_to_mst(encoder);
+	struct intel_digital_port *dig_port = intel_mst->primary;
+	struct intel_dp *intel_dp = &dig_port->dp;
+
+	if (intel_dp->active_mst_links == 0 &&
+	    dig_port->base.post_pll_disable)
+		dig_port->base.post_pll_disable(state, encoder, old_crtc_state, old_conn_state);
+}
+
 static void intel_mst_pre_pll_enable_dp(struct intel_atomic_state *state,
 					struct intel_encoder *encoder,
 					const struct intel_crtc_state *pipe_config,
@@ -1146,6 +1160,7 @@ intel_dp_create_fake_mst_encoder(struct intel_digital_port *dig_port, enum pipe
 	intel_encoder->compute_config_late = intel_dp_mst_compute_config_late;
 	intel_encoder->disable = intel_mst_disable_dp;
 	intel_encoder->post_disable = intel_mst_post_disable_dp;
+	intel_encoder->post_pll_disable = intel_mst_post_pll_disable_dp;
 	intel_encoder->update_pipe = intel_ddi_update_pipe;
 	intel_encoder->pre_pll_enable = intel_mst_pre_pll_enable_dp;
 	intel_encoder->pre_enable = intel_mst_pre_enable_dp;
-- 
2.39.2



