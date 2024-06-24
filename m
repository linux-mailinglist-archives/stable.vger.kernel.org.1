Return-Path: <stable+bounces-55046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AC19151B7
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 17:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D5D1C203BC
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC77419D88C;
	Mon, 24 Jun 2024 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PouyQVtX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7451E869
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241973; cv=none; b=CBnTE3MeMUtC1lUrYUGZct8pCltS+EniqmtWjRzGCzB5KzEG3tHIPFOnQEs9W9CbKg++f1/BZPMNKjrTqyHcQzDG7ZgCBbfJqFtcShD/HoKRVdHFaitidcY2OAlE9FFqRhFreySNAsqWeHgYTazsBx5SQssfNmkj9a5uTZi6k9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241973; c=relaxed/simple;
	bh=0F4rJSX/cYkQfHmDxDjysvB+2OgLg9F/qO8znE8nL0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P9tzSpOoQSQxMZFdvzI3kKu4oYEKlgqZmC1hdhv+Y2ZjluumF7hbc8OX6tA6NPoUYwyuO0dCLbZdpwHEy11q+ZXQDLNaR90E6bz6L1BvwoEtedgJkwhXUrNCYWSJXTsEeoolEQIf4tDY41GZ/a/b2aF/bgb7JQDEgZNwfNOKT4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PouyQVtX; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6c559235c6eso5684509a12.2
        for <stable@vger.kernel.org>; Mon, 24 Jun 2024 08:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719241971; x=1719846771; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O6zthYTCd6vmd4tACAt+MFQ0y4zDf3/Z9l8J20ygzDM=;
        b=PouyQVtXrQdQqveEXZP1vlV4U7gUXVVPkmcdG2wWVtBmfi83Bs48idC9SBvmERZiBn
         U4YhH6dOe6mzVpN9zlUZEGfB4eFF84x60szrcnpMpiNI3xPBvwScSUlNud7t96M07bKv
         ESum+01i9MgqV+nHsclXUEegStfaD+VG3ONeoM6CqArRuYq1rvLdpha6hspFBNBBkzLH
         tdojpkBVjpR0NhyO3twrEmyNGsJVJ6GyB/nyn7LZsAdtyyCSWCv0DlmH7M2c8a6Sc2K/
         v21/0OlDDaqIa61YVT0FpkJS8NUYvmOmHA4wnzAw0eI1SoBllIWxZNx7iUN6za6D5OIh
         FoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719241971; x=1719846771;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6zthYTCd6vmd4tACAt+MFQ0y4zDf3/Z9l8J20ygzDM=;
        b=RU7K5k1ZT1kNd6Gc77pLp4vZn7MSKpYD0XRoI5ebEHYKGGnY54rlkFGSq0tXiSoP7u
         DbJaNJmjxADaU0HjT96CW1WFa7Klub6GPuQjbOiR7gIV2CsHWWd+3eWZvrAg9BrF5ZrU
         0btgmZ8YW1deQmbRyLvMvqgDDqFYTYzIAibLg0BVkvD4szAFvRsuIY+zQu6lUDW6nHPy
         e6s7Vj0yALHjihTnZGdVVtHVxfSz5BqrRwXpLt/23KxWuZWt6x7aZk+4nAq7hiZh6H6R
         nSBeJu5yhJObvvOiiaB2tlJj2estneLUM4FgoSvShnBdNheYizlNsnXLKm7bRHmbMhke
         83FA==
X-Gm-Message-State: AOJu0YzPK3wSvnpcwqP7m9C1GIa8+krB4mUQG2YFFiiMuFsTNHN87TIx
	GoJ8zConzDjpmUD5csbWiKZdUVjDqtrUGPr+9IfaWx3MKEbOzTRkkbZPl3zdeT3iyrdkeaHFNPj
	LdoapHF8R4oZzZkKgmwjLw2EbnVdZm2sT7My0qnB/tZHs0brADIEfljArddeGVzzbabTCUPobZh
	FQLg9thKdYVbDGxQKX3G3Ew6+f/wDM6A+Q
X-Google-Smtp-Source: AGHT+IGq99ub0na888Ya9SQlrwOojsXXmLaRbY4ryUoszPO4pKtx9wmffV3SllW4R30aAM9N4j5PhF4efM0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:4a8:b0:719:3df6:fb39 with SMTP id
 41be03b00d2f7-71b607de757mr18200a12.10.1719241971130; Mon, 24 Jun 2024
 08:12:51 -0700 (PDT)
Date: Mon, 24 Jun 2024 15:12:49 +0000
In-Reply-To: <20240624135153.937666-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624135153.937666-1-sashal@kernel.org>
Message-ID: <ZnmM8SCNDe5Hbmcq@google.com>
Subject: Re: Patch "KVM: Use gfn instead of hva for mmu_notifier_retry" has
 been added to the 6.6-stable tree
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, chao.p.peng@linux.intel.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 24, 2024, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     KVM: Use gfn instead of hva for mmu_notifier_retry
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      kvm-use-gfn-instead-of-hva-for-mmu_notifier_retry.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 68a14ccc3fb35047cc4900c8ddd4b6f959e25b77
> Author: Chao Peng <chao.p.peng@linux.intel.com>
> Date:   Fri Oct 27 11:21:45 2023 -0700
> 
>     KVM: Use gfn instead of hva for mmu_notifier_retry
>     
>     [ Upstream commit 8569992d64b8f750e34b7858eac5d7daaf0f80fd ]
>     
>     Currently in mmu_notifier invalidate path, hva range is recorded and then
>     checked against by mmu_invalidate_retry_hva() in the page fault handling
>     path. However, for the soon-to-be-introduced private memory, a page fault
>     may not have a hva associated, checking gfn(gpa) makes more sense.
>     
>     For existing hva based shared memory, gfn is expected to also work. The
>     only downside is when aliasing multiple gfns to a single hva, the
>     current algorithm of checking multiple ranges could result in a much
>     larger range being rejected. Such aliasing should be uncommon, so the
>     impact is expected small.
>     
>     Suggested-by: Sean Christopherson <seanjc@google.com>
>     Cc: Xu Yilun <yilun.xu@intel.com>
>     Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
>     Reviewed-by: Fuad Tabba <tabba@google.com>
>     Tested-by: Fuad Tabba <tabba@google.com>
>     [sean: convert vmx_set_apic_access_page_addr() to gfn-based API]
>     Signed-off-by: Sean Christopherson <seanjc@google.com>
>     Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>     Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
>     Message-Id: <20231027182217.3615211-4-seanjc@google.com>
>     Reviewed-by: Kai Huang <kai.huang@intel.com>
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>     Stable-dep-of: c3f3edf73a8f ("KVM: Stop processing *all* memslots when "null" mmu_notifier handler is found")

Please drop this, and all other related patches.  This is not at all appropriate
for stable trees.

I'm pretty sure your scripts are borked too, at least from KVM's perspective.  I
specifically didn't tag c3f3edf73a8f for stable[*], and I thought we had agreed a
while back that only KVM (x86?) fixes with an explicit "Cc: stable@" would be
automatically included.

[*] https://lore.kernel.org/all/20240620230937.2214992-1-seanjc@google.com

