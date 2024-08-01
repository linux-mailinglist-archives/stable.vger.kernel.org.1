Return-Path: <stable+bounces-64947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DE0943CF9
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77AF1B24E4B
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247A32B9AA;
	Thu,  1 Aug 2024 00:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6JhSkWV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD514286;
	Thu,  1 Aug 2024 00:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471672; cv=none; b=YfoPMnjZr7O1+FgFW3AQwsNTB8niWZWxb4uc4gikPQ9+/p4aU2xwy/Yz8KR/irIFPfqqXimwuiM5xXyiZ918hNLE+yprUXFFJXYWdahkDK/0t7TVBMFYvdvvpeV6CzLIyWlUz+4jPAm+ovV33LVC4c2ksQnN+vAiFCy2AdTbvls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471672; c=relaxed/simple;
	bh=89FfziLV5sHr6MLxIivB2F/+Pw47DQ+9bnql9lzbtZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kSzMUlTTf+h/OoZkI07PcaEDdnmTHuh9Y0xL8ETaVJKuYRnS4E2LUulnuxZpX9dEKaoiv9YMCTBkH9kSrBnV8c8lIlMATdEet+18aGsN/xeRZ8bYhsJoEszFbjN2jM0qy2PqkF48+GOx+muofC4Zw1bVexZ2Su5NUA8/sx/Yi3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6JhSkWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87B8C116B1;
	Thu,  1 Aug 2024 00:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471672;
	bh=89FfziLV5sHr6MLxIivB2F/+Pw47DQ+9bnql9lzbtZ0=;
	h=From:To:Cc:Subject:Date:From;
	b=B6JhSkWVPdifm9vT2T2WtjN/82ei9XF+MgAkYOvYzfXaSEBFOETekcgBKeYybn3SL
	 ae9LFE04fnTcJnlWOXVZ3+5H77I9ZdEtspiTQhP3Hx1uC0reB5OGvu6KiTkfIEpHEd
	 WDyd2GLuOpj4iABqnPMyjWfUXwEB1NIPdrf1SokjVmKyGhtN60pNnR3hult6KquxYo
	 YaeVQSRTWc2jchsN9462GnGMKIReGt/dFNOp1kdp5ACkC+OZcovenP6rq0mVCCbw//
	 +xwnfBFD9x1ZWEZx5vCPVL2ND6pN8OD4FCDLyiMKVlWbWt2hclD2aBWvSt2pu8fSDd
	 Juwg+lzmqiM8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alvin Lee <alvin.lee2@amd.com>,
	Sohaib Nadeem <sohaib.nadeem@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
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
	wenjing.liu@amd.com,
	alex.hung@amd.com,
	aurabindo.pillai@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 01/83] drm/amd/display: Assign linear_pitch_alignment even for VM
Date: Wed, 31 Jul 2024 20:17:16 -0400
Message-ID: <20240801002107.3934037-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Alvin Lee <alvin.lee2@amd.com>

[ Upstream commit 984debc133efa05e62f5aa1a7a1dd8ca0ef041f4 ]

[Description]
Assign linear_pitch_alignment so we don't cause a divide by 0
error in VM environments

Reviewed-by: Sohaib Nadeem <sohaib.nadeem@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 72db370e2f21f..50e643bfdfbad 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1298,6 +1298,7 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 		return NULL;
 
 	if (init_params->dce_environment == DCE_ENV_VIRTUAL_HW) {
+		dc->caps.linear_pitch_alignment = 64;
 		if (!dc_construct_ctx(dc, init_params))
 			goto destruct_dc;
 	} else {
-- 
2.43.0


