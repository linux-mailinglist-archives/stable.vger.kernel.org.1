Return-Path: <stable+bounces-245034-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAFnAuefAGp2LAEAu9opvQ
	(envelope-from <stable+bounces-245034-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 17:10:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1411504B57
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 17:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5909300AEC9
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 15:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F0539E6E4;
	Sun, 10 May 2026 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siP3qfDR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF5B345757
	for <stable@vger.kernel.org>; Sun, 10 May 2026 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778425823; cv=none; b=oR6uS6Sizgu1mJ8Yl43qEPcLWJQOiFQasVuTBO/3mV9UJxia28YY1qKyNKhIa62zHuCdGh+7XUqeDQXwKXbawJDv/p2rRIvXmMVs8yEQwGkjTo85o4naCleY3qvrvT4RhPlmfwRIuUatG7PzvtLbaGfUqd1HAk0AI6acIp95XuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778425823; c=relaxed/simple;
	bh=Usw4EMx4/6wk2PA1GUAfzFa8912BKBi7omFpNCRDFC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2lu9SsZarn0DmaQowFT20WezBZXRMqhmxtOoGts3rydPITBETJp6a3aUKIPSzcb308dxYZNv+13xDmMZBKGRaGzDzPqAniBwlop3qQiz7dzENPNSpMbQXPIOcoLi13xSDBDdEs7qO3tdL9XnF582/NFU8ae/Ma4qN5IVkW3Qqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siP3qfDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E29C2BCB8;
	Sun, 10 May 2026 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778425823;
	bh=Usw4EMx4/6wk2PA1GUAfzFa8912BKBi7omFpNCRDFC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=siP3qfDRNhsKCdMHFei38HfhrHjSWm3OhbBmk05RNK9fa/nbleMWAzIFNzVryrcyx
	 kfD8eK+qDwTQd5626RnECwKL981xxjyl16Iintjkda997iCw34tnbl0C5cy27jnjc5
	 3cJ8bEt0kvFjd1saCBkCdCun+RT6Ia6OgR3AzoIW1+W2iZ/+uBD4QksDvYBb/QCM2f
	 t3xg5io2B6vKdDP7FQM8u0p8++he4XHH6uvFP+XLJmG1qizirL+iDwp+xLYlG1CJ0D
	 X6ne4fZ23gysiWMqp7RTjfZKgXX2u0BbSs+ujEj1ZLRutKK8a2f0wyLOg+E+XeTD+6
	 UCEdHSOlVoTDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sam Edwards <cfsworks@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Sam Edwards <CFSworks@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] net: stmmac: Prevent NULL deref when RX memory exhausted
Date: Sun, 10 May 2026 11:10:19 -0400
Message-ID: <20260510151019.38468-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260510151019.38468-1-sashal@kernel.org>
References: <2026050449-dish-arming-999b@gregkh>
 <20260510151019.38468-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A1411504B57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245034-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Sam Edwards <cfsworks@gmail.com>

[ Upstream commit 0bb05e6adfa99a2ea1fee1125cc0953409f83ed8 ]

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
Link: https://patch.msgid.link/20260422044503.5349-1-CFSworks@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 855074227b0ba..dea3d66619ce3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5143,9 +5143,12 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
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
 
 		if (priv->extend_desc)
 			np = (struct dma_desc *)(rx_q->dma_erx + next_entry);
@@ -5283,7 +5286,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
 	bufsz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
-	limit = min(priv->dma_conf.dma_rx_size - 1, (unsigned int)limit);
 
 	if (netif_msg_rx_status(priv)) {
 		void *rx_head;
@@ -5339,9 +5341,12 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
 
 		if (priv->extend_desc)
 			np = (struct dma_desc *)(rx_q->dma_erx + next_entry);
-- 
2.53.0


