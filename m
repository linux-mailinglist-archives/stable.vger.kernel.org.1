Return-Path: <stable+bounces-225494-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LBwNnRnt2mQQwEAu9opvQ
	(envelope-from <stable+bounces-225494-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 03:14:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 848C5293DA7
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 03:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00A8A30557F4
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 02:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C7C30B535;
	Mon, 16 Mar 2026 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xv2j3yDX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D30E30C35E
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627031; cv=none; b=mpWCtQmHjav5c3tPmb/gBUgy8mJtMTBQzwrsEYDdQwTxdeBgGRQ9XYTGXcnUbspCAtj4TYVwNBMK4x7uA71DZZDt3eHRqLl1tu0dnCJqa7fx0j23RUNqC88mug9cCSF9Vq+qV8k/PbnK26Umo8MbL/Gi+tN2WcICfP7ipxGuD2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627031; c=relaxed/simple;
	bh=iodMKVlN3gtM/vH3ohWtM82lJdYH0tG9s5iJw5Eun+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEB3j78GzzW6Y0fY5tJpcOsOmrrneV1vgzxblrIbrl1PSt5PMOvu26Kj2YQCpfesKz4G/niG11ZnhSdRVk8og8+euPPFjRzp73zYONeLDhDiiVF3VFTwhe5x2gqOqskNs4sXueMmrE3tpcNlXY/9pNv3cx/3+EWY0m3kWSz/18Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xv2j3yDX; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35b905e9dc0so650879a91.3
        for <stable@vger.kernel.org>; Sun, 15 Mar 2026 19:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773627030; x=1774231830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/yM1cLEJPCynSBddhLco3TyOcjIuEN7QpwgVXpMHAA=;
        b=Xv2j3yDXPrTyQuKX6iVJLFpC/pbzRiea5pzNyB/N9KweAf8h0yLbSczOmuSqV4oBhZ
         jsDOTdizRgsguE1UWBTVRrDnq337v1QHbdAGWYQb1lxR7lNYp6FYq5NoHGy+mD1pJWE2
         OCRbss6yT4VIz/gN8qzYiZH9wE6oFOBlnhR1/583824fC4b833c2CVnVTLyLc9EsgqqJ
         3zGjruGBaSKX8WPTi6urORsysjEkEPoXwehdg2TgX43sLumyVoXEb/Fq0yFcHLzXk/7K
         FpS1QRfLoTMoGUadggyxbsWrPFO+gLOGjFIRymhNywWPjoOtuU+w4aNLJqOk+EeIYBUD
         L4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627030; x=1774231830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C/yM1cLEJPCynSBddhLco3TyOcjIuEN7QpwgVXpMHAA=;
        b=WOKy8MdPuhnKg+06z+WkUwX0CAKKGewBqmH1Fj8PpZzCOQtKEAmkb8YOTz2ZuBDTPF
         tWg3+W6kdFvEfG+FiKaSxnQYWQsdiRdnKxNH2s6qYEPSdTQBqlo3hSvg0mJbjGlC7IrE
         Ro7LHu/GvRB0ZxGT21Puzj42kgc6dAY1ZT/S9lpJ8hIn7gy0vzYjnmzgv0qBhLR+SXrv
         WbCT50T47YwM960minSmEU92eh5a6gWQ+yfzBJZwJdlNki5o7pNgsoPKJUSZPaBKVzng
         nNmPJd8Q2nuYwtTqAt0lKXyp9o+QSWJn+ViD8MyXUNBZ2In5GBiaHQSA7bcPPPpwnzLP
         P6jA==
X-Forwarded-Encrypted: i=1; AJvYcCW+pf+CPE/3nAm7zP8frvDwUo5j9qxTsbRCU83IzH6pN36RUmygCd5QvTD0VrRG6Fx23j82Zik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBYdgdCkn/h9I7fVQQGjwVnvfi9iuyIPsky2UwlmoqzKF2fGfN
	LjWqt4+ycbKSCpnI46qs2CSw4SHHPrupGW/1hIQRhy7oP9QO7nYCOi2d
X-Gm-Gg: ATEYQzzNgn7FvEZNjiDBuiPiyr5PHn8P/PchbdVuLk/LK6aIFq+dQESh5TOaP1lalHT
	w+n6B+l7ylHcAgP6KIO5ms8Wuo5Ie/48Wg79J1F8+N6EYQXQnxarYRBc4PykSXcrXzi52+G8qHq
	sl0UbhBp6X1wk1+E8tHUwkqb10hWleOxlUCWbN31PRMs2a/PSMT0e4xVS9LwGA0KmaT2dNPa5ET
	XMbb6xGmvsxDJ9yXge85VojqPi/8KXVp+zFCPKIWrNNwaPTXL+Xy0KXAA81jfKuZ4ncNcISSLyO
	5oZTnePrCEc4AWfRnuSj3PNmgKo2ZHSXw1XdmKAsRUkHA611eBN4kGOC0ma9R4fT1IRlXiFH+sb
	Pz6a8t/yB5ac+0ZPy3dqrvb7hALfbSvwJJc//+N9mnwioJi5lPi/ZV076ee9T2WRIabjYHUl9iB
	MBY1KE90jecatYX06pxZ/G2RsA9Wbnefgm/Ywzao2xSEnnLf7CA1BT/A3/SAOJmLKu
X-Received: by 2002:a17:90b:4ace:b0:359:f8c3:dada with SMTP id 98e67ed59e1d1-35a21eb5ea6mr10794612a91.13.1773627029885;
        Sun, 15 Mar 2026 19:10:29 -0700 (PDT)
Received: from luna.turtle.lan (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02ffdfb7sm17705805a91.14.2026.03.15.19.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:10:28 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Serge Semin <fancer.lancer@gmail.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] net: stmmac: Fix NULL deref when RX encounters a dirty descriptor
Date: Sun, 15 Mar 2026 19:10:07 -0700
Message-ID: <20260316021009.262358-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260316021009.262358-1-CFSworks@gmail.com>
References: <20260316021009.262358-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,gmail.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-225494-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev,kernel];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 848C5293DA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Under typical conditions, `stmmac_rx_refill()` rearms every descriptor
in the RX ring. However, if it fails to allocate memory, it will stop
early and try again the next time it's called. In this situation, it
(correctly) leaves OWN=0 because the hardware is not yet allowed to
reclaim the descriptor.

`stmmac_rx()`, however, does not anticipate this scenario: it assumes
`cur_rx` always points to a valid descriptor, and that OWN=0 means the
buffer is ready for the driver. A `min()` clamp at the start prevents
`cur_rx` from wrapping all the way around the buffer (see Fixes:),
apparently intended to prevent the "head=tail ambiguity problem" from
breaking `stmmac_rx_refill()`. But this safeguard is incomplete because
the threshold to stay behind is actually `dirty_rx`, not `cur_rx`. It
works most of the time only by coincidence: `stmmac_rx_refill()` usually
succeeds often enough that it leaves `dirty_rx == cur_rx`. But when
`stmmac_rx()` is called when `dirty_rx != cur_rx` and the NAPI budget is
high, `cur_rx` can advance to a still-dirty descriptor, violating the
invariant and triggering a panic when the driver attempts to access a
missing buffer.

This can easily be fixed by subtracting `stmmac_rx_dirty()` from the
clamp. Because that function currently interprets `dirty_rx == cur_rx`
to mean "none dirty," its maximum return value is `dma_rx_size - 1`, so
doing this carries no risk of underflow, though does (like the Fixes:)
leave a clean buffer unreachable.

Fixes: b6cb4541853c7 ("net: stmmac: avoid rx queue overrun")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221010
Cc: stable@vger.kernel.org
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6827c99bde8c..f98b070073c0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5609,7 +5609,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
 	bufsz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
-	limit = min(priv->dma_conf.dma_rx_size - 1, (unsigned int)limit);
+	limit = min(priv->dma_conf.dma_rx_size - stmmac_rx_dirty(priv, queue) - 1,
+		    (unsigned int)limit);
 
 	if (netif_msg_rx_status(priv)) {
 		void *rx_head;
-- 
2.52.0


