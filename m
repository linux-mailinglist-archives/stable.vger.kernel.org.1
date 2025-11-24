Return-Path: <stable+bounces-196793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53142C824B4
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 20:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3C414E7FDF
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 19:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5382D77E5;
	Mon, 24 Nov 2025 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5Q128Ju"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB26929E112
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764012052; cv=none; b=AbzbHK7FK0DuAlEofoE0RVpss+8mByzF2WjRM+kdkfPpCmyF1n67ltoSbz1PG+nHQvuNbOIA/wLNWba2Gu7U2ePPEkbwo8ImmS72yg/0zPXQ0hrpcd8oy8wrEjjADwAVROnLpAxrxPcWFiCf5lqPRf+DjPMr38isFJKok2LQmPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764012052; c=relaxed/simple;
	bh=E2JOMDEr8z+GMmz/BATIesSjQcVM1L0IzGNQ0lQeT4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=er0ZqGzRiFG2/ca/ZpcZgwLhTL8vqVkxoy8UEJ8r3jHWDGkt1Mz/b91Tsa5fEjok1aT6IgwSDVaxoo9DgYQG/bYf4x7lZnsiRmW+aFOqT9PPvs6WZfG2iCzpukUuf5Vub13c9RgIAwQ/+FYSt86AtxrBIEBP6cwSIDi/b9aEh00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5Q128Ju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09FEC4CEF1;
	Mon, 24 Nov 2025 19:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764012051;
	bh=E2JOMDEr8z+GMmz/BATIesSjQcVM1L0IzGNQ0lQeT4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5Q128Ju3tIwf9zLF6A9ksE1gTxSMFBMyNXHyyQVafocsIZjOfMVg7moQl1tj2RBV
	 nLrrSOxlEokJdDUSiydDsxr5nLC87OGOj4XSQ+TuHWb8BfRkBJm8A4Vnymxd1cJNjf
	 F573NOU+3MNXh/gu4TLVwmk/2VvD1Kq0oNfUf2I/1JwYpkJ1/1g8qzK0N/DmpvI1Qg
	 yK6ouo7/mmFY6ON0Np7qlYandVADPGI6Fo3xtVE7J5BUthc9/1UbpaDwHt4DKezc8J
	 b7rZ+9cFWRJCbmHuhmVdH9WW/K+srN1CN0WTm2LppfvLH220dtm1Y2/uB+3Ss5lCAS
	 1jAesDrYCA58g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 3/3] Input: pegasus-notetaker - fix potential out-of-bounds access
Date: Mon, 24 Nov 2025 14:20:46 -0500
Message-ID: <20251124192046.3812-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124192046.3812-1-sashal@kernel.org>
References: <2025112420-barman-maybe-9927@gregkh>
 <20251124192046.3812-1-sashal@kernel.org>
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
index 4e412a73a5aad..64a5ce5462293 100644
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


