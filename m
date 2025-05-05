Return-Path: <stable+bounces-140071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E06A0AAA4B9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBBD188D555
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8193D303996;
	Mon,  5 May 2025 22:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E347JLw9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA69303975;
	Mon,  5 May 2025 22:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484034; cv=none; b=IK/rcduRMG/PBQlJNWpV8gPOeyBsJ0QM+RjcSMPo7430HeLboqrnAmk36HmSsA4Z5Hy1fFZJ2sIEn4q3iyWfJgtoQt4lD4zuKbnzKDDNc8q5n83bYeup6eApAMwKSzigyhQo5aMnHmOZMuY+ykR3a7JS78Qe1c23cs+hKZxhlWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484034; c=relaxed/simple;
	bh=cwwy7ThZb060HYnIL/EA0tFwjYPMkNg6CpL/qdWLBXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lT20Jc0kCnw6pxTuFtIRk7tDbMkgutaaufM4DI7k447qfWW6Hrn9GxK9vaSpkuih5qi51fRrunajt4n93ERTNABywCrKjuI0L/44MNAxSsIk0z/B5NcKQ6uN1D6veIggSXZhmLNlihWgx+HA2GM2C/sNn1Pw6Y9JYdPp8emFsyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E347JLw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057C9C4CEE4;
	Mon,  5 May 2025 22:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484034;
	bh=cwwy7ThZb060HYnIL/EA0tFwjYPMkNg6CpL/qdWLBXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E347JLw9BVSHFYKLHFKPu6ZYRfVxzVX6Hx33UwIJr2L3gbxKnGalCLQEuOsZP/sp1
	 cqGvVhT5VCtXxotV1iOr7+NoAoRBzee25PF2LK5PmZwP4LjFoSOzPRLHOWzZv96y3r
	 iwWxd/aIsUwCYY54dA6fZUxIIxgWom2UlnexqD/B4mnHKL2Xl9xytJMp5vhLBD3nxR
	 U4QSxD3CouKO1K37sodeq9OHfhJUVbCkUOS1L/5Uf93SFCB9pCBJiGqwYs8DtDB2BY
	 O+ju9Lcu4OgIh/EK5KKsuP3eaUoqMtYZntEcJa7k+2muZcDseaRLCUu1rMsUejELki
	 t6teECdx8ZRiw==
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
Subject: [PATCH AUTOSEL 6.14 324/642] drm/amd/display: Fix mismatch type comparison
Date: Mon,  5 May 2025 18:09:00 -0400
Message-Id: <20250505221419.2672473-324-sashal@kernel.org>
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
index 18b423bd302a7..22602f088553d 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -963,8 +963,8 @@ static bool spl_get_optimal_number_of_taps(
 	  bool *enable_isharp)
 {
 	int num_part_y, num_part_c;
-	int max_taps_y, max_taps_c;
-	int min_taps_y, min_taps_c;
+	unsigned int max_taps_y, max_taps_c;
+	unsigned int min_taps_y, min_taps_c;
 	enum lb_memory_config lb_config;
 	bool skip_easf = false;
 	bool is_subsampled = spl_is_subsampled_format(spl_in->basic_in.format);
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
index 467af9dd90ded..5d139cf51e89b 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
@@ -484,7 +484,7 @@ struct spl_sharpness_range {
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


