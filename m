Return-Path: <stable+bounces-235386-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLWGFgSX12mGPwgAu9opvQ
	(envelope-from <stable+bounces-235386-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:09:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E622A3CA2E0
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11F333025A6A
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 12:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F883C061A;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYXLZuoQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD703939DD;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736326; cv=none; b=T0n69OJ/BaBdwcnsmH1RsgYQ3LsEisF4vomfJrHmVEKgWiGht8pQmDjpQLJ4EhpregeVHITy8irUtfVp1acYvSmqeKUt0UQXtZ/0jA6ZN3WpEUhHoO5OJjROBHjbHGaXrz73ej9+eX/RWK+y5YVex1GUITKYoFQ38GXlnMJqbqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736326; c=relaxed/simple;
	bh=3DbsYkN4pf5ND1z8L30fphcMVgrd1sOFsBKrJWKj7TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXbMa7GuAT2jsod0TWGLqTVvhvkacu8Ml5CI8CEVGZwp3UnuaA7t2ACfEISqDmv+giSzsSbdk8W80Gzr5VPvhQaaaoKy9viiGd5FAdl0H7XxUv+77XZ5/1rr7qsMRBj1ThqkVoygLfWfP3RYqmhrBsR4iNpX2/i22wBlOSi/38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYXLZuoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9B9C2BCB0;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736326;
	bh=3DbsYkN4pf5ND1z8L30fphcMVgrd1sOFsBKrJWKj7TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WYXLZuoQ8oFwwg7QCVCsTgjZ+oF7k4znxYvh4mcT3ituf4jUt6lOBmrtFIwxBMVHV
	 +S4d4bkYsE8nK9KkaN7KV2Bzunj3zsgDkyRK50RkaNG9EAGdrVF1X6Vea02xxPaMmq
	 ZWbI1aE3JWof1OmZAGy0BX0RB1PzIxNSUGx2O0TLuTobOAftUxE0S4pBQqGXlhli0u
	 ddF9jdySAeKu8i749/x8Y88QzAuzfWGjn8vMeRX+e4YnrYDHr0/KjDsHbCEbKkyWLc
	 Lp4ZMGXDzbpvH77kts6wta6cmJTcrjQL4HD77J8ugRZ0+p/vlCqVqBL4wSyiRr6k4X
	 TDib8HQ5kS1RQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAo8R-00000001d6h-43PZ;
	Thu, 09 Apr 2026 14:05:23 +0200
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
	stable@vger.kernel.org
Subject: [PATCH 01/20] spi: amlogic-spisg: fix controller deregistration
Date: Thu,  9 Apr 2026 14:04:00 +0200
Message-ID: <20260409120419.388546-2-johan@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amlogic.com,aspeedtech.com,kaod.org,upb.ro,broadcom.com,gmail.com,vger.kernel.org,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235386-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E622A3CA2E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: cef9991e04ae ("spi: Add Amlogic SPISG driver")
Cc: stable@vger.kernel.org	# 6.17: b8db95529979
Cc: stable@vger.kernel.org	# 6.17
Cc: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-amlogic-spisg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amlogic-spisg.c b/drivers/spi/spi-amlogic-spisg.c
index da8ec35115da..19c5eba412ef 100644
--- a/drivers/spi/spi-amlogic-spisg.c
+++ b/drivers/spi/spi-amlogic-spisg.c
@@ -800,7 +800,7 @@ static int aml_spisg_probe(struct platform_device *pdev)
 		goto out_clk;
 	}
 
-	ret = devm_spi_register_controller(dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "spi controller registration failed\n");
 		goto out_clk;
@@ -823,6 +823,8 @@ static void aml_spisg_remove(struct platform_device *pdev)
 {
 	struct spisg_device *spisg = platform_get_drvdata(pdev);
 
+	spi_unregister_controller(spisg->controller);
+
 	if (!pm_runtime_suspended(&pdev->dev)) {
 		pinctrl_pm_select_sleep_state(&spisg->pdev->dev);
 		clk_disable_unprepare(spisg->core);
-- 
2.52.0


