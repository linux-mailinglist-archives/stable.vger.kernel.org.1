Return-Path: <stable+bounces-16184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7881B83F192
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD841F22979
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868D3200BD;
	Sat, 27 Jan 2024 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FNPnORRC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476FC1F95B
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397055; cv=none; b=mJlVtGPCL4EGyXhYd+yT1JLVPcf09Yqv4ZXFYMigA9YprTEz0x00OaIe+v3HWCHyiNbHxFOshNLIGTj9Tx/EjcWq/YFejv1AlCVmGZ8SBIUUTAcUSDnxRhjA9+Ps38Y5TlyVnYh8QQhe/FmzstR/PGl+WGErmdd2KVybKbSuOxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397055; c=relaxed/simple;
	bh=JpsCQweJAgRFPwdxXgCrVjfVGQkCCq4eYQ3ZfzYaF5g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TtWSQCoWOwJ+z62mtRXl1LJaLPrH94Fc4RtFWsj3C09o2y2k4uPwNGkVozM8mVjRG4Vp3lAPDTegUP4l40rdDn/zZYtKiW1oTkPV/f6h3X0K5WdOIsz3AHc9ohI22pm9KUJN2UQFTvrfyid4d26pq9w2Tx2Uul1m8+Lnu/HlAdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FNPnORRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E957C43390;
	Sat, 27 Jan 2024 23:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397055;
	bh=JpsCQweJAgRFPwdxXgCrVjfVGQkCCq4eYQ3ZfzYaF5g=;
	h=Subject:To:Cc:From:Date:From;
	b=FNPnORRCH5aJWHzt91jy+KLxfNPIFm9ZcGlYOjbsbpeUQ+f+xBsShlC+lLMGddEDY
	 Yob1HIy/aDgP9EqBr2uNtvCu/5bEQ6RKcN+hrz9Q2LFYibkI5qxzSIBwmBgocr6Acf
	 kWYl6061MVMURYfZbVvShrx9l37iJMBsYGEcCl1w=
Subject: FAILED: patch "[PATCH] drm/amd/display: force toggle rate wa for first link training" failed to apply to 6.1-stable tree
To: zhongwei.zhang@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,michael.strauss@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:10:54 -0800
Message-ID: <2024012754-uneaten-backwater-0004@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5a9a2cc8ae1889c4002850b00fd4fd9691dfac4e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012754-uneaten-backwater-0004@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

5a9a2cc8ae18 ("drm/amd/display: force toggle rate wa for first link training for a retimer")
7727e7b60f82 ("drm/amd/display: Improve robustness of FIXED_VS link training at DP1 rates")
80c6d6804f31 ("drm/amd/display: disable SubVP + DRR to prevent underflow")
54618888d1ea ("drm/amd/display: break down dc_link.c")
71d7e8904d54 ("drm/amd/display: Add HDMI manufacturer OUI and device id read")
65a4cfb45e0e ("drm/amdgpu/display: remove duplicate include header in files")
e322843e5e33 ("drm/amd/display: fix linux dp link lost handled only one time")
0c2bfcc338eb ("drm/amd/display: Add Function declaration in dc_link")
6ca7415f11af ("drm/amd/display: merge dc_link_dp into dc_link")
de3fb390175b ("drm/amd/display: move dp cts functions from dc_link_dp to link_dp_cts")
c5a31f178e35 ("drm/amd/display: move dp irq handler functions from dc_link_dp to link_dp_irq_handler")
0078c924e733 ("drm/amd/display: move eDP panel control logic to link_edp_panel_control")
bc33f5e5f05b ("drm/amd/display: create accessories, hwss and protocols sub folders in link")
2daeb74b7d66 ("drm/amdgpu/display/mst: update mst_mgr relevant variable when long HPD")
028c4ccfb812 ("drm/amd/display: force connector state when bpc changes during compliance")
603a521ec279 ("drm/amd/display: remove duplicate included header files")
bd3149014dff ("drm/amd/display: Decrease messaging about DP alt mode state to debug")
d5a43956b73b ("drm/amd/display: move dp capability related logic to link_dp_capability")
94dfeaa46925 ("drm/amd/display: move dp phy related logic to link_dp_phy")
630168a97314 ("drm/amd/display: move dp link training logic to link_dp_training")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5a9a2cc8ae1889c4002850b00fd4fd9691dfac4e Mon Sep 17 00:00:00 2001
From: Zhongwei <zhongwei.zhang@amd.com>
Date: Wed, 8 Nov 2023 16:34:36 +0800
Subject: [PATCH] drm/amd/display: force toggle rate wa for first link training
 for a retimer

[WHY]
Handover from DMUB to driver does not perform link rate toggle.
It might cause link training failure for boot up.

[HOW]
Force toggle rate wa for first link train.
link->vendor_specific_lttpr_link_rate_wa should be zero then.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Zhongwei <zhongwei.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
index fd8f6f198146..68096d12f52f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
@@ -115,7 +115,7 @@ static enum link_training_result perform_fixed_vs_pe_nontransparent_training_seq
 		lt_settings->cr_pattern_time = 16000;
 
 	/* Fixed VS/PE specific: Toggle link rate */
-	apply_toggle_rate_wa = (link->vendor_specific_lttpr_link_rate_wa == target_rate);
+	apply_toggle_rate_wa = ((link->vendor_specific_lttpr_link_rate_wa == target_rate) || (link->vendor_specific_lttpr_link_rate_wa == 0));
 	target_rate = get_dpcd_link_rate(&lt_settings->link_settings);
 	toggle_rate = (target_rate == 0x6) ? 0xA : 0x6;
 
@@ -271,7 +271,7 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
 	/* Vendor specific: Toggle link rate */
 	toggle_rate = (rate == 0x6) ? 0xA : 0x6;
 
-	if (link->vendor_specific_lttpr_link_rate_wa == rate) {
+	if (link->vendor_specific_lttpr_link_rate_wa == rate || link->vendor_specific_lttpr_link_rate_wa == 0) {
 		core_link_write_dpcd(
 				link,
 				DP_LINK_BW_SET,
@@ -617,7 +617,7 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	/* Vendor specific: Toggle link rate */
 	toggle_rate = (rate == 0x6) ? 0xA : 0x6;
 
-	if (link->vendor_specific_lttpr_link_rate_wa == rate) {
+	if (link->vendor_specific_lttpr_link_rate_wa == rate || link->vendor_specific_lttpr_link_rate_wa == 0) {
 		core_link_write_dpcd(
 				link,
 				DP_LINK_BW_SET,


