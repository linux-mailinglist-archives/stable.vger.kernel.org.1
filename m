Return-Path: <stable+bounces-76208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE0B979FC8
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 12:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 455CFB21133
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 10:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474A21509A5;
	Mon, 16 Sep 2024 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="IRfxdsin"
X-Original-To: stable@vger.kernel.org
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56921547F2;
	Mon, 16 Sep 2024 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726484057; cv=none; b=mEdLCpt0UJ8hT7LJcUXUrrAKlbz8LMWTKBluDj+egC4Zdt/OI3BzH2WcQsCTHwemITCnAPYlmXqwVAOM/jC8EYq47Q+6bAWeH9PP+FNTiOJzE4I3YF2nDM4WCbaguEUDVrXCu6bR3MDmpNkJdamxxCYFmFCMwYZqw+myRpWQoTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726484057; c=relaxed/simple;
	bh=6c4u/w45azANOUj2mFEtuoPMCb+R4HzsadISgO8smpw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HmX1VF4MYaP5rVX1bFNIUHq+akiRQhHJQ455ZcmMV1t/hW5jTANEFbTmVH4W3Yvws02IA/3yJjLoRoEw3gzVPxb83NueJga2+M6rEAyODnWrBLhS7CQuYEWFOtgk9cW65Vw25T4lkMDej6VTujQN4DPpLIeuUfzChCSxX6ma9cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=maxima.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=IRfxdsin; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxima.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id C9DCF1E0004;
	Mon, 16 Sep 2024 13:54:12 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru C9DCF1E0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1726484052; bh=oZG3n3xbV5KcvOrWPpD8sTpFQFpjRfidrHM0Z4QVsic=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=IRfxdsina6UW7NgxVqvfx6G4Xr1ls4bUybzvw0M7vuhc8N+DWv2coSb8wUXMLzSM+
	 C4IGaEbP5YVdUREKUaFdSYzYfPaOyL2xa27yN5crkZSBA1roEQ4G0o4kurKcZztv88
	 P2xGdRYxMVIAn0boBq0IJwWByW0o+XNTT/nt/6WHHJoYcYHaflSFWx2vZ4HT72mQmb
	 SVpFBkt1dQCQ8Bzb+1v1Bf9PnAuHTjNC+C1Q4E4M4EhaHbZNc8LfQUatbi7x1iZqOI
	 S6ucslOsemIEN3uu19lnaxIJMvkqV54EexTG+NBWXfQJvrROMFQsigao6ZQpa4d1KM
	 jJB653oUXaHgg==
Received: from ksmg02.maxima.ru (unknown [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Mon, 16 Sep 2024 13:54:12 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.247.10) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Mon, 16 Sep
 2024 13:54:10 +0300
From: Murad Masimov <m.masimov@maxima.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Murad Masimov <m.masimov@maxima.ru>, Harry Wentland
	<harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
	<Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Pan, Xinhui"
	<Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>, Alvin Lee <alvin.lee2@amd.com>, Chaitanya Dhere
	<chaitanya.dhere@amd.com>, Sasha Levin <sashal@kernel.org>, Sohaib Nadeem
	<sohaib.nadeem@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Hersen Wu
	<hersenxs.wu@amd.com>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Daniel Wheeler <daniel.wheeler@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Samson Tam <samson.tam@amd.com>
Subject: [PATCH 6.6] drm/amd/display: Fix subvp+drr logic errors
Date: Mon, 16 Sep 2024 13:53:15 +0300
Message-ID: <20240916105319.1847-1-m.masimov@maxima.ru>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch02.mt.ru
 (81.200.124.62)
X-KSMG-Rule-ID: 7
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187760 [Sep 16 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: m.masimov@maxima.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=maxima.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, maxima.ru:7.1.1;81.200.124.62:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;ksmg02.maxima.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.62, {DNS response errors}
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/16 05:22:00 #26594998
X-KSMG-AntiVirus-Status: Clean, skipped

From: Alvin Lee <alvin.lee2@amd.com>

commit 8a0f02b7beed7b2b768dbdf3b79960de68f460c5 upstream.

[Why]
There is some logic error where the wrong variable was used to check for
OTG_MASTER and DPP_PIPE.

[How]
Add booleans to confirm that the expected pipes were found before
validating schedulability.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Reviewed-by: Samson Tam <samson.tam@amd.com>
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Murad Masimov <m.masimov@maxima.ru>
---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c    | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 3d82cbef1274..7160380d5690 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -879,6 +879,8 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context)
 	int16_t stretched_drr_us = 0;
 	int16_t drr_stretched_vblank_us = 0;
 	int16_t max_vblank_mallregion = 0;
+	bool subvp_found = false;
+	bool drr_found = false;
 
 	// Find SubVP pipe
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -891,8 +893,10 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context)
 			continue;
 
 		// Find the SubVP pipe
-		if (pipe->stream->mall_stream_config.type == SUBVP_MAIN)
+		if (pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
+			subvp_found = true;
 			break;
+		}
 	}
 
 	// Find the DRR pipe
@@ -900,15 +904,20 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context)
 		drr_pipe = &context->res_ctx.pipe_ctx[i];
 
 		// We check for master pipe only
-		if (!resource_is_pipe_type(pipe, OTG_MASTER) ||
-				!resource_is_pipe_type(pipe, DPP_PIPE))
+		if (!resource_is_pipe_type(drr_pipe, OTG_MASTER) ||
+				!resource_is_pipe_type(drr_pipe, DPP_PIPE))
 			continue;
 
 		if (drr_pipe->stream->mall_stream_config.type == SUBVP_NONE && drr_pipe->stream->ignore_msa_timing_param &&
-				(drr_pipe->stream->allow_freesync || drr_pipe->stream->vrr_active_variable))
+				(drr_pipe->stream->allow_freesync || drr_pipe->stream->vrr_active_variable)) {
+			drr_found = true;
 			break;
+		}
 	}
 
+	if (!subvp_found || !drr_found)
+		return false;
+
 	main_timing = &pipe->stream->timing;
 	phantom_timing = &pipe->stream->mall_stream_config.paired_stream->timing;
 	drr_timing = &drr_pipe->stream->timing;
-- 
2.39.2


