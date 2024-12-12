Return-Path: <stable+bounces-103946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AB49EFF3D
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 23:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A5B2822E1
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 22:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFA81DE2BB;
	Thu, 12 Dec 2024 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SsF6rDsm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC371DDC14
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 22:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042344; cv=none; b=fVeLVF7hnTgExtETl7yZtn3Bg/I/cbkKxz30/V7b98YMqzZYC0VQroYZ22mpoTIMQsIt+lxjeo5BdnwPOEmVDfqynkL4qhXYaT+MbeK1LLrsyV8/JWB+SVFPxe/V80Y47SFhw09GiKmgTt2azSLe6YmODRQMso5y47qMhcNFc6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042344; c=relaxed/simple;
	bh=b/3CRAdu+7T5QJ4e6en1KgG9dbEf1XStUpVNzdnyvog=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ArlrXCpbFCokhWEjVycytPaCvnC/2VOxmxmS7AQwv1Qhw/liiWb2fq9vBtDMpB4zDI/QSTpA89wchs6fi1F4NNsPbYU2WxZDOsb9Sg39Dxou79BJTu/G0rbfi78J+Ox3KTSJj/83zuXQUUK7BS1BUKT8xpPwAYfuuYIM/t/9LZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SsF6rDsm; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-728e4e30163so872424b3a.1
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 14:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734042342; x=1734647142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeVEYyAeRFWzZUfEKgzMQxC3tRUbE6NlpO6Eh07fKpo=;
        b=SsF6rDsmdBTlDdVAoozOF36NToBrSeOtneghfO+3+at6SD9LQoXpquYGIeEh4NXkIM
         7RxtXF+apf+/7GowtAN/W77X0GtxEqvXfawVKfZDq8Ols8dr4Q4xYD7cmnoldX1yb8s9
         7m9yfIdhRwKcAITxQerx4BN5PrERKPPSTBag5D8HBFJg9NDeC1NvHIWkAEOftLY+meDF
         ReyPAwddquSxzoqnLAYWKlflv00b2UZV8Z6YUXiK4zmshKC3TVMI3+mCLpHKlg6+ikGa
         2QQtuZDZPK49cSlh3TPTMQu0sPkVf9+NagHP/bznPzd/8oaJ1Dy0e+gfC3UvaaIDeBe9
         tJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734042342; x=1734647142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeVEYyAeRFWzZUfEKgzMQxC3tRUbE6NlpO6Eh07fKpo=;
        b=lVGC46wGbx3Gfvl71E3jetO14vx18fTZNrIp06GD3Ynhut4/PQ4ATZcfr1vr46LYog
         lHzuBY/94dQDxXPyxIO/6Oo3ntCoaygkqgeqMvqWr1/A9B7uQJWD+FDdY5clGplaPcHE
         JWPkT2Dzf2giNECC7RHjkqHm21P3fBiAvujC0dSGiK4CKWVD1WsHgJl6EBePld0GPsVn
         dT0I+2CNba/bDJbgJ3dBfjM6w/kRPbA4WyDYOCQiTlZIuUh6PM2vZellS3ZboaDe2Iyn
         yyhivyAevpGosp5D455NVbnZpTRlOlit5Ke+XOLDzpUZNzxFT7foKVKmMr0cJSf6bXx3
         xq4Q==
X-Gm-Message-State: AOJu0Yx47lzPp+gJCV2RBuAANnyrAkU39OOn/hgPoTMgWKtsOYCo0n8o
	t9NccmS+EyxjFxzOJRIzVrWW+LCroVnah2pYAvt+t1BJNrBxvBx9qAz+t4adnqrw90dgRiK+D0Z
	y1g==
X-Google-Smtp-Source: AGHT+IGeog0JTNRLA0KDM2T3PGKhKDD4c0F8DMDQlKvrmOtVMEuF6PyrIFHqMD/w4E0ENaVhrbHRstdPXF4=
X-Received: from pfiu11.prod.google.com ([2002:a05:6a00:124b:b0:727:3a40:52d7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1893:b0:725:f1b1:cb9f
 with SMTP id d2e1a72fcca58-7290c25d946mr382070b3a.20.1734042341886; Thu, 12
 Dec 2024 14:25:41 -0800 (PST)
Date: Thu, 12 Dec 2024 14:25:40 -0800
In-Reply-To: <20241208083743.77295-1-kniv@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241208083743.77295-1-kniv@yandex-team.ru>
Message-ID: <Z1ti5K6hs6-sWIG_@google.com>
Subject: Re: [PATCH v2 6.1] KVM: x86/mmu: Ensure that kvm_release_pfn_clean()
 takes exact pfn from kvm_faultin_pfn()
From: Sean Christopherson <seanjc@google.com>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"

On Sun, Dec 08, 2024, Nikolay Kuratov wrote:
> Since 5.16 and prior to 6.13 KVM can't be used with FSDAX
> guest memory (PMD pages). To reproduce the issue you need to reserve
> guest memory with `memmap=` cmdline, create and mount FS in DAX mode
> (tested both XFS and ext4), see doc link below. ndctl command for test:
> ndctl create-namespace -v -e namespace1.0 --map=dev --mode=fsdax -a 2M
> Then pass memory object to qemu like:
> -m 8G -object memory-backend-file,id=ram0,size=8G,\
> mem-path=/mnt/pmem/guestmem,share=on,prealloc=on,dump=off,align=2097152 \
> -numa node,memdev=ram0,cpus=0-1
> QEMU fails to run guest with error: kvm run failed Bad address
> and there are two warnings in dmesg:
> WARN_ON_ONCE(!page_count(page)) in kvm_is_zone_device_page() and
> WARN_ON_ONCE(folio_ref_count(folio) <= 0) in try_grab_folio() (v6.6.63)
> 
> It looks like in the past assumption was made that pfn won't change from
> faultin_pfn() to release_pfn_clean(), e.g. see
> commit 4cd071d13c5c ("KVM: x86/mmu: Move calls to thp_adjust() down a level")
> But kvm_page_fault structure made pfn part of mutable state, so
> now release_pfn_clean() can take hugepage-adjusted pfn.
> And it works for all cases (/dev/shm, hugetlb, devdax) except fsdax.
> Apparently in fsdax mode faultin-pfn and adjusted-pfn may refer to
> different folios, so we're getting get_page/put_page imbalance.
> 
> To solve this preserve faultin pfn in separate local variable
> and pass it in kvm_release_pfn_clean().
> 
> Patch tested for all mentioned guest memory backends with tdp_mmu={0,1}.
> 
> No bug in upstream as it was solved fundamentally by
> commit 8dd861cc07e2 ("KVM: x86/mmu: Put refcounted pages instead of blindly releasing pfns")
> and related patch series.
> 
> Link: https://nvdimm.docs.kernel.org/2mib_fs_dax.html
> Fixes: 2f6305dd5676 ("KVM: MMU: change kvm_tdp_mmu_map() arguments to kvm_page_fault")
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Sean Christopherson <seanjc@google.com>

First off, thank you very much for the fixes+backports, and testing!

However, in the future, please don't record a Reviewed-by or Acked-tag unless it
is explicitly given, especially for backports to LTS kernels.  I know it's weird
and pedantic in this case since I provided the code, but it's still important to
give maintainers the opportunity to review exactly what will be applied.

Anyways, all the patches look good and Greg has grabbed them, so there's nothing
more to be done.

Thanks again!

