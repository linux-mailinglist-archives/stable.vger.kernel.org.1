Return-Path: <stable+bounces-147465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BB7AC57C4
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899777AF764
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3EC280032;
	Tue, 27 May 2025 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ox0eJeCk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99F280008;
	Tue, 27 May 2025 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367424; cv=none; b=NQD2+sWpB5Gfpjs2rUude/fL2WuLZbiS0SGGPXjyaay7pQfn+aGgS2RERVJ4+Z69/EZOKnNm6jwkex9k0Mz3eDsiSLAWtgdX8jfH2pYQj0NaPBxqsP9BXyPWMSPAy4QlqfxGQoN/g5/BVT5Z4wzwt9JqQgApaaevjyTtJQCXMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367424; c=relaxed/simple;
	bh=4+P1fOmzmPubONmzBhS6cakFm5AR89cX58XNsvXJfMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NO5S3QpcuO6fyIVLwkvnuErfI44ROjCmLwOcZnwanS308jx4sqJaR9W1TapR56pKqCvB7DwIBRhbBW3LbnbZjXaWjCrHMJhXR+QNgAZRdbu+41vFt8+aYSFLmKkDL36noaWPh0V8buI4ZMSFT6F1AsyfKgqjif+v0lneUwaaLzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ox0eJeCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1026C4CEF3;
	Tue, 27 May 2025 17:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367424;
	bh=4+P1fOmzmPubONmzBhS6cakFm5AR89cX58XNsvXJfMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ox0eJeCkKK8qJDJhrGSLVbdBiSv7ZdQqmLzRbm9/4gN2//100O00jciviHXRXxnkf
	 87mC4WZhyvFw6EUPQnjPGgaqnabEZsNVLqNOh5XzlOVmxIhpsCVTGvQzJ+yxR89uI4
	 vEo26luspaqqCE8uFc3SFaanb6nrlK7aurFglyjo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Navid Assadian <navid.assadian@amd.com>,
	Joshua Aberback <joshua.aberback@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 353/783] drm/amd/display: Fix mismatch type comparison
Date: Tue, 27 May 2025 18:22:30 +0200
Message-ID: <20250527162527.444810483@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Assadian, Navid <navid.assadian@amd.com>

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




