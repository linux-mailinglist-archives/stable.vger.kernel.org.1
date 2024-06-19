Return-Path: <stable+bounces-53691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D42090E3D7
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08BEC284002
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 06:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897376F305;
	Wed, 19 Jun 2024 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="peD2WJ98"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498EF6F2EF
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718780282; cv=none; b=oi55/HqfeaL4MFk/QhUCBDUgJA++Brg8EX+bO/aRmO6PTc7TaHlGysbNaouuYosyRwiSFfwRYeiRwjmpc97NQVaf95v/TFIoISByAnsRpUCWcYQblKvX1goLcA5bIyihjXZ8XPDwsaotQJW22aZ7/Ug3mPLlpIoF8CM8OarL2SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718780282; c=relaxed/simple;
	bh=7hQJVTdC2tjKCmWVcRFS3KWJ5lryzwcsbUJmtzzkeng=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O7tjNemt1sLdeTBgAkOdYkEY1Gf1Y8rHTVkQqmJqf7fqOMPk2UOCjGB4z399blX1PfmwbOdQIwzQW8T7KMQO205XL1To9esMS0W1Fzz6yjEkAIe5JNCVR3ocTXjpbO/muSirlEQV5HlmitNmyZqjyr4wotQLUZbS61Lec/gG8H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=peD2WJ98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2A2C2BBFC;
	Wed, 19 Jun 2024 06:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718780281;
	bh=7hQJVTdC2tjKCmWVcRFS3KWJ5lryzwcsbUJmtzzkeng=;
	h=Subject:To:Cc:From:Date:From;
	b=peD2WJ98QcOn8VxT02wd/70t1bWVOL1c1K/AWsilc/fvCapDvCIQ2PO6YG3ThMmeF
	 89La4HdMv4DsVXACSz2D+vHT0tEpSEMHWWLVrM85RpgRFC3JbJ4Ez6nUVVhLyhD+Jf
	 E4sOC7vtn3Qx799VCop0rLVV3G+pRc98DhFTD6U0=
Subject: FAILED: patch "[PATCH] riscv: force PAGE_SIZE linear mapping if debug_pagealloc is" failed to apply to 6.1-stable tree
To: namcao@linutronix.de,alexghiti@rivosinc.com,palmer@rivosinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 08:57:50 +0200
Message-ID: <2024061950-cahoots-cesarean-de11@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c67ddf59ac44adc60649730bf8347e37c516b001
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061950-cahoots-cesarean-de11@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


