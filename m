Return-Path: <stable+bounces-90098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C52B9BE3ED
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 11:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D847A1F24DC9
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 10:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87ED1DE4E1;
	Wed,  6 Nov 2024 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PyBwKEgd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3771DE3D5;
	Wed,  6 Nov 2024 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887999; cv=none; b=iIyd6PkeKf4UZAHGQ4HmH63E0Q8LnAs1bFlgToBq0/gDNUKdiDFvcieIiD8iQ9A+kSlCEBa7LcOwPjtObgr2Cn4ubd+0SPOvRl2qgLei/CFVBbOdCQ0JnTw3P2/srG7Rt5WdWH8sWA46bNhwAKGeE2nMFYgau2gwxbKKYsWSvME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887999; c=relaxed/simple;
	bh=VZZfAXWLhzUpGIEWB5aCTnkjLh25KfYAmGZfjfAoBuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jYpzDOd2O9OdWyNx9PxzMiNR5v8GAHFolgBPxkH4lTRddv99+BwaAI4YSzHWEWyzAzOyxs+PqUuOnrj7HDbO3PdoJcfTOxZY3bmD5qK3G2At8KTIw6Akx5FXcWJySeYY0VSmq5S1nNrF7F8qcH1j3ViewUlHfkp7eF1Z93M2Yfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PyBwKEgd; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730887998; x=1762423998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VZZfAXWLhzUpGIEWB5aCTnkjLh25KfYAmGZfjfAoBuk=;
  b=PyBwKEgdF2EWeHYBzb2sT8gqXR33ibsvC3FikgnKgzoZ/9U7TrUbZwWd
   LicwFv5W80tXFLog5yoLDlZ6Ya8CHQEEyvgdr3skvTSPv4r0W4ddJRp6M
   uc7gUSgP2k22a0n3A1C+4AlZmmq03TkYoi3VBef8abu5MWt3ITAAXuT+z
   dnFE3fKJUthW/GuIte7wZ9Nj1NjYxRjRldkq57Lo0tK0EOxrZf9mVA/Xl
   DUDxB1fRFcnD5rYvBGeFFrQUIFYq7iBsnwc2XGBttuLHwWLOz4UywDi4p
   RJikuHYFaFfWmZdFOcbYJY30vFkdYuEQndo94w8kgPb0XbQzdvlB40Mg1
   w==;
X-CSE-ConnectionGUID: Qy0sWWn/SeeWQgUjsfInaA==
X-CSE-MsgGUID: 7Rt49zR7Qle3rEznEU9M5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="42059433"
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="42059433"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 02:13:17 -0800
X-CSE-ConnectionGUID: iH3Q+aYpSEammDgYnTsC+g==
X-CSE-MsgGUID: PkwTEmJNTr+59k7Rs2qaPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="84813280"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmviesa010.fm.intel.com with ESMTP; 06 Nov 2024 02:13:16 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Kuangyi Chiang <ki.chiang65@gmail.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 20/33] xhci: Don't perform Soft Retry for Etron xHCI host
Date: Wed,  6 Nov 2024 12:14:46 +0200
Message-Id: <20241106101459.775897-21-mathias.nyman@linux.intel.com>
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

Since commit f8f80be501aa ("xhci: Use soft retry to recover faster from
transaction errors"), unplugging USB device while enumeration results in
errors like this:

[ 364.855321] xhci_hcd 0000:0b:00.0: ERROR Transfer event for disabled endpoint slot 5 ep 2
[ 364.864622] xhci_hcd 0000:0b:00.0: @0000002167656d70 67f03000 00000021 0c000000 05038001
[ 374.934793] xhci_hcd 0000:0b:00.0: Abort failed to stop command ring: -110
[ 374.958793] xhci_hcd 0000:0b:00.0: xHCI host controller not responding, assume dead
[ 374.967590] xhci_hcd 0000:0b:00.0: HC died; cleaning up
[ 374.973984] xhci_hcd 0000:0b:00.0: Timeout while waiting for configure endpoint command

Seems that Etorn xHCI host can not perform Soft Retry correctly, apply
XHCI_NO_SOFT_RETRY quirk to disable Soft Retry and then issue is gone.

This patch depends on commit a4a251f8c235 ("usb: xhci: do not perform
Soft Retry for some xHCI hosts").

Fixes: f8f80be501aa ("xhci: Use soft retry to recover faster from transaction errors")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 4b8c93e59d6d..0d49d9c390c1 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -399,6 +399,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_ETRON_HOST;
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
+		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
-- 
2.25.1


