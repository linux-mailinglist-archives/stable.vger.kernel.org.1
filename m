Return-Path: <stable+bounces-66725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C4694F0E3
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8701F20FC7
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4D8183CDD;
	Mon, 12 Aug 2024 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WnHISkUP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD947183CD7
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474541; cv=none; b=mXVuCAo1cov+FeDsCHvOdwsAXqHU/O0+cUWrw80Q2BI0L6O3KfK6lows1ZJO3LxfPYaNRjY6DL6a8zfGkJhft+eLQ5DCA9ixaN8TrnjuXCvFBvCdLPx8O7RpD+GTxynNU7IvpXfEN7U3GMCJGu9h45D949Rq79ghS6wZ35Xbgqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474541; c=relaxed/simple;
	bh=1sOhybVzX5+9j5n8NDN32n8sz6WITFi3ePzvvkPRpHQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DG5kgknLaZueXwJzTvTqe0z0WkJJpPfOgspafn9YRYw+jVVvRxcXbgC2kf2MjlWBYvEYk64bWZSPiS1KEBchDz0n2Ub6qs6LwiiSujFnSPWckJq8EVu0TXOI3wYL/eOxrjtbWtT7ZwDajy3WKBFjORoRkmlD1vYy1YN/3m6rIiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WnHISkUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8E5C32782;
	Mon, 12 Aug 2024 14:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474541;
	bh=1sOhybVzX5+9j5n8NDN32n8sz6WITFi3ePzvvkPRpHQ=;
	h=Subject:To:Cc:From:Date:From;
	b=WnHISkUPQ91Fjo4PZff+9iCLmZHuG+3JM8Vuj7WieKcoYOlP2K2AtdJ+8F7zz/HU7
	 lUnXZvGgMDxpzHMgIzoAQQzHnLLyBeXGV4X0rO9w5GhZFZOVIJCWaN6uV2/VwY3Yl+
	 yhwbGR7lSAtP74snLVwlvYE9OODOZG8mko/NgQsk=
Subject: FAILED: patch "[PATCH] drm/amd/display: Defer handling mst up request in resume" failed to apply to 5.4-stable tree
To: wayne.lin@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,hersenxs.wu@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:53:46 +0200
Message-ID: <2024081245-trident-diabolic-2e72@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 202dc359addab29451d3d18243c3d957da5392c8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081245-trident-diabolic-2e72@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

202dc359adda ("drm/amd/display: Defer handling mst up request in resume")
73c57a0aa7f6 ("drm/amd/display: Adjust the MST resume flow")
1e5d4d8eb8c0 ("drm/amd/display: Ext displays with dock can't recognized after resume")
028c4ccfb812 ("drm/amd/display: force connector state when bpc changes during compliance")
d5a43956b73b ("drm/amd/display: move dp capability related logic to link_dp_capability")
94dfeaa46925 ("drm/amd/display: move dp phy related logic to link_dp_phy")
630168a97314 ("drm/amd/display: move dp link training logic to link_dp_training")
d144b40a4833 ("drm/amd/display: move dc_link_dpia logic to link_dp_dpia")
a28d0bac0956 ("drm/amd/display: move dpcd logic from dc_link_dpcd to link_dpcd")
a98cdd8c4856 ("drm/amd/display: refactor ddc logic from dc_link_ddc to link_ddc")
4370f72e3845 ("drm/amd/display: refactor hpd logic from dc_link to link_hpd")
0e8cf83a2b47 ("drm/amd/display: allow hpo and dio encoder switching during dp retrain test")
7462475e3a06 ("drm/amd/display: move dccg programming from link hwss hpo dp to hwss")
e85d59885409 ("drm/amd/display: use encoder type independent hwss instead of accessing enc directly")
ebf13b72020a ("drm/amd/display: Revert Scaler HCBlank issue workaround")
639f6ad6df7f ("drm/amd/display: Revert Reduce delay when sink device not able to ACK 00340h write")
e3aa827e2ab3 ("drm/amd/display: Avoid setting pixel rate divider to N/A")
180f33d27a55 ("drm/amd/display: Adjust DP 8b10b LT exit behavior")
b7ada7ee61d3 ("drm/amd/display: Populate DP2.0 output type for DML pipe")
ea192af507d9 ("drm/amd/display: Only update link settings after successful MST link train")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 202dc359addab29451d3d18243c3d957da5392c8 Mon Sep 17 00:00:00 2001
From: Wayne Lin <wayne.lin@amd.com>
Date: Mon, 15 Apr 2024 14:04:00 +0800
Subject: [PATCH] drm/amd/display: Defer handling mst up request in resume

[Why]
Like commit ec5fa9fcdeca ("drm/amd/display: Adjust the MST resume flow"), we
want to avoid handling mst topology changes before restoring the old state.
If we enable DP_UP_REQ_EN before calling drm_atomic_helper_resume(), have
changce to handle CSN event first and fire hotplug event before restoring the
cached state.

[How]
Disable mst branch sending up request event before we restoring the cached state.
DP_UP_REQ_EN will be set later when we call drm_dp_mst_topology_mgr_resume().

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c863f400024b..ecf5752ef35f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2429,7 +2429,6 @@ static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
 
 	ret = drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
 				 DP_MST_EN |
-				 DP_UP_REQ_EN |
 				 DP_UPSTREAM_IS_SRC);
 	if (ret < 0) {
 		drm_dbg_kms(mgr->dev, "mst write failed - undocked during suspend?\n");


