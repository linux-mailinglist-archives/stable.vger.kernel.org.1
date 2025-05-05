Return-Path: <stable+bounces-140210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6776AAA64E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADC83A4C41
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB8527B4F6;
	Mon,  5 May 2025 22:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEwiGfgE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC788289FCF;
	Mon,  5 May 2025 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484355; cv=none; b=KB/E4ecnfIaEbIcoSxrWHzuih6iu1x/fGVPdH+6nVvs7lVbl7CJrFalOufOP7iZnblWyYYzYqnkHPwM9On5SWEGA6JLZEB66T6zGNYxaQOBwumBOo1+nZGknvUI2Pj+0o8JoAKBXmGZw2g+ilqcXheeOv+oyiGv6nDMlyq+ovsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484355; c=relaxed/simple;
	bh=IA7GbYYuCSC/XkC216binQY5ZuoP5+yntdksd1y0aWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OabpDierXt0EZM1zG4a5bUl2F0CeDXseUHJr8CLrFRGSS3SclpczbEfYh5AWsJmrvA+WGjVV9EL2/ldfbVcL1e4OCiL4yqH/NLprxD5J95ePHp5wE0qRrg7sB4dk2c3Kk2lAWGrMRmz07vkGN6Ucgc1SbDHkDsaVrrTckMfwn+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEwiGfgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBE0C4CEED;
	Mon,  5 May 2025 22:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484354;
	bh=IA7GbYYuCSC/XkC216binQY5ZuoP5+yntdksd1y0aWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oEwiGfgEGD8jyqcdSWgoOgK2zpPW4dfYm2acjFf1w84MMWdutbNeQUmdGZMAYTtQg
	 +dQlD4J1H3es8uXd/tY8r+yH+KUaLMjNl624/FupBT8/XBeYbjrPOIcPH8R6Q9E4vK
	 faXj2xKPtpWO27p6KbQzHCrsdfHQu7uGTfXGknqNlXrW49rPPLld7FCwrsN7bwKCBp
	 bnYIdM9LkwG3lUuMB6gO3RCe3F84edHfNePr9PKKIrsl00GbZr9eLmJnrycrV1+oOh
	 DPmytg4OwOmMae9j++R57a9ryHLM/gOzZDyVqoYpUQWsEgxMS+JtKiGqXtN1V5vl3x
	 wd6nDUCAm2UsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Samson Tam <Samson.Tam@amd.com>,
	Navid Assadian <navid.assadian@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	jun.lei@amd.com,
	alex.hung@amd.com,
	Relja.Vojvodic@amd.com,
	wenjing.liu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 462/642] drm/amd/display: remove TF check for LLS policy
Date: Mon,  5 May 2025 18:11:18 -0400
Message-Id: <20250505221419.2672473-462-sashal@kernel.org>
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

From: Samson Tam <Samson.Tam@amd.com>

[ Upstream commit 2a4519c4e9b2e1f622ab4c5f5841abdb9760cb0b ]

[Why & How]
LLS policy not affected by TF.
Remove check in don't care case and use
 pixel format only.

Reviewed-by: Navid Assadian <navid.assadian@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c | 31 +++++----------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index 153b7a8904e1e..047f05ab01810 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -784,25 +784,13 @@ static enum scl_mode spl_get_dscl_mode(const struct spl_in *spl_in,
 	return SCL_MODE_SCALING_420_YCBCR_ENABLE;
 }
 
-static bool spl_choose_lls_policy(enum spl_pixel_format format,
-	enum spl_transfer_func_type tf_type,
-	enum spl_transfer_func_predefined tf_predefined_type,
+static void spl_choose_lls_policy(enum spl_pixel_format format,
 	enum linear_light_scaling *lls_pref)
 {
-	if (spl_is_video_format(format)) {
+	if (spl_is_subsampled_format(format))
 		*lls_pref = LLS_PREF_NO;
-		if ((tf_type == SPL_TF_TYPE_PREDEFINED) ||
-			(tf_type == SPL_TF_TYPE_DISTRIBUTED_POINTS))
-			return true;
-	} else { /* RGB or YUV444 */
-		if ((tf_type == SPL_TF_TYPE_PREDEFINED) ||
-			(tf_type == SPL_TF_TYPE_BYPASS)) {
-			*lls_pref = LLS_PREF_YES;
-			return true;
-		}
-	}
-	*lls_pref = LLS_PREF_NO;
-	return false;
+	else /* RGB or YUV444 */
+		*lls_pref = LLS_PREF_YES;
 }
 
 /* Enable EASF ?*/
@@ -811,7 +799,6 @@ static bool enable_easf(struct spl_in *spl_in, struct spl_scratch *spl_scratch)
 	int vratio = 0;
 	int hratio = 0;
 	bool skip_easf = false;
-	bool lls_enable_easf = true;
 
 	if (spl_in->disable_easf)
 		skip_easf = true;
@@ -827,17 +814,13 @@ static bool enable_easf(struct spl_in *spl_in, struct spl_scratch *spl_scratch)
 		skip_easf = true;
 
 	/*
-	 * If lls_pref is LLS_PREF_DONT_CARE, then use pixel format and transfer
-	 *  function to determine whether to use LINEAR or NONLINEAR scaling
+	 * If lls_pref is LLS_PREF_DONT_CARE, then use pixel format
+	 *  to determine whether to use LINEAR or NONLINEAR scaling
 	 */
 	if (spl_in->lls_pref == LLS_PREF_DONT_CARE)
-		lls_enable_easf = spl_choose_lls_policy(spl_in->basic_in.format,
-			spl_in->basic_in.tf_type, spl_in->basic_in.tf_predefined_type,
+		spl_choose_lls_policy(spl_in->basic_in.format,
 			&spl_in->lls_pref);
 
-	if (!lls_enable_easf)
-		skip_easf = true;
-
 	/* Check for linear scaling or EASF preferred */
 	if (spl_in->lls_pref != LLS_PREF_YES && !spl_in->prefer_easf)
 		skip_easf = true;
-- 
2.39.5


