Return-Path: <stable+bounces-50151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFAE903B5A
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 14:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF411284325
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 12:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2099517B511;
	Tue, 11 Jun 2024 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kL0ohCOJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D40017B437;
	Tue, 11 Jun 2024 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107471; cv=none; b=A/K4OtJ0TSQ723j0OtkyEqWYvE+nmDUjriofXvM4S9wLjVJsZ8WVdZOV4Y9XFUcmz4AyBwI0o7Rpq1k1GQaMCmUc+5ilJ8XlkYHHZLJXOreJHRAs95No4XC/X9D4kqSnFlECyamL230xd6P5SRsUT2LG65A4tuoabMVHIrnizh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107471; c=relaxed/simple;
	bh=FOaE2PstEhFjh4wEaU+eChjM+aBc8E33yTqCu+HkY/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ieLILeUIYJ4xKSchoZINznyzQ5fOKzAjXXexy/12IQwd/u4gPBkzhG9iZvaUgijsSNSHp3q0bi3qGnWvPg+Q2CVM03kURIg0xZXyQJoLkWsYcb9bUJ3oZYzE+ZY09fceEzoVBny/qaU6fgqeKqTJkQ/KqLFvlWe4TuXGUG/l9+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kL0ohCOJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718107470; x=1749643470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FOaE2PstEhFjh4wEaU+eChjM+aBc8E33yTqCu+HkY/E=;
  b=kL0ohCOJpI3/Nkt4Iii98vupeQIXPrgKOM5D/66xZHqzo5tvBeTi1oGS
   vixz+lOx0odHaFg2GcYcJTVfTh8WYVbmIc5rh2mRDiue1AKm97tgZKYI5
   ilkEl5js5bF/lHOcK9qQ1RMiuyIJVyTQ7WN/um7MfZzqxPO/DSKlqdXuI
   dR6hxZdGUnx0ohEd7X0PQOxuJHxIwwVIMR0b1AUEc6PV8ChMINwG2MUu/
   10Yj8Tczuw2fpThKTeJnfDzk6MOyFgsvdXre/VdTbU3ywiWjXjA/s1t/H
   2C/iAaO6l8EPFY75iIHqY/RN68gB4iZovLEyhopXlhiywtXdluStOBqri
   A==;
X-CSE-ConnectionGUID: sIAHlajKT3CpGDa1bZCZEQ==
X-CSE-MsgGUID: 0vCNxJ/cRpmz8Nj3E9gc5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18641751"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="18641751"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 05:04:30 -0700
X-CSE-ConnectionGUID: rckRqGqcQtqQOJeKuH1Znw==
X-CSE-MsgGUID: yDDokXqSRBiwWlH3asPzQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="76879639"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by orviesa001.jf.intel.com with ESMTP; 11 Jun 2024 05:04:29 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Kuangyi Chiang <ki.chiang65@gmail.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 2/4] xhci: Apply reset resume quirk to Etron EJ188 xHCI host
Date: Tue, 11 Jun 2024 15:06:08 +0300
Message-Id: <20240611120610.3264502-3-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240611120610.3264502-1-mathias.nyman@linux.intel.com>
References: <20240611120610.3264502-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuangyi Chiang <ki.chiang65@gmail.com>

As described in commit c877b3b2ad5c ("xhci: Add reset on resume quirk for
asrock p67 host"), EJ188 have the same issue as EJ168, where completely
dies on resume. So apply XHCI_RESET_ON_RESUME quirk to EJ188 as well.

Cc: <stable@vger.kernel.org>
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index c040d816e626..dd8256e4e02a 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -36,6 +36,7 @@
 
 #define PCI_VENDOR_ID_ETRON		0x1b6f
 #define PCI_DEVICE_ID_EJ168		0x7023
+#define PCI_DEVICE_ID_EJ188		0x7052
 
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI	0x8c31
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
@@ -395,6 +396,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
+	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
+			pdev->device == PCI_DEVICE_ID_EJ188)
+		xhci->quirks |= XHCI_RESET_ON_RESUME;
+
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
 	    pdev->device == 0x0014) {
 		xhci->quirks |= XHCI_ZERO_64B_REGS;
-- 
2.25.1


