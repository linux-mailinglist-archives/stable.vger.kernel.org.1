Return-Path: <stable+bounces-125935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B60FA6DEE7
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFC03ACB58
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9D126157E;
	Mon, 24 Mar 2025 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yd+dEcoF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AC1261577
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830752; cv=none; b=g43PSEtTwMgBZzGxC4Xo8zextvb+UouuPaL8n8Zx8MsqNTsMWcdO49TAf/MBwzgDus+ro0myhDflv3gHcPNUyRe322VDO9JvwlD2VS3p9t3t9APb1Elikf+VQU7ZkIvNCZbCFTtSAjSHzXPM9vQYd1waNX3D2DMHfZ2oUCc34H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830752; c=relaxed/simple;
	bh=pLYh1t84ZKf3Dwy9tdh35uxzrsCBXx0vPQMvkgiarYA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=g+9CRVH0kwT50IZLjlU6BS4UIZfkLHHoPHhpmoQdma4H0x8hFzeFK6stfoHqVO7MnBGW8bdoSAQlygaS03sGgfizKQEoZ1gY1PL/mbZLtctQB5fjgd6HAhS1Lw7F+fVnwsKIjcvfCB6hj9lmLANvQGuALUEdAAR+AJhjc22l4xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yd+dEcoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18FBC4CEDD;
	Mon, 24 Mar 2025 15:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742830751;
	bh=pLYh1t84ZKf3Dwy9tdh35uxzrsCBXx0vPQMvkgiarYA=;
	h=Subject:To:Cc:From:Date:From;
	b=Yd+dEcoFp7LUidsB2xQ8c5Lybv4qHPLFKNx+oKusC3uCjDBt1fgKiwiAwWMJw/gzb
	 QaEZp00wuiXruOKRT39QLR13fBwNlFB1cmfigD+UkioZHsHzdBXWS9L+myzKbZgpDD
	 ynmYxZ3kJD0Ew94/ialKC265A6MjrdXxyiOzbZMU=
Subject: FAILED: patch "[PATCH] drm/amd/display: Use HW lock mgr for PSR1 when only one eDP" failed to apply to 6.6-stable tree
To: mario.limonciello@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,chiahsuan.chung@amd.com,daniel.wheeler@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Mar 2025 08:37:41 -0700
Message-ID: <2025032441-constrain-eastbound-09d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x acbf16a6ae775b4db86f537448cc466288aa307e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032441-constrain-eastbound-09d8@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From acbf16a6ae775b4db86f537448cc466288aa307e Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Fri, 7 Mar 2025 15:55:20 -0600
Subject: [PATCH] drm/amd/display: Use HW lock mgr for PSR1 when only one eDP

[WHY]
DMUB locking is important to make sure that registers aren't accessed
while in PSR.  Previously it was enabled but caused a deadlock in
situations with multiple eDP panels.

[HOW]
Detect if multiple eDP panels are in use to decide whether to use
lock. Refactor the function so that the first check is for PSR-SU
and then replay is in use to prevent having to look up number
of eDP panels for those configurations.

Fixes: f245b400a223 ("Revert "drm/amd/display: Use HW lock mgr for PSR1"")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3965
Reviewed-by: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ed569e1279a3045d6b974226c814e071fa0193a6)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index bf636b28e3e1..6e2fce329d73 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -69,5 +69,16 @@ bool should_use_dmub_lock(struct dc_link *link)
 	if (link->replay_settings.replay_feature_enabled)
 		return true;
 
+	/* only use HW lock for PSR1 on single eDP */
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_1) {
+		struct dc_link *edp_links[MAX_NUM_EDP];
+		int edp_num;
+
+		dc_get_edp_links(link->dc, edp_links, &edp_num);
+
+		if (edp_num == 1)
+			return true;
+	}
+
 	return false;
 }


