Return-Path: <stable+bounces-225495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HM4Brlmt2mQQwEAu9opvQ
	(envelope-from <stable+bounces-225495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 03:11:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D8B293D2F
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 03:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F943300BC61
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 02:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1427D30AAB3;
	Mon, 16 Mar 2026 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2H5CHbS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9218830BBB9
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627033; cv=none; b=IK2SMzhbRPo2cm3ZGhGwR/0GJyc07t47l6trLf/233LvJXM1hyxG1xf/SFpH6qmSxXU3EBv9YbOTvwqcL4dPgkvC6NgM4Jur0FbkjpNWEm+iBd+1hvKk4HMkSeXVdNErjCkZLp0b05tdeqdOm04dFDcMgXF2khIGvpAHfDmn/58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627033; c=relaxed/simple;
	bh=NA2WPiExcFM1F1Er32slS17NHJTG/FN7y2tKTlUTUQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S58EjUNpFjM+FgWUUxkCjOVd1c7v+Lspchdi3NpASNv8blaXvmn3XvwVe25YZrAQHudE8swvj2VfcnUHNHgX5llmHRnHlK1GE22tcCtRs/bgRMN8dcwTWs1BQtiNmsA0x+E4TNN0kb8RSCDKegzEaWiQxdG+iv+zK/7qDiOIhBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2H5CHbS; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35a04d6aeb0so2423980a91.0
        for <stable@vger.kernel.org>; Sun, 15 Mar 2026 19:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773627032; x=1774231832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWF2mf3kVPfppDp36uMCmkCxPdxULYmBpYhT7oMPfhU=;
        b=Z2H5CHbSvuUUU83B+YJHt2zwIY6rc1/234OnVbjP4bZmN++uY4F82faoDfiHw2BcX9
         AVdmjS+TlE53AJywca+pJvv7dXH1SDsN/IDr3LX3ax1SOEf/jgI6nmy17x0s512qiviG
         dcTAp2Cb32xQiPrq6A35/Me+BPZBOwIV4oRNfkpSPtV56+02IuJ7M7JpClv1IKs/yQWB
         8xwC+qP+CGbJjHvxmfrzIzzKYzecIp3DztuBxfubrxvlb8B4qgbx9KCHURhdnkSnQU1X
         LuUzWezNF2UN3U+nLUAyoB8E6ZH67IK1MPCh1Q8H0xPXSf8r+vf+DvYI+IiHDoYNlIAQ
         5pjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627032; x=1774231832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MWF2mf3kVPfppDp36uMCmkCxPdxULYmBpYhT7oMPfhU=;
        b=bayHVU/QW65EZZlN6faJC1OAI31vFDDMOT8Hp9BFXjmNsyJf0JNXzlqvcgJBOLdQOD
         g2S2CUjfA+tGJZbTdfno+AhiCPqmskvh18KHIKWmzUK04vZM2qqju64lafLM/ndcfMpx
         MuodvU9KBM+mvEMZ/f05pPjs+WELwXGt8/D+Yfcr+LktGbTyF8Bepdz6EHN5LrCdCh21
         tvOGyiCdXDMe5w+A49Jx7Jm2+J0o/uOswGtWvBOIXdO6O3XJmEsYJYuK6CUkxNXuXIuO
         ObqCBNwpqh2CGBZVnAzQu2Uyea86uov3YrCIs5xye+n6ejhjyRDpUOhiiHas1DhsvqRY
         k5oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwQ/6KtQGtx9B4wNWO4hHwfjK63bIBHDenLD80zkFXUTcvPIkHMhMExZgL9KTYg/Tl279ZgIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YygSnXdKAAgp6+euodjpL/ajc9MYlOa/ViqZ2VRENN2DCaafYLS
	Rn7nomEQ9NuX2q2Zz/jG+tcsf04Bk/k7r6DoVLGfJODPXd5Cour8K9/t
X-Gm-Gg: ATEYQzx+oWR+QOAaP8mepLszyyXA/ala/vfSjuYwEqG5amBtL7c8oxCdtF5Xoye7eg9
	dYhA5nyUeVeHMSTYYAAURc678sN9Sz3D0wCgqIhICcIfhxu3aTE7P6BsSWYl2DebHoVvg1utYAN
	3Y4oZvv6EfVFJ1HHH4MYfCtgpPDIA8yG94Lj1deOTnJIpYggaNAMamqs4jyuQJr6KbALv5JYK3+
	tT5A3hp97LVI/Oyw3u19QTDCBrTQeTV/5FPf539xMY1JNX5vk2bt9sGEpiOBiv2sX0n3ck+nrZT
	hcbWUcdrMvzM6SIoXkG+nVHF8pgfDZ8ETxytC7M9PiTBMqoxJ2ghjinoX2j9NGB590xA2WUQ5gJ
	C1wcg6yiFs0nYRaniZ27rTmCY4d+HBdtevMPKS/TE6NWiTmnSoizR6z7TQRiZKrf4cFfifO0aT8
	CAKHcvWiy1yZMSa0kUsLePmOi0VmkmUb2LbNmI2qMs55nqprySqMUHaklFGPgRswCd
X-Received: by 2002:a17:90b:3501:b0:359:fa1e:2bc3 with SMTP id 98e67ed59e1d1-35a21ea5dbfmr10103044a91.6.1773627031911;
        Sun, 15 Mar 2026 19:10:31 -0700 (PDT)
Received: from luna.turtle.lan (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02ffdfb7sm17705805a91.14.2026.03.15.19.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:10:31 -0700 (PDT)
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
Subject: [PATCH 2/3] net: stmmac: Prevent indefinite RX stall on buffer exhaustion
Date: Sun, 15 Mar 2026 19:10:08 -0700
Message-ID: <20260316021009.262358-3-CFSworks@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,gmail.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-225495-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15D8B293D2F
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

Fix this by checking if stmmac_rx_dirty() returns its maximal value,
returning the full budget (which tells NAPI to keep polling) if so.

Cc: stable@vger.kernel.org
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f98b070073c0..d18ee145f5ca 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5593,6 +5593,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
  */
 static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 {
+	int budget = limit;
 	u32 rx_errors = 0, rx_dropped = 0, rx_bytes = 0, rx_packets = 0;
 	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[queue];
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
@@ -5870,6 +5871,12 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	priv->xstats.rx_dropped += rx_dropped;
 	priv->xstats.rx_errors += rx_errors;
 
+	/* If the RX queue is completely dirty, we can't expect a future
+	 * interrupt; tell NAPI to keep polling.
+	 */
+	if (unlikely(stmmac_rx_dirty(priv, queue) == priv->dma_conf.dma_rx_size - 1))
+		return budget;
+
 	return count;
 }
 
-- 
2.52.0


