Return-Path: <stable+bounces-188193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C352CBF268F
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 271304F889B
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011FE284883;
	Mon, 20 Oct 2025 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhdiG6Cr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B385227466A
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977522; cv=none; b=gaUDJTdD6CyOwHxC3N2ed3/rbYCKpYMuzE0g8Da33TNEjUQ8oinNaNZyJHjUj8FLH8Ld+C5780tltZ4/a12T72elGXEBySJgyLR7HFkopG+4iocgbsTVyhi8KglHpSPRC1HjaNPQPglT+EBg8QeT44tQJbByoTMtTVH/E1TBrOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977522; c=relaxed/simple;
	bh=GdyQ55GIX/cyzx41+pc0+D/xh4luTCdVFRoG1HEsUD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIEw/Q8T2mK9zOV388OTaeyWk8AdoC1sBanDnWPDhjnFmYaNjUPWGKHgXwkysls8HZM7f8ud32cQ2N4++glK98LLFmabUcj9sNp40gCtcaeGtsp0H62BbG//4MKmVvPZiWZzJBQzDD5F4Y8ht65BuDh6l2ET6VycyDgwmIBehZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhdiG6Cr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC81C116B1;
	Mon, 20 Oct 2025 16:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760977522;
	bh=GdyQ55GIX/cyzx41+pc0+D/xh4luTCdVFRoG1HEsUD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WhdiG6Cr30KnVNPmvLOFl6+HfS17qJZJG9IhMqaXUu8H4W+uc16ETi4ZIHCs6OUQ3
	 ZNBlT5vLyJbEoywFYymkr5hB8FQ/fSBkLeev1yzQLCAYQYt/LQv0rpNL0i/Cm5nsQ3
	 oSqgZ2LWEec8RZiQyEIvZD/xCqdRfBl7RHQvm7UlVRyg+BnG3xxHqb8p1k9fh5w7bF
	 RaZXnhQrXCMKCpqr+pVTN4uawB4nJAqgfAJUnx6LY0Ri5mat3A4C/UXLwZ23TUKiiw
	 wYoAnB5Jdd+qFeNO+Ulc+hF1dvCaMA5zBeJLzDXQe9UUnIokpWPPbGQlQumR2kVo39
	 jGMJRK4uWiiUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date: Mon, 20 Oct 2025 12:25:17 -0400
Message-ID: <20251020162518.1838256-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020162518.1838256-1-sashal@kernel.org>
References: <2025101636-tartar-brethren-067c@gregkh>
 <20251020162518.1838256-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Krzysztof Wilczyński <kw@linux.com>

[ Upstream commit ad025f8e46f3dbf09b1bf8d7a5b4ce858df74544 ]

The sysfs_emit() and sysfs_emit_at() functions were introduced to make it
less ambiguous which function is preferred when writing to the output
buffer in a device attribute's "show" callback [1].

Convert the PCI sysfs object "show" functions from sprintf(), snprintf()
and scnprintf() to sysfs_emit() and sysfs_emit_at() accordingly, as the
latter is aware of the PAGE_SIZE buffer and correctly returns the number of
bytes written into the buffer.

No functional change intended.

[1] Documentation/filesystems/sysfs.rst

[bhelgaas: drop dsm_label_utf16s_to_utf8s(), link speed/width changes]
Link: https://lore.kernel.org/r/20210416205856.3234481-10-kw@linux.com
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Stable-dep-of: 48991e493507 ("PCI/sysfs: Ensure devices are powered for config reads")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci-label.c | 10 +++---
 drivers/pci/pci-sysfs.c | 72 ++++++++++++++++++++---------------------
 2 files changed, 40 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index cd84cf52a92e1..6c406453b49f4 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -62,13 +62,11 @@ static size_t find_smbios_instance_string(struct pci_dev *pdev, char *buf,
 				donboard->devfn == devfn) {
 			if (buf) {
 				if (attribute == SMBIOS_ATTR_INSTANCE_SHOW)
-					return scnprintf(buf, PAGE_SIZE,
-							 "%d\n",
-							 donboard->instance);
+					return sysfs_emit(buf, "%d\n",
+							  donboard->instance);
 				else if (attribute == SMBIOS_ATTR_LABEL_SHOW)
-					return scnprintf(buf, PAGE_SIZE,
-							 "%s\n",
-							 dmi->name);
+					return sysfs_emit(buf, "%s\n",
+							  dmi->name);
 			}
 			return strlen(dmi->name);
 		}
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5a9d942198586..3fddd421bbe66 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -39,7 +39,7 @@ field##_show(struct device *dev, struct device_attribute *attr, char *buf)				\
 	struct pci_dev *pdev;						\
 									\
 	pdev = to_pci_dev(dev);						\
-	return sprintf(buf, format_string, pdev->field);		\
+	return sysfs_emit(buf, format_string, pdev->field);		\
 }									\
 static DEVICE_ATTR_RO(field)
 
@@ -56,7 +56,7 @@ static ssize_t broken_parity_status_show(struct device *dev,
 					 char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	return sprintf(buf, "%u\n", pdev->broken_parity_status);
+	return sysfs_emit(buf, "%u\n", pdev->broken_parity_status);
 }
 
 static ssize_t broken_parity_status_store(struct device *dev,
@@ -129,7 +129,7 @@ static ssize_t power_state_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%s\n", pci_power_name(pdev->current_state));
+	return sysfs_emit(buf, "%s\n", pci_power_name(pdev->current_state));
 }
 static DEVICE_ATTR_RO(power_state);
 
@@ -138,10 +138,10 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
-	char *str = buf;
 	int i;
 	int max;
 	resource_size_t start, end;
+	size_t len = 0;
 
 	if (pci_dev->subordinate)
 		max = DEVICE_COUNT_RESOURCE;
@@ -151,12 +151,12 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 	for (i = 0; i < max; i++) {
 		struct resource *res =  &pci_dev->resource[i];
 		pci_resource_to_user(pci_dev, i, res, &start, &end);
-		str += sprintf(str, "0x%016llx 0x%016llx 0x%016llx\n",
-			       (unsigned long long)start,
-			       (unsigned long long)end,
-			       (unsigned long long)res->flags);
+		len += sysfs_emit_at(buf, len, "0x%016llx 0x%016llx 0x%016llx\n",
+				     (unsigned long long)start,
+				     (unsigned long long)end,
+				     (unsigned long long)res->flags);
 	}
-	return (str - buf);
+	return len;
 }
 static DEVICE_ATTR_RO(resource);
 
@@ -165,8 +165,8 @@ static ssize_t max_link_speed_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%s\n",
-		       pci_speed_string(pcie_get_speed_cap(pdev)));
+	return sysfs_emit(buf, "%s\n",
+			  pci_speed_string(pcie_get_speed_cap(pdev)));
 }
 static DEVICE_ATTR_RO(max_link_speed);
 
@@ -175,7 +175,7 @@ static ssize_t max_link_width_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%u\n", pcie_get_width_cap(pdev));
+	return sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
 }
 static DEVICE_ATTR_RO(max_link_width);
 
@@ -193,7 +193,7 @@ static ssize_t current_link_speed_show(struct device *dev,
 
 	speed = pcie_link_speed[linkstat & PCI_EXP_LNKSTA_CLS];
 
-	return sprintf(buf, "%s\n", pci_speed_string(speed));
+	return sysfs_emit(buf, "%s\n", pci_speed_string(speed));
 }
 static DEVICE_ATTR_RO(current_link_speed);
 
@@ -208,7 +208,7 @@ static ssize_t current_link_width_show(struct device *dev,
 	if (err)
 		return -EINVAL;
 
-	return sprintf(buf, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 		(linkstat & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT);
 }
 static DEVICE_ATTR_RO(current_link_width);
@@ -225,7 +225,7 @@ static ssize_t secondary_bus_number_show(struct device *dev,
 	if (err)
 		return -EINVAL;
 
-	return sprintf(buf, "%u\n", sec_bus);
+	return sysfs_emit(buf, "%u\n", sec_bus);
 }
 static DEVICE_ATTR_RO(secondary_bus_number);
 
@@ -241,7 +241,7 @@ static ssize_t subordinate_bus_number_show(struct device *dev,
 	if (err)
 		return -EINVAL;
 
-	return sprintf(buf, "%u\n", sub_bus);
+	return sysfs_emit(buf, "%u\n", sub_bus);
 }
 static DEVICE_ATTR_RO(subordinate_bus_number);
 
@@ -251,7 +251,7 @@ static ssize_t ari_enabled_show(struct device *dev,
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 
-	return sprintf(buf, "%u\n", pci_ari_enabled(pci_dev->bus));
+	return sysfs_emit(buf, "%u\n", pci_ari_enabled(pci_dev->bus));
 }
 static DEVICE_ATTR_RO(ari_enabled);
 
@@ -260,11 +260,11 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 
-	return sprintf(buf, "pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02X\n",
-		       pci_dev->vendor, pci_dev->device,
-		       pci_dev->subsystem_vendor, pci_dev->subsystem_device,
-		       (u8)(pci_dev->class >> 16), (u8)(pci_dev->class >> 8),
-		       (u8)(pci_dev->class));
+	return sysfs_emit(buf, "pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02X\n",
+			  pci_dev->vendor, pci_dev->device,
+			  pci_dev->subsystem_vendor, pci_dev->subsystem_device,
+			  (u8)(pci_dev->class >> 16), (u8)(pci_dev->class >> 8),
+			  (u8)(pci_dev->class));
 }
 static DEVICE_ATTR_RO(modalias);
 
@@ -302,7 +302,7 @@ static ssize_t enable_show(struct device *dev, struct device_attribute *attr,
 	struct pci_dev *pdev;
 
 	pdev = to_pci_dev(dev);
-	return sprintf(buf, "%u\n", atomic_read(&pdev->enable_cnt));
+	return sysfs_emit(buf, "%u\n", atomic_read(&pdev->enable_cnt));
 }
 static DEVICE_ATTR_RW(enable);
 
@@ -338,7 +338,7 @@ static ssize_t numa_node_store(struct device *dev,
 static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
-	return sprintf(buf, "%d\n", dev->numa_node);
+	return sysfs_emit(buf, "%d\n", dev->numa_node);
 }
 static DEVICE_ATTR_RW(numa_node);
 #endif
@@ -348,7 +348,7 @@ static ssize_t dma_mask_bits_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%d\n", fls64(pdev->dma_mask));
+	return sysfs_emit(buf, "%d\n", fls64(pdev->dma_mask));
 }
 static DEVICE_ATTR_RO(dma_mask_bits);
 
@@ -356,7 +356,7 @@ static ssize_t consistent_dma_mask_bits_show(struct device *dev,
 					     struct device_attribute *attr,
 					     char *buf)
 {
-	return sprintf(buf, "%d\n", fls64(dev->coherent_dma_mask));
+	return sysfs_emit(buf, "%d\n", fls64(dev->coherent_dma_mask));
 }
 static DEVICE_ATTR_RO(consistent_dma_mask_bits);
 
@@ -366,9 +366,9 @@ static ssize_t msi_bus_show(struct device *dev, struct device_attribute *attr,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pci_bus *subordinate = pdev->subordinate;
 
-	return sprintf(buf, "%u\n", subordinate ?
-		       !(subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI)
-			   : !pdev->no_msi);
+	return sysfs_emit(buf, "%u\n", subordinate ?
+			  !(subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI)
+			    : !pdev->no_msi);
 }
 
 static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
@@ -545,7 +545,7 @@ static ssize_t d3cold_allowed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	return sprintf(buf, "%u\n", pdev->d3cold_allowed);
+	return sysfs_emit(buf, "%u\n", pdev->d3cold_allowed);
 }
 static DEVICE_ATTR_RW(d3cold_allowed);
 #endif
@@ -559,7 +559,7 @@ static ssize_t devspec_show(struct device *dev,
 
 	if (np == NULL)
 		return 0;
-	return sprintf(buf, "%pOF", np);
+	return sysfs_emit(buf, "%pOF", np);
 }
 static DEVICE_ATTR_RO(devspec);
 #endif
@@ -605,7 +605,7 @@ static ssize_t driver_override_show(struct device *dev,
 	ssize_t len;
 
 	device_lock(dev);
-	len = scnprintf(buf, PAGE_SIZE, "%s\n", pdev->driver_override);
+	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
 	device_unlock(dev);
 	return len;
 }
@@ -681,11 +681,11 @@ static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
 	struct pci_dev *vga_dev = vga_default_device();
 
 	if (vga_dev)
-		return sprintf(buf, "%u\n", (pdev == vga_dev));
+		return sysfs_emit(buf, "%u\n", (pdev == vga_dev));
 
-	return sprintf(buf, "%u\n",
-		!!(pdev->resource[PCI_ROM_RESOURCE].flags &
-		   IORESOURCE_ROM_SHADOW));
+	return sysfs_emit(buf, "%u\n",
+			  !!(pdev->resource[PCI_ROM_RESOURCE].flags &
+			     IORESOURCE_ROM_SHADOW));
 }
 static DEVICE_ATTR_RO(boot_vga);
 
-- 
2.51.0


