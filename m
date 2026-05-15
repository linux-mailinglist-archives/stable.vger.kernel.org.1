Return-Path: <stable+bounces-247738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CI1EcQTB2ourgIAu9opvQ
	(envelope-from <stable+bounces-247738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:38:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B6854FB47
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2557230BC324
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBD747F2F0;
	Fri, 15 May 2026 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzCZtadU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FAA47D920
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847328; cv=none; b=aEgSv1m76WoizJ5GiaVFyy89VEJVvC1icgLxmJZJmKihwR96kMzg7PScM2IeErB7+GPJ48IAQraGiCDN/bnGjNAwKWUB8M2EAEQvxSf8UgV79RKGwkbwEGh00Fo8rcFH3ngeZ2bAEdn/ytsYgla4TyP+5lcV2VXcroYvYIvATE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847328; c=relaxed/simple;
	bh=9RbiOwHcKaxu/OTPu+f1ouIq7S+GG+SJhjpFdnpYPGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCGMcBF+KdxKSjFCtt9vMkkYtPY+LItWzwCqMkUiA44tykhMuHeVT/y8Zn/juwTK5EbnV1M3h/kgwznNuXKhDDinC8R1iaxXZjbP1Xi7YYb5xZC40MysZTK7jEYNEVyE5Tq94Q+Zh5+rfzSRjAysgsDlegUGiNYtBP0gSYpZB6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzCZtadU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C08CC2BCB0;
	Fri, 15 May 2026 12:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778847327;
	bh=9RbiOwHcKaxu/OTPu+f1ouIq7S+GG+SJhjpFdnpYPGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QzCZtadUFPTNoFldUWNJ+08ILJl0WUBoIGp+Gm3ciGOvHiuRr+fU2O+2Yfw0iyI99
	 XrAzPb3rBXYytAzw2NJlztCetAGpea0tJ1de2h8rAjpbQ1RW+BUwSukDDK/vc56uID
	 cLBicXE/C0l3Gax3EgqejalupsSB/6mJcj49/uZHGyBtbChglWZKYYrHxvQsc1TPFe
	 2PF5ct6I9EiHU0OopXaiBg/t+3vRm+rn79vFo1bM/z+pibNuUSUEINXP9CTOiIUghD
	 M/pNpnJy4PQBVAebpveycwJx02jMKrvJzAQ83yhG5/rPQ/b57z1s5feO17t4+xBDY0
	 6vypcwYbossEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] spi: topcliff-pch: Convert to platform remove callback returning void
Date: Fri, 15 May 2026 08:15:24 -0400
Message-ID: <20260515121525.3130058-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051240-sleep-zen-7409@gregkh>
References: <2026051240-sleep-zen-7409@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A6B6854FB47
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
	TAGGED_FROM(0.00)[bounces-247738-lists,stable=lfdr.de];
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
index 8c4615b763398..9641de3fef177 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1417,7 +1417,7 @@ static int pch_spi_pd_probe(struct platform_device *plat_dev)
 	return ret;
 }
 
-static int pch_spi_pd_remove(struct platform_device *plat_dev)
+static void pch_spi_pd_remove(struct platform_device *plat_dev)
 {
 	struct pch_spi_board_data *board_dat = dev_get_platdata(&plat_dev->dev);
 	struct pch_spi_data *data = platform_get_drvdata(plat_dev);
@@ -1455,8 +1455,6 @@ static int pch_spi_pd_remove(struct platform_device *plat_dev)
 
 	pci_iounmap(board_dat->pdev, data->io_remap_addr);
 	spi_unregister_master(data->master);
-
-	return 0;
 }
 #ifdef CONFIG_PM
 static int pch_spi_pd_suspend(struct platform_device *pd_dev,
@@ -1537,7 +1535,7 @@ static struct platform_driver pch_spi_pd_driver = {
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


