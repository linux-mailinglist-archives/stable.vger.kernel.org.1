Return-Path: <stable+bounces-62285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB3B93E802
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14255B227CB
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69561552E0;
	Sun, 28 Jul 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbFXAwGP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6245A154C0A;
	Sun, 28 Jul 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182898; cv=none; b=Nt7ONs2JTysyMai4tDLABghd8aYVIioNTKITqa0ch8U2VIlLoVCVSrAkGO7HoBAlmG8FJidd1TfroAS/f82SHiT03bhSljvjYkoKWzw/YJUkpmG+AH6SyTEeU2eJNIWFD2AtkBszPhJbrlj6Vmv/edNjhS3eswtqPDA+Gdk2VMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182898; c=relaxed/simple;
	bh=1wRiXKI28klhdNkstnKT428yfv9pv9fYkM0i20goWNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2LN8b/osvasGTCAHompps4ZosKlf5uyuo1zpqJt4zoVv6tPowrYxlT1QEVQc/PbmJjdbQNt0fv0nwyv7XYYcEFXsplzqKDfKyOLA9/oJ/SapJ7Hvcje9piVklGt9pkiMJ8PW5W+PdqSM/pc9Dw1A0luSsYyywcqcU+Mfr76SmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbFXAwGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EBDC32782;
	Sun, 28 Jul 2024 16:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182898;
	bh=1wRiXKI28klhdNkstnKT428yfv9pv9fYkM0i20goWNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbFXAwGP7dwZO8JOhKARH7BZ4VJST987IQdDkmu/Iap0Lr3apskVZ6pOSoONp40UQ
	 UuuEFsqostIUyjUcLUmUTMPCpxaMGFHd9J4eZ6Nx0G/Wbln/mdiB5iVqksfJ5kO0Mn
	 CgNvVbKIWCe3ieNGncSuD6Umt3MGd+p3nk4s1dFYjMLbxUHFQ8TYi59zkyAHacSRW8
	 oFVLOupM7m2NNHzHtrOtOB7whfIHLXEf2pV7b4o9WSbfKP8HO+1oa2xHi0vkbkVMoi
	 nLBEtekmwcI1X1RpbXT5LgyW6yGP6Eu6BYkOE9jOov8/GsuhVsRL0ZMWbVcEIBB4Mi
	 D11ubduDseRVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vidya Sagar <vidyas@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	will@kernel.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 02/15] PCI: Use preserve_config in place of pci_flags
Date: Sun, 28 Jul 2024 12:07:46 -0400
Message-ID: <20240728160813.2053107-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160813.2053107-1-sashal@kernel.org>
References: <20240728160813.2053107-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Vidya Sagar <vidyas@nvidia.com>

[ Upstream commit 7246a4520b4bf1494d7d030166a11b5226f6d508 ]

Use preserve_config in place of checking for PCI_PROBE_ONLY flag to enable
support for "linux,pci-probe-only" on a per host bridge basis.

This also obviates the use of adding PCI_REASSIGN_ALL_BUS flag if
!PCI_PROBE_ONLY, as pci_assign_unassigned_root_bus_resources() takes care
of reassigning the resources that are not already claimed.

Link: https://lore.kernel.org/r/20240508174138.3630283-5-vidyas@nvidia.com
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-host-common.c |  4 ----
 drivers/pci/probe.c                      | 20 +++++++++-----------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index d3924a44db02f..fd3020a399cf9 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -73,10 +73,6 @@ int pci_host_common_probe(struct platform_device *pdev)
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
-	/* Do not reassign resources if probe only */
-	if (!pci_has_flag(PCI_PROBE_ONLY))
-		pci_add_flags(PCI_REASSIGN_ALL_BUS);
-
 	bridge->sysdata = cfg;
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 	bridge->msi_domain = true;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e19b79821dd6d..908f930a0f428 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3066,20 +3066,18 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 
 	bus = bridge->bus;
 
+	/* If we must preserve the resource configuration, claim now */
+	if (bridge->preserve_config)
+		pci_bus_claim_resources(bus);
+
 	/*
-	 * We insert PCI resources into the iomem_resource and
-	 * ioport_resource trees in either pci_bus_claim_resources()
-	 * or pci_bus_assign_resources().
+	 * Assign whatever was left unassigned. If we didn't claim above,
+	 * this will reassign everything.
 	 */
-	if (pci_has_flag(PCI_PROBE_ONLY)) {
-		pci_bus_claim_resources(bus);
-	} else {
-		pci_bus_size_bridges(bus);
-		pci_bus_assign_resources(bus);
+	pci_assign_unassigned_root_bus_resources(bus);
 
-		list_for_each_entry(child, &bus->children, node)
-			pcie_bus_configure_settings(child);
-	}
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
 
 	pci_bus_add_devices(bus);
 	return 0;
-- 
2.43.0


