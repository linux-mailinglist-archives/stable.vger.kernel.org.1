Return-Path: <stable+bounces-235586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH6PLn2y2Gk8hAgAu9opvQ
	(envelope-from <stable+bounces-235586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 10:19:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5393D3E7C
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 10:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 918A030147AA
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 08:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8D13ACF1D;
	Fri, 10 Apr 2026 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKIAyxSv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DDB3AC0D4;
	Fri, 10 Apr 2026 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775809137; cv=none; b=ruMKRAfmi6PoK4eSSpO3GNjuFXwvbngipb9RfE5vtTrXu36vJ1PIz2HqfGeRA7kh6f8gOsl67FzXu0yqgQdfiAiQdpFiIGoomdnLy1LCkq8f3gwZkoUR6RgI+SBDDvgd4oTpkxsqsHDrqOspflEf17/sYm2ScG2o80gyX4EoUFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775809137; c=relaxed/simple;
	bh=myVQNTSRrfMEDMsyrLlgY1ej6c3ouUnZhQiGPsvtHZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqCS5uCzBXAYLQpBZCddyaJBEgEO5yBD2lBD3EacmgL0Cn6YAqjyyrQ8yes6E1w8ANoukxuE0qT0GpqzptaDh2LwYvITA+B39xJTfcskOwsganbDjjhn7UmKiT5HUlmAZ57vRckG8zldGHZyIAugDRbIbtNrRR2oADdrrOaunL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKIAyxSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F79CC2BCB0;
	Fri, 10 Apr 2026 08:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775809136;
	bh=myVQNTSRrfMEDMsyrLlgY1ej6c3ouUnZhQiGPsvtHZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WKIAyxSv5w+8fgD+6Juh3XTOrSOeHolzeA+APACpvVSjYHKFdl7yWmjzZPtsXMRs6
	 c1sOSA6RoYqH4MCIcfmB5OtQIrVPrEUo5FYiF36ue/k74rpkhfAkNYEPRdKC5pISnf
	 x6XWkEJdPPnAKMcANpQjQrzjLPw0/t1UlHxEuuJH+1iRuI6ffpQFwnXqiyZewHOnG9
	 3FI2Y3NxfexwGxnnZhO/XdNgVxdsLTTbgz+6E408odJVr+AAU0vgLXvB46dYGCaqxA
	 /APFRRWL5r/78oD6Pj33DQnijQp/7D/4nbb2c0czWWMYv6tlvt9q00+95qzjUOCYSh
	 y4PsJ9XWCeVhA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wB74n-000000026uQ-3dJW;
	Fri, 10 Apr 2026 10:18:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 05/26] spi: omap2-mcspi: fix controller deregistration
Date: Fri, 10 Apr 2026 10:17:35 +0200
Message-ID: <20260410081757.503099-6-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410081757.503099-1-johan@kernel.org>
References: <20260410081757.503099-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,collabora.com,nxp.com,pengutronix.de,codeconstruct.com.au,kernel.org,linaro.org,sifive.com,linux.alibaba.com,socionext.com,nvidia.com,amd.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235586-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF5393D3E7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Fixes: ccdc7bf92573 ("SPI: omap2_mcspi driver")
Cc: stable@vger.kernel.org	# 2.6.23
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index a3468e47e77d..56b30ff58771 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1592,7 +1592,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	if (status < 0)
 		goto disable_pm;
 
-	status = devm_spi_register_controller(&pdev->dev, ctlr);
+	status = spi_register_controller(ctlr);
 	if (status < 0)
 		goto disable_pm;
 
@@ -1613,11 +1613,17 @@ static void omap2_mcspi_remove(struct platform_device *pdev)
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 	struct omap2_mcspi *mcspi = spi_controller_get_devdata(ctlr);
 
+	spi_controller_get(ctlr);
+
+	spi_unregister_controller(ctlr);
+
 	omap2_mcspi_release_dma(ctlr);
 
 	pm_runtime_dont_use_autosuspend(mcspi->dev);
 	pm_runtime_put_sync(mcspi->dev);
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(ctlr);
 }
 
 /* work with hotplug and coldplug */
-- 
2.52.0


