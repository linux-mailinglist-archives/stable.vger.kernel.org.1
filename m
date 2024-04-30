Return-Path: <stable+bounces-41873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 720FE8B7023
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881DE1C21E11
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D474C12C54A;
	Tue, 30 Apr 2024 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n1pHTDk+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EBF12CDB2;
	Tue, 30 Apr 2024 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473818; cv=none; b=lKsXJ059aUC0UkWSDmtGiCR8Mmkw+8gZ5+LkoSbRsOlHP7nOKXcQ1gkzoO8uwsMcrhIUXX5WPAg2FNDoLn94AOZgdJlDpoHuvWvq/Cavu+5t5dJ0fNf0dA280jpXLk+ZwkuWws7fQRFYYVm/txAPOlPyK81ylEAblJj9oXkg9EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473818; c=relaxed/simple;
	bh=enEdUj7yDmIlfCH1NsSYMrSF9V63EscIV0MjUeDkDIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fD0HfTt2CctvASkjWiqsovT5TTsh2waBcQ+uWqC9qR+XcXl4/FNR72/2mTVHgq2qhYIBCx/i7nis5F9c+WpSLuAgAai1d8ySqVVFY/Hw1rKFoeZIcgXLeqm2IwwDGbQPB6OgfFukQ+zDzE+4DGU2TLH9GsBsmb5QMFTVakkxPtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n1pHTDk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7DAC4AF5F;
	Tue, 30 Apr 2024 10:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714473818;
	bh=enEdUj7yDmIlfCH1NsSYMrSF9V63EscIV0MjUeDkDIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1pHTDk+xXwRU3w94CbQIgLsouGpOCt9Oi67oWvff9Ls3kWIRVAJn2zQhCP3/5jEx
	 ZnlsB0rdqL/nPW3xrqzlTz+/jisSd+vGx4OpBH0jlEkLdpvuWohCA3x0Lao5fXddIM
	 Lb9tT/jnUyBw/Wh9/0Vj2pcU++01MiMrHYMuNjNY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	shironeko <shironeko@tesaguri.club>,
	Eric Dumazet <edumazet@google.com>,
	Jose Alonso <joalonsof@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 47/77] net: usb: ax88179_178a: stop lying about skb->truesize
Date: Tue, 30 Apr 2024 12:39:26 +0200
Message-ID: <20240430103042.524688351@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103041.111219002@linuxfoundation.org>
References: <20240430103041.111219002@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 4ce62d5b2f7aecd4900e7d6115588ad7f9acccca ]

Some usb drivers try to set small skb->truesize and break
core networking stacks.

In this patch, I removed one of the skb->truesize overide.

I also replaced one skb_clone() by an allocation of a fresh
and small skb, to get minimally sized skbs, like we did
in commit 1e2c61172342 ("net: cdc_ncm: reduce skb truesize
in rx path")

Fixes: f8ebb3ac881b ("net: usb: ax88179_178a: Fix packet receiving")
Reported-by: shironeko <shironeko@tesaguri.club>
Closes: https://lore.kernel.org/netdev/c110f41a0d2776b525930f213ca9715c@tesaguri.club/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jose Alonso <joalonsof@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240421193828.1966195-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/ax88179_178a.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 3df203feb09c5..812361e832fd5 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1465,21 +1465,16 @@ static int ax88179_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			/* Skip IP alignment pseudo header */
 			skb_pull(skb, 2);
 
-			skb->truesize = SKB_TRUESIZE(pkt_len_plus_padd);
 			ax88179_rx_checksum(skb, pkt_hdr);
 			return 1;
 		}
 
-		ax_skb = skb_clone(skb, GFP_ATOMIC);
+		ax_skb = netdev_alloc_skb_ip_align(dev->net, pkt_len);
 		if (!ax_skb)
 			return 0;
-		skb_trim(ax_skb, pkt_len);
+		skb_put(ax_skb, pkt_len);
+		memcpy(ax_skb->data, skb->data + 2, pkt_len);
 
-		/* Skip IP alignment pseudo header */
-		skb_pull(ax_skb, 2);
-
-		skb->truesize = pkt_len_plus_padd +
-				SKB_DATA_ALIGN(sizeof(struct sk_buff));
 		ax88179_rx_checksum(ax_skb, pkt_hdr);
 		usbnet_skb_return(dev, ax_skb);
 
-- 
2.43.0




