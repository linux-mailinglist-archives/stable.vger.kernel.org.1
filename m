Return-Path: <stable+bounces-70026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2150095CF5E
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406E51C229C0
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3CE1A2557;
	Fri, 23 Aug 2024 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGSoXozg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070FC188924;
	Fri, 23 Aug 2024 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421914; cv=none; b=ETgJqdTFm+1JVcHDtSYLGgPkFOktSaCSO2edkY89V45I+TGKiPnL/C0ksF64sVjOQQKd8xAV1c2ktaD+PW5WNB3tBvXCnwbO9TOQl1AN7+qixZwXkCQB0bsrMu/zy4iLrkq7lVRVZbAC8/I7qL6YkyCN2Xzlekub2ejmN+w4C7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421914; c=relaxed/simple;
	bh=K17i9zqYDdlPyHRrJSywueLiLlfemqOR+11rDSGc2w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POHlgiemVAiTLpj9awzQRW1waDnWyDH2/axIh5AwqeJUjzbJHTgDRT69AVajDVeGt4DjepoHKMR03Rjqp8yhGMOHO8aIhgIj/s+tklLXq1/JzPRLGGVUTaLo5yL1S1hdOJ1EDHXhq6qOAKo8k/IjwH7jFn55M1Z891nH041WQ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGSoXozg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50738C4AF0B;
	Fri, 23 Aug 2024 14:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421913;
	bh=K17i9zqYDdlPyHRrJSywueLiLlfemqOR+11rDSGc2w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NGSoXozgmIac5fKwZSsUciukeQgMlDBaZSrepdme5ULPVm5+vxPejDPGp+pvRNiaZ
	 OlYPv4H9duIWs8W81s8sycWpoXK+17nERpRFT5EzqzghNwwNmeJpZf3rcAgppsduE1
	 IZiT0e7qZPKjoKrkZBfEJ7ri27ZTi99GEFLC5jDHlLzVbNHWf4jXi97okM4PgYciG1
	 HzzIrELHvzgJwevd2IZ7Z/FYCKCiOD+lpM3cuUWDX3/i89OklZq4t8OLxsAJGJZP/3
	 6oDDLr5QUKgzG4vm56AYw/UYJyv4aWlFjbxZ7Msm1so3mbEhzZrfJHsp4bDebx5q2f
	 v4ytGVVBdolog==
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
Subject: [PATCH AUTOSEL 5.15 2/9] usbnet: ipheth: fix carrier detection in modes 1 and 4
Date: Fri, 23 Aug 2024 10:04:49 -0400
Message-ID: <20240823140507.1975524-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140507.1975524-1-sashal@kernel.org>
References: <20240823140507.1975524-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.165
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
index 4485388dcff2e..bb3d4c5dadfc7 100644
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


