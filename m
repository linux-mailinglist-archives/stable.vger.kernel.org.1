Return-Path: <stable+bounces-107763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43470A03160
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 21:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2AC61886B18
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 20:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258D81DDC0F;
	Mon,  6 Jan 2025 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dswdM0Ju"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665DADDBC
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736195267; cv=none; b=nKvBIPYXnYj84oP95Za1YoEAnQUGYTSoD2zvJl9bJODqK3WskgydD0s3/D7YRaMHliKBMIIA40z1bq6pvXy7UkxW3gQZ+M7Orx+MHq3sWaKWibmMiD/hpFrFxaS7mwEXYvlvTH5Mw80XImOYZJ6qJNWELS/2TGTtUUhNmGLyku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736195267; c=relaxed/simple;
	bh=fSekIhehtZmEYM8m+UMCn4RAjCnAIb1B35lBYxB0u2I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N7RbA3qt26gjuaaTzJdtuNN2B1aaxF7/kxJ6xiyEvdZhhTo0T/9iYZpt+DAe2FDyFcWm68AYGIcLIZHcLWnp8ZTna9xZ+Iz154x9MsMITbH2359JBHKsJcCSm2PjqlYW1upjvQWK4/bOhnZdhbKhjocMBA7aW/DhsJe6j+Nj7I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dswdM0Ju; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef728e36d5so21353484a91.3
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 12:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736195266; x=1736800066; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wiCvifj8dcSeBO9EgRDuEKt4b5UC2vhbCgxGSNIBg4E=;
        b=dswdM0JuZNVC3b0sOdN1ui6lrKRnDCMFbnD2YjWM+A+ny9C9fCiVbqEPvsYUwoI0XA
         S4ru6f7v5bxSBPaPloBaTHtHCio3BdfeHaGYzHpm5I4x7EFUE4Yzwfp14mZhENiOKpl5
         nGvEWwFhzy8oCVTYh1narYZewxZd8v8F4rrSkLmQaU+AbvDB7yHs0F4p5hV34KADbeOU
         UVvl25MSXxAtTtJGjVHDwclrXpqgw+jCBCEZnMdWh8+qAmkmGfSKgJCLe3tMJqHu5Q36
         paGbvF2cMyEPsaGJ6M6TbMpJvm6wleywBZtbKSht5IOcKGzuuWyroX2wVL75fd58ThGd
         /ssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736195266; x=1736800066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiCvifj8dcSeBO9EgRDuEKt4b5UC2vhbCgxGSNIBg4E=;
        b=sXyScqw7t1FgoaF5AVw+iscenTjpsfyY60m5KKK2hnOqJjl40azZKnKgV5ZY2sl8J1
         pLlc50HYwWWk7NIzkGPoIWQyL5J9f0Yb4ymD2QTv4VjNSSLpLlCmU15iaSAwOo1CCjS3
         v+JQ3JVp1ERN+sZBimQqXtmMjsbdcpGQHWeFWrn5SGRFeRdcuKg1YIw/Ynozka/hzTlp
         gFUpouGTN79z4UJIkd4Y/T4XDzJJTqIITB74Z1eE1nqNjaCGOH0U+iV3LWBC+sPTHML2
         9kotpf669eM6zj0RPngt0smyHLIJv2wDVaa0Cwn3SxkZrN6bn/5kkB/U217Cpx2IViL6
         jHiA==
X-Forwarded-Encrypted: i=1; AJvYcCWEsMBJCpNlh/FG2r7pYpsTwDdQRkkUss2z/RjNtc5s5Li2g3WsPuxv4UMgEzmBkt3frj6m63Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRtTzPTtGDTznAz5Zih3kuEVthp6Hhqep1JjoxXrKtRv9vkuED
	MkL706Llq3kWKb8RRvXzaVZnY5s6sgpP1a6UWbxIW9KgH/CfWdhPvP21LIjs4SUQ6IF7HIK4rBg
	XNg==
X-Google-Smtp-Source: AGHT+IFHqTblkO6OHD8AhzygsDlYDwlbvubT/lnkJmxd2ec6upce4F2a9c5d4m1oJ88l3tpl8ctQEaZxo/I=
X-Received: from pjbsn6.prod.google.com ([2002:a17:90b:2e86:b0:2f4:432d:250c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2649:b0:2ee:dd9b:e402
 with SMTP id 98e67ed59e1d1-2f452e0e152mr109962634a91.12.1736195265768; Mon,
 06 Jan 2025 12:27:45 -0800 (PST)
Date: Mon, 6 Jan 2025 12:27:44 -0800
In-Reply-To: <Z3AWJjUDmfCnD99S@lappy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241226033847.760293-1-gavinguo@igalia.com> <Z3AWJjUDmfCnD99S@lappy>
Message-ID: <Z3w8wPRvjNyDXSQS@google.com>
Subject: Re: [PATCH 6.6] KVM: x86: Make x2APIC ID 100% readonly
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Gavin Guo <gavinguo@igalia.com>, stable@vger.kernel.org, mhal@rbox.co, 
	haoyuwu254@gmail.com, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Sat, Dec 28, 2024, Sasha Levin wrote:
> On Thu, Dec 26, 2024 at 11:38:47AM +0800, Gavin Guo wrote:
> > From: Sean Christopherson <seanjc@google.com>
> > 
> > [ Upstream commit 4b7c3f6d04bd53f2e5b228b6821fb8f5d1ba3071 ]
> > 
> > Ignore the userspace provided x2APIC ID when fixing up APIC state for
> > KVM_SET_LAPIC, i.e. make the x2APIC fully readonly in KVM.  Commit
> > a92e2543d6a8 ("KVM: x86: use hardware-compatible format for APIC ID
> > register"), which added the fixup, didn't intend to allow userspace to
> > modify the x2APIC ID.  In fact, that commit is when KVM first started
> > treating the x2APIC ID as readonly, apparently to fix some race:
> > 
> > static inline u32 kvm_apic_id(struct kvm_lapic *apic)
> > {
> > -       return (kvm_lapic_get_reg(apic, APIC_ID) >> 24) & 0xff;
> > +       /* To avoid a race between apic_base and following APIC_ID update when
> > +        * switching to x2apic_mode, the x2apic mode returns initial x2apic id.
> > +        */
> > +       if (apic_x2apic_mode(apic))
> > +               return apic->vcpu->vcpu_id;
> > +
> > +       return kvm_lapic_get_reg(apic, APIC_ID) >> 24;
> > }
> > 
> > Furthermore, KVM doesn't support delivering interrupts to vCPUs with a
> > modified x2APIC ID, but KVM *does* return the modified value on a guest
> > RDMSR and for KVM_GET_LAPIC.  I.e. no remotely sane setup can actually
> > work with a modified x2APIC ID.
> > 
> > Making the x2APIC ID fully readonly fixes a WARN in KVM's optimized map
> > calculation, which expects the LDR to align with the x2APIC ID.
> > 
> >  WARNING: CPU: 2 PID: 958 at arch/x86/kvm/lapic.c:331 kvm_recalculate_apic_map+0x609/0xa00 [kvm]
> >  CPU: 2 PID: 958 Comm: recalc_apic_map Not tainted 6.4.0-rc3-vanilla+ #35
> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.2-1-1 04/01/2014
> >  RIP: 0010:kvm_recalculate_apic_map+0x609/0xa00 [kvm]
> >  Call Trace:
> >   <TASK>
> >   kvm_apic_set_state+0x1cf/0x5b0 [kvm]
> >   kvm_arch_vcpu_ioctl+0x1806/0x2100 [kvm]
> >   kvm_vcpu_ioctl+0x663/0x8a0 [kvm]
> >   __x64_sys_ioctl+0xb8/0xf0
> >   do_syscall_64+0x56/0x80
> >   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> >  RIP: 0033:0x7fade8b9dd6f
> > 
> > Unfortunately, the WARN can still trigger for other CPUs than the current
> > one by racing against KVM_SET_LAPIC, so remove it completely.
> > 
> > Reported-by: Michal Luczaj <mhal@rbox.co>
> > Closes: https://lore.kernel.org/all/814baa0c-1eaa-4503-129f-059917365e80@rbox.co
> > Reported-by: Haoyu Wu <haoyuwu254@gmail.com>
> > Closes: https://lore.kernel.org/all/20240126161633.62529-1-haoyuwu254@gmail.com
> > Reported-by: syzbot+545f1326f405db4e1c3e@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/000000000000c2a6b9061cbca3c3@google.com
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Message-ID: <20240802202941.344889-2-seanjc@google.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Gavin Guo <gavinguo@igalia.com>
> 
> As this one isn't tagged for stable, the KVM maintainers should ack the
> backport before we take it.

What's the motivation for applying this to 6.6?  AFAIK, there's no real world use
case that benefits from the patch, the fix is purely to plug a hole where fuzzers,
e.g. syzkaller, can trip a WARN.

That said, this is essentially a prerequisite for "KVM: x86: Re-split x2APIC ICR
into ICR+ICR2 for AMD (x2AVIC)"[*], and it's relatively low risk, so I'm not
opposed to landing it in 6.6.

[*] https://lore.kernel.org/all/2024100123-unreached-enrage-2cb1@gregkh

