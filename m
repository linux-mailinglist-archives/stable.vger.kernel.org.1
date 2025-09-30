Return-Path: <stable+bounces-182034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D74CFBABAD6
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 08:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311941921116
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 06:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992EF2989B5;
	Tue, 30 Sep 2025 06:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="azxmxEHz"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60465286438;
	Tue, 30 Sep 2025 06:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759214375; cv=none; b=U30hQEu7zaFiOyDEYwh10JNkrRb3aaurd0eIEFWaNOppXzlhTCmEz1hAhqaCGHSv4PKpXOGH76ErE/erpkFDkfqPCF+MiEx4EpQbY6ptz5xJMQSL71C/lYQkh4aAcMQFdZn35huHF5OOVgbI2lQ7QWOMzrkDmszUvY9Pf3hByZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759214375; c=relaxed/simple;
	bh=nw/bLSq5G9rQ3CcqzFuU18zCBGTcRyRQtGlYG1tDRhk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NAkMhbHUkrb4sIqM93ZPe0dNhmQdnnoOAx2nFSKwkx82O0IoXdrb1LltMdqhDfy0yi7EotpeZDBXijygwhp+YJ356te5XCFWC3f9fO0h6PAo1Typ/IggWszNdNV4BxQk202FdzoKXfnk7ysRM+AWsvzu1rx3mGq5DBlUZaZRXEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=azxmxEHz; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759214373; x=1790750373;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=86mRlECkiQjLn2SJJnK2m65Vsp8KHxy7PFdzrijTjqg=;
  b=azxmxEHzHdcueQhpxudgwC3beQrkBgajLm6nqeX+oVVGBMqJUXZI4CET
   C1NIMUlW2ayt6X9aZNaBczRmLNIjDTqC45MIAh4luiz5H6N+UubicnbC3
   fA3EgR2iRRjx2DdLdzZCiOE0Py4SrZYtE5EvLBioZ9YI8U6MpKYKqQPIU
   fQ6uzBNP4+l7LHgi0xJUqD09Rzpo8OfCXZjOCFdD4zTT27uGc1kprSHwr
   jjYXa9pcg6OhcBOs4cxJvBOSZftUvO239n17WbOnxmrJ9OHshm1nYZ4Uv
   44ECjvxtSZHTa9/tu4UCp9Am992Uu0mdlpQ6MhiMRit2xCDWCR+VLJ+o4
   w==;
X-CSE-ConnectionGUID: yVQyi8UHR2GZdvsjzUxYjQ==
X-CSE-MsgGUID: 6QfZ61FCQjKdkpuOMnE98g==
X-IronPort-AV: E=Sophos;i="6.18,303,1751241600"; 
   d="scan'208";a="3869275"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 06:39:31 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:51513]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.222:2525] with esmtp (Farcaster)
 id b09c49d1-cacd-4012-a7e4-1eafac7f67cd; Tue, 30 Sep 2025 06:39:31 +0000 (UTC)
X-Farcaster-Flow-ID: b09c49d1-cacd-4012-a7e4-1eafac7f67cd
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 30 Sep 2025 06:39:31 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Tue, 30 Sep 2025
 06:39:29 +0000
From: Jakub Acs <acsjakub@amazon.de>
To: <linux-mm@kvack.org>
CC: <acsjakub@amazon.de>, Andrew Morton <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou
	<chengming.zhou@linux.dev>, Peter Xu <peterx@redhat.com>, Axel Rasmussen
	<axelrasmussen@google.com>, Mike Kravetz <mike.kravetz@oracle.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH] mm/ksm: fix flag-dropping behavior in ksm_madvise
Date: Tue, 30 Sep 2025 06:39:21 +0000
Message-ID: <20250930063921.62354-1-acsjakub@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

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
userfaultfd_release_all(). Specifically, a VMA which has a valid pointer
to vma->vm_userfaultfd_ctx, but no UFFD flags in vma->vm_flags.

The inconsistency is caused in ksm_madvise(): when user calls madvise()
with MADV_UNMEARGEABLE on a VMA that is registered for UFFD in MINOR
mode, it accidentally clears all flags stored in the upper 32 bits of
vma->vm_flags.

Assuming x86_64 kernel build, unsigned long is 64-bit and unsigned int
and int are 32-bit wide. This setup causes the following mishap during
the &= ~VM_MERGEABLE assignment.

VM_MERGEABLE is a 32-bit constant of type unsigned int, 0x8000'0000.
After ~ is applied, it becomes 0x7fff'ffff unsigned int, which is then
promoted to unsigned long before the & operation. This promotion fills
upper 32 bits with leading 0s, as we're doing unsigned conversion (and
even for a signed conversion, this wouldn't help as the leading bit is
0). & operation thus ends up AND-ing vm_flags with 0x0000'0000'7fff'ffff
instead of intended 0xffff'ffff'7fff'ffff and hence accidentally clears
the upper 32-bits of its value.

Fix it by casting `VM_MERGEABLE` constant to unsigned long to preserve
the upper 32 bits, in case it's needed.

Note: other VM_* flags are not affected:
This only happens to the VM_MERGEABLE flag, as the other VM_* flags are
all constants of type int and after ~ operation, they end up with
leading 1 and are thus converted to unsigned long with leading 1s.

Note 2:
After commit 31defc3b01d9 ("userfaultfd: remove (VM_)BUG_ON()s"), this is
no longer a kernel BUG, but a WARNING at the same place:

[   45.595973] WARNING: CPU: 1 PID: 2474 at mm/userfaultfd.c:2067

but the root-cause (flag-drop) remains the same.

Fixes: 7677f7fd8be76 ("userfaultfd: add minor fault registration mode")
Signed-off-by: Jakub Acs <acsjakub@amazon.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Xu Xin <xu.xin16@zte.com.cn>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Peter Xu <peterx@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
---

I looked around the kernel and found one more flag that might be
causing similar issues: "IORESOURCE_BUSY" - as its inverted version is
bit-anded to unsigned long fields. However, it seems those fields don't
actually use any bits from upper 32-bits as flags (yet?).

I also considered changing the constant definition by adding ULL, but am
not sure where else that could blow up, plus it would likely call to
define all the related constants as ULL for consistency. If you'd prefer
that fix, let me know.


 mm/ksm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 160787bb121c..c24137a1eeb7 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2871,7 +2871,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 				return err;
 		}
 
-		*vm_flags &= ~VM_MERGEABLE;
+		*vm_flags &= ~((unsigned long) VM_MERGEABLE);
 		break;
 	}
 
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


