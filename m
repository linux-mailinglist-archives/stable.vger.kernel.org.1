Return-Path: <stable+bounces-240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA017F75B3
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179E7282502
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DA52C1BA;
	Fri, 24 Nov 2023 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y8VuOTrM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61642286B9
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E145AC433C8;
	Fri, 24 Nov 2023 13:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700834054;
	bh=75emIipprBAK4nNf1mZtcLy+dHoIXhSMUfPUZjFU23c=;
	h=Subject:To:Cc:From:Date:From;
	b=y8VuOTrM1l3PingHPfCFyOkUc0Qbw294jB9XYzLzOF1Yq0fvbwq0F7KhQEhzi26tJ
	 GyRJA2dXDGm1bjggkobTpVBRs7TNUPiacQI8E1+i9zz9vRypjOPCAIrQhuJRiJ5wJO
	 8XiqMFfTsCjXwhMsZ/gKJtWkTo3zjgAOOkUaBiAk=
Subject: FAILED: patch "[PATCH] drm/amd: Fix detection of _PR3 on the PCIe root port" failed to apply to 5.15-stable tree
To: mario.limonciello@amd.com,David.Perry@amd.com,Jun.Ma2@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 13:54:07 +0000
Message-ID: <2023112406-gonad-amuser-aab3@gregkh>
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
git cherry-pick -x c4c8955b8acb4d88d2ca02a7dc6010e5f0c5288d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112406-gonad-amuser-aab3@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

c4c8955b8acb ("drm/amd: Fix detection of _PR3 on the PCIe root port")
85ac2021fe3a ("drm/amdgpu: only check for _PR3 on dGPUs")
901e2be20dc5 ("drm/amdgpu: move PX checking into amdgpu_device_ip_early_init")
4a74c38cd67b ("drm/amdgpu: Detect if amdgpu in IOMMU direct map mode")
fe9c5c9affc9 ("drm/amdgpu: Use MAX_HWIP instead of HW_ID_MAX")
1d789535a036 ("drm/amdgpu: convert IP version array to include instances")
5c3720be7d46 ("drm/amdgpu: get VCN and SDMA instances from IP discovery table")
2cbc6f4259f6 ("drm/amd/display: fix error case handling")
75a07bcd1d30 ("drm/amdgpu/soc15: convert to IP version checking")
0b64a5a85229 ("drm/amdgpu/vcn2.5: convert to IP version checking")
96b8dd4423e7 ("drm/amdgpu/amdgpu_vcn: convert to IP version checking")
50638f7dbd0b ("drm/amdgpu/pm/amdgpu_smu: convert more IP version checking")
61b396b91196 ("drm/amdgpu/pm/smu_v13.0: convert IP version checking")
6b726a0a52cc ("drm/amdgpu/pm/smu_v11.0: update IP version checking")
1fcc208cd780 ("drm/amdgpu/psp_v13.0: convert to IP version checking")
e47868ea15cb ("drm/amdgpu/psp_v11.0: convert to IP version checking")
82d05736c47b ("drm/amdgpu/amdgpu_psp: convert to IP version checking")
9d0cb2c31891 ("drm/amdgpu/gfx9.0: convert to IP version checking")
24be2d70048b ("drm/amdgpu/hdp4.0: convert to IP version checking")
43bf00f21eaf ("drm/amdgpu/sdma4.0: convert to IP version checking")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c4c8955b8acb4d88d2ca02a7dc6010e5f0c5288d Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 26 Sep 2023 17:59:53 -0500
Subject: [PATCH] drm/amd: Fix detection of _PR3 on the PCIe root port

On some systems with Navi3x dGPU will attempt to use BACO for runtime
PM but fails to resume properly.  This is because on these systems
the root port goes into D3cold which is incompatible with BACO.

This happens because in this case dGPU is connected to a bridge between
root port which causes BOCO detection logic to fail.  Fix the intent of
the logic by looking at root port, not the immediate upstream bridge for
_PR3.

Cc: stable@vger.kernel.org
Suggested-by: Jun Ma <Jun.Ma2@amd.com>
Tested-by: David Perry <David.Perry@amd.com>
Fixes: b10c1c5b3a4e ("drm/amdgpu: add check for ACPI power resources")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e4627d92e1d0..bad2b5577e96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2238,7 +2238,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		adev->flags |= AMD_IS_PX;
 
 	if (!(adev->flags & AMD_IS_APU)) {
-		parent = pci_upstream_bridge(adev->pdev);
+		parent = pcie_find_root_port(adev->pdev);
 		adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
 	}
 


