Return-Path: <stable+bounces-62436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2BD93F17A
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 11:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5CB1C21540
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708E113C69A;
	Mon, 29 Jul 2024 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KBjjSxl+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310917581F
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246427; cv=none; b=Ru+oYpsKSZdUnnygJb62kt6X3rMa+Db5x/EPaGEOuy+D8ht9397RvKy/5Edq7XYpkL4YEOP20vqOaRtXmBoKbje0ru0HewPxoj5gX+suaw//Vsc8VtxlilJ+0Isoq+rZyFUtoHTtJBtyCCtJ6fzaEdAV47TgmrrIoJ/5HXL+mx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246427; c=relaxed/simple;
	bh=v8BDPaJP8pKDf2aK3nd8Rv47MG2qX5kNR6DDE0Lpy2I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sNfj9A6tBSS3m5zf/RZrCpMy569ixq+Kr1bwos9NNaJyUlmSVLRGc4qgXPBDX3Ee0PRKvm/svbopcPbLqId7F3HxHahwfLpbvnxVg8sE8RkI+fMittHk1lVgC20PGLprazlvcBX9POcBx55cOPT/SFfY5zcudUmG/IBz/1N0XyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KBjjSxl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35613C32786;
	Mon, 29 Jul 2024 09:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722246426;
	bh=v8BDPaJP8pKDf2aK3nd8Rv47MG2qX5kNR6DDE0Lpy2I=;
	h=Subject:To:Cc:From:Date:From;
	b=KBjjSxl+zbRGNhZ/lB4tF9+n2dnOSGFYtqsXQyMOFPTCtVmq87o4xziKmFxwMZmhK
	 mNaEwXKjuRBc2Mk/IbeOUfnTL5wEwob9ZIwWK5jFXlsn8tuSmZ1Gt7T9JTsuQXMiGO
	 lSlwDczBrsOP1Wj3XLv9cLaT9wmYHyXTSI4BAnnk=
Subject: FAILED: patch "[PATCH] drm/i915/display: For MTL+ platforms skip mg dp programming" failed to apply to 4.19-stable tree
To: imre.deak@intel.com,gustavo.sousa@intel.com,mika.kahola@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 11:46:42 +0200
Message-ID: <2024072942-sedan-dingo-ba07@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x aaf9dc86bd806458f848c39057d59e5aa652a399
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072942-sedan-dingo-ba07@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

aaf9dc86bd80 ("drm/i915/display: For MTL+ platforms skip mg dp programming")
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

From aaf9dc86bd806458f848c39057d59e5aa652a399 Mon Sep 17 00:00:00 2001
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

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index bb13a3ca8c7c..6672fc162c4f 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -2096,6 +2096,9 @@ icl_program_mg_dp_mode(struct intel_digital_port *dig_port,
 	u32 ln0, ln1, pin_assignment;
 	u8 width;
 
+	if (DISPLAY_VER(dev_priv) >= 14)
+		return;
+
 	if (!intel_encoder_is_tc(&dig_port->base) ||
 	    intel_tc_port_in_tbt_alt_mode(dig_port))
 		return;


