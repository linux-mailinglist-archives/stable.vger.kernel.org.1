Return-Path: <stable+bounces-220213-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHdZLdsuo2me+AQAu9opvQ
	(envelope-from <stable+bounces-220213-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:07:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB811C56E0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CDD12314D56C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D504DB567;
	Sat, 28 Feb 2026 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7YnQmEL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197204DB541;
	Sat, 28 Feb 2026 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300119; cv=none; b=OhYpVkn0jBiOX3eh41ftzkW5KQP7NyVyJdPX320M/KNvAUTNk9pbymvVDWZIXws7Y/4TpYTqMUt503UZAwm1lJAsdWBAna73NH+33v40Wlt3hVMog33T7quydmtRfpE9yWiB6OcVE0SCie49tWYRen16/SYcDBLMotIcRiQK30g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300119; c=relaxed/simple;
	bh=zQQDabQxX/Mj3pMOdIretiHOgmTgNC9y9Xg7vn5SY9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0CyD6SSIk28MeiSuOR4NsSF9qJLjWhUrrM7KJb4DlMoGQFUQioWcsEisU96tl/+WEA4O7qEsz71XrgRr0kRaF7HVWpS2NRG1L+yrrhx9jCQVGbRNOPpdOIaEyO0rrucIc1Fp+uGvQREjbh7IdarKeY4SFUfxwK/noldRsXGjm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7YnQmEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C93C2BC87;
	Sat, 28 Feb 2026 17:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300118;
	bh=zQQDabQxX/Mj3pMOdIretiHOgmTgNC9y9Xg7vn5SY9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7YnQmELM5f+3HHzS+ijzPXYcSlwqzuuw5BkrFj2FbmJ1e/FowVqrGVpspp674s/Y
	 IOMIJvBIkw6v5ku7Lq8fPi5Z0d2EZSSohoEx4JadfxNxRUOH0uPFQ2z4PP8ASUtC+q
	 h/GmGFHIBtB7sPE3t9hYiGGASpPrmX0EHhO9VjGYRsENDvCrA+1x6vB74L74aBAXd/
	 oe30/AcXJm28Gn6idNqHoexHvGDV4Bp5TG0whwDJfrvqzoiVFevNs4aHV03XEH1xuM
	 nQ0tWFh8sIzxcPFgHy4oheQ707EPdwKbygqHsJ14rA6jI7AZcq/NaeKcTXuORUBiX8
	 oFSnAscRAqRGw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jing Zhou <Jing.Zhou@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Roman Li <roman.li@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 135/844] drm/amd/display: Correct FIXED_VS Link Rate Toggle Condition
Date: Sat, 28 Feb 2026 12:20:48 -0500
Message-ID: <20260228173244.1509663-136-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220213-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: BFB811C56E0
X-Rspamd-Action: no action

From: Jing Zhou <Jing.Zhou@amd.com>

[ Upstream commit 531fe6e0fee85a1bdb5b8223a706fff654ed0a61 ]

[WHY&HOW]
The condition is only perform toggle if FIXED_VS LTTPR reports
no IEEE OUI.
The literal "\x0,\x0,\x0" contains commas changes the
bytes being compared to {0x00,0x2C,0X00}.
The correct literal should be "\x00\x00\x00" without commas.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Jing Zhou <Jing.Zhou@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
index ce174ce5579c0..6a7c4a59ff4c7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
@@ -271,7 +271,7 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	rate = get_dpcd_link_rate(&lt_settings->link_settings);
 
 	// Only perform toggle if FIXED_VS LTTPR reports no IEEE OUI
-	if (memcmp("\x0,\x0,\x0", &link->dpcd_caps.lttpr_caps.lttpr_ieee_oui[0], 3) == 0) {
+	if (memcmp("\x00\x00\x00", &link->dpcd_caps.lttpr_caps.lttpr_ieee_oui[0], 3) == 0) {
 		/* Vendor specific: Toggle link rate */
 		toggle_rate = (rate == 0x6) ? 0xA : 0x6;
 
-- 
2.51.0


