Return-Path: <stable+bounces-246364-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFwHLAZsA2of5wEAu9opvQ
	(envelope-from <stable+bounces-246364-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:05:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 884DC526BE0
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC33930507B1
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65540284883;
	Tue, 12 May 2026 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n22v9TTf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264343EDE5D;
	Tue, 12 May 2026 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609036; cv=none; b=AbhaRfm5gRTr6sgQXwnqM1IpY8vsfP731+3MFOQLeRxqDp7gJniYCNJn8W7TnjVa3UhuAzt5n4c5pKdWq256MLiAZsY77Qr2ZmKDjL5V0k4IkSzcXInCu3qgSKJSF8/u6nFtvRKjFlNhx6znIt7x6RjS+GZcY1VsRQQjwosBC4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609036; c=relaxed/simple;
	bh=4X0lANsi8ek67RnIQCFecdNJRDMwt8Ufs6pWHZ1Qugw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TiopVc9d+5r61st/SxsDMps9wTt/45PLP8UJUoh+HcS1zymX7wdSAHe3MsIGihe+rmgkLIlD7UNWY9JowZHS5P2KvCf99Qr0wyrcex/6BQMcDccMKYLsRxabwiTsN2SM2caWkw5lvjMT29O0xadB4AvhKq2jHPiZMqN88e4o7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n22v9TTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BBFC2BCB0;
	Tue, 12 May 2026 18:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609036;
	bh=4X0lANsi8ek67RnIQCFecdNJRDMwt8Ufs6pWHZ1Qugw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n22v9TTfa/Wddh8vqRKu3pSJJ3Hkq15D69q7063OCEmqIoBeiOlOAw8EKNCj87ZPb
	 GIVysW6qL2+Knz17owpYa8WClwWPcxXeLTIAnnBRubWgG5gyTLW1KCsRZs9D2pjiqf
	 8ANJvADyZd+9NOJ/AXWEUwW8TBpE5L7qywbGifgA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 7.0 041/307] USB: omap_udc: DMA: Dont enable burst 4 mode
Date: Tue, 12 May 2026 19:37:16 +0200
Message-ID: <20260512173940.991599636@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 884DC526BE0
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
	TAGGED_FROM(0.00)[bounces-246364-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iki.fi:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaro Koskinen <aaro.koskinen@iki.fi>

commit 3f91484f6c13c434bd573ca6b6779c26adb0ddab upstream.

Commit 65111084c63d7 ("USB: more omap_udc updates (dma and omap1710)")
added setting for DMA burst 4 mode. But I think this should be undone for
two reasons:

- It breaks DMA on 15xx boards - transfers just silently stall.

- On newer OMAP1 boards, like Nokia 770 (omap1710), there is no measurable
performance impact when testing TCP throughput with g_ether with large
15000 byte MTU size.

It's also worth noting that when the original change was made, the
OMAP_DMA_DATA_BURST_4 handling in arch/arm/plat-omap/dma.c was broken, and
actually resulted in the same as the OMAP_DMA_DATA_BURST_DIS i.e. burst
disabled. This was fixed not until a couple kernel releases later in an
unrelated commit 1a8bfa1eb998a ("[ARM] 3142/1: OMAP 2/5: Update files
common to omap1 and omap2").

So based on this it seems there was never really a very good reason to
enable this burst mode in omap_udc, so remove it now to allow 15xx DMA
to work again (it provides 2x throughput compared to PIO mode).

Fixes: 65111084c63d ("[PATCH] USB: more omap_udc updates (dma and omap1710)")
Cc: stable <stable@kernel.org>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Link: https://patch.msgid.link/ad06qHLclWHeSGnV@darkstar.musicnaut.iki.fi
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/omap_udc.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -733,8 +733,6 @@ static void dma_channel_claim(struct oma
 		if (status == 0) {
 			omap_writew(reg, UDC_TXDMA_CFG);
 			/* EMIFF or SDRC */
-			omap_set_dma_src_burst_mode(ep->lch,
-						OMAP_DMA_DATA_BURST_4);
 			omap_set_dma_src_data_pack(ep->lch, 1);
 			/* TIPB */
 			omap_set_dma_dest_params(ep->lch,
@@ -756,8 +754,6 @@ static void dma_channel_claim(struct oma
 				UDC_DATA_DMA,
 				0, 0);
 			/* EMIFF or SDRC */
-			omap_set_dma_dest_burst_mode(ep->lch,
-						OMAP_DMA_DATA_BURST_4);
 			omap_set_dma_dest_data_pack(ep->lch, 1);
 		}
 	}



