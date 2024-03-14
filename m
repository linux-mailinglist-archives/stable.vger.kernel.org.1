Return-Path: <stable+bounces-28143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AA687BC15
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 12:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A544B20F19
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 11:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFBA6EB6E;
	Thu, 14 Mar 2024 11:43:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1802.securemx.jp [210.130.202.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95E71A38DD
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710416605; cv=none; b=ujetlscx75DVq7Zdt7xsMKrw/kEEMOAPD5kbua2hVFtCn2P2T88ksPSRt9yjmpiX5PrS+Q8zaO2+gJ38DiSGVSirIljFgupz8tpGVlOj2147rB56I3QsMr9hfdnBtWXNKOw6iJZxCjbraSW2cD/YOMBf4Xn9ykSQYhvZVIJQqGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710416605; c=relaxed/simple;
	bh=l7DwAg40MNAKHvGEJF0WaNiu7y8jVBK3YitQ2Jj4Byk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=f3LklnP4jClLjkOblkigSxcJEUTNwZzRMmCA9dskjiku2ZyfepkKT6TjMNe1AE/Jj04yMaxorU4qoXGoNfC3dEKzjjN3P62b/GddgYFdRoAkyIQrmn3bkZCmf5Q3spsJf80pU5IJqrbp9ex3DdjXJE5sWOTb+2b+6QpLnrDllhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; arc=none smtp.client-ip=210.130.202.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1802) id 42EAqwQQ3795038; Thu, 14 Mar 2024 19:53:06 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 42EAqHLT410594; Thu, 14 Mar 2024 19:52:17 +0900
X-Iguazu-Qid: 2yAajzvdaI1wuJo8Lj
X-Iguazu-QSIG: v=2; s=0; t=1710413536; q=2yAajzvdaI1wuJo8Lj; m=7pYOjxe2OIceNMUWS9IFKbfZD9EJ9O2XHNbVSn3PYR4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 42EAqFKa594432
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 14 Mar 2024 19:52:16 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, carnil@debian.org,
        Hans de Goede <hdegoede@redhat.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 6.1.y, 6.6.y, 6.7.y] platform/x86: p2sb: On Goldmont only cache P2SB and SPI devfn BAR
Date: Thu, 14 Mar 2024 19:51:52 +0900
X-TSB-HOP2: ON
Message-Id: <1710413512-7184-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

commit aec7d25b497ce4a8d044e9496de0aa433f7f8f06 upstream.

On Goldmont p2sb_bar() only ever gets called for 2 devices, the actual P2SB
devfn 13,0 and the SPI controller which is part of the P2SB, devfn 13,2.

But the current p2sb code tries to cache BAR0 info for all of
devfn 13,0 to 13,7 . This involves calling pci_scan_single_device()
for device 13 functions 0-7 and the hw does not seem to like
pci_scan_single_device() getting called for some of the other hidden
devices. E.g. on an ASUS VivoBook D540NV-GQ065T this leads to continuous
ACPI errors leading to high CPU usage.

Fix this by only caching BAR0 info and thus only calling
pci_scan_single_device() for the P2SB and the SPI controller.

Fixes: 5913320eb0b3 ("platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe")
Reported-by: Danil Rybakov <danilrybakov249@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218531
Tested-by: Danil Rybakov <danilrybakov249@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240304134356.305375-2-hdegoede@redhat.com
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>

---
 drivers/platform/x86/p2sb.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
index 17cc4b45e023..a64f56ddd4a4 100644
--- a/drivers/platform/x86/p2sb.c
+++ b/drivers/platform/x86/p2sb.c
@@ -20,9 +20,11 @@
 #define P2SBC_HIDE		BIT(8)
 
 #define P2SB_DEVFN_DEFAULT	PCI_DEVFN(31, 1)
+#define P2SB_DEVFN_GOLDMONT	PCI_DEVFN(13, 0)
+#define SPI_DEVFN_GOLDMONT	PCI_DEVFN(13, 2)
 
 static const struct x86_cpu_id p2sb_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	PCI_DEVFN(13, 0)),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT, P2SB_DEVFN_GOLDMONT),
 	{}
 };
 
@@ -98,21 +100,12 @@ static void p2sb_scan_and_cache_devfn(struct pci_bus *bus, unsigned int devfn)
 
 static int p2sb_scan_and_cache(struct pci_bus *bus, unsigned int devfn)
 {
-	unsigned int slot, fn;
-
-	if (PCI_FUNC(devfn) == 0) {
-		/*
-		 * When function number of the P2SB device is zero, scan it and
-		 * other function numbers, and if devices are available, cache
-		 * their BAR0s.
-		 */
-		slot = PCI_SLOT(devfn);
-		for (fn = 0; fn < NR_P2SB_RES_CACHE; fn++)
-			p2sb_scan_and_cache_devfn(bus, PCI_DEVFN(slot, fn));
-	} else {
-		/* Scan the P2SB device and cache its BAR0 */
-		p2sb_scan_and_cache_devfn(bus, devfn);
-	}
+	/* Scan the P2SB device and cache its BAR0 */
+	p2sb_scan_and_cache_devfn(bus, devfn);
+
+	/* On Goldmont p2sb_bar() also gets called for the SPI controller */
+	if (devfn == P2SB_DEVFN_GOLDMONT)
+		p2sb_scan_and_cache_devfn(bus, SPI_DEVFN_GOLDMONT);
 
 	if (!p2sb_valid_resource(&p2sb_resources[PCI_FUNC(devfn)].res))
 		return -ENOENT;
-- 
2.43.0



