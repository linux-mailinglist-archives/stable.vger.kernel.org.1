Return-Path: <stable+bounces-247004-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBGHL8LCBGqiNgIAu9opvQ
	(envelope-from <stable+bounces-247004-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:28:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FE5538F30
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24022307F0EA
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311883A7580;
	Wed, 13 May 2026 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Owku+W5d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84AC3321B1
	for <stable@vger.kernel.org>; Wed, 13 May 2026 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696421; cv=none; b=PbWrMjc6x/CW2FNJE38PNhl5AHhEIe95wMHr322QnCUxNqA0gE5CpY/yuYvqVA3y1DahuPXAK1EdZtzROa0MmfHTjcF4Cq4iHJ5gKoFhhh6vOc2Ru3o0RKPUJrY0McVNdrekjlcawxSvr4XbuqGQ2WJnoSNXTAY5DgJorp1lOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696421; c=relaxed/simple;
	bh=DtmkQ5EXOXfJFto2cOz/r/cl2ekVXvjpzRBh8G0mgFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWFjrIHV2eqOLRyuMfUfCjhJu0d4dqzY0nEd2cjuH5BZNdTPIHAVhP+pmH+/THEiSJ6NmocedSe/XRyQM/LaRMW7JIGNL5rT6KDXE83cnTb57aqza1u/EBLbV8Ialpz6R00y5Z4a4f9LdJ4YCuCLN6W1VkV5qI4izMuvLSjKvYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Owku+W5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B7CC2BCF5;
	Wed, 13 May 2026 18:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778696420;
	bh=DtmkQ5EXOXfJFto2cOz/r/cl2ekVXvjpzRBh8G0mgFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Owku+W5d8ultkPsx5oPlb2vSNT9IMs7T8jHzx3JRPZHQMhhQqQJVMziXUhBnZbZhs
	 Zw22h7zKczliA6D2cyfKbuNJW7pBztxNk3JTEIRbCZCUukvRTbOOv4vg+FYrtxMWRS
	 y95LujJQZd6c/jNlUchs/wSu2Y5oSsHde8A/PYhBPxf8fdUMk0IxAu8vSAIarwetPy
	 rgxEYn6VmyX6otH403YbjDAU+VlulUSEIu2fhON3ji6LTo76rm6jMFxFf9y+aS7IP5
	 xTn0gw+O6UFcdxkHmRbUKb9j78z541mdx/3949HpPiuW8DG3O6fGFsvLMcFxX3IL1B
	 N9h+H7eWR2DVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] spi: spi-ti-qspi: Convert to platform remove callback returning void
Date: Wed, 13 May 2026 14:20:15 -0400
Message-ID: <20260513182017.3918352-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513182017.3918352-1-sashal@kernel.org>
References: <2026051215-exclusion-jargon-8c4e@gregkh>
 <20260513182017.3918352-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E6FE5538F30
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247004-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Action: no action

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 2f2802d1a59d79a3d00cb429841db502c2bbc3df ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Add an error message to the error path that returned an error before to
replace the core's error message with more information. Apart from the
different wording of the error message, this patch doesn't introduce a
semantic difference.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20231105172649.3738556-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 0c18a1bacbb1 ("spi: ti-qspi: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-ti-qspi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 4c17b6ae5c967..8b488b9aacbd6 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -908,21 +908,22 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ti_qspi_remove(struct platform_device *pdev)
+static void ti_qspi_remove(struct platform_device *pdev)
 {
 	struct ti_qspi *qspi = platform_get_drvdata(pdev);
 	int rc;
 
 	rc = spi_master_suspend(qspi->master);
-	if (rc)
-		return rc;
+	if (rc) {
+		dev_alert(&pdev->dev, "spi_master_suspend() failed (%pe)\n",
+			  ERR_PTR(rc));
+		return;
+	}
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	ti_qspi_dma_cleanup(qspi);
-
-	return 0;
 }
 
 static const struct dev_pm_ops ti_qspi_pm_ops = {
@@ -931,7 +932,7 @@ static const struct dev_pm_ops ti_qspi_pm_ops = {
 
 static struct platform_driver ti_qspi_driver = {
 	.probe	= ti_qspi_probe,
-	.remove = ti_qspi_remove,
+	.remove_new = ti_qspi_remove,
 	.driver = {
 		.name	= "ti-qspi",
 		.pm =   &ti_qspi_pm_ops,
-- 
2.53.0


