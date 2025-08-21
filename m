Return-Path: <stable+bounces-172117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F89B2FAB4
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5CB37B3258
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C17338F3B;
	Thu, 21 Aug 2025 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q4BRayoY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFD12EF66F
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783276; cv=none; b=PPaJ0KI8ixLgMaFxPcy5tb74NCGAGn4hRAWJYfaVLENDwOQbe7oVoIeGHutsgXvgD87aqaL9TW5v0m3416ICt7d7Pz+yVZMK9ddvHoQAA5sS1H2lmqjXcUpRdiwOcYpMO2IVlaMlqkobQiyKt4MaAOnQyDPIcWSXMDZWLD8ZA1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783276; c=relaxed/simple;
	bh=1jgHr41eY3v3kN2F5z/2T/sMwOsHHCTTfnxn2cD/B8M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tNgu1pNc4JpNRQdkwlZlrbNpIY8szJgh60yoD6+690tCZyL1kAGRw7UiEiWOSMVtKOdSsHWWl9NRffzLNs2li9YFW34cUTim/LDeEis/wCZm5Edd3Plp4qIaGCN1RMq6nD08RI+9mDFD4iPtrI+TL2d4I5c0G3B2G/R7qGF5nTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q4BRayoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E631AC4CEEB;
	Thu, 21 Aug 2025 13:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755783276;
	bh=1jgHr41eY3v3kN2F5z/2T/sMwOsHHCTTfnxn2cD/B8M=;
	h=Subject:To:Cc:From:Date:From;
	b=Q4BRayoYqxvXLqrZQDQyBhrLJZ1AhkssAVWosev+SKIiyBPAe3IE6/DWvX+A4HqzL
	 2z0FRJiEcBzmyIh8fqmEJjwNxZI3yZROdoGiuN81Ybq1EYmAuM8dUSugZZDEAjDHOT
	 1/RvhsBjO+sjXuQndJcKiiVvo0xWX4NEOtFiiQM0=
Subject: FAILED: patch "[PATCH] parisc: Update comments in make_insert_tlb" failed to apply to 5.15-stable tree
To: dave.anglin@bell.net,deller@gmx.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:34:33 +0200
Message-ID: <2025082133-resubmit-starlit-d1e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x cb22f247f371bd206a88cf0e0c05d80b8b62fb26
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082133-resubmit-starlit-d1e3@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cb22f247f371bd206a88cf0e0c05d80b8b62fb26 Mon Sep 17 00:00:00 2001
From: John David Anglin <dave.anglin@bell.net>
Date: Mon, 21 Jul 2025 15:13:42 -0400
Subject: [PATCH] parisc: Update comments in make_insert_tlb

The following testcase exposed a problem with our read access checks
in get_user() and raw_copy_from_user():

#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/types.h>

int main(int argc, char **argv)
{
  unsigned long page_size = sysconf(_SC_PAGESIZE);
  char *p = malloc(3 * page_size);
  char *p_aligned;

  /* initialize memory region. If not initialized, write syscall below will correctly return EFAULT. */
  if (1)
	memset(p, 'X', 3 * page_size);

  p_aligned = (char *) ((((uintptr_t) p) + (2*page_size - 1)) & ~(page_size - 1));
  /* Drop PROT_READ protection. Kernel and userspace should fault when accessing that memory region */
  mprotect(p_aligned, page_size, PROT_NONE);

  /* the following write() should return EFAULT, since PROT_READ was dropped by previous mprotect() */
  int ret = write(2, p_aligned, 1);
  if (!ret || errno != EFAULT)
	printf("\n FAILURE: write() did not returned expected EFAULT value\n");

  return 0;
}

Because of the way _PAGE_READ is handled, kernel code never generates
a read access fault when it access a page as the kernel privilege level
is always less than PL1 in the PTE.

This patch reworks the comments in the make_insert_tlb macro to try
to make this clearer.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v5.12+

diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
index ea57bcc21dc5..f4bf61a34701 100644
--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -499,6 +499,12 @@
 	 * this happens is quite subtle, read below */
 	.macro		make_insert_tlb	spc,pte,prot,tmp
 	space_to_prot   \spc \prot        /* create prot id from space */
+
+#if _PAGE_SPECIAL_BIT == _PAGE_DMB_BIT
+	/* need to drop DMB bit, as it's used as SPECIAL flag */
+	depi		0,_PAGE_SPECIAL_BIT,1,\pte
+#endif
+
 	/* The following is the real subtlety.  This is depositing
 	 * T <-> _PAGE_REFTRAP
 	 * D <-> _PAGE_DIRTY
@@ -511,17 +517,18 @@
 	 * Finally, _PAGE_READ goes in the top bit of PL1 (so we
 	 * trigger an access rights trap in user space if the user
 	 * tries to read an unreadable page */
-#if _PAGE_SPECIAL_BIT == _PAGE_DMB_BIT
-	/* need to drop DMB bit, as it's used as SPECIAL flag */
-	depi		0,_PAGE_SPECIAL_BIT,1,\pte
-#endif
 	depd            \pte,8,7,\prot
 
 	/* PAGE_USER indicates the page can be read with user privileges,
 	 * so deposit X1|11 to PL1|PL2 (remember the upper bit of PL1
-	 * contains _PAGE_READ) */
+	 * contains _PAGE_READ). While the kernel can't directly write
+	 * user pages which have _PAGE_WRITE zero, it can read pages
+	 * which have _PAGE_READ zero (PL <= PL1). Thus, the kernel
+	 * exception fault handler doesn't trigger when reading pages
+	 * that aren't user read accessible */
 	extrd,u,*=      \pte,_PAGE_USER_BIT+32,1,%r0
 	depdi		7,11,3,\prot
+
 	/* If we're a gateway page, drop PL2 back to zero for promotion
 	 * to kernel privilege (so we can execute the page as kernel).
 	 * Any privilege promotion page always denys read and write */


