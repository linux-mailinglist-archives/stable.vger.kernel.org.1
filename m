Return-Path: <stable+bounces-59550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B92D932AA9
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73498B231B5
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77211DA4D;
	Tue, 16 Jul 2024 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zQpKOuC9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60CCCA40;
	Tue, 16 Jul 2024 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144186; cv=none; b=HneNQRF43RuG+MKqf3klHRwYodSdSQranr/SzcEbOFCG1yPeznXOrUcC9FxJr/Y9dGaUDoyM+RSrCFtZkcy/PbsLx6TLLMhmjNWMjOzABZZij8r8B+TDv+kzQG9foqm5dq9+AGb/rT/RrFD0jFTrMPi4O4T9Re7b5f3jOLtww0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144186; c=relaxed/simple;
	bh=JOUk7xoWkf4lHN66o5bolfBXhATdGlGf1DC1i5wSlzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBH6e0jhym9gUp2F6/KApku60tFLqEjD0RzbgNyiEXCmC6UFQ2mxCW8n2aTPqng0z5Jpg7w9nDPQOSAeovT9bHaDjm3/y3hg2kxFqfNWQpxc/mP210firy13twmpZvXkcBC0b9G3Z4GA/KSyFQWvKy0VSsHrqfxuogacBK0rXG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zQpKOuC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B970C116B1;
	Tue, 16 Jul 2024 15:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144186;
	bh=JOUk7xoWkf4lHN66o5bolfBXhATdGlGf1DC1i5wSlzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zQpKOuC9hJXRebQL0gNMP7zZfxeBMu3GyvJPtt9hRjNVwis/efRxBV8rMWvor9Giw
	 y5WM9sZVwrCQkWEqcIokE1PtEcwkVspTaIihReJr04uRrIhE96pOroCa6g9o0U98ZA
	 jDwzoN0s7RZa5D9wYVIv8tFxI6rQbnesn6MISmyE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alan Stern <stern@rowland.harvard.edu>,
	Oliver Neukum <oneukum@suse.com>,
	syzbot+8693a0bb9c10b554272a@syzkaller.appspotmail.com
Subject: [PATCH 4.19 57/66] USB: core: Fix duplicate endpoint bug by clearing reserved bits in the descriptor
Date: Tue, 16 Jul 2024 17:31:32 +0200
Message-ID: <20240716152740.338292001@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152738.161055634@linuxfoundation.org>
References: <20240716152738.161055634@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>

commit a368ecde8a5055b627749b09c6218ef793043e47 upstream.

Syzbot has identified a bug in usbcore (see the Closes: tag below)
caused by our assumption that the reserved bits in an endpoint
descriptor's bEndpointAddress field will always be 0.  As a result of
the bug, the endpoint_is_duplicate() routine in config.c (and possibly
other routines as well) may believe that two descriptors are for
distinct endpoints, even though they have the same direction and
endpoint number.  This can lead to confusion, including the bug
identified by syzbot (two descriptors with matching endpoint numbers
and directions, where one was interrupt and the other was bulk).

To fix the bug, we will clear the reserved bits in bEndpointAddress
when we parse the descriptor.  (Note that both the USB-2.0 and USB-3.1
specs say these bits are "Reserved, reset to zero".)  This requires us
to make a copy of the descriptor earlier in usb_parse_endpoint() and
use the copy instead of the original when checking for duplicates.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-and-tested-by: syzbot+8693a0bb9c10b554272a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-usb/0000000000003d868e061bc0f554@google.com/
Fixes: 0a8fd1346254 ("USB: fix problems with duplicate endpoint addresses")
CC: Oliver Neukum <oneukum@suse.com>
CC: stable@vger.kernel.org
Link: https://lore.kernel.org/r/205a5edc-7fef-4159-b64a-80374b6b101a@rowland.harvard.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/config.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -291,6 +291,20 @@ static int usb_parse_endpoint(struct dev
 	if (ifp->desc.bNumEndpoints >= num_ep)
 		goto skip_to_next_endpoint_or_interface_descriptor;
 
+	/* Save a copy of the descriptor and use it instead of the original */
+	endpoint = &ifp->endpoint[ifp->desc.bNumEndpoints];
+	memcpy(&endpoint->desc, d, n);
+	d = &endpoint->desc;
+
+	/* Clear the reserved bits in bEndpointAddress */
+	i = d->bEndpointAddress &
+			(USB_ENDPOINT_DIR_MASK | USB_ENDPOINT_NUMBER_MASK);
+	if (i != d->bEndpointAddress) {
+		dev_notice(ddev, "config %d interface %d altsetting %d has an endpoint descriptor with address 0x%X, changing to 0x%X\n",
+		    cfgno, inum, asnum, d->bEndpointAddress, i);
+		endpoint->desc.bEndpointAddress = i;
+	}
+
 	/* Check for duplicate endpoint addresses */
 	if (config_endpoint_is_duplicate(config, inum, asnum, d)) {
 		dev_warn(ddev, "config %d interface %d altsetting %d has a duplicate endpoint with address 0x%X, skipping\n",
@@ -308,10 +322,8 @@ static int usb_parse_endpoint(struct dev
 		}
 	}
 
-	endpoint = &ifp->endpoint[ifp->desc.bNumEndpoints];
+	/* Accept this endpoint */
 	++ifp->desc.bNumEndpoints;
-
-	memcpy(&endpoint->desc, d, n);
 	INIT_LIST_HEAD(&endpoint->urb_list);
 
 	/*



