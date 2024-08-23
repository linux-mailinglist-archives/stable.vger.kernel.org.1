Return-Path: <stable+bounces-70044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E70F95CF98
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F661C22641
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819031AD9ED;
	Fri, 23 Aug 2024 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj8rUKR6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB2E1AD9DD;
	Fri, 23 Aug 2024 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421978; cv=none; b=qIiiau7MOAWzUXDpcwBgSL5ji90VLR4W2c7Uw21OMidcFfGDBR/iZdjJ1XcYJ4pYTGhWP3e7mPAKMPTtfkMi4iudk9F2Cx8hdguhr5NXJOGZqlza3wQP2POYNzKPGzoZfOKRnqWoB6ItkF9tLEFfrW2S6K3H8QBYQ2RJen/NaVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421978; c=relaxed/simple;
	bh=Es2J6zvyjI79XtLDSAe+sm1UQjMf40YO7hZ6YjWQ2SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4BKoi45+luIJOBZSsAsCv1WBTOceq950zZpszOkn58Cv2+3S80dsvchysPcs2E5iByZWWht+psqs7vQoR82hz78CbSULQ6UvMmJqohpiVbZj5xR9oO+RTq3qKthmFi6YBxajfjoPyKQU2EcPDw7FratTFQ93uhEfM0D8/NNhfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj8rUKR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0C8C4AF09;
	Fri, 23 Aug 2024 14:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421978;
	bh=Es2J6zvyjI79XtLDSAe+sm1UQjMf40YO7hZ6YjWQ2SM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fj8rUKR6N2J1XK3/hhsszp18F2R0FF/Jja9Tlk7UBxYrVNvwTiFzMXhqQ4+CxNUBR
	 m9jtxZSxPMqsQgJp4MDB4QcZr7EJJksY2Ol+adHf5HkAU/Y0SZwv5sRtQlG3ClUHjl
	 OANbfAsv+P9BYfzIBzDF+DbO25qaNmzGDJMCeJHYYCCb3/scIMRj/8CSZUqe/+gAqx
	 fOE8u7a1KYBUKiW2pwaUOyusV/oJhSc2JDP6VBFUxnRICXSszZ/lUHpAAytdZfAm5y
	 h/27KlD7+K30EMCbyT1iUcBwYwkLIhTR1HOCYkkjJVz+ZKh6ZOkdBL0A5DCXxAmm6W
	 Tl+dOvglkCrVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Foster Snowhill <forst@pen.gy>,
	Georgi Valkov <gvalkov@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	oneukum@suse.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/7] usbnet: ipheth: fix carrier detection in modes 1 and 4
Date: Fri, 23 Aug 2024 10:05:57 -0400
Message-ID: <20240823140611.1975950-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140611.1975950-1-sashal@kernel.org>
References: <20240823140611.1975950-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.282
Content-Transfer-Encoding: 8bit

From: Foster Snowhill <forst@pen.gy>

[ Upstream commit 67927a1b255d883881be9467508e0af9a5e0be9d ]

Apart from the standard "configurations", "interfaces" and "alternate
interface settings" in USB, iOS devices also have a notion of
"modes". In different modes, the device exposes a different set of
available configurations.

Depending on the iOS version, and depending on the current mode, the
length and contents of the carrier state control message differs:

* 1 byte (seen on iOS 4.2.1, 8.4):
    * 03: carrier off (mode 0)
    * 04: carrier on (mode 0)
* 3 bytes (seen on iOS 10.3.4, 15.7.6):
    * 03 03 03: carrier off (mode 0)
    * 04 04 03: carrier on (mode 0)
* 4 bytes (seen on iOS 16.5, 17.6):
    * 03 03 03 00: carrier off (mode 0)
    * 04 03 03 00: carrier off (mode 1)
    * 06 03 03 00: carrier off (mode 4)
    * 04 04 03 04: carrier on (mode 0 and 1)
    * 06 04 03 04: carrier on (mode 4)

Before this change, the driver always used the first byte of the
response to determine carrier state.

From this larger sample, the first byte seems to indicate the number of
available USB configurations in the current mode (with the exception of
the default mode 0), and in some cases (namely mode 1 and 4) does not
correlate with the carrier state.

Previous logic erroneously counted `04 03 03 00` as "carrier on" and
`06 04 03 04` as "carrier off" on iOS versions that support mode 1 and
mode 4 respectively.

Only modes 0, 1 and 4 expose the USB Ethernet interfaces necessary for
the ipheth driver.

Check the second byte of the control message where possible, and fall
back to checking the first byte on older iOS versions.

Signed-off-by: Foster Snowhill <forst@pen.gy>
Tested-by: Georgi Valkov <gvalkov@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/ipheth.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 7814856636907..c7495227545bb 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -253,13 +253,14 @@ static int ipheth_carrier_set(struct ipheth_device *dev)
 			0x02, /* index */
 			dev->ctrl_buf, IPHETH_CTRL_BUF_SIZE,
 			IPHETH_CTRL_TIMEOUT);
-	if (retval < 0) {
+	if (retval <= 0) {
 		dev_err(&dev->intf->dev, "%s: usb_control_msg: %d\n",
 			__func__, retval);
 		return retval;
 	}
 
-	if (dev->ctrl_buf[0] == IPHETH_CARRIER_ON) {
+	if ((retval == 1 && dev->ctrl_buf[0] == IPHETH_CARRIER_ON) ||
+	    (retval >= 2 && dev->ctrl_buf[1] == IPHETH_CARRIER_ON)) {
 		netif_carrier_on(dev->net);
 		if (dev->tx_urb->status != -EINPROGRESS)
 			netif_wake_queue(dev->net);
-- 
2.43.0


