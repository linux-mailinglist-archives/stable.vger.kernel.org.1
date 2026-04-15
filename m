Return-Path: <stable+bounces-238233-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOG2Gw8b4Gm3cgAAu9opvQ
	(envelope-from <stable+bounces-238233-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 01:11:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F453408CD8
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 01:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18ECC3100775
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 23:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679933932C2;
	Wed, 15 Apr 2026 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Pd8lBd43"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA62386428;
	Wed, 15 Apr 2026 23:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776294640; cv=none; b=jPJSEfSJs+vwjK+Z+MasOzM/P7FT+yjX+i87QwhRf++MJiZUvtb+Z6DckkxAMfBiEkGNcdaYY3RM11Vy/SKBLrzbyMGMWRflDMKjGD+XzVAaJ3ydfpo394v/GGr1vxDkvUTah67peGsLO0F/BdM6uHq9crfir4mUu83PlRV+GBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776294640; c=relaxed/simple;
	bh=1vX5Nf8nVSLCHfIZmp0Dp274peJGW6rXdzrkcnJj11k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJcCBtmuIpboRCSqEHVhvqwAZMVHMC9qY770L0+pgkL3zxIIdRiFKSkPyfmnzdClv8zIO5TdtIDybW3hBtkCaIxKF4CWv1NUdV9Y3JpTzrB1wf5otL4vXlUXYv6pXFTj+z/Vi6n1vayi1P32FWQVKIyoJk5f30/mDvtS0TtkJtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Pd8lBd43; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50944113F5D;
	Thu, 16 Apr 2026 01:10:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776294630; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=lv+bx+kmxOmu38ISk0zfCOIzdtCopAFmqK83omwzikQ=;
	b=Pd8lBd430kyqw3v9Ow4eyH0WLz/WUTfmg+EdsTKQPFbBhmCKJCVqEck6/mBHXxW0NIpDIj
	QU+MRymb/Es1vY3GhGIWBEyEDsMtGZWBRHIdo4xpEGkrv2c/9xP4CoxOgRlEvIC6RURfJE
	1JL3/ZaolIW7oHKfrGNMJ4TZiNDXODYZY8oQ0x94mrKU70RVjMvbiqtz5RK/LrLAOrsBPV
	xXBydYxWA4flSJXDaBtC332gEknzQJvdQRoEStWKgMeSfNKM0i75nxC3jAix6qkwkLD1pB
	ZdlnlZPblGGN5vyEK5lYjVdt82iYCqITa3Zei28kE7cdU5tDRdJdqq0yHrEC4Q==
From: Marek Vasut <marex@nabladev.com>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Yicong Hui <yiconghui@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [net,PATCH v4 2/2] net: ks8851: Avoid excess softirq scheduling
Date: Thu, 16 Apr 2026 01:09:45 +0200
Message-ID: <20260415231020.455298-2-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415231020.455298-1-marex@nabladev.com>
References: <20260415231020.455298-1-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238233-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nabladev.com,linutronix.de,vger.kernel.org,davemloft.net,lunn.ch,google.com,kernel.org,tipi-net.de,redhat.com,raritan.com,gmail.com];
	DKIM_TRACE(0.00)[nabladev.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[raritan.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nabladev.com:email,nabladev.com:dkim,nabladev.com:mid,davemloft.net:email,linutronix.de:email]
X-Rspamd-Queue-Id: 0F453408CD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The code injects a packet into netif_rx() repeatedly, which will add
it to its internal NAPI and schedule a softirq, and process it. It is
more efficient to queue multiple packets and process them all at the
local_bh_enable() time.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Fixes: e0863634bf9f ("net: ks8851: Queue RX packets in IRQ handler instead of disabling BHs")
Cc: stable@vger.kernel.org
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Ronald Wahl <ronald.wahl@raritan.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Yicong Hui <yiconghui@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V3: New patch
V4: Add RB from Sebastian
---
 drivers/net/ethernet/micrel/ks8851_common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index 6c375647b24de..4afbb40bc0e4a 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -373,9 +373,12 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	if (status & IRQ_LCI)
 		mii_check_link(&ks->mii);
 
-	if (status & IRQ_RXI)
+	if (status & IRQ_RXI) {
+		local_bh_disable();
 		while ((skb = __skb_dequeue(&rxq)))
 			netif_rx(skb);
+		local_bh_enable();
+	}
 
 	return IRQ_HANDLED;
 }
-- 
2.53.0


