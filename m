Return-Path: <stable+bounces-295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 953157F7705
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5CE1F20CD1
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A19E2C1B4;
	Fri, 24 Nov 2023 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ybIXJ8K+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829A6647
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2E7C433C7;
	Fri, 24 Nov 2023 14:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700837831;
	bh=mdgRQRxjH+EI0Q7sOrXH++et+aHmrr1X2xlTkBWXi9w=;
	h=Subject:To:Cc:From:Date:From;
	b=ybIXJ8K+LcmjyozcQAukjuy3sIHxNTzH3dnla43gryacl8YeLNnRD9E9RoNWFSkPe
	 J04C3gMviWliKjQbwzI89VMJ40EQXM5YBICvIkwhZS6k6zvXPZ4gmu0g6AB4PHxkZ0
	 SKhC0qBZGovwr7Co18e3mhj2Y5iZwXTDIUycNDkA=
Subject: FAILED: patch "[PATCH] drm/amdgpu: ungate power gating when system suspend" failed to apply to 6.6-stable tree
To: perry.yuan@amd.com,alexander.deucher@amd.com,kenneth.feng@amd.com,kevinyang.wang@amd.com,kun.liu2@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 14:57:09 +0000
Message-ID: <2023112409-fructose-spry-be2c@gregkh>
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
git cherry-pick -x 886b92f63573eab4ba30b06c4514b8f4af114e6a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112409-fructose-spry-be2c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

886b92f63573 ("drm/amdgpu: ungate power gating when system suspend")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 886b92f63573eab4ba30b06c4514b8f4af114e6a Mon Sep 17 00:00:00 2001
From: Perry Yuan <perry.yuan@amd.com>
Date: Thu, 27 Jul 2023 01:45:30 -0400
Subject: [PATCH] drm/amdgpu: ungate power gating when system suspend

[Why] During suspend, if GFX DPM is enabled and GFXOFF feature is
enabled the system may get hung. So, it is suggested to disable
GFXOFF feature during suspend and enable it after resume.

[How] Update the code to disable GFXOFF feature during suspend and enable
it after resume.

[  311.396526] amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
[  311.396530] amdgpu 0000:03:00.0: amdgpu: Fail to disable dpm features!
[  311.396531] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP block <smu> failed -62

Acked-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Kun Liu <kun.liu2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index dafb8cc1c684..c8a3bf01743f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3498,6 +3498,8 @@ static void gfx_v10_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 static void gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 					       unsigned int vmid);
 
+static int gfx_v10_0_set_powergating_state(void *handle,
+					  enum amd_powergating_state state);
 static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
 {
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
@@ -7179,6 +7181,13 @@ static int gfx_v10_0_hw_fini(void *handle)
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
+	/* WA added for Vangogh asic fixing the SMU suspend failure
+	 * It needs to set power gating again during gfxoff control
+	 * otherwise the gfxoff disallowing will be failed to set.
+	 */
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(10, 3, 1))
+		gfx_v10_0_set_powergating_state(handle, AMD_PG_STATE_UNGATE);
+
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
 			if (amdgpu_gfx_disable_kgq(adev, 0))


