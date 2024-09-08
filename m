Return-Path: <stable+bounces-73908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24302970775
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1501F21808
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7051531F4;
	Sun,  8 Sep 2024 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UnQOZxZu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E278F1DA26
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725799034; cv=none; b=lV7KdJJsQbM4M4JnvsTGi3KQ8Ndpc20EnOAk5pCSSm6fmq+VCG0uyJcTOLqfSC2cxmRw76NptjXmQ+CNfYTQk5cQtK1cjLR7WSlKpYQ/lNRYK3nbCFC2AmoUUCsDm4ENqvAGwH/vmuq7bUKScUiUMyPAD8ojfYAhdFbpfdtuUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725799034; c=relaxed/simple;
	bh=8CZK5Ocl/kMFnYq4kNG5RXWlQqLgly0OZpabarzb3Cw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i9LW2KedSN5j65NBcemf4RN94CcxBMDYTef2OA0Sq9fHFfDqgHNaK0o6YeRnwCpXsZ6KBTWRWZHZqbycIW4vngeovdJT2vshzAPtEdGPMvS/hThgJLHCf/FpqnQjoRsQwiC/lj+U8tCZbOdO1GboLj8uGob7kCoV7T7K46wx84k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UnQOZxZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A315C4CEC3;
	Sun,  8 Sep 2024 12:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725799033;
	bh=8CZK5Ocl/kMFnYq4kNG5RXWlQqLgly0OZpabarzb3Cw=;
	h=Subject:To:Cc:From:Date:From;
	b=UnQOZxZu5Sed/apIMvZtyzUgRl8U+wEycplqojbsKQqw0RmBxmVSKB/vLAjR6kR1y
	 VzP2xcuIkN2DteF+GnDUTQ2Ld8sHPUNIFTxV7LtqrPEt+ihzFpi9wD7makRz9JBglX
	 olqpVVYPFR4z28aT3Hgd5DEB7YvqPfJIEBEytm/c=
Subject: FAILED: patch "[PATCH] drm/amd/display: Determine IPS mode by ASIC and PMFW versions" failed to apply to 6.1-stable tree
To: sunpeng.li@amd.com,alexander.deucher@amd.com,harry.wentland@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 14:37:11 +0200
Message-ID: <2024090809-wrongly-repulsive-5a71@gregkh>
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
git cherry-pick -x 65444581a4aecf0e96b4691bb20fc75c602f5863
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090809-wrongly-repulsive-5a71@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

65444581a4ae ("drm/amd/display: Determine IPS mode by ASIC and PMFW versions")
234e94555800 ("drm/amd/display: Enable copying of bounding box data from VBIOS DMUB")
afca033f10d3 ("drm/amd/display: Add periodic detection for IPS")
05c5ffaac770 ("drm/amd/display: gpuvm handling in DML21")
9ba971b25316 ("drm/amd/display: Re-enable IPS2 for static screen")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
14813934b629 ("drm/amd/display: Allow RCG for Static Screen + LVP for DCN35")
e779f4587f61 ("drm/amd/display: Add handling for DC power mode")
cc263c3a0c9f ("drm/amd/display: remove context->dml2 dependency from DML21 wrapper")
d62d5551dd61 ("drm/amd/display: Backup and restore only on full updates")
2d5bb791e24f ("drm/amd/display: Implement update_planes_and_stream_v3 sequence")
4f5b8d78ca43 ("drm/amd/display: Init DPPCLK from SMU on dcn32")
2728e9c7c842 ("drm/amd/display: add DC changes for DCN351")
d2dea1f14038 ("drm/amd/display: Generalize new minimal transition path")
0701117efd1e ("Revert "drm/amd/display: For FPO and SubVP/DRR configs program vmin/max sel"")
a9b1a4f684b3 ("drm/amd/display: Add more checks for exiting idle in DC")
13b3d6bdbeb4 ("drm/amd/display: add debugfs disallow edp psr")
dcbf438d4834 ("drm/amd/display: Unify optimize_required flags and VRR adjustments")
1630c6ded587 ("drm/amd/display: "Enable IPS by default"")
8457bddc266c ("drm/amd/display: Revert "Rework DC Z10 restore"")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 65444581a4aecf0e96b4691bb20fc75c602f5863 Mon Sep 17 00:00:00 2001
From: Leo Li <sunpeng.li@amd.com>
Date: Tue, 27 Aug 2024 11:29:53 -0400
Subject: [PATCH] drm/amd/display: Determine IPS mode by ASIC and PMFW versions

[Why]

DCN IPS interoperates with other system idle power features, such as
Zstates.

On DCN35, there is a known issue where system Z8 + DCN IPS2 causes a
hard hang. We observe this on systems where the SBIOS allows Z8.

Though there is a SBIOS fix, there's no guarantee that users will get it
any time soon, or even install it. A workaround is needed to prevent
this from rearing its head in the wild.

[How]

For DCN35, check the pmfw version to determine whether the SBIOS has the
fix. If not, set IPS1+RCG as the deepest possible state in all cases
except for s0ix and display off (DPMS). Otherwise, enable all IPS

Signed-off-by: Leo Li <sunpeng.li@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 28d43d0895896f84c038d906d244e0a95eb243ec)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 983a977632ff..e6cea5b9bdb3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1752,6 +1752,30 @@ static struct dml2_soc_bb *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *
 	return bb;
 }
 
+static enum dmub_ips_disable_type dm_get_default_ips_mode(
+	struct amdgpu_device *adev)
+{
+	/*
+	 * On DCN35 systems with Z8 enabled, it's possible for IPS2 + Z8 to
+	 * cause a hard hang. A fix exists for newer PMFW.
+	 *
+	 * As a workaround, for non-fixed PMFW, force IPS1+RCG as the deepest
+	 * IPS state in all cases, except for s0ix and all displays off (DPMS),
+	 * where IPS2 is allowed.
+	 *
+	 * When checking pmfw version, use the major and minor only.
+	 */
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(3, 5, 0) &&
+	    (adev->pm.fw_version & 0x00FFFF00) < 0x005D6300)
+		return DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
+
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 5, 0))
+		return DMUB_IPS_ENABLE;
+
+	/* ASICs older than DCN35 do not have IPSs */
+	return DMUB_IPS_DISABLE_ALL;
+}
+
 static int amdgpu_dm_init(struct amdgpu_device *adev)
 {
 	struct dc_init_data init_data;
@@ -1863,7 +1887,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_debug_mask & DC_DISABLE_IPS)
 		init_data.flags.disable_ips = DMUB_IPS_DISABLE_ALL;
 	else
-		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
+		init_data.flags.disable_ips = dm_get_default_ips_mode(adev);
 
 	init_data.flags.disable_ips_in_vpb = 0;
 


