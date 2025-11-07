Return-Path: <stable+bounces-192721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D71C3FE1A
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 13:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD8D188FB10
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 12:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139D929AB05;
	Fri,  7 Nov 2025 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="iKKPifur"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1823F28C014
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762517973; cv=none; b=AlEhHiaHwHWCF/4LA3a4ezp23Yno3/il3T8lTDj1pqPHHWuoA90Q0X8QTJKCPnlnvn3TeKyDZo1MS3FldMKld8Oj/be5CDTbvOAM1TrvCY3avzKhtsVgbnDR7ZqZnoLz5zTZA965aQXuxlLX4UVfkIQvZ7htIRK0mqGGMS1+wgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762517973; c=relaxed/simple;
	bh=ElNigRlMcZoy++NqhkJxE8eCSTjevM8ZAlSkkitYWGw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EGGQU1uS3Su6oqsRYPcsSgLXnmbkTDBQzr1Aps9O5HW2Y/tKdBoADZJbuw1o16YvbhMLpAPEAkIlIfIXvXW7zvNB0/Vx4gt5hbcn6n5ovDVayWM8LN3JaR1NGGnb5RXijLtPSuyytvtRPoSH8gzhJVEDYZeGfmIohR7HW92frr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=iKKPifur; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1762517972; x=1794053972;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DnkWM9dhJbs73bRoXkT8yDW6Q+d1t3I0EKqVUz4HFkk=;
  b=iKKPifurwsDY8JfouM5LGpbBvc0OqSqcSbp6TB+tMUmqCwDDn9mOuksc
   MjWXfCVUlvgTxmRHD6sZeBLQDxUn+oyNyuRJTeRXqNx9a+uiBLvUmFww7
   0NJdhVR7TzSrpINycWm+/1Rckq4bVTil5XWLTMaqqYIg27sLGIoq9ncD8
   zuwUTIlgup2BCWbaMxMZfNtU8HP/076GaijIFWoBntnsOtid17NhSY2jM
   4zGE9jGE5jEXhCVdzcqRRq1cpQFjuO441Op1ELXQLdxNSRbLS38QbL6sJ
   LM1nLl1iv1Tcikam87iYhvbgnSaYt+QaDhbysLkahxn2gx//CuwJlcWsn
   Q==;
X-CSE-ConnectionGUID: e8SlEJ3lRYW8EcDPsuJhpA==
X-CSE-MsgGUID: 2f5NE+7+RWObmWrXFdNgPg==
X-IronPort-AV: E=Sophos;i="6.19,286,1754956800"; 
   d="scan'208";a="6617457"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 12:19:29 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:4737]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.195:2525] with esmtp (Farcaster)
 id 5575f960-87ee-4976-b26b-3b2bd3a33540; Fri, 7 Nov 2025 12:19:29 +0000 (UTC)
X-Farcaster-Flow-ID: 5575f960-87ee-4976-b26b-3b2bd3a33540
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 7 Nov 2025 12:19:29 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Fri, 7 Nov 2025
 12:19:27 +0000
From: Jakub Acs <acsjakub@amazon.de>
To: <stable@vger.kernel.org>
CC: <acsjakub@amazon.de>, <vbabka@suse.cz>, Miguel Ojeda
	<miguel.ojeda.sandonis@gmail.com>, David Hildenbrand <david@redhat.com>,
	SeongJae Park <sj@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Xu Xin
	<xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, Peter Xu
	<peterx@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, Andrew Morton
	<akpm@linux-foundation.org>
Subject: [PATCH 5.4.y] mm/ksm: fix flag-dropping behavior in ksm_madvise
Date: Fri, 7 Nov 2025 12:19:20 +0000
Message-ID: <20251107121920.19211-1-acsjakub@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

[ Upstream commit f04aad36a07cc17b7a5d5b9a2d386ce6fae63e93 ]

syzkaller discovered the following crash: (kernel BUG)

[   44.607039] ------------[ cut here ]------------
[   44.607422] kernel BUG at mm/userfaultfd.c:2067!
[   44.608148] Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
[   44.608814] CPU: 1 UID: 0 PID: 2475 Comm: reproducer Not tainted 6.16.0-rc6 #1 PREEMPT(none)
[   44.609635] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   44.610695] RIP: 0010:userfaultfd_release_all+0x3a8/0x460

<snip other registers, drop unreliable trace>

[   44.617726] Call Trace:
[   44.617926]  <TASK>
[   44.619284]  userfaultfd_release+0xef/0x1b0
[   44.620976]  __fput+0x3f9/0xb60
[   44.621240]  fput_close_sync+0x110/0x210
[   44.622222]  __x64_sys_close+0x8f/0x120
[   44.622530]  do_syscall_64+0x5b/0x2f0
[   44.622840]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   44.623244] RIP: 0033:0x7f365bb3f227

Kernel panics because it detects UFFD inconsistency during
userfaultfd_release_all().  Specifically, a VMA which has a valid pointer
to vma->vm_userfaultfd_ctx, but no UFFD flags in vma->vm_flags.

The inconsistency is caused in ksm_madvise(): when user calls madvise()
with MADV_UNMEARGEABLE on a VMA that is registered for UFFD in MINOR mode,
it accidentally clears all flags stored in the upper 32 bits of
vma->vm_flags.

Assuming x86_64 kernel build, unsigned long is 64-bit and unsigned int and
int are 32-bit wide.  This setup causes the following mishap during the &=
~VM_MERGEABLE assignment.

VM_MERGEABLE is a 32-bit constant of type unsigned int, 0x8000'0000.
After ~ is applied, it becomes 0x7fff'ffff unsigned int, which is then
promoted to unsigned long before the & operation.  This promotion fills
upper 32 bits with leading 0s, as we're doing unsigned conversion (and
even for a signed conversion, this wouldn't help as the leading bit is 0).
& operation thus ends up AND-ing vm_flags with 0x0000'0000'7fff'ffff
instead of intended 0xffff'ffff'7fff'ffff and hence accidentally clears
the upper 32-bits of its value.

Fix it by changing `VM_MERGEABLE` constant to unsigned long, using the
BIT() macro.

Note: other VM_* flags are not affected: This only happens to the
VM_MERGEABLE flag, as the other VM_* flags are all constants of type int
and after ~ operation, they end up with leading 1 and are thus converted
to unsigned long with leading 1s.

Note 2:
After commit 31defc3b01d9 ("userfaultfd: remove (VM_)BUG_ON()s"), this is
no longer a kernel BUG, but a WARNING at the same place:

[   45.595973] WARNING: CPU: 1 PID: 2474 at mm/userfaultfd.c:2067

but the root-cause (flag-drop) remains the same.

[akpm@linux-foundation.org: rust bindgen wasn't able to handle BIT(), from Miguel]
  Link: https://lore.kernel.org/oe-kbuild-all/202510030449.VfSaAjvd-lkp@intel.com/
Link: https://lkml.kernel.org/r/20251001090353.57523-2-acsjakub@amazon.de
Fixes: 7677f7fd8be7 ("userfaultfd: add minor fault registration mode")
Signed-off-by: Jakub Acs <acsjakub@amazon.de>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: SeongJae Park <sj@kernel.org>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Xu Xin <xu.xin16@zte.com.cn>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Peter Xu <peterx@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ acsjakub: drop rust-compatibility change (no rust in 5.4) ]
Signed-off-by: Jakub Acs <acsjakub@amazon.de>
---
Why sending to stable version from before "fixes"?

In the original patch, I set fixes tag to the change that allows the
panic to manifest, not to the one that is real root-cause of the
problem.

The change that introduced the root-cause of the problem is:
f8af4da3b4c1 ("ksm: the mm interface to ksm"), as pointed out by
Vlastimil in [1].

Hence, as the older kernels can be affected by the flag-drop as well,
backport to older kernels.

[1]: https://lore.kernel.org/all/13c7242e-3a40-469b-9e99-8a65a21449bb@suse.cz/

 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 57cba6e4fdcd..be8c793233d3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -293,7 +293,7 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
 #define VM_HUGEPAGE	0x20000000	/* MADV_HUGEPAGE marked this vma */
 #define VM_NOHUGEPAGE	0x40000000	/* MADV_NOHUGEPAGE marked this vma */
-#define VM_MERGEABLE	0x80000000	/* KSM may merge identical pages */
+#define VM_MERGEABLE	BIT(31)		/* KSM may merge identical pages */
 
 #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
 #define VM_HIGH_ARCH_BIT_0	32	/* bit only usable on 64-bit architectures */
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


