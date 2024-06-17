Return-Path: <stable+bounces-52371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A724490AB28
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 12:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD8A2852EC
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 10:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1DF194133;
	Mon, 17 Jun 2024 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVMUsURy"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DA07173C
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718620460; cv=none; b=u9fJjUfyVmehVvgXAJd1tUO68DZPxFO6PS3fLrWpWJdtZWD1hkR7y6jLnj22m85Xt7XYRV6vkDNRciTm9Bq7l0foK5Hzu17mR1RG0oLgxwY5x/oUY3MvxBjZGv5XxTU0kMIdwP1fagNpBN71pcACxRFb6ohDoCtSHuUCCmRxp4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718620460; c=relaxed/simple;
	bh=edwklOwUpN3/khUTiztuvQHfcx/h8uxguvmkHBABe/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nymgztQua7E61/Ln/nrliW33DrCU/5EFy0ip3PxzG4cUFLUFHxcxUV/Wvpt/0Hct5dXQ2x9kgGaj2EM7xC79gO2gyYVCQr8n48n8Iv4ZE10ahy65KSROXrjMWAODMpmO7l7ANMmTXdSFiL242H+dv0lCGexiRBbQDpjxL+HP4QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QVMUsURy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718620458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NPi0Lc2x8pzbKbisJrHzDcJs/eDuRo98ZfsdasjbD/Q=;
	b=QVMUsURy7t1WabDpVPmrITyAt0pNeo0IOIGh8wbGRTwjYnjLgRZJwUZK+pds6CWza6ibav
	eX4Ui28nH70t7w5IfMA1qO/vAOsfzTL/vSo20ZNEjp56DNeOBQ0qZg4vaVijF51OkrO9xr
	EmgQwk1d/3VtI6gY63iVGCPtQmcb9QE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-5D80IxndOgKTTJc2QlToGQ-1; Mon,
 17 Jun 2024 06:34:15 -0400
X-MC-Unique: 5D80IxndOgKTTJc2QlToGQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8559D1956080;
	Mon, 17 Jun 2024 10:34:13 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.164])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9356919560AE;
	Mon, 17 Jun 2024 10:34:09 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jtornosm@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH] net: usb: ax88179_178a: improve link status logs
Date: Mon, 17 Jun 2024 12:33:59 +0200
Message-ID: <20240617103405.654567-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Avoid spurious link status logs that may ultimately be wrong; for example,
if the link is set to down with the cable plugged, then the cable is
unplugged and afer this the link is set to up, the last new log that is
appearing is incorrectly telling that the link is up.

In order to aovid errors, show link status logs after link_reset
processing, and in order to avoid spurious as much as possible, only show
the link loss when some link status change is detected.

cc: stable@vger.kernel.org
Fixes: e2ca90c276e1 ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/usb/ax88179_178a.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index c2fb736f78b2..60357796be99 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -326,7 +326,8 @@ static void ax88179_status(struct usbnet *dev, struct urb *urb)
 
 	if (netif_carrier_ok(dev->net) != link) {
 		usbnet_link_change(dev, link, 1);
-		netdev_info(dev->net, "ax88179 - Link status is: %d\n", link);
+		if (!link)
+			netdev_info(dev->net, "ax88179 - Link status is: %d\n", link);
 	}
 }
 
@@ -1542,6 +1543,7 @@ static int ax88179_link_reset(struct usbnet *dev)
 			 GMII_PHY_PHYSR, 2, &tmp16);
 
 	if (!(tmp16 & GMII_PHY_PHYSR_LINK)) {
+		netdev_info(dev->net, "ax88179 - Link status is: 0\n");
 		return 0;
 	} else if (GMII_PHY_PHYSR_GIGA == (tmp16 & GMII_PHY_PHYSR_SMASK)) {
 		mode |= AX_MEDIUM_GIGAMODE | AX_MEDIUM_EN_125MHZ;
@@ -1579,6 +1581,8 @@ static int ax88179_link_reset(struct usbnet *dev)
 
 	netif_carrier_on(dev->net);
 
+	netdev_info(dev->net, "ax88179 - Link status is: 1\n");
+
 	return 0;
 }
 
-- 
2.45.1


