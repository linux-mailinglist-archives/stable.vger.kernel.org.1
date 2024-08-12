Return-Path: <stable+bounces-66742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1AD94F150
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A1F1F22E81
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F41917D8A3;
	Mon, 12 Aug 2024 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vr2RzAf4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9AE1E877
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475305; cv=none; b=c6wtWAB4qnPFuUr68m1ujOmGfPRo5cAJGbO1JPJ2TL5D3wV88iWl8oK/qWWjKEv1a936nR3hqmHbsmwI7Qm/M8mzB2yTPlzzAonXA+MZgZ9YDonaQ0s27Eu/g26kjbtU1O1SgRmcH2kwQhPDCW1Eh3qHT9rUlieq//TM2K4jp/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475305; c=relaxed/simple;
	bh=yIRIp8tdOPzM1NX1tfDFSSRFUgKrEMIZL29DqH+K7dw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BavzeW3Gb6R301yj/rYhtKnJ3pxvKtxpxMYnwzwV99V8VcCldhwbWJ4NUCr0Bny6t5C3Fj84jVzn41dtIhdh+WEdsYPCjmfAxBOf0PrnA97KCEup3WpQ3rb4A+t05HLRMOv/EUOdOH9MiFgyiEzHZmtBlI4tS5/1v89YqIzL9Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vr2RzAf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31ED0C32782;
	Mon, 12 Aug 2024 15:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723475304;
	bh=yIRIp8tdOPzM1NX1tfDFSSRFUgKrEMIZL29DqH+K7dw=;
	h=Subject:To:Cc:From:Date:From;
	b=vr2RzAf4JhuYPbYGlwHmSvJigzz0OILaAPWjS4iFX03oad/YaoQtPoUK/8HcI9fqv
	 SNPFgJmVdHS0ZuTybq1biTWJoLp/UHlJOkKo6FsqAFX6Ug1e1Er3veVT93Lca0Sade
	 UZ9PFBJUJfDHW8qgJLZYh1kMIz9iSNc2HuK3S3HE=
Subject: FAILED: patch "[PATCH] drm/amd/display: Solve mst monitors blank out problem after" failed to apply to 6.1-stable tree
To: Wayne.Lin@amd.com,alexander.deucher@amd.com,jerry.zuo@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 17:08:14 +0200
Message-ID: <2024081213-sweep-hungry-2d10@gregkh>
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
git cherry-pick -x e33697141bac18906345ea46533a240f1ad3cd21
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081213-sweep-hungry-2d10@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

e33697141bac ("drm/amd/display: Solve mst monitors blank out problem after resume")
1ff6631baeb1 ("drm/amd/display: Prevent IPX From Link Detect and Set Mode")
f63f86b5affc ("drm/amd/display: Separate setting and programming of cursor")
e779f4587f61 ("drm/amd/display: Add handling for DC power mode")
cc263c3a0c9f ("drm/amd/display: remove context->dml2 dependency from DML21 wrapper")
d62d5551dd61 ("drm/amd/display: Backup and restore only on full updates")
2d5bb791e24f ("drm/amd/display: Implement update_planes_and_stream_v3 sequence")
27f03bc680ef ("drm/amd/display: Guard cursor idle reallow by DC debug option")
4f5b8d78ca43 ("drm/amd/display: Init DPPCLK from SMU on dcn32")
2728e9c7c842 ("drm/amd/display: add DC changes for DCN351")
d2dea1f14038 ("drm/amd/display: Generalize new minimal transition path")
0701117efd1e ("Revert "drm/amd/display: For FPO and SubVP/DRR configs program vmin/max sel"")
a9b1a4f684b3 ("drm/amd/display: Add more checks for exiting idle in DC")
dcbf438d4834 ("drm/amd/display: Unify optimize_required flags and VRR adjustments")
8457bddc266c ("drm/amd/display: Revert "Rework DC Z10 restore"")
2a8e918f48bd ("drm/amd/display: add power_state and pme_pending flag")
e6f82bd44b40 ("drm/amd/display: Rework DC Z10 restore")
012fe0674af0 ("drm/amd/display: Add logging resource checks")
a465536ebff8 ("drm/amd/display: revert "Optimize VRR updates to only necessary ones"")
ca1ecae145b2 ("drm/amd/display: Add null pointer guards where needed")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e33697141bac18906345ea46533a240f1ad3cd21 Mon Sep 17 00:00:00 2001
From: Wayne Lin <Wayne.Lin@amd.com>
Date: Thu, 23 May 2024 12:18:07 +0800
Subject: [PATCH] drm/amd/display: Solve mst monitors blank out problem after
 resume

[Why]
In dm resume, we firstly restore dc state and do the mst resume for topology
probing thereafter. If we change dpcd DP_MSTM_CTRL value after LT in mst reume,
it will cause light up problem on the hub.

[How]
Revert commit 202dc359adda ("drm/amd/display: Defer handling mst up request in resume").
And adjust the reason to trigger dc_link_detect by DETECT_REASON_RESUMEFROMS3S4.

Cc: stable@vger.kernel.org
Fixes: 202dc359adda ("drm/amd/display: Defer handling mst up request in resume")
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Reviewed-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 98cf523a629e..29af22ddccc9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2583,6 +2583,7 @@ static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
 
 	ret = drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
 				 DP_MST_EN |
+				 DP_UP_REQ_EN |
 				 DP_UPSTREAM_IS_SRC);
 	if (ret < 0) {
 		drm_dbg_kms(mgr->dev, "mst write failed - undocked during suspend?\n");
@@ -3186,7 +3187,7 @@ static int dm_resume(void *handle)
 		} else {
 			mutex_lock(&dm->dc_lock);
 			dc_exit_ips_for_hw_access(dm->dc);
-			dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
+			dc_link_detect(aconnector->dc_link, DETECT_REASON_RESUMEFROMS3S4);
 			mutex_unlock(&dm->dc_lock);
 		}
 


