Return-Path: <stable+bounces-182071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39E7BACF6D
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25FCE166787
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 13:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AB32FB97D;
	Tue, 30 Sep 2025 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="KKFjZJbK"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BE537160;
	Tue, 30 Sep 2025 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759237442; cv=none; b=OX9uj8j+wXJa2eEwvOxlSx+OlXUBIGYgMFsQ3WSP5DeWP02yyEKorM0fT2w1VIfClinkepd+LSCRuMtwsS0Og0ZaSBimJrYNOd7syXs72hdNqP82GBw6NY/vgjz1Ofh4ZS1/ZwRx9pz65ztmsYNLLLyACn96M2mCfTZcZIJX1jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759237442; c=relaxed/simple;
	bh=e1VIyu9SrXA/7Yl1DN2m1dcmduX/GPpg+lp4hGITwKw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOhiBrAjy2/eVJxHQ+BxkbrW0Uyv+FBkpId4Kj7SX/ltRf+GeOi2k8dTjiL7tSngTnNZ8bxPs9nLhOVk/T37IDGueVVYVxnSHmy/1oUHoG6R4TZSQYvXV0AdfUXiCJ/NeZy08iNZMl9HGFf4XoOK3PcU+1lYPlV9Shx8xtsEhGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=KKFjZJbK; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759237440; x=1790773440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WhlVEI2MoLfPkRucEaBmQrTt04FFRGUJh48fBB87kKs=;
  b=KKFjZJbKagY2uMy5V4NG6Wu4g2J9dppDK6aEbrAgeZZP6OIlv1Jyg9VQ
   ALRi8lHA7LKjaFxrdY16JawrnltmNPhwWCkKzJWqomaUjocmt0IQfjeeY
   Kx63VS2YmDtzstYvZqz8zN4OP5nxN5ia1ora5gApHulT+QE7zdOrFqZII
   VPHiUZhIJrYrfTt15bnQVmbwbwjVidOHqd4BaysiXreN/zQjU/WOkkigQ
   QJ3WjjLGNdhmwVLNUPFepGljL7xkJrmneVE/5YzG4j2Xlz5M20Lp2Wy2M
   8A2VMpeJu+bzbrlT8Q0DWZ2V5NJnS5pxi0h9Ho1epw+Ce+vze5HYZ8JWD
   w==;
X-CSE-ConnectionGUID: b0u3MeyNQ9mJ+sk9lFvUHQ==
X-CSE-MsgGUID: 4yr5xNxDQDOS4P53bm7vvQ==
X-IronPort-AV: E=Sophos;i="6.18,304,1751241600"; 
   d="scan'208";a="3879921"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 13:03:58 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:3093]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.1:2525] with esmtp (Farcaster)
 id 1a53291d-2aa4-4833-888d-41560634f81a; Tue, 30 Sep 2025 13:03:58 +0000 (UTC)
X-Farcaster-Flow-ID: 1a53291d-2aa4-4833-888d-41560634f81a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 30 Sep 2025 13:03:48 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Tue, 30 Sep 2025
 13:03:27 +0000
Date: Tue, 30 Sep 2025 13:03:24 +0000
From: Jakub Acs <acsjakub@amazon.de>
To: David Hildenbrand <david@redhat.com>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Xu Xin
	<xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, Peter Xu
	<peterx@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, Mike Kravetz
	<mike.kravetz@oracle.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] mm/ksm: fix flag-dropping behavior in ksm_madvise
Message-ID: <20250930130324.GA68215@dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com>
References: <20250930063921.62354-1-acsjakub@amazon.de>
 <d25474b8-c340-4546-a41e-60a6ecfc42c3@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d25474b8-c340-4546-a41e-60a6ecfc42c3@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Tue, Sep 30, 2025 at 08:45:48AM +0200, David Hildenbrand wrote:
> On 30.09.25 08:39, Jakub Acs wrote:
> >syzkaller discovered the following crash: (kernel BUG)
> >
> >[   44.607039] ------------[ cut here ]------------
> >[   44.607422] kernel BUG at mm/userfaultfd.c:2067!
> >[   44.608148] Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> >[   44.608814] CPU: 1 UID: 0 PID: 2475 Comm: reproducer Not tainted 6.16.0-rc6 #1 PREEMPT(none)
> >[   44.609635] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> >[   44.610695] RIP: 0010:userfaultfd_release_all+0x3a8/0x460
> >
> ><snip other registers, drop unreliable trace>
> >
> >[   44.617726] Call Trace:
> >[   44.617926]  <TASK>
> >[   44.619284]  userfaultfd_release+0xef/0x1b0
> >[   44.620976]  __fput+0x3f9/0xb60
> >[   44.621240]  fput_close_sync+0x110/0x210
> >[   44.622222]  __x64_sys_close+0x8f/0x120
> >[   44.622530]  do_syscall_64+0x5b/0x2f0
> >[   44.622840]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >[   44.623244] RIP: 0033:0x7f365bb3f227
> >
> >Kernel panics because it detects UFFD inconsistency during
> >userfaultfd_release_all(). Specifically, a VMA which has a valid pointer
> >to vma->vm_userfaultfd_ctx, but no UFFD flags in vma->vm_flags.
> >
> >The inconsistency is caused in ksm_madvise(): when user calls madvise()
> >with MADV_UNMEARGEABLE on a VMA that is registered for UFFD in MINOR
> >mode, it accidentally clears all flags stored in the upper 32 bits of
> >vma->vm_flags.
> >
> >Assuming x86_64 kernel build, unsigned long is 64-bit and unsigned int
> >and int are 32-bit wide. This setup causes the following mishap during
> >the &= ~VM_MERGEABLE assignment.
> >
> >VM_MERGEABLE is a 32-bit constant of type unsigned int, 0x8000'0000.
> >After ~ is applied, it becomes 0x7fff'ffff unsigned int, which is then
> >promoted to unsigned long before the & operation. This promotion fills
> >upper 32 bits with leading 0s, as we're doing unsigned conversion (and
> >even for a signed conversion, this wouldn't help as the leading bit is
> >0). & operation thus ends up AND-ing vm_flags with 0x0000'0000'7fff'ffff
> >instead of intended 0xffff'ffff'7fff'ffff and hence accidentally clears
> >the upper 32-bits of its value.
> >
> >Fix it by casting `VM_MERGEABLE` constant to unsigned long to preserve
> >the upper 32 bits, in case it's needed.
> >
> >Note: other VM_* flags are not affected:
> >This only happens to the VM_MERGEABLE flag, as the other VM_* flags are
> >all constants of type int and after ~ operation, they end up with
> >leading 1 and are thus converted to unsigned long with leading 1s.
> >
> >Note 2:
> >After commit 31defc3b01d9 ("userfaultfd: remove (VM_)BUG_ON()s"), this is
> >no longer a kernel BUG, but a WARNING at the same place:
> >
> >[   45.595973] WARNING: CPU: 1 PID: 2474 at mm/userfaultfd.c:2067
> >
> >but the root-cause (flag-drop) remains the same.
> >
> >Fixes: 7677f7fd8be76 ("userfaultfd: add minor fault registration mode")
> >Signed-off-by: Jakub Acs <acsjakub@amazon.de>
> >Cc: Andrew Morton <akpm@linux-foundation.org>
> >Cc: David Hildenbrand <david@redhat.com>
> >Cc: Xu Xin <xu.xin16@zte.com.cn>
> >Cc: Chengming Zhou <chengming.zhou@linux.dev>
> >Cc: Peter Xu <peterx@redhat.com>
> >Cc: Axel Rasmussen <axelrasmussen@google.com>
> >Cc: Mike Kravetz <mike.kravetz@oracle.com>
> >Cc: linux-mm@kvack.org
> >Cc: linux-kernel@vger.kernel.org
> >Cc: stable@vger.kernel.org
> >---
> >
> >I looked around the kernel and found one more flag that might be
> >causing similar issues: "IORESOURCE_BUSY" - as its inverted version is
> >bit-anded to unsigned long fields. However, it seems those fields don't
> >actually use any bits from upper 32-bits as flags (yet?).
> >
> >I also considered changing the constant definition by adding ULL, but am
> >not sure where else that could blow up, plus it would likely call to
> >define all the related constants as ULL for consistency. If you'd prefer
> >that fix, let me know.
> >
> >
> >  mm/ksm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/mm/ksm.c b/mm/ksm.c
> >index 160787bb121c..c24137a1eeb7 100644
> >--- a/mm/ksm.c
> >+++ b/mm/ksm.c
> >@@ -2871,7 +2871,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
> >  				return err;
> >  		}
> >-		*vm_flags &= ~VM_MERGEABLE;
> >+		*vm_flags &= ~((unsigned long) VM_MERGEABLE);
> >  		break;
> >  	}
> 
> Wouldn't it be better to just do
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1ae97a0b8ec75..0eaf8af153f98 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -296,7 +296,7 @@ extern unsigned int kobjsize(const void *objp);
>  #define VM_MIXEDMAP    0x10000000      /* Can contain "struct page" and pure PFN pages */
>  #define VM_HUGEPAGE    0x20000000      /* MADV_HUGEPAGE marked this vma */
>  #define VM_NOHUGEPAGE  0x40000000      /* MADV_NOHUGEPAGE marked this vma */
> -#define VM_MERGEABLE   0x80000000      /* KSM may merge identical pages */
> +#define VM_MERGEABLE   0x80000000ul    /* KSM may merge identical pages */
>  #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
>  #define VM_HIGH_ARCH_BIT_0     32      /* bit only usable on 64-bit architectures */
> 
> 
> And for consistency doing it to all other flags as well? After all we have
> 
> 	typedef unsigned long vm_flags_t;
> 

Makes sense, sent v2:
https://lore.kernel.org/all/20250930130023.60106-1-acsjakub@amazon.de/

Thank you,
Jakub



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


