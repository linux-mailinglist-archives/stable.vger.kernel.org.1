Return-Path: <stable+bounces-246977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEtVD524BGplNQIAu9opvQ
	(envelope-from <stable+bounces-246977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:45:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6BB5383DC
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2742E300C03C
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7A64DC525;
	Wed, 13 May 2026 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYVkirPj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C357A4DBD86
	for <stable@vger.kernel.org>; Wed, 13 May 2026 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694298; cv=none; b=fg2GNsxJeJRvWGHn5jL3aoNWf8bOKA9EQME8eARwjU9rY+k4AtyTfafod4jQUcjQXF+YX6uXEEMjbhM/zDNH2lHCpDrcE7/uuj/wjIpiZ5AUOFxCL+KeLfGpZNDpVQF3hvRx9B51euz8dCdge5dLFRiAX4KPGkJCOaGezhs6/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694298; c=relaxed/simple;
	bh=yGIL8KEArg5EuwC1+5+PG2IZMjxwAjzwMky7qyxcjvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pt8zEqTrUeBVlxQkMEk946oB+kY+Q8jXCXpJ2xRmjZABBQ3ZDunTGaR8KQelsiDAYHQ4bOwI0lUK4f+XMxBq1aWzwYHohfBK66BCAFopmMiifOi226zEmECbIyYABS+jTNEhzfkoJdlQXL9YDYIa9hypf4cZie8BSDNGiCaECRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYVkirPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F91C19425;
	Wed, 13 May 2026 17:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778694298;
	bh=yGIL8KEArg5EuwC1+5+PG2IZMjxwAjzwMky7qyxcjvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mYVkirPj3rI7WrQMasmjfGVzfSpHnuyxfGzXnWE/Uj1+jby5d29YmrmnVqZXJQISH
	 5/qYyH7p4xgte/QzdaZqqH498+QO1RMjtqEwuURTYuBv3XuxDuo6rey0gODDpySdms
	 MWyeltKM2Jt812ylxaqbFIY2lIS5T4NBFLiXHy3B2s5jWGobaADz4CuX6iBHM7wF41
	 lRMVe4bMJAfHsvwwokuAeEuWGAnh/pvot+HKnczQ2fl/sOyVlTUovHblhyrzKL3sbr
	 xYQG0XKBaE3MBEocOyhWQelj2FDhYDVIQghHRkNQMJ8XJGXhkf1yKVvWO9AcLs6y8c
	 Me1R0p32t5n+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] spi: synquacer: Convert to platform remove callback returning void
Date: Wed, 13 May 2026 13:44:53 -0400
Message-ID: <20260513174455.3896307-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051241-embezzle-retrial-5eb7@gregkh>
References: <2026051241-embezzle-retrial-5eb7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CF6BB5383DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246977-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Action: no action

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 1972cdc47df737f5b90ac2132080004f5e413e91 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20230303172041.2103336-78-u.kleine-koenig@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 75d849c3452e ("spi: syncuacer: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-synquacer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index dc188f9202c97..3a92f722a6c50 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -735,7 +735,7 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int synquacer_spi_remove(struct platform_device *pdev)
+static void synquacer_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct synquacer_spi *sspi = spi_master_get_devdata(master);
@@ -743,8 +743,6 @@ static int synquacer_spi_remove(struct platform_device *pdev)
 	pm_runtime_disable(sspi->dev);
 
 	clk_disable_unprepare(sspi->clk);
-
-	return 0;
 }
 
 static int __maybe_unused synquacer_spi_suspend(struct device *dev)
@@ -820,7 +818,7 @@ static struct platform_driver synquacer_spi_driver = {
 		.acpi_match_table = ACPI_PTR(synquacer_hsspi_acpi_ids),
 	},
 	.probe = synquacer_spi_probe,
-	.remove = synquacer_spi_remove,
+	.remove_new = synquacer_spi_remove,
 };
 module_platform_driver(synquacer_spi_driver);
 
-- 
2.53.0


