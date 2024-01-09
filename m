Return-Path: <stable+bounces-10394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8074D8289F4
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 17:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C842868D2
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 16:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3CF3A1D7;
	Tue,  9 Jan 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yzzA21IB"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3180A3A1C2
	for <stable@vger.kernel.org>; Tue,  9 Jan 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbce2a8d700so3286306276.1
        for <stable@vger.kernel.org>; Tue, 09 Jan 2024 08:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704817688; x=1705422488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X5OuBSK2ue8Kgm1k8HYnk3iBNLImCMNlra+LgIioncU=;
        b=yzzA21IByFPLyQzVXsFpW/hisjZetZ4FJaOWOSFOwPJQCToW9XcidnmPI5Bb5wEOaS
         3G9cjVUoTTI1ZZYqteaVG2jj9X4HTpHJPj+t4e0LCNnvSX6xGf71ceQQ4oWrwB7OcbMc
         qpxPSt+bGMpLjEB8/7ztdrh2iGtex1wtETo1BvvYczEOWLJb/rVktZfaC1LgKyiTKLYl
         2aPah1P3Eh07H0NbBi30i7rrPzMZ1QZ4tp9E8fjXv5dgWkD/r0+3axOXFoB+64e67wzW
         bGI31Tr7gdQ0nLJ/yVtNo6I3YvHEP8omg4kTlxMOWVZkIqrJ9Z4fd6UK2w9KWEJjxeGq
         RLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704817688; x=1705422488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X5OuBSK2ue8Kgm1k8HYnk3iBNLImCMNlra+LgIioncU=;
        b=oib6AVziFQ1mWNAohb9i9gCyJDfEAW7Y+ZEZcg5ICcBTeZvNrIZdTl3J1SgWCcZu37
         qSX/I6f9SrKQcOmtj3OQoRjQMi1eOXtmqZch83TDSdRHJ0qeiG0H15e+duR2p9Wy9np4
         riyUXBN9HGXDRgZWijh87Mu04ODCkQaiLePSW26oekHoOCxp/trtPhjXHjrQh6cDvYmK
         00VwDf2FPEvYXwmM4aVuZ5U1joA+WTUq+8t7o6y8hRQDXaFXSuBjcHwZNgCmq0vEH7uY
         ayFmGAZ5hkpF5DRon8UiKHTAJ88ufp/8pdU09S+YRo0xT52tiBTnquRYR8Rr0TQKQLgM
         Vovw==
X-Gm-Message-State: AOJu0YzvVk/f/whURrZWFfENU8xWzwJtLeeGD5HB6LU403GMf5jBccHI
	hEhBVE++Ycm/cbKJkm/KUrp9Cba10LrkSbCi3Q==
X-Google-Smtp-Source: AGHT+IFSDvWVPac68q4BzCp/M7oq0Dprmnoi25LHdAWG2rkmmNus3vqOs8OrjdJwg44iO8Kai9BqtK53kUw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:8186:0:b0:dbc:1b48:dc1e with SMTP id
 p6-20020a258186000000b00dbc1b48dc1emr211467ybk.2.1704817688232; Tue, 09 Jan
 2024 08:28:08 -0800 (PST)
Date: Tue, 9 Jan 2024 08:28:06 -0800
In-Reply-To: <20240109112445.590736-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240109112445.590736-1-usama.anjum@collabora.com>
Message-ID: <ZZ10FqvnVWIbyo-9@google.com>
Subject: Re: [PATCH] fs/proc/task_mmu: move mmu notification mechanism inside
 mm lock
From: Sean Christopherson <seanjc@google.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Andrei Vagin <avagin@google.com>, Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	"=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?=" <mirq-linux@rere.qmqm.pl>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Arnd Bergmann <arnd@arndb.de>, kernel@collabora.com, 
	syzbot+81227d2bd69e9dedb802@syzkaller.appspotmail.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jan 09, 2024, Muhammad Usama Anjum wrote:
> Move mmu notification mechanism inside mm lock to prevent race condition
> in other components which depend on it. The notifier will invalidate
> memory range. Depending upon the number of iterations, different memory
> ranges would be invalidated.
> 
> The following warning would be removed by this patch:
> WARNING: CPU: 0 PID: 5067 at arch/x86/kvm/../../../virt/kvm/kvm_main.c:734 kvm_mmu_notifier_change_pte+0x860/0x960 arch/x86/kvm/../../../virt/kvm/kvm_main.c:734
> 
> There is no behavioural and performance change with this patch when
> there is no component registered with the mmu notifier.
> 
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Reported-by: syzbot+81227d2bd69e9dedb802@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/000000000000f6d051060c6785bc@google.com/
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  fs/proc/task_mmu.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 62b16f42d5d2..56c2e7357494 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2448,13 +2448,6 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
>  	if (ret)
>  		return ret;
>  
> -	/* Protection change for the range is going to happen. */
> -	if (p.arg.flags & PM_SCAN_WP_MATCHING) {
> -		mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
> -					mm, p.arg.start, p.arg.end);
> -		mmu_notifier_invalidate_range_start(&range);
> -	}
> -
>  	for (walk_start = p.arg.start; walk_start < p.arg.end;
>  			walk_start = p.arg.walk_end) {
>  		long n_out;

Nit, might be worth moving

		struct mmu_notifier_range range;

inside the loop to guard against stale usage, but that's definitely optional.

Reviewed-by: Sean Christopherson <seanjc@google.com>

