Return-Path: <stable+bounces-226564-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNW3Ip+KuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226564-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:08:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 221ED2AF07F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76AE3304AAC0
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFCA3F65FB;
	Tue, 17 Mar 2026 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tOafZNVR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843273F54D1;
	Tue, 17 Mar 2026 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767248; cv=none; b=Jl2uKq/QNntqWtPDeX6i733CHyuf74nZPFfJjklkK3kzCJythXOuxjp477uSHO0EFT7wzPw8+RzRzKR8oM5mKmRz00aAByVO7dvt+ls16+py7idfzTBKVX4t+UvOHFW25rtb4K2Nzo5iRjwOJAzSt07feP3aHXL91RQm/msp1vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767248; c=relaxed/simple;
	bh=vnJQMFqME26BWeZ3i1cYiIixKTfpOqE4Mk0JJGouG2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3lHJL7qUR1HD3m+aVFyXoZbTV5sEpytk7v5m8oOjnmtTMCB4uCj3O/tj/UbnFkBeO+cUAmF8CF9DpGhy8bY2tHpSA6VCDHNtk4TNrxpiBJPHX3D0FlOadsOfyqCEDFZ5ZYLpacpPvK3Mir3uIn62JTZDDT02NWgorw/m5NImCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tOafZNVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A15AC4CEF7;
	Tue, 17 Mar 2026 17:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767248;
	bh=vnJQMFqME26BWeZ3i1cYiIixKTfpOqE4Mk0JJGouG2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tOafZNVRrlrXW/yErfSxMa7SWIk3a2Fi6XcaWesBpKpXONT5W0VX9CbE7KcfFMK6Z
	 Us+dQwvGmmzVPBpWXX8Y1aDmffUnIUVI7mHogCHXd5oF9eyKtKPkxyNw5crZlUR1/z
	 gY5r3rQEhpwnoyYMhocL/cO1wgsqNe5Qfz1FGv4I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 047/333] net: spacemit: Fix error handling in emac_alloc_rx_desc_buffers()
Date: Tue, 17 Mar 2026 17:31:16 +0100
Message-ID: <20260317163001.110962977@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226564-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 221ED2AF07F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vivian Wang <wangruikang@iscas.ac.cn>

[ Upstream commit 3aa1417803c1833cbd5bacb7e6a6489a196f2519 ]

Even if we get a dma_mapping_error() while mapping an RX buffer, we
should still update rx_ring->head to ensure that the buffers we were
able to allocate and map are used. Fix this by breaking out to the
existing code after the loop, analogous to the existing handling for skb
allocation failure.

Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
Link: https://patch.msgid.link/20260305-k1-ethernet-more-fixes-v2-1-e4e434d65055@iscas.ac.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/spacemit/k1_emac.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index b49c4708bf9eb..5de69a105168a 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -582,7 +582,9 @@ static void emac_alloc_rx_desc_buffers(struct emac_priv *priv)
 						  DMA_FROM_DEVICE);
 		if (dma_mapping_error(&priv->pdev->dev, rx_buf->dma_addr)) {
 			dev_err_ratelimited(&ndev->dev, "Mapping skb failed\n");
-			goto err_free_skb;
+			dev_kfree_skb_any(skb);
+			rx_buf->skb = NULL;
+			break;
 		}
 
 		rx_desc_addr = &((struct emac_desc *)rx_ring->desc_addr)[i];
@@ -607,10 +609,6 @@ static void emac_alloc_rx_desc_buffers(struct emac_priv *priv)
 
 	rx_ring->head = i;
 	return;
-
-err_free_skb:
-	dev_kfree_skb_any(skb);
-	rx_buf->skb = NULL;
 }
 
 /* Returns number of packets received */
-- 
2.51.0




