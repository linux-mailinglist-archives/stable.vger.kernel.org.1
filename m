Return-Path: <stable+bounces-140073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EC4AAA4AC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE8316CAE2
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1724304254;
	Mon,  5 May 2025 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A71IClI+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCC6304249;
	Mon,  5 May 2025 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484047; cv=none; b=upBbq8wlM5gbDC3pr/PAcHf8QdY13nhGHVN47xWlagKhn6iD+tplpdsbDxUwNPRq9TGDHdwVzeyENhlNEbWGlrAOgUqi/1vFQFQVT6CIXQa0A0D4yBbRRDx8NjngZJE9cx/k0sOtmRB4iJ14ST36AX+OpDem+srKS35yZPf/w64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484047; c=relaxed/simple;
	bh=sxQ2MLzHhB6df/tTg4DZmAMx/JS+RzR7fiNkcK9woXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kHJDA65x620zM17c/7/R8f9Y6GCjBVLUIApqLy2DmzXe7PTc0TsIn3XsH59SWyvIR0kJJyLnkT3aylumYPoFcTKtDO37w0hfYFCxmsU5EAdfeVE/LcTfE9asFeIdFqJkhHPJIaIe/jS9K6/9iz8tbGJJKkvRt04FqgeQlNUFcYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A71IClI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A24C4CEED;
	Mon,  5 May 2025 22:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484047;
	bh=sxQ2MLzHhB6df/tTg4DZmAMx/JS+RzR7fiNkcK9woXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A71IClI+81P4X1DkvaAh0dvmG5fCFrfn6kYJJnU/wojdh73CyScuGERoEbEa9j/Kj
	 y4/0wTlvEom6bwa8MWFQSUeSsmYlAi54mNLuCVF5ImCP3/gIUXhTkWuOgd40bfore+
	 GDVEmrhz2AhFT2ObbHzkkB83ya0yh5+DRBq1ndLPv2PeULJlslT7zYeqh7izbhJTXY
	 LRA+10r8wy1KBMfakFaZyi46O6heVtxntGl31XfHiHO2IWqFSrP8rcFnTQeHqmz8pY
	 sU6ZT18ZBfYfPW+g3jWJub3YNxShvxgdzjMPuq7jaeTR3w3noMivcTdPYvFh9EEfuG
	 eR/2aYbo2Pang==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Samson Tam <Samson.Tam@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	zaeem.mohamed@amd.com,
	aurabindo.pillai@amd.com,
	jun.lei@amd.com,
	ivlipski@amd.com,
	alex.hung@amd.com,
	relja.vojvodic@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 326/642] drm/amd/display: Fix mismatch type comparison in custom_float
Date: Mon,  5 May 2025 18:09:02 -0400
Message-Id: <20250505221419.2672473-326-sashal@kernel.org>
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

[ Upstream commit 86f06bcbb54e93f3c7b5e22ae37e72882b74c4b0 ]

[Why & How]
Passing uint into uchar function param.  Pass uint instead

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c | 2 +-
 drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c b/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
index 131f1e3949d33..52d97918a3bd2 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
@@ -346,7 +346,7 @@ struct spl_fixed31_32 spl_fixpt_exp(struct spl_fixed31_32 arg)
 		if (m > 0)
 			return spl_fixpt_shl(
 				spl_fixed31_32_exp_from_taylor_series(r),
-				(unsigned char)m);
+				(unsigned int)m);
 		else
 			return spl_fixpt_div_int(
 				spl_fixed31_32_exp_from_taylor_series(r),
diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.h b/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.h
index ed2647f9a0999..9f349ffe91485 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.h
@@ -189,7 +189,7 @@ static inline struct spl_fixed31_32 spl_fixpt_clamp(
  * @brief
  * result = arg << shift
  */
-static inline struct spl_fixed31_32 spl_fixpt_shl(struct spl_fixed31_32 arg, unsigned char shift)
+static inline struct spl_fixed31_32 spl_fixpt_shl(struct spl_fixed31_32 arg, unsigned int shift)
 {
 	SPL_ASSERT(((arg.value >= 0) && (arg.value <= LLONG_MAX >> shift)) ||
 		((arg.value < 0) && (arg.value >= ~(LLONG_MAX >> shift))));
@@ -203,7 +203,7 @@ static inline struct spl_fixed31_32 spl_fixpt_shl(struct spl_fixed31_32 arg, uns
  * @brief
  * result = arg >> shift
  */
-static inline struct spl_fixed31_32 spl_fixpt_shr(struct spl_fixed31_32 arg, unsigned char shift)
+static inline struct spl_fixed31_32 spl_fixpt_shr(struct spl_fixed31_32 arg, unsigned int shift)
 {
 	bool negative = arg.value < 0;
 
-- 
2.39.5


