Return-Path: <stable+bounces-165092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1868B15031
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 17:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AD6F7A583D
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 15:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F021E25F8;
	Tue, 29 Jul 2025 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rb+vnUR5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8241A00E7
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803113; cv=none; b=c5cM2z3gKXCR3hrfl3BdvPBd8faVu6ItPqEK4JTuVw1vl09nSC+4Yj2ooAf90Al57f6ltsp65o0Bx81RH6vNR0Vv/2JeGXhikJn9T3T3AG0oSDqHgHdT7zmhHKm8P/3fvryrixuP0XTPIFJWdCV8SQaBnMZRPAkb92XMvWZvibQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803113; c=relaxed/simple;
	bh=9SNUpRf83tKX35+mrlVVZ5/SARTtX+GM2MlNxrsIQ0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnH9CfGHRpyYc81eFBACBiOBbXlgFwfc24hyFg6/y0azWrDiba373wuy0K+oeEReMjMiBl5ZvkvSPKel2DlyjJ1l89lyfkzg1YkEuWPy/WqthXiWi5VwOVjpfBZ0xx6hqOrRS9Ty2oZnrWZSzMt/fCkTg0dO9pWB67QbJE8ZqCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rb+vnUR5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b783ea502eso897346f8f.1
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753803109; x=1754407909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5T947jIUL2r6AMAQ8Bi05avA/GdnS5UQHGr+dRV2gs=;
        b=rb+vnUR5NrG8uLH1jU0Gw9/FmTfnJzLG1u5Z+wJF9w5G2XqYz1G9T75CswqY0Efil4
         QG36izzxvV2QpALTZm0QFbtTkQQfWv3ZpXfPNXzCPSbpXfTQgx0oEN+k10i3QTSGO9e8
         DV0paRKzGOXcC8zu4BSWV0BcerKkUjIHpd94UNF2YL6ByB27gzmOvdaQsR+BbhJAgaUG
         gIxUJoryedQwUjQMJU3qqsLBLGLr+dn2FP6GYzHSzZRLFoGD/c9WW212F87q3hw6ekwf
         kI6/UccUiDAfOlmLn0vkX0Jmwamyj8jbAc85sv9atL/wpsB2gkCTyEg92F1IxsAuPz9x
         S3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753803109; x=1754407909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5T947jIUL2r6AMAQ8Bi05avA/GdnS5UQHGr+dRV2gs=;
        b=X5Mk1h/mCVdoX2jS/XOJ8l88Eeoo2Xn+k9wMzLwpBfEocBRZweeIThrSUBcq1NHBcu
         62QFkAsU/WkKo94dQPks8BPjfAbiielGz9PgV530W9D6Zj0H5z9KYpEmU7pWk2mOlvmf
         67CRgUvNuXz9yOettI9b5V4UZfOL/Mtv/5TANoQ4TbGpgnu5UIsZaU6SJrJyiMdtuqJr
         MmN9jsEkatDgjVSQLfGdsNvKx2j+krin7XAJWhoBOZ+h1WwJf8E8lGdhZC2iF4zoZeBu
         jB5qqtLwe7Qox25b773UHjz87eFL7/5Ck4PQwCyO50qRPa1R7U5fHKzQ4x7BZFG+bHNQ
         HM9w==
X-Forwarded-Encrypted: i=1; AJvYcCXuOPxBkKXKdJUYkeXRmYBw9dGBJZSaDVDhglpOpkyNIPTC3v1YbcjE3/8moprXfVxM/9SfmrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhNHbkRpw+pt+UVjhBAYN/nkaO0m0ZEH2do1t8zUZ1XOgjBE7L
	JH39bgiKpoLeywRsNx1piLx16RW8yYoFZr0Y4qEx2u2kKh7cgFXqWaIErRP28iQj6eowQVj9jat
	4+DonV41iZnt2Hi8NdU3bKrnsqzvF8LgSY1Gymhgx
X-Gm-Gg: ASbGncvyZq7XRzyqNv6ElsvQl59Zj5yFof/TZDjm9CR4h48o4hy6V6lL3ILVZvIRO5n
	TwzusiNxXRmFwb38U/dBFc90Zscvpkn76Vjmp2JQDRVXNbgiDCpv9b17Klb9ymCAKH9AkPCfHNw
	Uweiwp8p3hc3H4sGLhCP8vXHych+g4vtPtEqe7VhfIRLW4yfMmI8twxYU1uWF/mDiOO0IA4A8K3
	37vwuYg9ceCTD7+jRd4XmGGsaev/9ycK6rINES1Eye2sCbAlX8=
X-Google-Smtp-Source: AGHT+IHufbHWGrcE6H6YTEDbWzL8c2qIJEjOoQTqO73spv4JETX+kra4urgxaHCl6/cUvIp8orzvlqgETFcgm6kc2vY=
X-Received: by 2002:a05:6000:2584:b0:3b6:162a:8e08 with SMTP id
 ffacd0b85a97d-3b78e4f54f2mr2887668f8f.12.1753803108996; Tue, 29 Jul 2025
 08:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1753492499-da8df97e@stable.kernel.org> <20250728175122.4021478-1-chengkev@google.com>
 <2025072934-path-slightly-24f2@gregkh>
In-Reply-To: <2025072934-path-slightly-24f2@gregkh>
From: Kevin Cheng <chengkev@google.com>
Date: Tue, 29 Jul 2025 11:31:38 -0400
X-Gm-Features: Ac12FXzZp0f4z9wHWzHHwlk5tLtKbbaCRs7uPxj8xrdC4NxkycJOrAdb5tdGHug
Message-ID: <CAE6NW_auGn-A0zCD5KtrrTuByC8fHCX2+Y+4R7b6eV8udMQseg@mail.gmail.com>
Subject: Re: [PATCH 6.12.y v2] KVM: x86: Free vCPUs before freeing VM state
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sashal@kernel.org, stable@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Aaron Lewis <aaronlewis@google.com>, 
	Jim Mattson <jmattson@google.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I left out

Message-ID: <20250224235542.2562848-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

mistakingly.

Thank you,
Kevin



On Tue, Jul 29, 2025 at 10:46=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Jul 28, 2025 at 05:51:22PM +0000, Kevin Cheng wrote:
> > From: Sean Christopherson <seanjc@google.com>
> >
> > [ Upstream commit 17bcd714426386fda741a4bccd96a2870179344b ]
> >
> > Free vCPUs before freeing any VM state, as both SVM and VMX may access
> > VM state when "freeing" a vCPU that is currently "in" L2, i.e. that nee=
ds
> > to be kicked out of nested guest mode.
> >
> > Commit 6fcee03df6a1 ("KVM: x86: avoid loading a vCPU after .vm_destroy =
was
> > called") partially fixed the issue, but for unknown reasons only moved =
the
> > MMU unloading before VM destruction.  Complete the change, and free all
> > vCPU state prior to destroying VM state, as nVMX accesses even more sta=
te
> > than nSVM.
> >
> > In addition to the AVIC, KVM can hit a use-after-free on MSR filters:
> >
> >   kvm_msr_allowed+0x4c/0xd0
> >   __kvm_set_msr+0x12d/0x1e0
> >   kvm_set_msr+0x19/0x40
> >   load_vmcs12_host_state+0x2d8/0x6e0 [kvm_intel]
> >   nested_vmx_vmexit+0x715/0xbd0 [kvm_intel]
> >   nested_vmx_free_vcpu+0x33/0x50 [kvm_intel]
> >   vmx_free_vcpu+0x54/0xc0 [kvm_intel]
> >   kvm_arch_vcpu_destroy+0x28/0xf0
> >   kvm_vcpu_destroy+0x12/0x50
> >   kvm_arch_destroy_vm+0x12c/0x1c0
> >   kvm_put_kvm+0x263/0x3c0
> >   kvm_vm_release+0x21/0x30
> >
> > and an upcoming fix to process injectable interrupts on nested VM-Exit
> > will access the PIC:
> >
> >   BUG: kernel NULL pointer dereference, address: 0000000000000090
> >   #PF: supervisor read access in kernel mode
> >   #PF: error_code(0x0000) - not-present page
> >   CPU: 23 UID: 1000 PID: 2658 Comm: kvm-nx-lpage-re
> >   RIP: 0010:kvm_cpu_has_extint+0x2f/0x60 [kvm]
> >   Call Trace:
> >    <TASK>
> >    kvm_cpu_has_injectable_intr+0xe/0x60 [kvm]
> >    nested_vmx_vmexit+0x2d7/0xdf0 [kvm_intel]
> >    nested_vmx_free_vcpu+0x40/0x50 [kvm_intel]
> >    vmx_vcpu_free+0x2d/0x80 [kvm_intel]
> >    kvm_arch_vcpu_destroy+0x2d/0x130 [kvm]
> >    kvm_destroy_vcpus+0x8a/0x100 [kvm]
> >    kvm_arch_destroy_vm+0xa7/0x1d0 [kvm]
> >    kvm_destroy_vm+0x172/0x300 [kvm]
> >    kvm_vcpu_release+0x31/0x50 [kvm]
> >
> > Inarguably, both nSVM and nVMX need to be fixed, but punt on those
> > cleanups for the moment.  Conceptually, vCPUs should be freed before VM
> > state.  Assets like the I/O APIC and PIC _must_ be allocated before vCP=
Us
> > are created, so it stands to reason that they must be freed _after_ vCP=
Us
> > are destroyed.
> >
> > Reported-by: Aaron Lewis <aaronlewis@google.com>
> > Closes: https://lore.kernel.org/all/20240703175618.2304869-2-aaronlewis=
@google.com
> > Cc: Jim Mattson <jmattson@google.com>
> > Cc: Yan Zhao <yan.y.zhao@intel.com>
> > Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>
> > Cc: Kai Huang <kai.huang@intel.com>
> > Cc: Isaku Yamahata <isaku.yamahata@intel.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Message-ID: <20250224235542.2562848-2-seanjc@google.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Kevin Cheng <chengkev@google.com>
> > ---
> >  arch/x86/kvm/x86.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index f378d479fea3f..7f91b11e6f0ec 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -12888,11 +12888,11 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
> >               mutex_unlock(&kvm->slots_lock);
> >       }
> >       kvm_unload_vcpu_mmus(kvm);
> > +     kvm_destroy_vcpus(kvm);
> >       kvm_x86_call(vm_destroy)(kvm);
> >       kvm_free_msr_filter(srcu_dereference_check(kvm->arch.msr_filter, =
&kvm->srcu, 1));
> >       kvm_pic_destroy(kvm);
> >       kvm_ioapic_destroy(kvm);
> > -     kvm_destroy_vcpus(kvm);
> >       kvfree(rcu_dereference_check(kvm->arch.apic_map, 1));
> >       kfree(srcu_dereference_check(kvm->arch.pmu_event_filter, &kvm->sr=
cu, 1));
> >       kvm_mmu_uninit_vm(kvm);
> > --
> > 2.50.1.487.gc89ff58d15-goog
> >
> >
>
> What changed in this v2 version?
>
> confused,
>
> greg k-h

