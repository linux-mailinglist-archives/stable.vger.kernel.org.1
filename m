Return-Path: <stable+bounces-53693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D6E90E3DC
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4F02842F7
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 06:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822E473464;
	Wed, 19 Jun 2024 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XYZ9lhLn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4447F71B45
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 06:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718780288; cv=none; b=Rpb0/PX7OdSGSNw517K4418MzJOVt+YcNBLg4YcthnJIcWjj48ARnMv1dduCbLpn7T48RWqDggRIKctId0edniKVIx36G68iHppOIH/mAcg6nnbCAilH1WYmWeEhZ8KE3dl0oc+n8PnKFBSJ4WbYBubL0hLmLdCJ8M2nbNIHjEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718780288; c=relaxed/simple;
	bh=YxjA/GKRUncoQpZteN6suIJ2vyQf+onI3DAE4VKtRbc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FYr56y6O13wkvhWvHBOJwLni9xYTY1ZavSM86C8857GWE1fsuPfr0/cLw+wFlss0EPSR9bUDr5Oj+MS18sotGriHFN6zvHnR8LO98aljMGPPX4fjuM0/xyfGghPBUn8duoMwtAb+xRYWRYBupnOU+hMf35I26TC/2zQq70Btqz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XYZ9lhLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A288C4AF1A;
	Wed, 19 Jun 2024 06:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718780287;
	bh=YxjA/GKRUncoQpZteN6suIJ2vyQf+onI3DAE4VKtRbc=;
	h=Subject:To:Cc:From:Date:From;
	b=XYZ9lhLnmPTiRh9cFP1CUpak9U9k/WFOvcrJJi9jPlvCpnb+45pSO62WukPB4I9NT
	 ScH9nPlfj3do4pZTjmYdWJJomvjEluNdgbe20Uod5N6g8db5KGe4He2HxuvXNRhSv/
	 5Qah6Q3H5QKNG46H9Cdy8A9+O//sjoLtJhLAxSLQ=
Subject: FAILED: patch "[PATCH] riscv: force PAGE_SIZE linear mapping if debug_pagealloc is" failed to apply to 5.10-stable tree
To: namcao@linutronix.de,alexghiti@rivosinc.com,palmer@rivosinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 08:57:52 +0200
Message-ID: <2024061952-placard-ninja-d1c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c67ddf59ac44adc60649730bf8347e37c516b001
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061952-placard-ninja-d1c5@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

c67ddf59ac44 ("riscv: force PAGE_SIZE linear mapping if debug_pagealloc is enabled")
629db01c64ff ("riscv: Don't use PGD entries for the linear mapping")
49a0a3731596 ("riscv: Check the virtual alignment before choosing a map size")
25abe0db9243 ("riscv: Fix kfence now that the linear mapping can be backed by PUD/P4D/PGD")
310c33dc7a12 ("Merge patch series "Introduce 64b relocatable kernel"")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c67ddf59ac44adc60649730bf8347e37c516b001 Mon Sep 17 00:00:00 2001
From: Nam Cao <namcao@linutronix.de>
Date: Wed, 15 May 2024 07:50:39 +0200
Subject: [PATCH] riscv: force PAGE_SIZE linear mapping if debug_pagealloc is
 enabled

debug_pagealloc is a debug feature which clears the valid bit in page table
entry for freed pages to detect illegal accesses to freed memory.

For this feature to work, virtual mapping must have PAGE_SIZE resolution.
(No, we cannot map with huge pages and split them only when needed; because
pages can be allocated/freed in atomic context and page splitting cannot be
done in atomic context)

Force linear mapping to use small pages if debug_pagealloc is enabled.

Note that it is not necessary to force the entire linear mapping, but only
those that are given to memory allocator. Some parts of memory can keep
using huge page mapping (for example, kernel's executable code). But these
parts are minority, so keep it simple. This is just a debug feature, some
extra overhead should be acceptable.

Fixes: 5fde3db5eb02 ("riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/2e391fa6c6f9b3fcf1b41cefbace02ee4ab4bf59.1715750938.git.namcao@linutronix.de
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fe8e159394d8..9020844f5189 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -668,6 +668,9 @@ void __init create_pgd_mapping(pgd_t *pgdp,
 static uintptr_t __init best_map_size(phys_addr_t pa, uintptr_t va,
 				      phys_addr_t size)
 {
+	if (debug_pagealloc_enabled())
+		return PAGE_SIZE;
+
 	if (pgtable_l5_enabled &&
 	    !(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >= P4D_SIZE)
 		return P4D_SIZE;


