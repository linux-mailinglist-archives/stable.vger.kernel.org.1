Return-Path: <stable+bounces-24714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB15D8695F0
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469421F2C1BB
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA1E141995;
	Tue, 27 Feb 2024 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YW11leTG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB7B13B2AC;
	Tue, 27 Feb 2024 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042787; cv=none; b=bwcPDTtMwPnFtsOhzyzszcOBgKJnBkMy/gZvzGqNoDDHS0ZwBerOsxW5Yl3+qrHet9LDEarLiAbtwzSIihgEqPtwtR+Q+F6oq7evZFK2TnUyHGH8WCTw5vc1qFC8E49DFU1pPA+IpLn+NW/7GcuD2h0YgySvqmv6nnADaEdm4Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042787; c=relaxed/simple;
	bh=jt3a02WhBWEK8pgcO6ByiVbl4cHwTsHRGUHARJBOXwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeUBfY7mep2SYgEjUS65rudK5vExv+BxlU61UWl93lQd1xfRPjxGUntE/ya1I/Gvds3jAAUC4W3+PTlcnFaiLFa+QFFzn2v5Qd2mBdWelQrnmwQwesoNpl6WfquigaO03rVd/fHXzl8kqjVSzR5IzF/8GUDNVYO+CDYE1zIS1NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YW11leTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5C5C433F1;
	Tue, 27 Feb 2024 14:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042787;
	bh=jt3a02WhBWEK8pgcO6ByiVbl4cHwTsHRGUHARJBOXwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YW11leTGWpek6yUH5c0QBQ0POyfqIIZfnwBZ+loq0n+vCn3RUGWMwUjSL009NaXfx
	 rnPqWGyq862S5sybrFAv0XBBTiC2ePLIB4RINAQqT9cowB/ae+V+DVF/5g/O/y4Gii
	 Z4J0F36rC0mF1tWh7JNhwBI1qP9mKruiKpRIohiE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Jeffery <andrew@aj.id.au>,
	Frederic Barrat <fbarrat@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 119/245] powerpc/powernv/ioda: Skip unallocated resources when mapping to PE
Date: Tue, 27 Feb 2024 14:25:07 +0100
Message-ID: <20240227131619.096196215@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
References: <20240227131615.098467438@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frederic Barrat <fbarrat@linux.ibm.com>

[ Upstream commit e64e71056f323a1e178dccf04d4c0f032d84436c ]

pnv_ioda_setup_pe_res() calls opal to map a resource with a PE. However,
the code assumes the resource is allocated and it uses the resource
address to find out the segment(s) which need to be mapped to the
PE. In the unlikely case where the resource hasn't been allocated, the
computation for the segment number is garbage, which can lead to
invalid memory access and potentially a kernel crash, such as:

[ ] pci_bus 0002:02: Configuring PE for bus
[ ] pci 0002:02     : [PE# fc] Secondary bus 0x0000000000000002..0x0000000000000002 associated with PE#fc
[ ] BUG: Kernel NULL pointer dereference on write at 0x00000000
[ ] Faulting instruction address: 0xc00000000005eac4
[ ] Oops: Kernel access of bad area, sig: 7 [#1]
[ ] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
[ ] Modules linked in:
[ ] CPU: 12 PID: 1 Comm: swapper/20 Not tainted 5.10.50-openpower1 #2
[ ] NIP:  c00000000005eac4 LR: c00000000005ea44 CTR: 0000000030061b9c
[ ] REGS: c000200007383650 TRAP: 0300   Not tainted  (5.10.50-openpower1)
[ ] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 44000224  XER: 20040000
[ ] CFAR: c00000000005eaa0 DAR: 0000000000000000 DSISR: 02080000 IRQMASK: 0
[ ] GPR00: c00000000005dd98 c0002000073838e0 c00000000185de00 c000200fff018960
[ ] GPR04: 00000000000000fc 0000000000000003 0000000000000000 0000000000000000
[ ] GPR08: 0000000000000000 0000000000000000 0000000000000000 9000000000001033
[ ] GPR12: 0000000031cb0000 c000000ffffe6a80 c000000000010a58 0000000000000000
[ ] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[ ] GPR20: 0000000000000000 0000000000000000 0000000000000000 c00000000711e200
[ ] GPR24: 0000000000000100 c000200009501120 c00020000cee2800 00000000000003ff
[ ] GPR28: c000200fff018960 0000000000000000 c000200ffcb7fd00 0000000000000000
[ ] NIP [c00000000005eac4] pnv_ioda_setup_pe_res+0x94/0x1a0
[ ] LR [c00000000005ea44] pnv_ioda_setup_pe_res+0x14/0x1a0
[ ] Call Trace:
[ ] [c0002000073838e0] [c00000000005eb98] pnv_ioda_setup_pe_res+0x168/0x1a0 (unreliable)
[ ] [c000200007383970] [c00000000005dd98] pnv_pci_ioda_dma_dev_setup+0x43c/0x970
[ ] [c000200007383a60] [c000000000032cdc] pcibios_bus_add_device+0x78/0x18c
[ ] [c000200007383aa0] [c00000000028f2bc] pci_bus_add_device+0x28/0xbc
[ ] [c000200007383b10] [c00000000028f3a0] pci_bus_add_devices+0x50/0x7c
[ ] [c000200007383b50] [c00000000028f3c4] pci_bus_add_devices+0x74/0x7c
[ ] [c000200007383b90] [c00000000028f3c4] pci_bus_add_devices+0x74/0x7c
[ ] [c000200007383bd0] [c00000000069ad0c] pcibios_init+0xf0/0x104
[ ] [c000200007383c50] [c0000000000106d8] do_one_initcall+0x84/0x1c4
[ ] [c000200007383d20] [c0000000006910b8] kernel_init_freeable+0x264/0x268
[ ] [c000200007383dc0] [c000000000010a68] kernel_init+0x18/0x138
[ ] [c000200007383e20] [c00000000000cbfc] ret_from_kernel_thread+0x5c/0x80
[ ] Instruction dump:
[ ] 7f89e840 409d000c 7fbbf840 409c000c 38210090 4848f448 809c002c e95e0120
[ ] 7ba91764 38a00003 57a7043e 38c00000 <7c8a492e> 5484043e e87e0018 4bff23bd

Hitting the problem is not that easy. It was seen with a (semi-bogus)
PCI device with a class code of 0. The generic PCI framework doesn't
allocate resources in such a case.

The patch is simply skipping resources which are still flagged with
IORESOURCE_UNSET.

We don't have the problem with 64-bit mem resources, as the address of
the resource is checked to be within the range of the 64-bit mmio
window. See pnv_ioda_reserve_dev_m64_pe() and pnv_pci_is_m64().

Reported-by: Andrew Jeffery <andrew@aj.id.au>
Fixes: 23e79425fe7c ("powerpc/powernv: Simplify pnv_ioda_setup_pe_seg()")
Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20230120093215.19496-1-fbarrat@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 624822a810193..8cf9e9f29763c 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2334,7 +2334,8 @@ static void pnv_ioda_setup_pe_res(struct pnv_ioda_pe *pe,
 	int index;
 	int64_t rc;
 
-	if (!res || !res->flags || res->start > res->end)
+	if (!res || !res->flags || res->start > res->end ||
+	    res->flags & IORESOURCE_UNSET)
 		return;
 
 	if (res->flags & IORESOURCE_IO) {
-- 
2.43.0




