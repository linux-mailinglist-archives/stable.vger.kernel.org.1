Return-Path: <stable+bounces-234662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oO41LHqk1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:54:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 146813C1ED1
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98D3630D748D
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9373C5552;
	Wed,  8 Apr 2026 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jdGwkHm5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1059E2F39C2;
	Wed,  8 Apr 2026 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673439; cv=none; b=X/byQicyqwXWJ8yXFgsUmLMRoMK6ITFYxqWmBe1jiLNTqKMRdP0CJKQvfH7otrN2eKmx0rE+IiPRFU6pmz2hBnftedwQAvw2x1vPIAFNbOCfss/msy7aGaR7C1e+OdOxKZiHPB9LfTkMUjKr6n35mFiawSXL+KnYNBCLngEfDyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673439; c=relaxed/simple;
	bh=aiGrJashckrkjjXZQJ0poqgrrH4onajL3n78iu+1x00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exxbdyTeAAmPenRQIbqJLyUu4eSh0bdN4Y3YkmMe9VczMI4pClB69W+ixq8pmlpfP+7Jd4tkx3d+q4k9WrFc1yGi/f9uVOJO4ha2bxi8xFzD1h3weYZUOaDOqMWtBjlooSHQnL1hdRomYjllONvTQJWhZl1SaCTvBAWPqXw4Uxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jdGwkHm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B663C19421;
	Wed,  8 Apr 2026 18:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673439;
	bh=aiGrJashckrkjjXZQJ0poqgrrH4onajL3n78iu+1x00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jdGwkHm5+/fNCozI21nU5vujAhC4Yv24/8erJFhhw0IvdXGX8yQfj1HXsEMHi8we8
	 T5g3qfrxF43uZJvRtyS2u/QM5g6p2cu6QISUo8MbCxxnO+g2RGqAbskQfKrt8esl5R
	 4YcOx4ZXDqDZDNzWXqgZQMLHc9GY8tmCQVMttAsQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yufan Chen <yufan.chen@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 233/277] net: ftgmac100: fix ring allocation unwind on open failure
Date: Wed,  8 Apr 2026 20:03:38 +0200
Message-ID: <20260408175942.558153034@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234662-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: 146813C1ED1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yufan Chen <yufan.chen@linux.dev>

commit c0fd0fe745f5e8c568d898cd1513d0083e46204a upstream.

ftgmac100_alloc_rings() allocates rx_skbs, tx_skbs, rxdes, txdes, and
rx_scratch in stages. On intermediate failures it returned -ENOMEM
directly, leaking resources allocated earlier in the function.

Rework the failure path to use staged local unwind labels and free
allocated resources in reverse order before returning -ENOMEM. This
matches common netdev allocation cleanup style.

Fixes: d72e01a0430f ("ftgmac100: Use a scratch buffer for failed RX allocations")
Cc: stable@vger.kernel.org
Signed-off-by: Yufan Chen <yufan.chen@linux.dev>
Link: https://patch.msgid.link/20260328163257.60836-1-yufan.chen@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/faraday/ftgmac100.c |   28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -964,19 +964,19 @@ static int ftgmac100_alloc_rings(struct
 	priv->tx_skbs = kcalloc(MAX_TX_QUEUE_ENTRIES, sizeof(void *),
 				GFP_KERNEL);
 	if (!priv->tx_skbs)
-		return -ENOMEM;
+		goto err_free_rx_skbs;
 
 	/* Allocate descriptors */
 	priv->rxdes = dma_alloc_coherent(priv->dev,
 					 MAX_RX_QUEUE_ENTRIES * sizeof(struct ftgmac100_rxdes),
 					 &priv->rxdes_dma, GFP_KERNEL);
 	if (!priv->rxdes)
-		return -ENOMEM;
+		goto err_free_tx_skbs;
 	priv->txdes = dma_alloc_coherent(priv->dev,
 					 MAX_TX_QUEUE_ENTRIES * sizeof(struct ftgmac100_txdes),
 					 &priv->txdes_dma, GFP_KERNEL);
 	if (!priv->txdes)
-		return -ENOMEM;
+		goto err_free_rxdes;
 
 	/* Allocate scratch packet buffer */
 	priv->rx_scratch = dma_alloc_coherent(priv->dev,
@@ -984,9 +984,29 @@ static int ftgmac100_alloc_rings(struct
 					      &priv->rx_scratch_dma,
 					      GFP_KERNEL);
 	if (!priv->rx_scratch)
-		return -ENOMEM;
+		goto err_free_txdes;
 
 	return 0;
+
+err_free_txdes:
+	dma_free_coherent(priv->dev,
+			  MAX_TX_QUEUE_ENTRIES *
+			  sizeof(struct ftgmac100_txdes),
+			  priv->txdes, priv->txdes_dma);
+	priv->txdes = NULL;
+err_free_rxdes:
+	dma_free_coherent(priv->dev,
+			  MAX_RX_QUEUE_ENTRIES *
+			  sizeof(struct ftgmac100_rxdes),
+			  priv->rxdes, priv->rxdes_dma);
+	priv->rxdes = NULL;
+err_free_tx_skbs:
+	kfree(priv->tx_skbs);
+	priv->tx_skbs = NULL;
+err_free_rx_skbs:
+	kfree(priv->rx_skbs);
+	priv->rx_skbs = NULL;
+	return -ENOMEM;
 }
 
 static void ftgmac100_init_rings(struct ftgmac100 *priv)



