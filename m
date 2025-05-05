Return-Path: <stable+bounces-140209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A59AAA64B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695C13A7E35
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB25F289FD9;
	Mon,  5 May 2025 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4e0KMZs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D25289FCF;
	Mon,  5 May 2025 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484351; cv=none; b=pKIYk7lEhrrHrfQK97JVAXMzJryqWH08zlUEc/Bef61M/17kUguhlhWM/Doq2OcbDO31KMBL8vwWsy11dyvrzibH/n24cxDDSQHmStZO6b0Yd0HXXfCKP+UMFpn12Mnnfcxr9O/iHGZ+sdQVJy4fP25eNAGZIZWMYqsr0r8pYg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484351; c=relaxed/simple;
	bh=KWzhfEAZmPHUG4x32DmdYJsjZ+NlA6z+ZlEFoc+wk0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTnovuoT231z0rc5+R4ZmMbG6hCcJ0ezGcGXRMMx9Pcz6jqkYkLLdcqZVXXRnxhMpRy92nP32i8LQb7u801j9PEv4Y49wEixa+sxt+ufe1r0Mz3uQsopTRERWEXhwdOIOfVvDi5pDoQNnbhcx1jYu4ypqp7t+dlkN6IbJJcddro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4e0KMZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1F6C4CEE4;
	Mon,  5 May 2025 22:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484351;
	bh=KWzhfEAZmPHUG4x32DmdYJsjZ+NlA6z+ZlEFoc+wk0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U4e0KMZsSqzuW/GppmA9wL4n4kr/2iPwycSmZkFhyLtMxo/+hlQVjY8g1R/MfqnHZ
	 xH4iL4ME7AKP/Q8HM71EFdU70stmfDKpI8d5FExnryi2OYsXvHDJJi3sRgrA0NR5HM
	 JZxNgX6kah3hDiJXJsnlXrUrYHRr7ZSyJl/GWc+ZHtPiHrRidGbbHRQpk7GrA+mu9O
	 HwhD6S9QXdBXs7K+WGux1bGPkdEGywvYjsPD5pKjRw1MdYr0FishQT1/jjDlIg6PXk
	 9imZCanwAdAW6of6mMAYZvIvyUseQIRlpzuZO+/akXfR5Vop1qh9zfsCC/jdTS5awm
	 VtQUElT0CQWGw==
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
	chiahsuan.chung@amd.com,
	nicholas.kazlauskas@amd.com,
	paul.hsieh@amd.com,
	daniel.miess@amd.com,
	zaeem.mohamed@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 461/642] drm/amd/display: pass calculated dram_speed_mts to dml2
Date: Mon,  5 May 2025 18:11:17 -0400
Message-Id: <20250505221419.2672473-461-sashal@kernel.org>
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
index d9e63c4fdd95c..17d0b4923b0cc 100644
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


