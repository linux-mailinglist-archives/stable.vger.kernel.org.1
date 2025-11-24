Return-Path: <stable+bounces-196712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE6BC80CB1
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 077704E572B
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C27306B37;
	Mon, 24 Nov 2025 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d17QO8rK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321A1306495
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763991394; cv=none; b=Ly8q7+YekuBmg/4H9qyfXDscSRtM9evXgXQPBNoHebdWoxES3QLd8sLtXsQuwF1Oom0q3eoJk1YHc/zXQ04A0xT/0d2rcZQ/Kbhp2jrcOQHNRvcJhIxrsktBvXr7x8A6uVxcctRODGVzXRNwznAmBzYpbHBmOIRE82vZWRmbhg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763991394; c=relaxed/simple;
	bh=uBs5vPhtT1teQ7LGyyQsqTNIUgxnaCxAJsqGv56YFEg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DBaWwHu07PDt171OPLTbkAgeKeM2+h/DeP2D8aHf+FL9BNuxeJUgdQhkOOompafYzrxEZMvaza5nXxHNByQOqShq+0iADQQGYQEwUbakiJzkGr/AaO+ProOQGnZMR5DcxNcoXbEApNdUSWLFCwuupBQDzbRT+FNFZkePA36UNbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d17QO8rK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0422C4CEF1;
	Mon, 24 Nov 2025 13:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763991394;
	bh=uBs5vPhtT1teQ7LGyyQsqTNIUgxnaCxAJsqGv56YFEg=;
	h=Subject:To:Cc:From:Date:From;
	b=d17QO8rKR1coD1jCLltJSrAsnr2RnUWcBVr5zZ1do7yMmQDad4IheYmLZPg+onZfa
	 PW2A5YvOQUu5B0VWlQu8lMh9rNg3aJ7c648mWCTNCXzQSHaX6xao0f6Raj8G+2phIJ
	 Q+a4XMbY95w4rEhaXleuARdVOZh79xJ5Xz2hNl78=
Subject: FAILED: patch "[PATCH] Input: pegasus-notetaker - fix potential out-of-bounds access" failed to apply to 5.10-stable tree
To: eeodqql09@gmail.com,dmitry.torokhov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:36:20 +0100
Message-ID: <2025112420-cleaver-backlight-0d73@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 69aeb507312306f73495598a055293fa749d454e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112420-cleaver-backlight-0d73@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 69aeb507312306f73495598a055293fa749d454e Mon Sep 17 00:00:00 2001
From: Seungjin Bae <eeodqql09@gmail.com>
Date: Fri, 17 Oct 2025 15:36:31 -0700
Subject: [PATCH] Input: pegasus-notetaker - fix potential out-of-bounds access

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

diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index 8d6b71d59793..eabb4a0b8a0d 100644
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
@@ -311,6 +314,12 @@ static int pegasus_probe(struct usb_interface *intf,
 	}
 
 	pegasus->data_len = usb_maxpacket(dev, pipe);
+	if (pegasus->data_len < NOTETAKER_PACKET_SIZE) {
+		dev_err(&intf->dev, "packet size is too small (%d)\n",
+			pegasus->data_len);
+		error = -EINVAL;
+		goto err_free_mem;
+	}
 
 	pegasus->data = usb_alloc_coherent(dev, pegasus->data_len, GFP_KERNEL,
 					   &pegasus->data_dma);


