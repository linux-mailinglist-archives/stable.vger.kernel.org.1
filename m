Return-Path: <stable+bounces-73609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A2A96DBD4
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 16:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873E02851A9
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 14:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAE55FB9C;
	Thu,  5 Sep 2024 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yj5sV8Rf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E14654F87;
	Thu,  5 Sep 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546694; cv=none; b=hYRV/dxHbGCmGb6BQjO0JjfBOSSpOpRSB19A55omNrfbI44vBQPnrr6W5s2kH3WxD6eCNrb9BkUkiIeaCQxLTU5F6lYBG7GmWQ+WL2MV2Ti/e14Hdgcz0nNG7FT6a9JZXBCjCIIt70kvdnLe9k6aggGydwe/Uo+8MYLQzr55wPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546694; c=relaxed/simple;
	bh=uGI6SGIrD/O2eBQ4Wq4v9jYmgtUXRGyG4r1dvAlrzFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L+4XtslcFXMvWPxXHQNIVqSx06rw97XCOYPKwC/HNI2icVWhiwBg+mUrghdoxXE0bKLdnScYnWKIhm8e7d/oUZ94iYz15tDE6A5CrzQJJsAhdOYBCPK+Xnrz9xWXBM/Qn2W9snvfkGT45nLRho2x8uJ/kqC0OTylGS5TRgoFePQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yj5sV8Rf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725546693; x=1757082693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uGI6SGIrD/O2eBQ4Wq4v9jYmgtUXRGyG4r1dvAlrzFM=;
  b=Yj5sV8RfKMOiwbBbhSyTCMTv980JjQ1ODr5/sKKkZ9JU34FlZHiSV91W
   U0ttmxbXv73FrVZvekoPKfCtxFI+V2TDICTA0bFbV0zQjN4cmhLP/U2Al
   YM/jeR6kUHXyU0hgFVhJ/yzHOGGHG2crbgRV3/FFJpuAGhzw2zWo1TrLY
   ghfo5zy+9WKkzKexLyFNq1ySxvZi58YhFasIsltg/6ENHvnQ25fiUmyIG
   GGcPTsT/FH5MUna3I3PSFcUPecqOeekDC0H91sIX+i39+Si1BMlKCyudK
   lPPfjkiqJT7umueLDw4DcMQqxeWQOwm79+CzT4y19byAICqmq+8rkFr7p
   A==;
X-CSE-ConnectionGUID: qqrLFIq6RnueAyUiz5M15Q==
X-CSE-MsgGUID: Yf882uCmTACDAD6RGlMCBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="49677561"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="49677561"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 07:31:33 -0700
X-CSE-ConnectionGUID: qgWnCSLvROWaQC2raElYlw==
X-CSE-MsgGUID: Ism/uomFQDWtq9U3m0egiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="88883235"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmviesa002.fm.intel.com with ESMTP; 05 Sep 2024 07:31:31 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 11/12] xhci: Set quirky xHC PCI hosts to D3 _after_ stopping and freeing them.
Date: Thu,  5 Sep 2024 17:32:59 +0300
Message-Id: <20240905143300.1959279-12-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240905143300.1959279-1-mathias.nyman@linux.intel.com>
References: <20240905143300.1959279-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI xHC host should be stopped and xhci driver memory freed before putting
host to PCI D3 state during PCI remove callback.

Hosts with XHCI_SPURIOUS_WAKEUP quirk did this the wrong way around
and set the host to D3 before calling usb_hcd_pci_remove(dev), which will
access the host to stop it, and then free xhci.

Fixes: f1f6d9a8b540 ("xhci: don't dereference a xhci member after removing xhci")
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-pci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 526739af2070..de50f5ba60df 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -657,8 +657,10 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 void xhci_pci_remove(struct pci_dev *dev)
 {
 	struct xhci_hcd *xhci;
+	bool set_power_d3;
 
 	xhci = hcd_to_xhci(pci_get_drvdata(dev));
+	set_power_d3 = xhci->quirks & XHCI_SPURIOUS_WAKEUP;
 
 	xhci->xhc_state |= XHCI_STATE_REMOVING;
 
@@ -671,11 +673,11 @@ void xhci_pci_remove(struct pci_dev *dev)
 		xhci->shared_hcd = NULL;
 	}
 
+	usb_hcd_pci_remove(dev);
+
 	/* Workaround for spurious wakeups at shutdown with HSW */
-	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
+	if (set_power_d3)
 		pci_set_power_state(dev, PCI_D3hot);
-
-	usb_hcd_pci_remove(dev);
 }
 EXPORT_SYMBOL_NS_GPL(xhci_pci_remove, xhci);
 
-- 
2.25.1


