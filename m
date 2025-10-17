Return-Path: <stable+bounces-187708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9087ABEBE0B
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0FFED353249
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 22:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA093223710;
	Fri, 17 Oct 2025 22:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o7eSNL1R"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E9E1EC01B
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760738551; cv=none; b=YKRBWCF9Pxdz5Sv5PfznjCSxYod/eKd0CtjuIBuGKIFvx7/QGM7h52jLav3wSMBqCN5o7VEC99mn0qEM4q9rEWlP4gPgwLjK/XhlRkCLQMoFsSjlU7CM61kOuyPHEqDYLCIO3UrwsGzTsgRASuDOiOoZQ3AbH80EjQN4EnUboY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760738551; c=relaxed/simple;
	bh=Sv4mt4tm1uam2/n94ETeDUnGjgQXLOgBPWlXE081u3U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JvkCPB0IRhIpVf8cr/yPyn4ajGRkuN+n/aM2a9/YyO8fDIQOOwxP6eh7aTxNX5k8Q5TEd2lqYoyI8I8M2la42EoAwcAZFwwc4fRr2sSMU9nXoMHIXz3UvVBgvl0YhRDH97TTVLNpKLIx+hfNVD0/2F75+tRUJqYvik00VBbgKig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o7eSNL1R; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2924b3b9d47so221755ad.0
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 15:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760738549; x=1761343349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d9AK61KxDwRiG/wbv/v3+5vtYbhhFqmy3e1ldjEh/DU=;
        b=o7eSNL1Rt5HKHATYqQihK5tmA5zdDMNRHv3Ig1EKFHNJZAWz72RQouf6emcIIgfW4g
         ZmlskVXNVjT5+jgPpoBjw3sPsFQbi0NtnnNlie1pGGNVx1WtU2I9cQGjA3ursvxSXnJX
         nKdZd5F9MI01WG0+cWejMZvg3/YOcoFIM9mQWrogEyiukSr3dVuBivbqHoK5tgOzEywO
         FQkI4gMkguwkAGmzn3kkzwkLmKeNIxIfmZGI/WuYb2pf5U2ke2qBEFFzKpDnkpuyEg0R
         pJVIpAF5pYa0zkCcsy0oKFQu0CJ8sIwxYKyRW2SEDZRvryeNrbqYTf4A/EoL7RZ8J2hF
         1goQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760738549; x=1761343349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9AK61KxDwRiG/wbv/v3+5vtYbhhFqmy3e1ldjEh/DU=;
        b=KhZd4EeEUhsO+CYTS+SGqumtqwk4Ij4xwicFNeNw+jMjMl8voC6owgulrBKl8vC/9M
         VWWCHVVle2+xWdjO9TwLhcH/asUSWuni8NQ+P0nh8vsmtX+M8fo+gj0sSHpL2nFoEd8H
         HQv/p3bN6C1uW+sUzfwYXZgBHEShh7KLPinmweKf4+rFFliD5nyQdy1X4z6A8ZhaFEso
         m6pb44+AKTGAECTPCyiR1WAKwsvoYHt4jfXfToOlPu5pC9tOGwvlE/LRj2U+WOglY3u4
         Kyv7IdGRESa0fSTOYZDnxfkKF5gzs4t6mbiIWtYq7msBBDyJaUyZw2AuNIBktn3d/fkJ
         E01Q==
X-Gm-Message-State: AOJu0Yz/34evdk/ty/J5KGkJv/WNGH86IFOhrX4Q+xusowYYL96BZXqk
	fOC3brfMABAYK4E066jJaHDZmIZeRI3VPYt+fZOblxF9bflGpYh57P7Sa67QaWVsWMUsra7jmcT
	j0bkYbg==
X-Google-Smtp-Source: AGHT+IHHkjDR/wald6CV7yRCKWPz9yv0mp7oYLpEUrLqZk99GbyKNaNULOAoY1/y4NwClNX6VIkW4ADo4zE=
X-Received: from pjbgc13.prod.google.com ([2002:a17:90b:310d:b0:330:49f5:c0b1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:240d:b0:290:ac36:2ecd
 with SMTP id d9443c01a7336-290c9ca66famr69955175ad.14.1760738549216; Fri, 17
 Oct 2025 15:02:29 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:02:27 -0700
In-Reply-To: <20251013151140.3383954-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025101005-married-company-a3fc@gregkh> <20251013151140.3383954-1-sashal@kernel.org>
Message-ID: <aPK886wPucs9kdNh@google.com>
Subject: Re: [PATCH 6.1.y] KVM: x86: Don't (re)check L1 intercepts when
 completing userspace I/O
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, 
	syzbot+cc2032ba16cc2018ca25@syzkaller.appspotmail.com, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 13, 2025, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit e750f85391286a4c8100275516973324b621a269 ]
> 
> When completing emulation of instruction that generated a userspace exit
> for I/O, don't recheck L1 intercepts as KVM has already finished that
> phase of instruction execution, i.e. has already committed to allowing L2
> to perform I/O.  If L1 (or host userspace) modifies the I/O permission
> bitmaps during the exit to userspace,  KVM will treat the access as being
> intercepted despite already having emulated the I/O access.
> 
> Pivot on EMULTYPE_NO_DECODE to detect that KVM is completing emulation.
> Of the three users of EMULTYPE_NO_DECODE, only complete_emulated_io() (the
> intended "recipient") can reach the code in question.  gp_interception()'s
> use is mutually exclusive with is_guest_mode(), and
> complete_emulated_insn_gp() unconditionally pairs EMULTYPE_NO_DECODE with
> EMULTYPE_SKIP.
> 
> The bad behavior was detected by a syzkaller program that toggles port I/O
> interception during the userspace I/O exit, ultimately resulting in a WARN
> on vcpu->arch.pio.count being non-zero due to KVM no completing emulation
> of the I/O instruction.
> 
>   WARNING: CPU: 23 PID: 1083 at arch/x86/kvm/x86.c:8039 emulator_pio_in_out+0x154/0x170 [kvm]
>   Modules linked in: kvm_intel kvm irqbypass
>   CPU: 23 UID: 1000 PID: 1083 Comm: repro Not tainted 6.16.0-rc5-c1610d2d66b1-next-vm #74 NONE
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>   RIP: 0010:emulator_pio_in_out+0x154/0x170 [kvm]
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    kvm_fast_pio+0xd6/0x1d0 [kvm]
>    vmx_handle_exit+0x149/0x610 [kvm_intel]
>    kvm_arch_vcpu_ioctl_run+0xda8/0x1ac0 [kvm]
>    kvm_vcpu_ioctl+0x244/0x8c0 [kvm]
>    __x64_sys_ioctl+0x8a/0xd0
>    do_syscall_64+0x5d/0xc60
>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
>    </TASK>
> 
> Reported-by: syzbot+cc2032ba16cc2018ca25@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68790db4.a00a0220.3af5df.0020.GAE@google.com
> Fixes: 8a76d7f25f8f ("KVM: x86: Add x86 callback for intercept check")
> Cc: stable@vger.kernel.org
> Cc: Jim Mattson <jmattson@google.com>
> Link: https://lore.kernel.org/r/20250715190638.1899116-1-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [ is_guest_mode() was open coded ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

Thanks Sasha!

