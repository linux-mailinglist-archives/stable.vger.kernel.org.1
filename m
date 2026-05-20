Return-Path: <stable+bounces-249944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EH5A3fKDWo33QUAu9opvQ
	(envelope-from <stable+bounces-249944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:51:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB9D590158
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2F8231247AB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1360B3EA976;
	Wed, 20 May 2026 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYwzYPMz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA1025333F
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287282; cv=none; b=qUr+oYkgAg6p8sHtvgfBXvycctOxWegFaJlvjI9fKGXx8k1WWVB0qKQD9zJfr1xsh6A782qIX/ui4zI1PIetUgdyRug4VN90R8MzEtlnqZzcaUyR/2xT/VnXeqrC1+N/19iMam9B6oW4sKRphym4m/+NAirkYt+SAjZTJNLNdbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287282; c=relaxed/simple;
	bh=IyZTt+fabuviOvpKCywK3vBBvIXPBLro9Rkt+RpEbaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNiIuMMladfjc0TllHBTpdjMua4+6ceKts3t6t6tveuhA48V2A0JVgTbLE2R33lkDI/ly02KEZHnFLxTIPAsuXd4e3iteND2Hr5KbwcSiMfQBylqHUYARxoB9VELsUAZu1sadhrcHInBhpoRyMo+byGK13QGv3OHkhjz6p8zEC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYwzYPMz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39901F00894;
	Wed, 20 May 2026 14:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779287279;
	bh=y3erZfHkI+/9SJyRBi2leGwWrEzPOSQhGyCOkBl0fy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EYwzYPMz3KDZ2t303Vk1xgsDU2Sw+6XM5glCtT2JmOcK++tqi2egq0fdqVx9N5Nu4
	 rkp+4aZgduj4ELZ/6zWXrZ9Hj8nuDSTMafTrm98JzJlHYs0u09Sz2hO23IoLFUfVlW
	 72OuXtK16Fq2rOKt/FgJBik50yohyx2cYgDCi+2uHvI10NzgPVFZEPxa3lk3thUlQF
	 cHM4AOEWwdefjN21SXjZsgGORnusn43daHmoO3a0Om23s+mUDqSBFpggbas4wD+U+z
	 hbKoLwqTdsSwi8Dqer1KyvV4R7HIo4mjm0Nxay4ogkzuuuQrw64NR5OYfQY7swTnKp
	 x+kBX9G/8harQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] spi: st-ssc4: fix controller deregistration
Date: Wed, 20 May 2026 10:27:57 -0400
Message-ID: <20260520142757.3647294-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051547-overturn-uncooked-4d7f@gregkh>
References: <2026051547-overturn-uncooked-4d7f@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249944-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7CB9D590158
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
[ changed spi_controller/host API calls to spi_master/master equivalents ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-st-ssc4.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index 6c44dda9ee8c5..f453e3c1a26b9 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -372,7 +372,7 @@ static int spi_st_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, master);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = spi_register_master(master);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register master\n");
 		goto rpm_disable;
@@ -394,10 +394,16 @@ static int spi_st_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct spi_st *spi_st = spi_master_get_devdata(master);
 
+	spi_master_get(master);
+
+	spi_unregister_master(master);
+
 	pm_runtime_disable(&pdev->dev);
 
 	clk_disable_unprepare(spi_st->clk);
 
+	spi_master_put(master);
+
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 
 	return 0;
-- 
2.53.0


