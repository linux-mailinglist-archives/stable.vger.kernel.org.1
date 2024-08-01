Return-Path: <stable+bounces-65070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A01943E09
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCAE2838AF
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AED81D4151;
	Thu,  1 Aug 2024 00:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcVAB33P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA0D1D4147;
	Thu,  1 Aug 2024 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472244; cv=none; b=RCm1W4WfFbfS/smm3oV2ssIHq1MvGd8HhlR0q6UE1KL+K82SqOghpMHz3If1ufjePbDKchB7o6gZ2dN4CHtWMm25Y4MgGrmJaQNh5G0kHOifL9sK29ZIzWSofxP1/o0a0bnzUpyMv8CYCHtLunJY4ZlEhMrC3PVxa0uh97GHDuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472244; c=relaxed/simple;
	bh=GCYeZ+s1AD2VNXhrhF1gjDx7P1Cnb4MLBbCIKetoeSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nt0/RZELfXNTEC8vHgcnYPsZPIE8htEL/2kOcJHslDmQjFbHnTitAnbYATBUjmoUtAGnojdL3H8MSeIMmGzXj43mLFJwxWhFH6Fxnk1fCMz70OmY77hP4yRUhOlwATLs/gOTp66mHGD06uNgaaoKPojrv9b9ExdzuOeE/RnadrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcVAB33P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08C2C4AF0C;
	Thu,  1 Aug 2024 00:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472243;
	bh=GCYeZ+s1AD2VNXhrhF1gjDx7P1Cnb4MLBbCIKetoeSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WcVAB33P6QPetXuT+26d4e1uNs/IEkAK5bT/uwrXr88zGuttjdVmxj0Ogew6Se65+
	 sp2EU0jABay/hT0M6Xn2ZBgHzt2oLIDiej8rl4DKHXOCWrNbyQXKSH73bWcynMPv4L
	 tzPPD/YuKjI9825+1iDvfhg4DCm+LyZf+nAf9+yjjfgvZUg13EcAPyMbh8YocmLGLp
	 /jPNms1MqZrrRXVqLLQVAmOw09BD5gWGdy1BfjdhDPhah2YWjOgc1oFoReaNX7f40B
	 o7OzRdyRKYnGsWS16dY+QrWNG8KYelAz2UtIZ6hrOzDdfo2Q+izoO8YvEGI5WbTW2S
	 pBidH46bvmMhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 41/61] drm/amd/display: Skip wbscl_set_scaler_filter if filter is null
Date: Wed, 31 Jul 2024 20:25:59 -0400
Message-ID: <20240801002803.3935985-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit c4d31653c03b90e51515b1380115d1aedad925dd ]

Callers can pass null in filter (i.e. from returned from the function
wbscl_get_filter_coeffs_16p) and a null check is added to ensure that is
not the case.

This fixes 4 NULL_RETURNS issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
index 994fb732a7cb7..a0d437f0ce2ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
@@ -690,6 +690,9 @@ static void wbscl_set_scaler_filter(
 	int pair;
 	uint16_t odd_coef, even_coef;
 
+	if (!filter)
+		return;
+
 	for (phase = 0; phase < (NUM_PHASES / 2 + 1); phase++) {
 		for (pair = 0; pair < tap_pairs; pair++) {
 			even_coef = filter[phase * taps + 2 * pair];
-- 
2.43.0


