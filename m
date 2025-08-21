Return-Path: <stable+bounces-172080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5672B2FA6A
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8611CE01C6
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C234E334739;
	Thu, 21 Aug 2025 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cWWRAjjM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831DB334392
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782836; cv=none; b=KydVkOoCpArPbvSJ3rD4/sqgKyDJcsX5y4Hdx5hfcjPxCjLSBUmzn04icYE03JUUOVjCmxlkUoJAV5Ch3B5SJ0bEMPpg0ibVOUpY7PN7YrUKOxqAEXRVN9LvBMyQYEa2fJRoPhavMLbF+UzXJ0oj0fyR9HNycz3hCORrpBNw0iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782836; c=relaxed/simple;
	bh=QRVkjySTvTJWf+/Uqjy4Y8Tly2muO+mwKXCk7YOWYrY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bBkfvZVXfXiA4SjKCSDkKtGZW3iaj28/GWRCCpIYUSldbg54ax61vr9NDXHQzvVj0jIlOZSPve4KdsnFf5bvIXITdFif61HfagyawArHzdSVeGzWFih01ssglWsd5DsF7GwOqRT/7Vfclp7cdkQWAfJHO6oYPGj2RTn+cZHtO1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cWWRAjjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCACAC4CEED;
	Thu, 21 Aug 2025 13:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755782836;
	bh=QRVkjySTvTJWf+/Uqjy4Y8Tly2muO+mwKXCk7YOWYrY=;
	h=Subject:To:Cc:From:Date:From;
	b=cWWRAjjMXXWafj0Qjvpl/I29dc76Wnzp/dLAyBvQnCBVe4G+VZdryxKBny5jgXhJ2
	 ij4JdQMqVXeekdRnh0wPdP83c+aC6X40UdwOTtkWxww7TofFV0X7gyb67obF5EAxzS
	 2lLmaUcry1WhyAcbCnMZw/RiLwS9ZmvMcveMTUg8=
Subject: FAILED: patch "[PATCH] PCI/portdrv: Use is_pciehp instead of is_hotplug_bridge" failed to apply to 5.15-stable tree
To: lukas@wunner.de,bhelgaas@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:27:01 +0200
Message-ID: <2025082101-catsup-superman-c4f4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1d60796a62f327cd9e0a6a0865ded7656d2c67f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082101-catsup-superman-c4f4@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


