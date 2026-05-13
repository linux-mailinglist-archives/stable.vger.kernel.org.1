Return-Path: <stable+bounces-247029-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHnjCmbSBGr0PQIAu9opvQ
	(envelope-from <stable+bounces-247029-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 21:35:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A1F53A07D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 21:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7725D303BBA1
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A762D3B6C01;
	Wed, 13 May 2026 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fku/LQ9F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB9B372067
	for <stable@vger.kernel.org>; Wed, 13 May 2026 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700880; cv=none; b=LzK4sjQk8MDFtu5IBEfy2RXu7C2xOQAR92YQ3scB58wOEk2w+TZ6ejuHZXtZUTheK0gRgmn76LjV3iKabq+L0YLFx067yolXTlbWYTw2bhoTbm3NxYvnDdcAaGa1ckQC752AuSzDEksouYSy+zk+XEo1wPKobLpscRNazNbOOSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700880; c=relaxed/simple;
	bh=aK2Y5/q+TChIRS5snl3bGzaHPooO1D9qPHlvwqEv/Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkDOBaU6+rk2AMoiWmj39OuPsbOjE3ui8byuN5ipug8JssZhAhEqjHRQfG4aFTByyRJ7rP6tkMTOVGcCflaCZGgvFwvLnZPRsiTr5LrcYjBf4ceSDwpi+UqzABg8JyB5RYPLDH+Uxuv0ZMulVmyGtuMmWAj+GKHeSDG5UfRi7kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fku/LQ9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECE3C2BCC6;
	Wed, 13 May 2026 19:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778700880;
	bh=aK2Y5/q+TChIRS5snl3bGzaHPooO1D9qPHlvwqEv/Ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fku/LQ9FtLxhYh4C5AbNz3QcI+66I8sbtW0XHUJtcPYS8OSKGIFPBxAIgyb+ti8AD
	 k/GvIbL3zaCGLRlzUknN8LifvreVjhxEqXXhsVE1ncILsOu3epESitRrm5/s9mFLl4
	 O5fBpfdYPeXSE3gPyFve292P79iFzjXUVfKV/RCrdxGkATWnKYuY5WMTRKprkNtDSX
	 43Mat71d7yxhPp7JVP/ZcI8mdI6nCM8CaMdlNqkPz1FpvDq1XkBBZWJiDFszZo09aT
	 bHi2iq+TkRdK7VM6DLf69wExngOV9DknubwI8zj0XYj0WNORHpolNzWiN3e2r930JR
	 LPICmyYxJJ10g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] spi: ti-qspi: fix controller deregistration
Date: Wed, 13 May 2026 15:34:14 -0400
Message-ID: <20260513193414.3938310-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513193414.3938310-1-sashal@kernel.org>
References: <2026051215-rebound-collie-a3aa@gregkh>
 <20260513193414.3938310-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A5A1F53A07D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247029-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email,msgid.link:url]
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 0c18a1bacbb1d8b8aa34d3d004a2cb8226c8b1ea ]

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Note that the controller is suspended before disabling and releasing
resources since commit 3ac066e2227c ("spi: spi-ti-qspi: Suspend the
queue before removing the device") which avoids issues like unclocked
accesses but prevents SPI device drivers from doing I/O during
deregistration.

Fixes: 3b3a80019ff1 ("spi: ti-qspi: one only one interrupt handler")
Cc: stable@vger.kernel.org	# 3.13
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-24-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
[ renamed spi_controller_* API calls to legacy spi_master_* equivalents and qspi->host to qspi->master ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-ti-qspi.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index f2ccd264230f7..d5a4fc70c45f8 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -894,7 +894,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	qspi->mmap_enabled = false;
 	qspi->current_cs = -1;
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = spi_register_master(master);
 	if (!ret)
 		return 0;
 
@@ -909,19 +909,17 @@ static int ti_qspi_probe(struct platform_device *pdev)
 static void ti_qspi_remove(struct platform_device *pdev)
 {
 	struct ti_qspi *qspi = platform_get_drvdata(pdev);
-	int rc;
 
-	rc = spi_master_suspend(qspi->master);
-	if (rc) {
-		dev_alert(&pdev->dev, "spi_master_suspend() failed (%pe)\n",
-			  ERR_PTR(rc));
-		return;
-	}
+	spi_master_get(qspi->master);
+
+	spi_unregister_master(qspi->master);
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	ti_qspi_dma_cleanup(qspi);
+
+	spi_master_put(qspi->master);
 }
 
 static const struct dev_pm_ops ti_qspi_pm_ops = {
-- 
2.53.0


