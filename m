Return-Path: <stable+bounces-3252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4797FF2E2
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 15:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34189281A5F
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C850D4778A;
	Thu, 30 Nov 2023 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kyRSGxaI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899E04879F
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 14:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28C5C433C8;
	Thu, 30 Nov 2023 14:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701355808;
	bh=gUtPHGcYSjVa8PoM/LXbLzyjNNl1Xzr/vZYUYvjxVbw=;
	h=Subject:To:Cc:From:Date:From;
	b=kyRSGxaISGT7ssIjwJ84/VSlPipQu2cm8N84RVVzKGw5cP3H+BA4HPzYzq+opiN4u
	 bmZbPzGHDQg0G/s6oplxINsUOLJ25s6m9aJCs1WY+wk1NpLWdiJ709HXq/RWISRMVS
	 RVtqxehq62mrAwLHcYW9iNYoEWyJS7QCWN3JF4Bo=
Subject: FAILED: patch "[PATCH] usb: config: fix iteration issue in" failed to apply to 5.10-stable tree
To: niklas.neronin@linux.intel.com,gregkh@linuxfoundation.org,mathias.nyman@linux.intel.com,stern@rowland.harvard.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 30 Nov 2023 14:50:02 +0000
Message-ID: <2023113001-bullfrog-retool-bfe1@gregkh>
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
git cherry-pick -x 974bba5c118f4c2baf00de0356e3e4f7928b4cbc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023113001-bullfrog-retool-bfe1@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

974bba5c118f ("usb: config: fix iteration issue in 'usb_get_bos_descriptor()'")
7a09c1269702 ("USB: core: Change configuration warnings to notices")

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


