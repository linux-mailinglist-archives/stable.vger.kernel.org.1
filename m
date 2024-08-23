Return-Path: <stable+bounces-69975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4475E95CEB3
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785101C239BF
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742D818BB95;
	Fri, 23 Aug 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka0j3Zag"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28942188908;
	Fri, 23 Aug 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421712; cv=none; b=cUrJbYxyh7qjhqpRPOBCOYpBM9CI00DrjugXinCEgb+M7IrKlscMWXgR2AbtW3FjTjpWhbqX6znZ8+WuGiBwWO5riUaIR7PmfyyoL3rNO66MjZySsTtkoJ8562HiSrQvBaY0zRXr0pByR5vl58+FX552oKi99p3reFX3E7PpMhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421712; c=relaxed/simple;
	bh=jWxdGS6Ho7i95RPFxbGoVcjSq9BXFV6jYEQsxzcxvv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKr8O5cID/1WsyCBZ6eURW+p7D7QCLvUdECjbM7SAKBP53YkAgsdGT2r8yBirgSc9io/oJzWAWJHnf9Qp244v1cE1skCd1aY49M+8x3NuB8mLkHbFYEL6jGmtni56AH5Y+zb9Bc8tG/6I6QCAHhJk1j7FvHVdc9enAX3HXIxgZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ka0j3Zag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B891AC32786;
	Fri, 23 Aug 2024 14:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421712;
	bh=jWxdGS6Ho7i95RPFxbGoVcjSq9BXFV6jYEQsxzcxvv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ka0j3Zag9OePWf30l1FsQ6EyVlyyJfsUwRfBcO3nOOGWZzfApwCFn5I6R/SmiQ6Sq
	 m3LMv3I3E0GsV5N3LeWlZjCg83+qHZxMQcHT9TDvMaw7Ug4HxvyqwjSsJgOMLcvZj2
	 m04nLbjchVLNI8DxD8Ncv5WujKGiSLusCbCigdknJ91r9rbGidDhqcV+OBMVv0vghi
	 0XdaFN5FbyxxwURLzDfCNrcvykzAZkj3V5zYHuIE1XmoIZnm23gKEprCWT118fqRfq
	 lTljf3ZvzOTTh0PjfyqPwP/oN2s7NWaZQh5rVAYjtgmci0habcKmEL4rOqMlovs/GD
	 SOVUxkLFxgx0g==
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
Subject: [PATCH AUTOSEL 6.10 08/24] usbnet: ipheth: fix carrier detection in modes 1 and 4
Date: Fri, 23 Aug 2024 10:00:30 -0400
Message-ID: <20240823140121.1974012-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140121.1974012-1-sashal@kernel.org>
References: <20240823140121.1974012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.6
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
index cdc72559790a6..46afb95ffabe3 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -355,13 +355,14 @@ static int ipheth_carrier_set(struct ipheth_device *dev)
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


