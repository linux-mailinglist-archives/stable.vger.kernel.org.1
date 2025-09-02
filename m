Return-Path: <stable+bounces-176985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D359B3FD0F
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 12:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340B117995A
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 10:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6072F548D;
	Tue,  2 Sep 2025 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aNszoWJO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ECC2F5462;
	Tue,  2 Sep 2025 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810404; cv=none; b=jyL8aUiwPoXXzJ1u//NXnTtarYAI6VyJvn2K6xBCQ/URn5g+CY7UcXAv1pvCjlAAFVmu5HLNoIMpFzJLoTzAuAv+PfdZeaU8qNf9ETQCPp+EYGQUqoB0rgK6qHK6d6+AHdXTODPIaYmRQ4Jbps7o0Vc758goNS5v6Loioxi/X7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810404; c=relaxed/simple;
	bh=/gCB6WlvMhpjTnQIW9fQa+utrVlQOJYK8p0PmDQ4Xss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkoUQxw6YVPq/WQxhWKRtzeciN8gDZXlTpKvkJDeX/+v41Lt3lDoQOILelD2qE8F2mMFwMbjXKQ/RuGA2jmFiW/oNCFWjviNNLvGJFfWpO4TUfcgNuCM9YQmoMNDaP1IelkUJp6au0l/t6PjnywU9H8GQT41ZI+8xm8AkxH42V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aNszoWJO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756810402; x=1788346402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/gCB6WlvMhpjTnQIW9fQa+utrVlQOJYK8p0PmDQ4Xss=;
  b=aNszoWJOMVy2SLoC/oD/bcNknnpKwfC9lQfrct0bDSwOdZgNGJjmOphr
   zBi0ili8uA8ysWEBYTpLVeJEO0cn3CaPySniUCVaHQDkY8yi8inoxHNhD
   O0pLTnYD0UiJo6bDCPPrT+cTw0mjSi6dtA5z/IvGd3Y6kZh4NKWh+l0tv
   O4DYMdjEnHa5kDCGTFkoJJtbWTBAP2h2BlBwKRcF4zUv5GBfBA4NIucgO
   RILU2HOS5HeVf0Pw/cwGqB6DXFiOMGr4OV65AiNXwuRwLyzLmNp1Z07jZ
   mYZE6E7CgyeSfpOCgHI2Te2eNv649aU9Akhk65EuhIREd8Z5kTpL7UF62
   Q==;
X-CSE-ConnectionGUID: k1BBHM2xSiizYJU4CsSZVw==
X-CSE-MsgGUID: gvARtAXuRva1/2LtB37dXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="76678017"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="76678017"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:53:22 -0700
X-CSE-ConnectionGUID: T+W0tHl8SDyhEuDaMzGfhA==
X-CSE-MsgGUID: aNFcd6WRRwCT+HKEbXJRDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="171609576"
Received: from johunt-mobl9.ger.corp.intel.com (HELO mnyman-desk.intel.com) ([10.245.245.90])
  by fmviesa008.fm.intel.com with ESMTP; 02 Sep 2025 03:53:20 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	David Wang <00107082@163.com>,
	Michal Pecio <michal.pecio@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] xhci: fix memory leak regression when freeing xhci vdev devices depth first
Date: Tue,  2 Sep 2025 13:53:06 +0300
Message-ID: <20250902105306.877476-4-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902105306.877476-1-mathias.nyman@linux.intel.com>
References: <20250902105306.877476-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Suspend-resume cycle test revealed a memory leak in 6.17-rc3

Turns out the slot_id race fix changes accidentally ends up calling
xhci_free_virt_device() with an incorrect vdev parameter.
The vdev variable was reused for temporary purposes right before calling
xhci_free_virt_device().

Fix this by passing the correct vdev parameter.

The slot_id race fix that caused this regression was targeted for stable,
so this needs to be applied there as well.

Fixes: 2eb03376151b ("usb: xhci: Fix slot_id resource race conflict")
Reported-by: David Wang <00107082@163.com>
Closes: https://lore.kernel.org/linux-usb/20250829181354.4450-1-00107082@163.com
Suggested-by: Michal Pecio <michal.pecio@gmail.com>
Suggested-by: David Wang <00107082@163.com>
Cc: stable@vger.kernel.org
Tested-by: David Wang <00107082@163.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 81eaad87a3d9..c4a6544aa107 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -962,7 +962,7 @@ static void xhci_free_virt_devices_depth_first(struct xhci_hcd *xhci, int slot_i
 out:
 	/* we are now at a leaf device */
 	xhci_debugfs_remove_slot(xhci, slot_id);
-	xhci_free_virt_device(xhci, vdev, slot_id);
+	xhci_free_virt_device(xhci, xhci->devs[slot_id], slot_id);
 }
 
 int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,
-- 
2.43.0


