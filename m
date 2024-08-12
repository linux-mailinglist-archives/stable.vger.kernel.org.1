Return-Path: <stable+bounces-66576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC0D94F037
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110801F25F8F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F547184547;
	Mon, 12 Aug 2024 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="inaz8BlW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDCB184541
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474028; cv=none; b=U8NAWSe5IcJdF0w6WjEQ92D2s35u5DOlpUlR7ls/GWQEJ9E5oaZeh3t7KiofGHNHcImLCM32UsLr/p6Moi8NjE3GM7U39lAP2NNZAt6q4cjjd89c0sBb3hcHAbXBdHwp7RSVXhJM76dRDpONvczHWeSQkAlSc/Ttz/FjefTV9OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474028; c=relaxed/simple;
	bh=h9CbbmPWY2FSD9zxh9iG2uzBBSClxuvZ2SasieHR9M4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ksToyAPmknO/eShVrabMOENlmLUwNV1RKB5cy/c9pexLFdOoxcyfrSqy4mc6SPfWN2JVl1C7SkhBbNRjfHWcDecJPoZ4eE/KoQpdnf5B/RGVfZUqWjjTFfUwsY31u95FpNLHKE6cWqBQHKDYi+9ALmfITYiFYgNARTp1CJare8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=inaz8BlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77612C4AF0F;
	Mon, 12 Aug 2024 14:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474027;
	bh=h9CbbmPWY2FSD9zxh9iG2uzBBSClxuvZ2SasieHR9M4=;
	h=Subject:To:Cc:From:Date:From;
	b=inaz8BlWtIvm0L+y2WkqjQEt65VkTk86pN/GorNQ1hNeX+F3rKbMX0ESxPew6N/xs
	 brHuV7lzcrcCEoEFTEHosDvpf7QRhLU+lSCRjJ6wq8SUbur/H9fl4Hb3N+BvWsQZE2
	 78Dcpk7Qxft0Wt7pAjloXEbV2cpXlhEJgzYe6IPI=
Subject: FAILED: patch "[PATCH] drm/amd/display: Solve mst monitors blank out problem after" failed to apply to 6.10-stable tree
To: Wayne.Lin@amd.com,alexander.deucher@amd.com,jerry.zuo@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:46:58 +0200
Message-ID: <2024081258-femur-antonym-2836@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x e33697141bac18906345ea46533a240f1ad3cd21
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081258-femur-antonym-2836@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

e33697141bac ("drm/amd/display: Solve mst monitors blank out problem after resume")
1ff6631baeb1 ("drm/amd/display: Prevent IPX From Link Detect and Set Mode")
f63f86b5affc ("drm/amd/display: Separate setting and programming of cursor")

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
 


