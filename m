Return-Path: <stable+bounces-95123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CAC9D756D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEBB0B37BCF
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E1222A581;
	Sun, 24 Nov 2024 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYz5aa6S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A052F229C77;
	Sun, 24 Nov 2024 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456076; cv=none; b=qLOkhY3Hc9nesp9PBN8O62gS/id4xxYyeDRVDIwAuSuKfEtI01A4vH0baN1NaqMjfp6QG1hrUeXW2zEeqNmYbWeOz/8PawRqXGuOsifTVxBpqJQlYMDMXOVhRwr9f91aVwcrSvSAeRfL1WQ5rbv3+0piqvccoUVA32O7vfDnArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456076; c=relaxed/simple;
	bh=qkgcVKR8Ql1xpozKQZGpIzlv1QYsIHMvwC7wX7DV7nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLJXMOgJabP/uyP4oOpgDhesx7Nw3OiTXZp9gR50nxRiLRtP+cZ9vCNo2gdZpzmp35H6EecZgnku19uyd0FTEsaVlsynWyNw/96szg5kkHCdsjwdAG2qGM68Ic7I7YHTHBO4m2Gks7bAXDowRqHDKWGI95dJszeMnL8arWvSrY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYz5aa6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AC9C4CED3;
	Sun, 24 Nov 2024 13:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456076;
	bh=qkgcVKR8Ql1xpozKQZGpIzlv1QYsIHMvwC7wX7DV7nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JYz5aa6SGhx6gzbgr15yr2DY1f1voetTIYStPKDba/jdiL12mpy0EeZ1IaIRaB0tI
	 cVDVDSGjmTbqnL1xlyN4kuTg/f5Sy8rBuZk+XscAThVeJpobXmYShJlNrCXi2vv5jM
	 w7MG91XV2VnIxgIdvyaf6RbzOuX0XFYNfnZD7zcyd+qiCyTmygnLxL83TfC8ywJt8O
	 ivOtrGjz6h0kENOyQiTNnPSpcshrhsvaANQ7HKZJUDrmjSIJ/+pN5OLRy3G7Gf6Wo8
	 AxcmcgDmo9lfvuFxQD32Bql4xBJcgkJ986Ptpv9eayIBhTQ5kCMVpb3RJfLKyf4UM/
	 rh4ZqOkzgMn5g==
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
Subject: [PATCH AUTOSEL 6.6 33/61] drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts for vega20_ih
Date: Sun, 24 Nov 2024 08:45:08 -0500
Message-ID: <20241124134637.3346391-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index 131e7b769519c..8ab2011e82098 100644
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


