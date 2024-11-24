Return-Path: <stable+bounces-95178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E28D9D73EE
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B6D28B448
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329C6235BEA;
	Sun, 24 Nov 2024 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2m/vxcU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A83235BE6;
	Sun, 24 Nov 2024 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456246; cv=none; b=F7VrPWRFJ3vCiPe1tUXgI9qkdbdU4HL2nGvyXxcmauerHy0ozqsnAis5nN2p6J0sX4B9wwaN44yX26Z7zqT7GcZ33uwbhs061lMOWbOnfIlEPEM9qFS8LoJkq4Rhd2vUYRLn40PdieX24r+pCaQxnYKWsV6m+V+PvOn7XEloC7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456246; c=relaxed/simple;
	bh=2O8QUltsFBoYt2xOLgHBENSJk2Qb/KzlOlICBSMWuGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ssw57+B903CUHkn9wXyANtAjrp2gEHjiV/HmDtKCtWzeywH6iOlGgYuzWKcbQNPL5r9+s5NRO4VmZTZ96Sukco9Hvueh1YXFy1MrBeWsg5+gviKNb8p73lmY5JWZW4suMlwvjqjciHkYWWqfi6LiwXuWV8/qUQMpqL5HezhNU2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2m/vxcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC7DC4CED1;
	Sun, 24 Nov 2024 13:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456245;
	bh=2O8QUltsFBoYt2xOLgHBENSJk2Qb/KzlOlICBSMWuGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U2m/vxcUs50DLktsK8MJQua88YCbjZrcp0Uz6mLIQaWw54gedojNkhqW20q0dSCFY
	 +yP6x9X+ysvxw7YmE41tecRR1lEhAx9WuCdIJynkYQACn5ko22QDR1kAw1dVtDC1Ic
	 pQG/t1RnCtqC2bq/mZtpvS/X0vI3N+RztlNRG0UY7zjr7axKNyT2ly9KEm9uKLObia
	 8PuRgSKoHuiIycByb2Cd/VmlLFFgfRV4hqcXsKRBniYCjrC/QNMvMO367B7OA1Rlz6
	 iiwrtNQQ5B7INfCtIi/B5OdK3ZJf7e+Ef3WuZY6JP2/WcZXmVOtbrEuRoZINaRUexp
	 orY2MMyUN8WzQ==
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
Subject: [PATCH AUTOSEL 6.1 27/48] drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts for vega20_ih
Date: Sun, 24 Nov 2024 08:48:50 -0500
Message-ID: <20241124134950.3348099-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index f1ba76c35cd6e..e85a0fb227d4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -109,6 +109,33 @@ static int vega20_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
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


