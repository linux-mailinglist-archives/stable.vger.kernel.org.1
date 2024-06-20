Return-Path: <stable+bounces-54718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEA2910644
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 15:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62992285476
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 13:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA151AE0AC;
	Thu, 20 Jun 2024 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHKelSwa"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885A61AE0AD
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890494; cv=none; b=r9pyG/mRUE2zy0k8T1xEM9ydEqaa3PT0NuAbfli6dT/zQ9J1gvQau4xpNqDsyXvx5BMjsD823SUORNMYbf/vikATFflfgPs9swwXVMqOgF5OyOqF1TQz8ZH0Jyp5NkYY7Umo2wixcfWN4rCbPCEE835zJw21ZGIHRYVd+NS0BK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890494; c=relaxed/simple;
	bh=Njjq6gWZ1RniPhVTD4fsI1ZonK0a/YGk1tsEsH4AL2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GYRKsfdCUQTiUe02JhR/oqCoonI3B8yUUx148LJawxfu/fUs3aFYxSwckNg/inNERQa2JqveOgK5QNeqIN/rrwdFJ8M4o1M0IltFBk4UCMskDVoW+2rm+lyUcUysSYAi+kAybxbHl+G4ZGvvwequF2+2aIE4PA/cYJliOiwnRho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JHKelSwa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718890491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rp2JJ5EfDeQKcGdQd+pvP1QoDtSuq6Czg3J9GG7cfMk=;
	b=JHKelSwarC77WTXTiNk9cOHph4/WdPnAohA1SFvuvYqzXkd7rqftFPnUwkxVmOItJTGPPt
	lypQ37VLOSQteLdOoVq6hUS6JrFatgzWbKRUC8zCDqgbK4bVNdBTIlfGW5BCJSkfsZM1wk
	p72niHSSFRIuM4to+XLJzdODz8K2cjs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-92sGqPXVMHW72ZfF7W5c2Q-1; Thu,
 20 Jun 2024 09:34:48 -0400
X-MC-Unique: 92sGqPXVMHW72ZfF7W5c2Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E62319560A3;
	Thu, 20 Jun 2024 13:34:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.104])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C4E319560AF;
	Thu, 20 Jun 2024 13:34:42 +0000 (UTC)
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
Subject: [PATCH net v3] net: usb: ax88179_178a: improve link status logs
Date: Thu, 20 Jun 2024 15:34:31 +0200
Message-ID: <20240620133439.102296-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Avoid spurious link status logs that may ultimately be wrong; for example,
if the link is set to down with the cable plugged, then the cable is
unplugged and after this the link is set to up, the last new log that is
appearing is incorrectly telling that the link is up.

In order to avoid errors, show link status logs after link_reset
processing, and in order to avoid spurious as much as possible, only show
the link loss when some link status change is detected.

cc: stable@vger.kernel.org
Fixes: e2ca90c276e1 ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v3:
  - Add net as target tree in the subject.
  - Use constant string instead of variable because no other value is possible.
v2: https://lore.kernel.org/netdev/20240618115054.101577-1-jtornosm@redhat.com/
  - Fix the nits
v1: https://lore.kernel.org/netdev/20240617103405.654567-1-jtornosm@redhat.com/

 drivers/net/usb/ax88179_178a.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index c2fb736f78b2..b034ef8a73ea 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -326,7 +326,8 @@ static void ax88179_status(struct usbnet *dev, struct urb *urb)
 
 	if (netif_carrier_ok(dev->net) != link) {
 		usbnet_link_change(dev, link, 1);
-		netdev_info(dev->net, "ax88179 - Link status is: %d\n", link);
+		if (!link)
+			netdev_info(dev->net, "ax88179 - Link status is: 0\n");
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


