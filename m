Return-Path: <stable+bounces-65122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48002943EDF
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795F81C22A0D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E09D1DC480;
	Thu,  1 Aug 2024 00:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWNrNo3I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCDC1DC475;
	Thu,  1 Aug 2024 00:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472506; cv=none; b=Lt984/pZ4WxRKlprKilMOJQ6GZh4+cNK4Ol2ajSmWc1VM8KENa4QjyD2hn/urlUUEpttGNXS42Ln1u1ZYsfnbRY6T2KJ//GwBgkVPHEgTcOdKiB0TFlJe8EJuVmaRRdgDMxFvdeqmsKtOoOsRXAyZF/TLsqpI+Em3u9NaKpOBGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472506; c=relaxed/simple;
	bh=xcoIfImOFi2tDBSbN1yCQgnHc11HHTOxBLdS8rblFww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3Xcb+/EK0ypVeY7okXtf6s8NqYTrIm0R8ZXholkLexjQpWQuSJLyNizooFIe9eA7uDrGjoKWwRs9GZPxr4iCRYy/taqgHSp8d/wYmqHyPPh//HZ4SCQU8uXTdrIOHCWT6nSF9M97Y/qy2UvshLSjuEw0n1pwR/NGy83VgtKa1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWNrNo3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7F1C116B1;
	Thu,  1 Aug 2024 00:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472505;
	bh=xcoIfImOFi2tDBSbN1yCQgnHc11HHTOxBLdS8rblFww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aWNrNo3Ib141f1PAooq76AlrIGWBSx+vsab+3u57WAe3tr3XUhTAWvxIoL8ejVwmx
	 nbZ2TB4qulgMO7qFeEUuwu+RPU1otJ/vWacPJQed3+AcphhFad1CfiK/LPBvE/cIEn
	 sIThgG0fD4BCj3Q0Tvf0rGzfzsxqZsM8XUgKRKoPyRP0Uh2pCxJ4M05Kqm0UGgGM8v
	 xhKEmVKQsFUxqEYXMbkBxMbvEXY1+/Kx8Kcz4HKXpbWd/3hh/62ekKjxwbdrGvkWM9
	 GPbht784wGn9qOuguZ+QEGL4l5oavuu0Axsud64QRFcqcT+MbZg8PPWzUlRM7JGX+s
	 D6V8QqlbgBSzA==
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
Subject: [PATCH AUTOSEL 5.15 32/47] drm/amd/display: Skip wbscl_set_scaler_filter if filter is null
Date: Wed, 31 Jul 2024 20:31:22 -0400
Message-ID: <20240801003256.3937416-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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


