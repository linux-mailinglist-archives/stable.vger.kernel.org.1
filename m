Return-Path: <stable+bounces-139984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E204EAAA3B0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F01A67B471F
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D642F1CED;
	Mon,  5 May 2025 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRqdi7ko"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05E72F1CE4;
	Mon,  5 May 2025 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483826; cv=none; b=Qa0qJfq43qBipihdADY+gXCpHQg3P2re/jypzJgY2zk57ULcJ6fidCipwV/4q45yoG2wELguFlvE7buzj6ylAuQgdiGkUu8zJ4NWZj8oTGbxISbAdZk9vr7nBU1/6fofZkgLIHEvfHAELc/VV5dCZ31HK7KkkpbBrXX56tvoOfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483826; c=relaxed/simple;
	bh=+HYjiBAwPMz5BtYEdMqzpJ2Hzx87YdBHZroo4bPqVwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MNdHLSa05sdniafDwwwQFO/PNLWUL38tRMCSZdd/DTpJizMpHJJIpId9us4MY0iq8IbLnRq8N87JJZ/tL6k0j7C9Gnb4M2urvD8jOBIvU2Gt/fd2n+ZPTYPhVutqPFXxytzS5LxjEF6M6kpAlN6PRXnl7An6PAX8XxbG7mHlRms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRqdi7ko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37C3C4CEE4;
	Mon,  5 May 2025 22:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483826;
	bh=+HYjiBAwPMz5BtYEdMqzpJ2Hzx87YdBHZroo4bPqVwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oRqdi7ko1trakwtRkNPdtPoVcRIF7tAQB7NDS/tIPmg5GD4ayGE/jbgQVOHj/R149
	 NCdVD+isLmxfhPk59cylnfC4PMFbkEwffVDFdk9T8GJylUSkJbkAoiX2IcTNfH0vIV
	 NO934x8s+Ne06ddRevS80sBtqsMHWUp7YBHsAeu0ysiUt/ODhsFW47UsdfD/x2/O2J
	 K5oGBVBkTfkbwlQBhVjJoB9VLMG6BQTVWUoEQ1fAKWXrj2HaJjKBEFM3dihv2lhjXD
	 cVgNERUPi1P+dpR8sg9RyiywhNEdabMfSpRRYO9Ohvplrbw2KvbPBXNuaxqdcsE4Fx
	 +zHYLpyRTgesg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 237/642] usb: xhci: set page size to the xHCI-supported size
Date: Mon,  5 May 2025 18:07:33 -0400
Message-Id: <20250505221419.2672473-237-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Niklas Neronin <niklas.neronin@linux.intel.com>

[ Upstream commit 68c1f1671650b49bbd26e6a65ddcf33f2565efa3 ]

The current xHCI driver does not validate whether a page size of 4096
bytes is supported. Address the issue by setting the page size to the
value supported by the xHCI controller, as read from the Page Size
register. In the event of an unexpected value; default to a 4K page size.

Additionally, this commit removes unnecessary debug messages and instead
prints the supported and used page size once.

The xHCI controller supports page sizes of (2^{(n+12)}) bytes, where 'n'
is the Page Size Bit. Only one page size is supported, with a maximum
page size of 128 KB.

Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250306144954.3507700-10-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-mem.c | 34 ++++++++++++++++++----------------
 drivers/usb/host/xhci.h     |  8 ++++----
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 9aa7e2a876ec1..d698095fc88d3 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1953,7 +1953,6 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
 	xhci->interrupters = NULL;
 
 	xhci->page_size = 0;
-	xhci->page_shift = 0;
 	xhci->usb2_rhub.bus_state.bus_suspended = 0;
 	xhci->usb3_rhub.bus_state.bus_suspended = 0;
 }
@@ -2372,6 +2371,22 @@ xhci_create_secondary_interrupter(struct usb_hcd *hcd, unsigned int segs,
 }
 EXPORT_SYMBOL_GPL(xhci_create_secondary_interrupter);
 
+static void xhci_hcd_page_size(struct xhci_hcd *xhci)
+{
+	u32 page_size;
+
+	page_size = readl(&xhci->op_regs->page_size) & XHCI_PAGE_SIZE_MASK;
+	if (!is_power_of_2(page_size)) {
+		xhci_warn(xhci, "Invalid page size register = 0x%x\n", page_size);
+		/* Fallback to 4K page size, since that's common */
+		page_size = 1;
+	}
+
+	xhci->page_size = page_size << 12;
+	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "HCD page size set to %iK",
+		       xhci->page_size >> 10);
+}
+
 int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 {
 	struct xhci_interrupter *ir;
@@ -2379,7 +2394,7 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	dma_addr_t	dma;
 	unsigned int	val, val2;
 	u64		val_64;
-	u32		page_size, temp;
+	u32		temp;
 	int		i;
 
 	INIT_LIST_HEAD(&xhci->cmd_list);
@@ -2388,20 +2403,7 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	INIT_DELAYED_WORK(&xhci->cmd_timer, xhci_handle_command_timeout);
 	init_completion(&xhci->cmd_ring_stop_completion);
 
-	page_size = readl(&xhci->op_regs->page_size);
-	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"Supported page size register = 0x%x", page_size);
-	val = ffs(page_size) - 1;
-	if (val < 16)
-		xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"Supported page size of %iK", (1 << (val + 12)) / 1024);
-	else
-		xhci_warn(xhci, "WARN: no supported page size\n");
-	/* Use 4K pages, since that's common and the minimum the HC supports */
-	xhci->page_shift = 12;
-	xhci->page_size = 1 << xhci->page_shift;
-	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"HCD page size set to %iK", xhci->page_size / 1024);
+	xhci_hcd_page_size(xhci);
 
 	/*
 	 * Program the Number of Device Slots Enabled field in the CONFIG
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 2c394cba120f1..7d22617417fe0 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -211,6 +211,9 @@ struct xhci_op_regs {
 #define CONFIG_CIE		(1 << 9)
 /* bits 10:31 - reserved and should be preserved */
 
+/* bits 15:0 - HCD page shift bit */
+#define XHCI_PAGE_SIZE_MASK     0xffff
+
 /**
  * struct xhci_intr_reg - Interrupt Register Set
  * @irq_pending:	IMAN - Interrupt Management Register.  Used to enable
@@ -1514,10 +1517,7 @@ struct xhci_hcd {
 	u16		max_interrupters;
 	/* imod_interval in ns (I * 250ns) */
 	u32		imod_interval;
-	/* 4KB min, 128MB max */
-	int		page_size;
-	/* Valid values are 12 to 20, inclusive */
-	int		page_shift;
+	u32		page_size;
 	/* MSI-X/MSI vectors */
 	int		nvecs;
 	/* optional clocks */
-- 
2.39.5


