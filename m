Return-Path: <stable+bounces-205618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E27DCFA31C
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 19:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2831302C900
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C90D2F3C19;
	Tue,  6 Jan 2026 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p97jnFWO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1231F1932;
	Tue,  6 Jan 2026 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721290; cv=none; b=RoMnWiTuLKUBKp+CSXDmusA00mJQocJOFOPEW09peSSg5KIKGUFxOaUeqKUKMo8ftHAUfqPlJ+RDIRytUrx63aHQULZm83Ku7VRGl7pdfJIWmmBe3itY8TGLVoLinqAI4PlAnIisRn5lOGYc3fAiBANosIt8smHzMipcWL/s5SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721290; c=relaxed/simple;
	bh=w+luoWE+cg4S/yoJJ0J/DdDdd3l3f76OJw0cwrN4aBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2P0DTWUvxv8r0RBOMtLw5RvnHqzwWhZjwvDHDTvtncUANv890uJiN5kh2+k39MMcRpCHrbC3kc0y8hNiLnUCD0stViPMPR3jKYmhn6AS4rhB0z/e14YMYKLA8nY3J+Eu8+lEXLy841X05skNd8Jr7v8TXtrjByVJKglF1BtLgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p97jnFWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3CDC116C6;
	Tue,  6 Jan 2026 17:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767721290;
	bh=w+luoWE+cg4S/yoJJ0J/DdDdd3l3f76OJw0cwrN4aBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p97jnFWOTvtIxqghwkoJ5SM2lLz7scdF16vXR9xzEEfZp5fySC/39p1em0PpqnoxN
	 nNDrP6nsDRGPRYqIvjzKIiI92yMKMy0bHydjdudXYf4O4HQuWxFOk7RxuRavRFw6cD
	 wvo8DhE5amX4pfVzp+ZO/WgDVM26kOZrRxdSW0Ic=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: [PATCH 6.12 460/567] drm/msm/a6xx: Fix out of bound IO access in a6xx_get_gmu_registers
Date: Tue,  6 Jan 2026 18:04:02 +0100
Message-ID: <20260106170508.362574487@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akhil P Oommen <akhilpo@oss.qualcomm.com>

commit 779b68a5bf2764c8ed3aa800e41ba0d5d007e1e7 upstream.

REG_A6XX_GMU_AO_AHB_FENCE_CTRL register falls under GMU's register
range. So, use gmu_write() routines to write to this register.

Fixes: 1707add81551 ("drm/msm/a6xx: Add a6xx gpu state")
Cc: stable@vger.kernel.org
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/688993/
Message-ID: <20251118-kaana-gpu-support-v4-1-86eeb8e93fb6@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -1231,7 +1231,7 @@ static void a6xx_get_gmu_registers(struc
 		return;
 
 	/* Set the fence to ALLOW mode so we can access the registers */
-	gpu_write(gpu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, 0);
+	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, 0);
 
 	_a6xx_get_gmu_registers(gpu, a6xx_state, &a6xx_gmu_reglist[2],
 		&a6xx_state->gmu_registers[2], false);



