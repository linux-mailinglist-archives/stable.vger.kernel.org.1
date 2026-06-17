Return-Path: <stable+bounces-266858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ht/yJn3XMmpV6AUAu9opvQ
	(envelope-from <stable+bounces-266858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 19:21:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F1A69BA47
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 19:21:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=osYshPbi;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266858-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266858-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1755C309A430
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 17:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A11635CBCB;
	Wed, 17 Jun 2026 17:20:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCED35202E
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:20:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716856; cv=none; b=sifl08+dsGb0XVTOUdHqOhflcOPKfIjQvgic9gBIuBVqiDGUtj+9qmn4qjYY5bX2qoN5qxqvoMDTxQyPmpGPDjx/pAjlJUug8PwH78BvLS4qnOc3NC+ZBPJ3kemqeidBiwVCXS1h2rrxwo8w/iDalxlfOPODhEEcpayHhwkVH2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716856; c=relaxed/simple;
	bh=Lya4g+uomsQwd3HMuDRsAT0+gs/fuadRtVEUxPbxC8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCUGtE2sBjXKjqH9oL/BoNPhGIlEWkwtv8cNgPZYpCySZCQXxzY/g2Ijve4LhVwmZRshzCo7gGiRLzP4tObgrpe3DgyNCNqfz2EPwM2gP/KMYzbhCZnrDin3/fCNdXI3IsRgc54fZY8ROx3YJCcjlo4mhELcpBdKShoTvDZALdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osYshPbi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA921F000E9;
	Wed, 17 Jun 2026 17:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781716853;
	bh=Yg5cghdxpiYTphg8yIVUhNZNR5s3/C2j5/DgCaF19+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=osYshPbiIjMD1AV0c5GRB/9+LnnqzuylxZlxl4e+pTAzYYhsoPc3aPmiG2TfCK9TP
	 9oLUWPIyOp2XHyrkxTbwPVd8bRuf9aRZ8MrK7iyBQntEf3ZEpsBaTy/iK3FYwhKvss
	 SrmGjwDZgrubylMZ9zXLVOzHdDAH3aMf8V90sjQ7uMXznAidL0CwpCu65X4BNt3wl4
	 Lu39GhnEi7r79B8QphGLflwHjBA1LWuLhhkQ2kMx96OOX+uA3LpgpLKW6XyGIuXdAV
	 KduJU4Eyg1iwxxYqwGRe5g2JbB69Giz3p7RC5hpgcumPvVmdJG/qzqMAXZRABNe/Kc
	 hgkHajzlrpUhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mmc: renesas_sdhi: Add OF entry for RZ/G2H SoC
Date: Wed, 17 Jun 2026 13:20:51 -0400
Message-ID: <20260617172051.253322-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061546-plexiglas-flaky-762c@gregkh>
References: <2026061546-plexiglas-flaky-762c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266858-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:wsa+renesas@sang-engineering.com,m:geert+renesas@glider.be,m:ulfh@kernel.org,m:sashal@kernel.org,m:wsa@sang-engineering.com,m:geert@glider.be,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,renesas.com:email,sang-engineering.com:email,glider.be:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19F1A69BA47

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit f48ee49726ee4ab545fd2dc644f169c0809b19b3 ]

The RZ/G2H (R8A774E1) SoC was previously handled via the generic
"renesas,rcar-gen3-sdhi" fallback compatible string. However, because
the SDHI IP on RZ/G2H is identical with the R-Car H3-N (R8A77951), it
requires the specific quirks and configuration defined in
`of_r8a7795_compatible` rather than the generic Gen3 data.

Add the explicit "renesas,sdhi-r8a774e1" match entry to map it correctly.
Note that the DT binding file renesas,sdhi.yaml does not need an update
as the entry for this SoC is already present.

Fixes: 31941342888d ("arm64: dts: renesas: r8a774e1: Add SDHI nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index f3e76d6b3e3fe3..1082e2cb399e1d 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -119,6 +119,7 @@ static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r7s9210", .data = &of_rza2_compatible, },
 	{ .compatible = "renesas,sdhi-mmc-r8a77470", .data = &of_rcar_gen3_compatible, },
+	{ .compatible = "renesas,sdhi-r8a774e1", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7795", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7796", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,rcar-gen3-sdhi", .data = &of_rcar_gen3_compatible, },
-- 
2.53.0


