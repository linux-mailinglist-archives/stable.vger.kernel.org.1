Return-Path: <stable+bounces-232691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CCeEn+jzGmQUwYAu9opvQ
	(envelope-from <stable+bounces-232691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 06:47:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBBD374B5E
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 06:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38BC130193B7
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 04:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C338C245008;
	Wed,  1 Apr 2026 04:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV7iIagN"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8EC18050
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 04:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775018871; cv=none; b=ZY+GxGK/QvEm5DLxxPQvQuAd6OL0XHkdeMoJf+KnFydJ69wTD1pwoABpMmYGL3uddcGIQS/f/AzEqy2nGi68XMo6DqGmEIbsu41xfjSd6KcpYpu1QI4fsMiN8e6h3lThXrHBlsb30OtEq+dlvAUYcgtyWz5whktWFJlPLkRTgqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775018871; c=relaxed/simple;
	bh=PpxbFaO33bEnNjvzKyApo/Q9GShxwpa/nEGQ/v232KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYJf2TNx+dqgfxtZDZyR6iVBiTYD8QcHwU7j301TypB5CofOhrC+5runkqE0xYZNPPx+acDI0q9QurDf1kz0hBgTHo1BNx0xOmcNPXO0LBLKROx9EZPHku0S9Bk0GwpiHMRHpLy9AYyCmw1lCPToWKe9OpaALNFEuOA8fskBtP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kV7iIagN; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-41cd9267bbfso463473fac.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 21:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775018869; x=1775623669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caSr3lZmDOdG5gDgsxTCqvAp/bk5INHxsGesKdHh4yc=;
        b=kV7iIagN3OPwY8LqxeWEyUuTT3d3FY0XnkDkZYZ4907I/BDBFH8ZdQ9JYLeSAc0I9e
         sm+qs3VCOowkoM6xUeo4qXo433SexMDgmlqdbEWV6NFXf5R+RauF7Zfz4oax3Cz1jA2D
         HeesVXNxACkQvB31wBblVLzQxI6Jg99yGqu/bpcymlw6RcdK12aFDkpsY6KlSAxBHfEw
         omjk/K6wp2Dr/1VpR5TMJLTb2fFE5HvzCmvWZfq/efS2mFFHCCXtt/96p+8JOJTQul9f
         kciEv8BeiB7mflINxT8E7XPuBRUDHtUkDLjAPyUwtIqSprJz73lOl3765HIXVvxgWUMH
         bRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775018869; x=1775623669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=caSr3lZmDOdG5gDgsxTCqvAp/bk5INHxsGesKdHh4yc=;
        b=NGxubU9sxFFZ4cBiU6KVyMwsOIzuOqjGP/LV1k0oeAlf2+jJBXSYVLB0LEc1g1A9FH
         SwI7EfbQsmUFwAQs25hst0D2ytCIFcVSmzoU1m9A8n8WW7O7JAB8PEwDCQ/tXRGfkGX5
         eWTQxskqzPlptnxSGDnkB2DFFuhVWI50eoAsBeMOxlBcX80rCtVcDTDHxY7oedqpL0wX
         3coY2qePiTJCRfDWAl1zpjd6mGUH6QOzVKrJF++IK1y87u/e0DN83fSFVyKos+OKH9s8
         ESur4gzO/s5ze+EOgDOFU4QAofoRehIjdG1Zcj3sw3ADXPV0Kk5PoWUIe6Oxog9q6+c2
         xBqw==
X-Forwarded-Encrypted: i=1; AJvYcCX3vnmSSH+Zp+VxmMtSkTCXdEcalbU6ZooIB9fp9RecMbXEGdFyYIrQD+Mh7r6G6026qjhWWsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVKXA/7tegKIcpCObU/BviLarwB0e+jYKeNCxH+zgWdbPDbEQ9
	dvD1xaUAnaNmZxTyZ27v5O7B9NIubd7TxWBKmE2LZfxNv9pOHCt76tla
X-Gm-Gg: ATEYQzxQ0jTMLqYY9gV6jSEBvRImZiP8VDukz/+0mTJ1hdyFDr2iHJeW+nl1B3B4OSa
	isWmf1TtlsqVdKoghiuY9kucuNcUOGG42wJRCrQylvjvLJRKVWmM1Yk+l1xxjJ8mqL/Z5IxZoBf
	OzziPKQJNY+E2/Y9av4YpMHABURt6Zf9czk5H6jXxURpOGd4op+6VaaJJ9dBtjhsojg/NCpRa8m
	KZAY3VLGm3TPgJVXjSunZ2u+sm6Edn2pXPYrw/Ffn+9jFzOfqyt02e5XiVMhf4G2MVk1Ilr4FS8
	qDjzgWFBnc1GWW8IIfbXYs9Karm23dOtlLAqofgn2FIKDSX5TKVtyaxAT2CvrKe927bl7T8utYq
	0MPDOKwiv0D7/4k1bJFKvS4gtlYHaPZYVLPTl63Bg/joxr/cYP7IZ/+JD3UXcOFI8oDS1eUaBIL
	zWSKSoG3E1owqqaryNQl0gnWagWNUa/5O7GKILVyfuu9FtqgpBiygV9SE1uUpKP0A4jsGtq3P/Q
	lfP
X-Received: by 2002:a05:6870:3211:b0:41c:1d37:3825 with SMTP id 586e51a60fabf-422a5156c4bmr3477405fac.17.1775018869186;
        Tue, 31 Mar 2026 21:47:49 -0700 (PDT)
Received: from CS-396-Lab-Machine.. (c-24-12-10-127.hsd1.il.comcast.net. [24.12.10.127])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04d79c35sm8741721fac.18.2026.03.31.21.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 21:47:47 -0700 (PDT)
From: Tyllis Xu <livelycarpet87@gmail.com>
X-Google-Original-From: Tyllis Xu <LivelyCarpet87@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	peppe.cavallaro@st.com,
	rayagond@vayavyalabs.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	danisjiang@gmail.com,
	ychen@northwestern.edu,
	Tyllis Xu <LivelyCarpet87@gmail.com>
Subject: [PATCH net v2] net: stmmac: fix integer underflow in chain mode
Date: Tue, 31 Mar 2026 23:47:07 -0500
Message-ID: <20260401044708.1386919-1-LivelyCarpet87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <acQWs7sXUgWjGsCM@shell.armlinux.org.uk>
References: <acQWs7sXUgWjGsCM@shell.armlinux.org.uk>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,st.com,vayavyalabs.com,vger.kernel.org,gmail.com,northwestern.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-232691-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[livelycarpet87@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3DBBD374B5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The jumbo_frm() chain-mode implementation unconditionally computes

    len = nopaged_len - bmax;

where nopaged_len = skb_headlen(skb) (linear bytes only) and bmax is
BUF_SIZE_8KiB or BUF_SIZE_2KiB.  However, the caller stmmac_xmit()
decides to invoke jumbo_frm() based on skb->len (total length including
page fragments):

    is_jumbo = stmmac_is_jumbo_frm(priv, skb->len, enh_desc);

When a packet has a small linear portion (nopaged_len <= bmax) but a
large total length due to page fragments (skb->len > bmax), the
subtraction wraps as an unsigned integer, producing a huge len value
(~0xFFFFxxxx).  This causes the while (len != 0) loop to execute
hundreds of thousands of iterations, passing skb->data + bmax * i
pointers far beyond the skb buffer to dma_map_single().  On IOMMU-less
SoCs (the typical deployment for stmmac), this maps arbitrary kernel
memory to the DMA engine, constituting a kernel memory disclosure and
potential memory corruption from hardware.

Fix this by introducing a buf_len local variable clamped to
min(nopaged_len, bmax).  Computing len = nopaged_len - buf_len is then
always safe: it is zero when the linear portion fits within a single
descriptor, causing the while (len != 0) loop to be skipped naturally,
and the fragment loop in stmmac_xmit() handles page fragments afterward.

Fixes: 286a83721720 ("stmmac: add CHAINED descriptor mode support (V4)")
Cc: stable@vger.kernel.org
Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
---
v2: Instead of restructuring into an if/else block (v1), introduce a
    buf_len local variable clamped to min(nopaged_len, bmax) so the
    subtraction and the existing while loop remain structurally intact.
    Suggested by Russell King.

 drivers/net/ethernet/stmicro/stmmac/chain_mode.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
index 120a009c9992..37f9417c7c0e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
@@ -20,7 +20,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 	unsigned int nopaged_len = skb_headlen(skb);
 	struct stmmac_priv *priv = tx_q->priv_data;
 	unsigned int entry = tx_q->cur_tx;
-	unsigned int bmax, des2;
+	unsigned int bmax, buf_len, des2;
 	unsigned int i = 1, len;
 	struct dma_desc *desc;
 
@@ -31,17 +31,18 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 	else
 		bmax = BUF_SIZE_2KiB;
 
-	len = nopaged_len - bmax;
+	buf_len = min_t(unsigned int, nopaged_len, bmax);
+	len = nopaged_len - buf_len;
 
 	des2 = dma_map_single(priv->device, skb->data,
-			      bmax, DMA_TO_DEVICE);
+			      buf_len, DMA_TO_DEVICE);
 	desc->des2 = cpu_to_le32(des2);
 	if (dma_mapping_error(priv->device, des2))
 		return -1;
 	tx_q->tx_skbuff_dma[entry].buf = des2;
-	tx_q->tx_skbuff_dma[entry].len = bmax;
+	tx_q->tx_skbuff_dma[entry].len = buf_len;
 	/* do not close the descriptor and do not set own bit */
-	stmmac_prepare_tx_desc(priv, desc, 1, bmax, csum, STMMAC_CHAIN_MODE,
+	stmmac_prepare_tx_desc(priv, desc, 1, buf_len, csum, STMMAC_CHAIN_MODE,
 			0, false, skb->len);
 
 	while (len != 0) {
-- 
2.43.0


