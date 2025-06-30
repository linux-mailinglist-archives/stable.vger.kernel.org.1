Return-Path: <stable+bounces-158949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FA7AEDD58
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 14:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F0E188F918
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 12:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122961DE891;
	Mon, 30 Jun 2025 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZqMljLUo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55231DFF7
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287525; cv=none; b=cqWRli/bPekbUyah+THhg8YENYY1RVLoCvQlmGCquVl5WAKGzWih+pKevqt3o81LBBHgKKyrE5FLwP5e05e0q0cNKsmpP/c0kQTyqzHQKc8gkCUlRwGtAw9qsDSNqlPOVciKXqxllOHsuXfQCb18SUhCLq39HVdwZ/JEvN8e9YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287525; c=relaxed/simple;
	bh=sfOGEDaspY/3BRosUF12hBo8mlZWglS3md3VeNXVGc4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ahZDWY0tD/r/fKTMsPyeWzUV4x18rdXnl/+IwJnRcYKYmIAYfT3oqMBw+SR0wMoRCFSc1Nsm2BsQk3M6L1EVGqwcLfsrAt5XY8Q9dfM7T1K749XpfgTS35dRYIsn/BHiaXLsT3UjcADay/7sni9KxZltlLHm87MLpWMDWd+ECLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZqMljLUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BA8C4CEE3;
	Mon, 30 Jun 2025 12:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751287525;
	bh=sfOGEDaspY/3BRosUF12hBo8mlZWglS3md3VeNXVGc4=;
	h=Subject:To:Cc:From:Date:From;
	b=ZqMljLUoFRXbvxDdUJ8+WHkPKRvgfcy7iVa0zfV/G9FkbQm2MW/eZxfYb2MGtfd55
	 nKU3Nn9SX4+T8viH/zmdyspn7K0y+1bM0B0oua/0djpnajRIHfTGEWqTZ1gJ2OaGvW
	 fOnW6NHhe2yh7l5OtxjZtTshnTpaOeSJZzI9d/3U=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Fix SDMA engine reset with logical instance ID" failed to apply to 6.15-stable tree
To: jesse.zhang@amd.com,Jesse.Zhang@amd.com,alexander.deucher@amd.com,jonathan.kim@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 14:45:22 +0200
Message-ID: <2025063022-wham-parachute-8574@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 09b585592fa481384597c81388733aed4a04dd05
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063022-wham-parachute-8574@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 09b585592fa481384597c81388733aed4a04dd05 Mon Sep 17 00:00:00 2001
From: Jesse Zhang <jesse.zhang@amd.com>
Date: Wed, 11 Jun 2025 15:02:09 +0800
Subject: [PATCH] drm/amdgpu: Fix SDMA engine reset with logical instance ID

This commit makes the following improvements to SDMA engine reset handling:

1. Clarifies in the function documentation that instance_id refers to a logical ID
2. Adds conversion from logical to physical instance ID before performing reset
   using GET_INST(SDMA0, instance_id) macro
3. Improves error messaging to indicate when a logical instance reset fails
4. Adds better code organization with blank lines for readability

The change ensures proper SDMA engine reset by using the correct physical
instance ID while maintaining the logical ID interface for callers.

V2: Remove harvest_config check and convert directly to physical instance (Lijo)

Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 5efa6217c239ed1ceec0f0414f9b6f6927387dfc)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 6716ac281c49..9b54a1ece447 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -540,8 +540,10 @@ static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
 	case IP_VERSION(4, 4, 2):
 	case IP_VERSION(4, 4, 4):
 	case IP_VERSION(4, 4, 5):
-		/* For SDMA 4.x, use the existing DPM interface for backward compatibility */
-		r = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
+		/* For SDMA 4.x, use the existing DPM interface for backward compatibility,
+		 * we need to convert the logical instance ID to physical instance ID before reset.
+		 */
+		r = amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, instance_id));
 		break;
 	case IP_VERSION(5, 0, 0):
 	case IP_VERSION(5, 0, 1):
@@ -568,7 +570,7 @@ static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
 /**
  * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
  * @adev: Pointer to the AMDGPU device
- * @instance_id: ID of the SDMA engine instance to reset
+ * @instance_id: Logical ID of the SDMA engine instance to reset
  *
  * Returns: 0 on success, or a negative error code on failure.
  */
@@ -601,7 +603,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 	/* Perform the SDMA reset for the specified instance */
 	ret = amdgpu_sdma_soft_reset(adev, instance_id);
 	if (ret) {
-		dev_err(adev->dev, "Failed to reset SDMA instance %u\n", instance_id);
+		dev_err(adev->dev, "Failed to reset SDMA logical instance %u\n", instance_id);
 		goto exit;
 	}
 


