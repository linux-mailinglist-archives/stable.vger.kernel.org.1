Return-Path: <stable+bounces-53620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A8C90D31C
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37B61F21D94
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21664155747;
	Tue, 18 Jun 2024 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AIETJv7e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55812139A4
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717638; cv=none; b=pM53ZDOjURgVT0YIZz/8QijRjsi8rVabZde3LWJl7tDIPNZkg+6tTdSgqDPuRKHEi91yz6zVFo3kmvteNVvt2CweYLTz9knHa9tTf6egRKLasrfp8mauJzudhrtxzwtd5wlgXCz4eSGexAx47cjCngopMBMl1RLY58wVQtnE/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717638; c=relaxed/simple;
	bh=b18FijIe92LIxbyVlKxGz2B3TABtG28NuoMJckvZ1Dg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Z2ehJo6IOjsAnPHA5B5/iaoSTbmrP7SmiiFJg3U8JhYI9dCPPn7vh95b9jQeT91q1/hig+g2X5mc5V/cXJ0bUNBUml7AbnG8yAhtdaedRO2X0rOSbQUnURUoz9AJhQSiGejzJHvO7eFq2skNlROshmVVFovMb4ooz0aHJPEP5WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AIETJv7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46846C3277B;
	Tue, 18 Jun 2024 13:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718717638;
	bh=b18FijIe92LIxbyVlKxGz2B3TABtG28NuoMJckvZ1Dg=;
	h=Subject:To:Cc:From:Date:From;
	b=AIETJv7eCLJhLoYrAmfoZxREYg4zG0+k3ZmRP5GNKdtiiz6sSDpcjhbS49uDo+YW8
	 nIPqMS8xPwZRouEPjamYpBWX2OLZnKvAGO7QKkjKIJaq78Gnk/DMDZNSnP3Q1GhajN
	 S3UW9F/8qoYufdN9FA1gqxVVl6Sq616LrS5gFYy8=
Subject: FAILED: patch "[PATCH] riscv: fix overlap of allocated page and PTR_ERR" failed to apply to 5.4-stable tree
To: namcao@linutronix.de,bjorn@kernel.org,bjorn@rivosinc.com,palmer@rivosinc.com,rppt@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Jun 2024 15:25:49 +0200
Message-ID: <2024061849-unifier-skipping-b900@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 994af1825a2aa286f4903ff64a1c7378b52defe6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061849-unifier-skipping-b900@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


