Return-Path: <stable+bounces-136738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69564A9D688
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 02:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE004C2E6C
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 00:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD9E2B9BB;
	Sat, 26 Apr 2025 00:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMf/jT/9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D5182D2
	for <stable@vger.kernel.org>; Sat, 26 Apr 2025 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626113; cv=none; b=b0k91Ygm3zaDxfUai1ETZYJxqFljQz8AdTHko7Ty9a8XLU17n1bU+NaLXqJGo+rpVvQloaogDmEriKjE8TUpguPINciFIbhVgcdmoqHAHBb+w8PkQqPWiK7M7loT3DWgsfpLz8UQXB+PnjdzV+q8pDNTq/uWgsRTNWzUbFGuffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626113; c=relaxed/simple;
	bh=dj0bfGtxPUBCB2BN99s57agY71aeiXn0r0ZVEZYdc64=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dsuR5JZ9Jl75RkTRFxbIuqUVLRX3XihGx/0FCWB6xaogkNXEcyaeTCqaqBOPA3ucNF+NcJfpcQRG8SDPAmyA7v3gdHeSH3FvIcd/nHa3ChvUXfhO7TtshGezEv5BasbF6w5xTnQH/mLQr81CGuSaRizoSKnIePJXOkeDCLm+h4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eMf/jT/9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff7cf599beso2588059a91.0
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 17:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745626110; x=1746230910; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8XVHrYIn93XRhYMir9nGcWzyn52V+i4Le0QPx96O+Ok=;
        b=eMf/jT/9OdpEhzXFfDlsLmJo616/a4dZ/HNZDhgNAEi7GNAj/41EfZHgAvORFaiOmU
         6z0O1Y7/nDRJq77a6aoCyetujAS2a+4KPz+RQvdM2r1zJOHy0sFmTUrzgyK7hW/0Caza
         O92Zp2z8MpbJ9VCPKv5HBj5tPeiYHPYmSDsEobwCX8AG8qILbZnyJeXHFDdjEYww9KUi
         k5J4CHfCLQjvLer+T813+JSZvUpqnGtZIi70scCJslTww0E+o+Om7LAg/mu642LzaDD7
         oOP6LWvcGt5GMYuzhQbS7zbjzAeI8KVIWPdPvPLimmX2Cr7jVvl3tu6yAE5djw+eb+e1
         qN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745626110; x=1746230910;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XVHrYIn93XRhYMir9nGcWzyn52V+i4Le0QPx96O+Ok=;
        b=lVS/9EktapC6uusnxPp6n3dmAFmtZRAA98nDduztN2YSs6rUXv60MekEl8HmquITLL
         woCtuGRVndmchdoVET+j224iXkPwVm8gbWfmWx9ymGw2TDcufWt6MZ7D81gLAMjPOdPI
         AFrClyAZ4XNfeVyfJERlJwh2OiUFk2aSBliKItzIJxrQgN+g4v2YAeNHxMAdtnTxly1H
         tW4vhigEigr7g8S/tfb/4Xnq+FSLgBV2L7HIXI8HO0M4fueVttz8vy5ImHfVTfC64Q5m
         1O+2Igbe1ORnB/Ow5Bg0Xd6oI5+szn+DrKrmZyWluhIP/fniQFz7VgpP9xx1xzNZmOtH
         NAow==
X-Forwarded-Encrypted: i=1; AJvYcCWtQLd09PyMYBGj1lgEatxWNO0AZ4pkGYcfillqygZO73tWRr+Slrwcv0zdER7M1xYCBISPdL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzMIpNmSnWJUSNdGU92Grx+QTzI/LITj6fKhYE0oalp/MdcK6M
	r/V5wuohw6iIvr1r9yrXkbO1q/N5CZFZngResUOlTM8xAvbcBE4jxtEYQ6moKdqYG8wwO5FQQzC
	bCw==
X-Google-Smtp-Source: AGHT+IG839ZjiQvqwW0BTxpqFP/CgujLrvPhmCLViZ6YlkA3FlFXD8cwWJB/77igEcMr1jgFTr5u7o8tB9Q=
X-Received: from pjm7.prod.google.com ([2002:a17:90b:2fc7:b0:2fa:a101:743])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35c5:b0:2ee:c6c8:d89f
 with SMTP id 98e67ed59e1d1-309f7df0012mr7564718a91.14.1745626110633; Fri, 25
 Apr 2025 17:08:30 -0700 (PDT)
Date: Fri, 25 Apr 2025 17:08:29 -0700
In-Reply-To: <20250424203110.GCaAqfjnr-fogRgnt7@renoirsky.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aAKaf1liTsIA81r_@google.com> <20250418191224.GFaAKkGBnb01tGUVhW@fat_crate.local>
 <aAfQbiqp_yIV3OOC@google.com> <20250422173355.GDaAfTA8GqnGBfDk7G@renoirsky.local>
 <aAfynEK3wcfQa1qQ@google.com> <20250423072017.GAaAiUsYzDOdt7cmp2@renoirsky.local>
 <aAj0ySpCnHf_SX2J@google.com> <20250423184326.GCaAk0zinljkNHa_M7@renoirsky.local>
 <aAqOmjQ_bNy8NhDh@google.com> <20250424203110.GCaAqfjnr-fogRgnt7@renoirsky.local>
Message-ID: <aAwj_Tkqj4GtywDe@google.com>
Subject: Re: CONFIG_X86_HYPERVISOR (was: Re: [PATCH AUTOSEL 5.10 2/6] x86/cpu:
 Don't clear X86_FEATURE_LAHF_LM flag in init_amd_k8() on AMD when running in
 a virtual machine)
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Max Grobecker <max@grobecker.info>, Ingo Molnar <mingo@kernel.org>, 
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, 
	x86@kernel.org, thomas.lendacky@amd.com, perry.yuan@amd.com, 
	mario.limonciello@amd.com, riel@surriel.com, mjguzik@gmail.com, 
	darwi@linutronix.de, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 24, 2025, Borislav Petkov wrote:
> On Thu, Apr 24, 2025 at 12:18:50PM -0700, Sean Christopherson wrote:
> > Not quite.  KVM supports all of those seamlessly, with some caveats.  E.g. if
> > host userspace and guest kernel are trying to use the same DRx, the guest will
> > "lose" and not get its #DBs.
> 
> Pff, so cloud providers have big fat signs over their workstations
> saying: you're not allowed to use breakpoints on production systems?

Heh, it's a bit more than a sign.

> With my silly thinking, I'd prefer to reglement this more explicitly and
> actually have the kernel enforce policy:

The kernel already can enforce policy.  Setting host breakpoints on guest code
is done through a dedicated ioctl(), and access to said ioctl() can be restricted
through various sandboxing methods, e.g. seccomp.

> HV userspace has higher prio with #DB or guests do. But the "losing" bit
> sounds weird and not nice.

Yeah, it's weird and not nice.  But if a human is interactive debugging a guest,
odds are very, very good that a missing breakpoint in the guest is not at all a
concern.

> > Definitely not.  All I was thinking was something like:
> > 
> > diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
> > index fdbbbfec745a..a218c5170ecd 100644
> > --- a/arch/x86/include/asm/debugreg.h
> > +++ b/arch/x86/include/asm/debugreg.h
> > @@ -121,7 +121,7 @@ static __always_inline unsigned long local_db_save(void)
> >  {
> >         unsigned long dr7;
> >  
> > -       if (static_cpu_has(X86_FEATURE_HYPERVISOR) && !hw_breakpoint_active())
> > +       if (static_cpu_has(X86_FEATURE_DRS_MAY_VMEXIT) && !hw_breakpoint_active())
> >                 return 0;
> >  
> >         get_debugreg(dr7, 7);
> > 
> > Where X86_FEATURE_DRS_MAY_VMEXIT is set if HYPERVISOR is detected, but then
> > cleared by SEV-ES+ and TDX guests with guaranteed access to DRs.  That said,
> > even that much infrastructure probably isn't worth the marginal benefits.
> 
> Btw you can replace that X86_FEATURE_DRS_MAY_VMEXIT with a cc_platform
> flag which gets properly set on all those coco guest types as those
> flags are exactly for that stuff.

No, that would defeat the purpose of the check.  The X86_FEATURE_HYPERVISOR has
nothing to do with correctness, it's all about performance.  Critically, it's a
static check that gets patched at runtime.  It's a micro-optimization for bare
metal to avoid a single cache miss (the __this_cpu_read(cpu_dr7)).  Routing
through cc_platform_has() would be far, far heavier than calling hw_breakpoint_active().

I pointed out the SEV-ES+/TDX cases because they likely would benefit from that
same micro-optimization, i.e. by avoiding the call to hw_breakpoint_active().

