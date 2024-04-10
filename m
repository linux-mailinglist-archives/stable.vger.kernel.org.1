Return-Path: <stable+bounces-37950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A905889EF4D
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 11:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EDF82823AC
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 09:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952B2158A24;
	Wed, 10 Apr 2024 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKwNSh2h"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2C61552F7
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742976; cv=none; b=DaFPQp4zAHFPgN5JzaGSLgTX0YowcC2pQ8qSnH4gNd7/Aio82ISwOVoXrRBDxFv89+HlZ7osUV0DLV4vEJ2qZcYPByb3pDzmSh15Lov+fFIdlliubVqLgLiddpq1pwY6FYy1Os0a7yuGb9B+g444guzvlUOUIln+nt/1htM85so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742976; c=relaxed/simple;
	bh=SAZd41g6QWPVqTDLBlVsXu/KlhhuJJKchgF2mhanS2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLfvNbk2zfq8PCvAC7yuYgj1QlaqAS1tmaX4v+NzdeXmTp+M2gMDjOTUj549aKnUse9hlDm7w87M4hFqF12VD4r2ypF+rXL/HOUITf9ADZQGK/FRrTQGKRyclKvaB6RZ4b1FxAUKH2S3ylfR1dddN1bNt6MoxGB4ZDXR8cjZfqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKwNSh2h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712742973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9YxSsTEjT+bNm+rMMiZoKcCt/TGKob88xfeV4IKUVt0=;
	b=ZKwNSh2hyEUmDsV9kHUtx0QBEaLcLfKMXnY1jNdQJ9qF9VBYHQlu4sIc2UKM9xf9R5cMEV
	YEIjO76E5gzuOLBAiJIXqIFGwMsMkitg9dOj0YWQFcAkFeHKOSMBTPVSoRXhfVg5Eey9gi
	I/EhKH6LhwkkSeVdcScVxu4CEvayYCo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-f6HnqSLmPfyF3B_AHHAKFw-1; Wed, 10 Apr 2024 05:56:11 -0400
X-MC-Unique: f6HnqSLmPfyF3B_AHHAKFw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41401f598cfso37930945e9.2
        for <stable@vger.kernel.org>; Wed, 10 Apr 2024 02:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712742970; x=1713347770;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9YxSsTEjT+bNm+rMMiZoKcCt/TGKob88xfeV4IKUVt0=;
        b=Gw/2jnkpcELF/Qc8BwXjBkOtf0HdpNvmotYAXBL91oSC29zlfoVd3BfXxgaRiYWSrM
         7Bk94zv4vbcUJCrX4Ex0ioztTGxq1Z6py5NDbFPNHhTOSy4EdEM2lgMKtupkcEPZh9G9
         5GG5sApMNKbwE4okUf2TuBslC0qs+1olcUlmr+QefnQLnw4m/2E5QDmpNJ+IoSI82gaV
         KEM6Dd0QeHub4ZTFmpJEB1dBlyxUySAr0oWl0cyUhzq7mH2ugfsGqh8Q7xWOzG6/VR40
         cfa43CH+dKywd/2QXqRaMOpNcTL58bCqcfIYRD/OiJMsm8NYgrfxLFSmnXJ0T1R7ADXz
         18aw==
X-Gm-Message-State: AOJu0YxUjUdazBDYpe7hxXWRZM+0l/Q8Pr8kjW0rtiwbQn0SA2DeMMer
	Eb11c7iwQwABwp2h4Nd7kmJE8QQSnjDSn6Sdv/v0puHVBEcUPLRb0wTxsLEdFM5IyQnf625a6oQ
	HHAEIuKTPckxRRp5el4IM2Yiwvzmlj9wWcCuKiPY9y5wNuW6xL33GKeu56U1zBmw+CA0bM1e1Be
	UZyeXdYtt0itAwFj7FHYiiupr90Ins7/6eig==
X-Received: by 2002:a05:600c:4747:b0:415:6afa:4d8d with SMTP id w7-20020a05600c474700b004156afa4d8dmr1516237wmo.6.1712742970339;
        Wed, 10 Apr 2024 02:56:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFks/OToR3J/x3GweqnIDqj0xrZpde/PEHKSXlSnnKkzo5PCOalN1WsLbYlN125pifszWENgg==
X-Received: by 2002:a05:600c:4747:b0:415:6afa:4d8d with SMTP id w7-20020a05600c474700b004156afa4d8dmr1516201wmo.6.1712742969754;
        Wed, 10 Apr 2024 02:56:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c712:fa00:38eb:93ad:be38:d469? (p200300cbc712fa0038eb93adbe38d469.dip0.t-ipconnect.de. [2003:cb:c712:fa00:38eb:93ad:be38:d469])
        by smtp.gmail.com with ESMTPSA id m5-20020a5d56c5000000b00341ce80ea66sm13411739wrw.82.2024.04.10.02.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 02:56:09 -0700 (PDT)
Message-ID: <bb1cd221-055a-4638-8c36-42d6d1822192@redhat.com>
Date: Wed, 10 Apr 2024 11:56:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y] x86/mm/pat: fix VM_PAT handling in COW mappings
To: stable@vger.kernel.org
Cc: Wupeng Ma <mawupeng1@huawei.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>
References: <2024040850-wildly-gyration-12ff@gregkh>
 <20240410093429.162502-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240410093429.162502-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.04.24 11:34, David Hildenbrand wrote:
> PAT handling won't do the right thing in COW mappings: the first PTE (or,
> in fact, all PTEs) can be replaced during write faults to point at anon
> folios.  Reliably recovering the correct PFN and cachemode using
> follow_phys() from PTEs will not work in COW mappings.
> 
> Using follow_phys(), we might just get the address+protection of the anon
> folio (which is very wrong), or fail on swap/nonswap entries, failing
> follow_phys() and triggering a WARN_ON_ONCE() in untrack_pfn() and
> track_pfn_copy(), not properly calling free_pfn_range().
> 
> In free_pfn_range(), we either wouldn't call memtype_free() or would call
> it with the wrong range, possibly leaking memory.
> 
> To fix that, let's update follow_phys() to refuse returning anon folios,
> and fallback to using the stored PFN inside vma->vm_pgoff for COW mappings
> if we run into that.
> 
> We will now properly handle untrack_pfn() with COW mappings, where we
> don't need the cachemode.  We'll have to fail fork()->track_pfn_copy() if
> the first page was replaced by an anon folio, though: we'd have to store
> the cachemode in the VMA to make this work, likely growing the VMA size.
> 
> For now, lets keep it simple and let track_pfn_copy() just fail in that
> case: it would have failed in the past with swap/nonswap entries already,
> and it would have done the wrong thing with anon folios.
> 
> Simple reproducer to trigger the WARN_ON_ONCE() in untrack_pfn():
> 
> <--- C reproducer --->
>   #include <stdio.h>
>   #include <sys/mman.h>
>   #include <unistd.h>
>   #include <liburing.h>
> 
>   int main(void)
>   {
>           struct io_uring_params p = {};
>           int ring_fd;
>           size_t size;
>           char *map;
> 
>           ring_fd = io_uring_setup(1, &p);
>           if (ring_fd < 0) {
>                   perror("io_uring_setup");
>                   return 1;
>           }
>           size = p.sq_off.array + p.sq_entries * sizeof(unsigned);
> 
>           /* Map the submission queue ring MAP_PRIVATE */
>           map = mmap(0, size, PROT_READ | PROT_WRITE, MAP_PRIVATE,
>                      ring_fd, IORING_OFF_SQ_RING);
>           if (map == MAP_FAILED) {
>                   perror("mmap");
>                   return 1;
>           }
> 
>           /* We have at least one page. Let's COW it. */
>           *map = 0;
>           pause();
>           return 0;
>   }
> <--- C reproducer --->
> 
> On a system with 16 GiB RAM and swap configured:
>   # ./iouring &
>   # memhog 16G
>   # killall iouring
> [  301.552930] ------------[ cut here ]------------
> [  301.553285] WARNING: CPU: 7 PID: 1402 at arch/x86/mm/pat/memtype.c:1060 untrack_pfn+0xf4/0x100
> [  301.553989] Modules linked in: binfmt_misc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_g
> [  301.558232] CPU: 7 PID: 1402 Comm: iouring Not tainted 6.7.5-100.fc38.x86_64 #1
> [  301.558772] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebu4
> [  301.559569] RIP: 0010:untrack_pfn+0xf4/0x100
> [  301.559893] Code: 75 c4 eb cf 48 8b 43 10 8b a8 e8 00 00 00 3b 6b 28 74 b8 48 8b 7b 30 e8 ea 1a f7 000
> [  301.561189] RSP: 0018:ffffba2c0377fab8 EFLAGS: 00010282
> [  301.561590] RAX: 00000000ffffffea RBX: ffff9208c8ce9cc0 RCX: 000000010455e047
> [  301.562105] RDX: 07fffffff0eb1e0a RSI: 0000000000000000 RDI: ffff9208c391d200
> [  301.562628] RBP: 0000000000000000 R08: ffffba2c0377fab8 R09: 0000000000000000
> [  301.563145] R10: ffff9208d2292d50 R11: 0000000000000002 R12: 00007fea890e0000
> [  301.563669] R13: 0000000000000000 R14: ffffba2c0377fc08 R15: 0000000000000000
> [  301.564186] FS:  0000000000000000(0000) GS:ffff920c2fbc0000(0000) knlGS:0000000000000000
> [  301.564773] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  301.565197] CR2: 00007fea88ee8a20 CR3: 00000001033a8000 CR4: 0000000000750ef0
> [  301.565725] PKRU: 55555554
> [  301.565944] Call Trace:
> [  301.566148]  <TASK>
> [  301.566325]  ? untrack_pfn+0xf4/0x100
> [  301.566618]  ? __warn+0x81/0x130
> [  301.566876]  ? untrack_pfn+0xf4/0x100
> [  301.567163]  ? report_bug+0x171/0x1a0
> [  301.567466]  ? handle_bug+0x3c/0x80
> [  301.567743]  ? exc_invalid_op+0x17/0x70
> [  301.568038]  ? asm_exc_invalid_op+0x1a/0x20
> [  301.568363]  ? untrack_pfn+0xf4/0x100
> [  301.568660]  ? untrack_pfn+0x65/0x100
> [  301.568947]  unmap_single_vma+0xa6/0xe0
> [  301.569247]  unmap_vmas+0xb5/0x190
> [  301.569532]  exit_mmap+0xec/0x340
> [  301.569801]  __mmput+0x3e/0x130
> [  301.570051]  do_exit+0x305/0xaf0
> ...
> 
> Link: https://lkml.kernel.org/r/20240403212131.929421-3-david@redhat.com
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Reported-by: Wupeng Ma <mawupeng1@huawei.com>
> Closes: https://lkml.kernel.org/r/20240227122814.3781907-1-mawupeng1@huawei.com
> Fixes: b1a86e15dc03 ("x86, pat: remove the dependency on 'vm_pgoff' in track/untrack pfn vma routines")
> Fixes: 5899329b1910 ("x86: PAT: implement track/untrack of pfnmap regions for x86 - v3")
> Acked-by: Ingo Molnar <mingo@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 04c35ab3bdae7fefbd7c7a7355f29fa03a035221)
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Backport notes:
(1) vm_normal_folio -> vm_normal_page

-- 
Cheers,

David / dhildenb


