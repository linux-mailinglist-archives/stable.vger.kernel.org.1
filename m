Return-Path: <stable+bounces-26656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A272870F89
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5241C21D6C
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB257BAE6;
	Mon,  4 Mar 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j9kMSjjr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA0D7B3E6;
	Mon,  4 Mar 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589337; cv=none; b=leXYCQW+T6GJEtmC/I9JYAnHenNEBsA96qNwIP+2Qr/1Yz7DQfMe3xZ7oDMGb54adetw+wQzyKwcfu89pvzlupNPv6efj56xJnubT+iVsFneARnPHDFvU3wKt8+rwirElvYaYXo5PV3B0NQTFKNkFxYnoP6X95YPVBoPBsblcP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589337; c=relaxed/simple;
	bh=/r7E3HVR3s0Ep8z/x0fWa9LmnsCu47xhYw39lPx8+o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPGMi5hoXRNhjoo7VklQUQtSUUpJTzGpq7UcNRz+kKW5QMrbJm3CX2p843a7f+kXjNcaQYXpyeYGxZinhvjxXPl9qloMvOqYf8seSLjwKyy2Tr3O2qhyV6i9Ks2QEqKhWVTHguzUwteQPmMXcCxTigz9mWK7FA1kBLbcvnSzmfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j9kMSjjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356E9C433F1;
	Mon,  4 Mar 2024 21:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709589337;
	bh=/r7E3HVR3s0Ep8z/x0fWa9LmnsCu47xhYw39lPx8+o0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j9kMSjjregJ9Ura8BtgC+x+2LVKV4OlyQhJOoTDy3aIRoZKtqe+timgxnEfoY7WMx
	 Z9Cz7M5YjwCAKp2X0lxmx/FNKBx9z8btrDR3jRMEhHPQJPRaMlRusOKZ/mDzvx9BYe
	 qE6EBjEgDkwf+1IKDn4I9Z9pVHzYCRdfM5+7i/Uo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Dimitris Vlachos <dvlachos@ics.forth.gr>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 46/84] riscv: Sparse-Memory/vmemmap out-of-bounds fix
Date: Mon,  4 Mar 2024 21:24:19 +0000
Message-ID: <20240304211543.874150034@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211542.332206551@linuxfoundation.org>
References: <20240304211542.332206551@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dimitris Vlachos <dvlachos@ics.forth.gr>

[ Upstream commit a11dd49dcb9376776193e15641f84fcc1e5980c9 ]

Offset vmemmap so that the first page of vmemmap will be mapped
to the first page of physical memory in order to ensure that
vmemmap’s bounds will be respected during
pfn_to_page()/page_to_pfn() operations.
The conversion macros will produce correct SV39/48/57 addresses
for every possible/valid DRAM_BASE inside the physical memory limits.

v2:Address Alex's comments

Suggested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Dimitris Vlachos <dvlachos@ics.forth.gr>
Reported-by: Dimitris Vlachos <dvlachos@ics.forth.gr>
Closes: https://lore.kernel.org/linux-riscv/20240202135030.42265-1-csd4492@csd.uoc.gr
Fixes: d95f1a542c3d ("RISC-V: Implement sparsemem")
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20240229191723.32779-1-dvlachos@ics.forth.gr
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 397cb945b16eb..9a3d9b68f2ff4 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -58,7 +58,7 @@
  * Define vmemmap for pfn_to_page & page_to_pfn calls. Needed if kernel
  * is configured with CONFIG_SPARSEMEM_VMEMMAP enabled.
  */
-#define vmemmap		((struct page *)VMEMMAP_START)
+#define vmemmap		((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT))
 
 #define PCI_IO_SIZE      SZ_16M
 #define PCI_IO_END       VMEMMAP_START
-- 
2.43.0




