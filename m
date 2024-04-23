Return-Path: <stable+bounces-40863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1B98AF95E
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A731F25897
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8293B1448D9;
	Tue, 23 Apr 2024 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JVwvGxVr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4077514388F;
	Tue, 23 Apr 2024 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908514; cv=none; b=J+8ROwBACiexK1EjsLp1evcs6rA/2c23EB15KfahQ51YxNJhUnEhJPGIgBgido7Q/qqIu7qRHUpF3yFpUyIjz3Zg9TCaOZ4ITsZatzOI5xDf/fDJDIPJyPIam4kvl7RXmUeuE8mef4KTuHycjNU9bYO261VBui08WvNORaLoZjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908514; c=relaxed/simple;
	bh=77HKJMJGH9zQ4nJ/eU+H/j2EysdNuqB/kDkWtqUDVas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmc2jRYUfKjJYtEPovPp92rq2xY/rWxAsTRYHPSStccj9MN7E1Ha85QqTu0R0APoKl0NOuTERWrePhxt9HRilByjTnq9j52fIk1JZi3FDc1yAQKFQsRfrFyQimuhefrL0818v3DVOy/F2++reMt2IQF9SSFHcLR5hEARiF4Wmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JVwvGxVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15779C3277B;
	Tue, 23 Apr 2024 21:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908514;
	bh=77HKJMJGH9zQ4nJ/eU+H/j2EysdNuqB/kDkWtqUDVas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JVwvGxVrJC6Z2A6fMuF3brsHNz9+i1USyCy5Fzp7c0a8zNmjMP7XVhbQAkhAKfQcU
	 N4jq+1jy9TMr6YQMarNlR2M0/9RKgIvYChPwOStf616IGsgK0q9xPjbNkWhtpV7JDR
	 HZYfmYKkHmThy3WdpvYQa6zi8/vNjp+3a0OJz3wA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	syzbot+5f29dc6a889fc42bd896@syzkaller.appspotmail.com
Subject: [PATCH 6.8 100/158] comedi: vmk80xx: fix incomplete endpoint checking
Date: Tue, 23 Apr 2024 14:38:42 -0700
Message-ID: <20240423213859.196489693@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>
References: <20240423213855.824778126@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

commit d1718530e3f640b7d5f0050e725216eab57a85d8 upstream.

While vmk80xx does have endpoint checking implemented, some things
can fall through the cracks. Depending on the hardware model,
URBs can have either bulk or interrupt type, and current version
of vmk80xx_find_usb_endpoints() function does not take that fully
into account. While this warning does not seem to be too harmful,
at the very least it will crash systems with 'panic_on_warn' set on
them.

Fix the issue found by Syzkaller [1] by somewhat simplifying the
endpoint checking process with usb_find_common_endpoints() and
ensuring that only expected endpoint types are present.

This patch has not been tested on real hardware.

[1] Syzkaller report:
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 0 PID: 781 at drivers/usb/core/urb.c:504 usb_submit_urb+0xc4e/0x18c0 drivers/usb/core/urb.c:503
...
Call Trace:
 <TASK>
 usb_start_wait_urb+0x113/0x520 drivers/usb/core/message.c:59
 vmk80xx_reset_device drivers/comedi/drivers/vmk80xx.c:227 [inline]
 vmk80xx_auto_attach+0xa1c/0x1a40 drivers/comedi/drivers/vmk80xx.c:818
 comedi_auto_config+0x238/0x380 drivers/comedi/drivers.c:1067
 usb_probe_interface+0x5cd/0xb00 drivers/usb/core/driver.c:399
...

Similar issue also found by Syzkaller:
Link: https://syzkaller.appspot.com/bug?extid=5205eb2f17de3e01946e

Reported-and-tested-by: syzbot+5f29dc6a889fc42bd896@syzkaller.appspotmail.com
Cc: stable <stable@kernel.org>
Fixes: 49253d542cc0 ("staging: comedi: vmk80xx: factor out usb endpoint detection")
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Link: https://lore.kernel.org/r/20240408171633.31649-1-n.zhandarovich@fintech.ru
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/comedi/drivers/vmk80xx.c |   35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

--- a/drivers/comedi/drivers/vmk80xx.c
+++ b/drivers/comedi/drivers/vmk80xx.c
@@ -641,33 +641,22 @@ static int vmk80xx_find_usb_endpoints(st
 	struct vmk80xx_private *devpriv = dev->private;
 	struct usb_interface *intf = comedi_to_usb_interface(dev);
 	struct usb_host_interface *iface_desc = intf->cur_altsetting;
-	struct usb_endpoint_descriptor *ep_desc;
-	int i;
+	struct usb_endpoint_descriptor *ep_rx_desc, *ep_tx_desc;
+	int ret;
 
-	if (iface_desc->desc.bNumEndpoints != 2)
-		return -ENODEV;
-
-	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
-		ep_desc = &iface_desc->endpoint[i].desc;
-
-		if (usb_endpoint_is_int_in(ep_desc) ||
-		    usb_endpoint_is_bulk_in(ep_desc)) {
-			if (!devpriv->ep_rx)
-				devpriv->ep_rx = ep_desc;
-			continue;
-		}
+	if (devpriv->model == VMK8061_MODEL)
+		ret = usb_find_common_endpoints(iface_desc, &ep_rx_desc,
+						&ep_tx_desc, NULL, NULL);
+	else
+		ret = usb_find_common_endpoints(iface_desc, NULL, NULL,
+						&ep_rx_desc, &ep_tx_desc);
 
-		if (usb_endpoint_is_int_out(ep_desc) ||
-		    usb_endpoint_is_bulk_out(ep_desc)) {
-			if (!devpriv->ep_tx)
-				devpriv->ep_tx = ep_desc;
-			continue;
-		}
-	}
-
-	if (!devpriv->ep_rx || !devpriv->ep_tx)
+	if (ret)
 		return -ENODEV;
 
+	devpriv->ep_rx = ep_rx_desc;
+	devpriv->ep_tx = ep_tx_desc;
+
 	if (!usb_endpoint_maxp(devpriv->ep_rx) || !usb_endpoint_maxp(devpriv->ep_tx))
 		return -EINVAL;
 



