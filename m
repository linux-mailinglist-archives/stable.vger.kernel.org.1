Return-Path: <stable+bounces-247117-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ba7Er9bBWomVQIAu9opvQ
	(envelope-from <stable+bounces-247117-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 07:21:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B56DD53DFA1
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 07:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DD87301D326
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 05:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892703A7F68;
	Thu, 14 May 2026 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4PeEXsP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0EB381C4
	for <stable@vger.kernel.org>; Thu, 14 May 2026 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778736035; cv=none; b=adDmYUCcMCp29GAWtkK1IrL7DJyBr6Icf3akxuqe6GstZyjTHVJrUVtJBdUbrSAQx2GBjRVC27a09cNCNZrG/3KoPIfXHAbgVaHQm9BVGOP/Uf9i0BMgEXejqVeVfy46BcKVAB4f5p/PtcHIuEK+eRpbNXqApAO13QfvPZyiL30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778736035; c=relaxed/simple;
	bh=if8Wwdbtgux0IjVu3j/fvu2JRIT+LcZe6EYaRI80Apk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeU5MGeBTu2gV2uOL7IOANGMSpac0KgRWzPM127jiUitxtD/6nVrla8+hapXte/ip+RUE8yKJybA7e5puSkTSqlDgKT4Mjz0/18REHlmQwvLglOAkby4d3qL4DH2nPOo/6gkQ+UoyhwUUuXINy/0zehF7rNOXAeeeFXJDkxtUUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4PeEXsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C8EC2BCB7;
	Thu, 14 May 2026 05:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778736035;
	bh=if8Wwdbtgux0IjVu3j/fvu2JRIT+LcZe6EYaRI80Apk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n4PeEXsP4TM+kobCvjJDwob51iHAVklFHomi+DpFsBeQygASSm4hkfQ6mjo2WKM4o
	 c2BTRiehyX8W3ZLTDBY8JwpFpULOXrsOApw3IhZgle3xv5IumOtoWCqmmhtFCrqmUT
	 /LbBmpiL6c9s4NHB2cxRYwFS9GRgkwzDt2gV8WWWlbqYqlWR2FdNuTqAwexKoeeIKC
	 2X0kOOGFAodf2yDFqsAUE9D7hIw3EEMn8wU44pUIugwfh3CisST5YkYEpoY7tyM3lZ
	 T4WJYOU4U5W1DopQiALaXldOxQSrlXCB87Liyo5qfb1taS5fi2nK5VrRoG6raNUyNM
	 QJBk3xjNc5hlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] spi: s3c64xx: Use devm_clk_get_enabled()
Date: Thu, 14 May 2026 01:20:31 -0400
Message-ID: <20260514052032.41196-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051226-composure-saffron-d0fa@gregkh>
References: <2026051226-composure-saffron-d0fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B56DD53DFA1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247117-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Andi Shyti <andi.shyti@kernel.org>

[ Upstream commit 20c475d21ed9326f7b1396c9bb8991b375cb6c50 ]

Replace the tuple devm_clk_get()/clk_prepare_enable() with the
single function devm_clk_get_enabled().

Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20230531205550.568340-1-andi.shyti@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 45daacbead8a ("spi: s3c64xx: fix NULL-deref on driver unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 39 +++++----------------------------------
 1 file changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index c481f80b4d8d2..995c03d1ddcf0 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1189,46 +1189,28 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
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
 
@@ -1277,11 +1259,6 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
-	clk_disable_unprepare(sdd->ioclk);
-err_disable_src_clk:
-	clk_disable_unprepare(sdd->src_clk);
-err_disable_clk:
-	clk_disable_unprepare(sdd->clk);
 err_deref_master:
 	spi_master_put(master);
 
@@ -1302,12 +1279,6 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
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
-- 
2.53.0


