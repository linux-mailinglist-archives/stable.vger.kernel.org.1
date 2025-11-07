Return-Path: <stable+bounces-192681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5032CC3E68A
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 05:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84EA03A9F1E
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 04:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F202A28750F;
	Fri,  7 Nov 2025 04:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="0C0Fsenp"
X-Original-To: stable@vger.kernel.org
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CA2214A97
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 04:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762488137; cv=none; b=SS+DIMoZbURn40jeUIbiImk6bgV5zJSY7h+JwgZjx8JLZKCz03m9Qdfm5afBL4jo0b51qtExM/oD31gYEIx8GmcnsvmbJgDtTHgrrD/UsSsRbxUxZ6RtfMpkD6oQiHckeltpahualftetljorb/zlANtaeRs+W0XOhbxkuSVyvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762488137; c=relaxed/simple;
	bh=UUuenMYg9ocxnpNEOQdv6RBX2DzfhgqPqQJHBfqyat0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QeytVJigQHrbtdrAk4Elno8HDU8WjzRfiEPAPpct1Y9xnoamwXudOEHNauw0H1N9zV5UO8pTYrAjQFUvlGurWEjLKklN3G8C+Mg5MHfQgtmZZuf2Yc0N9cUtWuJuxR42CPqEAN2eS9jujZ5R+QbfLpybTUtIzx21pvdiEdxjT44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=0C0Fsenp; arc=none smtp.client-ip=120.232.169.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=0C0FsenpEofFHcagG9lqooB1qz3rWBgCbz2sHhvzHg5agiJmzFin1YCK1CwuH8aR5MPf5T176D5ai
	 Nv/NqJ+5HGmZY19nwsG0A45eo1qq40LC6Q1STVa24erwhaYVauqleL5X9aZQZI02UiQh/ya8Ju86k5
	 QoxGsQMatMJtHDQY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[117.129.7.61])
	by rmsmtp-lg-appmail-19-12022 (RichMail) with SMTP id 2ef6690d6e850fa-47440;
	Fri, 07 Nov 2025 11:59:03 +0800 (CST)
X-RM-TRANSID:2ef6690d6e850fa-47440
From: Rajani Kantha <681739313@139.com>
To: dsahern@kernel.org,
	wangliang74@huawei.com,
	horms@kernel.org,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6.y] net: fix NULL pointer dereference in l3mdev_l3_rcv
Date: Fri,  7 Nov 2025 11:59:02 +0800
Message-Id: <20251107035902.3695-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Wang Liang <wangliang74@huawei.com>

[ Upstream commit 0032c99e83b9ce6d5995d65900aa4b6ffb501cce ]

When delete l3s ipvlan:

    ip link del link eth0 ipvlan1 type ipvlan mode l3s

This may cause a null pointer dereference:

    Call trace:
     ip_rcv_finish+0x48/0xd0
     ip_rcv+0x5c/0x100
     __netif_receive_skb_one_core+0x64/0xb0
     __netif_receive_skb+0x20/0x80
     process_backlog+0xb4/0x204
     napi_poll+0xe8/0x294
     net_rx_action+0xd8/0x22c
     __do_softirq+0x12c/0x354

This is because l3mdev_l3_rcv() visit dev->l3mdev_ops after
ipvlan_l3s_unregister() assign the dev->l3mdev_ops to NULL. The process
like this:

    (CPU1)                     | (CPU2)
    l3mdev_l3_rcv()            |
      check dev->priv_flags:   |
        master = skb->dev;     |
                               |
                               | ipvlan_l3s_unregister()
                               |   set dev->priv_flags
                               |   dev->l3mdev_ops = NULL;
                               |
      visit master->l3mdev_ops |

To avoid this by do not set dev->l3mdev_ops when unregister l3s ipvlan.

Suggested-by: David Ahern <dsahern@kernel.org>
Fixes: c675e06a98a4 ("ipvlan: decouple l3s mode dependencies from other modes")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250321090353.1170545-1-wangliang74@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 drivers/net/ipvlan/ipvlan_l3s.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ipvlan/ipvlan_l3s.c b/drivers/net/ipvlan/ipvlan_l3s.c
index d5b05e803219..ca35a50bb640 100644
--- a/drivers/net/ipvlan/ipvlan_l3s.c
+++ b/drivers/net/ipvlan/ipvlan_l3s.c
@@ -224,5 +224,4 @@ void ipvlan_l3s_unregister(struct ipvl_port *port)
 
 	dev->priv_flags &= ~IFF_L3MDEV_RX_HANDLER;
 	ipvlan_unregister_nf_hook(read_pnet(&port->pnet));
-	dev->l3mdev_ops = NULL;
 }
-- 
2.17.1



