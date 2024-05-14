Return-Path: <stable+bounces-44227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AF08C51D1
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1024A2826E7
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513D113C813;
	Tue, 14 May 2024 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YJ86gNbx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFA12B9AD;
	Tue, 14 May 2024 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685082; cv=none; b=LNAumNwJGIj1iP9BaIdGmpqQI2QizZ8t4CYw8PdEtPxvTYOfLNL4GzNyg3sqq3wLhdtFhz1LyRSO6++IKRWR6rVEBiEsDRmq+BG2sQIQqCONBVr0kqOZTzFeJEl4AbwGLtsUxF9zJK/CiQxvTsNRm/lJ+/MvLBDlz9GvfxoDZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685082; c=relaxed/simple;
	bh=W+PU0FXPC5JpgZMtPlwc68acXuhucMTvYKQ6/KJHaTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liIFsHEZnMeJI1GxIvjv9rEamKigU0Gi3z6hbOzAd3489lZba9CV/YLyKz/kIdsfapJJ7RkJQXozHN/BW5GarnbXQLU6+kP1UJk15uKvPDJeEzEhQdcG9iUEJ1zVOpu2FmS28ZnUd1YE+MttQab+Rb4BlERaf22OqdPxWIaoiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YJ86gNbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F21C2BD10;
	Tue, 14 May 2024 11:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715685081;
	bh=W+PU0FXPC5JpgZMtPlwc68acXuhucMTvYKQ6/KJHaTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJ86gNbxD1Hm4OthlXuM4T5GvJ4izMEBoFAweQkkvSwVHZejp46M8jKfftqDKMvD7
	 6zdOJdG+KHgwXDgorhRXfYyq1MrRMgDBKwoxITDhznzHrVWLpCcghTnfaRQqp8bBo8
	 IbC+S7e70FpNbqFaQOKGKnhnCIWslq0/3mFXjtQc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gaurav Batra <gbatra@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 092/301] powerpc/pseries/iommu: LPAR panics during boot up with a frozen PE
Date: Tue, 14 May 2024 12:16:03 +0200
Message-ID: <20240514101035.723567536@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gaurav Batra <gbatra@linux.ibm.com>

[ Upstream commit 49a940dbdc3107fecd5e6d3063dc07128177e058 ]

At the time of LPAR boot up, partition firmware provides Open Firmware
property ibm,dma-window for the PE. This property is provided on the PCI
bus the PE is attached to.

There are execptions where the partition firmware might not provide this
property for the PE at the time of LPAR boot up. One of the scenario is
where the firmware has frozen the PE due to some error condition. This
PE is frozen for 24 hours or unless the whole system is reinitialized.

Within this time frame, if the LPAR is booted, the frozen PE will be
presented to the LPAR but ibm,dma-window property could be missing.

Today, under these circumstances, the LPAR oopses with NULL pointer
dereference, when configuring the PCI bus the PE is attached to.

  BUG: Kernel NULL pointer dereference on read at 0x000000c8
  Faulting instruction address: 0xc0000000001024c0
  Oops: Kernel access of bad area, sig: 7 [#1]
  LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
  Modules linked in:
  Supported: Yes
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.4.0-150600.9-default #1
  Hardware name: IBM,9043-MRX POWER10 (raw) 0x800200 0xf000006 of:IBM,FW1060.00 (NM1060_023) hv:phyp pSeries
  NIP:  c0000000001024c0 LR: c0000000001024b0 CTR: c000000000102450
  REGS: c0000000037db5c0 TRAP: 0300   Not tainted  (6.4.0-150600.9-default)
  MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 28000822  XER: 00000000
  CFAR: c00000000010254c DAR: 00000000000000c8 DSISR: 00080000 IRQMASK: 0
  ...
  NIP [c0000000001024c0] pci_dma_bus_setup_pSeriesLP+0x70/0x2a0
  LR [c0000000001024b0] pci_dma_bus_setup_pSeriesLP+0x60/0x2a0
  Call Trace:
    pci_dma_bus_setup_pSeriesLP+0x60/0x2a0 (unreliable)
    pcibios_setup_bus_self+0x1c0/0x370
    __of_scan_bus+0x2f8/0x330
    pcibios_scan_phb+0x280/0x3d0
    pcibios_init+0x88/0x12c
    do_one_initcall+0x60/0x320
    kernel_init_freeable+0x344/0x3e4
    kernel_init+0x34/0x1d0
    ret_from_kernel_user_thread+0x14/0x1c

Fixes: b1fc44eaa9ba ("pseries/iommu/ddw: Fix kdump to work in absence of ibm,dma-window")
Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240422205141.10662-1-gbatra@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index e8c4129697b14..b1e6d275cda9e 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -786,8 +786,16 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 	 * parent bus. During reboot, there will be ibm,dma-window property to
 	 * define DMA window. For kdump, there will at least be default window or DDW
 	 * or both.
+	 * There is an exception to the above. In case the PE goes into frozen
+	 * state, firmware may not provide ibm,dma-window property at the time
+	 * of LPAR boot up.
 	 */
 
+	if (!pdn) {
+		pr_debug("  no ibm,dma-window property !\n");
+		return;
+	}
+
 	ppci = PCI_DN(pdn);
 
 	pr_debug("  parent is %pOF, iommu_table: 0x%p\n",
-- 
2.43.0




