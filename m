Return-Path: <stable+bounces-189314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF117C0933D
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 18:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 638C034D3C8
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 16:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB5E303A16;
	Sat, 25 Oct 2025 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbIO3vVa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530AF1F1306;
	Sat, 25 Oct 2025 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408670; cv=none; b=Vkx9ObphSVSEri/JgWhnMWdrOvPBJd/uRIiVZtV5WqvqbZZWSmxaf2BgNkjzYPbXudhmI/7aeQqKaNEH2qjX2ktiEfkQQFqvIgWWEvwadspeTAamP12l4PiQj5ZmhSkW8tcMWFwOrAouspXMfNA4JU/1LtG+PVX1oyDW81vNKgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408670; c=relaxed/simple;
	bh=7RPJS+YYBdHHkSkPg7nJLRvxjYkQoNcT5qFRStkQwPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjbhQYhibFK8YAkOIAw63fgSRTbdLEDaC+bD+4B+HeRILK6jsauJmWYVVU0tTm/7mcoqCOfq5s1fsl6AJuHYLQXwfow87yoKjVtErHHArI72iv1tk64iisV258UQMixgqBU7qI4MhN/MNrPxZlwRXsnFYGmMaVbT7s0LVWtPe5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbIO3vVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50FAC4CEFB;
	Sat, 25 Oct 2025 16:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761408669;
	bh=7RPJS+YYBdHHkSkPg7nJLRvxjYkQoNcT5qFRStkQwPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RbIO3vVaZRGtvaTtmlLj0YCRABRwwCmvFM3WFsB1GBjl5hrN0xiNUDjLFjgduP+9+
	 zWlMOKUguLU7XyqzYU4n69AWlWeRMt7n5/9PRgBTiQyih8Vy4vJBaTnApn9nOlD+UR
	 SWBOWLDcoOA7wiWkuVzFJySulz0dEg0nj52gmKrPOeG7NCCIfTxzUpE2QWcsc24cHU
	 DtaG9glLoprAxsbAMilBj8iZrCneF9TjMQ4zjJ8P1YYVTQRZ2Kf55CZfbWXSGIh6FS
	 5kvgK8zFHBoJ538BntW9Fw8rSUfz1IbregtX6YD0CEFIkVbp6sYzKvcBWhJURMJNS0
	 EI50HoqjujPAw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
	Nick Nielsen <nick.kainielsen@free.fr>,
	grm1 <grm1@mailbox.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] usb: xhci-pci: add support for hosts with zero USB3 ports
Date: Sat, 25 Oct 2025 11:54:27 -0400
Message-ID: <20251025160905.3857885-36-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Niklas Neronin <niklas.neronin@linux.intel.com>

[ Upstream commit 719de070f764e079cdcb4ddeeb5b19b3ddddf9c1 ]

Add xhci support for PCI hosts that have zero USB3 ports.
Avoid creating a shared Host Controller Driver (HCD) when there is only
one root hub. Additionally, all references to 'xhci->shared_hcd' are now
checked before use.

Only xhci-pci.c requires modification to accommodate this change, as the
xhci core already supports configurations with zero USB3 ports. This
capability was introduced when xHCI Platform and MediaTek added support
for zero USB3 ports.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220181
Tested-by: Nick Nielsen <nick.kainielsen@free.fr>
Tested-by: grm1 <grm1@mailbox.org>
Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250917210726.97100-4-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES — this change is a focused bugfix that lets PCI xHCI controllers
with only a single root hub enumerate correctly, matching support
already present in the core and other host adapters.

- `drivers/usb/host/xhci-pci.c:640` now sets `xhci->allow_single_roothub
  = 1`, allowing the existing `xhci_has_one_roothub()` helper to
  recognize hosts that genuinely provide only USB2 or only USB3 ports.
  For such hardware the new branch at `drivers/usb/host/xhci-
  pci.c:641-659` skips creating the secondary HCD and still runs
  `xhci_ext_cap_init()`, preventing the allocation/registration of a
  useless SuperSpeed root hub that currently causes probe failures on
  the systems reported in bug 220181.
- Stream capability handling switches to `xhci_get_usb3_hcd()` at
  `drivers/usb/host/xhci-pci.c:662-664`, so the code safely handles both
  the traditional dual-root-hub case and the new single-root-hub case
  without dereferencing a NULL `shared_hcd`.
- The xHCI core has supported “single-roothub” controllers since commit
  873f323618c2 (see the helper definitions in
  `drivers/usb/host/xhci.h:1659-1737`), and platform drivers already
  rely on the same pattern (`drivers/usb/host/xhci-plat.c:207` and
  `drivers/usb/host/xhci-mtk.c:629-655`). This patch simply brings the
  PCI glue in line with that infrastructure, so it has no architectural
  side effects.
- Scope is limited to the PCI front-end; it doesn’t alter shared data
  structures or other subsystems. Tested-by tags and the fact that the
  alternative drivers have run this logic for multiple release cycles
  further reduce regression risk. Backporters only need to ensure the
  target stable branch already contains the earlier
  “allow_single_roothub” support (present in 6.1+). If that prerequisite
  is met, the change is small, self-contained, and fixes real hardware
  breakage.

Natural next steps: 1) cherry-pick (plus prerequisite check) into the
relevant stable trees; 2) rerun basic USB enumeration on affected
hardware to confirm the controller now probes successfully.

 drivers/usb/host/xhci-pci.c | 42 +++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 00fac8b233d2a..5c8ab519f497d 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -610,7 +610,7 @@ int xhci_pci_common_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	int retval;
 	struct xhci_hcd *xhci;
-	struct usb_hcd *hcd;
+	struct usb_hcd *hcd, *usb3_hcd;
 	struct reset_control *reset;
 
 	reset = devm_reset_control_get_optional_exclusive(&dev->dev, NULL);
@@ -636,26 +636,32 @@ int xhci_pci_common_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	hcd = dev_get_drvdata(&dev->dev);
 	xhci = hcd_to_xhci(hcd);
 	xhci->reset = reset;
-	xhci->shared_hcd = usb_create_shared_hcd(&xhci_pci_hc_driver, &dev->dev,
-						 pci_name(dev), hcd);
-	if (!xhci->shared_hcd) {
-		retval = -ENOMEM;
-		goto dealloc_usb2_hcd;
-	}
 
-	retval = xhci_ext_cap_init(xhci);
-	if (retval)
-		goto put_usb3_hcd;
+	xhci->allow_single_roothub = 1;
+	if (!xhci_has_one_roothub(xhci)) {
+		xhci->shared_hcd = usb_create_shared_hcd(&xhci_pci_hc_driver, &dev->dev,
+							 pci_name(dev), hcd);
+		if (!xhci->shared_hcd) {
+			retval = -ENOMEM;
+			goto dealloc_usb2_hcd;
+		}
 
-	retval = usb_add_hcd(xhci->shared_hcd, dev->irq,
-			IRQF_SHARED);
-	if (retval)
-		goto put_usb3_hcd;
-	/* Roothub already marked as USB 3.0 speed */
+		retval = xhci_ext_cap_init(xhci);
+		if (retval)
+			goto put_usb3_hcd;
+
+		retval = usb_add_hcd(xhci->shared_hcd, dev->irq, IRQF_SHARED);
+		if (retval)
+			goto put_usb3_hcd;
+	} else {
+		retval = xhci_ext_cap_init(xhci);
+		if (retval)
+			goto dealloc_usb2_hcd;
+	}
 
-	if (!(xhci->quirks & XHCI_BROKEN_STREAMS) &&
-			HCC_MAX_PSA(xhci->hcc_params) >= 4)
-		xhci->shared_hcd->can_do_streams = 1;
+	usb3_hcd = xhci_get_usb3_hcd(xhci);
+	if (usb3_hcd && !(xhci->quirks & XHCI_BROKEN_STREAMS) && HCC_MAX_PSA(xhci->hcc_params) >= 4)
+		usb3_hcd->can_do_streams = 1;
 
 	/* USB-2 and USB-3 roothubs initialized, allow runtime pm suspend */
 	pm_runtime_put_noidle(&dev->dev);
-- 
2.51.0


