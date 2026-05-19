Return-Path: <stable+bounces-249515-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4G71BlwxDGrdZAUAu9opvQ
	(envelope-from <stable+bounces-249515-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:46:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 737F357B8F1
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4C7C3119FF1
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861B446AEF5;
	Tue, 19 May 2026 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I9aEYREb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A24409E16
	for <stable@vger.kernel.org>; Tue, 19 May 2026 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183473; cv=none; b=Ggp7/gVvO/FUckoX91EnpEqiEqUayXz9qWFB4V3FNS/3+Q9A1KnMfRIc/ypWqT6MKhZJ3M0egkIoDZBGYo7fy4b39+DmG4XMmN/6NvDPn5H89UxnWgEGchXRkckSfrD1naRjU7LnKKycDuZK7N2fKy4fhws/j/35uHPHsxLV74s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183473; c=relaxed/simple;
	bh=Cfl5HeU8GbsLzmwir1r2fgntdNWhmulwIk0THbgRkS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FElcjMqwfogxvava0ED8xT3I240Ax+1boOGyHWGpgVCz+GsJohjxgtCvIrC/WfxvVt6qt1W+NUpGdXfrN/YswZx7trwAOwKsA2dFAc6pib2OyuQgD+l7ZCPWHRvvvH4MD+NSruNSSwjeQt9oKjku4ZE2JpiiELXVXDaUSiFmWFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I9aEYREb; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779183472; x=1810719472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cfl5HeU8GbsLzmwir1r2fgntdNWhmulwIk0THbgRkS4=;
  b=I9aEYREb6Jp3UTM0ZaWRxmRiQvDQlWDiVDDstJP2uQvSlmMemkfF7eFo
   42HLsrL2ps2hgt6fpwEXVvY6RJlTBiutQZfOCRdyYRS91o14LQJsVAuTR
   ajoxFXThttvqCzt+79ZPs3KlzZW1b0tylHAcz7oaLo5UTvYLw8WoiXIdU
   OmaR/q+5sClp6CPqBmU31hBMit0qrRdxBaOiQnnC5y9Wa02Z6RUYp4JeE
   0hSd1h6BfaPk+Kodp1cIB+IDw9aTrnnlwRafhgnDZVEPZA7AxDF2UDhAW
   i8Q/a190CM7SRLU9ybXY/SiNc+9aJS3IGC81lveaPQkkV7kjtlystIdTX
   A==;
X-CSE-ConnectionGUID: n+ciu8QCRMOuULcVPDrAeQ==
X-CSE-MsgGUID: XIsVWoutRVKd9Jb+XZ5aaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="102730389"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="102730389"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:37:51 -0700
X-CSE-ConnectionGUID: HXyYMPSVT6Wi6sTx4uD6CQ==
X-CSE-MsgGUID: wZ5457WYRRKXpKgZXij7pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="277826722"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:37:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Xifer <xiferdev@gmail.com>,
	jodeliukas@gmail.com,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 09/10] PCI: Align head space better
Date: Tue, 19 May 2026 12:36:32 +0300
Message-ID: <20260519093633.16395-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519093633.16395-1-ilpo.jarvinen@linux.intel.com>
References: <20260519093633.16395-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249515-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[leemhuis.info,gmail.com,linux.intel.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:dkim,linux.intel.com:mid,msgid.link:url]
X-Rspamd-Queue-Id: 737F357B8F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 9036bd0efcb6162a77f3bf9bacbafba7686c7275 upstream.

When a bridge window contains big and small resource(s), the small
resource(s) may not amount to the half of the size of the big resource
which would allow calculate_head_align() to shrink the head alignment.
This results in always placing the small resource(s) after the big
resource.

In general, it would be good to be able to place the small resource(s)
before the big resource to achieve better utilization of the address space.
In the cases where the large resource can only fit at the end of the
window, it is even required.

However, carrying the information over from pbus_size_mem() and
calculate_head_align() to __pci_assign_resource() and
pcibios_align_resource() is not easy with the current data structures.

A somewhat hacky way to move the non-aligning tail part to the head is
possible within pcibios_align_resource(). The free space between the start
of the free space span and the aligned start address can be compared with
the non-aligning remainder of the size. If the free space is larger than
the remainder, placing the remainder before the start address is possible.
This relocation should generally work, because PCI resources consist only
power-of-2 atoms.

Various arch requirements may still need to override the relocation, so the
relocation is only applied selectively in such cases.

Fixes: 3958bf16e2fe ("PCI: Stop over-estimating bridge window size")
Fixes: bc75c8e50711 ("PCI: Rewrite bridge window head alignment function")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221205
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221493
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Xifer <xiferdev@gmail.com>
Tested-by: Aleksandras # 6.18
Link: https://patch.msgid.link/20260324165633.4583-10-ilpo.jarvinen@linux.intel.com
---
 arch/arm/kernel/bios32.c         |  3 +++
 arch/m68k/kernel/pcibios.c       |  4 ++++
 arch/mips/pci/pci-generic.c      |  3 +++
 arch/mips/pci/pci-legacy.c       |  2 ++
 arch/parisc/kernel/pci.c         |  3 +++
 arch/powerpc/kernel/pci-common.c |  2 ++
 arch/sh/drivers/pci/pci.c        |  2 ++
 arch/x86/pci/i386.c              |  2 ++
 arch/xtensa/kernel/pci.c         |  2 ++
 drivers/pci/setup-res.c          | 39 +++++++++++++++++++++++++++++++-
 include/linux/pci.h              |  5 ++++
 kernel/resource.c                |  2 +-
 12 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index cedb83a85dd9..ac0e890510da 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -577,6 +577,9 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 		return host_bridge->align_resource(dev, res,
 				start, size, align);
 
+	if (res->flags & IORESOURCE_MEM)
+		return pci_align_resource(dev, res, empty_res, size, align);
+
 	return start;
 }
 
diff --git a/arch/m68k/kernel/pcibios.c b/arch/m68k/kernel/pcibios.c
index 7e286ee1976b..7a9e60df79c5 100644
--- a/arch/m68k/kernel/pcibios.c
+++ b/arch/m68k/kernel/pcibios.c
@@ -31,11 +31,15 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       resource_size_t size,
 				       resource_size_t align)
 {
+	struct pci_dev *dev = data;
 	resource_size_t start = res->start;
 
 	if ((res->flags & IORESOURCE_IO) && (start & 0x300))
 		start = (start + 0x3ff) & ~0x3ff;
 
+	if (res->flags & IORESOURCE_MEM)
+		return pci_align_resource(dev, res, empty_res, size, align);
+
 	return start;
 }
 
diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
index aaa1d6de8bef..c2e23d0c1d77 100644
--- a/arch/mips/pci/pci-generic.c
+++ b/arch/mips/pci/pci-generic.c
@@ -38,6 +38,9 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 		return host_bridge->align_resource(dev, res,
 				start, size, align);
 
+	if (res->flags & IORESOURCE_MEM)
+		return pci_align_resource(dev, res, empty_res, size, align);
+
 	return start;
 }
 
diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index 817e97402afe..dae6dafdd6e0 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -70,6 +70,8 @@ pcibios_align_resource(void *data, const struct resource *res,
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
 	} else if (res->flags & IORESOURCE_MEM) {
+		start = pci_align_resource(dev, res, empty_res, size, align);
+
 		/* Make sure we start at our min on all hoses */
 		if (start < PCIBIOS_MIN_MEM + hose->mem_resource->start)
 			start = PCIBIOS_MIN_MEM + hose->mem_resource->start;
diff --git a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
index f50be1a63c4c..b8007c7400d4 100644
--- a/arch/parisc/kernel/pci.c
+++ b/arch/parisc/kernel/pci.c
@@ -201,6 +201,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       resource_size_t size,
 				       resource_size_t alignment)
 {
+	struct pci_dev *dev = data;
 	resource_size_t align, start = res->start;
 
 	DBG_RES("pcibios_align_resource(%s, (%p) [%lx,%lx]/%x, 0x%lx, 0x%lx)\n",
@@ -212,6 +213,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	align = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
 	if (align > alignment)
 		start = ALIGN(start, align);
+	else
+		start = pci_align_resource(dev, res, empty_res, size, alignment);
 
 	return start;
 }
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index e7bfa15da043..8efe95a0c4ff 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1144,6 +1144,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 			return start;
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
+	} else if (res->flags & IORESOURCE_MEM) {
+		start = pci_align_resource(dev, res, empty_res, size, align);
 	}
 
 	return start;
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 7a0522316ee3..878a27a1acfb 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -185,6 +185,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 		 */
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
+	} else if (res->flags & IORESOURCE_MEM) {
+		start = pci_align_resource(dev, res, empty_res, size, align);
 	}
 
 	return start;
diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index 6fbd4b34c3f7..e2de26b82940 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -165,6 +165,8 @@ pcibios_align_resource(void *data, const struct resource *res,
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
 	} else if (res->flags & IORESOURCE_MEM) {
+		start = pci_align_resource(dev, res, empty_res, size, align);
+
 		/* The low 1MB range is reserved for ISA cards */
 		if (start < BIOS_END)
 			start = BIOS_END;
diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index 64ccb7e0d92f..305031551136 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -54,6 +54,8 @@ pcibios_align_resource(void *data, const struct resource *res,
 
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
+	} else if (res->flags & IORESOURCE_MEM) {
+		start = pci_align_resource(dev, res, empty_res, size, align);
 	}
 
 	return start;
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 050ef79621a4..991d3ed543f5 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -246,6 +246,41 @@ static int pci_revert_fw_address(struct resource *res, struct pci_dev *dev,
 	return 0;
 }
 
+/*
+ * For mem bridge windows, try to relocate tail remainder space to space
+ * before res->start if there's enough free space there. This enables
+ * tighter packing for resources.
+ */
+resource_size_t pci_align_resource(struct pci_dev *dev,
+				   const struct resource *res,
+				   const struct resource *empty_res,
+				   resource_size_t size,
+				   resource_size_t align)
+{
+	resource_size_t remainder, start_addr;
+
+	if (!(res->flags & IORESOURCE_MEM))
+		return res->start;
+
+	if (IS_ALIGNED(size, align))
+		return res->start;
+
+	remainder = size - ALIGN_DOWN(size, align);
+	/* Don't mess with size that doesn't align with window size granularity */
+	if (!IS_ALIGNED(remainder, pci_min_window_alignment(dev->bus, res->flags)))
+		return res->start;
+	/* Try to place remainder that doesn't fill align before */
+	if (res->start < remainder)
+		return res->start;
+	start_addr = res->start - remainder;
+	if (empty_res->start > start_addr)
+		return res->start;
+
+	pci_dbg(dev, "%pR: moving candidate start address below align to %llx\n",
+		res, (unsigned long long)start_addr);
+	return start_addr;
+}
+
 /*
  * We don't have to worry about legacy ISA devices, so nothing to do here.
  * This is marked as __weak because multiple architectures define it; it should
@@ -257,7 +292,9 @@ resource_size_t __weak pcibios_align_resource(void *data,
 					      resource_size_t size,
 					      resource_size_t align)
 {
-	return res->start;
+	struct pci_dev *dev = data;
+
+	return pci_align_resource(dev, res, empty_res, size, align);
 }
 
 static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ac332ff9da9f..cedf948dc614 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1210,6 +1210,11 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       const struct resource *empty_res,
 				       resource_size_t size,
 				       resource_size_t align);
+resource_size_t pci_align_resource(struct pci_dev *dev,
+				   const struct resource *res,
+				   const struct resource *empty_res,
+				   resource_size_t size,
+				   resource_size_t align);
 
 /* Generic PCI functions used internally */
 
diff --git a/kernel/resource.c b/kernel/resource.c
index 8c5fcb30fc33..d02a53fb95d8 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -766,7 +766,7 @@ static int __find_resource_space(struct resource *root, struct resource *old,
 			}
 			alloc.end = alloc.start + size - 1;
 			if (alloc.start <= alloc.end &&
-			    __resource_contains_unbound(&avail, &alloc)) {
+			    __resource_contains_unbound(&full_avail, &alloc)) {
 				new->start = alloc.start;
 				new->end = alloc.end;
 				return 0;
-- 
2.47.3


