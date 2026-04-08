Return-Path: <stable+bounces-235058-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEejJ22l1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-235058-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:58:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 464C53C219F
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3809304D672
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCA73D8912;
	Wed,  8 Apr 2026 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FhLkfbXk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A380B34AB06;
	Wed,  8 Apr 2026 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674461; cv=none; b=eWmcN2dabwL/u3hmPdT5w0SpRRD2cSTgga1C2q9HNV2Is+jgNZjgB/i/saDGlx1rrJBgu83Pt7HTDQt4yUz76BlKK0x7EN6gaekb+5BW3DoanC5dd60MIuac54/9rPIXuY+NG45DINiOa+k6f6JlhWqIrn/ZZJFlauM9rabHj6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674461; c=relaxed/simple;
	bh=obE+PHJHkPfOA9oiWL8p2h28d5RYIr6IKDfHuJkZ/uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+frZi5ynM2h1bNoJIMSrVfinBxp9LGZI0wsomERvZd3GbJjKnddCrWyLxk2XgL6JCdsUKkJ1GdbCv4nUI9prx1suRAXwfod05tXg6qu5IFLJRTwOA/6LkzQIgHAFZj+bz4rwuKyvhUFGUEg9zPZgdTAG+ZuIdxaluxji5yxdrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FhLkfbXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD23C19421;
	Wed,  8 Apr 2026 18:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674461;
	bh=obE+PHJHkPfOA9oiWL8p2h28d5RYIr6IKDfHuJkZ/uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FhLkfbXkoLWrGx54jBFvZWNSMnS4pEXG3lLQpWKzS7KdoBaVx8p+D7obLA1+2HwQ5
	 u89QXQsUEYQ33g4fQAqJofaCxIxLiLCqZqittDeMyodI38valzLskizxMLqIlHHU1D
	 KL+S1OzU8uGMSUkxLGAXvmEI0Vsm6Pj9cOGRZT7g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Suraj Gupta <suraj.gupta2@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 074/311] net: xilinx: axienet: Fix BQL accounting for multi-BD TX packets
Date: Wed,  8 Apr 2026 20:01:14 +0200
Message-ID: <20260408175942.178735081@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235058-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,amd.com:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 464C53C219F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suraj Gupta <suraj.gupta2@amd.com>

[ Upstream commit d1978d03e86785872871bff9c2623174b10740de ]

When a TX packet spans multiple buffer descriptors (scatter-gather),
axienet_free_tx_chain sums the per-BD actual length from descriptor
status into a caller-provided accumulator. That sum is reset on each
NAPI poll. If the BDs for a single packet complete across different
polls, the earlier bytes are lost and never credited to BQL. This
causes BQL to think bytes are permanently in-flight, eventually
stalling the TX queue.

The SKB pointer is stored only on the last BD of a packet. When that
BD completes, use skb->len for the byte count instead of summing
per-BD status lengths. This matches netdev_sent_queue(), which debits
skb->len, and naturally survives across polls because no partial
packet contributes to the accumulator.

Fixes: c900e49d58eb ("net: xilinx: axienet: Implement BQL")
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
Link: https://patch.msgid.link/20260327073238.134948-3-suraj.gupta2@amd.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 284031fb2e2c7..eefe54ce66852 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -770,8 +770,8 @@ static int axienet_device_reset(struct net_device *ndev)
  * @first_bd:	Index of first descriptor to clean up
  * @nr_bds:	Max number of descriptors to clean up
  * @force:	Whether to clean descriptors even if not complete
- * @sizep:	Pointer to a u32 filled with the total sum of all bytes
- *		in all cleaned-up descriptors. Ignored if NULL.
+ * @sizep:	Pointer to a u32 accumulating the total byte count of
+ *		completed packets (using skb->len). Ignored if NULL.
  * @budget:	NAPI budget (use 0 when not called from NAPI poll)
  *
  * Would either be called after a successful transmit operation, or after
@@ -805,6 +805,8 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 				 DMA_TO_DEVICE);
 
 		if (cur_p->skb && (status & XAXIDMA_BD_STS_COMPLETE_MASK)) {
+			if (sizep)
+				*sizep += cur_p->skb->len;
 			napi_consume_skb(cur_p->skb, budget);
 			packets++;
 		}
@@ -818,9 +820,6 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 		wmb();
 		cur_p->cntrl = 0;
 		cur_p->status = 0;
-
-		if (sizep)
-			*sizep += status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
 	}
 
 	if (!force) {
-- 
2.53.0




