Return-Path: <stable+bounces-141144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E5EAAB0CD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2A84E2FC6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D6F2BF969;
	Tue,  6 May 2025 00:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TChQ+91U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F252BEC29;
	Mon,  5 May 2025 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485292; cv=none; b=n75jBQ0OF8eyWHxs0PWnfcM+Xw6u02NL2xCO4W+KT5EF7OMkKWIpqUD6BdYUkfjrxg5eR+6uxyR0U1BbL+m4jaG7CAy4O0JBWgPV58aGphpAzsYc6gf/X3ikc6vFaAecNBjr7s8l+0v7NPZPZ/4n83IQconNRA292XfI+vztlkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485292; c=relaxed/simple;
	bh=2gj39A3TJv/FRCdouiOH4XPaP1noapFKSqMjh5lbozI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eFJ2R0eerDetIx7qRye4MLwS3gjQItjvS/Pw0KViuU43AKzdzBe2j3GchzLOz5eT6SJbe6FTG6m4ksBSOiWBzsWAuroX2YnLwih0UMNuQEYuIhJREk6oSUIb7Yux3IoyPlCHndJUw+yzfnK6tOqyJMjc/gbTTERRikiJEsPRoSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TChQ+91U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13F8C4CEE4;
	Mon,  5 May 2025 22:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485292;
	bh=2gj39A3TJv/FRCdouiOH4XPaP1noapFKSqMjh5lbozI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TChQ+91UuMlH/VgfCFmOABM40/Bq6Qvq7398fqv0Ct8apcgBsqPbcXxj6//5SivAI
	 PkZ1s5Ec/WDXPeAQMl4Mx0neod2WL1TbdARhoLrMNAbE7pzv2rtXgwk9Z8JTDUYBdw
	 69Ralg7vVXgpz31QfR29GkclDg7MndmcC++yZhYMqGnCWYTHV94aA0LMYguV3drbEC
	 H+lUkhqIBZcGmcjvbTW5DxmQvWTmGuZFavULnEergNl9QtHozLT20QdeJ7JnBq86o7
	 Ed+hK/NYyt2nvUqs6NWw3scA5DmpMpxenzMd1/9BiFaTNbTnvgGHAepC07e651W1CN
	 imvhOz+gLToOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Assadian, Navid" <navid.assadian@amd.com>,
	Joshua Aberback <joshua.aberback@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Samson.Tam@amd.com,
	jun.lei@amd.com,
	alex.hung@amd.com,
	wenjing.liu@amd.com,
	Relja.Vojvodic@amd.com,
	rodrigo.siqueira@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 254/486] drm/amd/display: Fix mismatch type comparison
Date: Mon,  5 May 2025 18:35:30 -0400
Message-Id: <20250505223922.2682012-254-sashal@kernel.org>
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

From: "Assadian, Navid" <navid.assadian@amd.com>

[ Upstream commit 26873260d394b1e33cdd720154aedf0af95327f9 ]

The mismatch type comparison/assignment may cause data loss. Since the
values are always non-negative, it is safe to use unsigned variables to
resolve the mismatch.

Signed-off-by: Navid Assadian <navid.assadian@amd.com>
Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c       | 4 ++--
 drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index 014e8a296f0c7..54c7d6aecf51c 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -875,8 +875,8 @@ static bool spl_get_optimal_number_of_taps(
 	  bool *enable_isharp)
 {
 	int num_part_y, num_part_c;
-	int max_taps_y, max_taps_c;
-	int min_taps_y, min_taps_c;
+	unsigned int max_taps_y, max_taps_c;
+	unsigned int min_taps_y, min_taps_c;
 	enum lb_memory_config lb_config;
 	bool skip_easf = false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
index 2a74ff5fdfdbc..a2c28949ec47f 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
@@ -479,7 +479,7 @@ struct spl_sharpness_range {
 };
 struct adaptive_sharpness {
 	bool enable;
-	int sharpness_level;
+	unsigned int sharpness_level;
 	struct spl_sharpness_range sharpness_range;
 };
 enum linear_light_scaling	{	// convert it in translation logic
-- 
2.39.5


