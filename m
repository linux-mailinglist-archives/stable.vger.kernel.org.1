Return-Path: <stable+bounces-223172-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKqXFbEdqWlM2QAAu9opvQ
	(envelope-from <stable+bounces-223172-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 07:07:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A756620B1F9
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 07:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFA10303DACF
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 06:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AFE26738C;
	Thu,  5 Mar 2026 06:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NXZgrmKw"
X-Original-To: stable@vger.kernel.org
Received: from sg-1-100.ptr.blmpb.com (sg-1-100.ptr.blmpb.com [118.26.132.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F2726E702
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772690846; cv=none; b=bBvgljR60rVGW8NMOUyi22VSFYNIbz1Ac4rx+9o101+qgNMEZNuD42+ZV0w3/yMIpVM33hHJW6tQ0UsS7jGiXWPSKYn6qOC1auo/TVEhvuqeriTdLlLsBGqM5Nm/WDtkqk3sghC09D6JZZBJjCi7r57ui1K7BYl/GsBm7w5hPrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772690846; c=relaxed/simple;
	bh=VdK0MxFWy5AfGNYLihOKrAnjVOE1LOhw9JAhmBD1dcU=;
	h=Message-Id:Mime-Version:Content-Type:Date:Cc:Subject:From:To; b=XjWadKcTwaNi6BMLa/wQMpirTgjRzU9/T5Ywds+WqVk8J2HvHV02ms6PUJYxRxkTV8OrkRu9KNOE/Dh7IVMCaK0tLTW1GedmLk6TGZFfNq92uIrVTBokdE1Rk4+utWTPys/QSdbURlyWXqpQ+H7xnTUJZQK1tuWoiVtp8yYv8C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NXZgrmKw; arc=none smtp.client-ip=118.26.132.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1772690835; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=+xwQncdlXd0oSQ9jRHnvWwWoA100zQbea6T6LlMtF0Q=;
 b=NXZgrmKwQN9wuizvHU05yAhhsRoyb2M9tQdh0iH3XCmJ28gNYRdXrPuFr/jS1NnIn/hpu6
 a4FV9Em1vTV5S5Ekku+BE2pGEgF9aoNMtLifqtMaCwlQBq2lfYQdh1aEO3h3hkhPvOohLj
 uKaibpeyem92w9OMlGEgRRZuRJlw7WXmf27xgmH5KE9fq+62PXLG6wuxVXr48PlNqc5yHy
 wSTxFmbI+9yjKowz0IZFb29FAzOTuZb2A6OaLKTsys2aUmIIg/27PsNNOwKf5h2P2SZilG
 sQmjcMmpdMCTAIWDGN4XqddOFR/ylTr631idPE3o+vyCbNFJjGnvXUwW4aBn6g==
Message-Id: <20260305060656.3357250-1-zhangjian.3032@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu,  5 Mar 2026 14:06:55 +0800
X-Mailer: git-send-email 2.20.1
Cc: <stable@vger.kernel.org>
Subject: [PATCH net v2] net: ncsi: fix skb leak in error paths
Content-Transfer-Encoding: 7bit
From: "Jian Zhang" <zhangjian.3032@bytedance.com>
X-Lms-Return-Path: <lba+269a91d91+b45aba+vger.kernel.org+zhangjian.3032@bytedance.com>
X-Original-From: Jian Zhang <zhangjian.3032@bytedance.com>
To: "Samuel Mendoza-Jonas" <sam@mendozajonas.com>, 
	"Paul Fertser" <fercerpav@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, 
	"Joel Stanley" <joel@jms.id.au>, 
	"Gavin Shan" <gwshan@linux.vnet.ibm.com>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
X-Rspamd-Queue-Id: A756620B1F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[mendozajonas.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,jms.id.au,linux.vnet.ibm.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-223172-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[bytedance.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangjian.3032@bytedance.com,stable@vger.kernel.org];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,bytedance.com:server fail];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bytedance.com:dkim,bytedance.com:email,bytedance.com:mid]
X-Rspamd-Action: no action

Early return paths in NCSI RX and AEN handlers fail to release
the received skb, resulting in a memory leak.

Specifically, ncsi_aen_handler() returns on invalid AEN packets
without consuming the skb. Similarly, ncsi_rcv_rsp() exits early
when failing to resolve the NCSI device, response handler, or
request, leaving the skb unfreed.

CC: stable@vger.kernel.org
Fixes: 7a82ecf4cfb8 ("net/ncsi: NCSI AEN packet handler")
Fixes: 138635cc27c9 ("net/ncsi: NCSI response packet handler")
Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
---
Changes in v2:
- use meaningful label
- use kfree_skb to free skb in error paths
- add Fixes label

v1: https://lore.kernel.org/all/20260302054629.1347119-1-zhangjian.3032@bytedance.com/
---
 net/ncsi/ncsi-aen.c |  3 ++-
 net/ncsi/ncsi-rsp.c | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index 62fb1031763d..040a31557201 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -224,7 +224,8 @@ int ncsi_aen_handler(struct ncsi_dev_priv *ndp, struct sk_buff *skb)
 	if (!nah) {
 		netdev_warn(ndp->ndev.dev, "Invalid AEN (0x%x) received\n",
 			    h->type);
-		return -ENOENT;
+		ret = -ENOENT;
+		goto out;
 	}
 
 	ret = ncsi_validate_aen_pkt(h, nah->payload);
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 271ec6c3929e..fbd84bc8026a 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -1176,8 +1176,10 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 	/* Find the NCSI device */
 	nd = ncsi_find_dev(orig_dev);
 	ndp = nd ? TO_NCSI_DEV_PRIV(nd) : NULL;
-	if (!ndp)
-		return -ENODEV;
+	if (!ndp) {
+		ret = -ENODEV;
+		goto err_free_skb;
+	}
 
 	/* Check if it is AEN packet */
 	hdr = (struct ncsi_pkt_hdr *)skb_network_header(skb);
@@ -1199,7 +1201,8 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 	if (!nrh) {
 		netdev_err(nd->dev, "Received unrecognized packet (0x%x)\n",
 			   hdr->type);
-		return -ENOENT;
+		ret = -ENOENT;
+		goto err_free_skb;
 	}
 
 	/* Associate with the request */
@@ -1207,7 +1210,8 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 	nr = &ndp->requests[hdr->id];
 	if (!nr->used) {
 		spin_unlock_irqrestore(&ndp->lock, flags);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_free_skb;
 	}
 
 	nr->rsp = skb;
@@ -1261,4 +1265,8 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 out:
 	ncsi_free_request(nr);
 	return ret;
+
+err_free_skb:
+	kfree_skb(skb);
+	return ret;
 }
-- 
2.20.1

