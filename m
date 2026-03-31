Return-Path: <stable+bounces-231310-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mId4Fwwoy2nLEQYAu9opvQ
	(envelope-from <stable+bounces-231310-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 03:49:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0541E363229
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 03:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A8B6301395C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 01:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E528421D585;
	Tue, 31 Mar 2026 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Xz53Arwz"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6688735C190
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 01:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774921736; cv=none; b=Z2T2o0vlIPxqMNi8/EA33E9EbmgCIi3eAu0jUQpclWV13EokwnvqgpSWDZbNZSYd88PK2uOOBcSMwsp+KyiuNy/0Cce+Clftt5wK+e5l+R3qV3Vm/4AWRcWSCzMNkFvyTs8dMrJfsGbkeCxcX7s+Skn7muOody6a0cXZZQUOtkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774921736; c=relaxed/simple;
	bh=2Xe92bJA1IKCHmoyEgcN4DwhMlKFgwtLQv82yed622k=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=UFPxVf3jeXyYKkb0WH03fP8S/hMkQDRqUsgIKjwO3y5CUgMcSlI1ikJSxdfOjJecUrp/kxes2cfXfhPN/BZx0Ele6w/wuZ+0h8Enx95cS4J1LR3o8MXQmyLM0wubTRWDwSEX44EL7B6Y4R20RpxB8KVfjjjqsUSZmsrLS+k2JS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Xz53Arwz; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774921724; bh=KV1Z2bEMTctuQcZnl3dN2Va7/a85G/GZ/F/sFu+gDxM=;
	h=From:To:Cc:Subject:Date;
	b=Xz53ArwzKvYs8+r8urBYYJDWw31lauZlkqHPA2VV/4uHcTIwRR9CMvHrTKITc4acr
	 Q2EPBPt7kaGx74WlAVqxSO2y/834mQpgoiQm7V6cDCJWgXUWCcsbCKjFgFmYjHS/JS
	 WpnkSR2jpJ/qZbYmqbpjjSZAb9YC4kBwYfav/R+s=
Received: from June.localdomain ([123.121.145.35])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id C2884AC8; Tue, 31 Mar 2026 09:48:40 +0800
X-QQ-mid: xmsmtpt1774921720tspj4u9oa
Message-ID: <tencent_FAB2A00E105488F503DCC787B8060F881E06@qq.com>
X-QQ-XMAILINFO: OOyEews/EdUgJBTHzR+AvEpZ8QcrjB2Cid5WlwR2+xD2mMwIGk8pHXWe95ZKP0
	 ByummtbON/EBe8MQCrAZ49A/eicKRT3Ou1EhLGXLbsStOnHzW3U3dYNA9mcsmVq0xhmlzLk17uLk
	 pkZmpi/qgZlVpyQOKp3w9F7yDbphSnIJxi0sgcE1G3MGf+uS/Td3csMa6ft6vfukMGg1CDtvOwbo
	 pt3kR/+l+NUuseqGVDA+Npz9C/yvfIkt18PEFGrCNpnUu9Tj11zmTpzxzkoCoLdexx/LFDkfTDUz
	 mt70jR39+R9V7pmnEB4aW1gmEJGv3S1fzFYzF2/OmqVAXhw2VUFNpEhplhrXvR2gFhRVxnzJWONk
	 Xh51jWeA7HcsGaJ8VD5Ujb0U4F6Qt9wDUdRT3paExzTZRIb3c/5Z+ELlgluvh0/2wq0Yd4sHYUc6
	 aTJRpJ6S90ZTPFX6pj4E0lSoboj0OAg6IMvooMbZpo/DGTjWeeBegcn0FoyCC5XYuwYl+aKL5kon
	 uvMh1vYL5TPpi5UjHVe1n+3cngRhI++2B/uTz/tk+cKLVHZ7t6QNPcr9GuO/rM1budwWBE7G8qiu
	 S2Yd2oPoJ4xRVJd752qhpiJ3M3IMKGXhudZ4MYkckD6l/NG1cSOliBYOn4XVJJgYNQ+G/i6sN3Ef
	 aDSiFR3/svr2+Q+2I9oZCEDspdWX9SRCgTYpri7mwJyOTTqJs0Da3FT8OkqUsI5u53VtSjzKD8Af
	 zjR2P+hCo/gBirAQ5rXtRIzJzK1PP31K8O0gnaEqWfw7JRCkyxaqyLPrE8wvhH2JFhc2d2/gQpl8
	 a051xufIqNa5hizpwLS09xhVnsLBk8HFZOn4CCinPoHgQdsyheOsEmWXWQwn6cJ3rexRh7NWjINS
	 Diax0ELss/Y6OTjfX/CnjAnh/Kp1oC7aLxRhnxo37J0dk5NB8ei5AJWLtua5xIvg/9fIyxWmj2tI
	 udhf2d044q1GKRQDoe7nUTccgO+Qm26ADnsnr/ls7KbAJF+Tlv3zgDVBj7/GU8H10Q7ltk6cBeoR
	 +iom6uC7IdhqjqM4X1VxFTAY7h1zWlu8HcyA9Yhd2QK5KuY0IW2OJrGorA7RClOP7U7Jpcsg==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Wang Jun <1742789905@qq.com>
To: Jes Sorensen <jes@trained-monkey.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-acenic@sunsite.dk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gszhai@bjtu.edu.cn,
	25125332@bjtu.edu.cn,
	25125283@bjtu.edu.cn,
	23120469@bjtu.edu.cn,
	Wang Jun <1742789905@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: alteon: Add missing DMA mapping error checks in ace_start_xmit
Date: Tue, 31 Mar 2026 09:48:41 +0800
X-OQ-MSGID: <20260331014841.74420-1-1742789905@qq.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231310-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[sunsite.dk,vger.kernel.org,bjtu.edu.cn,qq.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1742789905@qq.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:dkim,qq.com:email,qq.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0541E363229
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ace_start_xmit function does not check the return value of
dma_map_page (via ace_map_tx_skb) and skb_frag_dma_map when building
transmit descriptors. If mapping fails, an invalid DMA address is
written to the descriptor, which may cause hardware to access
illegal memory, leading to system instability or crashes.

Add proper dma_mapping_error() checks for all mapping calls. When
mapping fails, free the skb, increment the dropped packet counter,
and return NETDEV_TX_OK.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Wang Jun <1742789905@qq.com>
---
 drivers/net/ethernet/alteon/acenic.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/alteon/acenic.c b/drivers/net/ethernet/alteon/acenic.c
index 455ee8930824..acabede53663 100644
--- a/drivers/net/ethernet/alteon/acenic.c
+++ b/drivers/net/ethernet/alteon/acenic.c
@@ -2417,6 +2417,11 @@ static netdev_tx_t ace_start_xmit(struct sk_buff *skb,
 		u32 vlan_tag = 0;
 
 		mapping = ace_map_tx_skb(ap, skb, skb, idx);
+		if (dma_mapping_error(&ap->pdev->dev, mapping)) {
+			dev_kfree_skb(skb);
+			dev->stats.tx_dropped++;
+			return NETDEV_TX_OK;
+		}
 		flagsize = (skb->len << 16) | (BD_FLG_END);
 		if (skb->ip_summed == CHECKSUM_PARTIAL)
 			flagsize |= BD_FLG_TCP_UDP_SUM;
@@ -2438,6 +2443,11 @@ static netdev_tx_t ace_start_xmit(struct sk_buff *skb,
 		int i;
 
 		mapping = ace_map_tx_skb(ap, skb, NULL, idx);
+		if (dma_mapping_error(&ap->pdev->dev, mapping)) {
+			dev_kfree_skb(skb);
+			dev->stats.tx_dropped++;
+			return NETDEV_TX_OK;
+		}
 		flagsize = (skb_headlen(skb) << 16);
 		if (skb->ip_summed == CHECKSUM_PARTIAL)
 			flagsize |= BD_FLG_TCP_UDP_SUM;
@@ -2460,6 +2470,11 @@ static netdev_tx_t ace_start_xmit(struct sk_buff *skb,
 			mapping = skb_frag_dma_map(&ap->pdev->dev, frag, 0,
 						   skb_frag_size(frag),
 						   DMA_TO_DEVICE);
+			if (dma_mapping_error(&ap->pdev->dev, mapping)) {
+				dev_kfree_skb(skb);
+				dev->stats.tx_dropped++;
+				return NETDEV_TX_OK;
+			}
 
 			flagsize = skb_frag_size(frag) << 16;
 			if (skb->ip_summed == CHECKSUM_PARTIAL)
-- 
2.43.0


