Return-Path: <stable+bounces-110513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89809A1C9AF
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEFD3A808C
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C517176AC5;
	Sun, 26 Jan 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkvbdKnY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3291C1A0BF8;
	Sun, 26 Jan 2025 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903233; cv=none; b=nLq6e+H2e3MCnvK2ArOEDsrYgJA4DZKzBV/NKHzFM2c33zKgM8s3fpkJXXTnPmGgiQsehpSKQHRo+T2WJ2/5heClRja2tgnKvfAoKxodTqkG1s4rRFhUx0lE7d/GEf4tLkSwm/Gw6cUFAzBO1+dURciFJl1JXNk28TROuUEre7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903233; c=relaxed/simple;
	bh=XKGfn4HN9PdLr93dYM6sHItaHU5f7ZdT7XRVtQ3vWxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mhLQj9EUhosvxi7bMoQ8deK4gqIBpaxobaCkuHOx0yBF4ziRmd67xJ4xkbS2NPdQx8bj5MBeXcXIvz7ojh7ROEIQ6FTdqqZFQ1F8/CDIpK6+FKs1s4ForMVNVQJM/+V6ByAvLNt54EU3MHf31vF/id3XQHsoNrSQYu9II+8LGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkvbdKnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB7CC4CEE3;
	Sun, 26 Jan 2025 14:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903232;
	bh=XKGfn4HN9PdLr93dYM6sHItaHU5f7ZdT7XRVtQ3vWxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dkvbdKnYFmxk8VBF6qaA9uLZltWGIf2KPH3y679AoL92vgfSU+YvM3CFoBBXOk8kU
	 UmBjr2Zhfp2os4K+fPMBP1FJXcRFyBM3fQeac4uWIf+aaX7KnVl5Lpv1MK858VGKkn
	 kKuRDXDq4VUksae2XRSiLh5PVCYACyxIFAhRHTk/7tcgvZ5XZyAcEkrMJd7FL+KAZN
	 iE8y1fOqAQVIx11AQtqugGNEvoGR5IVOJQ2woZaJzKC4iHulUD2qjbiKmLtSVCB0jg
	 P98Hz5BY6iudNg/pGWLfZpSu1LC20k09NVhwSSidfo1COinJeeVYoyrwwYhZDeAJAH
	 pyWxm3Ir6ZWmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ausef Yousof <Ausef.Yousof@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	chaitanya.dhere@amd.com,
	jun.lei@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 11/34] drm/amd/display: Overwriting dualDPP UBF values before usage
Date: Sun, 26 Jan 2025 09:52:47 -0500
Message-Id: <20250126145310.926311-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145310.926311-1-sashal@kernel.org>
References: <20250126145310.926311-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Ausef Yousof <Ausef.Yousof@amd.com>

[ Upstream commit 24909d9ec7c3afa8da2f3c9afa312e7a4a61f250 ]

[WHY]
Right now in dml2 mode validation we are calculating UBF parameters for
prefetch calculation for single and dual DPP scenarios. Data structure
to store such values are just 1D arrays, the single DPP values are
overwritten by the dualDPP values, and we end up using dualDPP for
prefetch calculations twice (once in place of singleDPP support check
and again for dual).

This naturally leads to many problems, one of which validating a mode in
"singleDPP" (when we used dual DPP parameters) and sending the singleDPP
parameters to mode programming, if we cannot support then we observe the
corruption as described in the ticket.

[HOW]
UBF values need to have 2d arrays to store values specific to single and
dual DPP states to avoid single DPP values being overwritten. Other
parameters are recorded on a per state basis such as prefetch UBF values
but they are in the same loop used for calculation and at that point its
fine to overwrite them, its not the case for plain UBF values.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/dml2/display_mode_core.c   | 30 +++++++++----------
 .../dc/dml2/display_mode_core_structs.h       |  6 ++--
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index be87dc0f07799..6822b07951204 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -6301,9 +6301,9 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 			mode_lib->ms.meta_row_bandwidth_this_state,
 			mode_lib->ms.dpte_row_bandwidth_this_state,
 			mode_lib->ms.NoOfDPPThisState,
-			mode_lib->ms.UrgentBurstFactorLuma,
-			mode_lib->ms.UrgentBurstFactorChroma,
-			mode_lib->ms.UrgentBurstFactorCursor);
+			mode_lib->ms.UrgentBurstFactorLuma[j],
+			mode_lib->ms.UrgentBurstFactorChroma[j],
+			mode_lib->ms.UrgentBurstFactorCursor[j]);
 
 		s->VMDataOnlyReturnBWPerState = dml_get_return_bw_mbps_vm_only(
 																	&mode_lib->ms.soc,
@@ -6458,9 +6458,9 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 				mode_lib->ms.cursor_bw_pre,
 				mode_lib->ms.prefetch_vmrow_bw,
 				mode_lib->ms.NoOfDPPThisState,
-				mode_lib->ms.UrgentBurstFactorLuma,
-				mode_lib->ms.UrgentBurstFactorChroma,
-				mode_lib->ms.UrgentBurstFactorCursor,
+				mode_lib->ms.UrgentBurstFactorLuma[j],
+				mode_lib->ms.UrgentBurstFactorChroma[j],
+				mode_lib->ms.UrgentBurstFactorCursor[j],
 				mode_lib->ms.UrgentBurstFactorLumaPre,
 				mode_lib->ms.UrgentBurstFactorChromaPre,
 				mode_lib->ms.UrgentBurstFactorCursorPre,
@@ -6517,9 +6517,9 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 						mode_lib->ms.cursor_bw,
 						mode_lib->ms.cursor_bw_pre,
 						mode_lib->ms.NoOfDPPThisState,
-						mode_lib->ms.UrgentBurstFactorLuma,
-						mode_lib->ms.UrgentBurstFactorChroma,
-						mode_lib->ms.UrgentBurstFactorCursor,
+						mode_lib->ms.UrgentBurstFactorLuma[j],
+						mode_lib->ms.UrgentBurstFactorChroma[j],
+						mode_lib->ms.UrgentBurstFactorCursor[j],
 						mode_lib->ms.UrgentBurstFactorLumaPre,
 						mode_lib->ms.UrgentBurstFactorChromaPre,
 						mode_lib->ms.UrgentBurstFactorCursorPre);
@@ -6586,9 +6586,9 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 													mode_lib->ms.cursor_bw_pre,
 													mode_lib->ms.prefetch_vmrow_bw,
 													mode_lib->ms.NoOfDPP[j], // VBA_ERROR DPPPerSurface is not assigned at this point, should use NoOfDpp here
-													mode_lib->ms.UrgentBurstFactorLuma,
-													mode_lib->ms.UrgentBurstFactorChroma,
-													mode_lib->ms.UrgentBurstFactorCursor,
+													mode_lib->ms.UrgentBurstFactorLuma[j],
+													mode_lib->ms.UrgentBurstFactorChroma[j],
+													mode_lib->ms.UrgentBurstFactorCursor[j],
 													mode_lib->ms.UrgentBurstFactorLumaPre,
 													mode_lib->ms.UrgentBurstFactorChromaPre,
 													mode_lib->ms.UrgentBurstFactorCursorPre,
@@ -7809,9 +7809,9 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 				mode_lib->ms.DETBufferSizeYThisState[k],
 				mode_lib->ms.DETBufferSizeCThisState[k],
 				/* Output */
-				&mode_lib->ms.UrgentBurstFactorCursor[k],
-				&mode_lib->ms.UrgentBurstFactorLuma[k],
-				&mode_lib->ms.UrgentBurstFactorChroma[k],
+				&mode_lib->ms.UrgentBurstFactorCursor[j][k],
+				&mode_lib->ms.UrgentBurstFactorLuma[j][k],
+				&mode_lib->ms.UrgentBurstFactorChroma[j][k],
 				&mode_lib->ms.NotUrgentLatencyHiding[k]);
 		}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
index f951936bb579e..504c427b3b319 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
@@ -884,11 +884,11 @@ struct mode_support_st {
 	dml_uint_t meta_row_height[__DML_NUM_PLANES__];
 	dml_uint_t meta_row_height_chroma[__DML_NUM_PLANES__];
 	dml_float_t UrgLatency;
-	dml_float_t UrgentBurstFactorCursor[__DML_NUM_PLANES__];
+	dml_float_t UrgentBurstFactorCursor[2][__DML_NUM_PLANES__];
 	dml_float_t UrgentBurstFactorCursorPre[__DML_NUM_PLANES__];
-	dml_float_t UrgentBurstFactorLuma[__DML_NUM_PLANES__];
+	dml_float_t UrgentBurstFactorLuma[2][__DML_NUM_PLANES__];
 	dml_float_t UrgentBurstFactorLumaPre[__DML_NUM_PLANES__];
-	dml_float_t UrgentBurstFactorChroma[__DML_NUM_PLANES__];
+	dml_float_t UrgentBurstFactorChroma[2][__DML_NUM_PLANES__];
 	dml_float_t UrgentBurstFactorChromaPre[__DML_NUM_PLANES__];
 	dml_float_t MaximumSwathWidthInLineBufferLuma;
 	dml_float_t MaximumSwathWidthInLineBufferChroma;
-- 
2.39.5


