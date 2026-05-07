Return-Path: <stable+bounces-244651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPnfHxsm/Wn6YAAAu9opvQ
	(envelope-from <stable+bounces-244651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 01:54:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D40C64F0655
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 01:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48C08302D527
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 23:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD653340281;
	Thu,  7 May 2026 23:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UB9dB7Se"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0C93469E7
	for <stable@vger.kernel.org>; Thu,  7 May 2026 23:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778198040; cv=none; b=aoNzJDIpWcqVAkabhgdv4cVF5UVpO3N9N6axzsJBplJbBBt7LhkpnEv+n/GfD04faCG79MNSg9YZvj3AtrYD8FvcHdB9q6UXh55Uh/NHASbsfIHuGvV4melbMjabDPGZ8e9rtWW3ewgtTqbI2F2Aa7/E4LFXcVELOnUelw+MzNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778198040; c=relaxed/simple;
	bh=YgUUBCT9tbhy2QZ45XowXTPYVZ8ZYA7uOiuEsQNGW+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtMetxiL0A3xPe2UIXQDLODx6TK2NbcBySMbvHRW+rOdtkWeFzfCPclMlb6s0AbuS5hvGhxr5G1jdAvzxP6JHFK2P0bVLTt537HSVf64n7ruunSmK4ibLUJFI7o6uiRmRHIN/0s/lPG3TD5S6HEPF3H/Eg9LpSxilIRapOD1PuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UB9dB7Se; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778198039; x=1809734039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YgUUBCT9tbhy2QZ45XowXTPYVZ8ZYA7uOiuEsQNGW+M=;
  b=UB9dB7SehOhn2Wpj/b0bQKSEQDnTsX8JTWzFEc2rhzMUQiE6KapElGek
   K7M7HcdZksdApy3VKMJY7Vkak1vSxl6KJqS0JOeOGp8R2FhgNTTXH21Hn
   MD/gbObbsHo4Z+V0l5rVbljhxVaqhVUyK+SeZSErjWIwIDGj8OQ9h6VrD
   5yjukQRLDeHxk4NgA30II5Cm6HkT7+QZA2CLye4UiFyFa4/5LgTWIbb/5
   zOKe0NXY4HCHCK6yobqGYvtk75691gytmQwh9aWOAJzWTHVLEmbXaavZi
   /W2M9uiuwYVCswkVi9vmH/YtHaeexMQ5ECEuktZ3/cNowAKtQf6dkPTvL
   w==;
X-CSE-ConnectionGUID: 2fQxjRNlS6OYLIXaA/ny+A==
X-CSE-MsgGUID: Aem5AwKtR8m5rth/+vhHYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="83033188"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="83033188"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 16:53:58 -0700
X-CSE-ConnectionGUID: o8F+hLFdQNCyWwbNWDkwyw==
X-CSE-MsgGUID: ERi4ZGgHQiSdHmr/QEhW+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="240599698"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.139])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 16:53:58 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: stable@vger.kernel.org
Cc: rick.p.edgecombe@intel.com,
	dave.hansen@intel.com,
	tglx@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 6.12.y] x86/shstk: Prevent deadlock during shstk sigreturn
Date: Thu,  7 May 2026 16:53:48 -0700
Message-ID: <20260507235348.1394848-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026050436-breeches-reformat-d041@gregkh>
References: <2026050436-breeches-reformat-d041@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D40C64F0655
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244651-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[rick.p.edgecombe@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

[ Upstream commit 9874b2917b9fbc30956fee209d3c4aa47201c64e ]

During sigreturn the shadow stack signal frame is popped. The kernel does
this by reading the shadow stack using normal read accesses. When it can't
assume the memory is shadow stack, it takes extra steps to makes sure it is
reading actual shadow stack memory and not other normal readable memory. It
does this by holding the mmap read lock while doing the access and checking
the flags of the VMA.

Unfortunately that is not safe. If the read of the shadow stack sigframe
hits a page fault, the fault handler will try to recursively grab another
mmap read lock. This normally works ok, but if a writer on another CPU is
also waiting, the second read lock could fail and cause a deadlock.

Fix this by doing the read of the userspace memory via gup. Embed it in the
get_shstk_data() helper.

Currently there is a check that skips the lookup work when the SSP can be
assumed to be on a shadow stack. While reorganizing the function, remove
the optimization to make the tricky code flows more common, such that
issues like this cannot escape detection for so long.

[Due to missing per-vma MM sequence counter, use a simpler GUP based
solution for the backport]
Cc: <stable@vger.kernel.org> # Depends on https://lore.kernel.org/all/20260504205856.536296-1-rick.p.edgecombe@intel.com/
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/shstk.c | 46 ++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 0dc983b33b003..373a44a5c478f 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -18,6 +18,7 @@
 #include <linux/sizes.h>
 #include <linux/user.h>
 #include <linux/syscalls.h>
+#include <linux/highmem.h>
 #include <asm/msr.h>
 #include <asm/fpu/xstate.h>
 #include <asm/fpu/types.h>
@@ -262,11 +263,29 @@ static int put_shstk_data(u64 __user *addr, u64 data)
 	return 0;
 }
 
+/* Copy from aligned address in userspace without risk of page fault. */
+static int shstk_copy_user_gup(unsigned long *ldata, unsigned long __user *addr)
+{
+	struct page *page;
+	void *kaddr;
+
+	mmap_assert_locked(current->mm);
+	if (get_user_pages((unsigned long)addr, 1, 0, &page) != 1)
+		return -EFAULT;
+
+	kaddr = kmap_local_page(page);
+	*ldata = *(unsigned long *)(kaddr + offset_in_page(addr));
+	kunmap_local(kaddr);
+	put_page(page);
+
+	return 0;
+}
+
 static int get_shstk_data(unsigned long *data, unsigned long __user *addr)
 {
 	unsigned long ldata;
 
-	if (unlikely(get_user(ldata, addr)))
+	if (shstk_copy_user_gup(&ldata, addr))
 		return -EFAULT;
 
 	if (!(ldata & SHSTK_DATA_BIT))
@@ -296,7 +315,6 @@ static int shstk_pop_sigframe(unsigned long *ssp)
 {
 	struct vm_area_struct *vma;
 	unsigned long token_addr;
-	bool need_to_check_vma;
 	int err = 1;
 
 	/*
@@ -308,26 +326,21 @@ static int shstk_pop_sigframe(unsigned long *ssp)
 	if (!IS_ALIGNED(*ssp, 8))
 		return -EINVAL;
 
-	need_to_check_vma = PAGE_ALIGN(*ssp) == *ssp;
-
-	if (need_to_check_vma)
-		if (mmap_read_lock_killable(current->mm))
-			return -EINTR;
+	if (mmap_read_lock_killable(current->mm))
+		return -EINTR;
 
 	err = get_shstk_data(&token_addr, (unsigned long __user *)*ssp);
 	if (unlikely(err))
 		goto out_err;
 
-	if (need_to_check_vma) {
-		vma = find_vma(current->mm, *ssp);
-		if (!vma || !(vma->vm_flags & VM_SHADOW_STACK)) {
-			err = -EFAULT;
-			goto out_err;
-		}
-
-		mmap_read_unlock(current->mm);
+	vma = find_vma(current->mm, *ssp);
+	if (!vma || !(vma->vm_flags & VM_SHADOW_STACK)) {
+		err = -EFAULT;
+		goto out_err;
 	}
 
+	mmap_read_unlock(current->mm);
+
 	/* Restore SSP aligned? */
 	if (unlikely(!IS_ALIGNED(token_addr, 8)))
 		return -EINVAL;
@@ -340,8 +353,7 @@ static int shstk_pop_sigframe(unsigned long *ssp)
 
 	return 0;
 out_err:
-	if (need_to_check_vma)
-		mmap_read_unlock(current->mm);
+	mmap_read_unlock(current->mm);
 	return err;
 }
 
-- 
2.54.0


