Return-Path: <stable+bounces-248786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBG8Mq1MB2opxQIAu9opvQ
	(envelope-from <stable+bounces-248786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:41:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E109553BC7
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0854D314B543
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC393CF698;
	Fri, 15 May 2026 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G7zt6D80"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC543CFF44;
	Fri, 15 May 2026 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862627; cv=none; b=nlyCIYLK4mmN+x2A4fkpmAtKzYBaU8xogh77pNUv4XKd6piWsXAdqVjs+6XoDd0huHdzsyshcAjLGWWUQTVfyoJCYxvhwa6Uy7FC3Du4f0tO6MJYtCSjBv2Kx/u+Of7BC06E4BCdbryYEmSZiy3Vt/YpmP0121mi8omH2wmAknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862627; c=relaxed/simple;
	bh=1PnIqYWjVplMaGs5FiRfOt5Z66pVnEcFVwBu8Srjh5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUbZLZ7jTSmcQjXoL7bBb85DSQrQA1EzJN7saYfUFcEEynIbzgXO+1EVI0lbG9TjavfiRqPjJ89C6cbNtfhHEI02c5SPmSI6i8Dee5Tf4QNRZyMLcG2Th+8zRn6IeY34sWFzfwkR0LqHFB4Q0Fmq8jLfWOEW53ZO+ITvrjjuaJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G7zt6D80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040CBC2BCC9;
	Fri, 15 May 2026 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862627;
	bh=1PnIqYWjVplMaGs5FiRfOt5Z66pVnEcFVwBu8Srjh5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G7zt6D800IDWLplDDjQedj4wx6C3dstlkMFaTmtuLAyoJUG0KkC5Ic02L9kRgN7dg
	 hk6h9NPKF9GSlbVx2qKxX24vXKx4JVku1jQll8X+5/5bjNRLRHjpLfWxmPSk7Nphxx
	 T0MXCNw9bZ6DIDLXIa2FFO7bbAmcjSZ8Nn7bNxTE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 7.0 120/201] spi: cadence-quadspi: fix runtime pm disable imbalance on probe failure
Date: Fri, 15 May 2026 17:48:58 +0200
Message-ID: <20260515154701.158611050@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6E109553BC7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248786-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 5ff4d5d1af0c7517bd8db83c95c4247a9729a548 upstream.

A recent attempt to fix the probe error handling introduced a runtime PM
disable depth imbalance by incorrectly disabling runtime PM on early
failures (e.g. probe deferral).

Fixes: f18c8cfa4f1a ("spi: cadence-qspi: Fix probe error path and remove")
Cc: stable@vger.kernel.org	# 7.0
Cc: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260421125354.1534871-2-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-cadence-quadspi.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1871,7 +1871,7 @@ static int cqspi_probe(struct platform_d
 	ret = clk_bulk_prepare_enable(CLK_QSPI_NUM, cqspi->clks);
 	if (ret) {
 		dev_err(dev, "Cannot enable QSPI clocks.\n");
-		goto disable_rpm;
+		return ret;
 	}
 
 	/* Obtain QSPI reset control */
@@ -1981,7 +1981,7 @@ static int cqspi_probe(struct platform_d
 		ret = cqspi_request_mmap_dma(cqspi);
 		if (ret == -EPROBE_DEFER) {
 			dev_err_probe(&pdev->dev, ret, "Failed to request mmap DMA\n");
-			goto disable_controller;
+			goto disable_rpm;
 		}
 	}
 
@@ -1999,14 +1999,13 @@ static int cqspi_probe(struct platform_d
 release_dma_chan:
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
-disable_controller:
+disable_rpm:
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
+		pm_runtime_disable(dev);
 	cqspi_controller_enable(cqspi, 0);
 disable_clks:
 	if (pm_runtime_get_sync(&pdev->dev) >= 0)
 		clk_bulk_disable_unprepare(CLK_QSPI_NUM, cqspi->clks);
-disable_rpm:
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
-		pm_runtime_disable(dev);
 
 	return ret;
 }



