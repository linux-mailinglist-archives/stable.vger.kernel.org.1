Return-Path: <stable+bounces-249908-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM3dF1avDWrW1QUAu9opvQ
	(envelope-from <stable+bounces-249908-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:55:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A0B58E4E4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C0463006B4B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0BD3E274F;
	Wed, 20 May 2026 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/3+0Mlh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB72F3E0C56
	for <stable@vger.kernel.org>; Wed, 20 May 2026 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281746; cv=none; b=LL0CuDaptM01QScV7gig4she/IpXry+YLoQd3VnGF7oMXwr7vnQgUKOy2nD7dSm4QosfRVNUAVjBnlJcz5ByFNrRd4ss1fIOVGdbSheigz7/z2XHbgQtEqLiR1gzH33WY+zu7mOJTVWjXm8ZZ8y0u8SKTRIpttm5YkI5gKaHLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281746; c=relaxed/simple;
	bh=kQqoICgWYcF9EhTVCWjl6d8enjOFRr1mVruuG2WSTHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WC//L2H/KxxUKkIS7jvO5y0GzaY9Q/OITehETUwW1/XfHXlQfe+7V5XXF3sFuyysUiS3bbhqEVmdhU3PjYacxJm1dddiXV8lRUfDh2QQZW8ZQ7CwT6hhkbIe3v0ew6u0gJtw7rgvAzRoLLaToKSd2N+82Yni8sB7BtWXIqcUHOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/3+0Mlh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73101F000E9;
	Wed, 20 May 2026 12:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779281743;
	bh=OvxVqXtAKOcNYGY0rlDdwQd524hoVyUF8qJ0kJeDltw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I/3+0Mlh2lmGctdporDyLiRbotMpJSOhDn0xoK6c7cgDBYWlH2YGzaF1E16yyBYM3
	 l9DB5Z0Ebgac4f+ZgVXklSQIUu+YBqqWlPBc0GM6p5SSerwRdLE3wfKOmQ5vtNSZEN
	 mXK2ibgj82b1t9jseRzy2LGceivwCuvuNMr3i8vCr9alN4SfbAPXhK2PUC1tJhjcZ5
	 MbB0qLL7T72aah1Xc0M7CgqzhF/QXnqgE6TwX/MPQTnZetnC7qNZ2Ev2w5cYb0D8XS
	 XuTU4VIlbLfv4aw0VwYFU/aWCaR+JI9nGj3/C7IathFYvRbfZejDAQBBM3sd3bMjU8
	 GB1qbs33PvgOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 1/2] spi: sifive: Simplify clock handling with devm_clk_get_enabled()
Date: Wed, 20 May 2026 08:55:40 -0400
Message-ID: <20260520125541.3536279-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051546-gestation-vessel-153b@gregkh>
References: <2026051546-gestation-vessel-153b@gregkh>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249908-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Queue-Id: 04A0B58E4E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pei Xiao <xiaopei01@kylinos.cn>

[ Upstream commit 140039c23aca067b9ff0242e3c0ce96276bb95f3 ]

Replace devm_clk_get() followed by clk_prepare_enable() with
devm_clk_get_enabled() for the bus clock. This reduces boilerplate code
and error handling, as the managed API automatically disables the clock
when the device is removed or if probe fails.

Remove the now-unnecessary clk_disable_unprepare() calls from the probe
error path and the remove callback. Adjust the error handling to use the
existing put_host label.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Link: https://patch.msgid.link/73d0d8ecb4e1af5a558d6a7866c0f886d94fe3d1.1773885292.git.xiaopei01@kylinos.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 0f25236694a2 ("spi: sifive: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sifive.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index 6c7aba8befa07..54adbc057af62 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -312,7 +312,8 @@ static int sifive_spi_probe(struct platform_device *pdev)
 		goto put_host;
 	}
 
-	spi->clk = devm_clk_get(&pdev->dev, NULL);
+	/* Spin up the bus clock before hitting registers */
+	spi->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(spi->clk)) {
 		dev_err(&pdev->dev, "Unable to find bus clock\n");
 		ret = PTR_ERR(spi->clk);
@@ -342,13 +343,6 @@ static int sifive_spi_probe(struct platform_device *pdev)
 		goto put_host;
 	}
 
-	/* Spin up the bus clock before hitting registers */
-	ret = clk_prepare_enable(spi->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Unable to enable bus clock\n");
-		goto put_host;
-	}
-
 	/* probe the number of CS lines */
 	spi->cs_inactive = sifive_spi_read(spi, SIFIVE_SPI_REG_CSDEF);
 	sifive_spi_write(spi, SIFIVE_SPI_REG_CSDEF, 0xffffffffU);
@@ -357,14 +351,14 @@ static int sifive_spi_probe(struct platform_device *pdev)
 	if (!cs_bits) {
 		dev_err(&pdev->dev, "Could not auto probe CS lines\n");
 		ret = -EINVAL;
-		goto disable_clk;
+		goto put_host;
 	}
 
 	num_cs = ilog2(cs_bits) + 1;
 	if (num_cs > SIFIVE_SPI_MAX_CS) {
 		dev_err(&pdev->dev, "Invalid number of spi targets\n");
 		ret = -EINVAL;
-		goto disable_clk;
+		goto put_host;
 	}
 
 	/* Define our host */
@@ -392,7 +386,7 @@ static int sifive_spi_probe(struct platform_device *pdev)
 			       dev_name(&pdev->dev), spi);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to bind to interrupt\n");
-		goto disable_clk;
+		goto put_host;
 	}
 
 	dev_info(&pdev->dev, "mapped; irq=%d, cs=%d\n",
@@ -401,13 +395,11 @@ static int sifive_spi_probe(struct platform_device *pdev)
 	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_host failed\n");
-		goto disable_clk;
+		goto put_host;
 	}
 
 	return 0;
 
-disable_clk:
-	clk_disable_unprepare(spi->clk);
 put_host:
 	spi_controller_put(host);
 
@@ -421,7 +413,6 @@ static void sifive_spi_remove(struct platform_device *pdev)
 
 	/* Disable all the interrupts just in case */
 	sifive_spi_write(spi, SIFIVE_SPI_REG_IE, 0);
-	clk_disable_unprepare(spi->clk);
 }
 
 static int sifive_spi_suspend(struct device *dev)
-- 
2.53.0


