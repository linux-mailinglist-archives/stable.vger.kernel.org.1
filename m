Return-Path: <stable+bounces-114742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC1DA2FE67
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 00:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35843A16E7
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 23:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59718261364;
	Mon, 10 Feb 2025 23:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hd66x9VG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8928025EF99
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739229997; cv=none; b=gHoR1tUrkGRZ+ysFDQ38zuV9XngfB655sYajbZO7Wy4YtgQZZPDIFsDDrQo2YwG+pdrdYpjtFeG3PfYcJyNVnlgzsTSebKukWbJ1TxdoleV8U6ot1KSE4UAcyliIBUkYk1sdrVRp6LHoD8+z/vN+Wu8ZpGgnTtYbWNzDW9h8iks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739229997; c=relaxed/simple;
	bh=CZUuCkyIQKxrQKqZgTjofTXSaKOijvZTvpLRa0qIBYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M9wCXYNkMQZtCKuNWGqVLQNHelawvlKv2/29mfdqVQo3KE29W5jYC49Y0wtUN273W/0UqXZX59fGRMfAwdyFkWC5XJRWNQk3TPuKSXnFuJNk7UiJxYhDQ1bOGnjGrxvaEm1i1NWWSc6KcROPtx8AFzkePZ5jC5uUuyB1RbUNrQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hd66x9VG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fa228b4151so7654313a91.1
        for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739229995; x=1739834795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N13YWUx1ZcMp4aHrnqOQBLoLE9MvfQbfztaxnyfAGFw=;
        b=Hd66x9VGDcm2JK88pL3NjkgZkvlo0GCR4ZKAihjjA0HGgIQharerCxBLtHAoviherz
         f+W7aL/oJjIRYEHUq75GJ06Nhsso9tWNRixagzEUSkR87kaBZ7MlmggwaKBC/PsOIr+a
         UqmDp6Wo0K7g2zMyAvVkuzV+RSmI/S6n1jqNCWt7Lh9l7V+Nav0PKk7dg2eiLqQXhgWp
         NEzvlQhoI0AM6DIOYsobGPTkj8gaiBpa6jEEQYB0d8KXCnMnPyXOAGRirn9kNjk+0PLF
         xTNhCKdyA7KLEB2zGfp1N9htBLvp5m5wdW7ce9SjAFcJjMxsZNV8RjBpVEAqCGN4uYBa
         uJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739229995; x=1739834795;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N13YWUx1ZcMp4aHrnqOQBLoLE9MvfQbfztaxnyfAGFw=;
        b=oNUNNXss3O6fqNS0jcqtm1C23U3v7dnMDJLFg5BNcoriqMttBQYV3frafYJWtHrxDt
         u5ULxOWsF84j6V5ml5rK88vAlw3qyG4kqaqVamLhKEgmcXGK+xaNsJG1c7MEA9lK/+h2
         quXJBFlZLPFsU3+xtvjXXfzNbj0aaRYxkmqxftwWEpefh/w9VpdWg4acspI6p/i/axcN
         9bX/7ocs5PwsjBhgoCS2M2f+aLWeE81ZpsrdlhuhPvK/OtxWA0G8Zx5VuzgiElGUkNEZ
         PCuQrV8yyjHUiqpKPHQ+IYG34bEDvr6RZE8wCBc4K2TbF7BS6A3nv+98yz49xMCSrHuy
         A6JA==
X-Gm-Message-State: AOJu0YwEbHiEktgUUCWOvAyTQNpJf9vfFvgSpUoKy63r4Mp/OH3+rVVG
	K0CfYBenC6FiC9JtCjw3OJ3NZOy2hH4ZKrWkS04bhggV+KKR2SPkrPv8ypq0kxlwNU9w0wXkvWM
	n6Q==
X-Google-Smtp-Source: AGHT+IGm0+JsmWI296vnskXjZiOxE0M7+6W9zIY8b2iMsGIzFtHjxI6dIj7DeYM2tlVXej/AvWmzm0+JARc=
X-Received: from pjh8.prod.google.com ([2002:a17:90b:3f88:b0:2ef:8eb8:e4eb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:f94f:b0:2ee:96a5:721c
 with SMTP id 98e67ed59e1d1-2fa2417c12fmr21582579a91.21.1739229994767; Mon, 10
 Feb 2025 15:26:34 -0800 (PST)
Date: Mon, 10 Feb 2025 15:26:33 -0800
In-Reply-To: <20250205222651.3784169-2-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024100123-unreached-enrage-2cb1@gregkh> <20250205222651.3784169-1-jthoughton@google.com>
 <20250205222651.3784169-2-jthoughton@google.com>
Message-ID: <Z6qLKdvdJ0WeNx6R@google.com>
Subject: Re: [PATCH 6.6.y 1/2] KVM: x86: Make x2APIC ID 100% readonly
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: stable@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Gavin Guo <gavinguo@igalia.com>, 
	Michal Luczaj <mhal@rbox.co>, Haoyu Wu <haoyuwu254@gmail.com>, 
	syzbot+545f1326f405db4e1c3e@syzkaller.appspotmail.com, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 05, 2025, James Houghton wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Ignore the userspace provided x2APIC ID when fixing up APIC state for
> KVM_SET_LAPIC, i.e. make the x2APIC fully readonly in KVM.  Commit
> a92e2543d6a8 ("KVM: x86: use hardware-compatible format for APIC ID
> register"), which added the fixup, didn't intend to allow userspace to
> modify the x2APIC ID.  In fact, that commit is when KVM first started
> treating the x2APIC ID as readonly, apparently to fix some race:
> 
>  static inline u32 kvm_apic_id(struct kvm_lapic *apic)
>  {
> -       return (kvm_lapic_get_reg(apic, APIC_ID) >> 24) & 0xff;
> +       /* To avoid a race between apic_base and following APIC_ID update when
> +        * switching to x2apic_mode, the x2apic mode returns initial x2apic id.
> +        */
> +       if (apic_x2apic_mode(apic))
> +               return apic->vcpu->vcpu_id;
> +
> +       return kvm_lapic_get_reg(apic, APIC_ID) >> 24;
>  }
> 
> Furthermore, KVM doesn't support delivering interrupts to vCPUs with a
> modified x2APIC ID, but KVM *does* return the modified value on a guest
> RDMSR and for KVM_GET_LAPIC.  I.e. no remotely sane setup can actually
> work with a modified x2APIC ID.
> 
> Making the x2APIC ID fully readonly fixes a WARN in KVM's optimized map
> calculation, which expects the LDR to align with the x2APIC ID.
> 
>   WARNING: CPU: 2 PID: 958 at arch/x86/kvm/lapic.c:331 kvm_recalculate_apic_map+0x609/0xa00 [kvm]
>   CPU: 2 PID: 958 Comm: recalc_apic_map Not tainted 6.4.0-rc3-vanilla+ #35
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.2-1-1 04/01/2014
>   RIP: 0010:kvm_recalculate_apic_map+0x609/0xa00 [kvm]
>   Call Trace:
>    <TASK>
>    kvm_apic_set_state+0x1cf/0x5b0 [kvm]
>    kvm_arch_vcpu_ioctl+0x1806/0x2100 [kvm]
>    kvm_vcpu_ioctl+0x663/0x8a0 [kvm]
>    __x64_sys_ioctl+0xb8/0xf0
>    do_syscall_64+0x56/0x80
>    entry_SYSCALL_64_after_hwframe+0x46/0xb0
>   RIP: 0033:0x7fade8b9dd6f
> 
> Unfortunately, the WARN can still trigger for other CPUs than the current
> one by racing against KVM_SET_LAPIC, so remove it completely.
> 
> Reported-by: Michal Luczaj <mhal@rbox.co>
> Closes: https://lore.kernel.org/all/814baa0c-1eaa-4503-129f-059917365e80@rbox.co
> Reported-by: Haoyu Wu <haoyuwu254@gmail.com>
> Closes: https://lore.kernel.org/all/20240126161633.62529-1-haoyuwu254@gmail.com
> Reported-by: syzbot+545f1326f405db4e1c3e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000c2a6b9061cbca3c3@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-ID: <20240802202941.344889-2-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> (cherry picked from commit 4b7c3f6d04bd53f2e5b228b6821fb8f5d1ba3071)

FWIW, for upstream LTS backports, the upstream commit information is usually place
at the top, before the original commit's changelog begins, and the blurb explicitly
calls out that it's an upstream commit.  I personally like this style:

  [ Upstream commit 4b7c3f6d04bd53f2e5b228b6821fb8f5d1ba3071 ]

as I find it easy to visually parse/separate from the original changelog.

> Signed-off-by: James Houghton <jthoughton@google.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

