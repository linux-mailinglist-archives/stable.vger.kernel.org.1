Return-Path: <stable+bounces-64906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 433D2943C21
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7108C1C21C1C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D751A4F11;
	Thu,  1 Aug 2024 00:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/92wCo5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1607A14B94E;
	Thu,  1 Aug 2024 00:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471388; cv=none; b=ZdkP9oi1+RF0FgJVFioRFKuoTBO9/7CZZpFmWPGOhgHDYLhcDC7M16EiwS3kSzrf6zwo6HE0RgbjGpDwwjlMjAVDBWzMziDo7CnTy7c1OwxANzAUP9PgbS7qUEgqW3wvoeF4+FX10b43rd2zykuPEYhZCunGjPKE5ubHCvqP3eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471388; c=relaxed/simple;
	bh=GCYeZ+s1AD2VNXhrhF1gjDx7P1Cnb4MLBbCIKetoeSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VV1+Co/0AoXyfX4IYFIGD1uxC9SP48aFzWSAeQO6nLQSUZYS5xmGNDsIObWjJ0Kf/JSXsoWPBkKswMI8fFfzJ4YXYsEFPlwFiNSmWl3+NN2AZ1q48h0a0c8PyLmYG79QxU0XOoW01tzxdGCdcdYgEVrV6GVzUGpHwQrO+lteock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/92wCo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0386C116B1;
	Thu,  1 Aug 2024 00:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471387;
	bh=GCYeZ+s1AD2VNXhrhF1gjDx7P1Cnb4MLBbCIKetoeSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k/92wCo5O4se7rhoPi3gvamZQnqfWzFWZhrFjSJk6cRnsULde1ZX7ckCWgdr3zfkk
	 kAbmgx0WgKtnRozdbAlVZrOJPwDTGXM8Bd1Doa3m3+C51+oXDnpF51KC4uy5JhCVjp
	 c+0Rqb0SpJIiornQWGbA1fd2sNEVq5tuLnC+yZXI75/C5JOdv40/89xTRmSnY0fQd0
	 fEDcXMqzNadT18yB6g96hGpslFaQLKz7W0X7n3xJHv90KcoK+69kV35BnsG3RmPLCf
	 tbY4H+iUgrxuWxIudTDf0oEo4DX8w/bM2d8boDHeR/uYXWrqqMDONDkMs5r72mo10O
	 0/hn7luz0POTg==
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
Subject: [PATCH AUTOSEL 6.10 081/121] drm/amd/display: Skip wbscl_set_scaler_filter if filter is null
Date: Wed, 31 Jul 2024 20:00:19 -0400
Message-ID: <20240801000834.3930818-81-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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


