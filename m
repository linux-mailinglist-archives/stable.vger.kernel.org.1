Return-Path: <stable+bounces-227369-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKo3JX5DvGmAwAIAu9opvQ
	(envelope-from <stable+bounces-227369-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 19:42:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B362D12D8
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 19:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B63E31193C7
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 18:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0361830E0D5;
	Thu, 19 Mar 2026 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAe82fXB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EFB3C141B
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945671; cv=none; b=mCSPvebu0Tsy36fZvWkKSm/hOFNpFsThtuYGMgjBubmmeSe3WniKQAufNSeUM2EK7rcsiX5ESh01xoPJ/4E9M5q1oR37Xw/gizZ2+/ridY+ikmO9ZKC1SuAPHgXbnfuZtgzDE96UU4tE1GCmVOjRFuopAXrlzUBnp5fkdZw32Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945671; c=relaxed/simple;
	bh=Un+tjKghOnSOGQJqIv2n+A/mJ2xTSQ27PpNpWvuI/2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oB3GnZeGKaEq+uzvQxSqVvUH/EGPtKbrejkMZfyqkiki9Er76jt6HSeTPKTv//G9kBONLjAB53aagT84YJRQSjlwg/9nB1H7/kdPwdXyJfiBlrO9Bk2YeuGI3ClAEN5OPl1hjNyR2SXmqQwdfK2UaZKazwXaB1ilIgxsXRBR8M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAe82fXB; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d7e94e0db7so167858a34.1
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 11:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773945667; x=1774550467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLw+KspfNI17fHokU2DyOGE90apcIrKC40CCDarAeuo=;
        b=GAe82fXBPp4IO7bTdInpZQ/m8FT6DtbVlsAwaUjc/xxt2ctFYH1ghLshR5/ke+gqKY
         FNyJqkHOLBJDK/v6OfAY4MPSWt7uN92PVvGpcP6IzNQyE6RrpkRT83TGhQJtols6HkE6
         F1x7ipXgh/xQzPeDfbJAL02rQwyydLlgqz4OxAb/U/5EkiodRaoq4m3YqbxaS16czCYy
         assYte3AXuBPvyFJF6nXJi62RlnZgG+gsnIJTA41K/+g4TYMtOS9Psmj9Om2dlH9cSjl
         XOqTw+7BLa10T1d+knLtMHG4/XGvzwZrs/2fOhNL5099L/fLo2VOaPHImuU4pJOrHEJ8
         iqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773945667; x=1774550467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FLw+KspfNI17fHokU2DyOGE90apcIrKC40CCDarAeuo=;
        b=QVVcuPr8CPc+5gHIaaPWJdf7/AY7qQ6KGOrL4rBhXXdP8YU93Lix90wtELhFr7p4Cd
         LNEtS5mya2ZE1cdA5RnYEQj94AAk7OIv2YFMpszrhM9B+gPJbMVYNb/mVXNrCnApH9nO
         G6356sdwNHhDDqgmN0SAYoLHGRfQ5WJywRtit9C9WTyU0uOF2Y9cyR+Qd0+fz4ggjs1f
         UFP7axeDlT4MQgMIlQ3EZaBYtds/Lo/NPqGppUxAWKTZ4v3MtiYH07lonKyWiVNmYAKn
         sm2BdKkqvJ1yIm5n4orBtKVexCiySnYbeg0oVNbT+SJuFPaB58JBUtVXLbY6I3ZdFyLy
         59Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVBwXJNLCcXs0pRfQDnj1O+lve/BrptVXR3WGp+7Bfpy4LzKuxvSXUPaF521+8eGC++DMOWVIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqmDDMwC70+44D6Z2wAs1bUdC6HV6kcB/3zqaAD4BxDRqhdzkN
	nix9hH0X8Lq9FSo/qWI0jkVEqG1KtuC4AuV5XOJaLXsQLQGHoqp8/fon
X-Gm-Gg: ATEYQzytHWZImnUg3e0OI521qparpe45kdEWDAlxLJe0fQaVnjF1HLDHhaE+ccamQ8w
	73s2ekzCNoW2/vbhFvLojPisOtI8Vl/09MC49qx7c1Vv/8oNpjKZU3YTdpg7IC5dXqV7oVFknfJ
	kLN/ftCZ5Hna3EvcmMDhwz4Yrvk8f+WpWh+dH2QvbDMOnH7Ff8PdlQAc5FA/XV7y/O6GILJOhyF
	6VYYtE/0TLSsQLWauFOgZOtXlvhlIBlK4tvDbTsiybvA2BT9iOBGGBF79ooI5Abj9NaOg4MfEVt
	UxZjuZ0Pt5Q4PLWR3AzOO++3r4wMvdiHqbDPNZIsQCMWDXPWOBa4j56L4Y4nzTxHa+d97Xd9iNX
	gKCrLysO9wI8RJZfYcz4a4s02X+wMW/VybEpC6yCATCuMOIyFWpV1u/ag3UjVKiU4383dqs88SG
	j6IKU1yCZYtNA8AVVbF+LXFGz68tmAy80UZ2CsfvMHe7iKjx/MIOniJKBaff7I8f/zz3MAORgGE
	BYwD0NFa28=
X-Received: by 2002:a05:6830:651c:b0:7d7:d0d5:5bf6 with SMTP id 46e09a7af769-7d7eaf4f4femr168906a34.21.1773945667481;
        Thu, 19 Mar 2026 11:41:07 -0700 (PDT)
Received: from celestia.turtle.lan (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadcb757sm181486a34.15.2026.03.19.11.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:41:06 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
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
Subject: [PATCH net v2 1/2] net: stmmac: Prevent NULL deref when RX memory exhausted
Date: Thu, 19 Mar 2026 11:40:30 -0700
Message-ID: <20260319184031.8596-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260319184031.8596-1-CFSworks@gmail.com>
References: <20260319184031.8596-1-CFSworks@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,gmail.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-227369-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev,kernel];
	NEURAL_HAM(-0.00)[-0.687];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06B362D12D8
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


