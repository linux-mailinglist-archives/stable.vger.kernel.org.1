Return-Path: <stable+bounces-249911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKdyBVyvDWrW1QUAu9opvQ
	(envelope-from <stable+bounces-249911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:55:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AF43C58E4EB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C369300915B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E783D47B1;
	Wed, 20 May 2026 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx80KPLM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC48533A032
	for <stable@vger.kernel.org>; Wed, 20 May 2026 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281753; cv=none; b=e1C7Fb7Gzvhy00x8yOUJAlWU2tQY4HsCKoS2WDG1AOAyxhLg+T/XMDIWnjKCGh2GlOcLwU2CYEe/prW2m+rym0i84fz27mpXotrRx6RuP1odr3fZPMIVKD2E395Zvlco0tEBMPnAcgli+ltYTFQlPjFhxbWLwF7rt2zZhOENuYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281753; c=relaxed/simple;
	bh=khS850M0xMp8YswltbDXF22+1LNg3X9fdBVFcLRTV9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEc8XEGo2eeGkvtdYpSBLoKuK9OUykO9h7SWi6GVZuifQKd6RiVPBBOpoNEMHYt9TFlpLPoKM25VdPn9qfEeVMdQJOoDYIOwZ0K4wlRp5gjdrdh4O5c2iOCOiGxzWKbUpDx6hfROfUJqCLBJWua8PLgOZWVlNR2Vx7p+ZmBvjMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx80KPLM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AAA1F00893;
	Wed, 20 May 2026 12:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779281752;
	bh=AyirgZpv4huyYhHW8SX+xBz3LATKTDizYdOZJ/aqjUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cx80KPLMOqFgY0+46KbOn3vCIEmdVeYXaR1uZHQiHTIBpheZym4TTKcMuqJzloyGs
	 aQeLkWAM8ngR4CS5UUazwa6Ybc14NoLB54lJmsH7SuDPU76BlQLxQOinoES7XdEYd8
	 fLQDoibpFvYm/rAqndNoRhkoPuSNY+el66a6wP5eu0TPktSFw+h6jxY5tnAHit1ISl
	 6RKxMLlNB3F/uNEg4kfDK+TXoLFm/YWsbvBgETTGKTOimkLcNaxQ+bUUFDwTNHiGJP
	 +6Y4Cp/+gJ+fh6hA8TW+Tz3eYZ+S+Nfl4xuICtsdVSUTDV4HedBq/c7Dg0ETlNZUqf
	 OiYDd/arWJiTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] spi: st-ssc4: fix controller deregistration
Date: Wed, 20 May 2026 08:55:48 -0400
Message-ID: <20260520125548.3536474-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520125548.3536474-1-sashal@kernel.org>
References: <2026051546-fable-equator-195c@gregkh>
 <20260520125548.3536474-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249911-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AF43C58E4EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 19857374010d06ca6a2f7c2c53464122eb804df0 ]

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: 9e862375c542 ("spi: Add new driver for STMicroelectronics' SPI Controller")
Cc: stable@vger.kernel.org	# 4.0
Cc: Lee Jones <lee@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-18-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-st-ssc4.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index e064025e2fd6d..82acb667fd2d7 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -349,7 +349,7 @@ static int spi_st_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register host\n");
 		goto rpm_disable;
@@ -371,10 +371,16 @@ static void spi_st_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct spi_st *spi_st = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	pm_runtime_disable(&pdev->dev);
 
 	clk_disable_unprepare(spi_st->clk);
 
+	spi_controller_put(host);
+
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 }
 
-- 
2.53.0


