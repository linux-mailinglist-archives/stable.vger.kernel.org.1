Return-Path: <stable+bounces-65054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7F2943DE2
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A871F2257A
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D58E1D0452;
	Thu,  1 Aug 2024 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAAGkZf5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384221D044D;
	Thu,  1 Aug 2024 00:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472199; cv=none; b=aCLsC3Wmb15PEHXs0H78OqaOV9axF+VpZ1CCDXJJI8vjc8K4dUQynyKM+GU1VXTm0Yr+EnVKx+gsAHDCCVli+wAwsZVBOcFtsiNqXekmAA8HcxKdFcOK0SyIOgHnx+LzudjVXXAS448IFfz+qmAYdALRkeWXwDmNlPdDd9HTSys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472199; c=relaxed/simple;
	bh=+R7UltP+hSTzVOJ4hD15m+PpE6pgJdcEl94o1E8adjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZE+dyAHNb8GPABnhTbU6iHIE/P/3EpeO7Gdm3aGhbdqmmw3yef4dCPNu3aqo/SmazD2u8qJCTvL4XVLhcueoVO+B+3qAQg8lFpSmPhKVI0noQaPyWLXZuWjFcLU7lLKjBCrkacEi9YRSF8IVVzQ88gVpZ3WrppfRcwHqa9YKnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAAGkZf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE00C4AF0C;
	Thu,  1 Aug 2024 00:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472198;
	bh=+R7UltP+hSTzVOJ4hD15m+PpE6pgJdcEl94o1E8adjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OAAGkZf5v4XZKFFHW1ym6J7zR8PXmxa3OEq/lYmMXIeBcPX8C8N828ti2nbRG/kxJ
	 BTrUz/nYg/imM99A2qsVjeMTX8TNqJNKS3Xdk9EM7y8ycirXRKT6snmHZrzIYVPRDX
	 7MKuxbophoJ6gCRppnqA8Y8LBCa5v9vy37ox2Ip6YlpcWOHXA76M0TgwAvyWKirIg1
	 +sFEc1YzpTgcjlvKw5iQKRPH9VkBpbIwLCSglHpP5U/VVcgPq6gJog/ybUZGpQV/QR
	 V9FPejqMNxRIdftibGRBqDVWWdLCDdOP1pSUaJebdtseJK58gkA7kGxJqyOmp2nmK2
	 kb+2t2SDsRtnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jesse Zhang <jesse.zhang@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	tao.zhou1@amd.com,
	felix.kuehling@amd.com,
	candice.li@amd.com,
	kevinyang.wang@amd.com,
	lijo.lazar@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 25/61] drm/amdgpu: the warning dereferencing obj for nbio_v7_4
Date: Wed, 31 Jul 2024 20:25:43 -0400
Message-ID: <20240801002803.3935985-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit d190b459b2a4304307c3468ed97477b808381011 ]

if ras_manager obj null, don't print NBIO err data

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 19455a7259391..7679a4cd55c05 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -384,7 +384,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 		else
 			WREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL, bif_doorbell_intr_cntl);
 
-		if (!ras->disable_ras_err_cnt_harvest) {
+		if (ras && !ras->disable_ras_err_cnt_harvest && obj) {
 			/*
 			 * clear error status after ras_controller_intr
 			 * according to hw team and count ue number
-- 
2.43.0


