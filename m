Return-Path: <stable+bounces-48236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F628FD2AA
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 18:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F83286925
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 16:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F0819D89C;
	Wed,  5 Jun 2024 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fx6je+sb"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA6519D899
	for <stable@vger.kernel.org>; Wed,  5 Jun 2024 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604240; cv=none; b=EY+SSk1W0dF0dZxTG0Sg1W6iX8bVWObXU2GkaaIdSecoU3IP6AYOi/ktiZFyfib74F+3jGCDRqxM/ySR47/GKBbgt9onEBni1LnI9ShYvNUmtBaSoCHjVzwdgCffhWzMH1O9NKrKdzzpI+Er41cdcPn0Taj8A8iSnQPIpH82dWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604240; c=relaxed/simple;
	bh=XCKqjztYR9+IKBnfTAp3qkdWxzvX3tjFJRwRcXyy0wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nK1Pjk0l+UxlKweqTS6FAt96+PLJ58ePcmJgjLQwJtPFsLRVla4YEtOWT6ucvYU46Qmy5mSmfllG5eSa6M9zNNoxQpY6XdCpGD1Cj70khcRvpr99o53fTTxcJJtcofg+Gc38ssUqaUdpWLlgfQyu1dUWZ9W0Bk/YncV3t/tANFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fx6je+sb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717604237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cWV8Lo8WLzhgwKW8jLwqp32oyRHSZADB4Op3hCnu5O4=;
	b=Fx6je+sbBJ+tceMqE5qeGTeKRYW82duesKUZxYCXyBr9HWaRUG3Vr0vgCm5e+DtvLgyeCS
	Sj4lZUyMYUIzAZJl4JiN3gaufLnFnPZCQea8ZrRmOQkj2F+3UxUmvNEP2peXCLHaDld6Fr
	yHktmsVihHnJd+ZeSdMxAxGXMXk4x2E=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-OGYaXYVeODenLm39l-yVHA-1; Wed, 05 Jun 2024 12:17:15 -0400
X-MC-Unique: OGYaXYVeODenLm39l-yVHA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2eac337014cso15271631fa.3
        for <stable@vger.kernel.org>; Wed, 05 Jun 2024 09:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717604231; x=1718209031;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cWV8Lo8WLzhgwKW8jLwqp32oyRHSZADB4Op3hCnu5O4=;
        b=VFhzfHO2acMQ1KNT53OQc6nq2SzvXyMxwYEghTQb6MVDV7j/Q8htnwd7n2rFBLoAbP
         gTxFG83zjGlTPLBeQwdffuTB7K1XAfUPBohGexgVMJ+yW5IgZqU+3L+9hfpc8TCJC98A
         K+wzlLYQSZ65sIbHXC4GbTTw54ym4Na9fO+wVrKIjzkfacpuifnQhedtppOsvMRJqaMS
         fwAUa9Gj7KtO5idzbBCwHZ7aE0xTpklQwGPQTafyXhwCUFzFj1Xs2UkfXICPn9UdrfZI
         eB9jhCiDI7IRhaP1H5XbaGvRwRmAyFkcXQUwdUxNV3c/OWrBtFzce/jLX49Auwsua9n2
         QsaA==
X-Forwarded-Encrypted: i=1; AJvYcCWdMokhd9Pg+sljOrik5uZO6kPY/c0VTRRxFxwm09mPgXTT831jxHiHA1tLCL0O5xuKYKIebVlpi4c9O8sc2limk8pMg1t3
X-Gm-Message-State: AOJu0YzkdA1UyTavZ5IKjultSQsuVwiiPgy2NvtV/3q5WupwZ4mx/J9J
	0RjalAcUTM1lAP1+hK7A4wtfLA3mMitOj5lEt+kptwEVjVkRkCi5pfaUR0L+nRDj5Ng+CQZ6sCZ
	9aJX9E+gX5ybTMmP4X457+I1OvvEgUXAkX1j1vlqBiYhHwNq4kQd3Hw==
X-Received: by 2002:a2e:9015:0:b0:2e2:a85f:f222 with SMTP id 38308e7fff4ca-2eac79bffd6mr21905161fa.10.1717604231457;
        Wed, 05 Jun 2024 09:17:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1/ptFn9F2AicH1L8mC8tPW6vXI9kcDGJgMU0weURGF8brg/KfPg9v0PpQcR+jiOzihyazkg==
X-Received: by 2002:a2e:9015:0:b0:2e2:a85f:f222 with SMTP id 38308e7fff4ca-2eac79bffd6mr21904871fa.10.1717604230954;
        Wed, 05 Jun 2024 09:17:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:3100:19a8:d898:8e69:6aff? (p200300cbc706310019a8d8988e696aff.dip0.t-ipconnect.de. [2003:cb:c706:3100:19a8:d898:8e69:6aff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158148f91sm28767755e9.30.2024.06.05.09.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 09:17:10 -0700 (PDT)
Message-ID: <6089ccc4-1fb7-4934-b119-253aa246a2dd@redhat.com>
Date: Wed, 5 Jun 2024 18:17:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: page_ref: remove folio_try_get_rcu()
To: Yang Shi <yang@os.amperecomputing.com>, Peter Xu <peterx@redhat.com>
Cc: oliver.sang@intel.com, paulmck@kernel.org, willy@infradead.org,
 riel@surriel.com, vivek.kasireddy@intel.com, cl@linux.com,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240604234858.948986-1-yang@os.amperecomputing.com>
 <ZmCDU5PMBqE-H-om@x1n>
 <58f249cf-c2a9-429b-871d-15584ed37956@os.amperecomputing.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <58f249cf-c2a9-429b-871d-15584ed37956@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.06.24 18:16, Yang Shi wrote:
> 
> 
> On 6/5/24 8:25 AM, Peter Xu wrote:
>> On Tue, Jun 04, 2024 at 04:48:57PM -0700, Yang Shi wrote:
>>> The below bug was reported on a non-SMP kernel:
>>>
>>> [  275.267158][ T4335] ------------[ cut here ]------------
>>> [  275.267949][ T4335] kernel BUG at include/linux/page_ref.h:275!
>>> [  275.268526][ T4335] invalid opcode: 0000 [#1] KASAN PTI
>>> [  275.269001][ T4335] CPU: 0 PID: 4335 Comm: trinity-c3 Not tainted 6.7.0-rc4-00061-gefa7df3e3bb5 #1
>>> [  275.269787][ T4335] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>>> [  275.270679][ T4335] RIP: 0010:try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
>>> [  275.272813][ T4335] RSP: 0018:ffffc90005dcf650 EFLAGS: 00010202
>>> [  275.273346][ T4335] RAX: 0000000000000246 RBX: ffffea00066e0000 RCX: 0000000000000000
>>> [  275.274032][ T4335] RDX: fffff94000cdc007 RSI: 0000000000000004 RDI: ffffea00066e0034
>>> [  275.274719][ T4335] RBP: ffffea00066e0000 R08: 0000000000000000 R09: fffff94000cdc006
>>> [  275.275404][ T4335] R10: ffffea00066e0037 R11: 0000000000000000 R12: 0000000000000136
>>> [  275.276106][ T4335] R13: ffffea00066e0034 R14: dffffc0000000000 R15: ffffea00066e0008
>>> [  275.276790][ T4335] FS:  00007fa2f9b61740(0000) GS:ffffffff89d0d000(0000) knlGS:0000000000000000
>>> [  275.277570][ T4335] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  275.278143][ T4335] CR2: 00007fa2f6c00000 CR3: 0000000134b04000 CR4: 00000000000406f0
>>> [  275.278833][ T4335] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> [  275.279521][ T4335] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> [  275.280201][ T4335] Call Trace:
>>> [  275.280499][ T4335]  <TASK>
>>> [ 275.280751][ T4335] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447)
>>> [ 275.281087][ T4335] ? do_trap (arch/x86/kernel/traps.c:112 arch/x86/kernel/traps.c:153)
>>> [ 275.281463][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
>>> [ 275.281884][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
>>> [ 275.282300][ T4335] ? do_error_trap (arch/x86/kernel/traps.c:174)
>>> [ 275.282711][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
>>> [ 275.283129][ T4335] ? handle_invalid_op (arch/x86/kernel/traps.c:212)
>>> [ 275.283561][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
>>> [ 275.283990][ T4335] ? exc_invalid_op (arch/x86/kernel/traps.c:264)
>>> [ 275.284415][ T4335] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568)
>>> [ 275.284859][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
>>> [ 275.285278][ T4335] try_grab_folio (mm/gup.c:148)
>>> [ 275.285684][ T4335] __get_user_pages (mm/gup.c:1297 (discriminator 1))
>>> [ 275.286111][ T4335] ? __pfx___get_user_pages (mm/gup.c:1188)
>>> [ 275.286579][ T4335] ? __pfx_validate_chain (kernel/locking/lockdep.c:3825)
>>> [ 275.287034][ T4335] ? mark_lock (kernel/locking/lockdep.c:4656 (discriminator 1))
>>> [ 275.287416][ T4335] __gup_longterm_locked (mm/gup.c:1509 mm/gup.c:2209)
>>> [ 275.288192][ T4335] ? __pfx___gup_longterm_locked (mm/gup.c:2204)
>>> [ 275.288697][ T4335] ? __pfx_lock_acquire (kernel/locking/lockdep.c:5722)
>>> [ 275.289135][ T4335] ? __pfx___might_resched (kernel/sched/core.c:10106)
>>> [ 275.289595][ T4335] pin_user_pages_remote (mm/gup.c:3350)
>>> [ 275.290041][ T4335] ? __pfx_pin_user_pages_remote (mm/gup.c:3350)
>>> [ 275.290545][ T4335] ? find_held_lock (kernel/locking/lockdep.c:5244 (discriminator 1))
>>> [ 275.290961][ T4335] ? mm_access (kernel/fork.c:1573)
>>> [ 275.291353][ T4335] process_vm_rw_single_vec+0x142/0x360
>>> [ 275.291900][ T4335] ? __pfx_process_vm_rw_single_vec+0x10/0x10
>>> [ 275.292471][ T4335] ? mm_access (kernel/fork.c:1573)
>>> [ 275.292859][ T4335] process_vm_rw_core+0x272/0x4e0
>>> [ 275.293384][ T4335] ? hlock_class (arch/x86/include/asm/bitops.h:227 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228)
>>> [ 275.293780][ T4335] ? __pfx_process_vm_rw_core+0x10/0x10
>>> [ 275.294350][ T4335] process_vm_rw (mm/process_vm_access.c:284)
>>> [ 275.294748][ T4335] ? __pfx_process_vm_rw (mm/process_vm_access.c:259)
>>> [ 275.295197][ T4335] ? __task_pid_nr_ns (include/linux/rcupdate.h:306 (discriminator 1) include/linux/rcupdate.h:780 (discriminator 1) kernel/pid.c:504 (discriminator 1))
>>> [ 275.295634][ T4335] __x64_sys_process_vm_readv (mm/process_vm_access.c:291)
>>> [ 275.296139][ T4335] ? syscall_enter_from_user_mode (kernel/entry/common.c:94 kernel/entry/common.c:112)
>>> [ 275.296642][ T4335] do_syscall_64 (arch/x86/entry/common.c:51 (discriminator 1) arch/x86/entry/common.c:82 (discriminator 1))
>>> [ 275.297032][ T4335] ? __task_pid_nr_ns (include/linux/rcupdate.h:306 (discriminator 1) include/linux/rcupdate.h:780 (discriminator 1) kernel/pid.c:504 (discriminator 1))
>>> [ 275.297470][ T4335] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4300 kernel/locking/lockdep.c:4359)
>>> [ 275.297988][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97)
>>> [ 275.298389][ T4335] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4300 kernel/locking/lockdep.c:4359)
>>> [ 275.298906][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97)
>>> [ 275.299304][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97)
>>> [ 275.299703][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97)
>>> [ 275.300115][ T4335] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
>>>
>>> This BUG is the VM_BUG_ON(!in_atomic() && !irqs_disabled()) assertion in
>>> folio_ref_try_add_rcu() for non-SMP kernel.
>>>
>>> The process_vm_readv() calls GUP to pin the THP. An optimization for
>>> pinning THP instroduced by commit 57edfcfd3419 ("mm/gup: accelerate thp
>>> gup even for "pages != NULL"") calls try_grab_folio() to pin the THP,
>>> but try_grab_folio() is supposed to be called in atomic context for
>>> non-SMP kernel, for example, irq disabled or preemption disabled, due to
>>> the optimization introduced by commit e286781d5f2e ("mm: speculative
>>> page references").
>>>
>>> The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
>>> boundaries") is not actually the root cause although it was bisected to.
>>> It just makes the problem exposed more likely.
>>>
>>> The follow up discussion suggested the optimization for non-SMP kernel
>>> may be out-dated and not worth it anymore [1].  So removing the
>>> optimization to silence the BUG.
>>>
>>> However calling try_grab_folio() in GUP slow path actually is
>>> unnecessary, so the following patch will clean this up.
>>>
>>> [1] https://lore.kernel.org/linux-mm/821cf1d6-92b9-4ac4-bacc-d8f2364ac14f@paulmck-laptop/
>>> Fixes: 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages != NULL"")
>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>> Cc: linux-stable <stable@vger.kernel.org> v6.6+
>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> Just to mention, IMHO it'll still be nicer if we keep the 1st fix patch
>> only have the folio_ref_try_add_rcu() changes, it'll be easier for
>> backport.
>>
>> Now this patch contains not only that but also logically a cleanup patch
>> that replaces old rcu calls to folio_try_get().  But squashing these may
>> mean we need explicit backport to 6.6 depending on whether those lines
>> changed, meanwhile the cleanup part may not be justfied to be backported in
>> the first place.  I'll leave that to you to decide, no strong feelings here.
> 
> Neither do I. But I slightly prefer have the patch as is for mainline
> since removing the #ifdef and the clean up lead by it seems
> self-contained and naturally integral. If it can not be applied to
> stable tree without conflict, I can generate a separate patch for stable
> tree with the removing #ifdef part. The effort should be trivial.

Agreed

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


