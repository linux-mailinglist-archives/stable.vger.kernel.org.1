Return-Path: <stable+bounces-220282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mF6NJiwvo2me+AQAu9opvQ
	(envelope-from <stable+bounces-220282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:08:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3908E1C5752
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36AB430AB573
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D2038453F;
	Sat, 28 Feb 2026 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOFXR+pb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1D7384537;
	Sat, 28 Feb 2026 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300186; cv=none; b=CKKtCD4n7Liz4Fl8tJBslAUJMeJWTKvvYHZACsk6HvqcyDWJ7ndNiW69600ogOBuTQY4KueovjoCn8nDvAEL7rvxYXZIwqC6pSj7vM3U8cLzixMLZTaqaeJIPxPEIT3pfUM7hmAGo0c3+T2yZ9fcLuocTJn6l5QfBOk75vHFKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300186; c=relaxed/simple;
	bh=gji0AlFxWedMciKFHPpWbLZYurZSn7rxo7+2jgIjW1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+g23Cd1cVax7rYRKLxJk1K05RLjlm/lk/RbljYzAyI394gbr4BQ5J69DCd+kH9AtPheNuTsWfc8m5jqmF1OlDft/p52B0U97UM8EGH6W7q/GxJPwEOAqFTPI1RRe7CstMz9V5sge8rvIROkLdSn1uv0s/ia3rZSGY20mA/s7Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOFXR+pb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9255C19425;
	Sat, 28 Feb 2026 17:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300186;
	bh=gji0AlFxWedMciKFHPpWbLZYurZSn7rxo7+2jgIjW1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nOFXR+pbo4IDiFx419d4ZSPbZfXmImwel0D6rFeT0f479jBJ8RlsMmZkhhKlmKr7V
	 w9wxXx01D7g9TklzMALDMybu9IR+Dsg97m8jfMV+wvZYFdgcnFZHpwhkZQK2oAVJew
	 FijtQrL9k02f/E5d6wpAuLyuzkK3QCIv2WYlpo9nr07Tv8TYqJVTjeilkpufes87A+
	 PiwcP1et2HTsohFPio/6O7LROb9GOwWWFBD+tGxW7viiourDjYub3Y6zNmMOZHVL8c
	 FLmdXkXNGTpom9EWB/F/ZYj9IEy4wXl9TW3QnG/PVg9tlsftez+ET9350LvCMWVbwZ
	 tv02VKDLI+r9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	"Ovidiu (Ovi) Bunea" <ovidiu.bunea@amd.com>,
	Matthew Stewart <matthew.stewart2@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 204/844] drm/amd/display: Ensure link output is disabled in backend reset for PLL_ON
Date: Sat, 28 Feb 2026 12:21:57 -0500
Message-ID: <20260228173244.1509663-205-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220282-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3908E1C5752
X-Rspamd-Action: no action

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 4589712e0111352973131bad975023b25569287c ]

[Why]
We're missing the code to actually disable the link output when we have
to leave the SYMCLK_ON but the TX remains OFF.

[How]
Port the code from DCN401 that detects SYMCLK_ON_TX_OFF and disable
the link output when the backend is reset.

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c  | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index d1ecdb92b072b..20f700b59847c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -546,8 +546,22 @@ static void dcn31_reset_back_end_for_pipe(
 	if (pipe_ctx->stream_res.tg->funcs->set_odm_bypass)
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
+	/*
+	 * TODO - convert symclk_ref_cnts for otg to a bit map to solve
+	 * the case where the same symclk is shared across multiple otg
+	 * instances
+	 */
 	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal))
-		pipe_ctx->stream->link->phy_state.symclk_ref_cnts.otg = 0;
+		link->phy_state.symclk_ref_cnts.otg = 0;
+
+	if (pipe_ctx->top_pipe == NULL) {
+		if (link->phy_state.symclk_state == SYMCLK_ON_TX_OFF) {
+			const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
+
+			link_hwss->disable_link_output(link, &pipe_ctx->link_res, pipe_ctx->stream->signal);
+			link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+		}
+	}
 
 	set_drr_and_clear_adjust_pending(pipe_ctx, pipe_ctx->stream, NULL);
 
-- 
2.51.0


