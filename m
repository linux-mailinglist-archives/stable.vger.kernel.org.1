Return-Path: <stable+bounces-235590-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC9gFNqz2GmshAgAu9opvQ
	(envelope-from <stable+bounces-235590-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 10:24:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAE73D40A6
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 10:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FE6630037CB
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 08:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF413AE1B8;
	Fri, 10 Apr 2026 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQotE9dV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1382D3ACA62;
	Fri, 10 Apr 2026 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775809137; cv=none; b=IrHPjpnRspLXykCgN/VqtDYoiibhqRuf5Slli9xwqA+qKNMCjbUol1fVDzYK3qCOys/WUZ6Xyswcgk3ssaYOgolEtWqkKEEk8kVSuUa/55PS84mpS0bf6mhVwJgWPGXjfGXxdszz54ChFjCW0Njak6re7EVEyQ9f024zARk0XNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775809137; c=relaxed/simple;
	bh=XAJF9Dgd3KEivhPnAw48nGC8xHdyG9h1Y+3SmIViMdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLoTXdrm2wIiMk2TXljpHFPCIhETVec0CXI5ABVI/CrW5qBdd5Os84RS1iNqYbmndr2bQCXEuS+X+DHGlnium3WLIqVRd4Ew/lsDYzaKM6FQ/OGNaH2byeIwzwaFYyRq1CJM5/MqYMRpWEgJ62RI4giiphIpvoi+EJQKFuKcDw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQotE9dV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC3AC2BC9E;
	Fri, 10 Apr 2026 08:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775809136;
	bh=XAJF9Dgd3KEivhPnAw48nGC8xHdyG9h1Y+3SmIViMdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hQotE9dVhzgpJLRHqDWAFXWaR21yRt7U0zxc6K6r1tKvxZFn6abnH3CPj3SOMwOdw
	 nKNXa/UaOZnTpE6y8HL7PoCWFU+HCYOciHbov3LLF7W8OG++IeRvWn2t0BXCcc63qf
	 sM0M3GCHtQUEadMp3WPDzDBZUpbC6tzA7Cr+bHV2SEHjpkl1+pHwJVQv0UrYSQP8G4
	 AirA+8alDEUP0f71WqoDRQfna7/+dCJDPC46QpHfE6KvFrdTCNMb/uC96CXCOiO55h
	 6TzBs6emJB8UVq/NL/PfNKoq8ROa4XFttlbLCmil5EE04HBk65zNbaASgpOR0gM6I1
	 gApf0fifZDfsw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wB74n-000000026uS-3fj8;
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
	stable@vger.kernel.org,
	Purna Chandra Mandal <purna.mandal@microchip.com>
Subject: [PATCH 06/26] spi: pic32: fix controller deregistration
Date: Fri, 10 Apr 2026 10:17:36 +0200
Message-ID: <20260410081757.503099-7-johan@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,collabora.com,nxp.com,pengutronix.de,codeconstruct.com.au,kernel.org,linaro.org,sifive.com,linux.alibaba.com,socionext.com,nvidia.com,amd.com,vger.kernel.org,microchip.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235590-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBAE73D40A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Fixes: 1bcb9f8ceb67 ("spi: spi-pic32: Add PIC32 SPI master driver")
Cc: stable@vger.kernel.org	# 4.7
Cc: Purna Chandra Mandal <purna.mandal@microchip.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-pic32.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 369850d14313..70427e529945 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -821,7 +821,7 @@ static int pic32_spi_probe(struct platform_device *pdev)
 	}
 
 	/* register host */
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&host->dev, "failed registering spi host\n");
 		goto err_bailout;
@@ -840,11 +840,16 @@ static int pic32_spi_probe(struct platform_device *pdev)
 
 static void pic32_spi_remove(struct platform_device *pdev)
 {
-	struct pic32_spi *pic32s;
+	struct pic32_spi *pic32s = platform_get_drvdata(pdev);
+
+	spi_controller_get(pic32s->host);
+
+	spi_unregister_controller(pic32s->host);
 
-	pic32s = platform_get_drvdata(pdev);
 	pic32_spi_disable(pic32s);
 	pic32_spi_dma_unprep(pic32s);
+
+	spi_controller_put(pic32s->host);
 }
 
 static const struct of_device_id pic32_spi_of_match[] = {
-- 
2.52.0


