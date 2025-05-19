Return-Path: <stable+bounces-144781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A88DCABBD37
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32041177D68
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2D113D52F;
	Mon, 19 May 2025 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Zdp8Tjp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C713269B03
	for <stable@vger.kernel.org>; Mon, 19 May 2025 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747656166; cv=none; b=Y2ak4gCEEN6OwkmQ7jXNS0A7LGriuizhACv9M25Q/ZdPyzIw5KUpYLR0jx8ScqC9wxh0rIeANG14GaLWE+YRc7fyfSRd8IO63DWugpuLCkkAS9yCttVlegAPtXEezdIe68xCvT/S2S2e0Z+rE2pBByqbcM9mRVr0pOM+gafsjVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747656166; c=relaxed/simple;
	bh=TrguJ/r22z5QM2ckSIjJG9MyLakYtxn9GLF2X7qY5ac=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gMs7ShyNFH+GMpjvJfGOrHSD92WErgU/tXQsvhQB+C4aUNLyLnvXPZ/JzepC1ySHiF+YkZP5jikhD22wix1X5DBiDmoyQSj3zQasPCvJKOe8hNGEdty5/N2W0ulG0UOGM7HJXlBYtE0QT3LZaCnBCPQzTKD19QW/2yxsCOUgdB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Zdp8Tjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A42DC4CEE9;
	Mon, 19 May 2025 12:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747656166;
	bh=TrguJ/r22z5QM2ckSIjJG9MyLakYtxn9GLF2X7qY5ac=;
	h=Subject:To:Cc:From:Date:From;
	b=2Zdp8TjplZ6VShGMm3lqXROjelovd+v9IcVkKw+N59CsTV9koaUhCZIz49P/i6qWw
	 Ulxq5mapVE/C1Fvg67xiIdPj5cOMycoACgi5hCE6R4nW0Fag5bQY7H2UXMVR3/UJR8
	 CBIIWOvYhpQE6/oD1Eiu7Kx5iQh9OIqLiG2zdglk=
Subject: FAILED: patch "[PATCH] drm/amd/display: Avoid flooding unnecessary info messages" failed to apply to 5.15-stable tree
To: Wayne.Lin@amd.com,alexander.deucher@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 14:02:42 +0200
Message-ID: <2025051942-empty-unlivable-7496@gregkh>
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
git cherry-pick -x d33724ffb743d3d2698bd969e29253ae0cff9739
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051942-empty-unlivable-7496@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d33724ffb743d3d2698bd969e29253ae0cff9739 Mon Sep 17 00:00:00 2001
From: Wayne Lin <Wayne.Lin@amd.com>
Date: Tue, 13 May 2025 11:20:24 +0800
Subject: [PATCH] drm/amd/display: Avoid flooding unnecessary info messages

It's expected that we'll encounter temporary exceptions
during aux transactions. Adjust logging from drm_info to
drm_dbg_dp to prevent flooding with unnecessary log messages.

Fixes: 3637e457eb00 ("drm/amd/display: Fix wrong handling for AUX_DEFER case")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://lore.kernel.org/r/20250513032026.838036-1-Wayne.Lin@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 9a9c3e1fe5256da14a0a307dff0478f90c55fc8c)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index c93eef6f7a6b..5cdbc86ef8f5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -107,7 +107,7 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	if (payload.write && result >= 0) {
 		if (result) {
 			/*one byte indicating partially written bytes*/
-			drm_info(adev_to_drm(adev), "amdgpu: AUX partially written\n");
+			drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX partially written\n");
 			result = payload.data[0];
 		} else if (!payload.reply[0])
 			/*I2C_ACK|AUX_ACK*/
@@ -133,11 +133,11 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 			break;
 		}
 
-		drm_info(adev_to_drm(adev), "amdgpu: DP AUX transfer fail:%d\n", operation_result);
+		drm_dbg_dp(adev_to_drm(adev), "amdgpu: DP AUX transfer fail:%d\n", operation_result);
 	}
 
 	if (payload.reply[0])
-		drm_info(adev_to_drm(adev), "amdgpu: AUX reply command not ACK: 0x%02x.",
+		drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX reply command not ACK: 0x%02x.",
 			payload.reply[0]);
 
 	return result;


