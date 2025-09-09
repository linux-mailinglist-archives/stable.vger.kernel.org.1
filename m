Return-Path: <stable+bounces-179020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A3DB4A087
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 06:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57F11BC1B8D
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 04:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BE21DA4E;
	Tue,  9 Sep 2025 04:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XW+B3teX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181182DCF6D
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 04:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757391314; cv=none; b=soUwN3CmSnGq2hH7v94ybQXDI0wsd50o+qfXpWdu4UgZEcSWJTwk95R95iEz0MGvLNmhlJXE70OtGUrY3YbmDYbxrl8z9a6HS78j3f+ljhIiODFjt+dCptBGMtnF2g4JY7rwpb4ArOUUuwrbuKSNfdLOu2LrBb5rqjZ/8Fd/zCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757391314; c=relaxed/simple;
	bh=pT26+SEmVHYpGlNaHL/D6A4zo3+KsYiTJJ7qtmJTSBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfGqRWeYQNZiT9kpzaZ++wMekAA3CC3+cARc5MVCbO5npnuONzrJWhlfL7aXwdyv7Fa15+YOMugWwI75UhI49MdsBPRbOgMnm0ucK0bqf1w0NDzt1NH9eFjRjdFYzPyYYEkiNYK1IbPHtrImPMGaEV3GMx+LhPQtdyqW+yvNwFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XW+B3teX; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so4253419a91.2
        for <stable@vger.kernel.org>; Mon, 08 Sep 2025 21:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757391311; x=1757996111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gxJFMPENkiFzkdroR5Tz7I5/fIhy1HQ88CU3H7ggzqM=;
        b=XW+B3teXSpWOFRMme7Qt7a4ZbY3V06GPvHEINPHRRc65fm8mu3ROcAcp0PYwzfhCUk
         igxyQJCAOT3MhNH8iLAQvXcmtrQproSQAPivTI+b8wxuVd+WtmAZ58X6O9C7m/kNGkOT
         2JKqnVHYnGsY6G0QWTN2FVuMuK/vJgQzFtYS+Iw6yAy9d4jDofa99cgrWFtG6fjZb+op
         rXlpu6YeLCP2xrZMDiOTFh99x3Q+Lm6LYFRTucbFH0bcQzaK3dWoS/C574QnkEl/LWDq
         Ao9XSRptZcJv5RTbSaa9WuOblZSPjdYdUKLdNJpY5WIcNwPGUPQc5V2DaGgL/+uoCPlB
         h97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757391311; x=1757996111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gxJFMPENkiFzkdroR5Tz7I5/fIhy1HQ88CU3H7ggzqM=;
        b=hfz/ZrZIlvNC5h6qHJIRWiyV12h+WIa9PumgpGxZx/lZb3UpYvG4MiCTDhRCWXkEjI
         sDX2uIrmdmLYTsj7mLGYokQQF/zHy8K8co+38iCb1TE7DjwGwTufSJxg1PjzlJJ8BovI
         z06Id3gMmy4shj3tbOr19SmfdvMiv0zKKpOuAHi92qGVudKKlhzzUYvyuamOsrExqH+h
         V+w9xQwcZrycAORWpYmVHLLVjXqjELkOZlrKnzy0By1jblr4OJgN3zhuLnD1vHaPUem+
         zmDRahYF2XH/8gfcMXrkzmtGig7fYzVjluWDyy1k+S8CWHlSnVCJEcQXiFa+9z4DBUuE
         Hapg==
X-Forwarded-Encrypted: i=1; AJvYcCU5punA2seG62CwKa0BYOVaJVihE+JRQN56FBVzsbKCFao0iK+tQqu2XGy4nSLB8ZbtXSv0aVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywxOPuFOie9y5TN/xew0TASACGwLnEEas0J7771+oy50QAl1Oi
	lC4284FRbkQs2ng1W/vRioar5Qiut3nWQR9LKs6glDb8ptXnuOpDQEYcBxMVDdhdNls=
X-Gm-Gg: ASbGncsj5ykjGZGUqm5RAGg03HXyIUkobI7kRiX7mc6MFJ8TqYBbYPnTXtWks/uTXih
	moI+4fUarD/hxF13oshBV8sqOt6QD5MLEb0rDx5UaMXSrFhTJ7X96IpZ+d/0OHCBPEeaSAJL5J0
	MvK2MAnMPjIk9w9keMso3zl+Rg5NX9p/nd1l1t2e7zhSngfomvdVp88wwfr/NVUNq/Tu1HAsn6D
	LfY/nAnI9uPUGJCIP9kZNGhjca+1srXRaYuj2Hl5Yw58iyyaw9Z20tElQPPpdUBTQrChRRVTVYm
	hahHS+1uR+sPMCBTIgdma/F9oMvZK902U9Z8TmVfCnU1uaxqaJcHsR85ypzsV/7/5a3vLMvtFHt
	/5ecYLPtG40B9b7CnUQL/VX4npsbC6y/N5b2pbZEg7Z+MHqoaHA64ClsVOHNWbdyxGQ==
X-Google-Smtp-Source: AGHT+IFmKILluPVE6QmOTg7F4UbwBleP/P8TGLMY4CHiDK4pExZY9zUglDorw4SnH9nVD579gInq1g==
X-Received: by 2002:a17:90b:3952:b0:32b:b514:3935 with SMTP id 98e67ed59e1d1-32d43f006f7mr14194348a91.16.1757391311145;
        Mon, 08 Sep 2025 21:15:11 -0700 (PDT)
Received: from [10.4.105.106] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3298520c7d0sm26222185a91.3.2025.09.08.21.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 21:15:10 -0700 (PDT)
Message-ID: <16fb786e-94d7-4093-a62c-39e9a2c26599@bytedance.com>
Date: Tue, 9 Sep 2025 12:15:04 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] KVM: x86: Latch INITs only in specific CPU
 states in KVM_SET_VCPU_EVENTS
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 liran.alon@oracle.com, hpa@zytor.com, wanpeng.li@hotmail.com,
 kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250827152754.12481-1-lifei.shirley@bytedance.com>
 <aK8r11trXDjBnRON@google.com>
 <CABgObfYqVTK3uB00pAyZAdX=Vx1Xx_M0MOwUzm+D1C04mrVfig@mail.gmail.com>
 <f904b674-98ba-4e13-a64c-fd30b6ac4a2e@bytedance.com>
 <CABgObfb4ocYcaZixoPD_VZL5Z_SieTGJW3GBCFB-_LuOH5Ut2g@mail.gmail.com>
 <d686f056-180c-4a22-a359-81eadb062629@bytedance.com>
 <c2979c40-0cf9-4238-9fb5-5cef6dd9f411@bytedance.com>
 <aL8A7WKHfAsAkPlh@google.com>
Content-Language: en-US
From: Fei Li <lifei.shirley@bytedance.com>
In-Reply-To: <aL8A7WKHfAsAkPlh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/9/25 12:14 AM, Sean Christopherson wrote:
> On Mon, Sep 08, 2025, Fei Li wrote:
>>
>> On 9/5/25 10:59 PM, Fei Li wrote:
>>>
>>> On 8/29/25 12:44 AM, Paolo Bonzini wrote:
>>>> On Thu, Aug 28, 2025 at 5:13 PM Fei Li <lifei.shirley@bytedance.com>
>>>> wrote:
>>>>> Actually this is a bug triggered by one monitor tool in our production
>>>>> environment. This monitor executes 'info registers -a' hmp at a fixed
>>>>> frequency, even during VM startup process, which makes some AP stay in
>>>>> KVM_MP_STATE_UNINITIALIZED forever. But this race only occurs with
>>>>> extremely low probability, about 1~2 VM hangs per week.
>>>>>
>>>>> Considering other emulators, like cloud-hypervisor and
>>>>> firecracker maybe
>>>>> also have similar potential race issues, I think KVM had better do some
>>>>> handling. But anyway, I will check Qemu code to avoid such race. Thanks
>>>>> for both of your comments. 🙂
>>>> If you can check whether other emulators invoke KVM_SET_VCPU_EVENTS in
>>>> similar cases, that of course would help understanding the situation
>>>> better.
>>>>
>>>> In QEMU, it is possible to delay KVM_GET_VCPU_EVENTS until after all
>>>> vCPUs have halted.
>>>>
>>>> Paolo
>>>>
> 
> Replacing the original message with a decently formatted version.  Please try to
> format your emails for plain text, I assume something in your mail system inserted
> a pile of line wraps and made the entire thing all but unreadable.

Sure, sorry for the inconvenience.

> 
>>> `info registers -a` hmp per 2ms[1]
>>>                 AP(vcpu1) thread[2]
>>>        BSP(vcpu0) send INIT/SIPI[3]
>>>
>>> [1] for each cpu: cpu_synchronize_state
>>>      if !qemu_thread_is_self()
>>>          1. insert to cpu->work_list, and handle asynchronously
>>>          2. then kick the AP(vcpu1) by sending SIG_IPI/SIGUSR1 signal
>>>
>>> [2] KVM: KVM_RUN and then schedule() in kvm_vcpu_block() loop
>>>           KVM: checks signal_pending, breaks loop and  returns -EINTR
>>>      Qemu: break kvm_cpu_exec loop, run
>>>         1. qemu_wait_io_event()
>>>            => process_queued_cpu_work => cpu->work_list.func()
>>>               e.i. do_kvm_cpu_synchronize_state() callback
>>>            => kvm_arch_get_registers
>>>               => kvm_get_mp_state
>>>                  /* KVM: get_mpstate also calls kvm_apic_accept_events() to handle INIT and SIPI */
>>>                  => cpu->vcpu_dirty = true;
>>>            // end of qemu_wait_io_event
>>>
>>> [3] SeaBIOS: BSP enters non-root mode and runs reset_vector() in SeaBIOS.
>>>      send INIT and then SIPI by writing APIC_ICR during smp_scan
>>>      KVM: BSP(vcpu0) exits, then
>>>      => handle_apic_write
>>>         => kvm_lapic_reg_write
>>>            => kvm_apic_send_ipi to all APs
>>>               => for each AP: __apic_accept_irq, e.g. for AP(vcpu1)
>>>                  => case APIC_DM_INIT:
>>>                     apic->pending_events = (1UL << KVM_APIC_INIT) (not kick the AP yet)
>>>                  => case APIC_DM_STARTUP:
>>>                     set_bit(KVM_APIC_SIPI, &apic->pending_events) (not kick the AP yet)
>>>
>>> [2] 2. kvm_cpu_exec()
>>>         => if (cpu->vcpu_dirty):
>>>            => kvm_arch_put_registers
>>>               => kvm_put_vcpu_events
>>>                  KVM: kvm_vcpu_ioctl_x86_set_vcpu_events
>>>                  => clear_bit(KVM_APIC_INIT, &vcpu->arch.apic->pending_events);
>>>                     e.i. pending_events changes from 11b to 10b
>>>                  // end of kvm_vcpu_ioctl_x86_set_vcpu_events
> 
> Qemu is clearly "putting" stale data here.
> 
>>>      Qemu: => after put_registers, cpu->vcpu_dirty = false;
>>>            => kvm_vcpu_ioctl(cpu, KVM_RUN, 0)
>>>               KVM: KVM_RUN
>>>               => schedule() in kvm_vcpu_block() until Qemu's next SIG_IPI/SIGUSR1 signal
>>>               /* But AP(vcpu1)'s mp_state will never change from KVM_MP_STATE_UNINITIALIZED
>>>                  to KVM_MP_STATE_INIT_RECEIVED, even then to KVM_MP_STATE_RUNNABLE without
>>>                  handling INIT inside kvm_apic_accept_events(), considering BSP will never
>>>                  send INIT/SIPI again during smp_scan. Then AP(vcpu1) will never enter
>>>                  non-root mode */
>>>
>>> [3] SeaBIOS: waits CountCPUs == expected_cpus_count and loops forever
>>>      e.i. the AP(vcpu1) stays: EIP=0000fff0 && CS =f000 ffff0000
>>>      and BSP(vcpu0) appears 100%  utilized as it is in a while loop.
> 
>> By the way, this doesn't seem to be a Qemu bug, since calling "info
>> registers -a" is allowed regardless of the vcpu state (including when the VM
>> is in the bootloader). Thus the INIT should not be latched in this case.
> 
> No, this is a Qemu bug.  It is the VMM's responsibility to ensure it doesn't load
> stale data into a vCPU.  There is simply no way for KVM to do the right thing,
> because KVM can't know if userspace _wants_ to clobber events versus when userspace
> is racing, as in this case.
> 
> E.g. the exact same race exists with NMIs.
> 
>    1. kvm_vcpu_ioctl_x86_get_vcpu_events()
>         vcpu->arch.nmi_queued   = 0
>         vcpu->arch.nmi_pending  = 0
>         kvm_vcpu_events.pending = 0
> 
>    2. kvm_inject_nmi()
>         vcpu->arch.nmi_queued   = 1
>         vcpu->arch.nmi_pending  = 0
>         kvm_vcpu_events.pending = 0
> 
>    3. kvm_vcpu_ioctl_x86_set_vcpu_events()
>         vcpu->arch.nmi_queued   = 0 // Moved to nmi_pending by process_nmi()
>         vcpu->arch.nmi_pending  = 0 // Explicitly cleared after process_nmi() when KVM_VCPUEVENT_VALID_NMI_PENDING
>         kvm_vcpu_events.pending = 0 // Stale data
> 
> But for NMI, Qemu avoids clobbering state thinks to a 15+ year old commit that
> specifically avoids clobbering NMI *and SIPI* when not putting "reset" state:
> 
>    commit ea64305139357e89f58fc05ff5d48dc233d44d87
>    Author:     Jan Kiszka <jan.kiszka@siemens.com>
>    AuthorDate: Mon Mar 1 19:10:31 2010 +0100
>    Commit:     Marcelo Tosatti <mtosatti@redhat.com>
>    CommitDate: Thu Mar 4 00:29:30 2010 -0300
> 
>      KVM: x86: Restrict writeback of VCPU state
>      
>      Do not write nmi_pending, sipi_vector, and mpstate unless we at least go
>      through a reset. And TSC as well as KVM wallclocks should only be
>      written on full sync, otherwise we risk to drop some time on state
>      read-modify-write.
> 
>      if (level >= KVM_PUT_RESET_STATE) {  <=========================
>          events.flags |= KVM_VCPUEVENT_VALID_NMI_PENDING;
>          if (env->mp_state == KVM_MP_STATE_SIPI_RECEIVED) {
>              events.flags |= KVM_VCPUEVENT_VALID_SIPI_VECTOR;
>          }
>      }
> 
> Presumably "SMIs" need the same treatment, e.g.
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 6c749d4ee8..f5bc0f9327 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5033,7 +5033,7 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
>   
>       events.sipi_vector = env->sipi_vector;
>   
> -    if (has_msr_smbase) {
> +    if (has_msr_smbase && level >= KVM_PUT_RESET_STATE) {
>           events.flags |= KVM_VCPUEVENT_VALID_SMM;
>           events.smi.smm = !!(env->hflags & HF_SMM_MASK);
>           events.smi.smm_inside_nmi = !!(env->hflags2 & HF2_SMM_INSIDE_NMI_MASK);

I see, this is indeed a feasible solution. I will send a patch to the 
Qemu community then to seek more advises. Thanks for your suggestions.

Have a nice day, thanks a lot
Fei


