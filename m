Return-Path: <stable+bounces-192699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8037FC3F3E9
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 10:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C86188A5BA
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 09:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D77283C8E;
	Fri,  7 Nov 2025 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="fw1/iwM8"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B26A21767A;
	Fri,  7 Nov 2025 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508989; cv=none; b=OcHYyLxXgP4PWTKcGqf6MmDvUJtidIiI/TQnV5OO3TzkDUPb8tLmssSz/JMKMsCtsMZ/x1MrHxsof+gAK4xf8IH4NxPpaCAuazBvd4kG5Xi15OJ2cmBoVPilmsBIvwFj7xEJs/dgMtljCTGW+Nxu4GAYWM0lIKkN5VuXmtHVolI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508989; c=relaxed/simple;
	bh=XkaQOlFtCI/XMXzkUTOuiDcM6Wrh7/NO7yO+DoduRBA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDnLiQxy4Va7Ne53F763yfNtsonGtJyxM3RnjCQLXQs12eeOv/uMxSF21xjKv1m5AzICDsqpiQo/eAFYheu5PjFKDBvwAndykXQOaWnUwzEOAH6wK4yQ4nF/qtXKHfeKb/c0buqJZ88Olh3cL/CTEfJg7RCemAX28zGdgckDaj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=fw1/iwM8; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1762508987; x=1794044987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tSmOMSfMDPnh2RnGvEKnRHhJf3u17n26UTMXVggCb24=;
  b=fw1/iwM8hCUYy3+V3HKNxWtT79zPK6nNTrENA07kbg5M7vdadUzCu9Hm
   cOfKRbUjNOendALF7/xRWKvBSbPaosYR1YW/epgK5jz8clsyCzue2WJCf
   2EBaOC7C3DNLQ9H3n5prRPOn3rZBh8uedspWriFj7jZokMzTmN0/ggG6W
   7vfMGblCzbraobGwVx1cIjNbTKmW1WUF6HFCwT+vjxbUNTH4iJ/qeYbsY
   Z3VMXhx1/c7aT1IzbJ6cFMHfNmyNRbiZCr0F/kiSMhKUwlj2BZ380SUNx
   brkXSvBaEd1r1cbADsEPhuBDYcVvzeyeMgEPflSMiJJw/gQ2UivAQAgOf
   Q==;
X-CSE-ConnectionGUID: Nq04Ner7T1iISROkPCGKRg==
X-CSE-MsgGUID: QoTYeIQ2T72oQgSQfm8RBQ==
X-IronPort-AV: E=Sophos;i="6.19,286,1754956800"; 
   d="scan'208";a="6610224"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 09:49:43 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:3609]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.26:2525] with esmtp (Farcaster)
 id c7de7f36-394a-411d-a4d8-9f571b0cb2a5; Fri, 7 Nov 2025 09:49:43 +0000 (UTC)
X-Farcaster-Flow-ID: c7de7f36-394a-411d-a4d8-9f571b0cb2a5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 7 Nov 2025 09:49:43 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Fri, 7 Nov 2025
 09:49:41 +0000
Date: Fri, 7 Nov 2025 09:49:38 +0000
From: Jakub Acs <acsjakub@amazon.de>
To: Vlastimil Babka <vbabka@suse.cz>
CC: <linux-mm@kvack.org>, Hugh Dickins <hughd@google.com>, Jann Horn
	<jannh@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <xu.xin16@zte.com.cn>,
	<chengming.zhou@linux.dev>, <peterx@redhat.com>, <axelrasmussen@google.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] mm/ksm: fix flag-dropping behavior in ksm_madvise
Message-ID: <20251107094938.GA71570@dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com>
References: <20251001090353.57523-1-acsjakub@amazon.de>
 <20251001090353.57523-2-acsjakub@amazon.de>
 <13c7242e-3a40-469b-9e99-8a65a21449bb@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <13c7242e-3a40-469b-9e99-8a65a21449bb@suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Thu, Nov 06, 2025 at 11:39:28AM +0100, Vlastimil Babka wrote:
> On 10/1/25 11:03, Jakub Acs wrote:
> > syzkaller discovered the following crash: (kernel BUG)
> > 
> > [   44.607039] ------------[ cut here ]------------
> > [   44.607422] kernel BUG at mm/userfaultfd.c:2067!
> > [   44.608148] Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> > [   44.608814] CPU: 1 UID: 0 PID: 2475 Comm: reproducer Not tainted 6.16.0-rc6 #1 PREEMPT(none)
> > [   44.609635] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > [   44.610695] RIP: 0010:userfaultfd_release_all+0x3a8/0x460
> > 
> > <snip other registers, drop unreliable trace>
> > 
> > [   44.617726] Call Trace:
> > [   44.617926]  <TASK>
> > [   44.619284]  userfaultfd_release+0xef/0x1b0
> > [   44.620976]  __fput+0x3f9/0xb60
> > [   44.621240]  fput_close_sync+0x110/0x210
> > [   44.622222]  __x64_sys_close+0x8f/0x120
> > [   44.622530]  do_syscall_64+0x5b/0x2f0
> > [   44.622840]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [   44.623244] RIP: 0033:0x7f365bb3f227
> > 
> > Kernel panics because it detects UFFD inconsistency during
> > userfaultfd_release_all(). Specifically, a VMA which has a valid pointer
> > to vma->vm_userfaultfd_ctx, but no UFFD flags in vma->vm_flags.
> > 
> > The inconsistency is caused in ksm_madvise(): when user calls madvise()
> > with MADV_UNMEARGEABLE on a VMA that is registered for UFFD in MINOR
> > mode, it accidentally clears all flags stored in the upper 32 bits of
> > vma->vm_flags.
> > 
> > Assuming x86_64 kernel build, unsigned long is 64-bit and unsigned int
> > and int are 32-bit wide. This setup causes the following mishap during
> > the &= ~VM_MERGEABLE assignment.
> > 
> > VM_MERGEABLE is a 32-bit constant of type unsigned int, 0x8000'0000.
> > After ~ is applied, it becomes 0x7fff'ffff unsigned int, which is then
> > promoted to unsigned long before the & operation. This promotion fills
> > upper 32 bits with leading 0s, as we're doing unsigned conversion (and
> > even for a signed conversion, this wouldn't help as the leading bit is
> > 0). & operation thus ends up AND-ing vm_flags with 0x0000'0000'7fff'ffff
> > instead of intended 0xffff'ffff'7fff'ffff and hence accidentally clears
> > the upper 32-bits of its value.
> > 
> > Fix it by changing `VM_MERGEABLE` constant to unsigned long, using the
> > BIT() macro.
> > 
> > Note: other VM_* flags are not affected:
> > This only happens to the VM_MERGEABLE flag, as the other VM_* flags are
> > all constants of type int and after ~ operation, they end up with
> > leading 1 and are thus converted to unsigned long with leading 1s.
> > 
> > Note 2:
> > After commit 31defc3b01d9 ("userfaultfd: remove (VM_)BUG_ON()s"), this is
> > no longer a kernel BUG, but a WARNING at the same place:
> > 
> > [   45.595973] WARNING: CPU: 1 PID: 2474 at mm/userfaultfd.c:2067
> > 
> > but the root-cause (flag-drop) remains the same.
> > 
> > Fixes: 7677f7fd8be76 ("userfaultfd: add minor fault registration mode")
> 
> Late to the party, but it seems to me the correct Fixes: should be
> f8af4da3b4c1 ("ksm: the mm interface to ksm")
> which introduced the flag and the buggy clearing code, no?
> 
> Commit 7677f7fd8be76 is just one that notices it, right? But there are other
> flags in >32 bit area, including pkeys etc. Sounds rather dangerous if they
> can be cleared using a madvise.
> 
> So we can't amend the Fixes: now but maybe could advise stable to backport
> for even older versions than based on 7677f7fd8be76 ?
> 

Good point. It was a bit tricky to determine the correct "fixes" tag, as
there were more candidates:
- the commit that initially introduced VM_MERGEABLE as a constant with
  different inferred type to other vm_flags constants
- the commit that first started using upper 32 bits of vm_flags and did
  not make sure the constants are defined safely
- f8af4da3b4c1 indeed, as the one that makes the drop actually possible
- 7677f7fd8be76 that shows us a path where the drop manifests

Looking back, I agree f8af4da3b4c1 is the better option, but as you
said, that won't be changed now.

Nevertheless, I'll send the backports after a round of kselftests,
thanks for pointing this out.

Have a good day,
Jakub
 



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


