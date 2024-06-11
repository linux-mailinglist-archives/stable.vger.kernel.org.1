Return-Path: <stable+bounces-50152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 898F0903B5E
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 14:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329561F244CE
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 12:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A8D17BB1B;
	Tue, 11 Jun 2024 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RR92QDtL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7597E17BB03;
	Tue, 11 Jun 2024 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107473; cv=none; b=PlHDsqfhj2PAnqenpL6tcCGeb11DgF2mSQfC7/tGQ8Nt0q892BbCooiGaCfVooh+c9hmKB5QXuP2bz+rpIq1JTjGC4gmZkGKsEAC/aetLQZXfUIVr/1XUBqEkZNoezPEa2/kT0gXuYk03y/T1YKRkIEqSld0xoJAX0A4yaYfFeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107473; c=relaxed/simple;
	bh=L/XqlaATQ5L2nB1nKSC4asLA3WxkfcILDCl56wqJrfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tjq0FNvGsuw708oTI4ibx8WuL/4cRG6j+leycYEMWVqlVaeS5ZvxuFK8tbEyLe9wDZOOtpCjkUpjC/P51JUVoso/qfmBzdRg3XYh7JbJKMvSjTiWZM/KF5Ny5goRfR2zLGmC21KTwL2bmYvLKUr4o+r0lztssYHVIMBYbKO35OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RR92QDtL; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718107472; x=1749643472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L/XqlaATQ5L2nB1nKSC4asLA3WxkfcILDCl56wqJrfk=;
  b=RR92QDtLly7kGvJ4+spHvbr793sm78UhVGBTWVkSS9RpOVNY5QmnoIZL
   DjoV3N9Zh9dHVW3JCCfERvWzFSjaUm65qBtMJCBRxFbm1khGz6GOPZ00p
   92iIiZMwhBIpGSf68kx40j7x412OJa3I3FSxvmB7KhpAvUdaS2ATxKMXn
   Bfv5nnJLuu6bSYvneIQSsafriSQTMqV/UDwOWDjpytGcbm9WHJYzdAhuV
   VXdAjI52jyylnxzBMYb3p8UV8A2sNr/Qh/5DATRfYLNrWjyvqAYcr9B/y
   R/2+CMO49pVFdB3UqaXa/jPtK6HyUSf3rsz0URkg0QBmmkY1qLi318bsV
   A==;
X-CSE-ConnectionGUID: 3ap7P1lhSsq6IlbxEYXA9A==
X-CSE-MsgGUID: AKQ4zeTkSE2abb6bhHkhAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18641756"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="18641756"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 05:04:32 -0700
X-CSE-ConnectionGUID: RfX+raOZR7qrS+zdkIUV1g==
X-CSE-MsgGUID: 6K/UjChsS1u/RDQ76gQZ5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="76879657"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by orviesa001.jf.intel.com with ESMTP; 11 Jun 2024 05:04:31 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Kuangyi Chiang <ki.chiang65@gmail.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 3/4] xhci: Apply broken streams quirk to Etron EJ188 xHCI host
Date: Tue, 11 Jun 2024 15:06:09 +0300
Message-Id: <20240611120610.3264502-4-mathias.nyman@linux.intel.com>
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

As described in commit 8f873c1ff4ca ("xhci: Blacklist using streams on the
Etron EJ168 controller"), EJ188 have the same issue as EJ168, where Streams
do not work reliable on EJ188. So apply XHCI_BROKEN_STREAMS quirk to EJ188
as well.

Cc: <stable@vger.kernel.org>
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index dd8256e4e02a..05881153883e 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -397,8 +397,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
-			pdev->device == PCI_DEVICE_ID_EJ188)
+			pdev->device == PCI_DEVICE_ID_EJ188) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
+		xhci->quirks |= XHCI_BROKEN_STREAMS;
+	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
 	    pdev->device == 0x0014) {
-- 
2.25.1


