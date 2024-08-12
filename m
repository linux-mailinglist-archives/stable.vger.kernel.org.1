Return-Path: <stable+bounces-66740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A6594F14E
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D962825A4
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B033F17F4FE;
	Mon, 12 Aug 2024 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="In7Aohqn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEDD178370
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475296; cv=none; b=PrBtpeICY38F2PZ+YUVIscJd8wNdzOuo31PD6ebVu2SKM2QtbDi4ac5FCDXrEQTuJgxfeXCs/SNSb0ejlChUwL0VVjmmh/8oGoq8jx1U/x/xVgWI5rcM7zcbLMJRrUxjadouCp5g+/lBfmOh4nLL53FZva6826NoVjqBWCjgwTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475296; c=relaxed/simple;
	bh=hBodh4kdItezPIjwh9Q3SYriYAlFegyyLNRfwLGDjpg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UY3AhICG6nkdLAz0WgLxPhF1+4wFNbGYz4G6AABJqDrHeR0Dtr6vvJ0LbPnNX1ASnRvEySbLWFCJAqXK/5n9Fe81ms5MdN9A9X+/3FQpM8h16RRR3V1ArJ55wFNfP30q6ojshyv7weawipKg3X0h6gGqREUQQ3v2lMv6hXmuj8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=In7Aohqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9842DC32782;
	Mon, 12 Aug 2024 15:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723475296;
	bh=hBodh4kdItezPIjwh9Q3SYriYAlFegyyLNRfwLGDjpg=;
	h=Subject:To:Cc:From:Date:From;
	b=In7AohqnXh7smAw+cHxZhumf8OgCGMUaylsjGTaLXvHD6WDZZuRXeZTRaGYYdcbqG
	 dKNmMNHwP7H9LMiYghvLkSlXuTb7lB3aCgshYZdhNwtGTDEeZVceHQxRwRZED1MvbZ
	 D1AFRUAs9EA2jm++W8k0KGhmdOunbFJgwbNizixA=
Subject: FAILED: patch "[PATCH] drm/amd/display: Solve mst monitors blank out problem after" failed to apply to 6.10-stable tree
To: Wayne.Lin@amd.com,alexander.deucher@amd.com,jerry.zuo@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 17:08:12 +0200
Message-ID: <2024081212-vitally-baked-7f93@gregkh>
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
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081212-vitally-baked-7f93@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

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
 


