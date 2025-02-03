Return-Path: <stable+bounces-112011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8366DA258F7
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 13:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BAE11882804
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 12:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E181320409D;
	Mon,  3 Feb 2025 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="LW6Oofeb"
X-Original-To: stable@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13352040B5;
	Mon,  3 Feb 2025 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738584392; cv=none; b=E63FaMKnClrbI5QzHN03HmAuM+IXmwke3ZAtp3izA8+RHUMnAAgJTARr8f5uC0lvFXVaQxokX1+EidwkKZjBRqsRl2+hBFuknUJND7gO2fYhs2vE6Cmiq9+nhIin2KGNp7A5bLphxxo5epwXHnWHky8Qyf9LXTEiPd2aX9Nn9Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738584392; c=relaxed/simple;
	bh=zYaLG6IJSpDlxxMTZJxY5ECMfjeDQ32tSMkMD4Z02+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bAKlIWcytiDvZs2O62ywfi9qpufvIThS6RhaeLvZI4bGtts2YZOFWTd1GZEJeTbat3pA0mDKAt8FUuX7clX1y+RcKYvBnXtBCQY732K3T+w2ZAlN8jbbZV+MYEgFevVMlYjH5Mw0BU2MG20CivVZ1OPzaX2sobtOIpNgqvgDZpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=LW6Oofeb; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55BFBA0CC1;
	Mon,  3 Feb 2025 13:00:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1738584054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N0MRwPWFmgCZmVobKqV4wnfrvyJ/Wr2AIibpxTZfaYA=;
	b=LW6OofebfTlfjMJSzvcsU57zOYpgt0o51xBqRgNb8V7lYksc7UMnDLha6EHb5t9AGoyp7O
	czWtQEDXDDaWr0xDF0ZVnvvCqQwl8QBLqLbOmJlFPYjPlAFIyJexHE46T+YmHjy6f1qbNE
	P2eyPM38PN/GYGFPXQAfnPnG0krJVXhZ0eVs+kxQ2orr4O18w9WwN+Qxp5IcZ2jJsy9u3F
	JKU50sPs4qZrpNFN0T7FlZ2M29pssFv7uOgnNmDvW+bq8og/sFlPAmTeCmEuLvJGazRGky
	I51Vo4HrbS1WyLpqHEz3EKbESqfwj7g6BGQuwLgHdykADW0awbSR7WTJJ6BN+w==
From: nb@tipi-net.de
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ben Hutchings <ben@decadent.org.uk>
Cc: n.buchwitz@kunbus.com,
	l.sanfilippo@kunbus.com,
	stable@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: xhci: Restore Renesas uPD72020x support in xhci-pci
Date: Mon,  3 Feb 2025 13:00:26 +0100
Message-Id: <20250203120026.2010567-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Nicolai Buchwitz <nb@tipi-net.de>

Before commit 25f51b76f90f1 ("xhci-pci: Make xhci-pci-renesas a proper
modular driver"), the xhci-pci driver handled the Renesas uPD72020x USB3
PHY and only utilized features of xhci-pci-renesas when no external
firmware EEPROM was attached. This allowed devices with a valid firmware
stored in EEPROM to function without requiring xhci-pci-renesas.

That commit changed the behavior, making xhci-pci-renesas responsible for
handling these devices entirely, even when firmware was already present
in EEPROM. As a result, unnecessary warnings about missing firmware files
appeared, and more critically, USB functionality broke whens
CONFIG_USB_XHCI_PCI_RENESAS was not enabled—despite previously workings
without it.

Fix this by ensuring that devices are only handed over to xhci-pci-renesas
if the config option is enabled. Otherwise, restore the original behavior
and handle them as standard xhci-pci devices.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
Fixes: 25f51b76f90f ("xhci-pci: Make xhci-pci-renesas a proper modular driver")
---
 drivers/usb/host/xhci-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 2d1e205c14c60..4ce80d8ac603e 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -654,9 +654,11 @@ int xhci_pci_common_probe(struct pci_dev *dev, const struct pci_device_id *id)
 EXPORT_SYMBOL_NS_GPL(xhci_pci_common_probe, "xhci");
 
 static const struct pci_device_id pci_ids_reject[] = {
+#if IS_ENABLED(CONFIG_USB_XHCI_PCI_RENESAS)
 	/* handled by xhci-pci-renesas */
 	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, 0x0014) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, 0x0015) },
+#endif
 	{ /* end: all zeroes */ }
 };
 
-- 
2.39.5


