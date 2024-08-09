Return-Path: <stable+bounces-66263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5B194D064
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 14:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041C41C20D53
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11793194A51;
	Fri,  9 Aug 2024 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0hD7d/B"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6883E1946D1;
	Fri,  9 Aug 2024 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207349; cv=none; b=Bz+urIX0HhpYzfDqm0Qt4DO6R+j5R6VQsKFhR3p2g8YdY/GLmJ9l20sRqu++CqJaeoUHaZrg7asq8nBzssvbZkWRggYTLEekJsDfZ0P9rdczTvuMke2gb9s4aTk/H2y5WKieJOrypq8+rO469B5WdpgOgj1M32TZZQXnUUH1AoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207349; c=relaxed/simple;
	bh=mrRLj2dMPicPoVdGssgYUJyUt94R7FX/32VQ7phXNxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r4VD+lv801JkxjaOVqc89BPjhX8JNzQz1tMHfrG24dmRgvxZ1BZ8cRbCjO+2YvDQhi5cLUCbdduJvrJeBLyLx3kEiL1dS+fyZjAtQmSgXGgmKynbLEKez0iGASPE0FlImUF/3dCuZ7oHW9vG7NgwM/MRf/EvNNtG+CIEw8TsOjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0hD7d/B; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723207348; x=1754743348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mrRLj2dMPicPoVdGssgYUJyUt94R7FX/32VQ7phXNxI=;
  b=S0hD7d/Bc+objFHTGj88vcB8te4gN3UdQgzTU0+RNpLdboXSjeujP+jB
   qfeUvB024WDUMS9R7uT5SC9/APnDfj0IMlm8kca7bzUx9stHGTZ86eMJ+
   Z+hOKPoJLVdvhBmYBGAUITYVX82foR5Bi3xzCdZNjyUcDmVtcaBCCxQFA
   UumVjVV01u4pL12lNnc2kzJCyM8RV/d1oKn/xIwIoUS9sS89H/XOR+hK8
   oT6YabiI6w7FoQHy8IgNVKdSnFr0WSWBfBBudHFQr09szx2ChzE+8GjMn
   URnB1pwDtBHmjq11Tn2Ty4uaEYqsKTRwzUmwZgYKXD6gkDBM2rHVTNpcv
   g==;
X-CSE-ConnectionGUID: Ozbq3iAhQJKOF+UAQDTRCA==
X-CSE-MsgGUID: QPYZFIaHRQWvPH3gWvqWhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32768611"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="32768611"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 05:42:28 -0700
X-CSE-ConnectionGUID: 2APYhJCISeOGnLluIimoWA==
X-CSE-MsgGUID: kVuM3rqOS2K/d+J4P8QDEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57473988"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by orviesa009.jf.intel.com with ESMTP; 09 Aug 2024 05:42:26 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] usb: xhci: Check for xhci->interrupters being allocated in xhci_mem_clearup()
Date: Fri,  9 Aug 2024 15:44:07 +0300
Message-Id: <20240809124408.505786-2-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809124408.505786-1-mathias.nyman@linux.intel.com>
References: <20240809124408.505786-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Zyngier <maz@kernel.org>

If xhci_mem_init() fails, it calls into xhci_mem_cleanup() to mop
up the damage. If it fails early enough, before xhci->interrupters
is allocated but after xhci->max_interrupters has been set, which
happens in most (all?) cases, things get uglier, as xhci_mem_cleanup()
unconditionally derefences xhci->interrupters. With prejudice.

Gate the interrupt freeing loop with a check on xhci->interrupters
being non-NULL.

Found while debugging a DMA allocation issue that led the XHCI driver
on this exact path.

Fixes: c99b38c41234 ("xhci: add support to allocate several interrupters")
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org # 6.8+
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index d7654f475daf..937ce5fd5809 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1872,7 +1872,7 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
 
 	cancel_delayed_work_sync(&xhci->cmd_timer);
 
-	for (i = 0; i < xhci->max_interrupters; i++) {
+	for (i = 0; xhci->interrupters && i < xhci->max_interrupters; i++) {
 		if (xhci->interrupters[i]) {
 			xhci_remove_interrupter(xhci, xhci->interrupters[i]);
 			xhci_free_interrupter(xhci, xhci->interrupters[i]);
-- 
2.25.1


