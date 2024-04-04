Return-Path: <stable+bounces-35921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9B58986CF
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 14:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24639B2326B
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 12:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8548185644;
	Thu,  4 Apr 2024 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+PcCasG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04185279;
	Thu,  4 Apr 2024 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232565; cv=none; b=SK4JGtJ2zwJBwM1UYRNbv4xoqoACvcSHG997ykRLQTLHMyyXCWqzYwe1d+/IJHN18nuxNyr/rvaApes2RUFqIhZxCn/2/e5Ihz/ydtoAzQXge4q34RViNcYjVw4LiHqWwO+w8ARR7DmqjaRMK6BQtNbvMKUOTZM+OnteBXdo5OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232565; c=relaxed/simple;
	bh=S2N3uB7P/OzEiBwNbUDT5i7k1PICI8SjBF1ZYyxVtaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IQ3PjaEgbTwQtPYeebHtDTmF3lNqpwi/ghwYs5vN7YZIJF72DEoRDaSgqdUGY/PxCxhRE++S7muMNgU8sV8CqmfTZSDyhOZYJr9GBwnlphEKdCBGPIyljQPFtrPk4C4H62gZCmWrdYoPTO8Jcvbmgam5ksBJfqplhX8qCorNOVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+PcCasG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712232564; x=1743768564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S2N3uB7P/OzEiBwNbUDT5i7k1PICI8SjBF1ZYyxVtaM=;
  b=Z+PcCasGeRSFrVad4VcoftFMg0eqIBAMNRgQjQVwk9eQUvkBFXiBTq09
   kasBnjHb3DbFwrCS/w3rPyODXmJI298Ui1Q4Y0mSp7KzygzKbdf/8tsr/
   UevpztE3XADUGUIx6+74jPu/iks5+I+1huV4S9Lbv1B13c2lqlyBu22E3
   8YxlgOYM1QNG8fcEbmFX1V4wZ7xeyIX/v8gFX+LX6/mZtGczjglHUkXbU
   wy0tphH3v6Td1dtug+ebB5lOmDj1CI7mJEyFkrqdEUsLvijuycbjKraAI
   rWRd4u95NEmLsT9S4J0hJBVmhKRyzbmZPZbZC14SeU6vtE037BXRGhb92
   w==;
X-CSE-ConnectionGUID: 1KjmZ3VuTLaR5elcyvojnw==
X-CSE-MsgGUID: gCEHk9u3QwyG6SQXv2/2mg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18240638"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18240638"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:09:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937086424"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="937086424"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2024 05:09:21 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	niklas.neronin@intel.com,
	Thinh.Nguyen@synopsys.com,
	Oliver Neukum <oneukum@suse.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 1/2] usb: xhci: correct return value in case of STS_HCE
Date: Thu,  4 Apr 2024 15:11:05 +0300
Message-Id: <20240404121106.2842417-2-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240404121106.2842417-1-mathias.nyman@linux.intel.com>
References: <20240404121106.2842417-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oliver Neukum <oneukum@suse.com>

If we get STS_HCE we give up on the interrupt, but for the purpose
of IRQ handling that still counts as ours. We may return IRQ_NONE
only if we are positive that it wasn't ours. Hence correct the default.

Fixes: 2a25e66d676d ("xhci: print warning when HCE was set")
Cc: stable@vger.kernel.org # v6.2+
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 52278afea94b..575f0fd9c9f1 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3133,7 +3133,7 @@ static int xhci_handle_events(struct xhci_hcd *xhci, struct xhci_interrupter *ir
 irqreturn_t xhci_irq(struct usb_hcd *hcd)
 {
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
-	irqreturn_t ret = IRQ_NONE;
+	irqreturn_t ret = IRQ_HANDLED;
 	u32 status;
 
 	spin_lock(&xhci->lock);
@@ -3141,12 +3141,13 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 	status = readl(&xhci->op_regs->status);
 	if (status == ~(u32)0) {
 		xhci_hc_died(xhci);
-		ret = IRQ_HANDLED;
 		goto out;
 	}
 
-	if (!(status & STS_EINT))
+	if (!(status & STS_EINT)) {
+		ret = IRQ_NONE;
 		goto out;
+	}
 
 	if (status & STS_HCE) {
 		xhci_warn(xhci, "WARNING: Host Controller Error\n");
@@ -3156,7 +3157,6 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 	if (status & STS_FATAL) {
 		xhci_warn(xhci, "WARNING: Host System Error\n");
 		xhci_halt(xhci);
-		ret = IRQ_HANDLED;
 		goto out;
 	}
 
@@ -3167,7 +3167,6 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 	 */
 	status |= STS_EINT;
 	writel(status, &xhci->op_regs->status);
-	ret = IRQ_HANDLED;
 
 	/* This is the handler of the primary interrupter */
 	xhci_handle_events(xhci, xhci->interrupters[0]);
-- 
2.25.1


