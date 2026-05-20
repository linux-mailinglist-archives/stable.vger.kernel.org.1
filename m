Return-Path: <stable+bounces-249943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAeBDijJDWo33QUAu9opvQ
	(envelope-from <stable+bounces-249943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:46:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8920958FF67
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 510A830A0C8E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7210F3EAC9B;
	Wed, 20 May 2026 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdxLr59L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568193E9589
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287252; cv=none; b=Ba2sMvh6Ct0NKEpiNXfsij43B7swazL4AIc7FiKZhqf6OHBIQRctcwoQQxoTYc6hGHHcV5l74IeivUBh9YXipfPD2qU4ZmbUcTsFK7zvV/5XYqysKRQErDUDZHBcJUZQdz3pxCp+KRddr1tKBmkhbaiFBeIANhn4Tv4mA86rw5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287252; c=relaxed/simple;
	bh=tvQzNcgYJuWiwJYrbrcog5quYwRzSKcabHNAwmsbrQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ac6sG0WYD3VaSVmZX+TaB4XLd2FCVUfqDawtuyurJVQ9snomSqKA04lnVXnA1zJG07tdtBXRLKpQbcFqN170cLpIPKaC2wTtrW3084SodFOqL1All8kqRsQ0KyuY0AOVs1PnEKjWTm9c2qaxbM5cE4+LKXbpOyrBXevGhWW89CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdxLr59L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEDF1F00896;
	Wed, 20 May 2026 14:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779287249;
	bh=cDpInlaDz/xIlGdRK3/AaVijUnTBxOzExYWxaX25Xig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JdxLr59LVXndWPCZRHEaMNVVDfWbe7t8HVQghfc7f2uzWko1ee+RQl/V7lHXBlaA3
	 R00kSVuC2HXrOuw+QRib54Rw6eOPr9esffW2jUt8H9ZouL5f2bpFV0uLWa5Dy4kwtF
	 kza8sYsGt1nAYpymV7U3baqx3SjcVYmC9d3aMUQqpJcgI0ZPz9BfUCQVOwYKAGPfRK
	 KOnqGqviKz0PlVz6Ul52JF+YEbhpy26dMI4Lqti+MJC9T0BrtJkz1OFznNOVBHtLnV
	 wvo+scqh4cvbN5Ebm5/t3Ktu+Co7upz2XoPqenNYD/FfpbFI+DFNyt1yZn+TJWi6rd
	 LrQg9XFrIoNKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Yash Shah <yash.shah@sifive.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] spi: sifive: fix controller deregistration
Date: Wed, 20 May 2026 10:27:26 -0400
Message-ID: <20260520142726.3646738-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520142726.3646738-1-sashal@kernel.org>
References: <2026051546-turbine-skirmish-96b4@gregkh>
 <20260520142726.3646738-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249943-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,sifive.com:email]
X-Rspamd-Queue-Id: 8920958FF67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 0f25236694a2854627c1597465a071e6bb6fe572 ]

Make sure to deregister the controller before disabling underlying
resources like interrupts during driver unbind.

Note that clocks were also disabled before the recent commit
140039c23aca ("spi: sifive: Simplify clock handling with
devm_clk_get_enabled()").

Fixes: 484a9a68d669 ("spi: sifive: Add driver for the SiFive SPI controller")
Cc: stable@vger.kernel.org	# 5.1
Cc: Yash Shah <yash.shah@sifive.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-15-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sifive.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index 6964d287ae141..683dce55ef302 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -393,7 +393,7 @@ static int sifive_spi_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "mapped; irq=%d, cs=%d\n",
 		 irq, host->num_chipselect);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_host failed\n");
 		goto put_host;
@@ -412,8 +412,14 @@ static void sifive_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct sifive_spi *spi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	/* Disable all the interrupts just in case */
 	sifive_spi_write(spi, SIFIVE_SPI_REG_IE, 0);
+
+	spi_controller_put(host);
 }
 
 static int sifive_spi_suspend(struct device *dev)
-- 
2.53.0


