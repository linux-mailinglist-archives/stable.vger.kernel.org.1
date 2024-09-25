Return-Path: <stable+bounces-77256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AD5985B28
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873D31C2404B
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31091191F9C;
	Wed, 25 Sep 2024 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNU+FkoO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECDA191F96;
	Wed, 25 Sep 2024 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264839; cv=none; b=dbrU1ujg6+jqsHJ7moxYHVXjLpK5tojczpb925rySC592QY1dc8o7PcGh+o7e2j2dm5SeHPwQuQisbmQoheULPR4BkEhQuJaGVJ7LSMrVQ3vX9l7ikWU0pGhYpYASfrJVGivpXq1XULjKVUBJQsjXNSrJHhm5hN2jwNpCIzA5Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264839; c=relaxed/simple;
	bh=AhRiXv9jHQtO4pocROaSclD7ZDHLsgLFcwpOJA4CoYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ll/+mUyPR0GChILoLXmFvti20yovVyUrBNFTmfQz8lNBKv8hEzkFGbdeK1JVQlPf5/wdEvnlgm6Bxdc9lBQqjI2guViWAUIGHg2g8bptyH+AOo6WwDZH3MwbDf3EzhkMFgrHftsSxTYECKvPiCI3z/PZlmtkttbb6fCD669SR3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNU+FkoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF72C4CEC3;
	Wed, 25 Sep 2024 11:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264838;
	bh=AhRiXv9jHQtO4pocROaSclD7ZDHLsgLFcwpOJA4CoYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jNU+FkoOdh5sMYFhJPPmKHPkWplL9BIWv35yfCr8Y3Mh3sZlQLfGME+Rw9DJn+MuC
	 cx835QJimLmtjZ7nsve4sEmtpC1Iw5WeYUHDM8rYyw3DMgWOYn0oMT7ZGBxAzuSU1K
	 P2Do/JLsXL9LPmx+TT5lmVsDRHFUGbMPkPvqOGjT3IGdVa1y05Pi/DMFUE8V/O8Qam
	 lSW/qMzgqzapmYarlR17aQhMimIaj71k2Re1fj4gnfgWjEqcfebYwgd90m4QFQ2iKS
	 DYMMZevxzuqF4dG3ZpNmacTB4BwzL97Moojpl02ck0tP1VMGuEP1L5/XhbV8cRRfF3
	 dVAAL9JWD0X8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alvin.lee2@amd.com,
	wayne.lin@amd.com,
	wenjing.liu@amd.com,
	george.shen@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 158/244] drm/amd/display: Check null pointer before try to access it
Date: Wed, 25 Sep 2024 07:26:19 -0400
Message-ID: <20240925113641.1297102-158-sashal@kernel.org>
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[ Upstream commit 1b686053c06ffb9f4524b288110cf2a831ff7a25 ]

[why & how]
Change the order of the pipe_ctx->plane_state check to ensure that
plane_state is not null before accessing it.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 7ca0da88290af..936c0ec076bc4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1931,6 +1931,11 @@ static void dcn20_program_pipe(
 	    (pipe_ctx->plane_state && pipe_ctx->plane_state->update_flags.bits.hdr_mult))
 		hws->funcs.set_hdr_multiplier(pipe_ctx);
 
+	if ((pipe_ctx->plane_state && pipe_ctx->plane_state->update_flags.bits.hdr_mult) ||
+	    pipe_ctx->update_flags.bits.enable)
+		hws->funcs.set_hdr_multiplier(pipe_ctx);
+
+
 	if (hws->funcs.populate_mcm_luts) {
 		if (pipe_ctx->plane_state) {
 			hws->funcs.populate_mcm_luts(dc, pipe_ctx, pipe_ctx->plane_state->mcm_luts,
@@ -1938,13 +1943,13 @@ static void dcn20_program_pipe(
 			pipe_ctx->plane_state->lut_bank_a = !pipe_ctx->plane_state->lut_bank_a;
 		}
 	}
-	if (pipe_ctx->update_flags.bits.enable ||
-	    (pipe_ctx->plane_state &&
+	if ((pipe_ctx->plane_state &&
 	     pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change) ||
 	    (pipe_ctx->plane_state &&
 	     pipe_ctx->plane_state->update_flags.bits.gamma_change) ||
 	    (pipe_ctx->plane_state &&
-	     pipe_ctx->plane_state->update_flags.bits.lut_3d))
+	     pipe_ctx->plane_state->update_flags.bits.lut_3d) ||
+	     pipe_ctx->update_flags.bits.enable)
 		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
 
 	/* dcn10_translate_regamma_to_hw_format takes 750us to finish
-- 
2.43.0


