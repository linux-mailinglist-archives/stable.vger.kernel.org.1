Return-Path: <stable+bounces-198989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B854CA0322
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 17:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D7B430690D9
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 16:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AA1347FD7;
	Wed,  3 Dec 2025 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AhRIWyBY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650AC347FC4;
	Wed,  3 Dec 2025 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778331; cv=none; b=DXcUNtLJaIi1kU+mgX8M9IP99hpmGs9uMHm9KrSX+94/NXsPNpe5sycogZ4GiNYkX8e0VKRhKJ6DTQTvV8RNFkmrMwOgPeyJVlW6IJnSF4tqcAvlJu7Dq4mvyQlXVBBOIvHkScp5LgbQeNFIDqVsxd/uUsBlLEdBt5bUSOuegj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778331; c=relaxed/simple;
	bh=x/OrD+7fUhSHDwJKmhDnBKFUox+jG/cJ5wB3O64nEJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsR8a2RPVTS/f9Y39kD+sMxjlTDcHk4ydXrvK4kMrzVsthLRs4oaR137wr2Z4YnqRfMhrtdgjWFAI49xYHyD2rulY/lwtr86mfsv8C8Ppbw6FOAhkM73EJLf4lXFt1NV+bgLJfc02SvJm10vIkWHn66YrozKQEEOFgKt847IXbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AhRIWyBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CC2C4CEF5;
	Wed,  3 Dec 2025 16:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764778331;
	bh=x/OrD+7fUhSHDwJKmhDnBKFUox+jG/cJ5wB3O64nEJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AhRIWyBYBx8o7y5LU2HPhl4biOp4zlTF44MpmMR4VI+KMbj1T7QJbXPtyZyYyQjZh
	 M4VQ/ZcpMsl48hpjPMSwZjxxbRtKDOgValqfYZJA1TmZAVonniqwNYgg9wwts2xcv3
	 n+KNBuIHiJ9Nc0OvENkdZqb33DKxXvgAiEXqQvwY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 280/392] isdn: mISDN: hfcsusb: fix memory leak in hfcsusb_probe()
Date: Wed,  3 Dec 2025 16:27:10 +0100
Message-ID: <20251203152424.464355732@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abdun Nihaal <nihaal@cse.iitm.ac.in>

commit 3f978e3f1570155a1327ffa25f60968bc7b9398f upstream.

In hfcsusb_probe(), the memory allocated for ctrl_urb gets leaked when
setup_instance() fails with an error code. Fix that by freeing the urb
before freeing the hw structure. Also change the error paths to use the
goto ladder style.

Compile tested only. Issue found using a prototype static analysis tool.

Fixes: 69f52adb2d53 ("mISDN: Add HFC USB driver")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Link: https://patch.msgid.link/20251030042524.194812-1-nihaal@cse.iitm.ac.in
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/isdn/hardware/mISDN/hfcsusb.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/drivers/isdn/hardware/mISDN/hfcsusb.c
+++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
@@ -1903,13 +1903,13 @@ out:
 	mISDN_freebchannel(&hw->bch[1]);
 	mISDN_freebchannel(&hw->bch[0]);
 	mISDN_freedchannel(&hw->dch);
-	kfree(hw);
 	return err;
 }
 
 static int
 hfcsusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
+	int err;
 	struct hfcsusb			*hw;
 	struct usb_device		*dev = interface_to_usbdev(intf);
 	struct usb_host_interface	*iface = intf->cur_altsetting;
@@ -2100,20 +2100,28 @@ hfcsusb_probe(struct usb_interface *intf
 	if (!hw->ctrl_urb) {
 		pr_warn("%s: No memory for control urb\n",
 			driver_info->vend_name);
-		kfree(hw);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_free_hw;
 	}
 
 	pr_info("%s: %s: detected \"%s\" (%s, if=%d alt=%d)\n",
 		hw->name, __func__, driver_info->vend_name,
 		conf_str[small_match], ifnum, alt_used);
 
-	if (setup_instance(hw, dev->dev.parent))
-		return -EIO;
+	if (setup_instance(hw, dev->dev.parent)) {
+		err = -EIO;
+		goto err_free_urb;
+	}
 
 	hw->intf = intf;
 	usb_set_intfdata(hw->intf, hw);
 	return 0;
+
+err_free_urb:
+	usb_free_urb(hw->ctrl_urb);
+err_free_hw:
+	kfree(hw);
+	return err;
 }
 
 /* function called when an active device is removed */



