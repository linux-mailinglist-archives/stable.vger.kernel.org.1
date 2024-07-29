Return-Path: <stable+bounces-62434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D25E93F176
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 11:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396741C212FB
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7F1140378;
	Mon, 29 Jul 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cqYKAoEJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD44713E8B6
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246415; cv=none; b=g42ftj6SqP177oyt1x4ZtCt9f913FMqlef6pU1XwO9PoBN+hip+568PkZmhFbHqcbuDiewKhk1hsAfd25EiQHqy6Aau6RVKExPEnzRu1DenQzw79PlyLnE1ELKgb2IsQrU5rIO2cZnLh8B6bdEhCS20YLiabeEQ1VKfS80dHvg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246415; c=relaxed/simple;
	bh=rDPI807joQx9PJX5f29SG2dl1JRPyrPh36KOTzIod+Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EWCSiRw4fUcE21hQVfd9y61+7/av5FJ3iBEDXq8L7t4XV86FnCy7okipI4EP4RuMte8BSUn7LnGl28aY+bZAGgzMWRs122Gd5vnu5RQpA+QDMHy9RHIsPWeNyWdvbduRBL+epEWXrRqIcI/nTgfRV3CmPmBlk5s7Qk/nrNiqxRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cqYKAoEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D713C32786;
	Mon, 29 Jul 2024 09:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722246415;
	bh=rDPI807joQx9PJX5f29SG2dl1JRPyrPh36KOTzIod+Y=;
	h=Subject:To:Cc:From:Date:From;
	b=cqYKAoEJKTmbeF91rgznb5BP6DYF1r/AZJ+WlWZXZspAoF3gRKHJrzIw0ag8CyX7E
	 c2LWpDOoR1nDKm3UaR2VBO54QGKOt5spDII9c9cD6SxJk9QU7vaI8ACAnyo9FmaPnG
	 WUtz88ACU0DDfQ5bRKZN/KdKAJ3+buS0hpPmSRDo=
Subject: FAILED: patch "[PATCH] drm/i915/display: For MTL+ platforms skip mg dp programming" failed to apply to 5.10-stable tree
To: imre.deak@intel.com,gustavo.sousa@intel.com,mika.kahola@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 11:46:41 +0200
Message-ID: <2024072941-uncross-untrained-affb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x aaf9dc86bd806458f848c39057d59e5aa652a399
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072941-uncross-untrained-affb@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


