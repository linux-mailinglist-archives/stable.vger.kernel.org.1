Return-Path: <stable+bounces-230563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCVcCoTaxWneCQUAu9opvQ
	(envelope-from <stable+bounces-230563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 02:16:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D66B33DC45
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 02:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B26D430312C5
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 01:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34C0298CC7;
	Fri, 27 Mar 2026 01:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="WSfm52FK"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31F523C4F3
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 01:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574205; cv=none; b=FXzbsNsVSwi6YfBO5x2qg/vizAFSGTc46tgITpnw2Im/jxLrBi4BCnVQnVxg6TsjG75h1g1wOU075d+flhEcuAVdrXFKY8hIUjFlGoLTnP9vz2thxRy9ecJmRStCZuKJ01oPY+0Rw11m0zeOiFryIv8/yBYTEINKx/IBNEmTQJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574205; c=relaxed/simple;
	bh=4ION8xlOxziA6xIZ/HXmfnOT9E1HwOafvdlHdxXZrM4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=CBAgi+ugpntVHeCBdRBo+BGLrSC9hA55ufs+atSWQDTKQjPNEuLVL4yZA+J86lTasY1QDPMAlTBIPs/LT1K3G+r2YDTSywI23+HLDsLrw7ds2ivrv9xwqy8qCWJw+IaTvnetHSn/TVmMvhinnTi11wA9T22LysvjAzk4hYCAz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=WSfm52FK; arc=none smtp.client-ip=43.163.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774574193; bh=3E7Cy3Lq5RO4uDWdY28fkZ57PM0uaL3UsRvYBXsxZ/Y=;
	h=From:To:Cc:Subject:Date;
	b=WSfm52FKTcRhp68EyfDlOaLLtT9XOe5eo3U7LntTDMxeR4R48//Gkj7/4QN6Q6SzM
	 OwBe4kIeRMLCZgCcbYQHKJNVsS8BHKovhvuH8MF8qJaiDh0aPjpDDgSAK+6omQGi9h
	 L9/B+Va3Ffdm79qKjSBWGNpZWqZNYNEFEzEamckY=
Received: from June.localdomain ([123.121.145.35])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 41D27EBF; Fri, 27 Mar 2026 09:16:29 +0800
X-QQ-mid: xmsmtpt1774574189tpmumoq43
Message-ID: <tencent_5F1EACA5E1063E7E346A4138913F7486A009@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNzn4NIMJdFeCJf7eTIWagXxfV2gDR6fjAo5PkA2iJNwzCBtFVKMn0
	 tFQ8NTkYQKBrnTRyl6xsDvO0qM1vBXmfzt/E9YppNBe6VSfq5S/myfSqTtsjTDdwKo/JAqPVWhHR
	 f0Wlwq+ZPuBQJk6tDtlHA2wrWBjgPnLFL18ajKfpj3CVz2kgnNi9QrnYKsUQraRElRDiSrC+aHET
	 WIctd9ddXG/Q0+F5BM3/YUFy19dcgeY8rODKU5qvPf4id1KoJvmlmEFY2h9cYFVutJidtlwdkNTb
	 AmyMct+48HNVWJ0rxdCx0cx/8TOL2iC9BcT69F1GV+MkNWTHgIBkndK6rl2Z/vW8o9MrHWltdr1P
	 Bi2vniRTTG/DVG5/4AjC9QmDKvfiNOltn/A+CWE1hIqlZVRO2NmzJeWqKNZOzogFXLLXB6EymeBa
	 5Umot1bXHLK0ae28u3vGyApvT9DTJGbvg85+ixP1BOFwwpq/T5swfejxfqVoH9WFtoQoDtBfZ1nS
	 Gm/OaQYBc1g/AJtmmYFoOGwc4iv0J/HkCdpd+im6+H89IXrbqATX/XP00BsbFXNx6GxTtDb0/IsS
	 pjV+Rh2wuuLsX1yWNW658RpwwG56TJw6fTO8P2FtvkEo5hBKwItVuxVS0lqw1kBH9xOd85jA3ekG
	 JMq18jFPuNN71V6+SEOyKMQpMit/G6B5/mT9AheFTmn4dZpToBCcciB5gt1ezKSpgfraU9LJGZNL
	 GC+q/saWcSpUhy9O7+WSRkjgY5D0vi3HVEbob3qj8Hsk6FCv40fg5drWawBbnjZ6M9bSsxBsUfd0
	 m2Gnk5zfKRUjgeCjBzQC96k3vQIOWxWgWt0Pw8xjfnbJQuzuBVUIGpgNR0Ol3s4nlU03RNLz0CAZ
	 eBaBm9o0e0OwzxHAXO1U2aTrx8febcGhc1nn1ffbBtYKLl3j+ETrJgqS+pL65q0uTucnn56O5sl0
	 +Idn8lz+edooOGFdqT+gnzxSQjen+9BkyGR834O6TW02MGpB0kHie1PEdBnPpULO2/uK1kS72MyF
	 WHacISJbItzWia3TNiih/6bzNn2LMfjsr8LFyr772PwphUa9+A
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Wang Jun <1742789905@qq.com>
To: kuba@kernel.org
Cc: pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	simon.horman@corigine.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gszhai@bjtu.edu.cn,
	25125332@bjtu.edu.cn,
	25125283@bjtu.edu.cn,
	23120469@bjtu.edu.cn,
	Wang Jun <1742789905@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: ns83820: check DMA mapping errors in hard_start_xmit
Date: Fri, 27 Mar 2026 09:16:27 +0800
X-OQ-MSGID: <20260327011627.40863-1-1742789905@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230563-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[redhat.com,lunn.ch,davemloft.net,google.com,corigine.com,vger.kernel.org,bjtu.edu.cn,qq.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1742789905@qq.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:dkim,qq.com:email,qq.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D66B33DC45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ns83820 driver currently ignores the return values of dma_map_single()
and skb_frag_dma_map() in the transmit path. If DMA mapping fails due to
IOMMU exhaustion or SWIOTLB pressure, the driver may proceed with invalid
DMA addresses, potentially causing hardware errors, data corruption, or
system instability.

Additionally, if mapping fails midway through processing fragmented
packets,previously mapped DMA resources are not released, leading
to DMA resource leaks.

Fix this by:
1. Checking dma_mapping_error() after each DMA mapping call.
2. Implementing an error handling path to unmap successfully
mapped buffers(both linear and fragments) using
dma_unmap_single().
3. Freeing the skb using dev_kfree_skb_any() to safely handle
both process and softirq contexts, as hard_start_xmit may be
called with IRQs enabled.
4. Returning NETDEV_TX_OK to drop the packet gracefully and
prevent TX queue stagnation.

This ensures compliance with the DMA API guidelines and
improves driver stability under memory pressure.

Fixes: fd9e4d6fec15 ("natsemi: switch from 'pci_' to 'dma_' API")
Cc: stable@vger.kernel.org
Signed-off-by: Wang Jun <1742789905@qq.com>
---
 drivers/net/ethernet/natsemi/ns83820.c | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ethernet/natsemi/ns83820.c
index cdbf82affa7b..90465e4977c3 100644
--- a/drivers/net/ethernet/natsemi/ns83820.c
+++ b/drivers/net/ethernet/natsemi/ns83820.c
@@ -1051,6 +1051,12 @@ static netdev_tx_t ns83820_hard_start_xmit(struct sk_buff *skb,
 	int stopped = 0;
 	int do_intr = 0;
 	volatile __le32 *first_desc;
+	dma_addr_t frag_dma_addr[MAX_SKB_FRAGS];
+	unsigned int frag_dma_len[MAX_SKB_FRAGS];
+	int frag_mapped_count = 0;
+	dma_addr_t main_buf = 0;
+	unsigned int main_len = 0;
+	int i;
 
 	dprintk("ns83820_hard_start_xmit\n");
 
@@ -1121,6 +1127,13 @@ static netdev_tx_t ns83820_hard_start_xmit(struct sk_buff *skb,
 	buf = dma_map_single(&dev->pci_dev->dev, skb->data, len,
 			     DMA_TO_DEVICE);
 
+	if (dma_mapping_error(&dev->pci_dev->dev, buf)) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+	main_buf = buf;
+	main_len = len;
+
 	first_desc = dev->tx_descs + (free_idx * DESC_SIZE);
 
 	for (;;) {
@@ -1144,6 +1157,15 @@ static netdev_tx_t ns83820_hard_start_xmit(struct sk_buff *skb,
 
 		buf = skb_frag_dma_map(&dev->pci_dev->dev, frag, 0,
 				       skb_frag_size(frag), DMA_TO_DEVICE);
+		if (dma_mapping_error(&dev->pci_dev->dev, buf))
+			goto dma_map_error;
+
+		if (frag_mapped_count < MAX_SKB_FRAGS) {
+			frag_dma_addr[frag_mapped_count] = buf;
+			frag_dma_len[frag_mapped_count] = skb_frag_size(frag);
+			frag_mapped_count++;
+		}
+
 		dprintk("frag: buf=%08Lx  page=%08lx offset=%08lx\n",
 			(long long)buf, (long) page_to_pfn(frag->page),
 			frag->page_offset);
@@ -1166,6 +1188,16 @@ static netdev_tx_t ns83820_hard_start_xmit(struct sk_buff *skb,
 	if (stopped && (dev->tx_done_idx != tx_done_idx) && start_tx_okay(dev))
 		netif_start_queue(ndev);
 
+	return NETDEV_TX_OK;
+dma_map_error:
+	dma_unmap_single(&dev->pci_dev->dev, main_buf, main_len, DMA_TO_DEVICE);
+	for (i = 0; i < frag_mapped_count; i++) {
+		dma_unmap_single(&dev->pci_dev->dev, frag_dma_addr[i], frag_dma_len[i],
+				 DMA_TO_DEVICE);
+	}
+
+	dev_kfree_skb_any(skb);
+
 	return NETDEV_TX_OK;
 }
 
-- 
2.43.0


