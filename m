Return-Path: <stable+bounces-51567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A802290707D
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7DA1C24224
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC26C13CF9E;
	Thu, 13 Jun 2024 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ezm/kD1H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629B03209;
	Thu, 13 Jun 2024 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281674; cv=none; b=sH9lH598r/OzPckNVneSe4VxUY8D54qwIcQ9KYdg23ntP6JsUR0E4xDp8NrHzRSd7SwDPJMnLNKxtz8u+RRBA+xb3WS4NMouLdT8VTkVEO/COVsBKf8MtMXw9JsTtd5EWo/d7jU6AaV0NgpJWW9n6t77kPEBF3DdC6INIySiOmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281674; c=relaxed/simple;
	bh=RNOlSKDuNlt6usEFW9blgJNPQnJkig9jlyrpPz/7m6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8MeuO2zI5QlRufJxokc2C36rEfpetnEvX8IXgvkDd/ydGwgQ/e292PHF89zIiTD3Ob5AUu2DEds9B6sfTBda6HWXb2CEY4syzsXW4rPsRc3RJTHRQkIX4eTc3bdzdbKy9BsQYRXezjrUM7mS+Nv0CIIcW0qxfY7aXGuo7AgEiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ezm/kD1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D490AC2BBFC;
	Thu, 13 Jun 2024 12:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281674;
	bh=RNOlSKDuNlt6usEFW9blgJNPQnJkig9jlyrpPz/7m6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ezm/kD1HqdZ8UYeu7CtasMm+evZfcPjAzOA+iCKpamgY/JWMe7c5Tn2m1D+qOuW2w
	 BFs6+HwREqGpU9op9ho2o+5FEx0TGRW0jK92Sc+T93/epYv6mfDrWc8h1bNQGFQE6c
	 GJQHrSR0LigLjrJGtTVPj/QRAuLoXqAQxFwzJPx4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ken Milmore <ken.milmore@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15 007/402] r8169: Fix possible ring buffer corruption on fragmented Tx packets.
Date: Thu, 13 Jun 2024 13:29:24 +0200
Message-ID: <20240613113302.412723763@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ken Milmore <ken.milmore@gmail.com>

commit c71e3a5cffd5309d7f84444df03d5b72600cc417 upstream.

An issue was found on the RTL8125b when transmitting small fragmented
packets, whereby invalid entries were inserted into the transmit ring
buffer, subsequently leading to calls to dma_unmap_single() with a null
address.

This was caused by rtl8169_start_xmit() not noticing changes to nr_frags
which may occur when small packets are padded (to work around hardware
quirks) in rtl8169_tso_csum_v2().

To fix this, postpone inspecting nr_frags until after any padding has been
applied.

Fixes: 9020845fb5d6 ("r8169: improve rtl8169_start_xmit")
Cc: stable@vger.kernel.org
Signed-off-by: Ken Milmore <ken.milmore@gmail.com>
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/r/27ead18b-c23d-4f49-a020-1fc482c5ac95@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4273,11 +4273,11 @@ static void rtl8169_doorbell(struct rtl8
 static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
 {
-	unsigned int frags = skb_shinfo(skb)->nr_frags;
 	struct rtl8169_private *tp = netdev_priv(dev);
 	unsigned int entry = tp->cur_tx % NUM_TX_DESC;
 	struct TxDesc *txd_first, *txd_last;
 	bool stop_queue, door_bell;
+	unsigned int frags;
 	u32 opts[2];
 
 	if (unlikely(!rtl_tx_slots_avail(tp))) {
@@ -4300,6 +4300,7 @@ static netdev_tx_t rtl8169_start_xmit(st
 
 	txd_first = tp->TxDescArray + entry;
 
+	frags = skb_shinfo(skb)->nr_frags;
 	if (frags) {
 		if (rtl8169_xmit_frags(tp, skb, opts, entry))
 			goto err_dma_1;



