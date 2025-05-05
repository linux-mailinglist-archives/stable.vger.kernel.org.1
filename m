Return-Path: <stable+bounces-140219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0ECAAA64A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B466F7B5EDB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF87028F957;
	Mon,  5 May 2025 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8ed1eZH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7D327B50B;
	Mon,  5 May 2025 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484401; cv=none; b=fa9obJLiwMLHjByzIAWSyc10aFXZCZ7KDsoM6AqibEwDFDO97jyU8Z1YluAvI4NssXyTL9No3iEHxmSXRxou9rhYnx990mNKB99T6MUTMqFmBG2LoYoQ0k8SLVWZPG0e82HXw411+9ev7fP2YbRt/KqnSH4OFRks1PfWMgVUxnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484401; c=relaxed/simple;
	bh=II0+gCSOLa6r7EPGRSZL2qEFTLnBnuZXoGZUfo9fuTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tS/wdNqhhsHhZmf1m24pwXYvV8EulwbkXuJz+LGcbE4NaioMyXLMc9cDsYS2oraHCEkKG0+wcjisa0AToP+jwiZWTQhs5pLs7oN2JgVqDUjjgvjymLrjLCQh7ckBTdOIYYZ1tjgPI2EeFCPvnnyQLHvSYkXgQ9lK84lFCNczAGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8ed1eZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE391C4CEE4;
	Mon,  5 May 2025 22:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484401;
	bh=II0+gCSOLa6r7EPGRSZL2qEFTLnBnuZXoGZUfo9fuTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T8ed1eZHV8ZiF386TZT5D4u0lgE/lbDJqgx81HT5NoPtD0UNojGW6zQb9q6FrrJpP
	 Hr3CpZnvkyZhfUfVAZmh9F8YdaqHxmeQtm96oQh2bM0LKI7YL5WNRBjphEriRu2vnB
	 r70oVq2O94pcdZaGjv+3Uhug5tThUQQ4YP+VMpMeBE5WpDF7DTa+A7b3DLKgcG/Cxd
	 OSto54ozXtaShbl62wC4fvo21GiQVJX961C+NO33+kCm9O9fSGFkWsKVkj9cd09qRJ
	 1Zpr5kDc03lJlj4Iogm/RWAM0WAMCRJGGqBRSu53JnJvoUHU7OUFoNZoHnADOO3s1P
	 uUpQg/pZ4Rdow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: George Shen <george.shen@amd.com>,
	Michael Strauss <michael.strauss@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	meenakshikumar.somasundaram@amd.com,
	PeiChen.Huang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 471/642] drm/amd/display: Update CR AUX RD interval interpretation
Date: Mon,  5 May 2025 18:11:27 -0400
Message-Id: <20250505221419.2672473-471-sashal@kernel.org>
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

From: George Shen <george.shen@amd.com>

[ Upstream commit 6a7fde433231c18164c117592d3e18ced648ad58 ]

[Why]
DP spec updated to have the CR AUX RD interval match the EQ AUX RD
interval interpretation of DPCD 0000Eh/0220Eh for 8b/10b non-LTTPR mode
and LTTPR transparent mode cases.

[How]
Update interpretation of DPCD 0000Eh/0220Eh for CR AUX RD interval
during 8b/10b link training.

Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../display/dc/link/protocols/link_dp_training_8b_10b.c    | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
index 3bdce32a85e3c..ae95ec48e5721 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
@@ -36,7 +36,8 @@
 	link->ctx->logger
 
 static int32_t get_cr_training_aux_rd_interval(struct dc_link *link,
-		const struct dc_link_settings *link_settings)
+		const struct dc_link_settings *link_settings,
+		enum lttpr_mode lttpr_mode)
 {
 	union training_aux_rd_interval training_rd_interval;
 	uint32_t wait_in_micro_secs = 100;
@@ -49,6 +50,8 @@ static int32_t get_cr_training_aux_rd_interval(struct dc_link *link,
 				DP_TRAINING_AUX_RD_INTERVAL,
 				(uint8_t *)&training_rd_interval,
 				sizeof(training_rd_interval));
+		if (lttpr_mode != LTTPR_MODE_NON_TRANSPARENT)
+			wait_in_micro_secs = 400;
 		if (training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL)
 			wait_in_micro_secs = training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL * 4000;
 	}
@@ -110,7 +113,6 @@ void decide_8b_10b_training_settings(
 	 */
 	lt_settings->link_settings.link_spread = link->dp_ss_off ?
 			LINK_SPREAD_DISABLED : LINK_SPREAD_05_DOWNSPREAD_30KHZ;
-	lt_settings->cr_pattern_time = get_cr_training_aux_rd_interval(link, link_setting);
 	lt_settings->eq_pattern_time = get_eq_training_aux_rd_interval(link, link_setting);
 	lt_settings->pattern_for_cr = decide_cr_training_pattern(link_setting);
 	lt_settings->pattern_for_eq = decide_eq_training_pattern(link, link_setting);
@@ -119,6 +121,7 @@ void decide_8b_10b_training_settings(
 	lt_settings->disallow_per_lane_settings = true;
 	lt_settings->always_match_dpcd_with_hw_lane_settings = true;
 	lt_settings->lttpr_mode = dp_decide_8b_10b_lttpr_mode(link);
+	lt_settings->cr_pattern_time = get_cr_training_aux_rd_interval(link, link_setting, lt_settings->lttpr_mode);
 	dp_hw_to_dpcd_lane_settings(lt_settings, lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 }
 
-- 
2.39.5


