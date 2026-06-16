Return-Path: <stable+bounces-265665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZP9PCmyNMWrnmQUAu9opvQ
	(envelope-from <stable+bounces-265665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:52:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1835693936
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:52:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="fL8MWQ/M";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265665-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-265665-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D64E303CF06
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89F74779B1;
	Tue, 16 Jun 2026 17:52:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9A1472771;
	Tue, 16 Jun 2026 17:52:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632359; cv=none; b=bl4wWtyNc4W2ePBMF13rXIO1sUp3ENV4gpmBQ2ZsE2YqQTISxLhQJ8XHj75c4d47HVq1OgOdIgqX3vvhgyvHuDNX76hxghJuC5liiDYBm+Lh7UAxu2NrDYafXGnelpXBb6r81TyBiyhM960yZMkQbfuAR1AyGzTTOobgaTkkQHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632359; c=relaxed/simple;
	bh=IiiQGSoqXh+sWdr6dJWhgLCSL1XMeFVxcxJkSw5vbxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghVDbbBLYDJPSkzyFHBjdblbYWIIQ4J4TUPHaWdY3WO5TUtp9c4O8lut7Tl3WEsdy1FIEkVg3ztjWW9FwpetMULst9x95ASKUCzbOIFkJhCF6GQddm82ZuWEZ8Yp4VbvvG+wf4TTZ2LGEjpGfCxSUlXSv16xYq1f7ld9EpJV4KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fL8MWQ/M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292EA1F000E9;
	Tue, 16 Jun 2026 17:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781632356;
	bh=kkaxYV7pNechZnG7moOEjpPpTy2IvCpGUSsQ/EgsaUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fL8MWQ/MNp6vk5na9uqN9E7YAd2Pv27ATA0NuhDRiW3R2JLRltivYDMeXirZZbDmU
	 6/c2jhhYlm8eDMEqD5dNu2Dp+0HLZOYhSiBqOPdXpMQ0+LQTnX+4zSnKSZd+wWUs6D
	 axRL/a6eSN0C+YSoePXQzxHbFfxSvhy//0UVa2No=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 395/522] spi: s3c64xx: Use devm_clk_get_enabled()
Date: Tue, 16 Jun 2026 20:29:02 +0530
Message-ID: <20260616145144.362081196@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265665-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:andi.shyti@kernel.org,m:broonie@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1835693936

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Shyti <andi.shyti@kernel.org>

[ Upstream commit 20c475d21ed9326f7b1396c9bb8991b375cb6c50 ]

Replace the tuple devm_clk_get()/clk_prepare_enable() with the
single function devm_clk_get_enabled().

Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20230531205550.568340-1-andi.shyti@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 45daacbead8a ("spi: s3c64xx: fix NULL-deref on driver unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-s3c64xx.c |   39 +++++----------------------------------
 1 file changed, 5 insertions(+), 34 deletions(-)

--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1189,46 +1189,28 @@ static int s3c64xx_spi_probe(struct plat
 	}
 
 	/* Setup clocks */
-	sdd->clk = devm_clk_get(&pdev->dev, "spi");
+	sdd->clk = devm_clk_get_enabled(&pdev->dev, "spi");
 	if (IS_ERR(sdd->clk)) {
 		dev_err(&pdev->dev, "Unable to acquire clock 'spi'\n");
 		ret = PTR_ERR(sdd->clk);
 		goto err_deref_master;
 	}
 
-	ret = clk_prepare_enable(sdd->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Couldn't enable clock 'spi'\n");
-		goto err_deref_master;
-	}
-
 	sprintf(clk_name, "spi_busclk%d", sci->src_clk_nr);
-	sdd->src_clk = devm_clk_get(&pdev->dev, clk_name);
+	sdd->src_clk = devm_clk_get_enabled(&pdev->dev, clk_name);
 	if (IS_ERR(sdd->src_clk)) {
 		dev_err(&pdev->dev,
 			"Unable to acquire clock '%s'\n", clk_name);
 		ret = PTR_ERR(sdd->src_clk);
-		goto err_disable_clk;
-	}
-
-	ret = clk_prepare_enable(sdd->src_clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Couldn't enable clock '%s'\n", clk_name);
-		goto err_disable_clk;
+		goto err_deref_master;
 	}
 
 	if (sdd->port_conf->clk_ioclk) {
-		sdd->ioclk = devm_clk_get(&pdev->dev, "spi_ioclk");
+		sdd->ioclk = devm_clk_get_enabled(&pdev->dev, "spi_ioclk");
 		if (IS_ERR(sdd->ioclk)) {
 			dev_err(&pdev->dev, "Unable to acquire 'ioclk'\n");
 			ret = PTR_ERR(sdd->ioclk);
-			goto err_disable_src_clk;
-		}
-
-		ret = clk_prepare_enable(sdd->ioclk);
-		if (ret) {
-			dev_err(&pdev->dev, "Couldn't enable clock 'ioclk'\n");
-			goto err_disable_src_clk;
+			goto err_deref_master;
 		}
 	}
 
@@ -1277,11 +1259,6 @@ err_pm_put:
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
-	clk_disable_unprepare(sdd->ioclk);
-err_disable_src_clk:
-	clk_disable_unprepare(sdd->src_clk);
-err_disable_clk:
-	clk_disable_unprepare(sdd->clk);
 err_deref_master:
 	spi_master_put(master);
 
@@ -1302,12 +1279,6 @@ static int s3c64xx_spi_remove(struct pla
 		dma_release_channel(sdd->tx_dma.ch);
 	}
 
-	clk_disable_unprepare(sdd->ioclk);
-
-	clk_disable_unprepare(sdd->src_clk);
-
-	clk_disable_unprepare(sdd->clk);
-
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);



