Return-Path: <stable+bounces-256051-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN1uMNyoGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256051-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:43:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B51E5F9649
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7CBD30B8A44
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC59339866;
	Thu, 28 May 2026 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j+Jicloj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8A33987F;
	Thu, 28 May 2026 20:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000617; cv=none; b=KhPlhB5nGZ/jSseZK1jfcG55nOV0I/b4I6KFSi+p9YHpFWO71UH8Q/3jRRKnDPehOSDT90JcxBlSwcS3Ji+qjHI7qmwg0iwx3ILR3DpmSPoR7PDSK/d6TWLWfzfKM+ovp0UNEFvdFw1Y7nq6TONVAdLc65RZdX6sq/wLg4xcgZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000617; c=relaxed/simple;
	bh=05+zop8jFikkOSj/xoz+CRfj58deG6etafafEyQaQXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PytkEGyuKDiDmQ+eyWJz1fyxspSyFWYZze8YkR2ydxIOQjvguROYgBbmJa2JZVAfgL0Z7ROb2D2elYOaz1H8sfPX1CT3YrVdhzNWCQxJMcN2UEnjhFilaDLzgLwp39aXKamH83isnZgDyPLG0eGYykdUJKPFdhCAQePaED+Z1Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j+Jicloj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810681F000E9;
	Thu, 28 May 2026 20:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000616;
	bh=I7b67II96NxTQ5XQPG099ffA8kRXnwFBL6ZcT+rh/dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j+Jicloj6jC9ZumBdaKCHEBPUFPw2jY9fqjCATv/pvmvsDTciS0vtgqVuRyvk7Po+
	 RRBRPT0/V+fhM8jTaMLhGk1bcfFggcmzBwoHN48vqTcAfNolFQLJEcmQiRS6f8UR/y
	 PQwHeqRtFFuxDPAxE0DB3OzrBmBX1d3UxZi8q1ro=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12 108/272] spi: ep93xx: fix error pointer deref after DMA setup failure
Date: Thu, 28 May 2026 21:48:02 +0200
Message-ID: <20260528194632.400788642@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-256051-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6B51E5F9649
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 5e121a81667a83e9a01d62b429e340f5a4a84abc upstream.

The driver falls back to PIO mode if DMA setup fails during probe.

Make sure to the clear the DMA channel pointers on setup failure to
avoid dereferencing an error pointer on later probe errors or driver
unbind.

This issue was flagged by Sashiko when reviewing a devres allocation
conversion patch.

Fixes: e79e7c2df627 ("spi: ep93xx: add DT support for Cirrus EP93xx")
Link: https://sashiko.dev/#/patchset/20260429091333.165363-1-johan%40kernel.org?part=10
Cc: stable@vger.kernel.org	# 6.12
Cc: Nikita Shubin <nikita.shubin@maquefel.me>
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Nikita Shubin <nikita.shubin@maquefel.me>
Link: https://patch.msgid.link/20260512074849.915143-1-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-ep93xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index db50018050e5..f716c9607be4 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -582,12 +582,14 @@ static int ep93xx_spi_setup_dma(struct device *dev, struct ep93xx_spi *espi)
 	espi->dma_rx = dma_request_chan(dev, "rx");
 	if (IS_ERR(espi->dma_rx)) {
 		ret = dev_err_probe(dev, PTR_ERR(espi->dma_rx), "rx DMA setup failed");
+		espi->dma_rx = NULL;
 		goto fail_free_page;
 	}
 
 	espi->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(espi->dma_tx)) {
 		ret = dev_err_probe(dev, PTR_ERR(espi->dma_tx), "tx DMA setup failed");
+		espi->dma_tx = NULL;
 		goto fail_release_rx;
 	}
 
-- 
2.54.0




