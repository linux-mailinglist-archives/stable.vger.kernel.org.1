Return-Path: <stable+bounces-137431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3996AAA134B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F56A4A3342
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66A024A047;
	Tue, 29 Apr 2025 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xx3gs3+v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AE821A43D;
	Tue, 29 Apr 2025 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946046; cv=none; b=AwO2cArISYN4VH9f3lLjTOwBcg6B++lrEe0juZh7AKYqa+QFAf16S1cPXYCKz7kcdvsBEQCxPlOVZL6NFuhFHcsMvAnXTwFKIoBTVuN2o6kfUhQ4XfpE31hmpaqRfpFH7vxOkuXXC22BoHwhopO+pSyXIXO2GtMXvptjOfc3gLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946046; c=relaxed/simple;
	bh=RodFU/Wq4nt8Vkm2G6BlakxMW38gbzzBFkQeOqeczzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IY9YRwjfgO9BRAJpfmhCof47YbtmxQmqbIIbMhcFMeSkGRXdzC6fHn2IntZIWmkp2uwiXoEzZjeBDK6D6b7n5oKv3XlRScYx6EMpUQ+tzmzsfIEXMaz6TX1SWPpKLctHQBy21KKWNskRcRzqHm5v5NOYUyGnx9Mi5dcjUBoV1R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xx3gs3+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCF0C4CEE3;
	Tue, 29 Apr 2025 17:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946046;
	bh=RodFU/Wq4nt8Vkm2G6BlakxMW38gbzzBFkQeOqeczzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xx3gs3+vgHU7AD46uGEwl3lz7ZLUeNfhYJ/WdFM8L+WQG+nQZhva8Zv/6iUGyy7GX
	 AwOEwYzLmp2bl5aJTsd/0NI4rq1zbkiOs2d69+c1Q6xTpHxPXENdf1CKCd1HP8XqxH
	 L8pDqWRxd7Xt6cE5HQvRZl27dKv1OhIfpKhW9Qz0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH 6.14 136/311] cxl/core/regs.c: Skip Memory Space Enable check for RCD and RCH Ports
Date: Tue, 29 Apr 2025 18:39:33 +0200
Message-ID: <20250429161126.610877675@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

commit 078d3ee7c162cd66d76171579c02d7890bd77daf upstream.

According to CXL r3.2 section 8.2.1.2, the PCI_COMMAND register fields,
including Memory Space Enable bit, have no effect on the behavior of an
RCD Upstream Port. Retaining this check may incorrectly cause
cxl_pci_probe() to fail on a valid RCD upstream Port.

While the specification is explicit only for RCD Upstream Ports, this
check is solely for accessing the RCRB, which is always mapped through
memory space. Therefore, its safe to remove the check entirely. In
practice, firmware reliably enables the Memory Space Enable bit for
RCH Downstream Ports and no failures have been observed.

Removing the check simplifies the code and avoids unnecessary
special-casing, while relying on BIOS/firmware to configure devices
correctly. Moreover, any failures due to inaccessible RCRB regions
will still be caught either in __rcrb_to_component() or while
parsing the component register block.

The following failure was observed in dmesg when the check was present:
	cxl_pci 0000:7f:00.0: No component registers (-6)

Fixes: d5b1a27143cb ("cxl/acpi: Extract component registers of restricted hosts from RCRB")
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: <stable@vger.kernel.org>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Robert Richter <rrichter@amd.com>
Link: https://patch.msgid.link/20250407192734.70631-1-Smita.KoralahalliChannabasappa@amd.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cxl/core/regs.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -581,7 +581,6 @@ resource_size_t __rcrb_to_component(stru
 	resource_size_t rcrb = ri->base;
 	void __iomem *addr;
 	u32 bar0, bar1;
-	u16 cmd;
 	u32 id;
 
 	if (which == CXL_RCRB_UPSTREAM)
@@ -603,7 +602,6 @@ resource_size_t __rcrb_to_component(stru
 	}
 
 	id = readl(addr + PCI_VENDOR_ID);
-	cmd = readw(addr + PCI_COMMAND);
 	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
 	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
 	iounmap(addr);
@@ -618,8 +616,6 @@ resource_size_t __rcrb_to_component(stru
 			dev_err(dev, "Failed to access Downstream Port RCRB\n");
 		return CXL_RESOURCE_NONE;
 	}
-	if (!(cmd & PCI_COMMAND_MEMORY))
-		return CXL_RESOURCE_NONE;
 	/* The RCRB is a Memory Window, and the MEM_TYPE_1M bit is obsolete */
 	if (bar0 & (PCI_BASE_ADDRESS_MEM_TYPE_1M | PCI_BASE_ADDRESS_SPACE_IO))
 		return CXL_RESOURCE_NONE;



