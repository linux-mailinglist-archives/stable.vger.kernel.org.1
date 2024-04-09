Return-Path: <stable+bounces-37912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC64089E5F6
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 01:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B751F24C20
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 23:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4F9158DA8;
	Tue,  9 Apr 2024 23:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aH515+/N"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A94A157476
	for <stable@vger.kernel.org>; Tue,  9 Apr 2024 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712704410; cv=none; b=An7j6ue5rheCj1fVlTgqp/btLvuh8WbajE+jcci13CmuFbvx9FXUrtU0KxDXgLNHZKhRhmTxhDOGt/RkQ9qtGC+gftzkjboyFmF5OxyrPDQqDtEzEddd3du1chyRUBDge3gSQAocBKEgc7fjqVENcdw/pDLqnBZ5S1wLYJoJ054=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712704410; c=relaxed/simple;
	bh=s1N+bWXW6ZgDbBF9S3ovbL3RYc98tH9Fns3Yc4Yvy50=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bul+c+Qg34e9ZWWV4kke/8IT/3gvXl5HrYxyolQ96PVNdgQ5q700qRPwFV4704D3rxR9FqnVjp1XUTPwHAyONvOThHZ5PcLr2uvRAsLbhImk027MsCyFJnvz6GYtbVBuc/PW9OAIfR6RnELoyORviZgmNyjrCMMrs6QFsMpyfTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aH515+/N; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a2c2b0d82aso5561955a91.3
        for <stable@vger.kernel.org>; Tue, 09 Apr 2024 16:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712704408; x=1713309208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kCjGvnjNmjYFW9A5jxHrUrxUVDFK2iV2f/iEuUaPJKU=;
        b=aH515+/NToaD+ywUFw6OTZwXmM6Q9VuUWMuG24UpaJZicOlvCzCdkO5yDDQkqRFvBC
         qtRTV+7RLLaWWenTV8Fk1tteD2/k+9txaeAKuKbJBy1XXBbSYsnxWL6xYtHZWTc+zkBq
         88GHAkVrA0Z+bvgHfw1DvG66Ijek6yNt/X0RRvFpuzgXd6KaPhqKA3QIepa4ZVqFI/UT
         W+YYTafqTKNucq/wAAnf6TqBZI+nu74oRH4kKsyOCser9VQzM2kZt8g8UjC0Kms1CQuk
         FXHAUwtzdVoWNW27+HnbEE6OP/tFtD8aUd0hReC4ooSPnQ24NwPXiZDs4lmDiz/ZsqKi
         AM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712704408; x=1713309208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kCjGvnjNmjYFW9A5jxHrUrxUVDFK2iV2f/iEuUaPJKU=;
        b=KiB7TVUZwPXk/UOdWCAXBGObXAN1jMzlGlSieaW9klOyHH0y2K5BBLHVRFJy7hXJoD
         mviPdjUaI9+/ro4WD8Y74gyXzlYyYNEuLKgdoXTch98qzPFOokPrahLJRZMUJo4zZpt0
         b+1wyufdXNlAPjslW13AYhlcC3x2vdqYOcjanVCKKBNQ34tKWTIJD5qW7Seb1Fl5St/7
         dovJSrvrABSVt8kjmP4QeFiKMxvS6A6WlFK2SJZoc9BUeEEaf9AKZ3Oe6LzJoMaol3Yw
         Q/d/iDwQKffz6ahIdWcflYsxWgHQaz+dKe5b9i0wJJ1FT70/f5iQN1EKNbndS9P/RKHQ
         bHxg==
X-Forwarded-Encrypted: i=1; AJvYcCUsvIjSQGY/IGA/3cc3skYA+e77gM7sd8wyZ6kqkqsnJpC3GFip/o1KQ28S6J6SkY6DVn2IdFHTSeJt5bQfGjDfov7jYNqo
X-Gm-Message-State: AOJu0YxuTFohpvEBc4iAGesSqMJvFvOW3gmGeBtn/5SHuoBLjRN0qr5+
	DUFQb0e3kVGF5PxrwecstcFykIVcldMVx7aKK+ZhdFuTJHI2OZvHzF9uMPP+ptgU2bcsXMERm3a
	1vA==
X-Google-Smtp-Source: AGHT+IGG3CX1kWWtUnLU0fYOieXTOoNviwHGWTY5hE+HKqVKD8ecUbGOjd5lbsCMNRwnm6c+0GiqgGAd+SA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e888:b0:1e0:afa0:cc94 with SMTP id
 w8-20020a170902e88800b001e0afa0cc94mr65257plg.7.1712704408440; Tue, 09 Apr
 2024 16:13:28 -0700 (PDT)
Date: Tue, 9 Apr 2024 16:13:27 -0700
In-Reply-To: <20240315230541.1635322-2-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240315230541.1635322-1-dmatlack@google.com> <20240315230541.1635322-2-dmatlack@google.com>
Message-ID: <ZhXLl358YY0WPOWL@google.com>
Subject: Re: [PATCH 1/4] KVM: x86/mmu: Check kvm_mmu_page_ad_need_write_protect()
 when clearing TDP MMU dirty bits
From: Sean Christopherson <seanjc@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org, 
	syzbot+900d58a45dcaab9e4821@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

The shortlog is a bit too literal, e.g. without intimate knowledge of what
kvm_mmu_page_ad_need_write_protect() does, it's impossible to know what this
patch actually fixes.

In this case, since it's a bug fix, I think it makes sense to explicitly call
out the L2 SPTEs angled, at the cost of not capturing the more general gist of
the patch.

On Fri, Mar 15, 2024, David Matlack wrote:
> Check kvm_mmu_page_ad_need_write_protect() when deciding whether to
> write-protect or clear D-bits on TDP MMU SPTEs.
> 
> TDP MMU SPTEs must be write-protected when the TDP MMU is being used to
> run an L2 (i.e. L1 has disabled EPT) and PML is enabled. KVM always
> disables the PML hardware when running L2, so failing to write-protect
> TDP MMU SPTEs will cause writes made by L2 to not be reflected in the
> dirty log.

I massaged this slightly to explain what kvm_mmu_page_ad_need_write_protect()
does at a high level, at least as far as this patch is concerned.

    KVM: x86/mmu: Write-protect L2 SPTEs in TDP MMU when clearing dirty status
    
    Check kvm_mmu_page_ad_need_write_protect() when deciding whether to
    write-protect or clear D-bits on TDP MMU SPTEs, so that the TDP MMU
    accounts for any role-specific reasons for disabling D-bit dirty logging.
    
    Specifically, TDP MMU SPTEs must be write-protected when the TDP MMU is
    being used to run an L2 (i.e. L1 has disabled EPT) and PML is enabled.
    KVM always disables PML when running L2, even when L1 and L2 GPAs are in
    the some domain, so failing to write-protect TDP MMU SPTEs will cause
    writes made by L2 to not be reflected in the dirty log.
 
> Reported-by: syzbot+900d58a45dcaab9e4821@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=900d58a45dcaab9e4821
> Fixes: 5982a5392663 ("KVM: x86/mmu: Use kvm_ad_enabled() to determine if TDP MMU SPTEs need wrprot")
> Cc: stable@vger.kernel.org
> Cc: Vipin Sharma <vipinsh@google.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  arch/x86/kvm/mmu/tdp_mmu.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 6ae19b4ee5b1..c3c1a8f430ef 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -1498,6 +1498,16 @@ void kvm_tdp_mmu_try_split_huge_pages(struct kvm *kvm,
>  	}
>  }
>  
> +static bool tdp_mmu_need_write_protect(struct kvm_mmu_page *sp)
> +{
> +	/*
> +	 * All TDP MMU shadow pages share the same role as their root, aside
> +	 * from level, so it is valid to key off any shadow page to determine if
> +	 * write protection is needed for an entire tree.
> +	 */
> +	return kvm_mmu_page_ad_need_write_protect(sp) || !kvm_ad_enabled();
> +}
> +
>  /*
>   * Clear the dirty status of all the SPTEs mapping GFNs in the memslot. If
>   * AD bits are enabled, this will involve clearing the dirty bit on each SPTE.
> @@ -1508,7 +1518,8 @@ void kvm_tdp_mmu_try_split_huge_pages(struct kvm *kvm,
>  static bool clear_dirty_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
>  			   gfn_t start, gfn_t end)
>  {
> -	u64 dbit = kvm_ad_enabled() ? shadow_dirty_mask : PT_WRITABLE_MASK;
> +	const u64 dbit = tdp_mmu_need_write_protect(root)
> +		? PT_WRITABLE_MASK : shadow_dirty_mask;

I would much prefer to keep the '?' and the first clause on the previous line.
Putting operators on a newline is frowned upon in general, and having the
PT_WRITABLE_MASK on the same line as tdp_mmu_need_write_protect() makes it quite
easy to understand the logic.

>  	struct tdp_iter iter;
>  	bool spte_set = false;
>  
> @@ -1523,7 +1534,7 @@ static bool clear_dirty_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
>  		if (tdp_mmu_iter_cond_resched(kvm, &iter, false, true))
>  			continue;
>  
> -		KVM_MMU_WARN_ON(kvm_ad_enabled() &&
> +		KVM_MMU_WARN_ON(dbit == shadow_dirty_mask &&
>  				spte_ad_need_write_protect(iter.old_spte));
>  
>  		if (!(iter.old_spte & dbit))
> @@ -1570,8 +1581,8 @@ bool kvm_tdp_mmu_clear_dirty_slot(struct kvm *kvm,
>  static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
>  				  gfn_t gfn, unsigned long mask, bool wrprot)
>  {
> -	u64 dbit = (wrprot || !kvm_ad_enabled()) ? PT_WRITABLE_MASK :
> -						   shadow_dirty_mask;
> +	const u64 dbit = (wrprot || tdp_mmu_need_write_protect(root))
> +		? PT_WRITABLE_MASK : shadow_dirty_mask;

Same here.

>  	struct tdp_iter iter;
>  
>  	lockdep_assert_held_write(&kvm->mmu_lock);
> @@ -1583,7 +1594,7 @@ static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
>  		if (!mask)
>  			break;
>  
> -		KVM_MMU_WARN_ON(kvm_ad_enabled() &&
> +		KVM_MMU_WARN_ON(dbit == shadow_dirty_mask &&
>  				spte_ad_need_write_protect(iter.old_spte));
>  
>  		if (iter.level > PG_LEVEL_4K ||
> -- 
> 2.44.0.291.gc1ea87d7ee-goog
> 

