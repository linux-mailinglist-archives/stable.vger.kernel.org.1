Return-Path: <stable+bounces-53690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B2F90E3D6
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBEFEB21882
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 06:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADCB6F305;
	Wed, 19 Jun 2024 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zkNiEnMe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1376F2EF
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718780273; cv=none; b=sjFc/Dz4aT4k73Cy/XIwcxVs2aChrXinxFmoU1CVj9DyW/CMXkFdQZWpnxrJnxEjT0I9kYRVSx5jHqhjl0J5b30OSZkZcKd60LpMjVhZA2sXwP+f87Xfeqgal/20ZWBstU2fOTWIecEJ09V7UeGQemkxvFRJRnggTKLk21nynX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718780273; c=relaxed/simple;
	bh=M0FEN57JaY/xoiTtD8zsNTgthMjGbPISff0kmQOEEsg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=R7gHtnaC3a6apVPbB7mwY+syvqLQ7ZqpBEpEg7bwDl6z7CmpBsHZ/YiZkHQzg2/hNX6M+fm35Ei3kMXIRFYCZQGTRKAyQoT44aAY2cirS3EqnQkqzdM1yEbp1T4Y6nGrFPM/mXxDjggX9VpystiwrjnQ3608JZHzEGColmI8+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zkNiEnMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F09C2BBFC;
	Wed, 19 Jun 2024 06:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718780273;
	bh=M0FEN57JaY/xoiTtD8zsNTgthMjGbPISff0kmQOEEsg=;
	h=Subject:To:Cc:From:Date:From;
	b=zkNiEnMeXYMrGR4xdTuDU7XH/3MvgeZ+m5D9TSXR4hvO9mZXGB/rJVqSHYW+3Nz7Y
	 5AquZTg2/kGC3R/bdbDJCehv2zAH8uWv5Rkc+lVG+esnSIuezH672rntowMclR7pp7
	 tU5nhE7oPBPRupGSDCIMLZt5gJaCLgq4CMeFOCpM=
Subject: FAILED: patch "[PATCH] riscv: force PAGE_SIZE linear mapping if debug_pagealloc is" failed to apply to 6.6-stable tree
To: namcao@linutronix.de,alexghiti@rivosinc.com,palmer@rivosinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 08:57:49 +0200
Message-ID: <2024061949-decree-impart-c089@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c67ddf59ac44adc60649730bf8347e37c516b001
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061949-decree-impart-c089@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

c67ddf59ac44 ("riscv: force PAGE_SIZE linear mapping if debug_pagealloc is enabled")
629db01c64ff ("riscv: Don't use PGD entries for the linear mapping")

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


