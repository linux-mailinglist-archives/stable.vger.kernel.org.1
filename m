Return-Path: <stable+bounces-247017-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJN7J6fFBGqbNwIAu9opvQ
	(envelope-from <stable+bounces-247017-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:40:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FF353921D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCCF330221E8
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B833A785E;
	Wed, 13 May 2026 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aisMIBI7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99706352C2B
	for <stable@vger.kernel.org>; Wed, 13 May 2026 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697245; cv=none; b=mHfFWTFLBHSkwr7DiUHj64J/JrzXyRonBVh3aTI4EKg38Nn+Ftqni78RHw8fZFv2f2W2AREZch936wlexgLFjT5uzn/BRX6pS+W1lswhZPxo5mWKYX5Eg/wWUkqgGY3Y6wLUoZepWRvWFN38BGMJU+0+JN1mS16Y9chJnZ5uaVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697245; c=relaxed/simple;
	bh=ECUfdJOF5sx/Lwk+jawY2WKGn7NqF+yoSu6V1IYz4UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiBlFtdE3O7V3O0I4Z8+gAi7iPEIvnX/HHhDkXhvk0upB+W+79le5jAZrkOLB2NihjheWbWSetoDce2gLnuk530MQKpdaSfGoFbJ/IPD01uqPAdpOiK6Bg3XkXBUzjAgyeRjw/qJITTLFqzGkw9gIrAFpHA/6yuTydutGMsbUEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aisMIBI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EB4C19425;
	Wed, 13 May 2026 18:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778697245;
	bh=ECUfdJOF5sx/Lwk+jawY2WKGn7NqF+yoSu6V1IYz4UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aisMIBI7B6GkvO4NvWqcytwdM8sk3lBUksvv34WNrSOY0CwFMqKL+0jhSRs52ywog
	 1vOgrFAW+2yYTeSFQZ8TocDLx8J5t3EJxvuXUjabbJL6dJH9JUJ2pNJEvQnwNHnUji
	 U4azEnZdO6pmEaX0vvY+OCgFlXg+ni72j3jhi1MM2Rnc+oUebCyvg0U3gyrns/+SdE
	 176JayJ2dxoLrzHxyCK7ghHFf4D8RgJrn2GZ57Nsuua0rLiUFSjVL+sC3LFWafquqZ
	 zzfHDY/ZzIZsuRcRMaImtYExpQAJDASH11+zcumY7i2d9UVu2e4HJUOvDLYwZ4R/3n
	 04IrwJLjJPCig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] spi: sun4i: fix controller deregistration
Date: Wed, 13 May 2026 14:34:01 -0400
Message-ID: <20260513183401.3927454-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051253-fabric-rocky-e5b7@gregkh>
References: <2026051253-fabric-rocky-e5b7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F1FF353921D
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
	TAGGED_FROM(0.00)[bounces-247017-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 42108a2f03e0fdeabe9d02d085bdb058baa1189f ]

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: b5f6517948cc ("spi: sunxi: Add Allwinner A10 SPI controller driver")
Cc: stable@vger.kernel.org	# 3.15
Cc: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-19-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
[ renamed `host`/`spi_controller` to `master`/`spi_master` and kept `int` return type with `return 0` in remove ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sun4i.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index a8fba310d7004..ab99cc7438652 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -503,7 +503,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = spi_register_master(master);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot register SPI master\n");
 		goto err_pm_disable;
@@ -521,8 +521,16 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 
 static int sun4i_spi_remove(struct platform_device *pdev)
 {
+	struct spi_master *master = platform_get_drvdata(pdev);
+
+	spi_master_get(master);
+
+	spi_unregister_master(master);
+
 	pm_runtime_force_suspend(&pdev->dev);
 
+	spi_master_put(master);
+
 	return 0;
 }
 
-- 
2.53.0


