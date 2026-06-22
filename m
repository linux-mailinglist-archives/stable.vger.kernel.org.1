Return-Path: <stable+bounces-267598-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LpnCBAm/OGr5hQcAu9opvQ
	(envelope-from <stable+bounces-267598-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 06:50:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5CD6ACA00
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 06:50:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=dbdQAUYH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267598-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267598-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B216C301DCF3
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 04:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9843537C8;
	Mon, 22 Jun 2026 04:50:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6952AE7A;
	Mon, 22 Jun 2026 04:50:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782103806; cv=none; b=r2AOkxOslb7ojmX1Ef+pzYMBr0jyAHtjGBQjP/MSTlrbgITirOpil0sDvcpSRdkWwm4WdYoq9tfZEGacMY7AK7gcl+2tF8JpmJ/SYXH4BuRSM27LpdMqK8QAbO+pFeGcGAr5oH8UIBmgENUauBw8NPsUmZBcftXV30QRtY6XK4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782103806; c=relaxed/simple;
	bh=MihYhHitBgIRq2skqdia1Bd6TDXpn4Qv1ik/XGT14Ag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=itu5MYzwHga6jLhe5jg1b6YElbjsjZsml2gi7prJgAbQs93LXPm3vdZdL9TQXrDDJs3nTOj98Yx16Fu1EbG4ch6zd1N7KT09YhvmqhCanKlmmTcxJF0QpPXjtdLvBSWAue/KADMkvAkDGI+Guip1lwU6hexnlDl0EP8R3KwRz44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dbdQAUYH; arc=none smtp.client-ip=117.135.210.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GZ
	tankCFaft2XhoUMoa3/uJleAp0j0bZd5291Kswe2s=; b=dbdQAUYHtpvRJw3/gh
	l0Z7i4uLD58dUcxGMtx75oZo2RteT4FjKNpngoi8QfG89Gi/zaSGHeHz+oQH9yzv
	OoPowWgRSAzNfEv6h+QGJM7M0NEJzXtxiprPbgXv+0Rw0qOSQ7RK+KgHUns+D0w6
	3bPeh/81y0O8BhXYpaz9rbyxg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3PvfLvjhq9IvzEw--.54790S2;
	Mon, 22 Jun 2026 12:49:17 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: meth: check skb allocation in meth_init_rx_ring()
Date: Mon, 22 Jun 2026 12:49:14 +0800
Message-Id: <20260622044914.664749-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3PvfLvjhq9IvzEw--.54790S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFykurWxWryUWF45Wr4fAFb_yoWDtwcE9r
	4j9rnaqa1DGF10ywsFyr47CryY9F95Zr95ZFsxKrZ3JFW2gr1Fqr1DurZ3Gry7Wr1rAFWD
	GFnxta12y34ftjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRN73kDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7g2L+Wo4vs16HwAA3V
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267598-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	FREEMAIL_FROM(0.00)[163.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C5CD6ACA00

meth_init_rx_ring() does not check the return value of alloc_skb().
If the allocation fails, the NULL skb is passed to skb_reserve() and
then dereferenced through skb->head.

Add check for alloc_skb() to prevent potential null pointer dereference.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/net/ethernet/sgi/meth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/sgi/meth.c b/drivers/net/ethernet/sgi/meth.c
index f7c3a5a766b7..ceff3cc937ad 100644
--- a/drivers/net/ethernet/sgi/meth.c
+++ b/drivers/net/ethernet/sgi/meth.c
@@ -228,6 +228,9 @@ static int meth_init_rx_ring(struct meth_private *priv)
 
 	for (i = 0; i < RX_RING_ENTRIES; i++) {
 		priv->rx_skbs[i] = alloc_skb(METH_RX_BUFF_SIZE, 0);
+		if (!priv->rx_skbs[i])
+			return -ENOMEM;
+
 		/* 8byte status vector + 3quad padding + 2byte padding,
 		 * to put data on 64bit aligned boundary */
 		skb_reserve(priv->rx_skbs[i],METH_RX_HEAD);
-- 
2.25.1


