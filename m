Return-Path: <stable+bounces-226565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BIEDsGNuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:22:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A772AF6CE
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0103430BC316
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F58C3F65F7;
	Tue, 17 Mar 2026 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uVvwDL//"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF773F54A5;
	Tue, 17 Mar 2026 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767252; cv=none; b=SYc/wzycEOyVuIYc3xU4RGv8pQ2CGZ98Qsa6tjO08Z3tAy26CIckjt/BNzIYmhshlCshpeoVCYiWD84eJaUVFVYsSb6EE281XKPrb3rGoOb9HN8WUFXqSiRn7c44e8Fyoi4wbJXnqeynUPNUCvm/NANeKweSedMHxRGZXMjfjPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767252; c=relaxed/simple;
	bh=oeufvtTD8AmbBwzJ8P5l53oeM3EjXxW/l4SExSSE0eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3/H7Rohz7YG6UbYkhMK3maglLBlKSl9DnexzS/7DeUdSbBqj0bCkjkuK/44vrTWmL1kuyzHbe9/hFjF/IF3ooQFKCjBVMORyES9iV0dlyfaT6pEKpRLb7tUbDE0qmcb3RQE+JvTB/a/cD5C7hGNU0JAK8A1Sxi5Wa1k9qrkd+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uVvwDL//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1057C2BC86;
	Tue, 17 Mar 2026 17:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767252;
	bh=oeufvtTD8AmbBwzJ8P5l53oeM3EjXxW/l4SExSSE0eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uVvwDL//n+CJ+fDtCLUeL4gWElEaGuNNOSVopUGSTITskpHndvrVh3ij18ym0Cq9d
	 MaJRpxw/et966tib8uMEy2NHEYKD4eraPiamvd/ACOS4NNFvRhD0o3+lgpYW5UtBIR
	 UWY1EPWAeya0RzkPTuMEm79UQRmAHQXofj8m4jeo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 048/333] net: spacemit: Fix error handling in emac_tx_mem_map()
Date: Tue, 17 Mar 2026 17:31:17 +0100
Message-ID: <20260317163001.147523303@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226565-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,iscas.ac.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48A772AF6CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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




