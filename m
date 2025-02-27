Return-Path: <stable+bounces-119861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1391A4892C
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 20:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA4747A677C
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 19:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF8B21B9C9;
	Thu, 27 Feb 2025 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEuqgdWk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CD61B0425;
	Thu, 27 Feb 2025 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740685550; cv=none; b=VuhBSY2Qk+Xq1E5qpKujChGXJVFA2UBLs3AxuFpEjT1AN3mKEvuJQrohtWRr4HcV7NyH5uDqAejQKiPjrHTJc6tSyyvAxZq7MttG8ZVEvXqEvKriQSCtoIWWijlnna5mFMiSQh8ppqw9Sp92oxHG4DDVyHcJHujhC5Bg2kQDoPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740685550; c=relaxed/simple;
	bh=ZXCrKOq4STAxpn0LbqL3XX+FU8M05shAqCoEyXVf51c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=abmkYW0EewewGQJlbUNZHvclXhmTsSaDBfzLXybCSNArrUSMO27Xp+D+k2rwp6d57g/gj7L1yZJjpUdaEQb20EYwsiCcy8VfP16uq4T1xVbiTUXnZ1Bv2fJAZBwgRgCGOn5cQ8deQbbvLHNYT7EqQijspAkrU0aoHSAphIaH13A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEuqgdWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14510C4FF0C;
	Thu, 27 Feb 2025 19:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740685550;
	bh=ZXCrKOq4STAxpn0LbqL3XX+FU8M05shAqCoEyXVf51c=;
	h=From:To:Cc:Subject:Date:From;
	b=NEuqgdWkYFoBCCqxldonqLYcPxKv9sZv8t8kW4ywOwltwMJwLwDUuOdWpYMiTmGAY
	 76pN2jBy4lwiRma0WXn2O4u7Su5hVJ2g8VFnmeQgUYOBj3f0RcH+Zl2OLalokyvcMS
	 V39hJFKeJi98vs2l3e49Dk2AQTcgMHXVC0vw4oORGEwwrvcO1uFeubVG+gIFx1LZst
	 9IC/K+5QkL6SSZtmcyuz2KAg69DYT5d+MKWVnAemN+cek9l4SG0SEql5zrwWivciPx
	 qVaH3gcX0BS+X7di5rWVjIOfjmVJ1VyQI7dQ5lSdZeAYxgNhBAv0pXMkXlIfIm3Abh
	 Y7AwH0ik/OPxg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tnjpL-008o1r-S4;
	Thu, 27 Feb 2025 19:45:47 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Oliver Upton <oliver.upton@linux.dev>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH] xhci: Restrict USB4 tunnel detection for USB3 devices to Intel hosts
Date: Thu, 27 Feb 2025 19:45:29 +0000
Message-Id: <20250227194529.2288718-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, oliver.upton@linux.dev, mathias.nyman@linux.intel.com, gregkh@linuxfoundation.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

When adding support for USB3-over-USB4 tunnelling detection, a check
for an Intel-specific capability was added. This capability, which
goes by ID 206, is used without any check that we are actually
dealing with an Intel host.

As it turns out, the Cadence XHCI controller *also* exposes an
extended capability numbered 206 (for unknown purposes), but of
course doesn't have the Intel-specific registers that the tunnelling
code is trying to access. Fun follows.

The core of the problems is that the tunnelling code blindly uses
vendor-specific capabilities without any check (the Intel-provided
documentation I have at hand indicates that 192-255 are indeed
vendor-specific).

Restrict the detection code to Intel HW for real, preventing any
further explosion on my (non-Intel) HW.

Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Fixes: 948ce83fbb7df ("xhci: Add USB4 tunnel detection for USB3 devices on Intel hosts")
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/usb/host/xhci-hub.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 9693464c05204..69c278b64084b 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/unaligned.h>
 #include <linux/bitfield.h>
+#include <linux/pci.h>
 
 #include "xhci.h"
 #include "xhci-trace.h"
@@ -770,9 +771,16 @@ static int xhci_exit_test_mode(struct xhci_hcd *xhci)
 enum usb_link_tunnel_mode xhci_port_is_tunneled(struct xhci_hcd *xhci,
 						struct xhci_port *port)
 {
+	struct usb_hcd *hcd;
 	void __iomem *base;
 	u32 offset;
 
+	/* Don't try and probe this capability for non-Intel hosts */
+	hcd = xhci_to_hcd(xhci);
+	if (!dev_is_pci(hcd->self.controller) ||
+	    to_pci_dev(hcd->self.controller)->vendor != PCI_VENDOR_ID_INTEL)
+		return USB_LINK_UNKNOWN;
+
 	base = &xhci->cap_regs->hc_capbase;
 	offset = xhci_find_next_ext_cap(base, 0, XHCI_EXT_CAPS_INTEL_SPR_SHADOW);
 
-- 
2.39.2


