Return-Path: <stable+bounces-196782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0159C82205
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 19:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB03434A666
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 18:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A8131A04F;
	Mon, 24 Nov 2025 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJjDaYH0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DE831985C
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764009483; cv=none; b=YNIFyyr6izP2CD/OlqqSBD1j+yAQZkKUZBSzIdnHTaxlN9wax6Y+BT40dvE6sVWADBdU2qj1nTOJfw1biBzdDuE16p1QRnaiHXVE671ktjqPsxQFSdHCPKydPPw7G9B1Fe8SU8s+N88AKnPP2DKF9y7trN7WS+sBvMMJXUXy2Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764009483; c=relaxed/simple;
	bh=d9PYYdTG3FEmQXCVKWqT+YYZcI9KCd8i14UrKrQBe04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVJuZvQ8thBUxsRBzM99B7Y4yizadlLF13SnZ4GKkxm/WSmklfvF0JOBkgGY1AoctWB+xSLXpJcJBDOm5zGbIJLseZAu69o3nKdf++H+t5gs+3p8bggx+BQ3KZ2Mzr4uTEh3QK2U2m5gIHVSdyp4a1WDE361IJI1zeeV5sMbKzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJjDaYH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B00C19422;
	Mon, 24 Nov 2025 18:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764009482;
	bh=d9PYYdTG3FEmQXCVKWqT+YYZcI9KCd8i14UrKrQBe04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rJjDaYH0n0dCXP3qL3flTrvuB0WaSRXMkeG3e0b5zyQtm/d2AsesyKQYHdJZEciHY
	 8lugjSF+qU52kWOQQvDQmmSJMgv94tF03gUiLRI1sSRprrDCeKyCD5qo0XswNIXb58
	 7kWVe67SvNG0JVCmreh1T+x6nm+cQtKVnyotnBLSTOKIMiS5Drno0RjDHzsNMYFv5y
	 nqrm1R1eo2ElZjCEguwnEcF2h1B7tsqMXBFqLjSs3dfZvscmksz5tGa9e04y4p8Auf
	 B2qDKaL4A5cZpwucsEQEJ2+MO5+5PHRf+jN1jAj//oxuZEZCHyO5E5E8kZrZXhgiXw
	 PQukFlPb2s+3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] Input: pegasus-notetaker - fix potential out-of-bounds access
Date: Mon, 24 Nov 2025 13:37:58 -0500
Message-ID: <20251124183758.4187087-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124183758.4187087-1-sashal@kernel.org>
References: <2025112419-scariness-motive-d737@gregkh>
 <20251124183758.4187087-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

[ Upstream commit 69aeb507312306f73495598a055293fa749d454e ]

In the pegasus_notetaker driver, the pegasus_probe() function allocates
the URB transfer buffer using the wMaxPacketSize value from
the endpoint descriptor. An attacker can use a malicious USB descriptor
to force the allocation of a very small buffer.

Subsequently, if the device sends an interrupt packet with a specific
pattern (e.g., where the first byte is 0x80 or 0x42),
the pegasus_parse_packet() function parses the packet without checking
the allocated buffer size. This leads to an out-of-bounds memory access.

Fixes: 1afca2b66aac ("Input: add Pegasus Notetaker tablet driver")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
Link: https://lore.kernel.org/r/20251007214131.3737115-2-eeodqql09@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/tablet/pegasus_notetaker.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index c608ac505d1ba..b2be4b87bfbe9 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -63,6 +63,9 @@
 #define BUTTON_PRESSED			0xb5
 #define COMMAND_VERSION			0xa9
 
+/* 1 Status + 1 Color + 2 X + 2 Y = 6 bytes */
+#define NOTETAKER_PACKET_SIZE		6
+
 /* in xy data packet */
 #define BATTERY_NO_REPORT		0x40
 #define BATTERY_LOW			0x41
@@ -297,6 +300,12 @@ static int pegasus_probe(struct usb_interface *intf,
 
 	pipe = usb_rcvintpipe(dev, endpoint->bEndpointAddress);
 	pegasus->data_len = usb_maxpacket(dev, pipe);
+	if (pegasus->data_len < NOTETAKER_PACKET_SIZE) {
+		dev_err(&intf->dev, "packet size is too small (%d)\n",
+			pegasus->data_len);
+		error = -EINVAL;
+		goto err_free_mem;
+	}
 
 	pegasus->data = usb_alloc_coherent(dev, pegasus->data_len, GFP_KERNEL,
 					   &pegasus->data_dma);
-- 
2.51.0


