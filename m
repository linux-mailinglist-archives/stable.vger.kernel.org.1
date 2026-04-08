Return-Path: <stable+bounces-234940-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHF2DfCo1mlKHAgAu9opvQ
	(envelope-from <stable+bounces-234940-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:13:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A9A3C29C6
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8323315622C
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831AF2641FC;
	Wed,  8 Apr 2026 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dl8AJ7Q1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B534AB06;
	Wed,  8 Apr 2026 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674157; cv=none; b=Pi1GxtCpYOVItLDTebD5JLiZbg6ivU8zzM3bqZrp1FWm+Y3QL5nvd35exwwqfNZFgDK+b634TfN7QwwZO8w9Oh2Kf6bZgkg5jnS7Oi5K8ewGN5kLV1jqoe1fqhy776bb7WxTtfeq4kGd13/HEVgmSMB1uD278jciF3O5Ma7M3Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674157; c=relaxed/simple;
	bh=bWUXTdMpRj48xvTfRhL9FQiXf5tnY2UV52ckI1PF14A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7O3r4Ghz/9Calp/Ngxw3pGdRCf+9yncCvVB9vgdgQGqE6gEiHchp3bu61srFwnHrtFKsK+BWR/JhwUJet2DhULSFTABfP2f15W0U8iJcEwIk6wrMm6gjHqXcOZ6JpsRw0VyeRGiIrfi2TlIRsrGm0R5eT34CXyWxi6P+vAlZuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dl8AJ7Q1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6AEC19421;
	Wed,  8 Apr 2026 18:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674157;
	bh=bWUXTdMpRj48xvTfRhL9FQiXf5tnY2UV52ckI1PF14A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dl8AJ7Q1Y6H4EZ388cKUrvhHFsgr+H1TVlNPamVoImdKRfJJqtjJP9iqwrv8qlIj+
	 6oNm720WTeOWa9Qon2/jlcwVC7Amkacxz+hXQrBkZWxSgJqB3xsVP2CTOGPXVBaw9F
	 QUD0G+PdNbUFdoSoWoJ5WVyNO/GwJWGODZHHaWew=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Rosen Penev <rosenp@gmail.com>
Subject: [PATCH 6.12 231/242] drm/amd/display: Keep PLL0 running on DCE 6.0 and 6.4
Date: Wed,  8 Apr 2026 20:04:31 +0200
Message-ID: <20260408175935.743822928@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amd.com];
	TAGGED_FROM(0.00)[bounces-234940-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9A9A3C29C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 0449726b58ea64ec96b95f95944f0a3650204059 ]

DC can turn off the display clock when no displays are connected
or when all displays are off, for reference see:
- dce*_validate_bandwidth

DC also assumes that the DP clock is always on and never powers
it down, for reference see:
- dce110_clock_source_power_down

In case of DCE 6.0 and 6.4, PLL0 is the clock source for both
the engine clock and DP clock, for reference see:
- radeon_atom_pick_pll
- atombios_crtc_set_disp_eng_pll

Therefore, PLL0 should be always kept running on DCE 6.0 and 6.4.
This commit achieves that by ensuring that by setting the display
clock to the corresponding value in low power state instead of
zero.

This fixes a page flip timeout on SI with DC which happens when
all connected displays are blanked.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -889,7 +889,16 @@ static bool dce60_validate_bandwidth(
 		context->bw_ctx.bw.dce.dispclk_khz = 681000;
 		context->bw_ctx.bw.dce.yclk_khz = 250000 * MEMORY_TYPE_MULTIPLIER_CZ;
 	} else {
-		context->bw_ctx.bw.dce.dispclk_khz = 0;
+		/* On DCE 6.0 and 6.4 the PLL0 is both the display engine clock and
+		 * the DP clock, and shouldn't be turned off. Just select the display
+		 * clock value from its low power mode.
+		 */
+		if (dc->ctx->dce_version == DCE_VERSION_6_0 ||
+			dc->ctx->dce_version == DCE_VERSION_6_4)
+			context->bw_ctx.bw.dce.dispclk_khz = 352000;
+		else
+			context->bw_ctx.bw.dce.dispclk_khz = 0;
+
 		context->bw_ctx.bw.dce.yclk_khz = 0;
 	}
 



