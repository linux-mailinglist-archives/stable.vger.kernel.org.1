Return-Path: <stable+bounces-247800-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEUEANgyB2qQswIAu9opvQ
	(envelope-from <stable+bounces-247800-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:51:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54583551B1A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1072300F119
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3963B6C19;
	Fri, 15 May 2026 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqbfH9A9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFFF2DFF04
	for <stable@vger.kernel.org>; Fri, 15 May 2026 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778856537; cv=none; b=Oq5TYlbJDoga1REI42leE2O+4LFmx0PiQ4PsQ2bja3XOsqnt1KHsjb7ajqY54QdsLxxPmRDMxtsm8kGLdOuKuH4LUUPxdZX42cx3rie66Esq2dDpYKVByB5giphJNF9J1dIogQnVS5Yn5q2hHYR2dojo/QIzfbSLuek57ZbOEBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778856537; c=relaxed/simple;
	bh=+khoP2hEZN6OGoTWqfbGyz4bbrPorBs3O4VkLKgY4Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hATJnT1idbTICD/W3hPbNS+ZdNORKeThdhqKjl2auY1qbML1STUKaLL/JjS25bDHCGGgs92MQHzazp8qrySMR0Dra3PGLwirUqCKGAB1vLziGR6RFEVHkSt+baQ1doZDYvw1EbzXmul0viWUcwGBLErcTTkFwhUyI+Brn7WgInk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqbfH9A9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D38C2BCB0;
	Fri, 15 May 2026 14:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778856536;
	bh=+khoP2hEZN6OGoTWqfbGyz4bbrPorBs3O4VkLKgY4Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lqbfH9A96iV+1lsAYUHtDMGZ/Q45/M1QntG1znWVQxYfmfEl7rNJfcP/MLkEvgsn0
	 pB4iT1hoAYA52sWCTm07iXTP0Hm/eFIysPbpRmf3GusY1HmteqmP0NKWFfIIN2HM1c
	 y4+LA6xgTDXVxxuN2EJudco7JOKdF4CYhyJ7zfaxiwjPq1xQga0qutFSXH+dcsWenU
	 bVG5w0qTEUMbA8uYkTELexttCFIEFb99Jip8e+DSTTjHUoCZnHFIANUS36Q0wqpAZ1
	 BwoQKH9CwmzA9HX/l8zc136ELmhfJnE2XxgwdMmDcb1TAwF9EntK2UIBRFkW1u4yFP
	 YN9HeYCAZeC8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Masayuki Ohtake <masa-korg@dsn.okisemi.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] spi: topcliff-pch: fix controller deregistration
Date: Fri, 15 May 2026 10:48:54 -0400
Message-ID: <20260515144854.3250320-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051240-chest-glider-6f38@gregkh>
References: <2026051240-chest-glider-6f38@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 54583551B1A
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
	TAGGED_FROM(0.00)[bounces-247800-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
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
[ renamed data->host to data->master and kept return 0 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 7fb020a1d66aa..11dac4e651fe4 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1426,6 +1426,10 @@ static int pch_spi_pd_remove(struct platform_device *plat_dev)
 	dev_dbg(&plat_dev->dev, "%s:[ch%d] irq=%d\n",
 		__func__, plat_dev->id, board_dat->pdev->irq);
 
+	spi_controller_get(data->master);
+
+	spi_unregister_controller(data->master);
+
 	if (use_dma)
 		pch_free_dma_buf(board_dat, data);
 
@@ -1453,7 +1457,8 @@ static int pch_spi_pd_remove(struct platform_device *plat_dev)
 	}
 
 	pci_iounmap(board_dat->pdev, data->io_remap_addr);
-	spi_unregister_master(data->master);
+
+	spi_controller_put(data->master);
 
 	return 0;
 }
-- 
2.53.0


