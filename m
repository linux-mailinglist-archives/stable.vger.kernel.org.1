Return-Path: <stable+bounces-245027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFBQOsSUAGpvKgEAu9opvQ
	(envelope-from <stable+bounces-245027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 16:23:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9159D504953
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 16:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3942A300CC02
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 14:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A291391501;
	Sun, 10 May 2026 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxiZrmve"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C337F19CD03
	for <stable@vger.kernel.org>; Sun, 10 May 2026 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778422971; cv=none; b=tQaROnfZfcOvGUp8NO7j81CwYGPM4LM0enLGvAzVqAwS1MW9AHpQh6IOXfYQcxQvH77i3SLO36YZVZCr3Un9W3Ynv0020pWNfN/2qTT8BdQeSZeyOMheJutmu8drnxtMmM7z1liRAYSzGgnTEMUD/a4Cm51JcSwtdlqKrVeSNu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778422971; c=relaxed/simple;
	bh=wOhyo6nNSH8NRLfLdSy20DPMtQBLl8rPZOLiDzeM1Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vyu9GnrWTPYJE8wADG8rBNxLtPfDAtn7KIhj+QsI+SosWj7j+6trU09j8RFgbS9h3QNMAtFA3EJm2UYgL2h2sW5cXFpj66cq9hOQ/PU+g3SKrBt3h8pmOmFx3CoZOVfgGLTuZVWbh8ZCZlqJ7DL4bDIdBfAUTVT874Im0Sx/duk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxiZrmve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9570C2BCF6;
	Sun, 10 May 2026 14:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778422971;
	bh=wOhyo6nNSH8NRLfLdSy20DPMtQBLl8rPZOLiDzeM1Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BxiZrmve2Zd8eRHbOpA3jBKAXVGO4RKX9X8AF81J53TBLnA8Q+rf2E0cMDtTuuy78
	 f6KiJTORFCUpiTEI7JKFh21v7X/h1jI7mAje97Im7bdunaw65z+jTS8sa34qVrgfeC
	 5pe1L+cVlL9jW9GaAYZ344IYi90Ru874bwMXph3ssDW3Uru0CCbpuxoFV58rRb1hlN
	 pAu2KKlLNwQmHknxXCJdpsTP0tFqu/ocnP8tAny6mszEWUcbiXHGjFcj8Ukc4LtP21
	 Z4vinglXbEABkMeBJTnay9BLKPDp0NmGgRAx+09gSoZatEoLB4NUWPj/cjcrbTxv6a
	 V86mzzPlCoThg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sam Edwards <cfsworks@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Sam Edwards <CFSworks@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] net: stmmac: Prevent NULL deref when RX memory exhausted
Date: Sun, 10 May 2026 10:22:47 -0400
Message-ID: <20260510142247.4179438-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260510142247.4179438-1-sashal@kernel.org>
References: <2026050448-gawk-hybrid-73b9@gregkh>
 <20260510142247.4179438-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9159D504953
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245027-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,armlinux.org.uk:email]
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
index 1fd3977ec01ab..893746b2a4961 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5270,9 +5270,12 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5410,7 +5413,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
 	bufsz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
-	limit = min(priv->dma_conf.dma_rx_size - 1, (unsigned int)limit);
 
 	if (netif_msg_rx_status(priv)) {
 		void *rx_head;
@@ -5466,9 +5468,12 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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


