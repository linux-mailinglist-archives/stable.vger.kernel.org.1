Return-Path: <stable+bounces-223543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBnWKS2frmm2GwIAu9opvQ
	(envelope-from <stable+bounces-223543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:21:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 525CA236F38
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62A483018682
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB2538F24D;
	Mon,  9 Mar 2026 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eGcZHAV9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FD738E5DC
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773051689; cv=none; b=GiMMTV7J40ufzTX85zaMuFeAsFZ19LGr3UawdqWX3m5Z51/tgZ+1wmwjHA0WTmDBZYFh0ETMqfb1v6ovI+0I7ryNFhAGnQMSdX2NYQ56D8CxDLympngm2Fb7/Y6xP1Id5MungSuZCvRZwglrmGWCBHUx6nevZ/mQEBGd1mbqzj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773051689; c=relaxed/simple;
	bh=h98wsGMMpFH+yE7rIx0krRtygzFyr4DaD6gZWHS/m6U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ffgnxoOlXXgMUvjROgPfcT2HD8YnH/dv1E6uGE2uDQkU69WoSyNJbjFSFhEvejwmOlg7s0ssyteWz82hwTji8LvKxTUTlyB/iO43+jLszIWSqXKgtip6nx3jjvmjsnYRlIC9rOAz7VdhxEq0mc2MF537ZT3aGPz+fT21jT3N2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eGcZHAV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451AAC4CEF7;
	Mon,  9 Mar 2026 10:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773051688;
	bh=h98wsGMMpFH+yE7rIx0krRtygzFyr4DaD6gZWHS/m6U=;
	h=Subject:To:Cc:From:Date:From;
	b=eGcZHAV9HgGO6XynmZxxWjRLvc8mxTWQt5XcUPCt+fneHdEZkdj8aj2Eu3iunO1Qp
	 cGitGrIidpzfDneXrYh88daNTDf9uTIqDz0BAWcjxbTuqHD2mKYHQpoln3CiTJFHti
	 BQ1LXZz/4FqJd3ynI5S/X+b9NaJS2IHCwdtGJEhw=
Subject: FAILED: patch "[PATCH] gve: fix incorrect buffer cleanup in" failed to apply to 6.6-stable tree
To: nktgrg@google.com,horms@kernel.org,hramamurthy@google.com,jordanrhee@google.com,joshwash@google.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Mar 2026 11:21:18 +0100
Message-ID: <2026030918-unflawed-unmasking-3b8d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 525CA236F38
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223543-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.372];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fb868db5f4bccd7a78219313ab2917429f715cea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026030918-unflawed-unmasking-3b8d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fb868db5f4bccd7a78219313ab2917429f715cea Mon Sep 17 00:00:00 2001
From: Ankit Garg <nktgrg@google.com>
Date: Fri, 20 Feb 2026 13:53:24 -0800
Subject: [PATCH] gve: fix incorrect buffer cleanup in
 gve_tx_clean_pending_packets for QPL

In DQ-QPL mode, gve_tx_clean_pending_packets() incorrectly uses the RDA
buffer cleanup path. It iterates num_bufs times and attempts to unmap
entries in the dma array.

This leads to two issues:
1. The dma array shares storage with tx_qpl_buf_ids (union).
 Interpreting buffer IDs as DMA addresses results in attempting to
 unmap incorrect memory locations.
2. num_bufs in QPL mode (counting 2K chunks) can significantly exceed
 the size of the dma array, causing out-of-bounds access warnings
(trace below is how we noticed this issue).

UBSAN: array-index-out-of-bounds in
drivers/net/ethernet/drivers/net/ethernet/google/gve/gve_tx_dqo.c:178:5 index 18 is out of
range for type 'dma_addr_t[18]' (aka 'unsigned long long[18]')
Workqueue: gve gve_service_task [gve]
Call Trace:
<TASK>
dump_stack_lvl+0x33/0xa0
__ubsan_handle_out_of_bounds+0xdc/0x110
gve_tx_stop_ring_dqo+0x182/0x200 [gve]
gve_close+0x1be/0x450 [gve]
gve_reset+0x99/0x120 [gve]
gve_service_task+0x61/0x100 [gve]
process_scheduled_works+0x1e9/0x380

Fix this by properly checking for QPL mode and delegating to
gve_free_tx_qpl_bufs() to reclaim the buffers.

Cc: stable@vger.kernel.org
Fixes: a6fb8d5a8b69 ("gve: Tx path for DQO-QPL")
Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260220215324.1631350-1-joshwash@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 28e85730f785..b57e8f13cb51 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -167,6 +167,25 @@ gve_free_pending_packet(struct gve_tx_ring *tx,
 	}
 }
 
+static void gve_unmap_packet(struct device *dev,
+			     struct gve_tx_pending_packet_dqo *pkt)
+{
+	int i;
+
+	if (!pkt->num_bufs)
+		return;
+
+	/* SKB linear portion is guaranteed to be mapped */
+	dma_unmap_single(dev, dma_unmap_addr(pkt, dma[0]),
+			 dma_unmap_len(pkt, len[0]), DMA_TO_DEVICE);
+	for (i = 1; i < pkt->num_bufs; i++) {
+		netmem_dma_unmap_page_attrs(dev, dma_unmap_addr(pkt, dma[i]),
+					    dma_unmap_len(pkt, len[i]),
+					    DMA_TO_DEVICE, 0);
+	}
+	pkt->num_bufs = 0;
+}
+
 /* gve_tx_free_desc - Cleans up all pending tx requests and buffers.
  */
 static void gve_tx_clean_pending_packets(struct gve_tx_ring *tx)
@@ -176,21 +195,12 @@ static void gve_tx_clean_pending_packets(struct gve_tx_ring *tx)
 	for (i = 0; i < tx->dqo.num_pending_packets; i++) {
 		struct gve_tx_pending_packet_dqo *cur_state =
 			&tx->dqo.pending_packets[i];
-		int j;
 
-		for (j = 0; j < cur_state->num_bufs; j++) {
-			if (j == 0) {
-				dma_unmap_single(tx->dev,
-					dma_unmap_addr(cur_state, dma[j]),
-					dma_unmap_len(cur_state, len[j]),
-					DMA_TO_DEVICE);
-			} else {
-				dma_unmap_page(tx->dev,
-					dma_unmap_addr(cur_state, dma[j]),
-					dma_unmap_len(cur_state, len[j]),
-					DMA_TO_DEVICE);
-			}
-		}
+		if (tx->dqo.qpl)
+			gve_free_tx_qpl_bufs(tx, cur_state);
+		else
+			gve_unmap_packet(tx->dev, cur_state);
+
 		if (cur_state->skb) {
 			dev_consume_skb_any(cur_state->skb);
 			cur_state->skb = NULL;
@@ -1157,22 +1167,6 @@ static void remove_from_list(struct gve_tx_ring *tx,
 	}
 }
 
-static void gve_unmap_packet(struct device *dev,
-			     struct gve_tx_pending_packet_dqo *pkt)
-{
-	int i;
-
-	/* SKB linear portion is guaranteed to be mapped */
-	dma_unmap_single(dev, dma_unmap_addr(pkt, dma[0]),
-			 dma_unmap_len(pkt, len[0]), DMA_TO_DEVICE);
-	for (i = 1; i < pkt->num_bufs; i++) {
-		netmem_dma_unmap_page_attrs(dev, dma_unmap_addr(pkt, dma[i]),
-					    dma_unmap_len(pkt, len[i]),
-					    DMA_TO_DEVICE, 0);
-	}
-	pkt->num_bufs = 0;
-}
-
 /* Completion types and expected behavior:
  * No Miss compl + Packet compl = Packet completed normally.
  * Miss compl + Re-inject compl = Packet completed normally.


