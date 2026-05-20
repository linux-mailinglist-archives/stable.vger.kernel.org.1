Return-Path: <stable+bounces-251657-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMLmFx4dDmro6AUAu9opvQ
	(envelope-from <stable+bounces-251657-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:44:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BF659A05D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2481D34FA8A5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6613D7D66;
	Wed, 20 May 2026 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bmx8/nWl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF353C870E;
	Wed, 20 May 2026 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298556; cv=none; b=tHmdmucUPUt2b/Z0onN92t0q2cVZI9DO1vVcawp7EkFGqBx9xs+tyEVUpsQlogU4V2HkZ+E/EtVdDFXKXSdnAgDF9lPYwL1br3ANFiQ1ltgH2Wqnr4RKAPnyHUt/MQ8PyidgT0vI0QIfKuFHDk/M9KX8ge/H6/+6VyHw4hz0fOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298556; c=relaxed/simple;
	bh=Q0etmJpfj3iKhfJXh77TxHiAmrG8QHL3Ob+k/koD0+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQ5khol+Pctt7C43e1kRFGj89+B2i3UmAIaF9GpIUfxAOgn3fEaN2T3xd4OWz0hLzOrjA7C2grunG6yYJNOyoE5j4QyGdw7Sv+gNA80HJkPTOobGwoF4WlnAtqUh6DQJpocRFPFuve0whZV4Qn8OIo1ZO54Qi0nGtmtVh/lK2Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bmx8/nWl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CDF1F00893;
	Wed, 20 May 2026 17:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298551;
	bh=j+U8A/kyOQ9op2/1JRc3OCpFKnN7s/0GS4kMVYr5Xek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bmx8/nWl0ZfslObb2bcCsxgpZEb79kO2OnT2+HXtdW3kFR/FkndH0rPj0rbEHsj0m
	 AClaRbRLBtUeXVMvVE8970cJvmqNLPpG4btzQRwECiBFH1Ryg7vV8kNT221O/Oo3dU
	 JsDZ9jO/WAI/LiUHcNYhJXnyHAQ71z3kMGQQtA4M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Francesco Lavra <flavra@baylibre.com>,
	Dipen Patel <dipenp@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 455/957] hte: tegra194: remove Kconfig dependency on Tegra194 SoC
Date: Wed, 20 May 2026 18:15:38 +0200
Message-ID: <20260520162144.390685974@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251657-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,baylibre.com:email,nvidia.com:email]
X-Rspamd-Queue-Id: B1BF659A05D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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




