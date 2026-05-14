Return-Path: <stable+bounces-247182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK12FPC5BWpZaAIAu9opvQ
	(envelope-from <stable+bounces-247182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:02:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A573A54157D
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 310DF3023DC9
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 12:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1033C65FF;
	Thu, 14 May 2026 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2CoIJzV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D863C5848
	for <stable@vger.kernel.org>; Thu, 14 May 2026 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778760156; cv=none; b=RhY8DZCrec9PxkTluRFSFKi/xLHUtiBu7/GFbod2QjrwuQqPOPSk1cYW/62irZ1VkkPRKDexPnDFvZB9MoEE5BXecoDDFvWgB10Br4DxFrUOqoz3WoSx4EG7IxAi5QScjcvVJTILC0l9+0x0/cn2F5aEa64mq5T6ZvkLlUtukD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778760156; c=relaxed/simple;
	bh=N/e7O3Ybiol96FTmQAvxcbt52rqA5DMahtijbOLC5Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2/nFOi1cZ5Uyl9YpyiD2sRvID6vhOSK3dw22f/7PSOEJ7qNqaP+BgZ9PhWeBsHK77bOufedosLbPXHOuYx50btXSLATUyk/GEp+ai89Rb2Jr5HZd8limqO3BSTAZ4OEefzjFdaAvnYOzoW9Hxt8y+vpW3C+sXphsx+YJmh90sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2CoIJzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCF1C2BCB3;
	Thu, 14 May 2026 12:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778760155;
	bh=N/e7O3Ybiol96FTmQAvxcbt52rqA5DMahtijbOLC5Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2CoIJzV9nmrf1iJ0evF04lZpxb7k2AND/we8LSWErmQ92S7ywCJiU3Pow6sAomqL
	 ffkG72I+Y9Xq/3cdnKvwO3uO7kfuavyjTfz/qciV06WeNVRasU1pFsOXpqjKEXv4pD
	 knw2EM0bep56Zu3+yR6C7odP3Bdo7JSHgs6gRtK49kxQyBlLhk2TeRed3F637dmtCP
	 hIKtYGSIvoK1gL339rM7yTG1USBIgOVkNXbQXTwh8dvrywcfYgKzP6BzHIBRyns0rE
	 z9p8M6HM8eq969tuEN1K+35C2//Te5j5B4OFYXUBBChJVzXS8/VR0+XsW69sspADOI
	 Dv+CLvGtKiPLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] spi: uniphier: Convert to platform remove callback returning void
Date: Thu, 14 May 2026 08:02:30 -0400
Message-ID: <20260514120233.192698-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051213-unsaved-bagpipe-b075@gregkh>
References: <2026051213-unsaved-bagpipe-b075@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A573A54157D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247182-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Action: no action

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 1b13d196d2813dadc1947940dbd4aaad6ae21c02 ]

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
Link: https://lore.kernel.org/r/20230303172041.2103336-84-u.kleine-koenig@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 0245435f7772 ("spi: uniphier: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-uniphier.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index cc0da48222311..f5344527af0bf 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -775,7 +775,7 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int uniphier_spi_remove(struct platform_device *pdev)
+static void uniphier_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
@@ -786,8 +786,6 @@ static int uniphier_spi_remove(struct platform_device *pdev)
 		dma_release_channel(master->dma_rx);
 
 	clk_disable_unprepare(priv->clk);
-
-	return 0;
 }
 
 static const struct of_device_id uniphier_spi_match[] = {
@@ -798,7 +796,7 @@ MODULE_DEVICE_TABLE(of, uniphier_spi_match);
 
 static struct platform_driver uniphier_spi_driver = {
 	.probe = uniphier_spi_probe,
-	.remove = uniphier_spi_remove,
+	.remove_new = uniphier_spi_remove,
 	.driver = {
 		.name = "uniphier-spi",
 		.of_match_table = uniphier_spi_match,
-- 
2.53.0


