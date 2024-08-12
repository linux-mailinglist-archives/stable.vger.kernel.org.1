Return-Path: <stable+bounces-66723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A296294F0DE
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50AB1C21F71
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4133217F4FE;
	Mon, 12 Aug 2024 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BbSje6lS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D7317BB03
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474535; cv=none; b=Lj31kIxNYtV191PUZWigzfQEY5NcW3MqPzDBZZRSSVGMpQbi6Xw52cd7skwK27qSmfUlWaG/vkh8Akr61U+8XepgHJd/UGie+d+3j5vLwE9bDliTSe3MYaXX29CPZqYzgQ61pCRmHnzKy30hOLK9mHqg0kg/LgflnqVZ1YRREFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474535; c=relaxed/simple;
	bh=5NXzOJ3DZ3Ct3uyP+NXcokTlLiYhtcM6VQ7HTWa1PGI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nUni2bobsU9yUWVvsvl465x6Nak3QTWuohc0YWE/C0b9X41v5rRgW22y+p4q7sSl0hkFnYUtlMqrnTg1G9dXdDl26FQuHjSiqdXQ+z3YC4SvQysnxEckygbsFnTutzmKXx0/FLH3Gi/0mf97cywWyU5LllQ6hnCy2msK/2FOs80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BbSje6lS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15605C32782;
	Mon, 12 Aug 2024 14:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474534;
	bh=5NXzOJ3DZ3Ct3uyP+NXcokTlLiYhtcM6VQ7HTWa1PGI=;
	h=Subject:To:Cc:From:Date:From;
	b=BbSje6lSGVjuEnU/dn5kA1HGZjmFAzu6Np0z9DRCkffwsZRg0470ebfIkEqDsQYb7
	 i0rWFHYg0e8z83vQdm0IhyK5qR5Jk3XVQiPKTgL4BNDaG4K+GvxXH4o8b3ZJoC2JZ8
	 2ExX435GXjko4ChLj7lXaC+Aynl5a5gNiQTQJ42A=
Subject: FAILED: patch "[PATCH] drm/amd/display: Defer handling mst up request in resume" failed to apply to 5.15-stable tree
To: wayne.lin@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,hersenxs.wu@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:53:44 +0200
Message-ID: <2024081244-modular-designer-cdb0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 202dc359addab29451d3d18243c3d957da5392c8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081244-modular-designer-cdb0@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


