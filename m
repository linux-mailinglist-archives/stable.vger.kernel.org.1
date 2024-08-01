Return-Path: <stable+bounces-64901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0942943BEE
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B91C2811E1
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68E114A4E5;
	Thu,  1 Aug 2024 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVVGp33D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C14132120;
	Thu,  1 Aug 2024 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471343; cv=none; b=sUlobYVOz/xVkBW6EaQkH1gWAFoGMvhKMlke0o+hw5gCPvzHqamBN0YEttoMEGYnoqGBzqWv6x0T/V5+dKxvBuqzJVRXC/o+rdNfFxIVZgq3pLgup1YSOlvXwr1PfGT6Vg2tTsiDTV0GUFQ/qbkyBfGDoarkAzaii3AFgRk1fOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471343; c=relaxed/simple;
	bh=Sx3sRZ5AVYDq1GDGcflS5HXYzGIQGcQNw1wxSsHPmcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDGgCE09T1JkixCXHfYk2MFXNc83Pg/JgVEXUB8rLvmAOVCIY6ryVqxw/3FMQWxh3AGrP6d7mtYfFTl9cdwpF1IuI1jmdqb+4mj9CY+tBqU2YTasgAP1uy2I42SpQkKhNT51XP/mwlJCDa2sv0b9oaLF9lGXv9yuLHbiwQS3qaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVVGp33D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE714C4AF0C;
	Thu,  1 Aug 2024 00:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471343;
	bh=Sx3sRZ5AVYDq1GDGcflS5HXYzGIQGcQNw1wxSsHPmcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rVVGp33DR5v78Q2g2JXICh3MLEqtE3a6NOUuuwqDTBrUQ3abeZLGHhhym25Dock+t
	 GwYAez86f9bggkOD0VveIMG0jDMBS83ImvNh85kXIX98ks+dimuF6gqx8aITc8OU1n
	 xmGJAH7auU+iD68jlrpVQXnAbc3/8ptSI0HCqJXqEKwdylvPzqdKrpc+CDDeNNT0xo
	 irCaCYOUXmh70bUAclSaJq6AmkXs31I41NE5JtK/Pk7/GAlmOf8tXVLMBcttmBtN8x
	 D8c3oZ2fGuC8lpoFmO3PvOR+6aFoEpPMm9q/IAHx8c/q8KFTLzaAkshzohjvmQNjqp
	 YVoMVLnIHsQ9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Duncan Ma <duncan.ma@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
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
	charlene.liu@amd.com,
	Qingqing.Zhuo@amd.com,
	alvin.lee2@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 076/121] drm/amd/display: Remove register from DCN35 DMCUB diagnostic collection
Date: Wed, 31 Jul 2024 20:00:14 -0400
Message-ID: <20240801000834.3930818-76-sashal@kernel.org>
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 466423c6dd8af23ebb3a69d43434d01aed0db356 ]

[Why]
These registers should not be read from driver and triggering the
security violation when DMCUB work times out and diagnostics are
collected blocks Z8 entry.

[How]
Remove the register read from DCN35.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 70e63aeb8f89b..a330827f900c3 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -459,7 +459,7 @@ uint32_t dmub_dcn35_get_current_time(struct dmub_srv *dmub)
 void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data)
 {
 	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset;
-	uint32_t is_traceport_enabled, is_cw0_enabled, is_cw6_enabled;
+	uint32_t is_traceport_enabled, is_cw6_enabled;
 
 	if (!dmub || !diag_data)
 		return;
@@ -510,9 +510,6 @@ void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnosti
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
 	diag_data->is_traceport_en  = is_traceport_enabled;
 
-	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
-	diag_data->is_cw0_enabled = is_cw0_enabled;
-
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
 	diag_data->is_cw6_enabled = is_cw6_enabled;
 
-- 
2.43.0


