Return-Path: <stable+bounces-230809-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFqkN2IoyGnEhQUAu9opvQ
	(envelope-from <stable+bounces-230809-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 20:13:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4268934FBC5
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 20:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D22A93042091
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 19:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E44E341050;
	Sat, 28 Mar 2026 19:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cs3pZk8P"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD220345CA1
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774725181; cv=none; b=ohGB76KQfnf4IBb/Tf10eE22ajyY0K4CDerfiEdY6zW/n/jqa+rFScUQCDt5nnClH3/gYgjCpJa/ku5bV2MbX4/ddBahb03S0BWRorPIT6tSFK8w4qPTzBBYZgh/an45pWnKc9/7FAhLkz5KeSHMnC1B19k7/r0Z8ljYhu4ONgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774725181; c=relaxed/simple;
	bh=Un+tjKghOnSOGQJqIv2n+A/mJ2xTSQ27PpNpWvuI/2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6bsq4YP5DMCwV0j/bltf8W4y5WLQp5eYp+bD7GXjnG7H3mWGxLRZ21B7NmLKeoG0NavZdX7Yu1miAoGmk00kY+0/u6kl/j7eQAISZg6Tq5tK+ptTG1ISd2T7fx1DGh1/yrj7Vh/LKR2Ok0lDzlInbCoBGZHiXhLDp5mK2Kc1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cs3pZk8P; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c18af885c0so2539817eec.0
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 12:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774725179; x=1775329979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLw+KspfNI17fHokU2DyOGE90apcIrKC40CCDarAeuo=;
        b=cs3pZk8P3fzlPj+zJ3uyS0v1ZtLqoutbwiz2kIZeG9rct5Bvz0f3vJ1z3dU4TJAEF4
         YfFUpS1gmOrcq43E2R2FtuUAZQC6xUKVKgLXMaEuuRRiYqTp19X+YNiI4nFWOfyeWvM3
         IOHaCmObeKhMovV70RDkX5psvDvYR2ez99NOY4tAg9epafGV0XUtE5I2yTqOPbfbWsN9
         gvPfsQ+Fb4plvPphyEY0+49C4C5F88CbVIYlAA9TU7Vgw/tXg98JCafxS8sBxiJCO1Cp
         YsjqITDi3I6xQcQvqrAW7kbHe9Km58ESRpkMMrE9X5qFM3sv6oezkKMKwOu5ORRflwFF
         p/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774725179; x=1775329979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FLw+KspfNI17fHokU2DyOGE90apcIrKC40CCDarAeuo=;
        b=UZjymmWgZQkIJGRyQxlPna6DDvwGkZB/tWxNZglZNZ+vHTbbWXmbBjlvu42FsKfJDL
         PSAghbp20tm3m1G5Ec4m0nodDQLQyQ1abNvckFJvpmqpF7MZVZ2NY4wVaX3LnwTLK8Vd
         irFQjw0q7JxwtsiP9E5BeWp7DpwajCSqf5joo6EShGHbT+motn+8W9yAlPSDDE+23NYF
         I9rI02Q/YYk89rndOXeD44rGg7uTiWRHqcpkBa8Xbk33V3wUGco9ZtpqnaikDBx3cb0M
         ffhRe4Ka0diMVaHq7WCn80LnABPlcPu19ySzWgEjh9iMmyQDI3vghacndu7jbzZeRsN+
         TKgw==
X-Forwarded-Encrypted: i=1; AJvYcCVzK7CPJIxUrc9YVpwM1zYCcuWjQ5+tmfNyL4G/3Ec4bDfn4dJESP4eb9uMKTgV7ZuSVp53JRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfyDHJ+Ditl/57h+YfXQZ8xuIPfsuxyLwNP6pheA+We3Kb+Q+S
	VICu7IvTqcn0SShyN4NJj8zsJvyiMAKRvtibYUy5YnH7GwjzCewO+f3JvWApEqut
X-Gm-Gg: ATEYQzzgZwjvwSrCvukY9AWTOwdLbHs4+6b1khXc0Aar5xBGjaPLsx2Ev1ErlV8U4fz
	46GI+kWjxnT1dFHm/b3mU1zo59nd9uVZ6SpCPR6vlWLqbguhUEBAgZ4ToYIRvIIQcbM2RaVgHJ9
	ozKaKjxRObyDLDLcrFSN3RTs/iG79qyiLb6D/4bQRHvEp3gvgXOb0NEZpvkyJpFj41jg1FM3YNF
	D61QcbCA5jtbVvU4hL9B8uZ01JgVKf4k+isjc4NLgZW3lbzzfrKL/ZbJEWztAN1Y2/GL5oHGpPt
	uxcN69PYrDZv5M3ECU+4XQTkq55/6tYsjFSVI/vGVod7h8uErvX5EHLtqyFSXscYJ9qWFAW8WfE
	D6MOE+rUrI9wuCk4PmWVZU6LSETVlIEcJ3gu2wZ8Gwa1FlYM4PbQAjvcJWAal6bSufyGnxY8VoJ
	CKUv17BMvG01rg67fK2xzizwFyIicQA2Z52COxNOCXyVXw8XjBg3XL/fSC
X-Received: by 2002:a05:7300:7fa4:b0:2c1:67e1:61c4 with SMTP id 5a478bee46e88-2c185ce8740mr4319411eec.5.1774725178830;
        Sat, 28 Mar 2026 12:12:58 -0700 (PDT)
Received: from localhost (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2c3c68b2721sm2508384eec.14.2026.03.28.12.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 12:12:58 -0700 (PDT)
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
Subject: [PATCH v3 1/2] net: stmmac: Prevent NULL deref when RX memory exhausted
Date: Sat, 28 Mar 2026 12:12:32 -0700
Message-ID: <20260328191233.519950-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260328191233.519950-1-CFSworks@gmail.com>
References: <20260328191233.519950-1-CFSworks@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-230809-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4268934FBC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The CPU receives frames from the MAC through conventional DMA: the CPU
allocates buffers for the MAC, then the MAC fills them and returns
ownership to the CPU. For each hardware RX queue, the CPU and MAC
coordinate through a shared ring array of DMA descriptors: one
descriptor per DMA buffer. Each descriptor includes the buffer's
physical address and a status flag ("OWN") indicating which side owns
the buffer: OWN=0 for CPU, OWN=1 for MAC. The CPU is only allowed to set
the flag and the MAC is only allowed to clear it, and both must move
through the ring in sequence: thus the ring is used for both
"submissions" and "completions."

In the stmmac driver, stmmac_rx() bookmarks its position in the ring
with the `cur_rx` index. The main receive loop in that function checks
for rx_descs[cur_rx].own=0, gives the corresponding buffer to the
network stack (NULLing the pointer), and increments `cur_rx` modulo the
ring size. After the loop exits, stmmac_rx_refill(), which bookmarks its
position with `dirty_rx`, allocates fresh buffers and rearms the
descriptors (setting OWN=1). If it fails any allocation, it simply stops
early (leaving OWN=0) and will retry where it left off when next called.

This means descriptors have a three-stage lifecycle (terms my own):
- `empty` (OWN=1, buffer valid)
- `full` (OWN=0, buffer valid and populated)
- `dirty` (OWN=0, buffer NULL)

But because stmmac_rx() only checks OWN, it confuses `full`/`dirty`. In
the past (see 'Fixes:'), there was a bug where the loop could cycle
`cur_rx` all the way back to the first descriptor it dirtied, resulting
in a NULL dereference when mistaken for `full`. The aforementioned
commit resolved that *specific* failure by capping the loop's iteration
limit at `dma_rx_size - 1`, but this is only a partial fix: if the
previous stmmac_rx_refill() didn't complete, then there are leftover
`dirty` descriptors that the loop might encounter without needing to
cycle fully around. The current code therefore panics (see 'Closes:')
when stmmac_rx_refill() is memory-starved long enough for `cur_rx` to
catch up to `dirty_rx`.

Fix this by further tightening the clamp from `dma_rx_size - 1` to
`dma_rx_size - stmmac_rx_dirty() - 1`, subtracting any remnant dirty
entries and limiting the loop so that `cur_rx` cannot catch back up to
`dirty_rx`. This carries no risk of arithmetic underflow: since the
maximum possible return value of stmmac_rx_dirty() is `dma_rx_size - 1`,
the worst the clamp can do is prevent the loop from running at all.

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


