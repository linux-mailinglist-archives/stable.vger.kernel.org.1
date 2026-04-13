Return-Path: <stable+bounces-236377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM56LZUZ3WnoZwkAu9opvQ
	(envelope-from <stable+bounces-236377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:28:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 493733EEFFC
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0762309BAE0
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287802BE65F;
	Mon, 13 Apr 2026 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qrpRK2+S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6FE27466A;
	Mon, 13 Apr 2026 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096748; cv=none; b=h1Fn6JV84LRMa1Yi3imGM5jrCqBZWZDbx5z2ji5XxS7LNj/z/ov1TIaK9qsb7LSZZtgf0QfPNeOERhZruDyrQJY/CRxbdhcZPNtqHQJXz09b+NRhTuNeVYwvYYN010dnVYtkI95iq+jVxry0fhc4+5KV4orOFSkEA9+75JMB+vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096748; c=relaxed/simple;
	bh=Hx5vWiUXALgzAO3mnPYy41ph4Zy9F2dJrfQ1uvKXJVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/FvgeX0yaAXBkKJ1A3r0pebtnZdlBZRQBD7xujqnwW80YPTsws4AaP/1WutiHes2OUG5nf2D/ZcA7gTUVnwN5F9td9e39luNlZE1eGCQ/VnGJToWczGtisk3QDwOAYRoGQXFoNUH98gLRDZeA/YsGNpuSnFjF/42U8ZtjW2c+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qrpRK2+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ECDC2BCB4;
	Mon, 13 Apr 2026 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096748;
	bh=Hx5vWiUXALgzAO3mnPYy41ph4Zy9F2dJrfQ1uvKXJVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qrpRK2+S6E1Lvh7lpg7256WACVxzwfkfU9oPiCiwdCkPvkA33jTwdWT/e3qZpzeTe
	 c9lZZw98Ic6IzSyXHSV775cX9lliFJaYNXNR/b9lC+AilQcrHMdzfSyp42H/VHIV4h
	 zcoZkN3//3/cCLtn43KRGoQXBSGkErJmoWG6IsQc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Carlier <devnexen@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 46/70] net: altera-tse: fix skb leak on DMA mapping error in tse_start_xmit()
Date: Mon, 13 Apr 2026 18:00:41 +0200
Message-ID: <20260413155729.904145155@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
References: <20260413155728.181580293@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236377-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 493733EEFFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Carlier <devnexen@gmail.com>

commit 6dede3967619b5944003227a5d09fdc21ed57d10 upstream.

When dma_map_single() fails in tse_start_xmit(), the function returns
NETDEV_TX_OK without freeing the skb. Since NETDEV_TX_OK tells the
stack the packet was consumed, the skb is never freed, leaking memory
on every DMA mapping failure.

Add dev_kfree_skb_any() before returning to properly free the skb.

Fixes: bbd2190ce96d ("Altera TSE: Add main and header file for Altera Ethernet Driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Link: https://patch.msgid.link/20260401211218.279185-1-devnexen@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/altera/altera_tse_main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -572,6 +572,7 @@ static netdev_tx_t tse_start_xmit(struct
 				  DMA_TO_DEVICE);
 	if (dma_mapping_error(priv->device, dma_addr)) {
 		netdev_err(priv->dev, "%s: DMA mapping error\n", __func__);
+		dev_kfree_skb_any(skb);
 		ret = NETDEV_TX_OK;
 		goto out;
 	}



