Return-Path: <stable+bounces-106232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41B89FDB7E
	for <lists+stable@lfdr.de>; Sat, 28 Dec 2024 16:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E387160388
	for <lists+stable@lfdr.de>; Sat, 28 Dec 2024 15:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0B615DBC1;
	Sat, 28 Dec 2024 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phV6PVA7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B2B7E575
	for <stable@vger.kernel.org>; Sat, 28 Dec 2024 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735398952; cv=none; b=CQ9Cg3A9Ti2s8wLOWMR5BZBOS+2ejTBajxvd8wI7RRqNbEnMW0J4umoGOyDJ8zo2HQzNJn1szXi+Ho30QT2b8Y0yLN9FucUUVWyaqFvbEQ7kV5ZdskW58sXFJZ7gVM9CbpNeMzoBGVYf/pRLN8q8hpH0DTbU0mJ2O0N9kjRvXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735398952; c=relaxed/simple;
	bh=gIQv6WIzFMQE3J2U4bylWeQdLvAZoBhGBbxu9c8Wnd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFZdKPTOQ+aJOcfguqZuSrNJnYW0h+tYgpSTbi0g84EdsIuqV2hy2Tm4s3IJ47wh2YH6nGpYkqoae6cgc6LK98w5gVFGRC8IXtXC8xAkUodnGNn4waxqm5twCZJUXugOFNnIWmx+LYB25DSgUN4Y7PrN3fUvbWsYKw1j4IO6WYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phV6PVA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965E4C4CECD;
	Sat, 28 Dec 2024 15:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735398951;
	bh=gIQv6WIzFMQE3J2U4bylWeQdLvAZoBhGBbxu9c8Wnd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=phV6PVA7HGI8Ev/gJSuMz5iwv01I2QYhxYpc9C0mNLbNViF+cOsFAMy6O3UtN3l8A
	 9Ldw/3HcyehRCOh45SqCv+mgZlbZamslmbWyIqjJinnyVxxNHXn2wTPBuiAh4jfizV
	 Zidjsi/3QOST4KMVy7GvwEbCsRKewcPEzW1Vq8VdJbXKN43FOEMo7c3IR29e/A+v1d
	 Laqie3MJipgLg+q4WJTy5tIUXe7Qjbm7Dxlrf6MkOFdZTZTkjMd808te95MG3ENhkT
	 BTSQzoK4kNv2qD0GKcd/y3uyetVjOxV2KOJD1pKhrKd6DNCu0mmzv3Vvc6+K9VyOqB
	 yNU9bzyRKKqIw==
Date: Sat, 28 Dec 2024 10:15:50 -0500
From: Sasha Levin <sashal@kernel.org>
To: Gavin Guo <gavinguo@igalia.com>
Cc: stable@vger.kernel.org, seanjc@google.com, mhal@rbox.co,
	haoyuwu254@gmail.com, pbonzini@redhat.com
Subject: Re: [PATCH 6.6] KVM: x86: Make x2APIC ID 100% readonly
Message-ID: <Z3AWJjUDmfCnD99S@lappy>
References: <20241226033847.760293-1-gavinguo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241226033847.760293-1-gavinguo@igalia.com>

On Thu, Dec 26, 2024 at 11:38:47AM +0800, Gavin Guo wrote:
>From: Sean Christopherson <seanjc@google.com>
>
>[ Upstream commit 4b7c3f6d04bd53f2e5b228b6821fb8f5d1ba3071 ]
>
>Ignore the userspace provided x2APIC ID when fixing up APIC state for
>KVM_SET_LAPIC, i.e. make the x2APIC fully readonly in KVM.  Commit
>a92e2543d6a8 ("KVM: x86: use hardware-compatible format for APIC ID
>register"), which added the fixup, didn't intend to allow userspace to
>modify the x2APIC ID.  In fact, that commit is when KVM first started
>treating the x2APIC ID as readonly, apparently to fix some race:
>
> static inline u32 kvm_apic_id(struct kvm_lapic *apic)
> {
>-       return (kvm_lapic_get_reg(apic, APIC_ID) >> 24) & 0xff;
>+       /* To avoid a race between apic_base and following APIC_ID update when
>+        * switching to x2apic_mode, the x2apic mode returns initial x2apic id.
>+        */
>+       if (apic_x2apic_mode(apic))
>+               return apic->vcpu->vcpu_id;
>+
>+       return kvm_lapic_get_reg(apic, APIC_ID) >> 24;
> }
>
>Furthermore, KVM doesn't support delivering interrupts to vCPUs with a
>modified x2APIC ID, but KVM *does* return the modified value on a guest
>RDMSR and for KVM_GET_LAPIC.  I.e. no remotely sane setup can actually
>work with a modified x2APIC ID.
>
>Making the x2APIC ID fully readonly fixes a WARN in KVM's optimized map
>calculation, which expects the LDR to align with the x2APIC ID.
>
>  WARNING: CPU: 2 PID: 958 at arch/x86/kvm/lapic.c:331 kvm_recalculate_apic_map+0x609/0xa00 [kvm]
>  CPU: 2 PID: 958 Comm: recalc_apic_map Not tainted 6.4.0-rc3-vanilla+ #35
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.2-1-1 04/01/2014
>  RIP: 0010:kvm_recalculate_apic_map+0x609/0xa00 [kvm]
>  Call Trace:
>   <TASK>
>   kvm_apic_set_state+0x1cf/0x5b0 [kvm]
>   kvm_arch_vcpu_ioctl+0x1806/0x2100 [kvm]
>   kvm_vcpu_ioctl+0x663/0x8a0 [kvm]
>   __x64_sys_ioctl+0xb8/0xf0
>   do_syscall_64+0x56/0x80
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
>  RIP: 0033:0x7fade8b9dd6f
>
>Unfortunately, the WARN can still trigger for other CPUs than the current
>one by racing against KVM_SET_LAPIC, so remove it completely.
>
>Reported-by: Michal Luczaj <mhal@rbox.co>
>Closes: https://lore.kernel.org/all/814baa0c-1eaa-4503-129f-059917365e80@rbox.co
>Reported-by: Haoyu Wu <haoyuwu254@gmail.com>
>Closes: https://lore.kernel.org/all/20240126161633.62529-1-haoyuwu254@gmail.com
>Reported-by: syzbot+545f1326f405db4e1c3e@syzkaller.appspotmail.com
>Closes: https://lore.kernel.org/all/000000000000c2a6b9061cbca3c3@google.com
>Signed-off-by: Sean Christopherson <seanjc@google.com>
>Message-ID: <20240802202941.344889-2-seanjc@google.com>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>Signed-off-by: Gavin Guo <gavinguo@igalia.com>

As this one isn't tagged for stable, the KVM maintainers should ack the
backport before we take it.

-- 
Thanks,
Sasha

