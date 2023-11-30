Return-Path: <stable+bounces-3255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F43E7FF2E5
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 15:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 926C6B20C1E
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24B442A8A;
	Thu, 30 Nov 2023 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X7ogljbV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A4F482F8
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 14:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71F2C433C8;
	Thu, 30 Nov 2023 14:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701355817;
	bh=k36t9/ucF/qRoonaALpf9kpL6fbaZMa2nqi+wNtGgr8=;
	h=Subject:To:Cc:From:Date:From;
	b=X7ogljbVWdiu0umAldQUfgdGCPhXQV9lgQy6J8G1zWKL5pbj36nFS7KVj99J0elvT
	 CqXXlDVqJheZHzhTreMQ/riYTwuLE3H8hscrr94J6tzYHFEgx5IUtAZGkmZEc25H5S
	 6KrOb6sQ36VqnnuutT6ppb2eftr6robGB3m8Ip9o=
Subject: FAILED: patch "[PATCH] usb: config: fix iteration issue in" failed to apply to 4.14-stable tree
To: niklas.neronin@linux.intel.com,gregkh@linuxfoundation.org,mathias.nyman@linux.intel.com,stern@rowland.harvard.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 30 Nov 2023 14:50:05 +0000
Message-ID: <2023113005-footwork-thimble-e0ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 974bba5c118f4c2baf00de0356e3e4f7928b4cbc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023113005-footwork-thimble-e0ae@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

974bba5c118f ("usb: config: fix iteration issue in 'usb_get_bos_descriptor()'")
7a09c1269702 ("USB: core: Change configuration warnings to notices")
91c7eaa686c3 ("USB: rename USB quirk to USB_QUIRK_ENDPOINT_IGNORE")
7f1b92a6a7f2 ("USB: core: clean up endpoint-descriptor parsing")
bdd1b147b802 ("USB: quirks: blacklist duplicate ep on Sound Devices USBPre2")
73f8bda9b5dc ("USB: core: add endpoint-blacklist quirk")
2548288b4fb0 ("USB: Fix: Don't skip endpoint descriptors with maxpacket=0")
3e4f8e21c4f2 ("USB: core: fix check for duplicate endpoints")
d482c7bb0541 ("USB: Skip endpoints with 0 maxpacket length")
3dd550a2d365 ("USB: usbcore: Fix slab-out-of-bounds bug during device reset")
a03ff5446081 ("USB: Fix slab-out-of-bounds write in usb_get_bos_descriptor")
781f0766cc41 ("USB: Wait for extra delay time after USB_PORT_FEAT_RESET for quirky hub")
aa071a92bbf0 ("usb: hub: Per-port setting to reduce TRSTRCY to 10 ms")
25244227158e ("usb: hub: Per-port setting to use old enumeration scheme")
4d8d5a392ae1 ("usb: core: Add USB_QUIRK_DELAY_CTRL_MSG to usbcore quirks")
1cbd53c8cd85 ("usb: core: introduce per-port over-current counters")
027bd6cafd9a ("usb: core: Add "quirks" parameter for usbcore")
cb88a0588717 ("usb: quirks: add control message delay for 1b1c:1b20")
7a1646d92257 ("Add delay-init quirk for Corsair K70 RGB keyboards")
81cf4a45360f ("USB: core: Add type-specific length check of BOS descriptors")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 974bba5c118f4c2baf00de0356e3e4f7928b4cbc Mon Sep 17 00:00:00 2001
From: Niklas Neronin <niklas.neronin@linux.intel.com>
Date: Wed, 15 Nov 2023 14:13:25 +0200
Subject: [PATCH] usb: config: fix iteration issue in
 'usb_get_bos_descriptor()'

The BOS descriptor defines a root descriptor and is the base descriptor for
accessing a family of related descriptors.

Function 'usb_get_bos_descriptor()' encounters an iteration issue when
skipping the 'USB_DT_DEVICE_CAPABILITY' descriptor type. This results in
the same descriptor being read repeatedly.

To address this issue, a 'goto' statement is introduced to ensure that the
pointer and the amount read is updated correctly. This ensures that the
function iterates to the next descriptor instead of reading the same
descriptor repeatedly.

Cc: stable@vger.kernel.org
Fixes: 3dd550a2d365 ("USB: usbcore: Fix slab-out-of-bounds bug during device reset")
Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20231115121325.471454-1-niklas.neronin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index b19e38d5fd10..7f8d33f92ddb 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -1047,7 +1047,7 @@ int usb_get_bos_descriptor(struct usb_device *dev)
 
 		if (cap->bDescriptorType != USB_DT_DEVICE_CAPABILITY) {
 			dev_notice(ddev, "descriptor type invalid, skip\n");
-			continue;
+			goto skip_to_next_descriptor;
 		}
 
 		switch (cap_type) {
@@ -1078,6 +1078,7 @@ int usb_get_bos_descriptor(struct usb_device *dev)
 			break;
 		}
 
+skip_to_next_descriptor:
 		total_len -= length;
 		buffer += length;
 	}


