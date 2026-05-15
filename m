Return-Path: <stable+bounces-247681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMByLXsJB2oLrAIAu9opvQ
	(envelope-from <stable+bounces-247681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:54:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA4054ED8C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7365630BF18D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07B839D6CC;
	Fri, 15 May 2026 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcibXw4u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CA842048
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845520; cv=none; b=SILp1M1feCwPsyhDq1c2BNsdaMmO8rs2yKwxg8Y+ImxzDbJGAzvZ3K+qf9ijSRcxnLLiM9t10T0C/+HlQArvBm7FqnomMYO+/vwBMNq10uMFfgA30z84xXvJ6Ql0RD/t9OzlfzcdFWOxp37f1aduccxOi2YXdAFF/ww1dm+GDOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845520; c=relaxed/simple;
	bh=VNWpPsk6OgyE45CNk0Oc/xEy6SV5RO8oqCRnjJPtSek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrJxTL0MVA2owMmcBNmShMJNxyzU/Qbvq5L2pBWBN0Cm1A8NdQE1wl1yxzDZtcrKg7F0bSt+fggmsPfaejUSmEwK9FXhUCeUtoVrj4z0cVsw0HEzcZCd5IdctgdFXcEdytVnuVqzqqLITzS2QmgB6OyP8K9kak5GJ67hwIr950M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcibXw4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5012C2BCB7;
	Fri, 15 May 2026 11:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778845520;
	bh=VNWpPsk6OgyE45CNk0Oc/xEy6SV5RO8oqCRnjJPtSek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UcibXw4uZ7dIgUzruzerlrygBLu0SU4+QXbCksJlCOsOjUZnWnfvEUfWv10c/y8uC
	 6Eu4YgoXlReV6RwaBWtdQ3nD78+e6wTGTKKF0HlQlDZF1PAXLVZ+Alo8scKuakqT0K
	 h4X7iSAE38Xt+w2pp/6gTjFQykcyZy6sBYlNpkRbvakEY7pvd90p77HpQJEig+7GcN
	 b+ps0txkQ64VPocwypJs3z2JER6A5SfsM4muusaStTRMlJ7yNx0iLEoWq0OOfjhsSq
	 xoC+iUOdTGudO+JlSZgo11YjgbGnSSW5lW9cl2/V5OoL8gj4d8emYv4j2WMuNvtwDg
	 BH7hq/qLAzvyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Masayuki Ohtake <masa-korg@dsn.okisemi.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] spi: topcliff-pch: fix controller deregistration
Date: Fri, 15 May 2026 07:45:16 -0400
Message-ID: <20260515114516.3021914-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515114516.3021914-1-sashal@kernel.org>
References: <2026051240-defiance-marlin-3914@gregkh>
 <20260515114516.3021914-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5AA4054ED8C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247681-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 543a94977b088..363f0e6db3dc9 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1406,6 +1406,10 @@ static void pch_spi_pd_remove(struct platform_device *plat_dev)
 	dev_dbg(&plat_dev->dev, "%s:[ch%d] irq=%d\n",
 		__func__, plat_dev->id, board_dat->pdev->irq);
 
+	spi_controller_get(data->host);
+
+	spi_unregister_controller(data->host);
+
 	if (use_dma)
 		pch_free_dma_buf(board_dat, data);
 
@@ -1433,7 +1437,8 @@ static void pch_spi_pd_remove(struct platform_device *plat_dev)
 	}
 
 	pci_iounmap(board_dat->pdev, data->io_remap_addr);
-	spi_unregister_controller(data->host);
+
+	spi_controller_put(data->host);
 }
 #ifdef CONFIG_PM
 static int pch_spi_pd_suspend(struct platform_device *pd_dev,
-- 
2.53.0


