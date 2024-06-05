Return-Path: <stable+bounces-48233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9DC8FD191
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 17:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E70B1F25474
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F147E4778E;
	Wed,  5 Jun 2024 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gurxuPCA"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898C945030
	for <stable@vger.kernel.org>; Wed,  5 Jun 2024 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601115; cv=none; b=nyWtqT2KDhj/hH/r+D74HmvtZ5CNgclBcLZeDfUdxxUmmm/NLp8Lj2PbjWCP/KOIsUzlaaC5V5JQWzMq5hUoJlHL4vS75BnkZJ1/p3A9it6/mfhqt40g20KnaFWDSJ+uZkOQlDOhR03+RIGW/At8UeozZ1j1bemrhwe9VQEaDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601115; c=relaxed/simple;
	bh=kGdBQb9DP47D8JHH/7IbJAetPXS61ZW00e/eAYL9h1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jktJjG8o/2F5Nb4yjsAWNJrCdxKj+ZxYf6JdzlMiOxlxpkSN+dcyHUAbRilUY2odxv7bGHb5XbYbOqNAIxBa1tnywjn8Jg6oVZd2GkkntzUIA2zziVPsHRYMTObDD4VB/z17DtBTOPUGw5/zkWy+Dj5H3MlNjlEI2ncyXDUqFko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gurxuPCA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717601112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8SLS2mVzgKo7z4DKJciMiqN7f3TQqan2EAaLyoLnxNQ=;
	b=gurxuPCARe1cgkfLp1Yg4RkoG120ZWLGS1RxIVzcayBCiJppbqvlrH8N2+WJvxJaBNqZfn
	yZWt9MHV2QR9W5lYzqlI0Dv2LY0q3Znnyfk/rB0CARR5nJkdw17al9mvhyD8eycPgW4ixd
	RI6C+IiKlmmTVKsZ/wen1/jo3lnn/7M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-f6gD2Y33OpWEOtBU_hKOEA-1; Wed, 05 Jun 2024 11:25:11 -0400
X-MC-Unique: f6gD2Y33OpWEOtBU_hKOEA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6af678b31b8so6858596d6.2
        for <stable@vger.kernel.org>; Wed, 05 Jun 2024 08:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717601110; x=1718205910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SLS2mVzgKo7z4DKJciMiqN7f3TQqan2EAaLyoLnxNQ=;
        b=Y9Tl6D+vvLZORn/QHeZb58bbThkzQemXiO4LRbRG0hIo6Mt9AXZqXcuVSjjktFz0Cr
         NeeVa4NbCu/SqWDhVnG2cRwiEGTo1LbTQaL19nEWMmt2fhNIrabH0Wsuen3ZNFyAOW+6
         zboE0IuqAw+sMbkSTlu8qQLgSTZzp1E8nRJI6nSGO6Yve8ivrU9hoDmfgl1pk956f/+t
         1qaYGimVdrldywzjbOvjniB6j1auCbwlcey3FTjCAAMHB5vEUL8DSGPxXAAQ3zFnGd2Y
         g/sprhDjl3t6ZdTA5ylS7DYZ3yobNcsJMUtVCOyNJ8bhs5X+Vnee+NT2LwuE1MMbg0qN
         BZXA==
X-Forwarded-Encrypted: i=1; AJvYcCVL98cI5WgWb4POzFZOikcv7k6eYm63Fpbk3h22+eaaCosLULb7G7lw+ZeP4BjQi2Ct8ZGV2S+TKG1I6l8j5nX/Y+hWCxdW
X-Gm-Message-State: AOJu0Ywf6BAPGcrPNUmEBhItTRWYXyqB8pusa64ctKySm0MwFODvq9r7
	Snl6TIpV78tNX2EBfnJGtTjtthP++oi3Z/F7BtmXKLFNrBo1RktzomP1y2ETOgHHlR+a2ViNNCe
	h0Q6brXvX4nKMrAB3mkieiA5vMY2YWUSFP5sHYZcVc23ZSlAaoX2EBQ==
X-Received: by 2002:a05:620a:178a:b0:794:ef5d:9e92 with SMTP id af79cd13be357-79523fccf54mr261012385a.6.1717601110219;
        Wed, 05 Jun 2024 08:25:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqmDUutYC7Er2IMw8kuASaE/wUAWK/1VhJ0D8S/pUpFbRkHxhW1udCWtUb3BJ6GRAYV8xkaA==
X-Received: by 2002:a05:620a:178a:b0:794:ef5d:9e92 with SMTP id af79cd13be357-79523fccf54mr261007385a.6.1717601109404;
        Wed, 05 Jun 2024 08:25:09 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7951955c4f8sm131120585a.50.2024.06.05.08.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 08:25:08 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:25:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: oliver.sang@intel.com, paulmck@kernel.org, david@redhat.com,
	willy@infradead.org, riel@surriel.com, vivek.kasireddy@intel.com,
	cl@linux.com, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: page_ref: remove folio_try_get_rcu()
Message-ID: <ZmCDU5PMBqE-H-om@x1n>
References: <20240604234858.948986-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604234858.948986-1-yang@os.amperecomputing.com>

On Tue, Jun 04, 2024 at 04:48:57PM -0700, Yang Shi wrote:
> The below bug was reported on a non-SMP kernel:
> 
> [  275.267158][ T4335] ------------[ cut here ]------------
> [  275.267949][ T4335] kernel BUG at include/linux/page_ref.h:275!
> [  275.268526][ T4335] invalid opcode: 0000 [#1] KASAN PTI
> [  275.269001][ T4335] CPU: 0 PID: 4335 Comm: trinity-c3 Not tainted 6.7.0-rc4-00061-gefa7df3e3bb5 #1
> [  275.269787][ T4335] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  275.270679][ T4335] RIP: 0010:try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
> [  275.272813][ T4335] RSP: 0018:ffffc90005dcf650 EFLAGS: 00010202
> [  275.273346][ T4335] RAX: 0000000000000246 RBX: ffffea00066e0000 RCX: 0000000000000000
> [  275.274032][ T4335] RDX: fffff94000cdc007 RSI: 0000000000000004 RDI: ffffea00066e0034
> [  275.274719][ T4335] RBP: ffffea00066e0000 R08: 0000000000000000 R09: fffff94000cdc006
> [  275.275404][ T4335] R10: ffffea00066e0037 R11: 0000000000000000 R12: 0000000000000136
> [  275.276106][ T4335] R13: ffffea00066e0034 R14: dffffc0000000000 R15: ffffea00066e0008
> [  275.276790][ T4335] FS:  00007fa2f9b61740(0000) GS:ffffffff89d0d000(0000) knlGS:0000000000000000
> [  275.277570][ T4335] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  275.278143][ T4335] CR2: 00007fa2f6c00000 CR3: 0000000134b04000 CR4: 00000000000406f0
> [  275.278833][ T4335] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  275.279521][ T4335] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  275.280201][ T4335] Call Trace:
> [  275.280499][ T4335]  <TASK>
> [ 275.280751][ T4335] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447)
> [ 275.281087][ T4335] ? do_trap (arch/x86/kernel/traps.c:112 arch/x86/kernel/traps.c:153)
> [ 275.281463][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
> [ 275.281884][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
> [ 275.282300][ T4335] ? do_error_trap (arch/x86/kernel/traps.c:174)
> [ 275.282711][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
> [ 275.283129][ T4335] ? handle_invalid_op (arch/x86/kernel/traps.c:212)
> [ 275.283561][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
> [ 275.283990][ T4335] ? exc_invalid_op (arch/x86/kernel/traps.c:264)
> [ 275.284415][ T4335] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568)
> [ 275.284859][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
> [ 275.285278][ T4335] try_grab_folio (mm/gup.c:148)
> [ 275.285684][ T4335] __get_user_pages (mm/gup.c:1297 (discriminator 1))
> [ 275.286111][ T4335] ? __pfx___get_user_pages (mm/gup.c:1188)
> [ 275.286579][ T4335] ? __pfx_validate_chain (kernel/locking/lockdep.c:3825)
> [ 275.287034][ T4335] ? mark_lock (kernel/locking/lockdep.c:4656 (discriminator 1))
> [ 275.287416][ T4335] __gup_longterm_locked (mm/gup.c:1509 mm/gup.c:2209)
> [ 275.288192][ T4335] ? __pfx___gup_longterm_locked (mm/gup.c:2204)
> [ 275.288697][ T4335] ? __pfx_lock_acquire (kernel/locking/lockdep.c:5722)
> [ 275.289135][ T4335] ? __pfx___might_resched (kernel/sched/core.c:10106)
> [ 275.289595][ T4335] pin_user_pages_remote (mm/gup.c:3350)
> [ 275.290041][ T4335] ? __pfx_pin_user_pages_remote (mm/gup.c:3350)
> [ 275.290545][ T4335] ? find_held_lock (kernel/locking/lockdep.c:5244 (discriminator 1))
> [ 275.290961][ T4335] ? mm_access (kernel/fork.c:1573)
> [ 275.291353][ T4335] process_vm_rw_single_vec+0x142/0x360
> [ 275.291900][ T4335] ? __pfx_process_vm_rw_single_vec+0x10/0x10
> [ 275.292471][ T4335] ? mm_access (kernel/fork.c:1573)
> [ 275.292859][ T4335] process_vm_rw_core+0x272/0x4e0
> [ 275.293384][ T4335] ? hlock_class (arch/x86/include/asm/bitops.h:227 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228)
> [ 275.293780][ T4335] ? __pfx_process_vm_rw_core+0x10/0x10
> [ 275.294350][ T4335] process_vm_rw (mm/process_vm_access.c:284)
> [ 275.294748][ T4335] ? __pfx_process_vm_rw (mm/process_vm_access.c:259)
> [ 275.295197][ T4335] ? __task_pid_nr_ns (include/linux/rcupdate.h:306 (discriminator 1) include/linux/rcupdate.h:780 (discriminator 1) kernel/pid.c:504 (discriminator 1))
> [ 275.295634][ T4335] __x64_sys_process_vm_readv (mm/process_vm_access.c:291)
> [ 275.296139][ T4335] ? syscall_enter_from_user_mode (kernel/entry/common.c:94 kernel/entry/common.c:112)
> [ 275.296642][ T4335] do_syscall_64 (arch/x86/entry/common.c:51 (discriminator 1) arch/x86/entry/common.c:82 (discriminator 1))
> [ 275.297032][ T4335] ? __task_pid_nr_ns (include/linux/rcupdate.h:306 (discriminator 1) include/linux/rcupdate.h:780 (discriminator 1) kernel/pid.c:504 (discriminator 1))
> [ 275.297470][ T4335] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4300 kernel/locking/lockdep.c:4359)
> [ 275.297988][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97)
> [ 275.298389][ T4335] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4300 kernel/locking/lockdep.c:4359)
> [ 275.298906][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97)
> [ 275.299304][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97)
> [ 275.299703][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97)
> [ 275.300115][ T4335] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
> 
> This BUG is the VM_BUG_ON(!in_atomic() && !irqs_disabled()) assertion in
> folio_ref_try_add_rcu() for non-SMP kernel.
> 
> The process_vm_readv() calls GUP to pin the THP. An optimization for
> pinning THP instroduced by commit 57edfcfd3419 ("mm/gup: accelerate thp
> gup even for "pages != NULL"") calls try_grab_folio() to pin the THP,
> but try_grab_folio() is supposed to be called in atomic context for
> non-SMP kernel, for example, irq disabled or preemption disabled, due to
> the optimization introduced by commit e286781d5f2e ("mm: speculative
> page references").
> 
> The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> boundaries") is not actually the root cause although it was bisected to.
> It just makes the problem exposed more likely.
> 
> The follow up discussion suggested the optimization for non-SMP kernel
> may be out-dated and not worth it anymore [1].  So removing the
> optimization to silence the BUG.
> 
> However calling try_grab_folio() in GUP slow path actually is
> unnecessary, so the following patch will clean this up.
> 
> [1] https://lore.kernel.org/linux-mm/821cf1d6-92b9-4ac4-bacc-d8f2364ac14f@paulmck-laptop/
> Fixes: 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages != NULL"")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Cc: linux-stable <stable@vger.kernel.org> v6.6+
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>

Just to mention, IMHO it'll still be nicer if we keep the 1st fix patch
only have the folio_ref_try_add_rcu() changes, it'll be easier for
backport.

Now this patch contains not only that but also logically a cleanup patch
that replaces old rcu calls to folio_try_get().  But squashing these may
mean we need explicit backport to 6.6 depending on whether those lines
changed, meanwhile the cleanup part may not be justfied to be backported in
the first place.  I'll leave that to you to decide, no strong feelings here.

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


