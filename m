Return-Path: <stable+bounces-95052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0999F9D768E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 18:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DEFFB27F00
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761BC2010F9;
	Sun, 24 Nov 2024 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pk321ClH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C001990C4;
	Sun, 24 Nov 2024 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455817; cv=none; b=HR7yBuSSvsMg71awr5G2dMN001yNCXzbPsH0lLMAWTUTg0CIeoOT12WEGQAt8gLdj8fUm/YmLIYw+iSZ6qbsdKC5sJDqiiRni7w2qQ0QeZl3spv4m2mVaFk3VSfDy7IJib9tdU97owHL6vEY07EIpQWfhs9IBjYOqoxhP1mQZxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455817; c=relaxed/simple;
	bh=XeG85bzIWsZOEXLxnHyr1tY4lNsjU+dONEJ+l2SUeNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUV3OyhyXses+BGHcsrCYVdb51YxlJQ9VyAdMuNLVhmiKs4xZjJFhim9gF+imsSxDuA0ekoGcP5Gk2BuL95aZQKcYtdtyZpqd08s2MH8H+w1dXlWf2eoj46CTcahkfHGXWa3tEAd33BoaPVny+BLy0BfxyUYFLuX6I9FqAdOD8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pk321ClH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F9BC4CECC;
	Sun, 24 Nov 2024 13:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455817;
	bh=XeG85bzIWsZOEXLxnHyr1tY4lNsjU+dONEJ+l2SUeNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pk321ClHG/oZ9hoDISauUa+RSApckwZ4dm38yx9H8sZCsuH8ECQDgvmDechOf32YV
	 C9362FSPs4+Q2DxqiX+nPCrORyBA/Q/kZ354BwFyOcWf7DsFG6BAEeq9E+h4rxI4b9
	 kaVrYxvolosO9yTV0R5erYOS3nGpDz8jBcGmTkfpdlI08+sczQZqXVWiZnF2Kr8kSq
	 uW7D+OjZz4AtCa41LwLuZYWFRlxIT0DWe2MAEvrDZ5PiKu1atJALpjeNWCZwvUp6t4
	 n3P1Xt0oC86kZU6SXtRlQN902XRWpVmiiL5zlNcmEtTdw/v5Uzz/09zG+gzwSXcXfJ
	 ImnaBVkeeLdDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Victor Lu <victorchengchi.lu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	friedrich.vock@gmx.de,
	Hawking.Zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 49/87] drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts for vega20_ih
Date: Sun, 24 Nov 2024 08:38:27 -0500
Message-ID: <20241124134102.3344326-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Victor Lu <victorchengchi.lu@amd.com>

[ Upstream commit 8b22f048331dfd45fdfbf0efdfb1d43deff7518d ]

Port this change to vega20_ih.c:
commit afbf7955ff01 ("drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts")

Original commit message:
"Why:
Setting IH_RB_WPTR register to 0 will not clear the RB_OVERFLOW bit
if RB_ENABLE is not set.

How to fix:
Set WPTR_OVERFLOW_CLEAR bit after RB_ENABLE bit is set.
The RB_ENABLE bit is required to be set, together with
WPTR_OVERFLOW_ENABLE bit so that setting WPTR_OVERFLOW_CLEAR bit
would clear the RB_OVERFLOW."

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index ac439f0565e35..16f5561fb86ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -114,6 +114,33 @@ static int vega20_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_ENABLE, (enable ? 1 : 0));
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_GPU_TS_ENABLE, 1);
 
+	if (enable) {
+		/* Unset the CLEAR_OVERFLOW bit to make sure the next step
+		 * is switching the bit from 0 to 1
+		 */
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+		if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+			if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
+				return -ETIMEDOUT;
+		} else {
+			WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+		}
+
+		/* Clear RB_OVERFLOW bit */
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
+		if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+			if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
+				return -ETIMEDOUT;
+		} else {
+			WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+		}
+
+		/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+		 * can be detected.
+		 */
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	}
+
 	/* enable_intr field is only valid in ring0 */
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
-- 
2.43.0


