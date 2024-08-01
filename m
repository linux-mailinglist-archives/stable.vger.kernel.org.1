Return-Path: <stable+bounces-65162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1560F943F6A
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A644BB2B82C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA51A1E2F47;
	Thu,  1 Aug 2024 00:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9y+HnfX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DF41E2F3E;
	Thu,  1 Aug 2024 00:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472703; cv=none; b=pxvuhCPLy1VWTi/AVN4dkTnajOHrWmO0Iwyem1E4RHcVeqUmVk8IFzl0kXHfYvQCJbsqvhcvGwoTSW76hCV4Lib5RZvfWjIxsCsPSd7gmeZ21tLQ+UgH8/gCbOkAIwW7ZRx8mw0HyR3D79RFCYOiMhKwnKJSS28a9XPsZyar+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472703; c=relaxed/simple;
	bh=xcoIfImOFi2tDBSbN1yCQgnHc11HHTOxBLdS8rblFww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFSKT1FyqaaMx/7xgep0lf3AGyygWJsQUwUdu67Wzg6L8mGngh1IPRq0YTEa+ojHu72rtSXOn4BfXM+oK34qMEi4gMw9aS8xTu7cptuvc5n9zOopzqlTrKwbD7ux2qeoyyrUQpfOXk2mFKD0wcoEwSP+/+Ffp3QkxLOCpqHeAzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9y+HnfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D22EC32786;
	Thu,  1 Aug 2024 00:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472703;
	bh=xcoIfImOFi2tDBSbN1yCQgnHc11HHTOxBLdS8rblFww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t9y+HnfXJssItG7QR8vYza9jI25addZIzT3Yp8Yk3a5p9Sw99z1iFE2UxG+q97Jfl
	 I26PtRHIrkpnVMGgZqCmdKCGaaazhwDkgd8ZclXTqr6NUab2mSG9FhgJPygT8g+dXE
	 /ku8ehmx6/FsS57P/kCZy3zAOCuL81Kjwyu6OAGHPdH+LyjW70XwNTqVzF8LbQIEIQ
	 f0mpth9JShHeg/HRR47Gk064GqX87LPIxI99I+fSylgpL+uvc6TZ8u4v/9ncj/jXTy
	 B3sXlOZiK8zDAqf8WmItD4nBNYv86P7Uu2b3MGdKhYdJnfd7b4NQIW4SA7BREH1Xnq
	 PVyCRXrVRvTOA==
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
Subject: [PATCH AUTOSEL 5.10 25/38] drm/amd/display: Skip wbscl_set_scaler_filter if filter is null
Date: Wed, 31 Jul 2024 20:35:31 -0400
Message-ID: <20240801003643.3938534-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index 880954ac0b027..1b3cba5b1d749 100644
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


