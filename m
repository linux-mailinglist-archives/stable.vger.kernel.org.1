Return-Path: <stable+bounces-247094-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ+JMjQ9BWqHTgIAu9opvQ
	(envelope-from <stable+bounces-247094-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 05:10:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E48F53D425
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 05:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94288302FEAA
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 03:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297C43016E3;
	Thu, 14 May 2026 03:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTm7FU2n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C562D739C
	for <stable@vger.kernel.org>; Thu, 14 May 2026 03:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778728240; cv=none; b=Yc8HOZgutj1xMBBRO9a+n0AGMBY4HvV4GCBXGrGj/cbYFwwho2Ri0ESAnXJn+5vAk8c4BYWzdrzkVLSpVZo2Cr69qCWrhNLa0PGDrBQzj6PDQMaCIXW6PFQivpok2RUSmoLM/PNrp+USqhkRky4d28YpplDB2esxr27y9YRQQMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778728240; c=relaxed/simple;
	bh=/0A1PaDhq5apXTHRHJC3p/ZlxkRDfUtVxVZ9qD5XZ3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWHKaxSNE4e/dxc/8dq+/BKKb985cjb1yCIR37rqF0+x6h2v3VRNYpjmt5BicHB8FHYHOQhifVGRopUxDHuezxuwbe4XTnSIeOLLjC/abQjH3ch20dq+cwPMMuQIqED17s42zL004jSzNw7G+OnQMfjug8LCQNKQCJ2XB9l57yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTm7FU2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DAEC19425;
	Thu, 14 May 2026 03:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778728239;
	bh=/0A1PaDhq5apXTHRHJC3p/ZlxkRDfUtVxVZ9qD5XZ3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FTm7FU2nNQ8amRC4F8mjIf5mYE6yrnUqMq0i1btiu4dJnQj+yoRVk6ie8yjldfZPO
	 5wUPzMzTSQqDkHbbcOWiUYeZUCdurn4TD9soON933+aEoWMyqwCqRiTVIt6i5HFXtq
	 tkYrS7P3Bpw3EldgrN85zRCxsJ50Q/5ta2pWdrTn7WcbPDF8TPqCX+k6zLkRhwLoEk
	 OGrQSw9J0jocEx525x4gF3bVbroPnDrgsBotY2eAbTwIBrznZMeotBv6UC1bBIoKE0
	 rTHm/axt7OPlexd10Y1z8XRey5nsTORKADVZdK0O3PJH9/und34rBHBcS2FPKNbnWO
	 QI4oE8w/syNTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] spi: tegra114: fix controller deregistration
Date: Wed, 13 May 2026 23:10:37 -0400
Message-ID: <20260514031037.4119194-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051237-disband-manual-6d4e@gregkh>
References: <2026051237-disband-manual-6d4e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3E48F53D425
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
	TAGGED_FROM(0.00)[bounces-247094-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 9c9c27ff2058142d8f800de3186d6864184958de ]

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: 5c8096439600 ("spi: tegra114: use devm_spi_register_master()")
Cc: stable@vger.kernel.org	# 3.13
Cc: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-22-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
[ kept `host->dev.of_node = pdev->dev.of_node;` context line above the `spi_register_controller()` conversion ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra114.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 48fb11fea55f2..a28597b6b80d6 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1416,7 +1416,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	}
 
 	host->dev.of_node = pdev->dev.of_node;
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can not register to host err %d\n", ret);
 		goto exit_free_irq;
@@ -1442,6 +1442,10 @@ static void tegra_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct tegra_spi_data	*tspi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	free_irq(tspi->irq, tspi);
 
 	if (tspi->tx_dma_chan)
@@ -1453,6 +1457,8 @@ static void tegra_spi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_spi_runtime_suspend(&pdev->dev);
+
+	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.53.0


