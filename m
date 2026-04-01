Return-Path: <stable+bounces-232687-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNiMHsSdzGkDUgYAu9opvQ
	(envelope-from <stable+bounces-232687-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 06:23:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C43C374A35
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 06:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64884308C5E9
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 04:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C693793AC;
	Wed,  1 Apr 2026 04:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgLk86pz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7D736B07B
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 04:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775017187; cv=none; b=WveCJJn2mlwkJ0Ia2vou55jx3iKatKhQpiGTSw+clmgMI5lSlnAY1W76YmSFCm3HsMTlL/nYIQUtZQhbJ5r3OEFMBznuTFonPXcKiDdFy9kTrOU+gca/cbRyEFojFiXB9UDSv9cRqhme8ss9KbHybj69XtdgSvtV8RQG4VnRJ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775017187; c=relaxed/simple;
	bh=GAdIAHgb5u8TBTPtWedEhpVmApFhU9W97TdtUCLjE8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5ba6BOPlGnFTv+TqnZVo8cBs4G1P7kL+UR8lFoELChUEq5H/04WKxvediY/SQ0whnMhLvWbJeTJIZ2NEEjj8a5OTHSqPznGISFCqHNAJq7BK6KHCWyu3lT8LhUc8TgN77iIph8v4TMYNw5TZzCEfaC16abTNRAAROVPHPF1I6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgLk86pz; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d4be94eeacso6096163a34.2
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 21:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775017185; x=1775621985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8Gs/LCy7pdaKThZ7lAOXGPZaybDiCKVdDXO7zMbjMs=;
        b=jgLk86pzUrhwLsvuIoofPtJtdzC9jkp4q2yu3+b+aD6v9CY80WufZD792fupnei2r7
         tqjNCBl5Ulp5cxpPneOUj1FYB3oOaItKxVBatGJsc6lInjVkADEvab5R85HjQAi81png
         WrMdFJb4FwdlxcaAoKGG7bJkcCCJKkJQGc/HaaiCC7UKViaaKSP3kXzTzXLnrZDOH7S7
         zDMMNPo486tkY9NrGNmCCiee1Yrp/CPxo9KtA99sV3Q8SdR3tA2TYIJBYkcQrvIn3pPh
         1JymKGhRzo6IZtdJxLtziS/2RD15DKuMmR+0T6NMWNY6p5DzV0ry4wGS4FLqM8sPl0P2
         J5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775017185; x=1775621985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p8Gs/LCy7pdaKThZ7lAOXGPZaybDiCKVdDXO7zMbjMs=;
        b=h2mBjsMbPb809mrzlL1kJLvsdHP2jxrJbff+eYFcmIebo/MQq3LFk/ta2jNDzclBjJ
         9yyPhPImInGP+WTHmYYsCy2dbOY6Dueqi710lCe2ZKBJATFFo5Q1Yf+8dMQ65HCMhaXX
         ABll4tfsEaV/K0CXaJcalcWMSGpK/ikLiBmzgJmlDZK5zReUtKXrDpemoP8BOese8ldU
         oFL4pg4PTcqrJWbsBXNBbAoGC5pyVc++9TSkklULxjf2URUjeb1etQnnJtHSUxpgwEyh
         6AkYOOcOnNPD6WILtkii8ozp7UWEzOV/i9FHw6DfEXp2F7xgSNu6TZDuZIgVN8olJ44h
         SHJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/3yvxOZzwkVgFVOVJFFn2/qCXuykvz2rcOv5Lk/+SDztm1JL/8dgHt256QzsxJVSohFQK4H0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoAb1lFAM8l46qR8CEmM34vdGLmpqdYdBqTNRZYIUvgunJuHui
	iFvbBIbAR7eLp4NmIF5RueiYiHqzDYqHKcIbdTVKPht/0oEJZseGDxos
X-Gm-Gg: ATEYQzz/tHGktQpiPeegyxT2RcN+iOP2vJ6retmUUtm87ihFGFxO/2N9aPFzms32BaS
	Vc/vOwVdo5I6lsXMzHe1ZDze3K/yUEdE0ci+5zLsUkWQFDaEx1owurt9WoGqJuv5Sb1u0yh0+BI
	arSvbGg/2wI6MNhD5qjbX62sraQU5XHUkd0hLIcvIlh6w99PFtexaSYC9b3fH0njVJ5rIfX9yW9
	tE66947yU95OHh1ZYvOF5/uqdn/BM6zxc5RLeaS/fkdV3lw5oI3WRCvw3IrVWW6EFKek2stRr+s
	gEUxPL0JDxa5nt0EopRMtQdkpewJUYDcgKi+enOYxDtQ60LKV4DydZDdiq5hQJMrgN7Svono2NO
	0GxDMNo8wFxJlpr6j0iS6X4GIT4Z1HbmhxQN1jzoZx4jX63M8A6BlNTEq6Y6RAdBNaXfHt2vZ39
	H7E7Ns7vKIWjk+k//GLyo9TUrdbT15slj7aGmRIgsRIoGMbEsAUN490z99mt4=
X-Received: by 2002:a05:6830:3709:b0:7c7:69c8:2d2 with SMTP id 46e09a7af769-7db9925b999mr1505891a34.13.1775017185265;
        Tue, 31 Mar 2026 21:19:45 -0700 (PDT)
Received: from localhost (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7da0a7b5b41sm9925868a34.15.2026.03.31.21.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 21:19:44 -0700 (PDT)
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
Subject: [PATCH net v4 2/2] net: stmmac: Prevent indefinite RX stall on buffer exhaustion
Date: Tue, 31 Mar 2026 21:19:29 -0700
Message-ID: <20260401041929.12392-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401041929.12392-1-CFSworks@gmail.com>
References: <20260401041929.12392-1-CFSworks@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232687-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C43C374A35
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

Also: even if not all descriptors are dirty, letting them accumulate
risks dropping frames in the next incoming traffic burst, if large
enough to exhaust the remaining valid ones.

Fix both of these problems by checking stmmac_rx_dirty() before return:
Use the same threshold as the zero-copy path (STMMAC_RX_FILL_BATCH) for
an unacceptably high number of neglected dirties, and tell NAPI to keep
polling (i.e. return budget) when that threshold is met.

Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers.")
Cc: stable@vger.kernel.org
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fc11f75f7dc0..6822ca27cb0f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5604,6 +5604,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	unsigned int desc_size;
 	struct sk_buff *skb = NULL;
 	struct stmmac_xdp_buff ctx;
+	int budget = limit;
 	int xdp_status = 0;
 	int bufsz;
 
@@ -5870,6 +5871,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	priv->xstats.rx_dropped += rx_dropped;
 	priv->xstats.rx_errors += rx_errors;
 
+	/* stmmac_rx_refill() may fail, leaving some dirty entries behind.
+	 * A few is OK, but if it gets out of hand, we risk dropping frames
+	 * in the next traffic burst; in the worst case (100% dirty) we won't
+	 * even receive any future "DMA completed" interrupts.
+	 */
+	if (unlikely(stmmac_rx_dirty(priv, queue) >= STMMAC_RX_FILL_BATCH))
+		return budget;
+
 	return count;
 }
 
-- 
2.52.0


