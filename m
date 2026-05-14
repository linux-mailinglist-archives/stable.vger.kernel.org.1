Return-Path: <stable+bounces-247192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Lb6GLjCBWpMbAIAu9opvQ
	(envelope-from <stable+bounces-247192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:40:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B15541C62
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47889300CE94
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 12:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AB43A783E;
	Thu, 14 May 2026 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0gpVXmm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E86371CEA
	for <stable@vger.kernel.org>; Thu, 14 May 2026 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762419; cv=none; b=pxc2udSkH12HxnJhqVWNqalJopEuXnmO2dO4cyFNsXKxIgRV/KUZFTBaFBlcow0JvBdebsk5De7gxuQL1/pWHIIYA4oBhnU274/7RQtWlGqGTfW/alMAPcKgKkb3Y+lDJJG7ykKg9+1g8aP0ZFVd0sEVDAyp1mnkB3b+eEqEJz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762419; c=relaxed/simple;
	bh=uKYVFApafaIa7ed1mIzX+o90PWdmZ15QrAfotN1GUBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBg4IoiLtLhNVghCAQt8rOOJGGfHtijSlFn5So+M4Rr39CpMZTEIozvob/W7kbMnaxJ2nCaKr4mVWm1P9joj6s0I5YNrRk1867wvsST3kLVniYDVOm6CAEga5t5h51YmNrOQsEuVWmTR6iMS4xoWtsQIdzBPrLX++fXHEFzPnfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0gpVXmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1110DC2BCB3;
	Thu, 14 May 2026 12:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778762418;
	bh=uKYVFApafaIa7ed1mIzX+o90PWdmZ15QrAfotN1GUBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0gpVXmmSMnbklgBAJ8Dy3qahCrr9+yO7pnmoLGtqxae2NA5OLlwk0IFZ+gUyu9/i
	 /jIddNnDefTsQpBejreI8StNjIqxlO0raeXmP3ebqZO8F/fNqLSnbqOap4XkhHjvLL
	 gOKEmx9/AdBYpmjLDrcAMAWysdUKtnh5Ouxf22xCjWYnv+NkT+Mi8g6qmCOj5Zv+yN
	 zQ/M40rlK8P8BWXqehV/Xx+52wA5+0+In17IHQKgNsx1rpkgf9UxHF2pmn+goThKmI
	 CCNxuXhbl2D1w3unNogOHJzYU1SHvcVFRQkylLeeBarSniGxZLNndUd8uOTqDlu7f6
	 xWwbdPNhQr+Pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] spi: tegra20-sflash: fix controller deregistration
Date: Thu, 14 May 2026 08:40:16 -0400
Message-ID: <20260514124016.210394-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051258-punctured-fox-aad5@gregkh>
References: <2026051258-punctured-fox-aad5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D9B15541C62
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247192-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit ad7310e983327f939dd6c4e801eab13238992572 ]

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: f12f7318c44a ("spi: tegra20-sflash: use devm_spi_register_master()")
Cc: stable@vger.kernel.org	# 3.13
Cc: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-23-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
[ renamed spi_controller/host APIs to spi_master/master equivalents and switched devm_spi_register_master to spi_register_master ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra20-sflash.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 62e50830b7f95..762316ec7fbf3 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -508,7 +508,7 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 
 	master->dev.of_node = pdev->dev.of_node;
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = spi_register_master(master);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can not register to master err %d\n", ret);
 		goto exit_pm_disable;
@@ -531,12 +531,18 @@ static int tegra_sflash_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct tegra_sflash_data	*tsd = spi_master_get_devdata(master);
 
+	spi_master_get(master);
+
+	spi_unregister_master(master);
+
 	free_irq(tsd->irq, tsd);
 
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_sflash_runtime_suspend(&pdev->dev);
 
+	spi_master_put(master);
+
 	return 0;
 }
 
-- 
2.53.0


