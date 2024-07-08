Return-Path: <stable+bounces-58216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C143492A336
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 14:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF2A280E36
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 12:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAAC84E13;
	Mon,  8 Jul 2024 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YjxfxmKj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B0C824B2
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443050; cv=none; b=SUVjtnDV9uxro8PhAIqfdUESHnl+YVti6BZmexN6zJaTVB3Xiy4DkameSGf2/UGd5y9/3kx1JxTHqHTvTFSyXIRu1oFfRdnwtaHgXOPDcBlS+WMr56f3osuWgaKrsEEFzP7j0kUvq4YgiYtUJWR9amD0WKR5XjyddPxltegTVU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443050; c=relaxed/simple;
	bh=ayyAoTGbYF3inDJt7HZaufNE5e6fckWwF4zoamBfz5Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bupCTxRPmDJ8ohdvEvML3Gvu6TIkZmDrlkBegiIuMRrln7oF5kZO+6+mVqaMbjOKaph5CF2xfP1joRCaVa809UcFjdmqnV4Ne7Oe+XjsP/++mTPZGJK3IyZknlHQ/4KcaSS6Dd9sUBvynush/pRIyzGgjSvUx2eMJE7DQeladUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YjxfxmKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994AAC116B1;
	Mon,  8 Jul 2024 12:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720443050;
	bh=ayyAoTGbYF3inDJt7HZaufNE5e6fckWwF4zoamBfz5Y=;
	h=Subject:To:Cc:From:Date:From;
	b=YjxfxmKjU4ro4V5D4lq8bOgcEQHT70Ne0D5mwI4mlUJ1fXcYJbVuUYgOoltuST4tS
	 a6XKdL8hbB43PUoYyM3J347iZqz+aBc9HpC5tk08MZr9rT4YA5ITmRY7jbM6Ymh5Gd
	 oGlOE1ODWnZj/so0WZ54c9CgLBV2CYdR7AtZZCuE=
Subject: FAILED: patch "[PATCH] drm/i915/display: For MTL+ platforms skip mg dp programming" failed to apply to 6.6-stable tree
To: imre.deak@intel.com,gustavo.sousa@intel.com,jani.nikula@intel.com,mika.kahola@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Jul 2024 14:50:40 +0200
Message-ID: <2024070840-gurgle-wikipedia-e4e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f72383371e8c5d1d108532d7e395ff2c277233e5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070840-gurgle-wikipedia-e4e0@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

f72383371e8c ("drm/i915/display: For MTL+ platforms skip mg dp programming")
7fcf755896a3 ("drm/i915/display: use intel_encoder_is/to_* functions")
0a099232d254 ("drm/i915/snps: pass encoder to intel_snps_phy_update_psr_power_state()")
684a37a6ffa9 ("drm/i915/ddi: pass encoder to intel_wait_ddi_buf_active()")
65ea19a698f2 ("drm/i915/hdmi: convert *_port_to_ddc_pin() to *_encoder_to_ddc_pin()")
6a8c66bf0e56 ("drm/i915: Don't explode when the dig port we don't have an AUX CH")
d5c7854b50e6 ("drm/i915/xe2lpd: Move D2D enable/disable")
2e4b90fbe755 ("drm/i915: Filter out glitches on HPD lines during hotplug detection")
31a5b6ed88c7 ("drm/i915/display: Unify VSC SPD preparation")
00076671a648 ("drm/i915/display: Move colorimetry_support from intel_psr to intel_dp")
e11300a1d8e3 ("drm/i915/display: Remove intel_crtc_state->psr_vsc")
561322c3bc14 ("drm/i915/display: Skip state verification with TBT-ALT mode")
7966a93a27cf ("drm/i915: Push audio enable/disable further out")
59be90248b42 ("drm/i915/mtl: C20 state verification")
3257e55d3ea7 ("drm/i915/panelreplay: enable/disable panel replay")
b8cf5b5d266e ("drm/i915/panelreplay: Initializaton and compute config for panel replay")
dd8f2298e34b ("drm/i915/psr: Move psr specific dpcd init into own function")
36f579ffc692 ("drm/i915/dp_mst: Improve BW sharing between MST streams")
e37137380931 ("drm/i915/dp_mst: Force modeset CRTC if DSC toggling requires it")
b2608c6b3212 ("drm/i915/dp_mst: Enable MST DSC decompression for all streams")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f72383371e8c5d1d108532d7e395ff2c277233e5 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Tue, 25 Jun 2024 14:18:40 +0300
Subject: [PATCH] drm/i915/display: For MTL+ platforms skip mg dp programming

For MTL+ platforms we use PICA chips for Type-C support and
hence mg programming is not needed.

Fixes issue with drm warn of TC port not being in legacy mode.

Cc: stable@vger.kernel.org

Signed-off-by: Mika Kahola <mika.kahola@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Gustavo Sousa <gustavo.sousa@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240625111840.597574-1-mika.kahola@intel.com
(cherry picked from commit aaf9dc86bd806458f848c39057d59e5aa652a399)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 3c3fc53376ce..6bff169fa8d4 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -2088,6 +2088,9 @@ icl_program_mg_dp_mode(struct intel_digital_port *dig_port,
 	u32 ln0, ln1, pin_assignment;
 	u8 width;
 
+	if (DISPLAY_VER(dev_priv) >= 14)
+		return;
+
 	if (!intel_encoder_is_tc(&dig_port->base) ||
 	    intel_tc_port_in_tbt_alt_mode(dig_port))
 		return;


