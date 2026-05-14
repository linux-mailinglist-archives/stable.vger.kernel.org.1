Return-Path: <stable+bounces-247096-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JkWMh1MBWoIUgIAu9opvQ
	(envelope-from <stable+bounces-247096-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:14:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C722853D958
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7824300D76C
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 04:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E36E3ACA5D;
	Thu, 14 May 2026 04:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhsG05w/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5953AE71E
	for <stable@vger.kernel.org>; Thu, 14 May 2026 04:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778732056; cv=none; b=YGkVMcNeTdFTJyknetMZSlwy8jYRhpvyn9ZxFhvElr/is25OEHhddpxACLzlJma1CImR3iq/KVRvNPDHWoclQ7xO2gXqwUd00ijUBnwxOlqHwcawRwM9fKPe2cprJHetBCxrfo5+27lK1f/+fwLxq8N1qmMLVrGvnIcDedWhfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778732056; c=relaxed/simple;
	bh=O2x7dfmOfH68Dum5XszZLc4m/ewJl8Ctu40cXfFzSEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWvZaKKztF8i7YY3e4cWP+O5TWJ9XgnfrElj3poGlFcX7JxaLdfZcm5YwhXKJwwQss6OtAOFA7EjwN908gWLZ+cK08F3PjYJQcVAgZ5iZxjWJG+tB/DsGg4fVKHyYAzHvqseU85qCfemjPP2JnVWfWe9lx6RDuSkQigRi+sa0Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhsG05w/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AA0C2BCB7;
	Thu, 14 May 2026 04:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778732055;
	bh=O2x7dfmOfH68Dum5XszZLc4m/ewJl8Ctu40cXfFzSEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BhsG05w/jxinno5qE4YLNbCfB2i1DvGIgJrQJY3q2fog5w28zjsMu/802fUnTPjlg
	 Nw4UPgQ44cpWPwTzESGsHLlX8GIPgX0FGyeDTWS73IEWxnzK3VPkp3r2wwD2EUaWic
	 o4NfMxGOcqecl9ezIkPfv0nxcZSQJdXfPXEb63K53aw8b47OnMwbuOhagSsveL8sxL
	 TKe5DK2JyEVhF+gbL2OTeNBLINUEoJXft1wfcFejs5smM7Ti47guLsJvgRmjkTMB+r
	 xLnMNvXS4Ux6qG6SIpXh5cPCUVMI13RxGh8Ohb2rJb6A64AchstnnHPdrFLAJ4dQib
	 b29eaHCDSftMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] spi: sun6i: fix controller deregistration
Date: Thu, 14 May 2026 00:14:12 -0400
Message-ID: <20260514041412.4189652-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051227-slate-moving-766e@gregkh>
References: <2026051227-slate-moving-766e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C722853D958
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247096-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit d874a1c33aee0d88fb4ba2f8aeadaa9f1965209a ]

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: 3558fe900e8a ("spi: sunxi: Add Allwinner A31 SPI controller driver")
Cc: stable@vger.kernel.org	# 3.15
Cc: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-20-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
[ renamed spi_controller APIs to spi_master equivalents and kept int return type for sun6i_spi_remove ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sun6i.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index d79853ba7792a..834957bb04ba8 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -688,7 +688,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = spi_register_master(master);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot register SPI master\n");
 		goto err_pm_disable;
@@ -714,12 +714,19 @@ static int sun6i_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 
+	spi_master_get(master);
+
+	spi_unregister_master(master);
+
 	pm_runtime_force_suspend(&pdev->dev);
 
 	if (master->dma_tx)
 		dma_release_channel(master->dma_tx);
 	if (master->dma_rx)
 		dma_release_channel(master->dma_rx);
+
+	spi_master_put(master);
+
 	return 0;
 }
 
-- 
2.53.0


