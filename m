Return-Path: <stable+bounces-56829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B040924627
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8934C1C21982
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106361BE873;
	Tue,  2 Jul 2024 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zD5PvQbO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48A21BE85B;
	Tue,  2 Jul 2024 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941500; cv=none; b=eR1jFSLX3Zd9ob+yLJi/4UHF9kxuKM8h4UQZrdd4fJtmDsO9WsHMnuPGPwf1B6oVYy0ELR3VVJvgK1J9ndHdMXFerRqDhNEO5Bl5XjDyYVru6G91y+j9cS9GKAmBgp7iKd8u5wokENOryuDEtpg0vtVSpHv6HyrABK3f6UoOyJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941500; c=relaxed/simple;
	bh=xD1w9gCPf0dnC7Igbyu7dQ+kqI/fJ2ISRaUct7OMyfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=id+kVmPvp3lEEex75Wv4bqdS62ekuTDZqr54yYRZtL5HDjSTecvtDXf5KmJ22j874FHs+zDZ96QFFLUZwdpcPGYYGthxNY9wgQ0QOqAb73kQM8SqkELUm8cn/0pcLPHX2s3iAPuuRgW3thvexOv4FtLyHQJtqoOC39ZAqvRZD0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zD5PvQbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B63C4AF0D;
	Tue,  2 Jul 2024 17:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719941500;
	bh=xD1w9gCPf0dnC7Igbyu7dQ+kqI/fJ2ISRaUct7OMyfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zD5PvQbOa4LrtQKWMlYWvpk/GddcUSEZl9++VIKY3678E32+CBDiMV/aUc2NprTqC
	 xh5RFd6nLSB27Sh29GQQu1w3YgVAzzaIbMw5JEBnBj9r96waVYxXSVBF7Hf+a6kCTP
	 Moeb8KE5ahms8YG2YZ7iZKFY5WCXX8nHAqFYunyk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 082/128] net: usb: ax88179_178a: improve link status logs
Date: Tue,  2 Jul 2024 19:04:43 +0200
Message-ID: <20240702170229.326086943@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170226.231899085@linuxfoundation.org>
References: <20240702170226.231899085@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

commit 058722ee350c0bdd664e467156feb2bf5d9cc271 upstream.

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
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/ax88179_178a.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -326,7 +326,8 @@ static void ax88179_status(struct usbnet
 
 	if (netif_carrier_ok(dev->net) != link) {
 		usbnet_link_change(dev, link, 1);
-		netdev_info(dev->net, "ax88179 - Link status is: %d\n", link);
+		if (!link)
+			netdev_info(dev->net, "ax88179 - Link status is: 0\n");
 	}
 }
 
@@ -1540,6 +1541,7 @@ static int ax88179_link_reset(struct usb
 			 GMII_PHY_PHYSR, 2, &tmp16);
 
 	if (!(tmp16 & GMII_PHY_PHYSR_LINK)) {
+		netdev_info(dev->net, "ax88179 - Link status is: 0\n");
 		return 0;
 	} else if (GMII_PHY_PHYSR_GIGA == (tmp16 & GMII_PHY_PHYSR_SMASK)) {
 		mode |= AX_MEDIUM_GIGAMODE | AX_MEDIUM_EN_125MHZ;
@@ -1577,6 +1579,8 @@ static int ax88179_link_reset(struct usb
 
 	netif_carrier_on(dev->net);
 
+	netdev_info(dev->net, "ax88179 - Link status is: 1\n");
+
 	return 0;
 }
 



