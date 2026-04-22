Return-Path: <stable+bounces-240270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP2QM4xS6GnlJAIAu9opvQ
	(envelope-from <stable+bounces-240270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 06:46:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77223441FF8
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 06:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C8583038164
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 04:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186E82E62B3;
	Wed, 22 Apr 2026 04:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/nlBYtl"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57BE2882D6
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 04:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776833113; cv=none; b=q32mVLgaKO6iOahEXYsjSPXpsF/zc2YW6njNKhkmJD513I3JMhgixLeEA7GWlttERA3iAtN6AlRAPwS5XpEwYBXfrJxLGbNOpVc7ottfGOwk/jsr95Xsug6J++CA5Jmvci97ZLLwiYHGVSUdQ0qcQ4NISIh/ZbbBrm4UGKxAgWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776833113; c=relaxed/simple;
	bh=PLlkGExxQGslAPKGedjPrwQDdD7n18K+euuIhDieg3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RBOGjBZf+hg3oT4pjyEEezvV0i5KAZ2oNrhg2U8HYKxdtj+tFCo782stD9n1Oq0jYdJtuMo8uWgdI/PrasjZkkexXSfGR/EdEC7nLHf66ZqS5uedaaHdGL4QLCZbH4A/g5CB1XG13iRI/a7tohYcc/Mfr/tHW9Ow12nfYsksmAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/nlBYtl; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40ee9b945d5so3963158fac.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 21:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776833110; x=1777437910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Cj4omnP69kMXkBuQqesz50Z/3zgQMt+xBhIxIth3BY=;
        b=g/nlBYtl7u5pOAXhxEUw3kv9eOjSmWu4Qyd8tVOWpULWuLaqpOVAvcexaBbvq9bG0B
         LUcROjFXIW63/VyXKCwmbT0HNLTMh2m49qojWIMhqUpq/VmlJheZFFuiFj0uaGuzfjgh
         VIckDPmPUDvawKDj4QaB1PgdClJmWeV+nt7ZFfDFlIE+mbc2L/pjVmVrJQQg4GLfejrP
         LG2SMldfaaOM/IMYWf7Z3EaQNGhBfnB4UuYqL6w5Lz/ayMvn8Mj2Pk3Tqp8aRVDBARR1
         BUkPKZJQHAaroEennkwKeTROdU9cJst4/m/5o6xjhKR2LYoM3p5eFkaDgwLE2zIid/0C
         AW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776833110; x=1777437910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Cj4omnP69kMXkBuQqesz50Z/3zgQMt+xBhIxIth3BY=;
        b=h3fmg4UWRi/6thMfz63hyq+6jcIptB2BeyHhWNJgyIPrFAftADDQsN5/Vz+lUg3dxD
         yBpN/3N0y1QaeZoCh33r4+hL1uZpBXCITAldtGDn85awmn7b9xDCmUhXHDVjfR2PItLm
         KYCYLOApjGWkRhMPtIGXOiZWEewF10qRTka08C5MUJwe/9Ce331feBfAzAtM8rjeES7l
         9ygMTJcbaqzPJRE1gxPmXV3V1WPaDpndiDYJw9MR59j0jxykDqPCKVHziMonrh1+Zr0K
         g+kkx5W/VIjcwE0r+eWj8hoLnH8+/S3/bCZu2IMBr+H9fwpG1qSz5pSETkYDzxFmzrU2
         XA8g==
X-Forwarded-Encrypted: i=1; AFNElJ+gdCZgggbCssgqkHchsntrM6wvke9MPkKjB+clUOBa4ltyXvW9iKLm5n1vDLuoqVkhWo6Lnd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYITuxLv9hio8c0UIoqAwokJ1J+ldn4APtZDr/COvnv3aJOrHG
	rflnea46YpAYeyuT/KpvDxt4d4NZ8hGh622Uo9JuHo+WOe7U2XMxGWQG
X-Gm-Gg: AeBDiesRqrcrKJeeZdk2PqCV3j/ZLMgfD/3JUz99j5X1S7Uh9J8YvVziREEKcc9+H4X
	0vsqNPENSZHi9cz5N+xtMSYpumJmlA5Xa6rE0ib1CdB7zW8gKvADqrxwer/qSCTe2zlt5PnEaMA
	pzH5f95L1VPhUacaLCe12wHR3/yMaSDU3r7YbMB8Bf4UbkwqIwqiqgUVI+9nYxdzOD3Ip6LdLYG
	WPsazhhaIPjB/2R9JXhk6zfbWsgd4LSQX3wn7Zy7dF7cJp9JygKfufrAjuTNr7MC2w1KRKuSmNO
	lHeRP6T8MrPNQvcGaqOmt1K98PTzU/08bTp1Rf7Nl3Hhcqdjo30H5oCJFij25QI2pIxYe/3pMv1
	V5DRX1BiHziV7dFjNLYmesXRfoQYoG6Bt7GChlh2GTjRaRh6IE5lYjmcoayY4H37VJeceO8pgoL
	LNIw84GLZjBmGTEOLRrMwax4foIO600Drxtafbc8I7WfJ6eIyCEiZLpxBwomrHXchKAkdiow==
X-Received: by 2002:a05:6870:82a4:b0:41c:3db:58d8 with SMTP id 586e51a60fabf-42aded57eccmr12187382fac.29.1776833110389;
        Tue, 21 Apr 2026 21:45:10 -0700 (PDT)
Received: from localhost (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-42fb269f69bsm2841483fac.12.2026.04.21.21.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 21:45:09 -0700 (PDT)
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
	stable@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net v6] net: stmmac: Prevent NULL deref when RX memory exhausted
Date: Tue, 21 Apr 2026 21:45:03 -0700
Message-ID: <20260422044503.5349-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
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
	TAGGED_FROM(0.00)[bounces-240270-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev,kernel];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 77223441FF8
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

Fix this by explicitly checking, before advancing `cur_rx`, if the next
entry is dirty; exit the loop if so. This prevents processing of the
final, used descriptor until stmmac_rx_refill() succeeds, but
fully prevents the `cur_rx == dirty_rx` ambiguity as the previous bugfix
intended: so remove the clamp as well. Since stmmac_rx_zc() is a
copy-paste-and-tweak of stmmac_rx() and the code structure is identical,
any fix to stmmac_rx() will also need a corresponding fix for
stmmac_rx_zc(). Therefore, apply the same check there.

In stmmac_rx() (not stmmac_rx_zc()), a related bug remains: after the
MAC sets OWN=0 on the final descriptor, it will be unable to send any
further DMA-complete IRQs until it's given more `empty` descriptors.
Currently, the driver simply *hopes* that the next stmmac_rx_refill()
succeeds, risking an indefinite stall of the receive process if not. But
this is not a regression, so it can be addressed in a future change.

Fixes: b6cb4541853c7 ("net: stmmac: avoid rx queue overrun")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221010
Cc: stable@vger.kernel.org
Suggested-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---

This is v6 of [1], which was itself split out of [2]. This patch prevents a
NULL dereference in the stmmac receive path, and (at Russell's suggestion) in
the zero-copy path as well.

The approach is different from the previous version and checks the dirty_rx
index in the loop proper, copied directly from Russell's suggestion [3]. Parts
of the commit message also use his phrasing. For these reasons he is credited
with `Suggested-by`.

The commit message now acknowledges the pipeline stall that can occur in case
of failure of the next stmmac_rx_refill() after the MAC consumes the final
descriptor. I still intend to fix that bug when I can find the time to finish
investigating and implement the timer as requested by Jakub, however I'm
sending this patch now to resolve the outright _panic_ and simplify review.
The stmmac_rx_zc() path is not affected by this stall.

[1] https://lore.kernel.org/netdev/20260415023947.7627-1-CFSworks@gmail.com/
[2] https://lore.kernel.org/netdev/20260401041929.12392-1-CFSworks@gmail.com/
[3] https://lore.kernel.org/netdev/ad-LAB08-_rpmMzK@shell.armlinux.org.uk/

---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ca68248dbc78..3591755ea30b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5549,9 +5549,12 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 			break;
 
 		/* Prefetch the next RX descriptor */
-		rx_q->cur_rx = STMMAC_NEXT_ENTRY(rx_q->cur_rx,
-						priv->dma_conf.dma_rx_size);
-		next_entry = rx_q->cur_rx;
+		next_entry = STMMAC_NEXT_ENTRY(rx_q->cur_rx,
+					       priv->dma_conf.dma_rx_size);
+		if (unlikely(next_entry == rx_q->dirty_rx))
+			break;
+
+		rx_q->cur_rx = next_entry;
 
 		np = stmmac_get_rx_desc(priv, rx_q, next_entry);
 
@@ -5686,7 +5689,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
 	bufsz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
-	limit = min(priv->dma_conf.dma_rx_size - 1, (unsigned int)limit);
 
 	if (netif_msg_rx_status(priv)) {
 		void *rx_head = stmmac_get_rx_desc(priv, rx_q, 0);
@@ -5733,9 +5735,12 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		if (unlikely(status & dma_own))
 			break;
 
-		rx_q->cur_rx = STMMAC_NEXT_ENTRY(rx_q->cur_rx,
-						priv->dma_conf.dma_rx_size);
-		next_entry = rx_q->cur_rx;
+		next_entry = STMMAC_NEXT_ENTRY(rx_q->cur_rx,
+					       priv->dma_conf.dma_rx_size);
+		if (unlikely(next_entry == rx_q->dirty_rx))
+			break;
+
+		rx_q->cur_rx = next_entry;
 
 		np = stmmac_get_rx_desc(priv, rx_q, next_entry);
 
-- 
2.52.0


