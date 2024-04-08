Return-Path: <stable+bounces-36361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315AA89BCF7
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 12:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FBD5B21679
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 10:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B594853385;
	Mon,  8 Apr 2024 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k2T2BaXp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7798C52F82
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571896; cv=none; b=nyiHF3a4RWDXztuQcjwJ9QQUUs12m8gKMryscleRJzO2hIajHg7NhdttWDwcuAFbBA5f2LfxtnFsKns7szd5P7NlxsvX5O2swECo80yERVx2m7rR+poILEaN7KMg1BkBIFQagh2OZejYEYvuW+Vy8V/4pez/UNkBhZPS7GNPPdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571896; c=relaxed/simple;
	bh=EzqHdwhW20L+kwMxukaK37B09vPTMxwtZy7HBCGHkRQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gEpJHE8PEN9K/zgvONDJqNdF7UwzLVqeT2INgxuuPOyxpUWFD7QgHTnUCiBX2vEYqqIUajEZzYmO3gMCKUXSLpGVXE54VeZvDAm/ecSCsLv6BCoibY4zcBlMdA9VF5lnqWgnAsE2ar/ghH3sFbUavOqaIr6HDl4Q41G4wra8fB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k2T2BaXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF27C433F1;
	Mon,  8 Apr 2024 10:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712571896;
	bh=EzqHdwhW20L+kwMxukaK37B09vPTMxwtZy7HBCGHkRQ=;
	h=Subject:To:Cc:From:Date:From;
	b=k2T2BaXpXNvfOsVPXqq8HUtT+PUsabwtdv3IfnOMR80KTDnfsMv04n99KSnW7b+ZM
	 jOnYeiMA6QrN01b7plWDcdRfaExLnHNsgclXxfYdChZ4rc+lR7xcDTp5SM3ZApJ1Bz
	 piXX7UO426/GO4rNsGnnMcFzUC4p7KOqNVcrkn4c=
Subject: FAILED: patch "[PATCH] drm/i915/mst: Limit MST+DSC to TGL+" failed to apply to 6.6-stable tree
To: ville.syrjala@linux.intel.com,rodrigo.vivi@intel.com,uma.shankar@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Apr 2024 12:24:52 +0200
Message-ID: <2024040851-nail-pectin-26a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 51bc63392e96ca45d7be98bc43c180b174ffca09
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040851-nail-pectin-26a4@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

51bc63392e96 ("drm/i915/mst: Limit MST+DSC to TGL+")
d19daffc89fe ("drm/i915/dp_mst: Use connector DSC DPCD in intel_dp_mst_mode_valid_ctx()")
8d5284765a43 ("drm/i915/dp: Use consistent name for link bpp and compressed bpp")
3a4b4809c8cc ("drm/i915/dp: Move compressed bpp check with 420 format inside the helper")
a1476c2a9715 ("drm/i915/dp: Consider output_format while computing dsc bpp")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 51bc63392e96ca45d7be98bc43c180b174ffca09 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Tue, 2 Apr 2024 16:51:46 +0300
Subject: [PATCH] drm/i915/mst: Limit MST+DSC to TGL+
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The MST code currently assumes that glk+ already supports MST+DSC,
which is incorrect. We need to check for TGL+ actually. ICL does
support SST+DSC, but supposedly it can't do MST+FEC which will
also rule out MST+DSC.

Note that a straight TGL+ check doesn't work here because DSC
support can get fused out, so we do need to also check 'has_dsc'.

Cc: stable@vger.kernel.org
Fixes: d51f25eb479a ("drm/i915: Add DSC support to MST path")
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240402135148.23011-6-ville.syrjala@linux.intel.com
(cherry picked from commit c9c92f286dbdf872390ef3e74dbe5f0641e46f55)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_display_device.h b/drivers/gpu/drm/i915/display/intel_display_device.h
index fe4268813786..9b1bce2624b9 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.h
+++ b/drivers/gpu/drm/i915/display/intel_display_device.h
@@ -47,6 +47,7 @@ struct drm_printer;
 #define HAS_DPT(i915)			(DISPLAY_VER(i915) >= 13)
 #define HAS_DSB(i915)			(DISPLAY_INFO(i915)->has_dsb)
 #define HAS_DSC(__i915)			(DISPLAY_RUNTIME_INFO(__i915)->has_dsc)
+#define HAS_DSC_MST(__i915)		(DISPLAY_VER(__i915) >= 12 && HAS_DSC(__i915))
 #define HAS_FBC(i915)			(DISPLAY_RUNTIME_INFO(i915)->fbc_mask != 0)
 #define HAS_FPGA_DBG_UNCLAIMED(i915)	(DISPLAY_INFO(i915)->has_fpga_dbg)
 #define HAS_FW_BLC(i915)		(DISPLAY_VER(i915) >= 3)
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 53aec023ce92..b651c990af85 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -1355,7 +1355,7 @@ intel_dp_mst_mode_valid_ctx(struct drm_connector *connector,
 		return 0;
 	}
 
-	if (DISPLAY_VER(dev_priv) >= 10 &&
+	if (HAS_DSC_MST(dev_priv) &&
 	    drm_dp_sink_supports_dsc(intel_connector->dp.dsc_dpcd)) {
 		/*
 		 * TBD pass the connector BPC,


