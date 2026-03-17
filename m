Return-Path: <stable+bounces-226782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LpkFbeOuWnQKQIAu9opvQ
	(envelope-from <stable+bounces-226782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:26:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FFB2AF897
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E79863030DA1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EE237BE8B;
	Tue, 17 Mar 2026 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="joEvDdV+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41E937B3F6;
	Tue, 17 Mar 2026 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768177; cv=none; b=D/2MOU9htjhj5NgxkhYvputw99yq+/a6bPKGfybPyNFqWzeWAyDbuq65CIMDyXprJPxmfRr4Z1etAIL/hzWd3yPtPuh7j3G3Q3NqpMR/9ZdWnNfc5R5o4Pqn7MZGQhvLFNiwpude3WcF7/yvQL8p+5QYizfg27Yl1hKvHA17CI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768177; c=relaxed/simple;
	bh=TJmGLVF7UFQbGOxZIK33wtZW1gXhVwQ4wD6tYfuemec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpGEfCQ/DoZReG0gCxQ+Xnm/usCCRAylkp6arCa8rWdS65dPiN1FjEQCbCocTpdKNQfQuwljtR95MHai18jC4iJQyuP2UkH/KfpmQsLLXlSUcgS2L9Afn8a23ACpS7fePW7XTrmqK4nMV0WaADj7HodwUU4zbfhEw0q+yRzLlzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=joEvDdV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339B1C4CEF7;
	Tue, 17 Mar 2026 17:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768176;
	bh=TJmGLVF7UFQbGOxZIK33wtZW1gXhVwQ4wD6tYfuemec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=joEvDdV+k690MDx7HJmeZkz+SXueGQeqTnvlRQGxkLVoPtf/2Ri+3vA8S4ULCHu5O
	 ZeYTf5sLEW4F9mn+XGzZ97Yq8BKQy+s3vbCtxkiPjDmGXq8Hc04wIM2QvJmk/oQf3O
	 DiBjoFowPrJ430Ni38+sxZUi18kmeuGioxpPhqvA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Long Li <longli@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 216/333] net: mana: Ring doorbell at 4 CQ wraparounds
Date: Tue, 17 Mar 2026 17:34:05 +0100
Message-ID: <20260317163007.373345597@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226782-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 19FFB2AF897
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Long Li <longli@microsoft.com>

commit dabffd08545ffa1d7183bc45e387860984025291 upstream.

MANA hardware requires at least one doorbell ring every 8 wraparounds
of the CQ. The driver rings the doorbell as a form of flow control to
inform hardware that CQEs have been consumed.

The NAPI poll functions mana_poll_tx_cq() and mana_poll_rx_cq() can
poll up to CQE_POLLING_BUFFER (512) completions per call. If the CQ
has fewer than 512 entries, a single poll call can process more than
4 wraparounds without ringing the doorbell. The doorbell threshold
check also uses ">" instead of ">=", delaying the ring by one extra
CQE beyond 4 wraparounds. Combined, these issues can cause the driver
to exceed the 8-wraparound hardware limit, leading to missed
completions and stalled queues.

Fix this by capping the number of CQEs polled per call to 4 wraparounds
of the CQ in both TX and RX paths. Also change the doorbell threshold
from ">" to ">=" so the doorbell is rung as soon as 4 wraparounds are
reached.

Cc: stable@vger.kernel.org
Fixes: 58a63729c957 ("net: mana: Fix doorbell out of order violation and avoid unnecessary doorbell rings")
Signed-off-by: Long Li <longli@microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Link: https://patch.msgid.link/20260226192833.1050807-1-longli@microsoft.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c |   23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1645,8 +1645,14 @@ static void mana_poll_tx_cq(struct mana_
 	ndev = txq->ndev;
 	apc = netdev_priv(ndev);
 
+	/* Limit CQEs polled to 4 wraparounds of the CQ to ensure the
+	 * doorbell can be rung in time for the hardware's requirement
+	 * of at least one doorbell ring every 8 wraparounds.
+	 */
 	comp_read = mana_gd_poll_cq(cq->gdma_cq, completions,
-				    CQE_POLLING_BUFFER);
+				    min((cq->gdma_cq->queue_size /
+					  COMP_ENTRY_SIZE) * 4,
+					 CQE_POLLING_BUFFER));
 
 	if (comp_read < 1)
 		return;
@@ -2031,7 +2037,14 @@ static void mana_poll_rx_cq(struct mana_
 	struct mana_rxq *rxq = cq->rxq;
 	int comp_read, i;
 
-	comp_read = mana_gd_poll_cq(cq->gdma_cq, comp, CQE_POLLING_BUFFER);
+	/* Limit CQEs polled to 4 wraparounds of the CQ to ensure the
+	 * doorbell can be rung in time for the hardware's requirement
+	 * of at least one doorbell ring every 8 wraparounds.
+	 */
+	comp_read = mana_gd_poll_cq(cq->gdma_cq, comp,
+				    min((cq->gdma_cq->queue_size /
+					  COMP_ENTRY_SIZE) * 4,
+					 CQE_POLLING_BUFFER));
 	WARN_ON_ONCE(comp_read > CQE_POLLING_BUFFER);
 
 	rxq->xdp_flush = false;
@@ -2076,11 +2089,11 @@ static int mana_cq_handler(void *context
 		mana_gd_ring_cq(gdma_queue, SET_ARM_BIT);
 		cq->work_done_since_doorbell = 0;
 		napi_complete_done(&cq->napi, w);
-	} else if (cq->work_done_since_doorbell >
-		   cq->gdma_cq->queue_size / COMP_ENTRY_SIZE * 4) {
+	} else if (cq->work_done_since_doorbell >=
+		   (cq->gdma_cq->queue_size / COMP_ENTRY_SIZE) * 4) {
 		/* MANA hardware requires at least one doorbell ring every 8
 		 * wraparounds of CQ even if there is no need to arm the CQ.
-		 * This driver rings the doorbell as soon as we have exceeded
+		 * This driver rings the doorbell as soon as it has processed
 		 * 4 wraparounds.
 		 */
 		mana_gd_ring_cq(gdma_queue, 0);



