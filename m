Return-Path: <stable+bounces-189033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EBABFE06B
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 21:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC9E3A4E32
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 19:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3802FD699;
	Wed, 22 Oct 2025 19:27:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B8B2DECAA
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161272; cv=none; b=lFrV8VDrPTp+iJzwwLe8Fivuf6Ovop7yK9+PIaUWYpcXCzOZFykMOzunL/ccFWTBnn0mBDd4xF9DBNkpttDPdSXNGGSkCAO0kY7NXEaztYkKDN8hN5sPAk+JYCQD+HWic81+juTD7PnV22QRal3XixNXZgGOon3cmi/Bpk2eFvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161272; c=relaxed/simple;
	bh=gYQTLK82fnwN0e8FQXe4nfrbjt3VRNZg6J4PZMkOgtc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VuTnHSwwaG7f/EJgtKgmZ6Qs/ubK7ce8R+eT/uJSlzU1yn0ROrkRIfX6WPrVyCwNVzoH0PV8hKJcvQOCnwJuU40noGtU9PwnI4tUKIE/53dWBYRfaJD+3QB5Rn1haD1jCwRLlWJfgrfnKu6Vly25fSh77c1ePMOr1ukWQZWVds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 48E4523373;
	Wed, 22 Oct 2025 22:27:44 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10.y] firewire: net: fix use after free in fwnet_finish_incoming_packet()
Date: Wed, 22 Oct 2025 22:27:41 +0300
Message-Id: <20251022192741.212975-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Shurong <zhang_shurong@foxmail.com>

commit 3ff256751a2853e1ffaa36958ff933ccc98c6cb5 upstream.

The netif_rx() function frees the skb so we can't dereference it to
save the skb->len.

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Link: https://lore.kernel.org/r/tencent_3B3D24B66ED66A6BB73CC0E63C6A14E45109@qq.com
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
[ kovalev: bp to fix CVE-2023-53432 ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/firewire/net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/net.c b/drivers/firewire/net.c
index 715e491dfbc3..8504e95ede90 100644
--- a/drivers/firewire/net.c
+++ b/drivers/firewire/net.c
@@ -489,7 +489,7 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 					bool is_broadcast, u16 ether_type)
 {
 	struct fwnet_device *dev;
-	int status;
+	int status, len;
 	__be64 guid;
 
 	switch (ether_type) {
@@ -546,13 +546,15 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 		}
 		skb->protocol = protocol;
 	}
+
+	len = skb->len;
 	status = netif_rx(skb);
 	if (status == NET_RX_DROP) {
 		net->stats.rx_errors++;
 		net->stats.rx_dropped++;
 	} else {
 		net->stats.rx_packets++;
-		net->stats.rx_bytes += skb->len;
+		net->stats.rx_bytes += len;
 	}
 
 	return 0;
-- 
2.50.1


