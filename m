Return-Path: <stable+bounces-185539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2D1BD6AD8
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 00:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E473A188F590
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A372FF152;
	Mon, 13 Oct 2025 22:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPKZKUK2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9302EF654;
	Mon, 13 Oct 2025 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760396173; cv=none; b=oOzRFe/Psc5JzN56LlhuTpkTpc+jbgtQW0y487wt9se0kr0r01rQxrd+K5hKV/m3Yq/pyH1WJyI2r00bAiOGI0JSIdALf5ckRIGnWt7ovhY7kyOC2/1pOYwoin00KtWxV/Uw9w/0MeleFL0mk0Q62Xi+5/kCui1tuGdh9uDLLS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760396173; c=relaxed/simple;
	bh=Kn24UEWdQTOB35pmmAc1rSpnw2CwkoAzDD1IJChp/Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MeMhhY99BIbsmLpS5XIhwttDq7FAO/R9iod1eFj11WezwIOIfgmMHBCiWCPSUzAKQVdVsplCA0U86dnjT3IEo7823Mws64RmIwjO81UlgOY/KNG1A+X9GpjynRKFOXV0oOyhtPba4AOvM2rgOYiccqvLcxiVWDuCU8r5/BokCUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPKZKUK2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760396172; x=1791932172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kn24UEWdQTOB35pmmAc1rSpnw2CwkoAzDD1IJChp/Zg=;
  b=FPKZKUK24Zmn2ywaFr8fMICMza1M+4fcORDewlgzylPCf0TqLkUKJS/V
   oevArLwVSuSIExYyGoOKyLWSehmj/SaVcPJ1dAp8UHv8qUiLxkwrLQV9D
   ar/EDak+VHlvmCZOIzjqHxcWlw2v/jAXSFk0HoJFlWmph6D4+sYUWKUku
   5ycxdn4WU78oXVqBbD3y3+SwqNnUTeBMXj23lK6hHpykwb5+GawrmlKKj
   OU89EjYryfgf6ALucQPX2Fc2VkiKOsS6qlsTCeuHBbqcaiSHtuPt7DzPq
   SoOgOuHdQMPdmMHuvi8C+XAtwxULzwCD1NtX3lLjHYukUDj3dYgZTYe9e
   Q==;
X-CSE-ConnectionGUID: oP7cuG73QUC2uP1KR8Ar4A==
X-CSE-MsgGUID: YSxBPadVSAW367rfiLLNbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="66202534"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="66202534"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 15:56:06 -0700
X-CSE-ConnectionGUID: ILeIe3fJQRON8wBFF1an4A==
X-CSE-MsgGUID: BVRLJ3iHQRuwK/zQBZNFWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="185742310"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO mnyman-desk.home) ([10.245.244.60])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 15:56:06 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
Subject: [PATCH 3/3] xhci: dbc: enable back DbC in resume if it was enabled before suspend
Date: Tue, 14 Oct 2025 01:55:42 +0300
Message-ID: <20251013225542.504072-4-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013225542.504072-1-mathias.nyman@linux.intel.com>
References: <20251013225542.504072-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DbC is currently only enabled back if it's in configured state during
suspend.

If system is suspended after DbC is enabled, but before the device is
properly enumerated by the host, then DbC would not be enabled back in
resume.

Always enable DbC back in resume if it's suspended in enabled,
connected, or configured state

Cc: stable@vger.kernel.org
Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
Tested-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-dbgcap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 023a8ec6f305..ecda964e018a 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -1392,8 +1392,15 @@ int xhci_dbc_suspend(struct xhci_hcd *xhci)
 	if (!dbc)
 		return 0;
 
-	if (dbc->state == DS_CONFIGURED)
+	switch (dbc->state) {
+	case DS_ENABLED:
+	case DS_CONNECTED:
+	case DS_CONFIGURED:
 		dbc->resume_required = 1;
+		break;
+	default:
+		break;
+	}
 
 	xhci_dbc_stop(dbc);
 
-- 
2.43.0


