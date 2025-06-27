Return-Path: <stable+bounces-158786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD95AEBA17
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 16:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E683B253D
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3732E7177;
	Fri, 27 Jun 2025 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HlK11Ao9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027613234;
	Fri, 27 Jun 2025 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035296; cv=none; b=gbmluQcA7B+/26koKD27P41S6KwWbUjYm93Mihc/BygkL6+Gsnk/HsoLSn1rJcwyCqjC5VttxtpQIwneh1iLsMZz4LgyjLOtWqAObQd0cFRy1N1bjBcLOgduRrmZdPOwdAIeMXzekxfpbQo8ZMosakfaKDoNh5s9zJT/h1ds6zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035296; c=relaxed/simple;
	bh=DkSV88qksqUtLKJI7ol90y8ckHSURyruXuGh6rf06DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFy6tH0YcqFvG3McMiKGmsS3ePPYENX79L1e0iXnuyJ4j70XtT79fMcWdKR6nqupv0HwupILGwGqJ1kK67TjcMiwob1CP0+2BZ6dyXfR/OMTgCFXY3mvE5gbeDxP8xL8oJGRMXFFjs4BIH/kXzl/MB7+ix15u2yY+oIlhqKRCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HlK11Ao9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751035295; x=1782571295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DkSV88qksqUtLKJI7ol90y8ckHSURyruXuGh6rf06DU=;
  b=HlK11Ao9C2E0tXr73sR/qn/meNHwczf/xtB1u5aSMYUdKj8Qthzir8sh
   t+RZh464WQXAg/aE3vbnhG9GyRuRhH9pxmBfdBfF3Wykcu1c9bGHjv0Oy
   BmzP0h2Jle/tkzAOjRpDFjG343ixnjj7FHjrOh5YoPs+pHKlZ9q+aBIGj
   YDs4F3EV33FfLXqjVurdZghFvRq2AUAH4Rz8rp/K/ITHreGE/XogHsSlR
   3GvsFqi0a6LoFiNmkB6Spspbx+AuuFcW+rZxw3tfN3kdk+04ZBzdsDndf
   4W/ej8aYh7DUaW17knSTbUuHp84p3ojyFMMRzcJG4NpocX1zj5P/HazGz
   w==;
X-CSE-ConnectionGUID: dBgZyzSfTkSOhUinuIu9kQ==
X-CSE-MsgGUID: zh1EmXz+SIGLYCxGcPaDlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53444934"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="53444934"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 07:41:34 -0700
X-CSE-ConnectionGUID: F+BBiHYaQheEKYjgAMG6Mw==
X-CSE-MsgGUID: C1z0T1TMSHe3QODxTj1Xeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="156872916"
Received: from unknown (HELO mnyman-desk.fi.intel.com) ([10.237.72.199])
  by fmviesa003.fm.intel.com with ESMTP; 27 Jun 2025 07:41:33 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Hongyu Xie <xiehongyu1@kylinos.cn>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 2/4] xhci: Disable stream for xHC controller with XHCI_BROKEN_STREAMS
Date: Fri, 27 Jun 2025 17:41:20 +0300
Message-ID: <20250627144127.3889714-3-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627144127.3889714-1-mathias.nyman@linux.intel.com>
References: <20250627144127.3889714-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyu Xie <xiehongyu1@kylinos.cn>

Disable stream for platform xHC controller with broken stream.

Fixes: 14aec589327a6 ("storage: accept some UAS devices if streams are unavailable")
Cc: stable@vger.kernel.org # 5.4
Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-plat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 6dab142e7278..c79d5ed48a08 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -328,7 +328,8 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 	}
 
 	usb3_hcd = xhci_get_usb3_hcd(xhci);
-	if (usb3_hcd && HCC_MAX_PSA(xhci->hcc_params) >= 4)
+	if (usb3_hcd && HCC_MAX_PSA(xhci->hcc_params) >= 4 &&
+	    !(xhci->quirks & XHCI_BROKEN_STREAMS))
 		usb3_hcd->can_do_streams = 1;
 
 	if (xhci->shared_hcd) {
-- 
2.43.0


