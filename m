Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52CD7A7B89
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbjITLxM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbjITLxL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:53:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098ACB0
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:53:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311E6C433C8;
        Wed, 20 Sep 2023 11:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210784;
        bh=5mpXTahiy4TKMHUOhP4mMeHXXC+RvNm6OSQu+gV0Lkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ftdn6THPZN3sahKQ5A8kMtUSO6Y8GqSyjCFb0iiJCSyKvCrzpS9NycKb76U2OtQlG
         ButJh2V1JLdSVgbSSO0pZde2N1prxi5SEClZ1N4LNqef+STLepI/GiCgHioLa7B1O+
         AllEmMowLUOQr55hZqKeS1AEYQwdGZqDLHlet8ao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.5 203/211] drm/i915: Only check eDP HPD when AUX CH is shared
Date:   Wed, 20 Sep 2023 13:30:47 +0200
Message-ID: <20230920112852.162043787@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 7c95ec3b59479bb24093918bbfc801c9f31826f2 upstream.

Apparently Acer Chromebook C740 (BDW-ULT) doesn't have the
eDP HPD line properly connected, and thus fails the new
HPD check during eDP probe. The result is that we lose the
eDP output.

I suspect all such machines would be Chromebooks or other
Linux exclusive systems as the Windows driver likely wouldn't
work either. I did check a few other BDW machines here and
those do have eDP HPD connected, one of them even is a
different Chromebook (Samus).

To account for these funky machines let's skip the HPD check when
it looks like the eDP port is the only one using that specific AUX
channel. In case of multiple ports sharing the same AUX CH (eg. on
Asrock B250M-HDV) we still do the check and thus should correctly
ignore the eDP port in favor of the other DP port (usually a DP->VGA
converter).

v2: Don't oops during list iteration

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9264
Fixes: cfe5bdfb27fa ("drm/i915: Check HPD live state during eDP probe")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230908052527.685-1-ville.syrjala@linux.intel.com
Reviewed-by: Luca Coelho <luciano.coelho@intel.com>
(cherry picked from commit 70052100fabec5d8c1b09c9959817a2f4517e6b5)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/intel_bios.c |   21 +++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_bios.h |    1 +
 drivers/gpu/drm/i915/display/intel_dp.c   |    7 ++++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -3659,6 +3659,27 @@ enum aux_ch intel_bios_dp_aux_ch(const s
 	return map_aux_ch(devdata->i915, devdata->child.aux_channel);
 }
 
+bool intel_bios_dp_has_shared_aux_ch(const struct intel_bios_encoder_data *devdata)
+{
+	struct drm_i915_private *i915;
+	u8 aux_channel;
+	int count = 0;
+
+	if (!devdata || !devdata->child.aux_channel)
+		return false;
+
+	i915 = devdata->i915;
+	aux_channel = devdata->child.aux_channel;
+
+	list_for_each_entry(devdata, &i915->display.vbt.display_devices, node) {
+		if (intel_bios_encoder_supports_dp(devdata) &&
+		    aux_channel == devdata->child.aux_channel)
+			count++;
+	}
+
+	return count > 1;
+}
+
 int intel_bios_dp_boost_level(const struct intel_bios_encoder_data *devdata)
 {
 	if (!devdata || devdata->i915->display.vbt.version < 196 || !devdata->child.iboost)
--- a/drivers/gpu/drm/i915/display/intel_bios.h
+++ b/drivers/gpu/drm/i915/display/intel_bios.h
@@ -271,6 +271,7 @@ enum aux_ch intel_bios_dp_aux_ch(const s
 int intel_bios_dp_boost_level(const struct intel_bios_encoder_data *devdata);
 int intel_bios_dp_max_lane_count(const struct intel_bios_encoder_data *devdata);
 int intel_bios_dp_max_link_rate(const struct intel_bios_encoder_data *devdata);
+bool intel_bios_dp_has_shared_aux_ch(const struct intel_bios_encoder_data *devdata);
 int intel_bios_hdmi_boost_level(const struct intel_bios_encoder_data *devdata);
 int intel_bios_hdmi_ddc_pin(const struct intel_bios_encoder_data *devdata);
 int intel_bios_hdmi_level_shift(const struct intel_bios_encoder_data *devdata);
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5503,8 +5503,13 @@ static bool intel_edp_init_connector(str
 	/*
 	 * VBT and straps are liars. Also check HPD as that seems
 	 * to be the most reliable piece of information available.
+	 *
+	 * ... expect on devices that forgot to hook HPD up for eDP
+	 * (eg. Acer Chromebook C710), so we'll check it only if multiple
+	 * ports are attempting to use the same AUX CH, according to VBT.
 	 */
-	if (!intel_digital_port_connected(encoder)) {
+	if (intel_bios_dp_has_shared_aux_ch(encoder->devdata) &&
+	    !intel_digital_port_connected(encoder)) {
 		/*
 		 * If this fails, presume the DPCD answer came
 		 * from some other port using the same AUX CH.


