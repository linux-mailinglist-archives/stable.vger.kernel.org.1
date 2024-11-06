Return-Path: <stable+bounces-90095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD669BE3E5
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 11:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5CE71F24DB6
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 10:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682F41DE3B3;
	Wed,  6 Nov 2024 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqiXLC+6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34A61DE3AE;
	Wed,  6 Nov 2024 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887994; cv=none; b=p+GSUanuRM9yTl3FaIB+K0MercnYt17QsQTs8VhXozPzZJl/CxxffoUNQ6uxIYrhBJD2VIO7xINPMdPxHV5SMEyaJ8IZdcKDp5Z0TwBJkye+nzeQljIGadf0/qkc26FSR5YI7HydIzcP/b9DmM+kaNC5NSS3CcPceAOagB3ETT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887994; c=relaxed/simple;
	bh=eiWAtX+LR2y5YPx9QJM5LcvI9XMM/eNw/g1OXKd0iig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZJiCvIFjUtOt1yHOEqNlW9n9ilVBIivKXTrsGsp6Cnf2Y7EYp94If6xAkGEbdCqjFy3OzBE7ODU0bRPWi57VV3z0KrZfRZI5kMovVd7alKRqVidqsBOPHD8vtVIgk+nRHc/85IgeZ855k1EeorMujl9r7ALmURcJpDTM4s9qcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqiXLC+6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730887993; x=1762423993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eiWAtX+LR2y5YPx9QJM5LcvI9XMM/eNw/g1OXKd0iig=;
  b=hqiXLC+6hFajf+yWwbvutSN1+WTvyZMgU3BJVxkVHGwEEGDK7fT7Mz1E
   lC9yoicpzGGmoebXSuyVyLgP21bDTZMFezffw5fQUEMkU+/Rjls7J/cGR
   oJdbfQJTNJg9AjXtZcNhuAs+5pT+7L0hQYzhAgauqKDAeLXT278D9/xIk
   W6cdBZhQ1UcITyvBKcQJOFK4gB0Sj5YjU/Z3ZgACc+wpoJV4r0kykekNp
   qo3gIEkM9rlVzJ7BHrI4MMFpbCxc7TvW7b58ClL8E4MJVJtcjDYhQIW0o
   u8cLKaF7pKo7eLCHAjT3bYQ27s7SvxSs4FrkIivbIOX+oYa/VSQskWBiI
   w==;
X-CSE-ConnectionGUID: pRx6GauJQkezCM8QPH/P7Q==
X-CSE-MsgGUID: z+20Qs1KQDibeObsP14IDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="42059417"
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="42059417"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 02:13:12 -0800
X-CSE-ConnectionGUID: hZWE9wsDRyauQJ/7MpLLIg==
X-CSE-MsgGUID: jPIVNyTZRk6oEXAkNopYoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="84813213"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmviesa010.fm.intel.com with ESMTP; 06 Nov 2024 02:13:11 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Kuangyi Chiang <ki.chiang65@gmail.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 17/33] xhci: Combine two if statements for Etron xHCI host
Date: Wed,  6 Nov 2024 12:14:43 +0200
Message-Id: <20241106101459.775897-18-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106101459.775897-1-mathias.nyman@linux.intel.com>
References: <20241106101459.775897-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuangyi Chiang <ki.chiang65@gmail.com>

Combine two if statements, because these hosts have the same
quirk flags applied.

[Mathias: has stable tag because other fixes in series depend on this]

Fixes: 91f7a1524a92 ("xhci: Apply broken streams quirk to Etron EJ188 xHCI host")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-pci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 7803ff1f1c9f..db3c7e738213 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -394,12 +394,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
-			pdev->device == PCI_DEVICE_ID_EJ168) {
-		xhci->quirks |= XHCI_RESET_ON_RESUME;
-		xhci->quirks |= XHCI_BROKEN_STREAMS;
-	}
-	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
-			pdev->device == PCI_DEVICE_ID_EJ188) {
+	    (pdev->device == PCI_DEVICE_ID_EJ168 ||
+	     pdev->device == PCI_DEVICE_ID_EJ188)) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
-- 
2.25.1


