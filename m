Return-Path: <stable+bounces-235392-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iK26Nw+W12mGPwgAu9opvQ
	(envelope-from <stable+bounces-235392-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:05:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E513CA111
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C1A73004F3E
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 12:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BA23C552B;
	Thu,  9 Apr 2026 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0E497hQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33A23BD63B;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736326; cv=none; b=bIqD2618eRjGKG7COrgmQuWI8dctfknK96Qa345DiuqNXYj+LoY44CJljE+sewQfH0o6AfqdZ15JYddfYIGIMvN9f/4sJ6Au3LOjslGofBmhkLFYXtnIacOOnO/JhD8r99AEuizp7TTd9kQ/zARylbJPk1wXmx0kufmPSMbZALY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736326; c=relaxed/simple;
	bh=WBPrRuAmAQ/zlEaKZ9bjdjO4z8ffnisBNAnRXlbfIHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoEQztVKCrhiOuCAxzqs6P3oKRO0n7q2O6SI+nUhGze/fES9EHmTMoQMUXqYxQzDJL4ASjhpZEg2cU7vtaD7mPWlPpYLHcrOY+WyjKHR3Uu7JqtxGoDd6A65QZUMp56dPkUOIasSzrnrZzPMh9DaxPR3q0C3pJuudIjq0g8zHCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0E497hQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E5EC2BCC6;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736326;
	bh=WBPrRuAmAQ/zlEaKZ9bjdjO4z8ffnisBNAnRXlbfIHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s0E497hQZSoWwZQ6DZXGcAHpCcTaGxeP1vqkNgziLgr5xNax4jY2zKZIIdnuYgkhm
	 0y7AbLeNziHy5YvDRIJyELjr9lTm8tXsIt7XkNsFoNhCTB0Zhr2Mp91+BeQu716SyC
	 RLh6TnQ7DiBu8ipA4H7SL8mVdTdxp7Wl52U9WSyDFitISArQ6jFISWdWR4i7ERhzSR
	 S17QP+aXLcMoxH7SER1p0whmcb+1GcOuIYHOBOoTFcE4yxb1JAhtTodCF2LhrY3slG
	 Ty+HBhvruXOp7Lv0LatjDiu2Vat6C6iNkOzZhMEhN4lKomrf5vBov9A3uHsIufG2OD
	 GO32R3cYWmGNA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAo8S-00000001d7D-0Tgw;
	Thu, 09 Apr 2026 14:05:24 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 17/20] spi: meson-spicc: fix controller deregistration
Date: Thu,  9 Apr 2026 14:04:16 +0200
Message-ID: <20260409120419.388546-18-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409120419.388546-1-johan@kernel.org>
References: <20260409120419.388546-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amlogic.com,aspeedtech.com,kaod.org,upb.ro,broadcom.com,gmail.com,vger.kernel.org,kernel.org,linaro.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235392-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9E513CA111
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to deregister the controller before disabling it to allow SPI
device drivers to do I/O during deregistration.

Fixes: 454fa271bc4e ("spi: Add Meson SPICC driver")
Cc: stable@vger.kernel.org	# 4.13
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-meson-spicc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 57768da3205d..b80f9f457b66 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -1081,7 +1081,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "spi registration failed\n");
 		goto out_host;
@@ -1099,8 +1099,14 @@ static void meson_spicc_remove(struct platform_device *pdev)
 {
 	struct meson_spicc_device *spicc = platform_get_drvdata(pdev);
 
+	spi_controller_get(spicc->host);
+
+	spi_unregister_controller(spicc->host);
+
 	/* Disable SPI */
 	writel(0, spicc->base + SPICC_CONREG);
+
+	spi_controller_put(spicc->host);
 }
 
 static const struct meson_spicc_data meson_spicc_gx_data = {
-- 
2.52.0


