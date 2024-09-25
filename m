Return-Path: <stable+bounces-77514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534F1985DFA
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037E5281270
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3535A208E75;
	Wed, 25 Sep 2024 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/KS55dL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EC7208E70;
	Wed, 25 Sep 2024 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266085; cv=none; b=pPo87/OHSrRD71oqfMDs2n4l/aV8/lFZID8WvrmB9oTfLjFbVZCWkJkfdUGRzuu3WvQQ6/mOfxNg+QCVT9dnC3Do5AiPlLG68gHCYAbWxAhuyewGwh9uyzuXB2Ty3BU3pUkEqrt03aIXr1Jd+yYhwlSBG0MEBXnxqEhaOgOWt6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266085; c=relaxed/simple;
	bh=Ksqu8nOUQTfxeTp6k0Uxh8iY+BnEDmfD+McJOdXyPRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7vyOn2Jq20anFWQJAJJz2aYwjO8Y2kKnQrqYx0/b5MAHjcSU/EJW/EojMOjjipm1Em0CA4IKCZN0xJNn43jiK5wf1H46UMWYEoNFHja6j1dhM2HtABXBwF3tyKJwkntSlSRrD1mJ2EHxI7XiPMZWaT9VvIJd4cPFtcNWJicOhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/KS55dL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D83C4CEC7;
	Wed, 25 Sep 2024 12:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266084;
	bh=Ksqu8nOUQTfxeTp6k0Uxh8iY+BnEDmfD+McJOdXyPRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/KS55dLSQAeMMvvuFFvp9YUgGoarHqHy4ejcRcKNGn7oG0ow30JlraKCd0LObZCP
	 UYE+Rh3BBbBbDzDXQ9TXS9riH/A+8vJdXQnXF2ZlZM5how/P4fjE3D9q62iLRCsJEh
	 EGYlmFb2TEZhtVtcNw3A5ljeSmY/NzfPxLyV7rpvbHtGRnqYr7tHF285rjNcIM/zpI
	 2YSgY8oavl1KZyT3az+vqsr4hhq40vGaUqcMjgvbz1TgEzZozZK0ZkQeVocDjw44hP
	 6IUuZb2roDfwd9PEyMrRZMNuy6d2Be4UCZQcagFVCBC4a8/Oz2Xv3+wrSRMEdCP0+x
	 jAvvRp1I+p1xA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Huang <tim.huang@amd.com>,
	Jesse Zhang <jesse.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	electrodeyt@gmail.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 166/197] drm/amdgpu: fix unchecked return value warning for amdgpu_atombios
Date: Wed, 25 Sep 2024 07:53:05 -0400
Message-ID: <20240925115823.1303019-166-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Tim Huang <tim.huang@amd.com>

[ Upstream commit 92549780e32718d64a6d08bbbb3c6fffecb541c7 ]

This resolves the unchecded return value warning reported by Coverity.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 35 ++++++++++++--------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 7dc102f0bc1d3..0c8975ac5af9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1018,8 +1018,9 @@ int amdgpu_atombios_get_clock_dividers(struct amdgpu_device *adev,
 		if (clock_type == COMPUTE_ENGINE_PLL_PARAM) {
 			args.v3.ulClockParams = cpu_to_le32((clock_type << 24) | clock);
 
-			amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-				sizeof(args));
+			if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+			    index, (uint32_t *)&args, sizeof(args)))
+				return -EINVAL;
 
 			dividers->post_div = args.v3.ucPostDiv;
 			dividers->enable_post_div = (args.v3.ucCntlFlag &
@@ -1039,8 +1040,9 @@ int amdgpu_atombios_get_clock_dividers(struct amdgpu_device *adev,
 			if (strobe_mode)
 				args.v5.ucInputFlag = ATOM_PLL_INPUT_FLAG_PLL_STROBE_MODE_EN;
 
-			amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-				sizeof(args));
+			if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+			    index, (uint32_t *)&args, sizeof(args)))
+				return -EINVAL;
 
 			dividers->post_div = args.v5.ucPostDiv;
 			dividers->enable_post_div = (args.v5.ucCntlFlag &
@@ -1058,8 +1060,9 @@ int amdgpu_atombios_get_clock_dividers(struct amdgpu_device *adev,
 		/* fusion */
 		args.v4.ulClock = cpu_to_le32(clock);	/* 10 khz */
 
-		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-			sizeof(args));
+		if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+		    index, (uint32_t *)&args, sizeof(args)))
+			return -EINVAL;
 
 		dividers->post_divider = dividers->post_div = args.v4.ucPostDiv;
 		dividers->real_clock = le32_to_cpu(args.v4.ulClock);
@@ -1070,8 +1073,9 @@ int amdgpu_atombios_get_clock_dividers(struct amdgpu_device *adev,
 		args.v6_in.ulClock.ulComputeClockFlag = clock_type;
 		args.v6_in.ulClock.ulClockFreq = cpu_to_le32(clock);	/* 10 khz */
 
-		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-			sizeof(args));
+		if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+		    index, (uint32_t *)&args, sizeof(args)))
+			return -EINVAL;
 
 		dividers->whole_fb_div = le16_to_cpu(args.v6_out.ulFbDiv.usFbDiv);
 		dividers->frac_fb_div = le16_to_cpu(args.v6_out.ulFbDiv.usFbDivFrac);
@@ -1113,8 +1117,9 @@ int amdgpu_atombios_get_memory_pll_dividers(struct amdgpu_device *adev,
 			if (strobe_mode)
 				args.ucInputFlag |= MPLL_INPUT_FLAG_STROBE_MODE_EN;
 
-			amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-				sizeof(args));
+			if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+			    index, (uint32_t *)&args, sizeof(args)))
+				return -EINVAL;
 
 			mpll_param->clkfrac = le16_to_cpu(args.ulFbDiv.usFbDivFrac);
 			mpll_param->clkf = le16_to_cpu(args.ulFbDiv.usFbDiv);
@@ -1211,8 +1216,9 @@ int amdgpu_atombios_get_max_vddc(struct amdgpu_device *adev, u8 voltage_type,
 		args.v2.ucVoltageMode = 0;
 		args.v2.usVoltageLevel = 0;
 
-		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-			sizeof(args));
+		if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+		    index, (uint32_t *)&args, sizeof(args)))
+			return -EINVAL;
 
 		*voltage = le16_to_cpu(args.v2.usVoltageLevel);
 		break;
@@ -1221,8 +1227,9 @@ int amdgpu_atombios_get_max_vddc(struct amdgpu_device *adev, u8 voltage_type,
 		args.v3.ucVoltageMode = ATOM_GET_VOLTAGE_LEVEL;
 		args.v3.usVoltageLevel = cpu_to_le16(voltage_id);
 
-		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-			sizeof(args));
+		if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+		    index, (uint32_t *)&args, sizeof(args)))
+			return -EINVAL;
 
 		*voltage = le16_to_cpu(args.v3.usVoltageLevel);
 		break;
-- 
2.43.0


