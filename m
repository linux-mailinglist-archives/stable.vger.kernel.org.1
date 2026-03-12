Return-Path: <stable+bounces-224818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIauORl2sml/MwAAu9opvQ
	(envelope-from <stable+bounces-224818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 09:15:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F57926EBBB
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 09:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9697630ADBAF
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 08:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FF6331A46;
	Thu, 12 Mar 2026 08:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjkQV5t7"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9230F7EF
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303288; cv=none; b=gPytzFYz2cWcXdrAKDT1FC/UzynXNzj4b4bYjl0MYFUbvrQPhO9aG14Bi6dr4+b6fj5DaGaXkdAydFTUK04BxBlS7BsFg3JhaYj+pOXF7lJD42HZweOKHNBw7U61wzc1UJQ2kK1f0DxxojyFbSVjav4yUIzUkbMLQVTd7X2aHuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303288; c=relaxed/simple;
	bh=cs1KGwAKEFW/FOK5rw+QRVROLa56giVXoJA5JjRTJIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k6D6pI93mkZWgqaQZMfdwlRz7AEU6kvhpp7gAJg36uU230SIcSdcWc+U5Bt0+FEHf+nIJdOBtNi9129Qvalf9o+mASyPCcw/b37W5dSKuv5iVsxSkgnUvt4RXankGKjSxpcqKXuYzJj5uunUVWk9Vx7ooTRdzJ66039E+Xcr+5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjkQV5t7; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899eabc5292so8957156d6.0
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 01:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773303286; x=1773908086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xmh4GWcYYRX4fgVVj4IGuhR0cpdqOiqNjv69jLST2ew=;
        b=gjkQV5t7H6BCNE7u85MDM20X8F3PK2AavH9evzrqjW3LtPs4cXbVV1ypP8IUdVtRZD
         HNFXQoKAh24rX/TtOhn473gwDcW8B8L3jjmdUfQV10jKtW3fhvIfoEofJIb45wVNcUL1
         BONwymdLh/qtJ4lE6U1VBFJvPhsdeFxd17vq8DVok1/oHj5hosXQVjixxBxZxU/HGiqU
         ATQmV1CrHRZW6lv01UOaw2W9+XuJLrpAO0TL6QN9wCPisqRvI14Cf15OgvzQSeuwggEN
         +ljcDHuzCCSoag3GFUuZB1OT68bm6/613fetS9aJoxTuMBHkgQSsPKmAiR8u5WidYAH8
         8ZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773303286; x=1773908086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xmh4GWcYYRX4fgVVj4IGuhR0cpdqOiqNjv69jLST2ew=;
        b=SYxCZu+H3yAmovilGorZR7EsXoXUDOmJFnkpDB/1dRd2HN6A5udBheiPTAfMIMMyZv
         sq0vyRM6rFJJ49tN/IzcIt0gItfF7Yuv/eupv1ZWM23+T3d50jEQDlMhqV8D18Wva21a
         AGm2J5GVGY/tVFSI+C9rC1tUFZDpJpGc/nj7xWN7UJhLeYYs6QfOfFzuag33YNCwlg2t
         82zGiKheJVfzTCcRIjBMxrsFwhZD7kxXy6NHfj+BqPNkggicIVWoFc6pQRAGXZ4whUW7
         65aTmvA6pf0RcXIzLjdc2DwJ/0wGdyleqEqobnoVS2KH+Hz5oQvgqSKQaOrMDXrXFoMY
         LzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUipH69z2pfFtzWj7bogwIJiqWCsFbCYmMmu/1b6D6J1oqHrw2kMCh0TWV8BEYT7Or+a42mGe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Tb0I2eDyKqB3kABwLu0g+/929Q06ls3fmp598HMpwhxJzhWw
	PG2/aFCtuBWf9CzuX6YIaEObi4/kM9+Fd78r7CS9bQ427UVH+5odZPsq
X-Gm-Gg: ATEYQzw8rsHKALsEswvUt4RWR11gP7RyxvWtyouztHjF06kWGd5YKPHSdxO1r0yTmid
	tKjEzbL09LSSUT7KyWhVfTJi9kLXWgW3KPuoBsJnnqTucrz+u+pp2csLWEiY11Tx2w1B7iwdG8G
	sHkpP1sbcvlbdus/maqfXWb9L1+4dWlMajHDchRZKS7SwY4m8mg47aPn2e/vzisOYFwpbP4kr3L
	3yj1dYMm18t+gQLsoStnKFlOi+yxPSuiv/V1lKx26OcNWLuI723IEPMrXhJrB9Wv1O4g0Rw0Jju
	i5XQoRpJvm88A4pfooU8OfYWWb621cCQsXhsKGjQ4G4y2M/HkGkVBNnHXFtZ6aXQRM9wRbneQRF
	KBkepNhcjd3494u2E16tpoq4HnDaUN5eayQc+h0XTrNFER4wa39oT84KpE/oQPH8GU2ujqN1ad2
	Z3hENT8cZJesE3pRf4uaTNNCtyCPF9ne0WT455sb/1Bf0=
X-Received: by 2002:a05:6214:622:b0:89a:1c81:65c1 with SMTP id 6a1803df08f44-89a669dd63dmr75619006d6.16.1773303286507;
        Thu, 12 Mar 2026 01:14:46 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65c122c0sm30423076d6.23.2026.03.12.01.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:14:46 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 12 Mar 2026 16:13:59 +0800
Subject: [PATCH net 2/2] net: macb: Reinitialize tx/rx queue pointer
 registers and rx ring during resume
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-macb-versal-v1-2-467647173fa4@gmail.com>
References: <20260312-macb-versal-v1-0-467647173fa4@gmail.com>
In-Reply-To: <20260312-macb-versal-v1-0-467647173fa4@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kevin Hao <haokexin@gmail.com>, Quanyang Wang <quanyang.wang@windriver.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,windriver.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224818-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F57926EBBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On certain platforms, such as AMD Versal boards, the tx/rx queue pointer
registers are cleared after suspend, and the rx queue pointer register
is also disabled during suspend if WOL is enabled. Previously, we assumed
that these registers would be restored by macb_mac_link_up(). However,
in commit bf9cf80cab81, macb_init_buffers() was moved from
macb_mac_link_up() to macb_open(). Therefore, we should call
macb_init_buffers() to reinitialize the tx/rx queue pointer registers
during resume.

Due to the reset of these two registers, we also need to adjust the
tx/rx rings accordingly. The tx ring will be handled by
gem_shuffle_tx_rings() in macb_mac_link_up(), so we only need to
initialize the rx ring here.

Fixes: bf9cf80cab81 ("net: macb: Fix tx/rx malfunction after phy link down and up")
Reported-by: Quanyang Wang <quanyang.wang@windriver.com>
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Tested-by: Quanyang Wang <quanyang.wang@windriver.com>
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/cadence/macb_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 67f7ecb05a7d6b8a5f49da588faafe1aa70d0d2b..100f478c0d30e4a91021a7da83f8f08606eca66e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -6106,8 +6106,18 @@ static int __maybe_unused macb_resume(struct device *dev)
 		rtnl_unlock();
 	}
 
+	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC))
+		macb_init_buffers(bp);
+
 	for (q = 0, queue = bp->queues; q < bp->num_queues;
 	     ++q, ++queue) {
+		if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
+			if (macb_is_gem(bp))
+				gem_init_rx_ring(queue);
+			else
+				macb_init_rx_ring(queue);
+		}
+
 		napi_enable(&queue->napi_rx);
 		napi_enable(&queue->napi_tx);
 	}

-- 
2.53.0


