Return-Path: <stable+bounces-77292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A88985B7F
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF76FB24A98
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708FE1BF80D;
	Wed, 25 Sep 2024 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyUZdst3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E514184538;
	Wed, 25 Sep 2024 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265015; cv=none; b=oSuKj8aOlL2VVg3dAIavR52XGuG4NHx71je1GJihF1ksOz9WdgA1YtDwhCFGTuJAqO366IeU3kWj+NCLjcJzU9JUREPcClnqJ0RaR4sUX2+PCbH84SRzr9hcOczC5W+VVRPIroPjJaC1qpyUidvUvJkuNQoG9hvGSoMErCgCk4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265015; c=relaxed/simple;
	bh=lw4Lfqx1k+k9pvCiV4drdU+7jyHe71CV9Nn//3wN524=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ht5TI2wngFpihDpzZsEC/QTrfdIXuT/H1FIpo/gmx1xIpW9422d1/oigtqTv+4kLsU0USNg3Cp7dxt+Uezm1lvjmvbFYNIg3ArUTXQD/hVi3Le06W2yt34W281YvTFAuatGducnQAjVTmEjrZggKGL31kLE8dkqAJVhhf1iJa+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyUZdst3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4726C4CEC3;
	Wed, 25 Sep 2024 11:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265014;
	bh=lw4Lfqx1k+k9pvCiV4drdU+7jyHe71CV9Nn//3wN524=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KyUZdst3q49QeF7uhuCh5MQygSpfbZpnEDXmoiGdZm/Qwcbqvd5kVBGx6aCQAXQE3
	 3GNBsrmnWHJydvr72C0/7l9YulZ9h30XpWXyxyHV3hZ3xm4Kd2znqzDhlkzFdvVvPe
	 GB7kekZOrMGJWFZ8wGgaqNtWNK0tVkIYdbb13rCAfZxXsUezHkN1jFNz2AY3vmR5ap
	 qbdhL5l0svFkqa6zg3ocWp3HGvzRVgcL41XEthzzU+xIUO/BDI9WryS8dq9+RLIJR6
	 u+pTvQgaej1gzZpSfwNysrukDg/N79Pft2TyUCp5YMYp0Y8xk5l6B/j8iAlzn0VURz
	 8XJbOGbVDb3wQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	roman.li@amd.com,
	hersenxs.wu@amd.com,
	george.shen@amd.com,
	stylon.wang@amd.com,
	allen.pan@amd.com,
	meenakshikumar.somasundaram@amd.com,
	michael.strauss@amd.com,
	aric.cyr@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 194/244] drm/amd/display: Avoid overflow assignment in link_dp_cts
Date: Wed, 25 Sep 2024 07:26:55 -0400
Message-ID: <20240925113641.1297102-194-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit a15268787b79fd183dd526cc16bec9af4f4e49a1 ]

sampling_rate is an uint8_t but is assigned an unsigned int, and thus it
can overflow. As a result, sampling_rate is changed to uint32_t.

Similarly, LINK_QUAL_PATTERN_SET has a size of 2 bits, and it should
only be assigned to a value less or equal than 4.

This fixes 2 INTEGER_OVERFLOW issues reported by Coverity.

Signed-off-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h                  | 2 +-
 drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c | 3 ++-
 drivers/gpu/drm/amd/display/include/dpcd_defs.h               | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 519c3df78ee5b..95c275bf649bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -727,7 +727,7 @@ struct dp_audio_test_data_flags {
 struct dp_audio_test_data {
 
 	struct dp_audio_test_data_flags flags;
-	uint8_t sampling_rate;
+	uint32_t sampling_rate;
 	uint8_t channel_count;
 	uint8_t pattern_type;
 	uint8_t pattern_period[8];
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index df3781081da7a..32d5a4b143333 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -775,7 +775,8 @@ bool dp_set_test_pattern(
 			core_link_read_dpcd(link, DP_TRAINING_PATTERN_SET,
 					    &training_pattern.raw,
 					    sizeof(training_pattern));
-			training_pattern.v1_3.LINK_QUAL_PATTERN_SET = pattern;
+			if (pattern <= PHY_TEST_PATTERN_END_DP11)
+				training_pattern.v1_3.LINK_QUAL_PATTERN_SET = pattern;
 			core_link_write_dpcd(link, DP_TRAINING_PATTERN_SET,
 					     &training_pattern.raw,
 					     sizeof(training_pattern));
diff --git a/drivers/gpu/drm/amd/display/include/dpcd_defs.h b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
index aee5170f5fb23..c246235e4afec 100644
--- a/drivers/gpu/drm/amd/display/include/dpcd_defs.h
+++ b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
@@ -76,6 +76,7 @@ enum dpcd_phy_test_patterns {
 	PHY_TEST_PATTERN_D10_2,
 	PHY_TEST_PATTERN_SYMBOL_ERROR,
 	PHY_TEST_PATTERN_PRBS7,
+	PHY_TEST_PATTERN_END_DP11 = PHY_TEST_PATTERN_PRBS7,
 	PHY_TEST_PATTERN_80BIT_CUSTOM,/* For DP1.2 only */
 	PHY_TEST_PATTERN_CP2520_1,
 	PHY_TEST_PATTERN_CP2520_2,
-- 
2.43.0


