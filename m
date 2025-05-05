Return-Path: <stable+bounces-140227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86D3AAA660
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F2D7A22F6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFCB323E81;
	Mon,  5 May 2025 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQBj87it"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89044323E73;
	Mon,  5 May 2025 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484447; cv=none; b=Tgb17CTiOcXf7ivcB7RYvuX0ImlGhvFFtQDMFHw7e7GiirqVeEM6RPSiTxsFXJSSGUkYDnI3ZJw0y4qR/YKrGDO+PCLe/PKgeYuveN3cFCAoTRP5/deGz0yc99I7L0AkjsPSiuE4bvHMS/4Fhk/TGez5jjoOBCcOusr9aqmwSRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484447; c=relaxed/simple;
	bh=jxXWZA6/hbDS4q7/o+RBQaoVxwSATKL7MT5TjUAl7YM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DItopcW/5KF6tm6eVqQYb0syvgpFsQHz3qC74Dnuxivl9mcwKHY3DE/eSFABlqJQ07Y+9CwGRvGuREcbnBTwd4YquzNv8s9maoYS0Vn4sfMEQpuqigXIdQhQXDOCfTliHLB6irydnslPn49vYiJBXCG0c2cl0xlpRvTAmf9Qzs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQBj87it; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91F5C4CEEE;
	Mon,  5 May 2025 22:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484447;
	bh=jxXWZA6/hbDS4q7/o+RBQaoVxwSATKL7MT5TjUAl7YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aQBj87itE3Hs2O0b/VtCh3lD+rOEFHml4cFfrrmE7OyDKyael2CWkjWfQ1qh+akwj
	 Gvksb0ygOy9qAm9W90UaQiEqGg1guWa1yMUnHw2DBWZxcPvfOAj/YIFEwJL23hHry8
	 +aqalkNPKCGUNifuXk120d9gNIy9cF+cRyAeY2BxT/dPM6NgBlUCZwIgJN+sx741G2
	 DWGtHf543/yZtzNtZg5Uc1dcAktRUxLBkRRd7A/MVIi91CPEdBybyKzFu4AOGP3WoR
	 olvUJem4Kw/jhG4qlUOF92xleLnWbs1uPGfrAzZbQqhrVyPW+AaLH2YiS13qIXElYh
	 NXJtIR0mJYbgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dillon Varone <dillon.varone@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Alvin.Lee2@amd.com,
	alex.hung@amd.com,
	zaeem.mohamed@amd.com,
	chris.park@amd.com,
	ryanseto@amd.com,
	martin.leung@amd.com,
	Charlene.Liu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 479/642] drm/amd/display: Populate register address for dentist for dcn401
Date: Mon,  5 May 2025 18:11:35 -0400
Message-Id: <20250505221419.2672473-479-sashal@kernel.org>
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

From: Dillon Varone <dillon.varone@amd.com>

[ Upstream commit 5f0d1ef6f16e150ee46cc00b8d233d9d271fe39e ]

[WHY&HOW]
Address was not previously populated which can result in incorrect
clock frequencies being read on boot.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c | 2 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h       | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 8082bb8776114..a3b8e3d4a429e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -24,6 +24,8 @@
 
 #include "dml/dcn401/dcn401_fpu.h"
 
+#define DCN_BASE__INST0_SEG1                       0x000000C0
+
 #define mmCLK01_CLK0_CLK_PLL_REQ                        0x16E37
 #define mmCLK01_CLK0_CLK0_DFS_CNTL                      0x16E69
 #define mmCLK01_CLK0_CLK1_DFS_CNTL                      0x16E6C
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index 7a1ca1e98059b..221645c023b50 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -221,6 +221,7 @@ enum dentist_divider_range {
 	CLK_SF(CLK0_CLK_PLL_REQ, FbMult_frac, mask_sh)
 
 #define CLK_REG_LIST_DCN401()	  \
+	SR(DENTIST_DISPCLK_CNTL), \
 	CLK_SR_DCN401(CLK0_CLK_PLL_REQ,   CLK01, 0), \
 	CLK_SR_DCN401(CLK0_CLK0_DFS_CNTL, CLK01, 0), \
 	CLK_SR_DCN401(CLK0_CLK1_DFS_CNTL,  CLK01, 0), \
-- 
2.39.5


