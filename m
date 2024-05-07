Return-Path: <stable+bounces-43365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F6D8BF21D
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D911C20819
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EB9137C21;
	Tue,  7 May 2024 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljw5oF0b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7766E137935;
	Tue,  7 May 2024 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123509; cv=none; b=bLyG6VTzB2dyxEpGcMFWECpx8M+tnAKOc7hLl0cNaAJMQNrCA8XJTFyAXOY7P9M28TbmFCiwQEvdhic82UkwP17Cb7yr9tH//Zq9G/JPYSHgVD7r7t5RcxBJWW1/+CBg3smLXZ0NH6G3RdteoqkmeWxoZi3s/3yOW9ieB/nY6g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123509; c=relaxed/simple;
	bh=VQPRs9iLz4D7n1G+GMh7JP1p2fCzmiocS/p2Lg0AXeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5/N4W0ZExjEI5g9tmZXVVGgzatVQmmVkMt06sugvEfaeBjXqSdDJnrwWo7ZAzgvja9Q31d7yRR1S+s6868KmhFAI1DPv7cA3pS9uwTFqJu8AWLr0dFwCVNN53YrHV046MYRoOhLxfDUSO6h1ldjm6x/P4tJ1mVpfVWalfb6jVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljw5oF0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED27C2BBFC;
	Tue,  7 May 2024 23:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123509;
	bh=VQPRs9iLz4D7n1G+GMh7JP1p2fCzmiocS/p2Lg0AXeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ljw5oF0brBQNbj+QIc0FPs9W3kpo/afUpCR7sdXT2EXI9suPrmNJ/QFIkaZj/0U2E
	 plIAblLsBSlTXeo2wAXOMwhaz43heNuLYau0Hqn15yMvLmORMwTODykLn+4IZHfK3o
	 8eV4tav51+tvHMCEXpJkm6yg3XZgXqKKl4ofWWe0GpPCHsQrDLlL2B5CEnwGsxBDzX
	 etdWSJPlw4jdUvQE8lbnQpLDdrffMjydchrheIYaNPUTLfRspDqk8KqeHqi+c7hgsw
	 Mm224kqgnCmtQz2K0p/iwM65uYp5LBu6R3bx6zKb4+rWEvPuVfe04gfH+owvM2xT/H
	 fTUP9DQDSNsuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leo Ma <hanghong.ma@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	stylon.wang@amd.com,
	samson.tam@amd.com,
	relja.vojvodic@amd.com,
	etbitnun@amd.com,
	qingqing.zhuo@amd.com,
	charlene.liu@amd.com,
	wenjing.liu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 33/43] drm/amd/display: Fix DC mode screen flickering on DCN321
Date: Tue,  7 May 2024 19:09:54 -0400
Message-ID: <20240507231033.393285-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Leo Ma <hanghong.ma@amd.com>

[ Upstream commit ce649bd2d834db83ecc2756a362c9a1ec61658a5 ]

[Why && How]
Screen flickering saw on 4K@60 eDP with high refresh rate external
monitor when booting up in DC mode. DC Mode Capping is disabled
which caused wrong UCLK being used.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Leo Ma <hanghong.ma@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index e9345f6554dbc..2428a4763b85f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -547,8 +547,12 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 					 * since we calculate mode support based on softmax being the max UCLK
 					 * frequency.
 					 */
-					dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-							dc->clk_mgr->bw_params->dc_mode_softmax_memclk);
+					if (dc->debug.disable_dc_mode_overwrite) {
+						dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK, dc->clk_mgr->bw_params->max_memclk_mhz);
+						dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, dc->clk_mgr->bw_params->max_memclk_mhz);
+					} else
+						dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
+								dc->clk_mgr->bw_params->dc_mode_softmax_memclk);
 				} else {
 					dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, dc->clk_mgr->bw_params->max_memclk_mhz);
 				}
@@ -581,8 +585,13 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		/* set UCLK to requested value if P-State switching is supported, or to re-enable P-State switching */
 		if (clk_mgr_base->clks.p_state_change_support &&
 				(update_uclk || !clk_mgr_base->clks.prev_p_state_change_support) &&
-				!dc->work_arounds.clock_update_disable_mask.uclk)
+				!dc->work_arounds.clock_update_disable_mask.uclk) {
+			if (dc->clk_mgr->dc_mode_softmax_enabled && dc->debug.disable_dc_mode_overwrite)
+				dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK,
+						max((int)dc->clk_mgr->bw_params->dc_mode_softmax_memclk, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz)));
+
 			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
+		}
 
 		if (clk_mgr_base->clks.num_ways != new_clocks->num_ways &&
 				clk_mgr_base->clks.num_ways > new_clocks->num_ways) {
-- 
2.43.0


