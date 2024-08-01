Return-Path: <stable+bounces-64904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 772A4943C12
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EADF21F21E48
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78BA14B07C;
	Thu,  1 Aug 2024 00:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEb0rqN5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46FD14A629;
	Thu,  1 Aug 2024 00:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471378; cv=none; b=R4g2HlOPkSVBIT6zyD+eENQdNRhbofg/KaVZ4K2mjvKan4J4FRK/WjdRT2TBH5RuiE+3U9xSTYRQ/YGNY6NJ55crLYh+yDx+3+5X6f5RmCAERYten3Qjaci4C5oq/3sShrcEFes6omkO3xy1vrku7Wv/T1hqCD0J0oL+GaSzEAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471378; c=relaxed/simple;
	bh=Ql4idpPEwSG2odetp/Oqw0NEhP/uQ2tRKugeqUNQb6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyY4ADI0LcB+zJN/kuYPpk/NSpMxRNVowCkUczNfgEQcTr+x9Qy7hw9SdRPqwRghMVT5ZjILlIlB8cppnmxvWl21HD7D7/4J/qLtVGOBjoKkoDvSxNuNFgo6bWLbVwHSFk7Dbxv1hqkCX1YFJVesOtjIU3ZbaJDlq/5m+kZ3dJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEb0rqN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94452C32786;
	Thu,  1 Aug 2024 00:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471378;
	bh=Ql4idpPEwSG2odetp/Oqw0NEhP/uQ2tRKugeqUNQb6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KEb0rqN5XhFd4W+w3dY3rv+z52yZfdEvSDeRX2TzfDkXWUZyUnLZA0OOlYin66Adg
	 TBrBFBkAkI8EOcFfu6nhBwivSYkcOMM6RbsGwkrHhB2Z63kAYlMzmlW5BgJDhOrL+Z
	 shcFrZ7wflHmy46yWDqprU1VAlS5OSJows5AoZgg0bbSTLWWTJa8clNcgZdHIA0B5Q
	 ELIkh3hQnt2CnPTXkohw1ll7kCoykp3J585VGeA52M274IZGPbhsC0Q8GopMxdKB5K
	 rJUt/iwU9c7n/0p42y3rXtSajFuZwhBMEI85C0GWVrWhZ8BPNbP0J7QAJWk7t4Bneq
	 f/PRWgLviZ+Sw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
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
	chuchang@amd.com,
	jun.lei@amd.com,
	nicholas.kazlauskas@amd.com,
	camille.cho@amd.com,
	lewis.huang@amd.com,
	anthony.koo@amd.com,
	srinivasan.shanmugam@amd.com,
	wayne.lin@amd.com,
	dan.carpenter@linaro.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 079/121] drm/amd/display: Avoid overflow from uint32_t to uint8_t
Date: Wed, 31 Jul 2024 20:00:17 -0400
Message-ID: <20240801000834.3930818-79-sashal@kernel.org>
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

[ Upstream commit d6b54900c564e35989cf6813e4071504fa0a90e0 ]

[WHAT & HOW]
dmub_rb_cmd's ramping_boundary has size of uint8_t and it is assigned
0xFFFF. Fix it by changing it to uint8_t with value of 0xFF.

This fixes 2 INTEGER_OVERFLOW issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c       | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
index b851fc65f5b7c..5c2d6642633d9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
@@ -258,7 +258,7 @@ bool dmub_abm_set_pipe(struct abm *abm,
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = abm->ctx;
-	uint32_t ramping_boundary = 0xFFFF;
+	uint8_t ramping_boundary = 0xFF;
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 804be977ea47b..3de65a9f0e6f2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -142,7 +142,7 @@ static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst,
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = abm->ctx;
-	uint32_t ramping_boundary = 0xFFFF;
+	uint8_t ramping_boundary = 0xFF;
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
-- 
2.43.0


