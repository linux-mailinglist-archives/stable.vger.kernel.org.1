Return-Path: <stable+bounces-229410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOwfKU5kwWmaSgQAu9opvQ
	(envelope-from <stable+bounces-229410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:03:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C1A2F7506
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0CC9307D438
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE133B3BFC;
	Mon, 23 Mar 2026 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EyvoOiVW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEAB3B3885;
	Mon, 23 Mar 2026 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279159; cv=none; b=Bf0J2kUwSy4IVVLK/yUD7cZCwGKvs3NoLC7Dxl60qdlQQ3dEbprMIM6Vj5FpXymDontzI0ffsV2cilryZaOsXUOLeE/jmjWi9qd3FVHXo58Iy6VoHW5QtO915NKQYOIR8SAfI/Cdf0Yc7WqMpH4ENrwBKJ9UqfxxpKzcfy1jhY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279159; c=relaxed/simple;
	bh=KabduQCXeSf156MymVBibv7BRT9X4Hs2r6c8XPrSEps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5dkfXADnE7f6cwPGvnaE795xnuLlIhnEwAynEpn+grcI+IzftCD7iCO8ECc/EdsIXxOeLLZ9bM5htYIrQqdyOSbjJRZIsg4ThawWgBQU2zXsSPMZUkdlvpdgI5wxXS8StD/eJsOHIJrya5poFb6vnBvJosGwc6Dctlo2OZPjuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EyvoOiVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B939C4CEF7;
	Mon, 23 Mar 2026 15:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774279158;
	bh=KabduQCXeSf156MymVBibv7BRT9X4Hs2r6c8XPrSEps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EyvoOiVW/kxMjX48OSE//kFH4FI4GYm8NGI0tGFzWSqzUaCSGZRuQEGqavSO0C/ZK
	 Rgfc8Uv9vHSSlnPeWDpHGyJ/OSfurGyKtTY4OSuZxXM3/j/f9pg5wZA8t1wpgs1amk
	 AG9sgd3m+Zf7ofmv9VhW5Jul5D/R1R2BHMbKFcL4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 494/567] drm/amdgpu: apply state adjust rules to some additional HAINAN vairants
Date: Mon, 23 Mar 2026 14:46:54 +0100
Message-ID: <20260323134546.243966935@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229410-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0C1A2F7506
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 9787f7da186ee8143b7b6d914cfa0b6e7fee2648 upstream.

They need a similar workaround.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1839
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 0de31d92a173d3d94f28051b0b80a6c98913aed4)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3440,9 +3440,11 @@ static void si_apply_state_adjust_rules(
 	if (adev->asic_type == CHIP_HAINAN) {
 		if ((adev->pdev->revision == 0x81) ||
 		    (adev->pdev->revision == 0xC3) ||
+		    (adev->pdev->device == 0x6660) ||
 		    (adev->pdev->device == 0x6664) ||
 		    (adev->pdev->device == 0x6665) ||
-		    (adev->pdev->device == 0x6667)) {
+		    (adev->pdev->device == 0x6667) ||
+		    (adev->pdev->device == 0x666F)) {
 			max_sclk = 75000;
 		}
 		if ((adev->pdev->revision == 0xC3) ||



