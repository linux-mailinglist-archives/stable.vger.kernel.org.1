Return-Path: <stable+bounces-172078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 584FBB2FA69
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC161CC5652
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F19335BDC;
	Thu, 21 Aug 2025 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X7oLT1Rv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C6E334739
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782824; cv=none; b=KnahNdR/nc8MwP8lblHQeFVCHCTA/mGIJTZ6eJsfrvacwOQPWO0XndiE8qmRkmuDqXfSmDwPhVwtbTC+XUEBfOQJMnfKI3v5jWKDrsOId7KXRSDuOnIkP0cgTtCORo4FuAgyxccC1TFqIMmfTplxGtxDovreIinB1ZVME8UcI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782824; c=relaxed/simple;
	bh=XS4OtdAI6Eu1ZFDCYwLoGHyQxFFp1imqC5B1Q4prXA4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ID0sNDYTBBDNftnHCnT9eL3AUenABBTtRR6JI9DypUNs5xKt1WDhGHbY57iTnmdQu12iUs/pg8iu/UvrduPcNGg0TFKKYZczRTQnqBjS6WG4fUg+X99i4R3k0Md9G1rQ2uo4WWL0UaAQtsayihq/2E9XvV6m5o20uvkd70q/IYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X7oLT1Rv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC7BC4CEEB;
	Thu, 21 Aug 2025 13:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755782823;
	bh=XS4OtdAI6Eu1ZFDCYwLoGHyQxFFp1imqC5B1Q4prXA4=;
	h=Subject:To:Cc:From:Date:From;
	b=X7oLT1Rvf1DFpoiqRZ9Y0G0r2ZpshzIL3lu3gowr4IcydVyhlm66W+uHDfLJT/oz/
	 G5ZgqATQLlILYRfAtvz3wTWpOxwmXFTGCcIcdEGeaAmepIfDWhpV7Cx9/4Rf9lPu+X
	 LN7MuVZ+cEms4fsX4So44Aai1JBHO09TQmytdAMc=
Subject: FAILED: patch "[PATCH] PCI/portdrv: Use is_pciehp instead of is_hotplug_bridge" failed to apply to 6.1-stable tree
To: lukas@wunner.de,bhelgaas@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:27:00 +0200
Message-ID: <2025082100-neglector-avenge-a128@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1d60796a62f327cd9e0a6a0865ded7656d2c67f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082100-neglector-avenge-a128@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1d60796a62f327cd9e0a6a0865ded7656d2c67f9 Mon Sep 17 00:00:00 2001
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 13 Jul 2025 16:31:02 +0200
Subject: [PATCH] PCI/portdrv: Use is_pciehp instead of is_hotplug_bridge

The PCIe port driver erroneously creates a subdevice for hotplug on ACPI
slots which are handled by the ACPI hotplug driver.

Avoid by checking the is_pciehp flag instead of is_hotplug_bridge when
deciding whether to create a subdevice.  The latter encompasses ACPI slots
whereas the former doesn't.

The superfluous subdevice has no real negative impact, it occupies memory
and interrupt resources but otherwise just sits there waiting for
interrupts from the slot that are never signaled.

Fixes: f8415222837b ("PCI: Use cached copy of PCI_EXP_SLTCAP_HPC bit")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org # v4.7+
Link: https://patch.msgid.link/40d5a5fe8d40595d505949c620a067fa110ee85e.1752390102.git.lukas@wunner.de

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index e8318fd5f6ed..d1b68c18444f 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -220,7 +220,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	int services = 0;
 
-	if (dev->is_hotplug_bridge &&
+	if (dev->is_pciehp &&
 	    (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
 	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) &&
 	    (pcie_ports_native || host->native_pcie_hotplug)) {


