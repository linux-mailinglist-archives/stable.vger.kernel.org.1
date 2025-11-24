Return-Path: <stable+bounces-196786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A36C8235D
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 20:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240293AD9C3
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 19:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B852431A578;
	Mon, 24 Nov 2025 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/cX9XdH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ECF31A54C
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764010643; cv=none; b=bXN7chm1cFBBoOsgUUp7Cz58xS8G+RBFEXkI2OHl+ePC1gPA2f5lJGddjelkIdhIl8QpbvRD5tchwmuDkfQJg3nQSIsN41dGPLjpeMzxu4ZWRF7Z0CZu7DZceVeYOuCDIA1nOhCddWuMl4d6I4A+tKB4N3reSwfBJJkBk2DwW7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764010643; c=relaxed/simple;
	bh=d9PYYdTG3FEmQXCVKWqT+YYZcI9KCd8i14UrKrQBe04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYKW3iZ5WKK6FhInY69y8n9amQA44QGit8Ih2kj5OskmweWGXWAffl1/zuST3mBzM7xJCXiJdg88kcWIr1OayEvg+XGBUHLwXZ/vyJ8N5Q9MDBOUMBbHPvPxkw+Nmw9l4sSPnGlhUctLkIG2UAvvyaL+RAsLdO7jmcA+Q98ay7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/cX9XdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1BBC4AF49;
	Mon, 24 Nov 2025 18:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764010643;
	bh=d9PYYdTG3FEmQXCVKWqT+YYZcI9KCd8i14UrKrQBe04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/cX9XdHyMicnezP+JddtZCroaLE8d8OXX3q3hvt6WA7d7JcS4m2K0Cw5hylIudjj
	 kjSX6mlilAyALdpT+HRhLWKcHfwzbCb+p7sZsvhqfGth+EXATIiQVe3pAK1mefy03p
	 rfBsrTdRQj5Nof62CjIOXNeTNGTqVQufUD7MAgPcBNXakBNDgrzU+q6S1xMduoUCWQ
	 5wh2mr7IWE98JglYqD39clophLxo4J2eGw/CuT7BYgEU6Z89QgijgIczUPaoIpzvWd
	 kfgYvhuRYvhFWPs8OJlRAIY7i0Y9HEJYiWPZBGky4WJxMQyFrlsJX3ATFs8n1e0Irw
	 HE8JBevlrvnAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] Input: pegasus-notetaker - fix potential out-of-bounds access
Date: Mon, 24 Nov 2025 13:57:18 -0500
Message-ID: <20251124185718.4192041-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124185718.4192041-1-sashal@kernel.org>
References: <2025112420-cleaver-backlight-0d73@gregkh>
 <20251124185718.4192041-1-sashal@kernel.org>
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


