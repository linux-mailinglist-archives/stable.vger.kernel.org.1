Return-Path: <stable+bounces-68461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E659953266
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940BA1C25FD7
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A2F1AC421;
	Thu, 15 Aug 2024 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="um+OH/2E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E1719DF5F;
	Thu, 15 Aug 2024 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730642; cv=none; b=h5x4NODBKzgmt6gyEvyBTRGdokfrn3e14PsWB0jKOwtz6w89x5HUwVqbvorH+dQDQctDCtPp8ZIsBgzFq+4mA2ipBA3ZCVEXXH8yX5pyFcrFRXludcvAxnUY6B/x79sTXO9ghTKmFFupRynbwMFWXGJzZwa9MZr959jGYvFO0Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730642; c=relaxed/simple;
	bh=wjcpV582u/xrOg5/DtGh8xwczv0ouK32wndca+HAne4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cinUcC2YtUsxmKQIEkfaJ0JgUWALYRiJXmsU9pKWuvvpQzFsB3TTPrW3qI0rINgaaTuWfeHXsZ+cN8PtLuDXQGTRHGma7QNx3MO5IT1qPFYEFKSefKlmaqKLf59tXtvHSfFzeYHzS2EMxnje4uXLFoinS5fn0VGG8DGjgrA7Tt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=um+OH/2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EC6C32786;
	Thu, 15 Aug 2024 14:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730641;
	bh=wjcpV582u/xrOg5/DtGh8xwczv0ouK32wndca+HAne4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=um+OH/2EtYXOruyzDyYCe/LmpbkErRxiKdxablpWHmpm+My3VhsiBO6Sp/KlJpnzQ
	 ZlbV1XhlMyjKHTI7xpLBZjARdE19EJvf8oJDCbYET1S2umDtsfRQ0YC71+tL8qite4
	 AT+38sf+g4zbcSl40bGmIZ26MmXJA90o0J2EK1e8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 5.15 464/484] PCI/DPC: Fix use-after-free on concurrent DPC and hot-removal
Date: Thu, 15 Aug 2024 15:25:22 +0200
Message-ID: <20240815131959.398265890@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
User-Agent: quilt/0.67
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 11a1f4bc47362700fcbde717292158873fb847ed upstream.

Keith reports a use-after-free when a DPC event occurs concurrently to
hot-removal of the same portion of the hierarchy:

The dpc_handler() awaits readiness of the secondary bus below the
Downstream Port where the DPC event occurred.  To do so, it polls the
config space of the first child device on the secondary bus.  If that
child device is concurrently removed, accesses to its struct pci_dev
cause the kernel to oops.

That's because pci_bridge_wait_for_secondary_bus() neglects to hold a
reference on the child device.  Before v6.3, the function was only
called on resume from system sleep or on runtime resume.  Holding a
reference wasn't necessary back then because the pciehp IRQ thread
could never run concurrently.  (On resume from system sleep, IRQs are
not enabled until after the resume_noirq phase.  And runtime resume is
always awaited before a PCI device is removed.)

However starting with v6.3, pci_bridge_wait_for_secondary_bus() is also
called on a DPC event.  Commit 53b54ad074de ("PCI/DPC: Await readiness
of secondary bus after reset"), which introduced that, failed to
appreciate that pci_bridge_wait_for_secondary_bus() now needs to hold a
reference on the child device because dpc_handler() and pciehp may
indeed run concurrently.  The commit was backported to v5.10+ stable
kernels, so that's the oldest one affected.

Add the missing reference acquisition.

Abridged stack trace:

  BUG: unable to handle page fault for address: 00000000091400c0
  CPU: 15 PID: 2464 Comm: irq/53-pcie-dpc 6.9.0
  RIP: pci_bus_read_config_dword+0x17/0x50
  pci_dev_wait()
  pci_bridge_wait_for_secondary_bus()
  dpc_reset_link()
  pcie_do_recovery()
  dpc_handler()

Fixes: 53b54ad074de ("PCI/DPC: Await readiness of secondary bus after reset")
Closes: https://lore.kernel.org/r/20240612181625.3604512-3-kbusch@meta.com/
Link: https://lore.kernel.org/linux-pci/8e4bcd4116fd94f592f2bf2749f168099c480ddf.1718707743.git.lukas@wunner.de
Reported-by: Keith Busch <kbusch@kernel.org>
Tested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org # v5.10+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pci.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4916,7 +4916,7 @@ int pci_bridge_wait_for_secondary_bus(st
 				      int timeout)
 {
 	struct pci_dev *child;
-	int delay;
+	int delay, ret = 0;
 
 	if (pci_dev_is_disconnected(dev))
 		return 0;
@@ -4944,8 +4944,8 @@ int pci_bridge_wait_for_secondary_bus(st
 		return 0;
 	}
 
-	child = list_first_entry(&dev->subordinate->devices, struct pci_dev,
-				 bus_list);
+	child = pci_dev_get(list_first_entry(&dev->subordinate->devices,
+					     struct pci_dev, bus_list));
 	up_read(&pci_bus_sem);
 
 	/*
@@ -4955,7 +4955,7 @@ int pci_bridge_wait_for_secondary_bus(st
 	if (!pci_is_pcie(dev)) {
 		pci_dbg(dev, "waiting %d ms for secondary bus\n", 1000 + delay);
 		msleep(1000 + delay);
-		return 0;
+		goto put_child;
 	}
 
 	/*
@@ -4976,7 +4976,7 @@ int pci_bridge_wait_for_secondary_bus(st
 	 * until the timeout expires.
 	 */
 	if (!pcie_downstream_port(dev))
-		return 0;
+		goto put_child;
 
 	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
 		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
@@ -4987,11 +4987,16 @@ int pci_bridge_wait_for_secondary_bus(st
 		if (!pcie_wait_for_link_delay(dev, true, delay)) {
 			/* Did not train, no need to wait any further */
 			pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
-			return -ENOTTY;
+			ret = -ENOTTY;
+			goto put_child;
 		}
 	}
 
-	return pci_dev_wait(child, reset_type, timeout - delay);
+	ret = pci_dev_wait(child, reset_type, timeout - delay);
+
+put_child:
+	pci_dev_put(child);
+	return ret;
 }
 
 void pci_reset_secondary_bus(struct pci_dev *dev)



