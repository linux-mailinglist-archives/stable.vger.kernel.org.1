Return-Path: <stable+bounces-240140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CmbARFw52ke8AEAu9opvQ
	(envelope-from <stable+bounces-240140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:39:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE67143ABE4
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3903E305BDCC
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B05E3D300A;
	Tue, 21 Apr 2026 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMDPq5KK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ECE3D16EA;
	Tue, 21 Apr 2026 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776774994; cv=none; b=r8PaMVyQnzvQaCkCZZMtVNVjVmkQ09XH2NHgM7f87atdIREIdWYh398o25Du6vD4/ZQUljaEhuqtLOcjaojDLiM1R1rJFbzzLP/b1Ue+L+L/JQN10uUMYcsleB+zEXBeVcNYhg2wNadTsdxq2mGmC5vha7inhvHsS9aKG61sqns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776774994; c=relaxed/simple;
	bh=KxiawPPhW975UovztG38WmdbOcmtGvwrgRAh0YqH+ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9LC0t4Lk5WASO9oFFseizezL63HG0Jjhylrs8ADiVMGt+2Ls7KuY55KYjSdc+6zVnR98sApSADRRAMpmeMGLQXdW/F+ymNhGuPUWDN6Z+xDUbcTsIKeDDOQJi7bD7j4mDVj9LKX8re9UUiRGmKyh+kUCI7Eb83oRXH9xmzImaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMDPq5KK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01D9C2BCB8;
	Tue, 21 Apr 2026 12:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776774993;
	bh=KxiawPPhW975UovztG38WmdbOcmtGvwrgRAh0YqH+ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RMDPq5KK4DbP0H4ntVeEr4o1ITOzm7zATIT0tjyKscH0VnmEOQEl0NRvYdaEOzymc
	 ibnYMxNAg1UpqIE7RMbDMznjevY2YuYH6AKJjvCXv15aI9xq5ZjnRnVtoPZXih799/
	 RNRS0es+fw2C/efuZ6cSINvI8rEHRQF5sRYnQwsH+K+p8W9zeSIrGwf/cfCiOuKdof
	 U8C5hrDFEth8YO0H4zOsHAaIz/KWJ73hjVH2zhAm4LxpA1thHtXVYxaSM/ukZ14d3S
	 AYZFUewYGUF6jYhMk5V5foAghfaaCYn+2Z+/mogTx1eMcLoWo+KpJ1kvNxLB6Uk1Cp
	 cMPYB3NBrrxEw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFAL9-00000006QyF-2Nc2;
	Tue, 21 Apr 2026 14:36:31 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 2/4] spi: cadence: fix clock imbalance on probe failure
Date: Tue, 21 Apr 2026 14:36:13 +0200
Message-ID: <20260421123615.1533617-3-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421123615.1533617-1-johan@kernel.org>
References: <20260421123615.1533617-1-johan@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240140-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xilinx.com:email]
X-Rspamd-Queue-Id: AE67143ABE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure that the controller is active before disabling clocks on probe
failure to avoid unbalanced clock disable.

Also drop the usage count before returning (so that the controller can
be suspended after a probe deferral) and restore the autosuspend
setting.

Fixes: d36ccd9f7ea4 ("spi: cadence: Runtime pm adaptation")
Cc: stable@vger.kernel.org	# 4.7
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-cadence.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index bf4a7cf6b142..891e2ba36958 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -741,7 +741,6 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		/* Set to default valid value */
 		ctlr->max_speed_hz = xspi->clk_rate / 4;
 		xspi->speed_hz = ctlr->max_speed_hz;
-		pm_runtime_put_autosuspend(&pdev->dev);
 	} else {
 		ctlr->mode_bits |= SPI_NO_CS;
 		ctlr->target_abort = cdns_target_abort;
@@ -752,12 +751,17 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		goto clk_dis_all;
 	}
 
+	if (!spi_controller_is_target(ctlr))
+		pm_runtime_put_autosuspend(&pdev->dev);
+
 	return ret;
 
 clk_dis_all:
 	if (!spi_controller_is_target(ctlr)) {
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_set_suspended(&pdev->dev);
+		pm_runtime_put_noidle(&pdev->dev);
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
 	}
 remove_ctlr:
 	spi_controller_put(ctlr);
-- 
2.52.0


