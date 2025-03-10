Return-Path: <stable+bounces-122152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 060F5A59F2B
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3EE3AA272
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A84230BF8;
	Mon, 10 Mar 2025 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rt/HvsE8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DA8230D2B;
	Mon, 10 Mar 2025 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627677; cv=none; b=gizjiZGB7JxiOYOWhL8oV6bQYWXth/mQfqC/KYsz6Fq3gwbdTJTsA7KxJ25uHVM1opm5zhjzMs62Cxx740nSMCuPVhGwIpgrGBWn7cYkrH5nxnp83Bel+fhpsElVQfNPWa6Y9EeXIYL1g6wLm720nqAgB+pO4I1IIwH6KuMn7Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627677; c=relaxed/simple;
	bh=5Y7b+AMURS1855lEy+21FDKBN1q/kA4ri/D+vMwT1y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TExvB6XrljfoOEC9xdkAFrIcYAlzPYsCiVf6OOc3fbKlejoFzdN6pXeaz9IZbXPnn0gEbFM4eP2CI0Z1CAMC5rhaWX5dBcSwk1bGcJGzqNypSH1/HzwKXG4mC8ye1UDm+armqi51yiLR7ebMLbtPWn4M+8rHbKL5/JjNmWZBqPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rt/HvsE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4CBC4CEE5;
	Mon, 10 Mar 2025 17:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627677;
	bh=5Y7b+AMURS1855lEy+21FDKBN1q/kA4ri/D+vMwT1y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rt/HvsE8bYCUQ7tJdO1XjFQArXcoiza84k0CVSaX5msHjhmztpBNhLkTii/BjKYo+
	 vIzIYxrO/Tn9yvv3elPz+2Ga3aIcV0rr9dPxmIfnMaXFQvv6LqMGs+OOjmHhNzBOtr
	 d4dLmirCHY3t2ATIMK+5UnpcBxkkoZMWnecO41iM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 6.12 210/269] usb: hub: lack of clearing xHC resources
Date: Mon, 10 Mar 2025 18:06:03 +0100
Message-ID: <20250310170506.064168299@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pawel Laszczak <pawell@cadence.com>

commit 2b66ef84d0d2a0ea955b40bd306f5e3abbc5cf9c upstream.

The xHC resources allocated for USB devices are not released in correct
order after resuming in case when while suspend device was reconnected.

This issue has been detected during the fallowing scenario:
- connect hub HS to root port
- connect LS/FS device to hub port
- wait for enumeration to finish
- force host to suspend
- reconnect hub attached to root port
- wake host

For this scenario during enumeration of USB LS/FS device the Cadence xHC
reports completion error code for xHC commands because the xHC resources
used for devices has not been properly released.
XHCI specification doesn't mention that device can be reset in any order
so, we should not treat this issue as Cadence xHC controller bug.
Similar as during disconnecting in this case the device resources should
be cleared starting form the last usb device in tree toward the root hub.
To fix this issue usbcore driver should call hcd->driver->reset_device
for all USB devices connected to hub which was reconnected while
suspending.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/PH7PR07MB953841E38C088678ACDCF6EEDDCC2@PH7PR07MB9538.namprd07.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/hub.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -6066,6 +6066,36 @@ void usb_hub_cleanup(void)
 } /* usb_hub_cleanup() */
 
 /**
+ * hub_hc_release_resources - clear resources used by host controller
+ * @udev: pointer to device being released
+ *
+ * Context: task context, might sleep
+ *
+ * Function releases the host controller resources in correct order before
+ * making any operation on resuming usb device. The host controller resources
+ * allocated for devices in tree should be released starting from the last
+ * usb device in tree toward the root hub. This function is used only during
+ * resuming device when usb device require reinitialization – that is, when
+ * flag udev->reset_resume is set.
+ *
+ * This call is synchronous, and may not be used in an interrupt context.
+ */
+static void hub_hc_release_resources(struct usb_device *udev)
+{
+	struct usb_hub *hub = usb_hub_to_struct_hub(udev);
+	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
+	int i;
+
+	/* Release up resources for all children before this device */
+	for (i = 0; i < udev->maxchild; i++)
+		if (hub->ports[i]->child)
+			hub_hc_release_resources(hub->ports[i]->child);
+
+	if (hcd->driver->reset_device)
+		hcd->driver->reset_device(hcd, udev);
+}
+
+/**
  * usb_reset_and_verify_device - perform a USB port reset to reinitialize a device
  * @udev: device to reset (not in SUSPENDED or NOTATTACHED state)
  *
@@ -6129,6 +6159,9 @@ static int usb_reset_and_verify_device(s
 	bos = udev->bos;
 	udev->bos = NULL;
 
+	if (udev->reset_resume)
+		hub_hc_release_resources(udev);
+
 	mutex_lock(hcd->address0_mutex);
 
 	for (i = 0; i < PORT_INIT_TRIES; ++i) {



