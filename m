Return-Path: <stable+bounces-146648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59548AC5435
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 18:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9B88A3B4C
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A3927FD62;
	Tue, 27 May 2025 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S5JfUEhn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3E7276057;
	Tue, 27 May 2025 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364879; cv=none; b=Wh2DwBsybNBrCqQxifbPXVVaH/670bETPQe1bU4jGxthe3J5cM+2o38hik611P7ke6mYDUSqedfxwfXtDpLBRwiaJ3TS9kfWsFesdlXgepuwPtNTEg7m700jCtRBKHSIQ22q6za4RRxB7r/y5DiuvkKaooyC1pNLeclltxV5qfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364879; c=relaxed/simple;
	bh=t5/DO68UdP3nVNxP1XzV7LrxTh5gVZ+4Ss+oMaQAQnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lq6nMmKX0PucNJer/sjavFvmLMFYdL1ihySU8XFylzf4mNChBE0DUFrgluWdTXMAQxgPF5P5cmDetrgjauZAxOZbdLQVPC7BeKdIb3+pSv4O+Z2ojItcDa79IJ1XhNBszsFNNQ4k9SAesv2khpEOEC0vfOT1SKvXCFk+4oA/14E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S5JfUEhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DF8C4CEE9;
	Tue, 27 May 2025 16:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748364879;
	bh=t5/DO68UdP3nVNxP1XzV7LrxTh5gVZ+4Ss+oMaQAQnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S5JfUEhn28LlyGjOb0Qaj7t8eO1kSxj9DudVraIAqDMQOGYf5mtIRAgUMoU0yHHeL
	 NRGtjCrpREo0VvlGyEwX6cqvZyKdUOOk9foBPmLs2Bm2RwCTqOlrAbgc/CEnmYnaaN
	 aPKyN4wyiQOUs+Evgdt7Gjfn9VjHAvC651KbWPvU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robin Chen <robin.chen@amd.com>,
	Leon Huang <Leon.Huang1@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 196/626] drm/amd/display: Fix incorrect DPCD configs while Replay/PSR switch
Date: Tue, 27 May 2025 18:21:29 +0200
Message-ID: <20250527162452.982833905@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Huang <Leon.Huang1@amd.com>

[ Upstream commit 0d9cabc8f591ea1cd97c071b853b75b155c13259 ]

[Why]
When switching between PSR/Replay,
the DPCD config of previous mode is not cleared,
resulting in unexpected behavior in TCON.

[How]
Initialize the DPCD in setup function

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../link/protocols/link_edp_panel_control.c   | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 3aa05a2be6c09..fa642f4b88c2d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -674,6 +674,18 @@ bool edp_setup_psr(struct dc_link *link,
 	if (!link)
 		return false;
 
+	//Clear PSR cfg
+	memset(&psr_configuration, 0, sizeof(psr_configuration));
+	dm_helpers_dp_write_dpcd(
+		link->ctx,
+		link,
+		DP_PSR_EN_CFG,
+		&psr_configuration.raw,
+		sizeof(psr_configuration.raw));
+
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED)
+		return false;
+
 	dc = link->ctx->dc;
 	dmcu = dc->res_pool->dmcu;
 	psr = dc->res_pool->psr;
@@ -684,9 +696,6 @@ bool edp_setup_psr(struct dc_link *link,
 	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
 		return false;
 
-
-	memset(&psr_configuration, 0, sizeof(psr_configuration));
-
 	psr_configuration.bits.ENABLE                    = 1;
 	psr_configuration.bits.CRC_VERIFICATION          = 1;
 	psr_configuration.bits.FRAME_CAPTURE_INDICATION  =
@@ -950,6 +959,16 @@ bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream
 	if (!link)
 		return false;
 
+	//Clear Replay config
+	dm_helpers_dp_write_dpcd(link->ctx, link,
+		DP_SINK_PR_ENABLE_AND_CONFIGURATION,
+		(uint8_t *)&(replay_config.raw), sizeof(uint8_t));
+
+	if (!(link->replay_settings.config.replay_supported))
+		return false;
+
+	link->replay_settings.config.replay_error_status.raw = 0;
+
 	dc = link->ctx->dc;
 
 	replay = dc->res_pool->replay;
-- 
2.39.5




