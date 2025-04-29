Return-Path: <stable+bounces-137891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF013AA158A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F8017790B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE04D24E016;
	Tue, 29 Apr 2025 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dIqu9IZ+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9B9224AE6;
	Tue, 29 Apr 2025 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947446; cv=none; b=V769mgdvNekBnKbdHDmycGAAN+OuytRtNR1YDf6ujpBeCCmAvCpSTHiNTsb9N+eq4MZvTf371z63hygCefEgs0vKpXvgMAVAmw2xMqI/Sl0ic7Jn8hF3gOcJzlUcF/Yinzjl5dtASDRmGPnV6ToTkbNDOHy1MeHXebEdO2d58ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947446; c=relaxed/simple;
	bh=RuVIyE6tUO6lreeOoxhANsf+xIDxLyjoGl1W7lbcWk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5gkmt09+Cb6eVNG00r/7JbRoYRrSgjb0KsNYSicUOXX9YUurK7D+X/Hv5Md2cID+5vVAbCJOnFMjasWWkOgo9jFrrFbumyO+GI+7ZAKvVHEu2CVSCfXFE+dUHzK+DTb/glIpd5UlmQYkVK6HrkNpx+UJWAGyNPcFcTSPzWVl/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dIqu9IZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206A4C4CEE3;
	Tue, 29 Apr 2025 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947446;
	bh=RuVIyE6tUO6lreeOoxhANsf+xIDxLyjoGl1W7lbcWk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dIqu9IZ+K9abphEOg7gpBlhiLqL2coe7PUVJwm52itjXXmTUPgHgr7//vSHjUXi5a
	 rjDLNMHxj2OSx5nqQ1YZIDK2BDejYXmWOXxyg+YHV9MkrwGhZ7ZM9VfNOW5iw5el51
	 +YtJeT//EGOX6Q8tt6oKBXJsv8cjCKVuazqOVbhg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jon Hunter <jonathanh@nvidia.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH 5.10 283/286] PCI: Fix use-after-free in pci_bus_release_domain_nr()
Date: Tue, 29 Apr 2025 18:43:07 +0200
Message-ID: <20250429161119.553094668@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
User-Agent: quilt/0.68
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring <robh@kernel.org>

commit 30ba2d09edb5ea857a1473ae3d820911347ada62 upstream.

Commit c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
introduced a use-after-free bug in the bus removal cleanup. The issue was
found with kfence:

  [   19.293351] BUG: KFENCE: use-after-free read in pci_bus_release_domain_nr+0x10/0x70

  [   19.302817] Use-after-free read at 0x000000007f3b80eb (in kfence-#115):
  [   19.309677]  pci_bus_release_domain_nr+0x10/0x70
  [   19.309691]  dw_pcie_host_deinit+0x28/0x78
  [   19.309702]  tegra_pcie_deinit_controller+0x1c/0x38 [pcie_tegra194]
  [   19.309734]  tegra_pcie_dw_probe+0x648/0xb28 [pcie_tegra194]
  [   19.309752]  platform_probe+0x90/0xd8
  ...

  [   19.311457] kfence-#115: 0x00000000063a155a-0x00000000ba698da8, size=1072, cache=kmalloc-2k

  [   19.311469] allocated by task 96 on cpu 10 at 19.279323s:
  [   19.311562]  __kmem_cache_alloc_node+0x260/0x278
  [   19.311571]  kmalloc_trace+0x24/0x30
  [   19.311580]  pci_alloc_bus+0x24/0xa0
  [   19.311590]  pci_register_host_bridge+0x48/0x4b8
  [   19.311601]  pci_scan_root_bus_bridge+0xc0/0xe8
  [   19.311613]  pci_host_probe+0x18/0xc0
  [   19.311623]  dw_pcie_host_init+0x2c0/0x568
  [   19.311630]  tegra_pcie_dw_probe+0x610/0xb28 [pcie_tegra194]
  [   19.311647]  platform_probe+0x90/0xd8
  ...

  [   19.311782] freed by task 96 on cpu 10 at 19.285833s:
  [   19.311799]  release_pcibus_dev+0x30/0x40
  [   19.311808]  device_release+0x30/0x90
  [   19.311814]  kobject_put+0xa8/0x120
  [   19.311832]  device_unregister+0x20/0x30
  [   19.311839]  pci_remove_bus+0x78/0x88
  [   19.311850]  pci_remove_root_bus+0x5c/0x98
  [   19.311860]  dw_pcie_host_deinit+0x28/0x78
  [   19.311866]  tegra_pcie_deinit_controller+0x1c/0x38 [pcie_tegra194]
  [   19.311883]  tegra_pcie_dw_probe+0x648/0xb28 [pcie_tegra194]
  [   19.311900]  platform_probe+0x90/0xd8
  ...

  [   19.313579] CPU: 10 PID: 96 Comm: kworker/u24:2 Not tainted 6.2.0 #4
  [   19.320171] Hardware name:  /, BIOS 1.0-d7fb19b 08/10/2022
  [   19.325852] Workqueue: events_unbound deferred_probe_work_func

The stack trace is a bit misleading as dw_pcie_host_deinit() doesn't
directly call pci_bus_release_domain_nr(). The issue turns out to be in
pci_remove_root_bus() which first calls pci_remove_bus() which frees the
struct pci_bus when its struct device is released. Then
pci_bus_release_domain_nr() is called and accesses the freed struct
pci_bus. Reordering these fixes the issue.

Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
Link: https://lore.kernel.org/r/20230329123835.2724518-1-robh@kernel.org
Link: https://lore.kernel.org/r/b529cb69-0602-9eed-fc02-2f068707a006@nvidia.com
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable@vger.kernel.org	# v6.2+
Cc: Pali Rohár <pali@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/remove.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -156,8 +156,6 @@ void pci_remove_root_bus(struct pci_bus
 	list_for_each_entry_safe(child, tmp,
 				 &bus->devices, bus_list)
 		pci_remove_bus_device(child);
-	pci_remove_bus(bus);
-	host_bridge->bus = NULL;
 
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 	/* Release domain_nr if it was dynamically allocated */
@@ -165,6 +163,9 @@ void pci_remove_root_bus(struct pci_bus
 		pci_bus_release_domain_nr(bus, host_bridge->dev.parent);
 #endif
 
+	pci_remove_bus(bus);
+	host_bridge->bus = NULL;
+
 	/* remove the host bridge */
 	device_del(&host_bridge->dev);
 }



