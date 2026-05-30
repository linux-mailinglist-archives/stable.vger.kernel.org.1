Return-Path: <stable+bounces-257815-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH5TKh0gG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-257815-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:36:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F380610023
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B3E43089768
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A301A2E7379;
	Sat, 30 May 2026 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T6wlFaTj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2BE3AA182;
	Sat, 30 May 2026 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162265; cv=none; b=QQwUkTiZ5fQfe0pxN0f1PvmIpSILELZK/vtcrziM3gJI9TfbX3HsUoxQA8MA2MS3dWnYz2Vk3ZLY/E2pc1dA3ULZrXUrDqKAuxH4Ue62wBwc74KLln08PETL+QY2V/whXpdp2DbnSxrIL5B2HPEP1mDCjyjCkszqhtE01cY5Rzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162265; c=relaxed/simple;
	bh=g43dq6gd9GH/JJhiS6rZshDnZ74e+nKWtJi6YYx4nyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hv4lHW5GKA23QZKQCXuHOFgk3CR4FgkA9TWHUL8re1Dm8qLiDqMoBbQmuSVyNzmkzPnaqKJuJpEaa5t9kZMPbTwIKdlAIaqn2fggnZLimT36UmuH4+H37F5b6gDpsnj0bi0TcKFA15a9e8bJjnXtmk4dE//ryURrKPspi6w2HC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T6wlFaTj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B4C1F00893;
	Sat, 30 May 2026 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162262;
	bh=yQDlyMZ9eZgCwQ0tIX+p4ZMBw+DzHrPDJlIFtkhXQzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T6wlFaTjIAHRW9dImC2EbDFi9Zs69fs0mHNWvUWoKinXU+dwQOza6/VBLS9WVkA7H
	 ELN1RiE5B+0XPB3JkIIPbLvYsnArsb2CrCLof9mIFCHrNA7MM7rPxvQB2ldJ+/CT7G
	 E77A0tfWOKUn09eCUTMqFp0u+m8cTnEszjo86tG0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vignesh R <vigneshr@ti.com>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 870/969] spi: ti-qspi: fix use-after-free after DMA setup failure
Date: Sat, 30 May 2026 18:06:34 +0200
Message-ID: <20260530160324.707413108@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257815-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ti.com:email,sashiko.dev:url,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 0F380610023
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit ea6ec3343e05f7937a53eb6d7617b3abdb4abc19 upstream.

The driver falls back to PIO mode if DMA setup fails during probe.

Make sure to clear the DMA channel pointer also if buffer allocation
fails to avoid passing a pointer to the released channel to the DMA
engine (or trying to free the channel a second time on late probe errors
or driver unbind).

This issue was flagged by Sashiko when reviewing a devres allocation
conversion patch.

Fixes: c687c46e9e45 ("spi: spi-ti-qspi: Use bounce buffer if read buffer is not DMA'ble")
Link: https://sashiko.dev/#/patchset/20260505072909.618363-1-johan%40kernel.org?part=17
Cc: stable@vger.kernel.org	# 4.12
Cc: Vignesh R <vigneshr@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260512074809.915084-1-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-ti-qspi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -875,6 +875,7 @@ static int ti_qspi_probe(struct platform
 		dev_err(qspi->dev,
 			"dma_alloc_coherent failed, using PIO mode\n");
 		dma_release_channel(qspi->rx_chan);
+		qspi->rx_chan = NULL;
 		goto no_dma;
 	}
 	master->dma_rx = qspi->rx_chan;



