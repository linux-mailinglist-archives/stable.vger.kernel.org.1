Return-Path: <stable+bounces-53749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AA290E5FF
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3E628338A
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A387A158;
	Wed, 19 Jun 2024 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0koT56Aj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23E06F300
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786339; cv=none; b=NhupIk83d2noF69MG5gdyammpKpZDUXKqhvg6TBI65BoR6lqDGnj5lbETevwXg5wYckbwXn7lvbHY/v7WNIg/zBjkvBQ83NHZLvGyEKO+yX/saESVizXOUsQe3LwC9t9O+er0qHbNxkOah9rHoutuqlfq3x0NLSGHaMmOjJ3+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786339; c=relaxed/simple;
	bh=4oVWYbN+PrxfNJf0StrCuSQi8XxAyN/IzojJ7KXFIbQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XVARQOBYWhgF6hsK7HsgwXq3Oas6lImQ/6blRaW2Tqm5Ro9DF8Xinv/EOGqrkOXPSSB/xuA8R55uHneQlOsUApPMTT8Dfayoqempy9XAxDT9u4Qj8qMj6xwzr5LjU180qrLDwrziQaTm/VITTIWj3gibs3eTv2WjAyQaipw/rsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0koT56Aj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B60BC2BBFC;
	Wed, 19 Jun 2024 08:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786339;
	bh=4oVWYbN+PrxfNJf0StrCuSQi8XxAyN/IzojJ7KXFIbQ=;
	h=Subject:To:Cc:From:Date:From;
	b=0koT56AjBvvuifGDY32VwzcJRrTlEtNJ/hb7HDFW1ZRRJ7EtUb4JrfGMk3ntUcEVk
	 xG9F8pYU7eTG2/OZ/27vLOEuSvhWufrEv1nGkmS260IaSB7eMxQEDRhSIWeZTPcMCt
	 Lslq9qTU7ZHI9UvuEEPQaKYspjSELl+B0TGltsVQ=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Reset dGPU if suspend got aborted" failed to apply to 5.10-stable tree
To: lijo.lazar@amd.com,Hawking.Zhang@amd.com,alexander.deucher@amd.com,kevinyang.wang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:38:34 +0200
Message-ID: <2024061934-endanger-autism-856a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x df3c7dc5c58b1f85033d2cd9a121b27844700ca2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061934-endanger-autism-856a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

df3c7dc5c58b ("drm/amdgpu: Reset dGPU if suspend got aborted")
71199aa47bbc ("drm/amdgpu: add soc21 common ip block v2")
0d055f09e121 ("drm/amdgpu: drop navi reg init functions")
bf99b9b03265 ("drm/amdgpu: drop nv_set_ip_blocks()")
f76f795a8ffa ("drm/amdgpu: move headless sku check into harvest function")
3f68c01be9a2 ("drm/amd/display: add cyan_skillfish display support")
59066d0083d2 ("drm/amdgpu: handle VCN instances when harvesting (v2)")
733ee71ae0d0 ("drm/amdgpu: replace dce_virtual with amdgpu_vkms (v3)")
fd922f7a0e90 ("drm/amdgpu: cleanup dce_virtual")
84ec374bd580 ("drm/amdgpu: create amdgpu_vkms (v4)")
641df0990487 ("drm/amdgpu: enable SMU for cyan_skilfish")
1c7916af55a7 ("drm/amdgpu: enable psp v11.0.8 for cyan_skillfish")
338b3cf0b9f8 ("drm/amdgpu: add nbio support for cyan_skillfish")
f36fb5a0e361 ("drm/amdgpu: set ip blocks for cyan_skillfish")
708391977be5 ("drm/amdgpu: dynamic initialize ip offset for cyan_skillfish")
46ddb8965882 ("drm/amd/display: implement workaround for riommu related hang")
9604b74bff62 ("drm/amdgpu: Correct the irq numbers for virtual crtc")
8fe44c080a53 ("drm/amdgpu/display: fold DRM_AMD_DC_DCN3_1 into DRM_AMD_DC_DCN")
30adeee52d1e ("drm/amd/display: Enforce DPCD Address ranges")
c5bc8c1bd4c7 ("drm/amd/display: Read LTTPR caps first on bootup")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From df3c7dc5c58b1f85033d2cd9a121b27844700ca2 Mon Sep 17 00:00:00 2001
From: Lijo Lazar <lijo.lazar@amd.com>
Date: Wed, 14 Feb 2024 17:55:54 +0530
Subject: [PATCH] drm/amdgpu: Reset dGPU if suspend got aborted

For SOC21 ASICs, there is an issue in re-enabling PM features if a
suspend got aborted. In such cases, reset the device during resume
phase. This is a workaround till a proper solution is finalized.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 8526282f4da1..abe319b0f063 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -867,10 +867,35 @@ static int soc21_common_suspend(void *handle)
 	return soc21_common_hw_fini(adev);
 }
 
+static bool soc21_need_reset_on_resume(struct amdgpu_device *adev)
+{
+	u32 sol_reg1, sol_reg2;
+
+	/* Will reset for the following suspend abort cases.
+	 * 1) Only reset dGPU side.
+	 * 2) S3 suspend got aborted and TOS is active.
+	 */
+	if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
+	    !adev->suspend_complete) {
+		sol_reg1 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+		msleep(100);
+		sol_reg2 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+
+		return (sol_reg1 != sol_reg2);
+	}
+
+	return false;
+}
+
 static int soc21_common_resume(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (soc21_need_reset_on_resume(adev)) {
+		dev_info(adev->dev, "S3 suspend aborted, resetting...");
+		soc21_asic_reset(adev);
+	}
+
 	return soc21_common_hw_init(adev);
 }
 


