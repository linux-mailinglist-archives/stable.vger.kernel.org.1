Return-Path: <stable+bounces-234339-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANQFHOWd1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234339-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:26:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E33F73C0B8F
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66654308B520
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F99D3D9DC0;
	Wed,  8 Apr 2026 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Og239uWC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9543D9DB9;
	Wed,  8 Apr 2026 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672603; cv=none; b=KZlrXmZO1UICPxs8FnGtHF7ePezX7imoN3hNE/ZlskXoIkVh30byYf/nwCVJZs0fv7tfLX68dhnC5TlQhH+zw/gFQktfFb8Z8TX4hr4HyQtugxJDZujzKadX07mIrnadKzBhB/aDtgkhepXpWjYRQ4xDOsV1Epi85dD3tQ4mb3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672603; c=relaxed/simple;
	bh=WSwL3g6f4zZHQ70gr80pMGb7jGT5ykUrxawm440uQZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWsG+AIoZUcBGR3zCEBUV1u/Xe/bM0M66TgE9sur8qJDPvvA+/y+emzQhyXvUQNqWIL2bxmRafgy/4ThNr0LpkRbjyQ3sBXSeX5EUz8hRshvKDKP8/lGu8KhN0qIZfcY7lQ3Gf+h7akuiAe30YEexDzvHewjQ78qn1PkpJkhBVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Og239uWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28D0C19421;
	Wed,  8 Apr 2026 18:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672603;
	bh=WSwL3g6f4zZHQ70gr80pMGb7jGT5ykUrxawm440uQZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Og239uWCvJb2xIkadMcoDea8S2ooZC2wC2nmS+YKJ48GJkIQr4/oDxQhCFWCesnzI
	 YHPzUcErzgxVCuDdERcSv0ufg4U/1DhcyY6QG6sdCqXXjPUs2AE3YtPZIX7cdgMFXI
	 nVGJDJDaSRN06YdXkdC01RRGtAkbd7122RnIKhOI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	Shiji Yang <yangshiji66@outlook.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 071/160] mips: ralink: update CPU clock index
Date: Wed,  8 Apr 2026 20:02:38 +0200
Message-ID: <20260408175915.852997742@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
References: <20260408175913.177092714@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-234339-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,yahoo.com,outlook.com,gmail.com,alpha.franken.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[franken.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: E33F73C0B8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shiji Yang <yangshiji66@outlook.com>

[ Upstream commit 43985a62bab9d35e5e9af41118ce2f44c01b97d2 ]

Update CPU clock index to match the clock driver changes.

Fixes: d34db686a3d7 ("clk: ralink: mtmips: fix clocks probe order in oldest ralink SoCs")
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/ralink/clk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/ralink/clk.c b/arch/mips/ralink/clk.c
index 9db73fcac522e..5c1eb46ef5d07 100644
--- a/arch/mips/ralink/clk.c
+++ b/arch/mips/ralink/clk.c
@@ -21,16 +21,16 @@ static const char *clk_cpu(int *idx)
 {
 	switch (ralink_soc) {
 	case RT2880_SOC:
-		*idx = 0;
+		*idx = 1;
 		return "ralink,rt2880-sysc";
 	case RT3883_SOC:
-		*idx = 0;
+		*idx = 1;
 		return "ralink,rt3883-sysc";
 	case RT305X_SOC_RT3050:
-		*idx = 0;
+		*idx = 1;
 		return "ralink,rt3050-sysc";
 	case RT305X_SOC_RT3052:
-		*idx = 0;
+		*idx = 1;
 		return "ralink,rt3052-sysc";
 	case RT305X_SOC_RT3350:
 		*idx = 1;
-- 
2.53.0




