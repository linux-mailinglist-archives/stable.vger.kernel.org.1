Return-Path: <stable+bounces-135023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF91A95E10
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7B93A5054
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68FA1F4CBB;
	Tue, 22 Apr 2025 06:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cST1Dgmq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652DB1F4CA4
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303022; cv=none; b=qfWcRomZdDmRsEauMgAJ9t7KYlDg2TP9aa27Ms7adfvmILmi/1ZJwFYoQVtgP+5FTnMRetcy9+3+ogB+NJyz4ccCe+GdS6htB/kqEZFo5yQVFcm4ACXJ8zVK8apu1hGExVVS5oe7KqH8D40CQA+YODb4fEMK+BAABXq+AcwAu4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303022; c=relaxed/simple;
	bh=bVg5D7XCmSxCYZ5SxOy9CH2Ahp70krYODDibJ1cSbco=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NIHUPzFgqbBTSt6i2zkXJ2Fovqify20mQvgbjr93PAC0d4MdtfOWnXyRIk+ZI5LVT/7WtWSiG8tRF2g4Cy0yPHONWXyytfMR39qz5K7tz57Dn3L1dYGzVOkKEset6jLh8iFajpwaUHNFbTi7g1GE8YnX2bYhRJgYmJ2DthhFWJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cST1Dgmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86490C4CEE9;
	Tue, 22 Apr 2025 06:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745303021;
	bh=bVg5D7XCmSxCYZ5SxOy9CH2Ahp70krYODDibJ1cSbco=;
	h=Subject:To:Cc:From:Date:From;
	b=cST1Dgmq/RB8AJ2fmlTJyCVc8qsGvQ1GGYBCXbD5h+tvJZoZOKl8MLdjfO1kQ/dem
	 h9WzN0LbFy7Nob+KNFxn9OR7wn57RyisS/Ju4NX249q5z1g3Pa8wrUscud16dvRSBQ
	 e9cF5uW4VTiRdp/RxBQplOh/yufq+vOJMb1LRRq4=
Subject: FAILED: patch "[PATCH] drm/i915/xe2hpd: Identify the memory type for SKUs with GDDR" failed to apply to 6.12-stable tree
To: vivek.kasireddy@intel.com,jani.nikula@intel.com,lucas.demarchi@intel.com,matthew.d.roper@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Apr 2025 08:23:39 +0200
Message-ID: <2025042239-underfoot-unlovable-f450@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x bc1feb8174b7e46c1806a6f684d89a47508f3a53
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042239-underfoot-unlovable-f450@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bc1feb8174b7e46c1806a6f684d89a47508f3a53 Mon Sep 17 00:00:00 2001
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
Date: Mon, 24 Mar 2025 10:22:33 -0700
Subject: [PATCH] drm/i915/xe2hpd: Identify the memory type for SKUs with GDDR
 + ECC

Some SKUs of Xe2_HPD platforms (such as BMG) have GDDR memory type
with ECC enabled. We need to identify this scenario and add a new
case in xelpdp_get_dram_info() to handle it. In addition, the
derating value needs to be adjusted accordingly to compensate for
the limited bandwidth.

Bspec: 64602
Cc: Matt Roper <matthew.d.roper@intel.com>
Fixes: 3adcf970dc7e ("drm/xe/bmg: Drop force_probe requirement")
Cc: stable@vger.kernel.org
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Acked-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250324-tip-v2-1-38397de319f8@intel.com
(cherry picked from commit 327e30123cafcb45c0fc5843da0367b90332999d)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_bw.c b/drivers/gpu/drm/i915/display/intel_bw.c
index 048be2872247..98b898a1de8f 100644
--- a/drivers/gpu/drm/i915/display/intel_bw.c
+++ b/drivers/gpu/drm/i915/display/intel_bw.c
@@ -244,6 +244,7 @@ static int icl_get_qgv_points(struct drm_i915_private *dev_priv,
 			qi->deinterleave = 4;
 			break;
 		case INTEL_DRAM_GDDR:
+		case INTEL_DRAM_GDDR_ECC:
 			qi->channel_width = 32;
 			break;
 		default:
@@ -398,6 +399,12 @@ static const struct intel_sa_info xe2_hpd_sa_info = {
 	/* Other values not used by simplified algorithm */
 };
 
+static const struct intel_sa_info xe2_hpd_ecc_sa_info = {
+	.derating = 45,
+	.deprogbwlimit = 53,
+	/* Other values not used by simplified algorithm */
+};
+
 static int icl_get_bw_info(struct drm_i915_private *dev_priv, const struct intel_sa_info *sa)
 {
 	struct intel_qgv_info qi = {};
@@ -740,10 +747,15 @@ static unsigned int icl_qgv_bw(struct drm_i915_private *i915,
 
 void intel_bw_init_hw(struct drm_i915_private *dev_priv)
 {
+	const struct dram_info *dram_info = &dev_priv->dram_info;
+
 	if (!HAS_DISPLAY(dev_priv))
 		return;
 
-	if (DISPLAY_VERx100(dev_priv) >= 1401 && IS_DGFX(dev_priv))
+	if (DISPLAY_VERx100(dev_priv) >= 1401 && IS_DGFX(dev_priv) &&
+		 dram_info->type == INTEL_DRAM_GDDR_ECC)
+		xe2_hpd_get_bw_info(dev_priv, &xe2_hpd_ecc_sa_info);
+	else if (DISPLAY_VERx100(dev_priv) >= 1401 && IS_DGFX(dev_priv))
 		xe2_hpd_get_bw_info(dev_priv, &xe2_hpd_sa_info);
 	else if (DISPLAY_VER(dev_priv) >= 14)
 		tgl_get_bw_info(dev_priv, &mtl_sa_info);
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index ffc346379cc2..54538b6f85df 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -305,6 +305,7 @@ struct drm_i915_private {
 			INTEL_DRAM_DDR5,
 			INTEL_DRAM_LPDDR5,
 			INTEL_DRAM_GDDR,
+			INTEL_DRAM_GDDR_ECC,
 		} type;
 		u8 num_qgv_points;
 		u8 num_psf_gv_points;
diff --git a/drivers/gpu/drm/i915/soc/intel_dram.c b/drivers/gpu/drm/i915/soc/intel_dram.c
index 9e310f4099f4..f60eedb0e92c 100644
--- a/drivers/gpu/drm/i915/soc/intel_dram.c
+++ b/drivers/gpu/drm/i915/soc/intel_dram.c
@@ -687,6 +687,10 @@ static int xelpdp_get_dram_info(struct drm_i915_private *i915)
 		drm_WARN_ON(&i915->drm, !IS_DGFX(i915));
 		dram_info->type = INTEL_DRAM_GDDR;
 		break;
+	case 9:
+		drm_WARN_ON(&i915->drm, !IS_DGFX(i915));
+		dram_info->type = INTEL_DRAM_GDDR_ECC;
+		break;
 	default:
 		MISSING_CASE(val);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 72ef0b6fc425..9f8667ebba85 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -585,6 +585,7 @@ struct xe_device {
 			INTEL_DRAM_DDR5,
 			INTEL_DRAM_LPDDR5,
 			INTEL_DRAM_GDDR,
+			INTEL_DRAM_GDDR_ECC,
 		} type;
 		u8 num_qgv_points;
 		u8 num_psf_gv_points;


