Return-Path: <stable+bounces-37675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D2089C665
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 16:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5E8BB2600B
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 14:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451E17FBBB;
	Mon,  8 Apr 2024 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sENxZz8C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A682E405;
	Mon,  8 Apr 2024 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584932; cv=none; b=Ac1qQSf2mXG+v8MyVEuc9FWX318IOxKnKYgS+VdxM2cDwLtLNK8hBlow+l8HE+l4zib+H77Ch2ZC5QKUIMTkEEh0AdirOjWvajfUl+K0jxe8S85i+TQWRwu2m++x0HZ34jc0aNd41aQZQvoFM0Ct/1Syh3c4YJ7hTqTh6L/lUxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584932; c=relaxed/simple;
	bh=EabIlBy3ixk8Mhm7i2SfOdKclxIGWJMWE5eJFJQqAGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLNbgKYj9MvjG//T/Kk96vp64rozv3QCoHtyqGZa5aQHxWwq0Y23ZE3cqEN031xuME5NNcg0tHB6HKruH1rX7T/v6HMpQNWqERhasMtFkmzLEXqlBLnWfjice/6sCIUxJcWlwLNn/MbQfAwlIRxhZ8ZnyxJul2yGmvvsrolPBDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sENxZz8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7597BC433F1;
	Mon,  8 Apr 2024 14:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584931;
	bh=EabIlBy3ixk8Mhm7i2SfOdKclxIGWJMWE5eJFJQqAGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sENxZz8CnroH+drg/ZbCQVvxuhv24IqcKDwqdL0xOuvqidMXrfOTWGfyXYWZ+EJuv
	 gmhviWyejgpjT3Lrenr4bK4dDYClnPZkfK8X3aRRCHcjT6MPTprUdfbCEvVbB7Ctuu
	 06ADJ4we5iCk1s6DYuA0iUFGb4mgmmWWgBlQtixg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 5.15 605/690] USB: core: Fix deadlock in usb_deauthorize_interface()
Date: Mon,  8 Apr 2024 14:57:51 +0200
Message-ID: <20240408125421.518079441@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>

commit 80ba43e9f799cbdd83842fc27db667289b3150f5 upstream.

Among the attribute file callback routines in
drivers/usb/core/sysfs.c, the interface_authorized_store() function is
the only one which acquires a device lock on an ancestor device: It
calls usb_deauthorize_interface(), which locks the interface's parent
USB device.

The will lead to deadlock if another process already owns that lock
and tries to remove the interface, whether through a configuration
change or because the device has been disconnected.  As part of the
removal procedure, device_del() waits for all ongoing sysfs attribute
callbacks to complete.  But usb_deauthorize_interface() can't complete
until the device lock has been released, and the lock won't be
released until the removal has finished.

The mechanism provided by sysfs to prevent this kind of deadlock is
to use the sysfs_break_active_protection() function, which tells sysfs
not to wait for the attribute callback.

Reported-and-tested by: Yue Sun <samsun1006219@gmail.com>
Reported by: xingwei lee <xrivendell7@gmail.com>

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/linux-usb/CAEkJfYO6jRVC8Tfrd_R=cjO0hguhrV31fDPrLrNOOHocDkPoAA@mail.gmail.com/#r
Fixes: 310d2b4124c0 ("usb: interface authorization: SysFS part of USB interface authorization")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/1c37eea1-9f56-4534-b9d8-b443438dc869@rowland.harvard.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/sysfs.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -1169,14 +1169,24 @@ static ssize_t interface_authorized_stor
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	bool val;
+	struct kernfs_node *kn;
 
 	if (strtobool(buf, &val) != 0)
 		return -EINVAL;
 
-	if (val)
+	if (val) {
 		usb_authorize_interface(intf);
-	else
-		usb_deauthorize_interface(intf);
+	} else {
+		/*
+		 * Prevent deadlock if another process is concurrently
+		 * trying to unregister intf.
+		 */
+		kn = sysfs_break_active_protection(&dev->kobj, &attr->attr);
+		if (kn) {
+			usb_deauthorize_interface(intf);
+			sysfs_unbreak_active_protection(kn);
+		}
+	}
 
 	return count;
 }



