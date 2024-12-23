Return-Path: <stable+bounces-105926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C2A9FB253
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2408D1885C39
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193E41A8F80;
	Mon, 23 Dec 2024 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RfAU41ao"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5388827;
	Mon, 23 Dec 2024 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970607; cv=none; b=h66+yuIsOMy1KCrTLScBvBhuedQK7/SgTRVhK82UiHYhQL2LHuKjCo3FewxxgkhILjpsBg2WeK7R3plRDr3B4T326PeT49Z/3crdyIpLAlsyOOa1tjKQlNBhJWkpFbjyejPdlywhC5+NzRZl4pcjAGiuOrMMD0MqjJk/VARkGmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970607; c=relaxed/simple;
	bh=m8nKUOE9dP+clf0bXGDg9b5rdm3JEmHLTnK8wt1I5NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBuLF6cpdP33QlfGrjx928wQr/msTiNPduUcUIsVpcD9J42L64B4H5mXaI/Bbo7jWfgFeVjU/BLwURbu1YeFlUK9e3RxJPmXiI3EFGYNKkP0EpvN+I3CsPxhIAkyIel1yz9mLSYt/QpY6DCMQXRVY67Sa1VIux7nYLt5fuAeYgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RfAU41ao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345BCC4CED3;
	Mon, 23 Dec 2024 16:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734970607;
	bh=m8nKUOE9dP+clf0bXGDg9b5rdm3JEmHLTnK8wt1I5NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RfAU41ao7ieHJGwM4vpXEXCGOO0pxIOAPgyt86vgU5TUqXKOok7CMnxAvW21jmJzs
	 M2sa896hoFT/YBZI70fa7UKPyd8DjcIjs6sHxDvg+fVeBs9hVwFyVRaVGbFRdtoi7B
	 SyndDnFoyGlo8pOS4+7F/qJYmAHCSXU9a75+b4pg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Daniel Walker (danielwa)" <danielwa@cisco.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 16/83] p2sb: Do not scan and remove the P2SB device when it is unhidden
Date: Mon, 23 Dec 2024 16:58:55 +0100
Message-ID: <20241223155354.263418921@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223155353.641267612@linuxfoundation.org>
References: <20241223155353.641267612@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[ Upstream commit 360c400d0f568636c1b98d1d5f9f49aa3d420c70 ]

When drivers access P2SB device resources, it calls p2sb_bar(). Before
the commit 5913320eb0b3 ("platform/x86: p2sb: Allow p2sb_bar() calls
during PCI device probe"), p2sb_bar() obtained the resources and then
called pci_stop_and_remove_bus_device() for clean up. Then the P2SB
device disappeared. The commit 5913320eb0b3 introduced the P2SB device
resource cache feature in the boot process. During the resource cache,
pci_stop_and_remove_bus_device() is called for the P2SB device, then the
P2SB device disappears regardless of whether p2sb_bar() is called or
not. Such P2SB device disappearance caused a confusion [1]. To avoid the
confusion, avoid the pci_stop_and_remove_bus_device() call when the BIOS
does not hide the P2SB device.

For that purpose, cache the P2SB device resources only if the BIOS hides
the P2SB device. Call p2sb_scan_and_cache() only if p2sb_hidden_by_bios
is true. This allows removing two branches from p2sb_scan_and_cache().
When p2sb_bar() is called, get the resources from the cache if the P2SB
device is hidden. Otherwise, read the resources from the unhidden P2SB
device.

Reported-by: Daniel Walker (danielwa) <danielwa@cisco.com>
Closes: https://lore.kernel.org/lkml/ZzTI+biIUTvFT6NC@goliath/ [1]
Fixes: 5913320eb0b3 ("platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20241128002836.373745-5-shinichiro.kawasaki@wdc.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/p2sb.c | 42 +++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
index 6fb76b82ecce..eff920de31c2 100644
--- a/drivers/platform/x86/p2sb.c
+++ b/drivers/platform/x86/p2sb.c
@@ -100,10 +100,8 @@ static int p2sb_scan_and_cache(struct pci_bus *bus, unsigned int devfn)
 	/*
 	 * The BIOS prevents the P2SB device from being enumerated by the PCI
 	 * subsystem, so we need to unhide and hide it back to lookup the BAR.
-	 * Unhide the P2SB device here, if needed.
 	 */
-	if (p2sb_hidden_by_bios)
-		pci_bus_write_config_dword(bus, devfn, P2SBC, 0);
+	pci_bus_write_config_dword(bus, devfn, P2SBC, 0);
 
 	/* Scan the P2SB device and cache its BAR0 */
 	p2sb_scan_and_cache_devfn(bus, devfn);
@@ -112,9 +110,7 @@ static int p2sb_scan_and_cache(struct pci_bus *bus, unsigned int devfn)
 	if (devfn == P2SB_DEVFN_GOLDMONT)
 		p2sb_scan_and_cache_devfn(bus, SPI_DEVFN_GOLDMONT);
 
-	/* Hide the P2SB device, if it was hidden */
-	if (p2sb_hidden_by_bios)
-		pci_bus_write_config_dword(bus, devfn, P2SBC, P2SBC_HIDE);
+	pci_bus_write_config_dword(bus, devfn, P2SBC, P2SBC_HIDE);
 
 	if (!p2sb_valid_resource(&p2sb_resources[PCI_FUNC(devfn)].res))
 		return -ENOENT;
@@ -141,7 +137,7 @@ static int p2sb_cache_resources(void)
 	u32 value = P2SBC_HIDE;
 	struct pci_bus *bus;
 	u16 class;
-	int ret;
+	int ret = 0;
 
 	/* Get devfn for P2SB device itself */
 	p2sb_get_devfn(&devfn_p2sb);
@@ -167,7 +163,12 @@ static int p2sb_cache_resources(void)
 	pci_bus_read_config_dword(bus, devfn_p2sb, P2SBC, &value);
 	p2sb_hidden_by_bios = value & P2SBC_HIDE;
 
-	ret = p2sb_scan_and_cache(bus, devfn_p2sb);
+	/*
+	 * If the BIOS does not hide the P2SB device then its resources
+	 * are accesilble. Cache them only if the P2SB device is hidden.
+	 */
+	if (p2sb_hidden_by_bios)
+		ret = p2sb_scan_and_cache(bus, devfn_p2sb);
 
 	pci_unlock_rescan_remove();
 
@@ -190,6 +191,26 @@ static int p2sb_read_from_cache(struct pci_bus *bus, unsigned int devfn,
 	return 0;
 }
 
+static int p2sb_read_from_dev(struct pci_bus *bus, unsigned int devfn,
+			      struct resource *mem)
+{
+	struct pci_dev *pdev;
+	int ret = 0;
+
+	pdev = pci_get_slot(bus, devfn);
+	if (!pdev)
+		return -ENODEV;
+
+	if (p2sb_valid_resource(pci_resource_n(pdev, 0)))
+		p2sb_read_bar0(pdev, mem);
+	else
+		ret = -ENOENT;
+
+	pci_dev_put(pdev);
+
+	return ret;
+}
+
 /**
  * p2sb_bar - Get Primary to Sideband (P2SB) bridge device BAR
  * @bus: PCI bus to communicate with
@@ -213,7 +234,10 @@ int p2sb_bar(struct pci_bus *bus, unsigned int devfn, struct resource *mem)
 	if (!devfn)
 		p2sb_get_devfn(&devfn);
 
-	return p2sb_read_from_cache(bus, devfn, mem);
+	if (p2sb_hidden_by_bios)
+		return p2sb_read_from_cache(bus, devfn, mem);
+
+	return p2sb_read_from_dev(bus, devfn, mem);
 }
 EXPORT_SYMBOL_GPL(p2sb_bar);
 
-- 
2.39.5




