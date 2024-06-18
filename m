Return-Path: <stable+bounces-53621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDF290D31D
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2881C2478C
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666BB15575E;
	Tue, 18 Jun 2024 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Igund7W8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B4E15574D
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717642; cv=none; b=kwhVqPpF9YehG9naMXkYxS7czBnOTVBunaThmpie90dfq+oi8lJEqiqsVJlI+I0/c3BXHCPFdBhVK2uWD7U3wR+FvQNKYeZFwB9pwFQ9I5xRyca3b4kn0BdEzPeet0p7Xxg4X1YIQdObrNxBPkZ3Tb0rKTOBBvDsyiTndpqYEDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717642; c=relaxed/simple;
	bh=ce+OqhsTF62FVK/v1/CUsL5REgbynbmJeTfe74WsGeo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UJ74aMKE4SjYfYZmgCY6vPBRgz+fcdQy/vTDJNQrYZ8limPDPNLTsMMzN969dT+q6Z52pC/7PF2Us+6hwvDG665J84LMCyf4zb1xN4D7x05zoznjd/nV5LrU5gQ2Oy2z1BiCzntcLndoInTcaNhfWEg2ngc02g3nQeeCibDg07g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Igund7W8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E50FC3277B;
	Tue, 18 Jun 2024 13:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718717641;
	bh=ce+OqhsTF62FVK/v1/CUsL5REgbynbmJeTfe74WsGeo=;
	h=Subject:To:Cc:From:Date:From;
	b=Igund7W8N6AJKNTHKS61ybofgpUQyUF0lKNdgnYeIbI9vlzhEeoBOEGs3cZ2hDf+Y
	 TFnGaRSXmVfq4uGhDgxh/hG/5CFLjexWzVdgyQZmRKz2W6MYz6nqkR0T1HL4i0gUjK
	 Q88yiEbnfzeuGerlhiu2cr6F6WWqsKKrkrncS2/U=
Subject: FAILED: patch "[PATCH] riscv: fix overlap of allocated page and PTR_ERR" failed to apply to 4.19-stable tree
To: namcao@linutronix.de,bjorn@kernel.org,bjorn@rivosinc.com,palmer@rivosinc.com,rppt@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Jun 2024 15:25:53 +0200
Message-ID: <2024061853-upbeat-skyline-91e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 994af1825a2aa286f4903ff64a1c7378b52defe6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061853-upbeat-skyline-91e2@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

994af1825a2a ("riscv: fix overlap of allocated page and PTR_ERR")
07aabe8fb6d1 ("riscv: mm: init: try best to use IS_ENABLED(CONFIG_64BIT) instead of #ifdef")
063df71a574b ("Merge tag 'riscv-for-linus-5.15-mw0' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 994af1825a2aa286f4903ff64a1c7378b52defe6 Mon Sep 17 00:00:00 2001
From: Nam Cao <namcao@linutronix.de>
Date: Thu, 25 Apr 2024 13:52:01 +0200
Subject: [PATCH] riscv: fix overlap of allocated page and PTR_ERR
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On riscv32, it is possible for the last page in virtual address space
(0xfffff000) to be allocated. This page overlaps with PTR_ERR, so that
shouldn't happen.

There is already some code to ensure memblock won't allocate the last page.
However, buddy allocator is left unchecked.

Fix this by reserving physical memory that would be mapped at virtual
addresses greater than 0xfffff000.

Reported-by: Björn Töpel <bjorn@kernel.org>
Closes: https://lore.kernel.org/linux-riscv/878r1ibpdn.fsf@all.your.base.are.belong.to.us
Fixes: 76d2a0493a17 ("RISC-V: Init and Halt Code")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: <stable@vger.kernel.org>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Link: https://lore.kernel.org/r/20240425115201.3044202-1-namcao@linutronix.de
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index e3218d65f21d..e3405e4b99af 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -250,18 +250,19 @@ static void __init setup_bootmem(void)
 		kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base;
 
 	/*
-	 * memblock allocator is not aware of the fact that last 4K bytes of
-	 * the addressable memory can not be mapped because of IS_ERR_VALUE
-	 * macro. Make sure that last 4k bytes are not usable by memblock
-	 * if end of dram is equal to maximum addressable memory.  For 64-bit
-	 * kernel, this problem can't happen here as the end of the virtual
-	 * address space is occupied by the kernel mapping then this check must
-	 * be done as soon as the kernel mapping base address is determined.
+	 * Reserve physical address space that would be mapped to virtual
+	 * addresses greater than (void *)(-PAGE_SIZE) because:
+	 *  - This memory would overlap with ERR_PTR
+	 *  - This memory belongs to high memory, which is not supported
+	 *
+	 * This is not applicable to 64-bit kernel, because virtual addresses
+	 * after (void *)(-PAGE_SIZE) are not linearly mapped: they are
+	 * occupied by kernel mapping. Also it is unrealistic for high memory
+	 * to exist on 64-bit platforms.
 	 */
 	if (!IS_ENABLED(CONFIG_64BIT)) {
-		max_mapped_addr = __pa(~(ulong)0);
-		if (max_mapped_addr == (phys_ram_end - 1))
-			memblock_set_current_limit(max_mapped_addr - 4096);
+		max_mapped_addr = __va_to_pa_nodebug(-PAGE_SIZE);
+		memblock_reserve(max_mapped_addr, (phys_addr_t)-max_mapped_addr);
 	}
 
 	min_low_pfn = PFN_UP(phys_ram_base);


