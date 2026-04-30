Return-Path: <stable+bounces-242188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMg6B+Ob82kx5QEAu9opvQ
	(envelope-from <stable+bounces-242188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:13:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 228724A6BEA
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F008C300623C
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F642D7814;
	Thu, 30 Apr 2026 18:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQ09D3It"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DC747A0B4
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777572828; cv=none; b=FqeTZO/iTn3kPDCabWkUUrGAcfIQc6Z61NuFnTBoSwtieIsIv2/bvNjsP9SFS1GfAQFoD4HEukcSyg5ojFlLlZfDbpjpwWkI3J99Q31CAuuuWfBU6N6saRVQGFX02Iwgy9oECoBflpJo1Vg9IKTyCF8WDd1+7zWsosn4WRu5x/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777572828; c=relaxed/simple;
	bh=L/5U++biNDMBUtPbxgH5ptjaeBsGBMVEMMUNS5TFPsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tt4I5mnYwy7MGEelMLy+uO34XR0DZPkkMwD7e509ejaPPBe0puW5FIxuOMMY4GRPhdRj/g4SZlyZ5AGF5BGHuCZnopYzzTiLcJcRt98FJNPy3RFu7s0wl+Mf7dZ5CyNmfqv+G+02xw7SOoWMOqaILJsAwpLJVbCQ+7+tO9HCToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQ09D3It; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB04C2BCB8;
	Thu, 30 Apr 2026 18:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777572827;
	bh=L/5U++biNDMBUtPbxgH5ptjaeBsGBMVEMMUNS5TFPsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WQ09D3ItI6qPg5PtAZDeNO4SogJvHu3TsEyV9mf80jpa4+D/XxSIESJSM06PBfNev
	 almQpmPCBKOdTpT3m+yNQEnA0AfmeYgKhe5Kdu/oKokM47O6mDTxJyHj+QyzQgGwXB
	 1B11hVE6fTJGJVohyLWGPJzMZUn3GeVFyBwOd3jkrjB71xpUqxpvWiGHwzy+3ZDVlu
	 CllUr8QKV5Hq7Rf1G/LMaV4N0S5jUf7SpIlbwoQ+thQnzPjwrFeVLwMuCYth+qYYNg
	 evYA2Gc5dxYaPq+Otg/PESPW6BggXixlpxAoJdOQBGA6yNIM68wkzxs4q12+du/5kj
	 rydbIhn0cyMiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] spi: imx: Convert to platform remove callback returning void
Date: Thu, 30 Apr 2026 14:13:43 -0400
Message-ID: <20260430181344.1923600-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026043052-amplify-gag-dbbc@gregkh>
References: <2026043052-amplify-gag-dbbc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 228724A6BEA
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-242188-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 423e548127223d597bb65a149ebcb3c50ea08846 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20230306065733.2170662-3-u.kleine-koenig@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 1c78c2002380 ("spi: imx: fix use-after-free on unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-imx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index e929a5af38eea..9bf9ded1de1ea 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1878,7 +1878,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int spi_imx_remove(struct platform_device *pdev)
+static void spi_imx_remove(struct platform_device *pdev)
 {
 	struct spi_controller *controller = platform_get_drvdata(pdev);
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
@@ -1897,8 +1897,6 @@ static int spi_imx_remove(struct platform_device *pdev)
 	pm_runtime_disable(spi_imx->dev);
 
 	spi_imx_sdma_exit(spi_imx);
-
-	return 0;
 }
 
 static int __maybe_unused spi_imx_runtime_resume(struct device *dev)
@@ -1960,7 +1958,7 @@ static struct platform_driver spi_imx_driver = {
 		   .pm = &imx_spi_pm,
 	},
 	.probe = spi_imx_probe,
-	.remove = spi_imx_remove,
+	.remove_new = spi_imx_remove,
 };
 module_platform_driver(spi_imx_driver);
 
-- 
2.53.0


