Return-Path: <stable+bounces-247179-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GODZFNO4BWpZaAIAu9opvQ
	(envelope-from <stable+bounces-247179-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 13:58:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A47B2541493
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 13:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E0F53039C8E
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 11:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFF83C1F50;
	Thu, 14 May 2026 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wr/rBrq5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F08D3C197A
	for <stable@vger.kernel.org>; Thu, 14 May 2026 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759888; cv=none; b=JroFwptbV0IFMqktodIzFWbZvV25aEYiPAZaK6qqW5YPQOMnp4FqGZg+FJ/yqjqJo+bQ/SmfX1jAFb0XpqyUVUDpcviUUosc+iu1rst/YV8PHpxqajEPMvhfMk4PuMy/58WzAd73HZgujdBLPyCeWa27qwK+tKRWQ/Tr4meL0wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759888; c=relaxed/simple;
	bh=foYBdwTNkvy/V8jK2OOTmJP3UhocaYJH7LvKbrDzA14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQJ4a7/938/Vbb2XqVeTp/hfxc9MdzrNt8k/aGXeaTPs0/NmIZ3Yt2jP6/foXEPYJQwp3xQPaYwW4FSO9UEBQaomqD633urE+yFnJjqZ9sePjm63ebn88yDRJC6092pMD0JBLbvfeQz4jLww5tKw9D+IlGJeqY1TCVJsTixD8Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wr/rBrq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E92FC2BCC9;
	Thu, 14 May 2026 11:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778759888;
	bh=foYBdwTNkvy/V8jK2OOTmJP3UhocaYJH7LvKbrDzA14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wr/rBrq5s35283MPYCALpbGPqTB36/Qlf59wUQeU3kRCWKEF1i8MxyEH5HNIBVf7F
	 Phh/nncVW+0YzoeGYyfBce8CIZBF59XrP9Idgfvaf7sji7QdUkwJgFiadMqjyQNk4t
	 ta7ls9sqQPKDTFDmh2O0jum7U3ndXXX7hZiP1zfa101jR5ZINeQzNlDmRAdLMhuAHK
	 6PfcOxcdIUiZoV8vECYilZOGlBLTB/HpNGQ2dZECMPY/X8TMISpju+TMyv25O/GmxK
	 XfxT7GVCq1u264nuhYUniRr8krqjdo2X74+KGe+mRD/T/RnXlfzfg1E9kd0ti+z36a
	 56A9elPwPfIYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] spi: tegra114: fix controller deregistration
Date: Thu, 14 May 2026 07:58:05 -0400
Message-ID: <20260514115805.188807-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051238-compare-doorway-3b62@gregkh>
References: <2026051238-compare-doorway-3b62@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A47B2541493
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247179-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email]
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
[ renamed spi_controller/host APIs to spi_master/master equivalents and placed spi_master_put() before the existing return 0 in remove ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra114.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 30a699ba9b4c2..39a34fbe6ceaf 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1417,7 +1417,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	}
 
 	master->dev.of_node = pdev->dev.of_node;
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = spi_register_master(master);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can not register to master err %d\n", ret);
 		goto exit_free_irq;
@@ -1443,6 +1443,10 @@ static int tegra_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct tegra_spi_data	*tspi = spi_master_get_devdata(master);
 
+	spi_master_get(master);
+
+	spi_unregister_master(master);
+
 	free_irq(tspi->irq, tspi);
 
 	if (tspi->tx_dma_chan)
@@ -1455,6 +1459,8 @@ static int tegra_spi_remove(struct platform_device *pdev)
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_spi_runtime_suspend(&pdev->dev);
 
+	spi_master_put(master);
+
 	return 0;
 }
 
-- 
2.53.0


