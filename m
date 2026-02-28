Return-Path: <stable+bounces-220214-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM6BKvEwo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220214-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:16:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CF21C5999
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88FBF3320C0A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495A64DBD61;
	Sat, 28 Feb 2026 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDzdgcMT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8344DB579;
	Sat, 28 Feb 2026 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300120; cv=none; b=TMzxhyajFaNCDo5hw0qIBFJGCW7LnvTlhOZ3K183fXQRAQhKcL4RaPuyUl9/I8XelhEsrVVZWQReP4Lkiglxdsp7kOz8p0vjraPsYfIhbyEj43XRYaMymS7QzRXo0cgrQ88RD5+mhnSjdlcojT+iSHjwovnWmmY7NS31poUSiH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300120; c=relaxed/simple;
	bh=d9/1ShxoaaOuUBmvZ5NReuYcP1/oe01v6p1gTJbqV84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnUM+75p1Up7bf1ZL8M61PNDEfhfSdXwG9f5gozvhornAjugsOmnoNeG+XgyvmXxPSTa21v/ZN7KaP5DucO6liBHLib5jj4gGMqy4USPFqmTZJTYk/gZk9L9kDLlnmGgMw/DDvoyxG+vjnUFC77N61gT7FD/GKWC0N/7HQcXlmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDzdgcMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19507C19424;
	Sat, 28 Feb 2026 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300119;
	bh=d9/1ShxoaaOuUBmvZ5NReuYcP1/oe01v6p1gTJbqV84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EDzdgcMTYGCWj3vh1sGRZxJDaNjAGVpk2nZwdarOHiH5/3aNikZ2yTN93HjuONJEk
	 yfiJraEZNuZQ2OLQe41Uqrr8xjKudzPaqGLCFD6g4ysBtPWanlQnAWn4XsVuaME/FE
	 B15COp+QrHDCkX+S+2Pd0DfVUEq7j6Oajl1SwIdZvWzs4Y6oQA0XXgntC/7Kn9n6AC
	 FdlLRl+gsxlak7NBPPSi5FO1PeMsehGJV5gpktMIfdoUKKi5KycVOJzCZe+kZ6KYi2
	 Uyk33N10tez1gu8ON1nLUkieK4iYZG8bPuTTNbaoA/wN0dWyquJQW1eAP+agq00qn0
	 +EV+2N5ywS3dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dillon Varone <Dillon.Varone@amd.com>,
	Sridevi Arvindekar <sridevi.arvindekar@amd.com>,
	Roman Li <roman.li@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 136/844] drm/amd/display: Guard FAMS2 configuration updates
Date: Sat, 28 Feb 2026 12:20:49 -0500
Message-ID: <20260228173244.1509663-137-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220214-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26CF21C5999
X-Rspamd-Action: no action

From: Dillon Varone <Dillon.Varone@amd.com>

[ Upstream commit 7dedb906cdfec100061daf41f8e54266e975987d ]

[WHY&HOW]
If DMCUB is not initialized or FAMS2 is not supported, the
interface should not be called.

Reviewed-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 5ffe41a96864a..12ce3789f5130 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1774,7 +1774,8 @@ void dcn401_unblank_stream(struct pipe_ctx *pipe_ctx,
 void dcn401_hardware_release(struct dc *dc)
 {
 	if (!dc->debug.disable_force_pstate_allow_on_hw_release) {
-		dc_dmub_srv_fams2_update_config(dc, dc->current_state, false);
+		if (dc->ctx->dmub_srv && dc->debug.fams2_config.bits.enable)
+			dc_dmub_srv_fams2_update_config(dc, dc->current_state, false);
 
 		/* If pstate unsupported, or still supported
 		* by firmware, force it supported by dcn
@@ -1794,7 +1795,9 @@ void dcn401_hardware_release(struct dc *dc)
 			dc->clk_mgr->clks.p_state_change_support = false;
 			dc->clk_mgr->funcs->update_clocks(dc->clk_mgr, dc->current_state, true);
 		}
-		dc_dmub_srv_fams2_update_config(dc, dc->current_state, false);
+
+		if (dc->ctx->dmub_srv && dc->debug.fams2_config.bits.enable)
+			dc_dmub_srv_fams2_update_config(dc, dc->current_state, false);
 	}
 }
 
-- 
2.51.0


