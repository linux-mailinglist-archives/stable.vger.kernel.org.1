Return-Path: <stable+bounces-59450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B4E9328D8
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4AAA1C208ED
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA571A0714;
	Tue, 16 Jul 2024 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/V+Nhhx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0E219D8A9;
	Tue, 16 Jul 2024 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140072; cv=none; b=moSkQv1ie7S0u7SzLTcydRqn/gtW+wsXYDgNFB1JOu4bymwLiDTlVxccqqCGUw1P6IJvLY8hgQ1/ggSmllz6EeU4vztYv5Hb3mdu7of0g590/2V4VhVIBaHJ+2jWp4TeXDeJ4/9LCXG2ADo/GL9sHN4cuvmqKPEcCsk3S+gIQCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140072; c=relaxed/simple;
	bh=lFfeEuGvPTnaQ/p4RIp+RBEGX2XyChwT1+a3MqZRhf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pB8Em0IxqVjuuJs3JFxrPf2QnpJRpzWywWTErBfh5LOUnFfXLP7/z3JyA++PmKf+jxG6qrp99+SHxYuXMpTyG4pLC7vHphXe+c3nFWZT5+8UKhTwDkM1kjA1RKnUaaxkhQl8srrtRNXGSv0bBqIIWZrOtXgJcSXPBJuctJklcs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/V+Nhhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E68C116B1;
	Tue, 16 Jul 2024 14:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140071;
	bh=lFfeEuGvPTnaQ/p4RIp+RBEGX2XyChwT1+a3MqZRhf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A/V+NhhxfEnuIEliav1KQ1sE0apocGc+PbRx4qkGw7DTDyL2dty9J3aZc9dqdOOLj
	 DvjI0/oDV7o5e0mX5rR7fWXrmFlTo3NWlwSoE/dp5lD+UmjSVSL2dPsKmqWEn7vPkh
	 mpZMkdg0lgDwM2PSdh6yNGejmcybqP/A8lACHRAE2m3OIVAGF3SYK42DjCaOsAKlyW
	 FsjXD67OfAKu8yQebaru8Os/n07GXhWS0T45xr4RdUN8fTwA9lEa50AWZ3LK5UEqla
	 qpwpOvkCHPqEPYBAYkq6ID3CCJweUhS1z1mgqtZwGK3Dk+pfK92GWfEbSHBfA4ACDN
	 rLckBnu6tchgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alvin Lee <alvin.lee2@amd.com>,
	Chaitanya Dhere <chaitanya.dhere@amd.com>,
	Nevenko Stupar <nevenko.stupar@amd.com>,
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
	jun.lei@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 12/18] drm/amd/display: Account for cursor prefetch BW in DML1 mode support
Date: Tue, 16 Jul 2024 10:26:47 -0400
Message-ID: <20240716142713.2712998-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142713.2712998-1-sashal@kernel.org>
References: <20240716142713.2712998-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.40
Content-Transfer-Encoding: 8bit

From: Alvin Lee <alvin.lee2@amd.com>

[ Upstream commit 074b3a886713f69d98d30bb348b1e4cb3ce52b22 ]

[Description]
We need to ensure to take into account cursor prefetch BW in
mode support or we may pass ModeQuery but fail an actual flip
which will cause a hang. Flip may fail because the cursor_pre_bw
is populated during mode programming (and mode programming is
never called prior to ModeQuery).

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 6c84b0fa40f44..0782a34689a00 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -3364,6 +3364,9 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							&mode_lib->vba.UrgentBurstFactorLumaPre[k],
 							&mode_lib->vba.UrgentBurstFactorChromaPre[k],
 							&mode_lib->vba.NotUrgentLatencyHidingPre[k]);
+
+					v->cursor_bw_pre[k] = mode_lib->vba.NumberOfCursors[k] * mode_lib->vba.CursorWidth[k][0] * mode_lib->vba.CursorBPP[k][0] /
+							8.0 / (mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]) * v->VRatioPreY[i][j][k];
 				}
 
 				{
-- 
2.43.0


