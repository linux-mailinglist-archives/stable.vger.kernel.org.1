Return-Path: <stable+bounces-141235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3A4AAB1AE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6DA177D27
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C3F335EEE;
	Tue,  6 May 2025 00:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZXTNbge"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9D92DA553;
	Mon,  5 May 2025 22:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485578; cv=none; b=mj5wHIqh04kQAFmSZeYeGA5lPgsSeZtJ0lJjM4AAg4AqcOR/EkTdf2/9Qs7/WqedxVdyvaVWBdfAmiwTvqOufkZZzEED6uDfzKXKyZhQNzWpVBuGaPoRrFHiAk443zlN+3eMKanTkvq3pij/yfC3yugROMI0Du/iCR9JsasEeKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485578; c=relaxed/simple;
	bh=6mPqgwLb2mCdS10e+lsKQ7uH3WuGjQ8Eakwk9ne+RJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JBEg6DQffRlyyUzBol35d2BUs6X6sJrG/On1GmkbA5teI06uWkylZsw1YgSVSFt6YnWJ++yWB6BZiZd7zaY9NFG3pxfGvOCpkLhBDM1/Vw1EyIh2YDm6f3+DqQI7E+LNpObW0+ZWmvVjOt/r6epvjLaA60+ytlylZlJJ5Ju6cW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZXTNbge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933B7C4CEED;
	Mon,  5 May 2025 22:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485577;
	bh=6mPqgwLb2mCdS10e+lsKQ7uH3WuGjQ8Eakwk9ne+RJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pZXTNbge5dROjBL9zI91uMJfUxp5SkqTtFJQzC4iiub5ORMYIH+u/NbLvu2OrSefv
	 tXfJ3UHl3Tj0P8gRnVgS7TwHlrzPMSwGkNpnD7Hlk6bEWeWCvXpRa1NNsLn0ZjBPHa
	 6PMTHTOWWqA76RWwwWdNtxGqjWYBDEdP06QAxDY1xOX6R0pq+DemSZTuYmYs9qx/s6
	 impMmglv2H3Sflbe98R0HN3RDYopOBhNzMMCOYEaNVGUAhrEC440R84cFffKKWWtgB
	 aC6vhZmOQe7AP5zALPyXL/pgQ80MiepTbZJ3bm2f0cxHufohSfSZlelJ5R9pc2OELY
	 GpLi0T546kJ+Q==
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
Subject: [PATCH AUTOSEL 6.12 373/486] drm/amd/display: Populate register address for dentist for dcn401
Date: Mon,  5 May 2025 18:37:29 -0400
Message-Id: <20250505223922.2682012-373-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 8cfc5f4359374..313e52997596a 100644
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


