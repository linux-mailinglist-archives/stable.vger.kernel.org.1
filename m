Return-Path: <stable+bounces-141228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC0EAAB198
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7671BA768C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6498736452D;
	Tue,  6 May 2025 00:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oD8DO5aV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1422D29A9;
	Mon,  5 May 2025 22:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485539; cv=none; b=KTS/2ktEEKDafCIzSEC+rtq3Izmn0chL0R2BpJYIjl8Y/6gcFFfp0xe3YIeYCxb3xQwHsDOeEa6Q+stDut9CnL883lxrRtqgDNp+/LsZEePZW8rk+kQYKqnG1s4lGrNLMz3vsbDwHmt3P9PtQHRPWvuwrfAW13oR6P4CEIK6SxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485539; c=relaxed/simple;
	bh=wBfUbzaxmhjYfDfq1VVlhEIMstN1gwg46rt6za0VmZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gc2fi14l1fTEIIkTscyRDAa+E3Do3CWut8Ne/F79Bi6nMkn2/SB5/Ptpizdwp/Q0IADH9XY/qLVclvjRSVIlkWrjGkcEtjBLU4iVOWjduahtY9oNdvQ6AWKbomdjMhv5x9NIJWDfeO3cyzwCswcT1fxAsTAVE24i0tDijs0XI4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oD8DO5aV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DADC4CEE4;
	Mon,  5 May 2025 22:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485539;
	bh=wBfUbzaxmhjYfDfq1VVlhEIMstN1gwg46rt6za0VmZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oD8DO5aVteaxpMz8zhmDhgy7lyskbhDlPZw2c8HuCnT24RFsYFo6wZOw37YszqUZ3
	 upRpamWjNprz2gwlivxTMjGaF4cy9DG6b49LgQrqyyMW96QHQDqBMdOiBXG7vcYsCS
	 BRyxZL9wGA480MMs2LLEmzj/7+3OVerMtNDQ5S2r9b6geEcAGT0muCqpoVq/4Xnd01
	 tREWcI8ZjaA8eohCaNwWtbbIqNMal6GWeWZcuRQhIEeAWypi4Ru/CUAG2ISZgespGD
	 19UxZEcudu4d58j0sZwmFOChTJzgQs6kgUaksJzabPpSRAJEQw8tueSWpUQU9qFhk7
	 2jBBrCBnLxbTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charlene Liu <Charlene.Liu@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Roman Li <Roman.Li@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	austin.zheng@amd.com,
	jun.lei@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	nsusanto@amd.com,
	nicholas.kazlauskas@amd.com,
	chiahsuan.chung@amd.com,
	paul.hsieh@amd.com,
	daniel.miess@amd.com,
	zaeem.mohamed@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 363/486] drm/amd/display: pass calculated dram_speed_mts to dml2
Date: Mon,  5 May 2025 18:37:19 -0400
Message-Id: <20250505223922.2682012-363-sashal@kernel.org>
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

From: Charlene Liu <Charlene.Liu@amd.com>

[ Upstream commit b40d022ec06ade9f6c809091dc188422a0f0946d ]

[why]
currently dml2 is using a hard coded 16 to convert memclk to dram_speed_mts.
for apu, this depends on wck_ratio.

change to pass the already calculated dram_speed_mts from fpu to dml2.

v2: use existing calculation of dram_speed_mts for now to avoid regression

Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c | 1 +
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h     | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 47d785204f29c..e8efffcc69a16 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -367,6 +367,8 @@ void dcn35_update_bw_bounding_box_fpu(struct dc *dc,
 				clock_limits[i].socclk_mhz;
 			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].memclk_mhz =
 				clk_table->entries[i].memclk_mhz * clk_table->entries[i].wck_ratio;
+
+			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].dram_speed_mts = clock_limits[i].dram_speed_mts;
 			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].dtbclk_mhz =
 				clock_limits[i].dtbclk_mhz;
 			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_dcfclk_levels =
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
index a201dbb743d79..79d921adc2153 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
@@ -401,6 +401,7 @@ void dcn351_update_bw_bounding_box_fpu(struct dc *dc,
 				clock_limits[i].socclk_mhz;
 			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].memclk_mhz =
 				clk_table->entries[i].memclk_mhz * clk_table->entries[i].wck_ratio;
+			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].dram_speed_mts = clock_limits[i].dram_speed_mts;
 			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].dtbclk_mhz =
 				clock_limits[i].dtbclk_mhz;
 			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_dcfclk_levels =
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index 0f944fcfd5a5b..785226945699d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -159,6 +159,7 @@ struct dml2_clks_table_entry {
 	unsigned int dtbclk_mhz;
 	unsigned int dispclk_mhz;
 	unsigned int dppclk_mhz;
+	unsigned int dram_speed_mts; /*which is based on wck_ratio*/
 };
 
 struct dml2_clks_num_entries {
-- 
2.39.5


