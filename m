Return-Path: <stable+bounces-230814-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJtCIPoryGlWhgUAu9opvQ
	(envelope-from <stable+bounces-230814-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 20:28:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E490E34FCF7
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 20:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDE153067580
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 19:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F5E346AC6;
	Sat, 28 Mar 2026 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEgR0KLr"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522A1330328
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774725935; cv=none; b=m6ziVryeXbOf+OYKEUPOEYOskE3c3cw+EEWlyyBOwinR1j26mps5odyWw9GWtPbo/6syKygtuvTSXYkdANVp+hbUX3V3WFy+UgiORDhD0TXvyaDggEcCYwgPzCXyQvHlBAsJldjypaLKxx0Ma7mphfDetQ5atR7PifdmqwzuHUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774725935; c=relaxed/simple;
	bh=qGFTzlpUUEI4pKdSdaSVMTnjSAfvQHYO8xeTqhyGGNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCG2Kr00iL//3bqYaX5S3YGPC1AT9EH9k99WpqvtwL0E6K0bJsN2z29lrEwOGeuRfxWNy3Fd1np6+Et9LKIPPxQiBs23T7BQ+TZfqpC+q4b+OhpkmakX2YNGmMDSEVRjEMXgv6UbXq4sSefrRCkdSBkpGTv75mi/pyIYy2na3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEgR0KLr; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-128ebee22caso1606520c88.0
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 12:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774725932; x=1775330732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nV0vTDjXno/BRjs9UsVyAooL1Z9SQRTeEW/NqAyKUfY=;
        b=lEgR0KLrwKjxKMvDE7rNcArqNArDMySNPm3gewc/DJDizynnvtbkQUAHotPimHp8Cd
         hLJm/LZ2MbSzJ/QOUyMg62MAkgscoQrSTwy/XQGzKfmFV8XDxTmX6CJoIfV7D9SEXysB
         rGAWPgXuI5ayVUf9ayPELcRxFvRHtlRNqj2XuXI2LkYUfpaCZeGvKgm5BWeoiYFzhlYw
         xIxO3DZlR6fLG/iJb32msjYk92zaUEVn347yLGYVWpNk5o0OFOPHYzIdry5zosA9WSul
         4T1AuLy7rx/AeJXTxyJpu1wdxm8poar/CzsgRCSTPlDRyFNop7pjcmTvuymJ/62fhtnJ
         88CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774725932; x=1775330732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nV0vTDjXno/BRjs9UsVyAooL1Z9SQRTeEW/NqAyKUfY=;
        b=jwF4NH8dUt3Vg7bWrF8UQAyFJh6jQY95wIi5CYR8FFjeK26D9G8pQsmDBa+rEmwNPe
         D1X2c0NV3i9LU/tmgxnLnr2l2PWkqyI89hRcyA7lOGAZPSK0UHIkrLB0EvfJCsnHsF/H
         irIevOqGsJ/R6UvZXJasdXI4js7fcYIkoF+/aOowsbRwx2FsDX0DtL5+w/Ojz+EONRop
         vYSW4ZW9DISK6sHCY+FYaAzm/z0aVdSpnBXsIKyhHRkfBoepi3EWPAwSMvh3pl2Cw3rA
         gv5lNvGdkvdZieDGhdI8eDgDCkDdv/MTesEktuuAHl9wZzHHTVztoQnHMt304QxeyWsb
         Zv9A==
X-Forwarded-Encrypted: i=1; AJvYcCWCDHI9DvuFu49gAgdEfJzzdrVs2lwxP5sJgPDhch/5hKJQ1rPNhipeF+wn/iY/OMxBQw9ycM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaG8nqVOutBCLbgCR20mgACwS6gQxDcjVEHpwZuowDCmIUS6bP
	jHyWPfsuoLpYHDnL8TZww1d46h6baxEL7OtVEpmRMNPT6jFAB6Oy+5bcWGsHhZxY
X-Gm-Gg: ATEYQzxzA7Tnhl9XWelnnY6xE1TEQa6dWrcdh9iXnogaGE1lLr92y/wu5yIk49pHHao
	vjCAk4DE3enlmZJCPv0l6KG35wg5f+QsovefdxfAn9w1YcF2KhjKa/9UKi1b9RWUVzRa1KrOK6o
	2vKjFG6pvOMMHFLLoYjxVe2MOH4HHpz/1at4IAdpJS+farsiknbwgyAhuavYkWKuY2UbqhNofM2
	xgtLFRRBNjoBrEFUGmZ78mAie49NGcytsJwUkix8CfkY+cbPRgr5s5NPo3thLfrixsd3wUmJhGM
	LCwGv0GfzStTpgleBsx/rtYqXFnaX8Z60zpzMAuNxeuEKb7aQYqdDcLRgwiIFMUpCjyiq53vmfB
	4jUTrzo7s0QWGk8kohojk0nVW7piF2k58oDTYuOgL1jAsC96aYvnO+7wEZpPriaCtJzw+PG0YAi
	7/alACIp0G477lUBsefzomWFDk1Gbbxm/CGv+lfM6duLtkSb7RRN8JMvNP
X-Received: by 2002:a05:7022:92a:b0:11b:9b9f:426b with SMTP id a92af1059eb24-12ab28e4dd5mr4350751c88.20.1774725932423;
        Sat, 28 Mar 2026 12:25:32 -0700 (PDT)
Received: from localhost (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-12ab970da7fsm2819438c88.0.2026.03.28.12.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 12:25:30 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Serge Semin <fancer.lancer@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [RESEND PATCH net v3 2/2] net: stmmac: Prevent indefinite RX stall on buffer exhaustion
Date: Sat, 28 Mar 2026 12:25:03 -0700
Message-ID: <20260328192503.520689-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260328192503.520689-1-CFSworks@gmail.com>
References: <20260328192503.520689-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230814-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E490E34FCF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The stmmac driver handles interrupts in the usual NAPI way: an interrupt
arrives, the NAPI instance is scheduled and interrupts are masked, and
the actual work occurs in the NAPI polling function. Once no further
work remains, interrupts are unmasked and the NAPI instance is put to
sleep to await a future interrupt. In the receive case, the MAC only
sends the interrupt when a DMA operation completes; thus the driver must
make sure a usable RX DMA descriptor exists before expecting a future
interrupt.

The main receive loop in stmmac_rx() exits under one of 3 conditions:
1) It encounters a DMA descriptor with OWN=1, indicating that no further
   pending data exists. The MAC will use this descriptor for the next
   RX DMA operation, so the driver can expect a future interrupt.
2) It exhausts the NAPI budget. In this case, the driver doesn't know
   whether the MAC has any usable DMA descriptors. But when the driver
   consumes its full budget, that signals NAPI to keep polling, so the
   question is moot.
3) It runs out of (non-dirty) descriptors in the RX ring. In this case,
   the MAC will only have a usable descriptor if stmmac_rx_refill()
   succeeds (at least partially).

Currently, stmmac_rx() lacks any check against scenario #3 and
stmmac_rx_refill() failing: it will stop NAPI polling and unmask
interrupts to await an interrupt that will never arrive, stalling the
receive pipeline indefinitely.

Fix this by checking stmmac_rx_dirty(): it will return 0 if
stmmac_rx_refill() fully succeeded and we can safely await an interrupt.
Any nonzero value means some allocations failed, in which case we risk
dropping frames if a large traffic burst exhausts the surviving
non-dirties. Therefore, simply return the full budget (to keep polling)
until all allocations succeed.

Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers.")
Cc: stable@vger.kernel.org
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f98b070073c0..81f764352f3d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5604,6 +5604,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	unsigned int desc_size;
 	struct sk_buff *skb = NULL;
 	struct stmmac_xdp_buff ctx;
+	int budget = limit;
 	int xdp_status = 0;
 	int bufsz;
 
@@ -5870,6 +5871,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	priv->xstats.rx_dropped += rx_dropped;
 	priv->xstats.rx_errors += rx_errors;
 
+	/* If stmmac_rx_refill() failed, keep trying until it doesn't. */
+	if (unlikely(stmmac_rx_dirty(priv, queue) > 0))
+		return budget;
+
 	return count;
 }
 
-- 
2.52.0


