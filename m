Return-Path: <stable+bounces-247741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBzxOsAUB2rgrQIAu9opvQ
	(envelope-from <stable+bounces-247741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:42:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A5554FC82
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A15473268229
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0780847F2D1;
	Fri, 15 May 2026 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVOMHEDv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EF747F2E5
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847333; cv=none; b=bwlweEsSo6VZRyMY41GnyYuKa0qDRnY2D88wD9TDOpsJXC1ptvOp/SiylRcnDvcAkZloebFFdddoUfHGL8jsOBYeAqkG0Kjv6q8VLVIm2i6jUU3klpKNK+AMkc9MNn2mQNiaPLSIf7i6ucPbXi05J1BA0jm/6s5lXimujrG92N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847333; c=relaxed/simple;
	bh=U/0vKkm8ojQXIsp3AEDb0qA59xW7mYTF51Zng5h7xSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zok3e2y4Ak55FqrvkJmIIhUZSCvnczS0tbsNRzRx5C1oKKlFJq/uqjGC6CHeAyonb3afWRsGmoYN8W5mgSUH/Thm49QKG5olZRzjIfNIoeZ3iHuiSUMb+YBFy1Dqa2a1eaiJf0AS3tsiVOxLzIqSvByZ5zCVF80a58fxpV3chHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVOMHEDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37AEC2BCB8;
	Fri, 15 May 2026 12:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778847332;
	bh=U/0vKkm8ojQXIsp3AEDb0qA59xW7mYTF51Zng5h7xSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RVOMHEDvI+4W0V7pGXvV0osef6vDKDafc6tIG1oz3ouDjLHsCqDPci2VMjUe3MBiB
	 A4+jXfv7UmaS2qAiI1WSG66WC62naVWp1S1BCODdwmRxxurqDWra3fnZWEbqi3PFI3
	 ILzgMGcXRTnrt3q+AR5LAoGfxxMJbZLr/w1A5re3//ZFOsKtBVyGTiDTe1qgl5mAXD
	 Un2aJFb9FFfC6/f0RLqbM+zlTbBoXm1iA3bN8oOTZk0Pgc635YByd24uksABuVvvjD
	 IR3YAePvp4XHamWjEsqwlpvgDiGKybnnbSxR1QsCgzko5TmYAj4eztoTvSiDDQGOg9
	 S3n72lG+1jilg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Masayuki Ohtake <masa-korg@dsn.okisemi.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] spi: topcliff-pch: fix controller deregistration
Date: Fri, 15 May 2026 08:15:25 -0400
Message-ID: <20260515121525.3130058-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515121525.3130058-1-sashal@kernel.org>
References: <2026051240-sleep-zen-7409@gregkh>
 <20260515121525.3130058-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 72A5554FC82
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247741-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 5d6f477d6fc0767c57c5e1e6f55a1662820eef87 ]

Make sure to deregister the controller before disabling and releasing
underlying resources like interrupts and DMA during driver unbind.

Fixes: e8b17b5b3f30 ("spi/topcliff: Add topcliff platform controller hub (PCH) spi bus driver")
Cc: stable@vger.kernel.org	# 2.6.37
Cc: Masayuki Ohtake <masa-korg@dsn.okisemi.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260414134319.978196-8-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
[ renamed spi_controller_*(data->host) calls to spi_master_*(data->master) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 9641de3fef177..fa60828808d84 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1427,6 +1427,10 @@ static void pch_spi_pd_remove(struct platform_device *plat_dev)
 	dev_dbg(&plat_dev->dev, "%s:[ch%d] irq=%d\n",
 		__func__, plat_dev->id, board_dat->pdev->irq);
 
+	spi_master_get(data->master);
+
+	spi_unregister_master(data->master);
+
 	if (use_dma)
 		pch_free_dma_buf(board_dat, data);
 
@@ -1454,7 +1458,8 @@ static void pch_spi_pd_remove(struct platform_device *plat_dev)
 	}
 
 	pci_iounmap(board_dat->pdev, data->io_remap_addr);
-	spi_unregister_master(data->master);
+
+	spi_master_put(data->master);
 }
 #ifdef CONFIG_PM
 static int pch_spi_pd_suspend(struct platform_device *pd_dev,
-- 
2.53.0


