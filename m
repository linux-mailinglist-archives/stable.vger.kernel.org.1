Return-Path: <stable+bounces-247023-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKPjMTzSBGr0PQIAu9opvQ
	(envelope-from <stable+bounces-247023-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 21:34:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3E953A031
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 21:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC953300490A
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EAD3B6BE3;
	Wed, 13 May 2026 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L35q+T+r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282E834A3A5
	for <stable@vger.kernel.org>; Wed, 13 May 2026 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700858; cv=none; b=MlivBu2kMQ5ENmFwpbjbKf3SmPHlT2/k2MAHp3TU2wanmxyQkgD4bv0aGN+aZLqDAAu6YyVWplFf6CI62ohIUCD6mhtPTf9g7/IWLI95o6BmnteL7fpA4fnJMAYZGZILiC6T/aTQMozLiHzcaOJekRYvtstYC7prw25xn34WLoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700858; c=relaxed/simple;
	bh=bD99+Hczp73/QOzukEvy+BVlW0doGU4r/EWPHwlgLzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUEsCEYrccu+o2888lCq8+MGgA1Z7BQ5F485OENDXS9keAeRrMZlpkKYxori3Bln1B/EGDvOJl+S27J7gplL2whmAhLhBHFnSJK28U2VNI2RGPqP4a8AWrjrjaAAHXgQXRNsDs6+bT1llN+rC6KAC9H7+VKci1JeQ2mK2QwSs/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L35q+T+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBC8C19425;
	Wed, 13 May 2026 19:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778700857;
	bh=bD99+Hczp73/QOzukEvy+BVlW0doGU4r/EWPHwlgLzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L35q+T+r1LU9zUAdwMnqT5IhzDyS5MrrQ1ynwV4rvQewnGYIsn9uLPif1wKHmEEAD
	 s7QC0uEDSgy2WvOOY+xoINyFbiB2H9e+YuWy0nO5e6EemFmMasf1Ft2rfY1toYQAGB
	 m/Q4WUrRqzzObTknSi4TFGnC/jPqTsXvGeN0+gPBX5/OD0xBm8iqUFaGSGgIPlhtc7
	 FcAR42Kfe8DEZ/0css0RcEs2yjQOcDXdn/+/Koq5XRnegtmwh+UUBYmmM/9uWrOVKM
	 TJbUOFqFztjaQdrEC/oCarqS7va+zMuM51GmN10Oxdl+JzFaKWiEjeWAnQWdjQhFhk
	 34Q/U/IEf+I1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] spi: spi-ti-qspi: Convert to platform remove callback returning void
Date: Wed, 13 May 2026 15:34:13 -0400
Message-ID: <20260513193414.3938310-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051215-rebound-collie-a3aa@gregkh>
References: <2026051215-rebound-collie-a3aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7B3E953A031
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247023-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,pengutronix.de:email]
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
index 081da1fd3fd7e..f2ccd264230f7 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -906,21 +906,22 @@ static int ti_qspi_probe(struct platform_device *pdev)
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
@@ -929,7 +930,7 @@ static const struct dev_pm_ops ti_qspi_pm_ops = {
 
 static struct platform_driver ti_qspi_driver = {
 	.probe	= ti_qspi_probe,
-	.remove = ti_qspi_remove,
+	.remove_new = ti_qspi_remove,
 	.driver = {
 		.name	= "ti-qspi",
 		.pm =   &ti_qspi_pm_ops,
-- 
2.53.0


