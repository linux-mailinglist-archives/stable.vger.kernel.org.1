Return-Path: <stable+bounces-232686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN72AeGczGkDUgYAu9opvQ
	(envelope-from <stable+bounces-232686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 06:19:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8563749CA
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 06:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E26C302F18D
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 04:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293BE36B07B;
	Wed,  1 Apr 2026 04:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVrHqiAx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0C33793AC
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 04:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775017182; cv=none; b=Iv9cGysYX/dVX5andnIWP5xOwbcg+t7YzVRNw1qf/JVZ+GHKpsrXDedso8GpezFoe7IeVkAVEfACLJwodrY9Xs4P6i1KjFiYoUzVHlYV98yxXDxVPUcRN8CdjKZAeTj6kk+WvqomKLTX3G1RwBvf6hzBuloJnUcRjr8/m9dJWU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775017182; c=relaxed/simple;
	bh=bQF1B63XcSzzW4Me2ZXYMgmme68wMnnLs+ouzSS6L0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dogx83Aj/3N8O6TSp+my2j5DIp+iMrQRxmj8gD3B+9cMuqmV0MI1qdmE0DKBB/nkmWJ31xDRYUntf3AlG7HrbN7gybQBNKAB0OgoUc3hJt685Ttc1ChI/97J5NXUB+weIs7bqbVLc7KaG3GmH+1DurJYM3NwQRi3NX/30dOIsEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVrHqiAx; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d74aa6bcdbso3587509a34.2
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 21:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775017180; x=1775621980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSD4qx/2JYM1VePcNlk14SPwVbO4qzamhYtHorOqJMs=;
        b=OVrHqiAxAkZKmdHA96j+FdaxWtp1x7oZ6BKNQTpBAyEKTYS137yxFTALfghB+kxEAH
         H+eeLuIatOurk2VcLSV++NiX29yc9wgXnyGUb/VH9w9MKn0D+MgcS9AvA1ns1o0yKKQH
         PP8ItPWMtnQpKJ+eMZhPorqzmgtEP7R9OVsR+ud7KlG+DvUNgSyt6UbzeAqRGA+CYwdf
         tRjskykQ5A8j/Q+SJHKiuCww9oc02alh7scPaAwZuJKJ48lerOkmMmvwFYxfkiVjOFg+
         67TQLAQ2w73XvGxThfc4s1JKSKhZkWed/n0JHi04G3YVLmeiY8Ckn/x/dRu3hjbuHz49
         vX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775017180; x=1775621980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DSD4qx/2JYM1VePcNlk14SPwVbO4qzamhYtHorOqJMs=;
        b=Dwu96yU+7rMl9Q1/ZFMN9LcjoggW+OsLpmZuv77sadALO/69WLeQrbm+PSzuiULSOh
         iBDcCZxfC4G2UG0zdaKu9wctknI7PuChQFjURdTa+c90RAO/Ry4cmCnwDGPAP+SgL06o
         dujtRhFGAyf5hkf0TAoyvGCePkyLHJtBwMv7hfCe+0KQeuSHFy8v8vNCHW2DFUSWuObk
         AZNUE25h0dwjQuQKA1xoghJy9VZfuvzuCLbZQJEHxU/fFwqBHEh0YgMVWIlcm1ipB19P
         TUuYb5jOPk2VYmE+sPVeOJ2dO4bYS12tk0DrNk/KGxOKBZkpYwOuULwtqE8p/kj+RsTk
         KyEg==
X-Forwarded-Encrypted: i=1; AJvYcCVx2P+wrXmorYx4Ire5212hrBLGr8JbTrg7UWhg5+FrkSIczYIeo0lu+KzaAitbmpfRQP3SZq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Yt4W3kwKAQJkv/Ho3XSjKSzqWlDquOz3Rm2mnQ+1+ltF/cyb
	uBZaTpidgSUyvKuC3lHkK6zmYG+H1HJbb6Y6dghMKBUt9pTC6d93LxMj
X-Gm-Gg: ATEYQzwmiaQs356vAls86gdYdqHlTjuTWFJXrh0hXZfY7LGi0Nvp/apP9mYiUhYILzV
	eUqrqwpjeAinURtqqxRUo6YeFZAwUbXIJ9tFx2kXdrj8tRa/PzfxwhBhil5Zg0Bbmu1O7+4B3wC
	B1g8j7wSGhdGusyG8EpJ/etyO4HLIwDURiypZ8SzoXWVcjCWBW424/7SQQMXKDR/jfWP65I+NJB
	jj+w9o5vtLLu4RZQSH+NTP24E9ysoNd+2XI9XkhCmjcXIu5fgXsZym/XnPnipbB0Xo8condrgQB
	FKvDfPVzXfdPWOav0lyeTj2mRmw4VonUCxw4zwQl7H6k0ji+G+2e8kNXH/xuSuQcuj35krY5aYy
	AhpgLsBGbnX7wm/ZxhkW3BF8eqQfp8EJdhOI2a5zoO3A6XZkmRJY1kXapWH4sLnOT64EfEUOIyw
	VmdiwP6Zep/qUod4oMXeCq/B8q7gABcZ83qXBiPM99oghj8SPqRvW5l9FO5E4=
X-Received: by 2002:a05:6830:452a:b0:7d7:db95:eee9 with SMTP id 46e09a7af769-7db994cf1b0mr1337728a34.30.1775017180356;
        Tue, 31 Mar 2026 21:19:40 -0700 (PDT)
Received: from localhost (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7da0a384631sm9647188a34.7.2026.03.31.21.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 21:19:39 -0700 (PDT)
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
Subject: [PATCH net v4 1/2] net: stmmac: Prevent NULL deref when RX memory exhausted
Date: Tue, 31 Mar 2026 21:19:28 -0700
Message-ID: <20260401041929.12392-2-CFSworks@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232686-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F8563749CA
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
index 13d3cac056be..fc11f75f7dc0 100644
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


