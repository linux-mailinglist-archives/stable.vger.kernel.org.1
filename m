Return-Path: <stable+bounces-252498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNKQEuv6DWru5AUAu9opvQ
	(envelope-from <stable+bounces-252498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:18:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B815D595C0D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94D82305DA81
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1923C2F363F;
	Wed, 20 May 2026 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VXRkPfGp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99D733B97A;
	Wed, 20 May 2026 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300830; cv=none; b=fOuY5PiDpDo3R+wvjQRbdRvrfm6vTe23h9JTvOqBKMZX2ea76zay7YilV3vwc/GAFS/dlT+3zqyT5/OtGLBoxHFLDd3dbAr+LqgYpV67q6dv5G0pnWczqp5Xo2ACj7WqwXVi64k3kSjBFjaRislcd8LrwgDAfGa8wIEe51OugfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300830; c=relaxed/simple;
	bh=nwGYYHSgDfINggeHCbjpvfGZxrMDKtcKblu6S51nkQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmrpws56KNFXwkC5faH/bbQalTvRukpHVlBaOPHwuyPvy1M36L71QA5D364xEcC+ABJpmWSP6EOSf7a0LpIU7ngWHZSM+UXDFtIPY05ugNaTl/gt0j28702bx9BbHMnygbhtBzuLo1S854XZzfF9v5Ga7Jw3kZH31Jlc25muJB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VXRkPfGp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA611F000E9;
	Wed, 20 May 2026 18:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300829;
	bh=6AY0IG+KRF0fRcRC0pUtQHDs7AQeUBabFWqvKjka2HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VXRkPfGpUOdcXPGc3+wijq87Hl4o3ZjsX/AKl6zbQSXMPWoWDY0tj1FqqB+149agQ
	 s+gNzkCh17FFPQkgvNLCnAziF/LCZuYtqczO/7rvj6BuFlBJFimaRVG6EEZqVdgntJ
	 gcaOQg56PYzpVVtaSScEQxxnilldh5xPDd14hydY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Francesco Lavra <flavra@baylibre.com>,
	Dipen Patel <dipenp@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 324/666] hte: tegra194: remove Kconfig dependency on Tegra194 SoC
Date: Wed, 20 May 2026 18:18:55 +0200
Message-ID: <20260520162118.246806400@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252498-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,baylibre.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: B815D595C0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Francesco Lavra <flavra@baylibre.com>

[ Upstream commit 92dfd92f747698352b256cd9ddd7497bb7ebe9c8 ]

This driver runs also on other Tegra SoCs (e.g. Tegra234).
Replace Kconfig dependency on Tegra194 with more generic dependency on
Tegra, and amend the Kconfig help text to reflect the fact that this
driver works on SoCs other than Tegra194.

Fixes: b003fb5c9df8 ("hte: Add Tegra234 provider")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Acked-by: Dipen Patel <dipenp@nvidia.com>
Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hte/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hte/Kconfig b/drivers/hte/Kconfig
index 641af722b555d..f57bad67deef0 100644
--- a/drivers/hte/Kconfig
+++ b/drivers/hte/Kconfig
@@ -16,13 +16,13 @@ if HTE
 
 config HTE_TEGRA194
 	tristate "NVIDIA Tegra194 HTE Support"
-	depends on (ARCH_TEGRA_194_SOC || COMPILE_TEST)
+	depends on (ARCH_TEGRA || COMPILE_TEST)
 	depends on GPIOLIB
 	help
 	  Enable this option for integrated hardware timestamping engine also
 	  known as generic timestamping engine (GTE) support on NVIDIA Tegra194
-	  systems-on-chip. The driver supports 352 LIC IRQs and 39 AON GPIOs
-	  lines for timestamping in realtime.
+	  and later systems-on-chip. The driver supports 352 LIC IRQs and 39
+	  AON GPIOs lines for timestamping in realtime.
 
 config HTE_TEGRA194_TEST
         tristate "NVIDIA Tegra194 HTE Test"
-- 
2.53.0




