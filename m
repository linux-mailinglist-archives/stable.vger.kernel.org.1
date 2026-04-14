Return-Path: <stable+bounces-237878-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0COPGExG3mn+pwkAu9opvQ
	(envelope-from <stable+bounces-237878-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:51:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D83113FABE7
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC0F7306B2C8
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93583E714C;
	Tue, 14 Apr 2026 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0vKlASY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481263E5EF9;
	Tue, 14 Apr 2026 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174341; cv=none; b=QNTCCrVgZBphskVDRrKMiJaUX6Vre651j7KM9S1o9mrgU2hDBwHEB2ikgSooQ8Ao6Wjo3KXX/zFt5i4u+JXQ/cwo6t8GuKcMQvDNuhWZZmGgpOft6hJuq3U4BgarorLlSEPberT7wgoQ0lwKdxtprUZXcXwOEV2CJhgV+ji7zcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174341; c=relaxed/simple;
	bh=53ad1irEqhAo43vfv6Y2SIlO3JtmIiRbHZrk6q58rDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jK8KzGKsmSsFabJ2Qpi5hPXDrAMcaYV7FV+IzryTIJPiKmPBbtqb6sM6eLBO8mDEYbh+T334iB8hrTTiVvvwaXNAksoYJJ+I+VjT0lBaRnG0BW7Kzs2/rnEMzIL4EzJRMiIqd6MbDE1nQ/xC+BHtq02NG+O2pWTLtiKufbaLbqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0vKlASY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D80C19425;
	Tue, 14 Apr 2026 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776174341;
	bh=53ad1irEqhAo43vfv6Y2SIlO3JtmIiRbHZrk6q58rDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R0vKlASYt5MrluAcsCDwACVQRViUES3piVCU9s0N75u+9xbRml39UEMnjpEMZOotY
	 3R18npY4LEe+cOIBMGysxDBDv7azKJe4S6Zouu1qog/Ye8jJFkxH+f0hGp7+ME8IaC
	 FAVI9D3p59ZKgwSHqvVUPq0K24JwqCZn64yUjRswPxTdI24kDymXkro1u7zbAEPbuy
	 cCzTGrPlzr9sjZSvT5L9tyjqOUWU+ckgRYGiZ1cNHOv2Vi7iaq4lXfGO4ujo/7l73x
	 xhSwJzsVaeseuB2PRPsQGJsqi1Qv8U2G2Rxec8NG5e0maPn2HvE51KlY3gm9GJQuba
	 +KUzjdJy0uCzw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wCe5C-000000046W6-3Bq0;
	Tue, 14 Apr 2026 15:45:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Subject: [PATCH 8/8] spi: topcliff-pch: fix use-after-free on unbind
Date: Tue, 14 Apr 2026 15:43:19 +0200
Message-ID: <20260414134319.978196-9-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260414134319.978196-1-johan@kernel.org>
References: <20260414134319.978196-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237878-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[okisemi.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D83113FABE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Give the driver a chance to flush its queue before releasing the DMA
buffers on driver unbind

Fixes: c37f3c2749b5 ("spi/topcliff_pch: DMA support")
Cc: stable@vger.kernel.org	# 3.1
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index c120436434d0..14d11450e86d 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1410,9 +1410,6 @@ static void pch_spi_pd_remove(struct platform_device *plat_dev)
 
 	spi_unregister_controller(data->host);
 
-	if (use_dma)
-		pch_free_dma_buf(board_dat, data);
-
 	/* check for any pending messages; no action is taken if the queue
 	 * is still full; but at least we tried.  Unload anyway */
 	count = 500;
@@ -1436,6 +1433,9 @@ static void pch_spi_pd_remove(struct platform_device *plat_dev)
 		free_irq(board_dat->pdev->irq, data);
 	}
 
+	if (use_dma)
+		pch_free_dma_buf(board_dat, data);
+
 	pci_iounmap(board_dat->pdev, data->io_remap_addr);
 
 	spi_controller_put(data->host);
-- 
2.52.0


