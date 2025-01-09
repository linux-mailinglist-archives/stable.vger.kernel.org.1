Return-Path: <stable+bounces-108092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C1EA07528
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 12:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A6D3A7905
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 11:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15231216E05;
	Thu,  9 Jan 2025 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Is3Gxv8Q"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2121A23B0
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736423850; cv=none; b=PCp1UltRer6zsdMegMDgJNVTP9ovTPXbNMZt9je38pmxwChL3hK+3Y73w3LrMsavdbdYgnvYTfVdWvawxG0L6mt/QPZv8k8mFR9BdNvB7KHErtokHi1chh6tZmZJmsD3KAyKuD71dxzat4LQyQS4+joibN90r0+rF8JiA9FGzUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736423850; c=relaxed/simple;
	bh=x+awWrYfpI7iTBUgFDMLbYtsYIH4O+YVhCQYjcLwBPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUrH6mKLztnakv79/reo2F0p4EXnQhf6oWLmGUNGyxTp1SrM8vi9bplXQ7p4Kh6A66XFRVFVwHAd3Omj9O62+uRUx4o+jvSVC1zCvR9gKWb4C3MyMdJTsb4fWs12l185wjjqOnqwQY6ZQAGn8mim12SWQ90aubGCBWjwoiwCVQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Is3Gxv8Q; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Zemaecocy7C4YdtJVcNDwEAu6hOI+96zFYwh8lBLf2s=; b=Is3Gxv8QWcNH2GPBiJHEsafKqt
	D/R70QCeJz+dLIRCgqPDo3z6w62bnrOOg7cslN4stnb6OVYQkgLAvgou/+ksvfvrdk9zC6THeG5DK
	yn/VhenK/1wAPf0fI+TQuKdCAtWUQOubHzgpD1dB7iLOjn8swT5pfitEm+igTtpwLPDON95o/cD63
	MJ9ED0rqNPCMkOoXT+2WKGbrvI0ZrTYIt5TPcxkScD/T7agBdekqe9NHzC/THC/gVPwPcGVTpUaIy
	9ycFIAfjKeEKXvbQZws+T2dA4W9vrwbGM5zgzTvlNyp12/k7WhYwMiNBSALVS+iKturuLMSbncnV8
	Ea8J2+Qw==;
Received: from 27-52-162-135.adsl.fetnet.net ([27.52.162.135] helo=[192.168.247.167])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tVrAA-00DXZD-9V; Thu, 09 Jan 2025 12:57:22 +0100
Message-ID: <8bfc2790-a159-795f-6e4d-38b10227d726@igalia.com>
Date: Thu, 9 Jan 2025 19:57:14 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.6] KVM: x86: Make x2APIC ID 100% readonly
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, mhal@rbox.co, haoyuwu254@gmail.com,
 pbonzini@redhat.com
References: <20241226033847.760293-1-gavinguo@igalia.com>
 <Z3AWJjUDmfCnD99S@lappy> <Z3w8wPRvjNyDXSQS@google.com>
From: Gavin Guo <gavinguo@igalia.com>
In-Reply-To: <Z3w8wPRvjNyDXSQS@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/7/25 04:27, Sean Christopherson wrote:
> On Sat, Dec 28, 2024, Sasha Levin wrote:
>> On Thu, Dec 26, 2024 at 11:38:47AM +0800, Gavin Guo wrote:
>>> From: Sean Christopherson <seanjc@google.com>
>>>
>>> [ Upstream commit 4b7c3f6d04bd53f2e5b228b6821fb8f5d1ba3071 ]
>>>
>>> Ignore the userspace provided x2APIC ID when fixing up APIC state for
>>> KVM_SET_LAPIC, i.e. make the x2APIC fully readonly in KVM.  Commit
>>> a92e2543d6a8 ("KVM: x86: use hardware-compatible format for APIC ID
>>> register"), which added the fixup, didn't intend to allow userspace to
>>> modify the x2APIC ID.  In fact, that commit is when KVM first started
>>> treating the x2APIC ID as readonly, apparently to fix some race:
>>>
>>> static inline u32 kvm_apic_id(struct kvm_lapic *apic)
>>> {
>>> -       return (kvm_lapic_get_reg(apic, APIC_ID) >> 24) & 0xff;
>>> +       /* To avoid a race between apic_base and following APIC_ID update when
>>> +        * switching to x2apic_mode, the x2apic mode returns initial x2apic id.
>>> +        */
>>> +       if (apic_x2apic_mode(apic))
>>> +               return apic->vcpu->vcpu_id;
>>> +
>>> +       return kvm_lapic_get_reg(apic, APIC_ID) >> 24;
>>> }
>>>
>>> Furthermore, KVM doesn't support delivering interrupts to vCPUs with a
>>> modified x2APIC ID, but KVM *does* return the modified value on a guest
>>> RDMSR and for KVM_GET_LAPIC.  I.e. no remotely sane setup can actually
>>> work with a modified x2APIC ID.
>>>
>>> Making the x2APIC ID fully readonly fixes a WARN in KVM's optimized map
>>> calculation, which expects the LDR to align with the x2APIC ID.
>>>
>>>   WARNING: CPU: 2 PID: 958 at arch/x86/kvm/lapic.c:331 kvm_recalculate_apic_map+0x609/0xa00 [kvm]
>>>   CPU: 2 PID: 958 Comm: recalc_apic_map Not tainted 6.4.0-rc3-vanilla+ #35
>>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.2-1-1 04/01/2014
>>>   RIP: 0010:kvm_recalculate_apic_map+0x609/0xa00 [kvm]
>>>   Call Trace:
>>>    <TASK>
>>>    kvm_apic_set_state+0x1cf/0x5b0 [kvm]
>>>    kvm_arch_vcpu_ioctl+0x1806/0x2100 [kvm]
>>>    kvm_vcpu_ioctl+0x663/0x8a0 [kvm]
>>>    __x64_sys_ioctl+0xb8/0xf0
>>>    do_syscall_64+0x56/0x80
>>>    entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>>   RIP: 0033:0x7fade8b9dd6f
>>>
>>> Unfortunately, the WARN can still trigger for other CPUs than the current
>>> one by racing against KVM_SET_LAPIC, so remove it completely.
>>>
>>> Reported-by: Michal Luczaj <mhal@rbox.co>
>>> Closes: https://lore.kernel.org/all/814baa0c-1eaa-4503-129f-059917365e80@rbox.co
>>> Reported-by: Haoyu Wu <haoyuwu254@gmail.com>
>>> Closes: https://lore.kernel.org/all/20240126161633.62529-1-haoyuwu254@gmail.com
>>> Reported-by: syzbot+545f1326f405db4e1c3e@syzkaller.appspotmail.com
>>> Closes: https://lore.kernel.org/all/000000000000c2a6b9061cbca3c3@google.com
>>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>>> Message-ID: <20240802202941.344889-2-seanjc@google.com>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
>> As this one isn't tagged for stable, the KVM maintainers should ack the
>> backport before we take it.
> What's the motivation for applying this to 6.6?  AFAIK, there's no real world use
> case that benefits from the patch, the fix is purely to plug a hole where fuzzers,
> e.g. syzkaller, can trip a WARN.
>
> That said, this is essentially a prerequisite for "KVM: x86: Re-split x2APIC ICR
> into ICR+ICR2 for AMD (x2AVIC)"[*], and it's relatively low risk, so I'm not
> opposed to landing it in 6.6.
>
> [*] https://lore.kernel.org/all/2024100123-unreached-enrage-2cb1@gregkh
Thank you for reviewing the backporting. This backporting aims to 
address the
syzkaller warning message and ensure that the stable kernel is 
consistent with
the upstream version.

