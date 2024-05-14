Return-Path: <stable+bounces-45055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2F68C558A
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8441E28D5F6
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4BD2943F;
	Tue, 14 May 2024 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jYR+lJyd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D8BF9D4;
	Tue, 14 May 2024 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687951; cv=none; b=Qqzgj6JO/fyDfoEcm866zpIp9NmdYXDJ3+E3tUayYTj2wo7NHOsmumFv0BZCvU5i6EMPkkgMQavPWMwHSopB/TAav7tH0TlOOUlvzra2URYP7HXp+E9f7SoJTK6jQYjEf3RW6UWkCQoe2BISk1Do8SMSh6k6LZxpwv6Jn51301c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687951; c=relaxed/simple;
	bh=V43g8m99+Z6Rd0cqsjUJylSbIxuk0ifGXFz5pSopK4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mk5Ccdt8TiSGbrjwtuKH0Or4NBGMHc8Q55WxvyoAZl+hWkQrAhDw1mXFZHnmQt65WkUcsP1aiVAotvCXLXYzdar5cw1eHf4/D+zD7zLuNqPJXUG+AXZd8qJ94JjU/ZS90FUkmx+bEw+X/WQlbf71loV8/Ev5lELUTUO3drBtTno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jYR+lJyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9A5C2BD10;
	Tue, 14 May 2024 11:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687950;
	bh=V43g8m99+Z6Rd0cqsjUJylSbIxuk0ifGXFz5pSopK4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jYR+lJydagacS0RfcNIpWfDkQjk1sPYSPR5vNG0VLjvKhpEH3Kt6Gc/jFy9bevcWG
	 wOuK5qeDFcpMbu6INzD7KeDeHejNMrz5DfEZZlhOeXiPBcjbVyb1J6gA4jjw8SNE6M
	 dhmRKBYC6ygNTH+Gn2AXujqHvkSEp1m3UuPbXoPo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gerd Hoffmann <kraxel@redhat.com>,
	David Laight <David.Laight@aculab.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 5.15 144/168] usb: ohci: Prevent missed ohci interrupts
Date: Tue, 14 May 2024 12:20:42 +0200
Message-ID: <20240514101012.202838980@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101006.678521560@linuxfoundation.org>
References: <20240514101006.678521560@linuxfoundation.org>
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

From: Guenter Roeck <linux@roeck-us.net>

commit fe81f354841641c7f71163b84912b25c169ed8ec upstream.

Testing ohci functionality with qemu's pci-ohci emulation often results
in ohci interface stalls, resulting in hung task timeouts.

The problem is caused by lost interrupts between the emulation and the
Linux kernel code. Additional interrupts raised while the ohci interrupt
handler in Linux is running and before the handler clears the interrupt
status are not handled. The fix for a similar problem in ehci suggests
that the problem is likely caused by edge-triggered MSI interrupts. See
commit 0b60557230ad ("usb: ehci: Prevent missed ehci interrupts with
edge-triggered MSI") for details.

Ensure that the ohci interrupt code handles all pending interrupts before
returning to solve the problem.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: stable@vger.kernel.org
Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Link: https://lore.kernel.org/r/20240429154010.1507366-1-linux@roeck-us.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/ohci-hcd.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -890,6 +890,7 @@ static irqreturn_t ohci_irq (struct usb_
 	/* Check for an all 1's result which is a typical consequence
 	 * of dead, unclocked, or unplugged (CardBus...) devices
 	 */
+again:
 	if (ints == ~(u32)0) {
 		ohci->rh_state = OHCI_RH_HALTED;
 		ohci_dbg (ohci, "device removed!\n");
@@ -984,6 +985,13 @@ static irqreturn_t ohci_irq (struct usb_
 	}
 	spin_unlock(&ohci->lock);
 
+	/* repeat until all enabled interrupts are handled */
+	if (ohci->rh_state != OHCI_RH_HALTED) {
+		ints = ohci_readl(ohci, &regs->intrstatus);
+		if (ints && (ints & ohci_readl(ohci, &regs->intrenable)))
+			goto again;
+	}
+
 	return IRQ_HANDLED;
 }
 



