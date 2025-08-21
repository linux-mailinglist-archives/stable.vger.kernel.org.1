Return-Path: <stable+bounces-172128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC5EB2FC90
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56EDC174A82
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51414266565;
	Thu, 21 Aug 2025 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TkYnhD5a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E418C25B1EA
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786072; cv=none; b=CeMnG77IYmuGSM7JJ3QggMKag727LJuDS68gNtt+xaX+60ylY8YeTJxlg4jfGRgZW/Y4yfuiOX8zO7Ix5lvnN0j++3t3DRR1cKsyYRv0OJhXIEfOa3uJ44T7WlGwzFd5U7uUF92W4ldIpoDwR6nuf33jneGJyB96H5uLbqeOMgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786072; c=relaxed/simple;
	bh=o43U7xP95/5rDE/yPBoKpi7b56tp8otyYKu7E853HWw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=khXl+j/kiGwivzFIua2EK7LyDWTBfRaRB7FmLC3IXgncIEEhfq/VKw8XSh8hNpKXff6DXEZ7d8AOKVMguAhjXtz0AD+qIZcNFcqqnq6uGpy5LG/tO+FQyguVlKZrMVZOLbNJYHnxeS9k2J2GyPHuWCOCcGpeHX05p+QCBcS94wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TkYnhD5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4658C4CEEB;
	Thu, 21 Aug 2025 14:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755786071;
	bh=o43U7xP95/5rDE/yPBoKpi7b56tp8otyYKu7E853HWw=;
	h=Subject:To:Cc:From:Date:From;
	b=TkYnhD5ayyN2swD/G3CcBorJe2tGDKzKSxWwTAot1IiINacV4Quuvygv0084aauKP
	 WDNr+10v6aRW+4IP4rCJ9TDs2JiKIuTk8SeA1EWb/o+QzubTPqALuFEm20EBUF1fVj
	 xXNWqeI5mRhP0FRBXOt3kAb2TAnZD87w+8OwOrqo=
Subject: FAILED: patch "[PATCH] PCI/portdrv: Use is_pciehp instead of is_hotplug_bridge" failed to apply to 6.6-stable tree
To: lukas@wunner.de,bhelgaas@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 16:20:44 +0200
Message-ID: <2025082144-poplar-glare-2f1c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1d60796a62f327cd9e0a6a0865ded7656d2c67f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082144-poplar-glare-2f1c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


