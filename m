Return-Path: <stable+bounces-247679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCpPG3IJB2oLrAIAu9opvQ
	(envelope-from <stable+bounces-247679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:54:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD0654ED84
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B359830BCDEA
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0803D43636A;
	Fri, 15 May 2026 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaTTj6vN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BCD42EEBD
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845518; cv=none; b=pqA3FgqObV01M5IqoIlJEY/Fi61RLULTFmxLT9Ve9SKIdZzrsip8u+bDECYnfh9gOSEyK1WXJlTAvCkgceiK2J5sG1MAuU+ToqpKcZJFQZpXXXIEm5F0VSpOJ+aY+FA0D9FcFE74ujum0xRVBW91zJMPGRtO7pUJlcWH+V94pnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845518; c=relaxed/simple;
	bh=PPsnxzTJqDR3RTcGSvdCMx+ILWXnHeZpSGUf5APnqfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwo7em87pPtVw8l627wXnqJ9N0/3/BuXQ3cPNB2TpTB3fphThbWiqtkEow521UlQnFGtozlVvCg3LEJ17i4rAlaGINaod9VYC8JQ2RB1qZUtcFqki6hKhnYQcB0i8UGONNGCFJ68nbScF/pbp7tXRDblYUveE+XCWKrSsL6dzck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaTTj6vN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29642C2BCB0;
	Fri, 15 May 2026 11:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778845518;
	bh=PPsnxzTJqDR3RTcGSvdCMx+ILWXnHeZpSGUf5APnqfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IaTTj6vNM3JxSGk2FaIakyONkzywREm1es7L1C7bWtUDbMwReVUwCvUh1uxED4PK4
	 ZbIYhbatls73Q4itAcmd+O05RLrN99lmqpjMJmW56TEY7BRgb3e3FG1bm9U0ATwrjZ
	 q7tprpYVrUagYm2N4HFBjppJjw7WoBJaNdvhuGFuCc6iClLd/+gF9JZlqDaLTkOK6Y
	 hTyb/5PRieDc4XeCC5AFqWyhLHcYnaVY4My87ctd8KA+oYdyW4oi4xWHDlH3EB6vXi
	 zDTnVxG8f3hHYyzgo6+A2GgXdkQ+L86cIyaqmEzSHEvAk8ZLYgkiU3TKxRyaj5lh37
	 O8iMwD8NseWUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] spi: topcliff-pch: Convert to platform remove callback returning void
Date: Fri, 15 May 2026 07:45:14 -0400
Message-ID: <20260515114516.3021914-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051240-defiance-marlin-3914@gregkh>
References: <2026051240-defiance-marlin-3914@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0AD0654ED84
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-247679-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit b082694f18bdff807b42a3bccc62c3a524168f23 ]

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
Link: https://lore.kernel.org/r/20230303172041.2103336-83-u.kleine-koenig@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 5d6f477d6fc0 ("spi: topcliff-pch: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index cbb60198a7f00..1679a0ba3d62e 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1396,7 +1396,7 @@ static int pch_spi_pd_probe(struct platform_device *plat_dev)
 	return ret;
 }
 
-static int pch_spi_pd_remove(struct platform_device *plat_dev)
+static void pch_spi_pd_remove(struct platform_device *plat_dev)
 {
 	struct pch_spi_board_data *board_dat = dev_get_platdata(&plat_dev->dev);
 	struct pch_spi_data *data = platform_get_drvdata(plat_dev);
@@ -1434,8 +1434,6 @@ static int pch_spi_pd_remove(struct platform_device *plat_dev)
 
 	pci_iounmap(board_dat->pdev, data->io_remap_addr);
 	spi_unregister_master(data->master);
-
-	return 0;
 }
 #ifdef CONFIG_PM
 static int pch_spi_pd_suspend(struct platform_device *pd_dev,
@@ -1516,7 +1514,7 @@ static struct platform_driver pch_spi_pd_driver = {
 		.name = "pch-spi",
 	},
 	.probe = pch_spi_pd_probe,
-	.remove = pch_spi_pd_remove,
+	.remove_new = pch_spi_pd_remove,
 	.suspend = pch_spi_pd_suspend,
 	.resume = pch_spi_pd_resume
 };
-- 
2.53.0


