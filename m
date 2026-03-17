Return-Path: <stable+bounces-226182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNKfIAmFuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:44:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D32F92AE554
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91B483081BD3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131713EC2CA;
	Tue, 17 Mar 2026 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gGGrC9SM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB19C376477;
	Tue, 17 Mar 2026 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765623; cv=none; b=o365KljwzbkWwRaWzc+/f55jQLvlwiQ4igyN7FNv+mAWtBK7t19/BVLWP1nGniT4+RjvrP1RdEhJFGWUwrUI0usH5unTmwE2RP4LU/fIZ42vPcyfBEWBEPiIX6uf+rW3opq7NytTLyY1y/d3OyE11YOcNjlBDNr+2b/laO9T6DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765623; c=relaxed/simple;
	bh=XyvE7fDnqTj6RQIVLSRB/jSZMxbXRLbxowNoBQe4Uzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzQ5CHW0bJnp1Kxwevp36yLAev9mFKLJjG6J4ANK9lnGCQknhffppJBwpy96tXp0Z372LLgvdEVdf6nLLhyCmdH+DNnATPLZ0ZfsoPUlrGNsS66cs/5tzYXncEkT8Bu5r/kYJp5OM8etef9/WRkfavkLhpstigq16OctiY0oZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gGGrC9SM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFB8C4CEF7;
	Tue, 17 Mar 2026 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765623;
	bh=XyvE7fDnqTj6RQIVLSRB/jSZMxbXRLbxowNoBQe4Uzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gGGrC9SMK8ouPJ9/sQxbrtDlBU/Y5LLEdX3H0n/eRZuRalAqIe53yUzRTiewbdvdT
	 NIvhyig53N17JIyoRNWyk4aQOtIRMlrjpme5SYUt6+tKO9Fv4PX3/bfAjw+zqPVsUN
	 3r7TIS62J9Y6HBi93BEqMfQDLo/B5OGQxByNl0aE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 052/378] net: spacemit: Fix error handling in emac_tx_mem_map()
Date: Tue, 17 Mar 2026 17:30:09 +0100
Message-ID: <20260317163008.905784731@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226182-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D32F92AE554
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vivian Wang <wangruikang@iscas.ac.cn>

[ Upstream commit 86292155bea578ebab0ca3b65d4d87ecd8a0e9ea ]

The DMA mappings were leaked on mapping error. Free them with the
existing emac_free_tx_buf() function.

Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
Link: https://patch.msgid.link/20260305-k1-ethernet-more-fixes-v2-2-e4e434d65055@iscas.ac.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/spacemit/k1_emac.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index 5de69a105168a..d64ca7bbda9ea 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -750,7 +750,7 @@ static void emac_tx_mem_map(struct emac_priv *priv, struct sk_buff *skb)
 	struct emac_desc tx_desc, *tx_desc_addr;
 	struct device *dev = &priv->pdev->dev;
 	struct emac_tx_desc_buffer *tx_buf;
-	u32 head, old_head, frag_num, f;
+	u32 head, old_head, frag_num, f, i;
 	bool buf_idx;
 
 	frag_num = skb_shinfo(skb)->nr_frags;
@@ -818,6 +818,15 @@ static void emac_tx_mem_map(struct emac_priv *priv, struct sk_buff *skb)
 
 err_free_skb:
 	dev_dstats_tx_dropped(priv->ndev);
+
+	i = old_head;
+	while (i != head) {
+		emac_free_tx_buf(priv, i);
+
+		if (++i == tx_ring->total_cnt)
+			i = 0;
+	}
+
 	dev_kfree_skb_any(skb);
 }
 
-- 
2.51.0




