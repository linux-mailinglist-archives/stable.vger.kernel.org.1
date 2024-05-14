Return-Path: <stable+bounces-44363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FE68C526F
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994BF1F21F6F
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F6E13D2B6;
	Tue, 14 May 2024 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QGduknVO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4110F6311D;
	Tue, 14 May 2024 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685891; cv=none; b=MGKECd6ypIGxgiudMl/15c85AEuCGmBISMeOKKvnOG+dwDTj75oc88sApTtCrpi9OAGIg6vHXqDj7npE7O9ZoloGlnD/vtEXlY0FBmP+K1+7+kKPBERBDwdcPeta1MTQPIlZmIq6hy4E5fPWXcFFF8/BjbrnirDHzCxjFOQMEFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685891; c=relaxed/simple;
	bh=8UZsmh77JeiaIZ38SV3UI7sTEx9VxuIo5DbBAghDiSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muhpdUyeS5/6H9aOlTm4PejeWTuUGGmFv7SGnQqagP2zdbdIxrnTGtUauw10Nf3lmxIMG+pdTDtsoXYmQKB30kw7EmbPaUi+Ogql7bQNOy15+XhKUaIjpsKdkvs23pNqPF6GFEGGFSzXawlxinJXx9FKs5APhE6A4PRjtRjFT4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QGduknVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0672C2BD10;
	Tue, 14 May 2024 11:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715685891;
	bh=8UZsmh77JeiaIZ38SV3UI7sTEx9VxuIo5DbBAghDiSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QGduknVO3ZxauQ0whxfLxcgAUXGsjAvnnfHuMayqQ8jrrRL038oGZUnK6Q3DGU6nz
	 /UQPDS3kZZeV3Ox+RSgd37bSLhkL0RaD/NMJ6UE4bTtZQ+83OMPMPeeSiJvpYoaAe4
	 DlshlIPFuSyOknYSO9cu4aB7DRsVTVGGA3nHOIJM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gerd Hoffmann <kraxel@redhat.com>,
	David Laight <David.Laight@aculab.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 6.6 228/301] usb: ohci: Prevent missed ohci interrupts
Date: Tue, 14 May 2024 12:18:19 +0200
Message-ID: <20240514101040.865230092@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -888,6 +888,7 @@ static irqreturn_t ohci_irq (struct usb_
 	/* Check for an all 1's result which is a typical consequence
 	 * of dead, unclocked, or unplugged (CardBus...) devices
 	 */
+again:
 	if (ints == ~(u32)0) {
 		ohci->rh_state = OHCI_RH_HALTED;
 		ohci_dbg (ohci, "device removed!\n");
@@ -982,6 +983,13 @@ static irqreturn_t ohci_irq (struct usb_
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
 



