Return-Path: <stable+bounces-64972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8874943D1F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D79283AEF
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B2B3DAC1D;
	Thu,  1 Aug 2024 00:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdkuhXPF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629033DAC0E;
	Thu,  1 Aug 2024 00:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471807; cv=none; b=rIq/pav+NdtZOcBF41hPeDWUpsUNyDP03LJXTmAo6Bes/1SWc6xzGAnYWgXejoCtr62UUKjsivRwGJXP8Q2mrOdwc0BZam39lY14aHZ8zZcgmPPXG6dEzKp53kInn613r2sLdbRf2n9FOt5lPegqhcZvamaiLyRl6BEl7DAEw5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471807; c=relaxed/simple;
	bh=Y00lFwOfs8utmAlyqNrsjuufMAzmrSd+JCkb86Z3v0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvn3OxjbsGyv/mUrlAx3LpQ52iOrlXi2DQde7AgActJhAvSWrjOJZaVyb6QnTCWDOVa0DtjHsqVaV1GA21E/i3mMH5xsDsjnU/Tc0R+2YwUoAQyfEtnVdgNNfyKop7TCjp93CXxyMMC73WryC3JQtURGikHGwHazbRKb+JZvse4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdkuhXPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F8AC4AF0C;
	Thu,  1 Aug 2024 00:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471807;
	bh=Y00lFwOfs8utmAlyqNrsjuufMAzmrSd+JCkb86Z3v0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hdkuhXPFcEYzN+BjGNIY319MNDrvUtQ2K2WyAojNx5Ase0TcP+/ZjRRkDavxp1mYL
	 bJAMgmsMG3DT3oOE3JCyqxqQ2WdXQ/6ZtLp3J/IaRK/7iDtu4EkinuFCYZwVpr1FZ6
	 pgDOfttd4m6macgh/H31xVcc2nkC/d64z6KXS+bmhIMxxhi8m1PVkztFqJmkVdOnJW
	 oaMK9Xf+RZas1fER2fox3JNWnA3csOK3uoMQ/WoyLDGLkUbDIi/UtJGzBRTUAL0sDn
	 mzcbE73VJtw6G0Pwv90V5pPPcYdikDgXKmCGadn1bIBZQ/RFADccxvtLQNF74XB8ob
	 2L5SmWddKO+Cw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	lijo.lazar@amd.com,
	Hawking.Zhang@amd.com,
	electrodeyt@gmail.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 26/83] drm/amdgpu: fix mc_data out-of-bounds read warning
Date: Wed, 31 Jul 2024 20:17:41 -0400
Message-ID: <20240801002107.3934037-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Tim Huang <Tim.Huang@amd.com>

[ Upstream commit 51dfc0a4d609fe700750a62f41447f01b8c9ea50 ]

Clear warning that read mc_data[i-1] may out-of-bounds.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index dce9e7d5e4ec6..a14a54a734c12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1476,6 +1476,8 @@ int amdgpu_atombios_init_mc_reg_table(struct amdgpu_device *adev,
 										(u32)le32_to_cpu(*((u32 *)reg_data + j));
 									j++;
 								} else if ((reg_table->mc_reg_address[i].pre_reg_data & LOW_NIBBLE_MASK) == DATA_EQU_PREV) {
+									if (i == 0)
+										continue;
 									reg_table->mc_reg_table_entry[num_ranges].mc_data[i] =
 										reg_table->mc_reg_table_entry[num_ranges].mc_data[i - 1];
 								}
-- 
2.43.0


