Return-Path: <stable+bounces-140223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1962DAAA66F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BCA985B65
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF57323337;
	Mon,  5 May 2025 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOEgn2QE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EBF323330;
	Mon,  5 May 2025 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484427; cv=none; b=rmCUiesEubejsj9AsU6uPxf+5OBLdHCE5CPSVBfvUl7flbnEha/sbfK7OzhX/gwKI+mSm7N5V4b2D5Yw6K4oouqchakK4iqy6BWFpC7By4HqIxfKvMS0q/RWuOWMc2Mw3HZsdF/FYD2ZqOpQcQB+oOkC11UZGqT7FHJV1FerPJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484427; c=relaxed/simple;
	bh=LQuPVeC3fJNuEY74H0m/1+/IkO53Xpzz+TKlzgBh4l4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AApjhccvxUVjFILkUoDqk5XG6nRF8/ji6ciDPBSfJYe6p4MDlfoBB7ml4DCYR1fdPOi/rNBYzhN2+J0FgWJzNnHMaL7eYm6mH4oBICS3lLYBx1gmvCZ5LATsECu28DWXdXVky9mtvo4AC3OKV7+OT5m6ULjxCkE8SEVqL5sIX9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOEgn2QE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8495C4CEE4;
	Mon,  5 May 2025 22:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484426;
	bh=LQuPVeC3fJNuEY74H0m/1+/IkO53Xpzz+TKlzgBh4l4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kOEgn2QEpPusdi0/oFjwqL8e/DRbj1x9vkq44gcAy3sxV0Gh+lLO5WJUxPpRV2bdl
	 AXtJbRyHImKOw5CLRsCcmpHvGlWFha2VDGxhhcU+zHWD4ZTw912NLqrIiAYUj+gzq+
	 UQyCjBAxsN/CKYJlihg1Ev4FVaIT8w2dur/mS0pWGG2Xuame9QE3VIR3CUPpNQAYPh
	 8+Tvv+JCZ+3NMOzuu2qeTwSipQpbR6H1mpa8rsGyAgBOvYUlCXbAsKYnOam1Qj4ddJ
	 ws10PAVo4ZYmWwxnknib2SVtSRIEtdVwCmHWjalSCNAWNAZ0N0eyRwdPROh3VSQVxE
	 PfalV0zpqKTiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiang Liu <gerry@linux.alibaba.com>,
	Shuo Liu <shuox.liu@linux.alibaba.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	lijo.lazar@amd.com,
	david.rosca@amd.com,
	Prike.Liang@amd.com,
	asad.kamal@amd.com,
	sonjiang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 475/642] amdgpu/soc15: enable asic reset for dGPU in case of suspend abort
Date: Mon,  5 May 2025 18:11:31 -0400
Message-Id: <20250505221419.2672473-475-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Jiang Liu <gerry@linux.alibaba.com>

[ Upstream commit 38e8ca3e4b6de1c6e49d0140264cfc8d314a5f70 ]

When GPU suspend is aborted, do the same for dGPU as APU to reset
soc15 asic. Otherwise it may cause following errors:
[  547.229463] amdgpu 0001:81:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring kiq_0.2.1.0 test failed (-110)

[  555.126827] amdgpu 0000:0a:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring kiq_0.2.1.0 test failed (-110)
[  555.126901] [drm:amdgpu_gfx_enable_kcq [amdgpu]] *ERROR* KCQ enable failed
[  555.126957] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block <gfx_v9_4_3> failed -110
[  555.126959] amdgpu 0000:0a:00.0: amdgpu: amdgpu_device_ip_resume failed (-110).
[  555.126965] PM: dpm_run_callback(): pci_pm_resume+0x0/0xe0 returns -110
[  555.126966] PM: Device 0000:0a:00.0 failed to resume async: error -110

This fix has been tested on Mi308X.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Tested-by: Shuo Liu <shuox.liu@linux.alibaba.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/2462b4b12eb9d025e82525178d568cbaa4c223ff.1736739303.git.gerry@linux.alibaba.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index e98fb3fa36a88..6e09613de8cd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -604,12 +604,10 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
 {
 	/* Will reset for the following suspend abort cases.
-	 * 1) Only reset on APU side, dGPU hasn't checked yet.
-	 * 2) S3 suspend aborted in the normal S3 suspend or
-	 *    performing pm core test.
+	 * 1) S3 suspend aborted in the normal S3 suspend
+	 * 2) S3 suspend aborted in performing pm core test.
 	 */
-	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
-			!pm_resume_via_firmware())
+	if (adev->in_s3 && !pm_resume_via_firmware())
 		return true;
 	else
 		return false;
-- 
2.39.5


