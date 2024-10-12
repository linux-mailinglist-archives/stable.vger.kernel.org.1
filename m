Return-Path: <stable+bounces-83590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AEC99B474
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37F2AB23DDD
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCDF207A08;
	Sat, 12 Oct 2024 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAcDOLvX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE3E206E6F;
	Sat, 12 Oct 2024 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732615; cv=none; b=cKELY5L2Xg2V+3vSGbLdOtu93lFmQoQ+5unofhXiXQWgK+g1swe7zqXpmyZQPYrm4PNfeexkxNIMS8tm4u3oFUu7P7C5TaaObQ/3RdDHN1rsyFxWpdMlMbyytWkN4Rbf0PbM1wTSTdR1AmRUL30+Nv/74F0fpFCHCvTb00ttDs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732615; c=relaxed/simple;
	bh=Nb2BbHq+1efjpAn+GbZjGdJrBasAPm8DiOu7LApyvV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehOq16DV5+mG1xXn5BSyJUrQ+0dEfkbqdC06OfLmB7bYCUvffWi2SsTEijK74djHg/IOmrv060qNfLxmowuN2uuYSyuTStIG7+mElLPM6tJE828Z5+I92RPC0h96A0HIMfVUVc+ZD5POHg/TE33t9++6NzFnfYhia/cHqKqgxqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAcDOLvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349FBC4CEC6;
	Sat, 12 Oct 2024 11:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732615;
	bh=Nb2BbHq+1efjpAn+GbZjGdJrBasAPm8DiOu7LApyvV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gAcDOLvXge8ewaL0HgF+xwY2CY1vgB3nZo3QN/lnYPBEPpbOZRUajUgddl/yQOW5f
	 ug00INiCo5BZ1wRWetbxF7lZpL6Jm9Iyuf3m6n+LgGPZrbOvZ23Q8DpROTBG0ITa6t
	 wtpJ4U5KoHpgM+9XbazwptWE+okP5M0o7rgMXk98iiftOL/Lgd9fBhvWq+/9MJ1Mu4
	 t4v0dbvaOkyxBk/sur9leG76IvAeMe/V+eVnWtFU0RwBw/C4RkAg6RVH2RlyPWnCjv
	 caln5RSa4yZUO7MhxOX7/97tX6RDKzwOnvn/uB+/3z2RyNvf1VldlEMsTePIqx5Y9R
	 biHWrpvW+L7lg==
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
Subject: [PATCH AUTOSEL 4.19 2/6] usbnet: ipheth: fix carrier detection in modes 1 and 4
Date: Sat, 12 Oct 2024 07:29:59 -0400
Message-ID: <20241012113009.1764620-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012113009.1764620-1-sashal@kernel.org>
References: <20241012113009.1764620-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
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
index c762335587a43..43db0f37f1951 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -307,13 +307,14 @@ static int ipheth_carrier_set(struct ipheth_device *dev)
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


