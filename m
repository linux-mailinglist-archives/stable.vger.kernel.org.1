Return-Path: <stable+bounces-77281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C804985B67
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7301F21E94
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F19F193086;
	Wed, 25 Sep 2024 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/s7OM8c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFB815532A;
	Wed, 25 Sep 2024 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264940; cv=none; b=frqFiXCmcOAORCfRe8b4eRmQLfU5ge26bT9ipX9MVAI32FGZIlM3C9gTowc26FhgSaEyPWFLA5dzyeKXJkVZJvbVkTCK3PQgOWdt7q8uyiGPK9WuviJKM+sSX11daRUd0h9mawBVG0ZXvJKsk+aYh/8ZxiPKPx68bY/K/bho9HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264940; c=relaxed/simple;
	bh=IiEJWeg9HvhsJThCecwE7574GnUAmOuksOLPKp8f/Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ox4N8OJpdZlZZhX1iAzYScVAdQD1RGdIoA3wx1qp5BJJnrLBTokaUUfcxphn1N1CDqO4lZA8pOiWakMQCJHz4meiQ9+5+T1TAUBtZum39xZV9k90O+c56atTF5y/PX4My5FBFWFI7/XFwubKsG8eIAEoVax79JSkWTQ4kkEHcOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/s7OM8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A74C4CECD;
	Wed, 25 Sep 2024 11:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264940;
	bh=IiEJWeg9HvhsJThCecwE7574GnUAmOuksOLPKp8f/Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/s7OM8cNLlN5mK/N5P6XhuBUu9yB1f37EueK36zKrSWJ6rK9crfQlnm/BLAci6hY
	 NKd2UEXQYfbyrPp9QP6U83qrrOkZP0FUt0Q+DuhrLI4JnN9R2UrsoZc1PGrFtm9y3h
	 Aux+eyIcOkPmE53oCkmMwDr79henoYRjcearOmzO/AueUQZt16vHRqnfMycNZ83iYd
	 hCWhQsNVrT/A375M73jbCNLbkMGMDXWg8KTheyDHiDyRFm3EodpIxwAFB38bvKWyEH
	 9H2pizQviUHCV6vXzHYSXap7CHq2glGHHRI7mAwBomehV1lRIIVbayCTfq09fvnkjl
	 LSlBpnrNhGe3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chris Park <chris.park@amd.com>,
	Joshua Aberback <joshua.aberback@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dillon.varone@amd.com,
	alex.hung@amd.com,
	aurabindo.pillai@amd.com,
	hamza.mahfooz@amd.com,
	wenjing.liu@amd.com,
	charlene.liu@amd.com,
	mario.limonciello@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 183/244] drm/amd/display: Deallocate DML memory if allocation fails
Date: Wed, 25 Sep 2024 07:26:44 -0400
Message-ID: <20240925113641.1297102-183-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Chris Park <chris.park@amd.com>

[ Upstream commit 892abca6877a96c9123bb1c010cafccdf8ca1b75 ]

[Why]
When DC state create DML memory allocation fails, memory is not
deallocated subsequently, resulting in uninitialized structure
that is not NULL.

[How]
Deallocate memory if DML memory allocation fails.

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index e990346e51f67..665157f8d4cbe 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -211,10 +211,16 @@ struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *p
 #ifdef CONFIG_DRM_AMD_DC_FP
 	if (dc->debug.using_dml2) {
 		dml2_opt->use_clock_dc_limits = false;
-		dml2_create(dc, dml2_opt, &state->bw_ctx.dml2);
+		if (!dml2_create(dc, dml2_opt, &state->bw_ctx.dml2)) {
+			dc_state_release(state);
+			return NULL;
+		}
 
 		dml2_opt->use_clock_dc_limits = true;
-		dml2_create(dc, dml2_opt, &state->bw_ctx.dml2_dc_power_source);
+		if (!dml2_create(dc, dml2_opt, &state->bw_ctx.dml2_dc_power_source)) {
+			dc_state_release(state);
+			return NULL;
+		}
 	}
 #endif
 
-- 
2.43.0


