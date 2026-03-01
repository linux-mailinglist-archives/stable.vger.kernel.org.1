Return-Path: <stable+bounces-222101-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NdyGryho2mRIwUAu9opvQ
	(envelope-from <stable+bounces-222101-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:17:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 133B11CD643
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB14E3275102
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2037C3002C8;
	Sun,  1 Mar 2026 01:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJlQhFNo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61672F39BE;
	Sun,  1 Mar 2026 01:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329900; cv=none; b=stRoNAX4OUO+x6Rd4q+jfE71xaaA7/XdGY3K6bA2wP7jhki2o19j0n7m5TMw2yNXRiC6+BoRdEJiHrOTB3GHhY/IylVRi8N2jawODhCFzjJwZPCdZEuj9chLABasQusRMIk4NEC3OKqeC3on1ZAfFzZvOfNhmadY/YWBm6HaO9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329900; c=relaxed/simple;
	bh=7CRA10bqyxM6nxp0YP/yYLBECZXSBAeOtLOEOXJWH8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YVpERolLwtDez66t0Aeg6DGyTldgQHJoM6aiDxn/pNX5GEeY3rdqrpfCW+wb3tRdJqHJs/68U12nQZudNSboQH9f0l0rsQNDI4CNDgvV95Iry1Pb30wa9tXyQX0reeQFWnU6Rmke0PYByfWomsyn8t8SmQ8bSq1kT4gUZxVDc6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJlQhFNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6750C19421;
	Sun,  1 Mar 2026 01:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329900;
	bh=7CRA10bqyxM6nxp0YP/yYLBECZXSBAeOtLOEOXJWH8w=;
	h=From:To:Cc:Subject:Date:From;
	b=IJlQhFNoCrWbzxoV1ZWg/RLKiHr2hn64G2r7MqxjnXaRqGgBAkXs0lgz7mDik4Cna
	 vqezsEzX4IGZTxrjCuriLyQ6Ml08dgtRumYC5c1K6E/aJIixq0vhBt0SuvpWYpi2/D
	 N8/qfn4Q/aTJalp3dI+WcqiVEV2ZLrZYH+yY9Qxq81g8NpZfI8EMR2fUv3rglhNf5A
	 +l1dHqvoxQTVKAS36/QK1kLsHdg/D4/voxjMLCieL7x6PhhqSZLkjZpOfr64HL3nYM
	 y/b16pSr6I3rcns5+U7rueAEniGi8IYfT/eMUfrPSZHnaHoGS4B6VdKHlkmWdQJrge
	 +l/2/U1pSmiDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	briannorris@chromium.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-pci@vger.kernel.org
Subject: FAILED: Patch "PCI/PM: Prevent runtime suspend until devices are fully initialized" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:51:38 -0500
Message-ID: <20260301015138.1718025-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222101-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,chromium.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: 133B11CD643
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 51c0996dadaea20d73eb0495aeda9cb0422243e8 Mon Sep 17 00:00:00 2001
From: Brian Norris <briannorris@chromium.org>
Date: Thu, 22 Jan 2026 09:48:15 -0800
Subject: [PATCH] PCI/PM: Prevent runtime suspend until devices are fully
 initialized

Previously, it was possible for a PCI device to be runtime-suspended before
it was fully initialized. When that happened, the suspend process could
save invalid device state, for example, before BAR assignment. Restoring
the invalid state during resume may leave the device non-functional.

Prevent runtime suspend for PCI devices until they are fully initialized by
deferring pm_runtime_enable().

More details on how exactly this may occur:

  1. PCI device is created by pci_scan_slot() or similar

  2. As part of pci_scan_slot(), pci_pm_init() puts the device in D0 and
     prevents runtime suspend prevented via pm_runtime_forbid()

  3. pci_device_add() adds the underlying 'struct device' via device_add(),
     which means user space can allow runtime suspend, e.g.,

       echo auto > /sys/bus/pci/devices/.../power/control

  4. PCI device receives BAR configuration
     (pci_assign_unassigned_bus_resources(), etc.)

  5. pci_bus_add_device() applies final fixups, saves device state, and
     tries to attach a driver

The device may potentially be suspended between #3 and #5, so this is racy
with user space (udev or similar).

Many PCI devices are enumerated at subsys_initcall time and so will not
race with user space, but devices created later by hotplug or modular
pwrctrl or host controller drivers are susceptible to this race.

More runtime PM details at the first Link: below.

Link: https://lore.kernel.org/all/0e35a4e1-894a-47c1-9528-fc5ffbafd9e2@samsung.com/
Signed-off-by: Brian Norris <briannorris@chromium.org>
[bhelgaas: update comments per https://lore.kernel.org/r/CAJZ5v0iBNOmMtqfqEbrYyuK2u+2J2+zZ-iQd1FvyCPjdvU2TJg@mail.gmail.com]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260122094815.v5.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid
---
 drivers/pci/bus.c | 8 ++++++++
 drivers/pci/pci.c | 8 +++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 4383a36fd6ca0..41e5c45e38b5e 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -379,6 +380,13 @@ void pci_bus_add_device(struct pci_dev *dev)
 		put_device(&pdev->dev);
 	}
 
+	/*
+	 * Enable runtime PM, which potentially allows the device to
+	 * suspend immediately, only after the PCI state has been
+	 * configured completely.
+	 */
+	pm_runtime_enable(&dev->dev);
+
 	if (!dn || of_device_is_available(dn))
 		pci_dev_allow_binding(dev);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 86ccbd0efb495..d5f4b52899ada 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3199,8 +3199,14 @@ void pci_pm_init(struct pci_dev *dev)
 poweron:
 	pci_pm_power_up_and_verify_state(dev);
 	pm_runtime_forbid(&dev->dev);
+
+	/*
+	 * Runtime PM will be enabled for the device when it has been fully
+	 * configured, but since its parent and suppliers may suspend in
+	 * the meantime, prevent them from doing so by changing the
+	 * device's runtime PM status to "active".
+	 */
 	pm_runtime_set_active(&dev->dev);
-	pm_runtime_enable(&dev->dev);
 }
 
 static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
-- 
2.51.0





