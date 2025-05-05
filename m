Return-Path: <stable+bounces-141423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 045A6AAB6E8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E7E17AD2E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D938230BC7;
	Tue,  6 May 2025 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhzix/WR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6045394A2F;
	Mon,  5 May 2025 23:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486251; cv=none; b=b3nLZq3j6ZeGVRv69+EtdlLG7oPDLZRuKSigOcFXf24GnvzwMXps/b7wASDBETAIkw7+fhLZIHGxCHhW0MzV7yXxuQXAb2ndnvWyrIp4vercAu6qzfd+DdFGUgfHUHP8wwX8xan2sma8VS1SHiBjyAdLkpyue5gKHcs2ELXZEY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486251; c=relaxed/simple;
	bh=j1d6PGAovfWjZXGpNBEcrGcaxLqhxtXiaVSrR4lXUYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LTBjbhVy/2H5a6nh6zNPr88c3bGnmSBkjk4jHlbNyCy8nTASKkAZ67Kq23kTVLRKw7AR0rKQk2hsytVBWaLrorkb+Re6gJAzGT09ugdUINLHqWGh3iSw5aEq8ZUn590F9J9nw5ibakbt/ITpiZfdFNkjtUnzBVtxJfB7akI3Z5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhzix/WR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE4CC4CEE4;
	Mon,  5 May 2025 23:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486249;
	bh=j1d6PGAovfWjZXGpNBEcrGcaxLqhxtXiaVSrR4lXUYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lhzix/WRs+bHm5ducwt0JVemXoqvSw7skFBF8XgyhueCvlgMfiWZlrvz0001h1Yfs
	 lj5NcupoJjQkvLjh/qeaoYlcynQ0pAcGfQ/h1I6nRguySWHyiIR/x6yK398UUGSEYu
	 4LnKgU3YmwRXL0TmsAlQwSnlI5n+PMIF89Ic5ooX9kYQBRPBfg0SPW3Z6rxcFtNO64
	 4wwzuwFVmjthIOlF4JAEGYHTdughCPaZFLXJeiJo3YW5qRMf2E5h4BPki++UlOmjUh
	 h9IW6WevfTaBFWbXbty2K1q31xBIsGn3xKrx6FOhZgJ6HANVLRSS1ROrSivSO2Mns0
	 UpO2LO+qf6ANA==
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
	PeiChen.Huang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 225/294] drm/amd/display: Update CR AUX RD interval interpretation
Date: Mon,  5 May 2025 18:55:25 -0400
Message-Id: <20250505225634.2688578-225-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 2b4c15b0b4070..52261e7c11c0b 100644
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


