Return-Path: <stable+bounces-228581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFoeDcRLwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:18:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3063B2F4260
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F284300BC42
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E861E5B88;
	Mon, 23 Mar 2026 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUJR4kaK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CE01A680B;
	Mon, 23 Mar 2026 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275508; cv=none; b=WiREeCYtbC1u1IK8jW8UcZc4zNiR0pvUovkr3WUGSSZVNkD2A11QZMSAYOc+u46b7M3ElaSJp3kp5mWoZH0P3U++4bVqA0yKNusE/TxMoIyl700SlnD2wpU0xIKAigIUqNhAayuZBiHX8B6WMNeL5Q4Thl7J3tksQ5XpSX8e3Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275508; c=relaxed/simple;
	bh=z54twYpyCZdACUNzqjxk1EsOaAdi6eIq8x2Ouf6QPEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDIVJjhMofguXloiFglQTxFXhoj0JENPi5MQJr5XY0B2q8SjGNZ8mzqDWuWQH2PDhagnNnrOl8a1QqqnV+ApAiRVVEtaku8+J0wm6bdnwSUTC20kAdHO0TRBu365PAD+AnxyCNapZHNZJk869IkTbMUkbf5Ebg1hnywV/5b/UnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUJR4kaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6DAC4CEF7;
	Mon, 23 Mar 2026 14:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774275507;
	bh=z54twYpyCZdACUNzqjxk1EsOaAdi6eIq8x2Ouf6QPEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUJR4kaKSSNml4lXO24XDgpcpsUVDZ89WfVtlnOkfYjjbYN/qPwEFOKAbdSG0leuh
	 oBUr2mzq4fgHrfXcIK5qg3DA9fuH7SsvzysWZAj3FqbGSrmicJHh9cA/rFFD3mL0sT
	 aYCMpwSS3YPSNJs0v1jwBl4HV2aE2+4STvYEf1nHcr+c8kLiUopbzFN+8x4vAEgtCO
	 YkztR6BtltmQDqz0IA1Z8elfNI5mNXZmnJejlRRt3lpFby2jjFDS4PLlk0gh7LZzmD
	 MzJ+oQ33lXZtEmTZ4SNV3fQgg5Z4T8QZUHTTvaSgYcn03N0yRqvo7gzEURjB21HJXV
	 Kow9CyF0fM5ew==
Date: Mon, 23 Mar 2026 14:18:22 +0000
From: Simon Horman <horms@kernel.org>
To: Tyllis Xu <livelycarpet87@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com, peppe.cavallaro@st.com,
	rayagond@vayavyalabs.com, stable@vger.kernel.org,
	danisjiang@gmail.com, ychen@northwestern.edu
Subject: Re: [PATCH] net: stmmac: fix integer underflow in chain mode
 jumbo_frm
Message-ID: <20260323141822.GB69756@horms.kernel.org>
References: <20260321041058.901149-1-LivelyCarpet87@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321041058.901149-1-LivelyCarpet87@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-228581-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,bootlin.com,st.com,vayavyalabs.com,gmail.com,northwestern.edu];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev,kernel];
	RCPT_COUNT_TWELVE(0.00)[15];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3063B2F4260
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 11:10:58PM -0500, Tyllis Xu wrote:
> The jumbo_frm() chain-mode implementation unconditionally computes
> 
>     len = nopaged_len - bmax;
> 
> where nopaged_len = skb_headlen(skb) (linear bytes only) and bmax is
> BUF_SIZE_8KiB or BUF_SIZE_2KiB.  However, the caller stmmac_xmit()
> decides to invoke jumbo_frm() based on skb->len (total length including
> page fragments):
> 
>     is_jumbo = stmmac_is_jumbo_frm(priv, skb->len, enh_desc);
> 
> When a packet has a small linear portion (nopaged_len <= bmax) but a
> large total length due to page fragments (skb->len > bmax), the
> subtraction wraps as an unsigned integer, producing a huge len value
> (~0xFFFFxxxx).  This causes the while (len != 0) loop to execute
> hundreds of thousands of iterations, passing skb->data + bmax * i
> pointers far beyond the skb buffer to dma_map_single().  On IOMMU-less
> SoCs (the typical deployment for stmmac), this maps arbitrary kernel
> memory to the DMA engine, constituting a kernel memory disclosure and
> potential memory corruption from hardware.
> 
> The ring-mode counterpart already guards against this with:
> 
>     if (nopaged_len > BUF_SIZE_8KiB) { ... use len ... }
>     else { ... map nopaged_len directly ... }
> 
> Apply the same pattern to chain mode: guard the chunked-DMA path with
> if (nopaged_len > bmax), and add an else branch that maps the entire
> linear portion as a single descriptor when it fits within bmax.  The
> fragment loop in stmmac_xmit() handles page fragments afterward.
> 
> Fixes: 286a83721720 ("stmmac: add CHAINED descriptor mode support (V4)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>

As a fix for code present in net this patch should be targeted at the net
tree like this:

Subject: [PATCH net] net: stmmac: fix integer underflow in chain mode

As is, our CI tries to apply this patch to the default tree, net-next.
Which fails due to a conflict with commit 6b4286e05508 ("net: stmmac:
rename STMMAC_GET_ENTRY() -> STMMAC_NEXT_ENTRY()"). So no CI tests were
run.

> ---
>  drivers/net/ethernet/stmicro/stmmac/chain_mode.c | 71 ++++++++++++++---------
>  1 file changed, 44 insertions(+), 27 deletions(-)

The bulk of this patch is whitespace change (indentation).
So seems useful to examine this patch with whitespace changes ignored.

git diff -w yeilds;

diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
index 120a009c9992..c8980482dea2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
@@ -31,6 +31,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 	else
 		bmax = BUF_SIZE_2KiB;
 
+	if (nopaged_len > bmax) {
 		len = nopaged_len - bmax;
 
 		des2 = dma_map_single(priv->device, skb->data,
@@ -77,6 +78,18 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 				len = 0;
 			}
 		}
+	} else {
+		des2 = dma_map_single(priv->device, skb->data,
+				      nopaged_len, DMA_TO_DEVICE);
+		desc->des2 = cpu_to_le32(des2);
+		if (dma_mapping_error(priv->device, des2))
+			return -1;
+		tx_q->tx_skbuff_dma[entry].buf = des2;
+		tx_q->tx_skbuff_dma[entry].len = nopaged_len;
+		stmmac_prepare_tx_desc(priv, desc, 1, nopaged_len, csum,
+				STMMAC_CHAIN_MODE, 0, !skb_is_nonlinear(skb),
+				skb->len);
+	}
 
 	tx_q->cur_tx = entry;

The code in the else arm of the new condition is quite similar to
the (not visible in the diff above) code at the top of the non-else
arm of the condition.

I do see this is consistent with the ring-mode code.  So perhaps it is
appropriate as a fix. But I do wonder if this could be consolidated - e.g.
by setting up some local variables rather than moving the mapping logic
into a condition.

