Return-Path: <stable+bounces-177827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB60B45B7E
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 17:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B92D482781
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 15:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B452F7AC2;
	Fri,  5 Sep 2025 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CyJrJgKg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF542F7AB4
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084378; cv=none; b=QhNJIR7m0HNO/rtycXUMGGrkbmIbsnk/xTm/zcCjepX8U0hgOfPYlcKzN7ffB4PKxzN8QEoSmQGJBUuyxktJ+V+EpOrLTqfIEuHmFwC+NUQukRYAc5rFXf6+GkyZwtJE9Z7CEHKUCE1on/Wylst6rtc62xW4cfmngK5vbKCnSGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084378; c=relaxed/simple;
	bh=XcqHYkHT4m5vC0R1cBvzFMNka7TCqqEBUzUASjSkIKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XE/mRsgjv0Z5EcDOJnlDUZzbIRGI8RjRSfgBFDBTeB6xmcFVeFn67dyy8qBtcKHdqtA3shJ/46Mvi1hQbnTiXxb/cCx+fCoVopk10MO2gZTfoiK3r68YmAovZPgMXmVZQYUY63uJElq7UOPxgKZwOBIeGnpxQT3bKw0VFXYiP0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CyJrJgKg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24457f581aeso22034475ad.0
        for <stable@vger.kernel.org>; Fri, 05 Sep 2025 07:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757084376; x=1757689176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxJY233Uqqg21CAqUEiMyudhk5JYPYhTbvvi/CIfNGk=;
        b=CyJrJgKgITVtKBLkB+Pug6B9MgDCjE+0o4IZJ1igdNAF4bxNOxzF4mOGGWM+/n/e38
         5812v/pRD7aO72ZwTFkL00p/8mXQi1stkLo/7Um+W7/Xl/aE3fx8KG5Il53M6mlaHZEd
         ZIaoZDo5XAWgO9wL7ITV4QFoxcZ3b2GScRNqn48bh6EuBFt2ZwE+iZOdNTqPcq0GP+Q0
         vcTWhkKzl+7CEUe/+0+rzU8f1la+a2yqdT4Tl6BVkIKYzDZeLZ7THOBv8SAdtUQokpMo
         /H4me9pG78jQ+e8rwp6KshX8Lgdr8o1Q0wOS45ZH3l9zgpFNRaLXWlw5MY6SVjhMyVTN
         Q5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757084376; x=1757689176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxJY233Uqqg21CAqUEiMyudhk5JYPYhTbvvi/CIfNGk=;
        b=iC29kxT6JN+NGT6Czwnl1pdZ3ueCO770+bSz0FdXtTubL9WKvM5HBINR3Jt1sJPoqR
         dZv0MIMMn/v2MLYULCQZWVBnO0wCwFhOOn5/9fpGnMN1gqZIZ+ifH+LtmxbPeVv5MK0N
         hEsTCtbZ9R3Axqmk4bZ3pUX1iNX923YEryVa67JCwNnUogGN6gr7YmYSBDgk4elfSipJ
         lMTVlFxlH4qgEtCAzZdSDJkcJOdaqAYeejSB7k/VCez6bcH+OTi6XJ16CnM2jO6XAcu+
         Yzj0AAe41edq2Gh6svlfu6PSy/va9gQA5EIpilElktT945WEcYpgINH9b49n51cLC7Vg
         HqHA==
X-Forwarded-Encrypted: i=1; AJvYcCUuNdPh4KXIzZhQcxC8PKMh7eIU3QPzizfzmU3bUFXgcWt6Le1IiZKqLxsZyqxZ9liZsOpTwJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4P98wYSQ4+C7zooHEci99b6u11kCG+moUPLblGtSh7lZ5GDiY
	tP1nLAKBF30bKQwceK32nPxQeCFzlhXAP6uzBfKLgn/WqCUSTIfuiWu2gbSVTntXXLk=
X-Gm-Gg: ASbGnctmJrJCBivEyGPJZ54yLu5QvH5zfodw3XkZwoA1OTDA/0dH8OYROOQz55ljHrZ
	p3h958Zo2Yodda0MXlxTnc79eTlRhgSoR/6cgSxcGnfOc/Lp8h+FlAT6IsObZv2ZaCRCMqjlbPM
	l/HP8mMDuxyvCkpOKI1S8mIqME1RHr8MHPeE1E3gJKMvkhSKQvZ8RM8JZuTmH6RARFm1xeX5VAe
	yzV2155sn8vMsiYbl3vSs0gE0vbmnUjG4RiyzHdso6cesz6NEfchlcSwvOClAOLfwUJhFkPz9nq
	iOgWUNN809rK+FjDqnFl9glVzzdCT11LcmzqX+4RgSfpeRwC8C58mJ7No5uO4gwDvAn6m1Rn6Ge
	gf9jcV6q37mDoRwBxIABgkB5jqX6BoBl7X8MNfVYXyoF8Qe1K5roDmLwmFop0xPg=
X-Google-Smtp-Source: AGHT+IF0oshhaCSxRIfpasEwtpeGFZadc99IPAvw/eelHrSh1OB4Ilh5zEeIUkPqAnpO5BxcnXM/Lg==
X-Received: by 2002:a17:903:2309:b0:248:96f3:408c with SMTP id d9443c01a7336-24944b1cb74mr370934945ad.31.1757084376131;
        Fri, 05 Sep 2025 07:59:36 -0700 (PDT)
Received: from [10.4.109.2] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd0736ba7sm19340638a12.12.2025.09.05.07.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 07:59:35 -0700 (PDT)
Message-ID: <d686f056-180c-4a22-a359-81eadb062629@bytedance.com>
Date: Fri, 5 Sep 2025 22:59:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] KVM: x86: Latch INITs only in specific CPU
 states in KVM_SET_VCPU_EVENTS
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, liran.alon@oracle.com, hpa@zytor.com,
 wanpeng.li@hotmail.com, kvm@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250827152754.12481-1-lifei.shirley@bytedance.com>
 <aK8r11trXDjBnRON@google.com>
 <CABgObfYqVTK3uB00pAyZAdX=Vx1Xx_M0MOwUzm+D1C04mrVfig@mail.gmail.com>
 <f904b674-98ba-4e13-a64c-fd30b6ac4a2e@bytedance.com>
 <CABgObfb4ocYcaZixoPD_VZL5Z_SieTGJW3GBCFB-_LuOH5Ut2g@mail.gmail.com>
Content-Language: en-US
From: Fei Li <lifei.shirley@bytedance.com>
In-Reply-To: <CABgObfb4ocYcaZixoPD_VZL5Z_SieTGJW3GBCFB-_LuOH5Ut2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/29/25 12:44 AM, Paolo Bonzini wrote:
> On Thu, Aug 28, 2025 at 5:13 PM Fei Li <lifei.shirley@bytedance.com> wrote:
>> Actually this is a bug triggered by one monitor tool in our production
>> environment. This monitor executes 'info registers -a' hmp at a fixed
>> frequency, even during VM startup process, which makes some AP stay in
>> KVM_MP_STATE_UNINITIALIZED forever. But this race only occurs with
>> extremely low probability, about 1~2 VM hangs per week.
>>
>> Considering other emulators, like cloud-hypervisor and firecracker maybe
>> also have similar potential race issues, I think KVM had better do some
>> handling. But anyway, I will check Qemu code to avoid such race. Thanks
>> for both of your comments. 🙂
> If you can check whether other emulators invoke KVM_SET_VCPU_EVENTS in
> similar cases, that of course would help understanding the situation
> better.
>
> In QEMU, it is possible to delay KVM_GET_VCPU_EVENTS until after all
> vCPUs have halted.
>
> Paolo
>
Hi Paolo and Sean,


Sorry for the late response, I have been a little busy with other things 
recently. The complete calling processes for the bad case are as follows:

`info registers -a` hmp per 2ms[1]      AP(vcpu1) thread[2]              
     BSP(vcpu0) send INIT/SIPI[3]

                                  [2]
                                  KVM: KVM_RUN and then
                           schedule() in kvm_vcpu_block() loop

[1]
for each cpu: cpu_synchronize_state
if !qemu_thread_is_self()
1. insert to cpu->work_list, and handle asynchronously
2. then kick the AP(vcpu1) by sending SIG_IPI/SIGUSR1 signal

                       [2]
                       KVM: checks signal_pending, breaks loop and 
returns -EINTR
Qemu: break kvm_cpu_exec loop, run
   1. qemu_wait_io_event()
   => process_queued_cpu_work => cpu->work_list.func()
        e.i. do_kvm_cpu_synchronize_state() callback
        => kvm_arch_get_registers
             => kvm_get_mp_state /* KVM: get_mpstate also calls
            kvm_apic_accept_events() to handle INIT and SIPI */
        => cpu->vcpu_dirty = true;
   // end of qemu_wait_io_event

                                   [3]
                                   SeaBIOS: BSP enters non-root mode and 
runs reset_vector() in SeaBIOS.
                                            send INIT and then SIPI by 
writing APIC_ICR during smp_scan
                                   KVM: BSP(vcpu0) exits, then => 
handle_apic_write
                                        => kvm_lapic_reg_write => 
kvm_apic_send_ipi to all APs
                                        => for each AP: 
__apic_accept_irq, e.g. for AP(vcpu1)
                                             => case APIC_DM_INIT: 
apic->pending_events = (1UL << KVM_APIC_INIT)
                                                  (not kick the AP yet)
                                             => case APIC_DM_STARTUP: 
set_bit(KVM_APIC_SIPI, &apic->pending_events)
                                                  (not kick the AP yet)

   [2]
   2. kvm_cpu_exec()
   => if (cpu->vcpu_dirty):
      => kvm_arch_put_registers
         => kvm_put_vcpu_events
                       KVM: kvm_vcpu_ioctl_x86_set_vcpu_events
  => clear_bit(KVM_APIC_INIT, &vcpu->arch.apic->pending_events);
       e.i. pending_events changes from 11b to 10b
  // end of kvm_vcpu_ioctl_x86_set_vcpu_events
Qemu: => after put_registers, cpu->vcpu_dirty = false;
         => kvm_vcpu_ioctl(cpu, KVM_RUN, 0)
                       KVM: KVM_RUN
  => schedule() in kvm_vcpu_block() until Qemu's next SIG_IPI/SIGUSR1 signal
  /* But AP(vcpu1)'s mp_state will never change from 
KVM_MP_STATE_UNINITIALIZED
    to KVM_MP_STATE_INIT_RECEIVED, even then to KVM_MP_STATE_RUNNABLE
without handling INIT inside kvm_apic_accept_events(), considering BSP 
will never
    send INIT/SIPI again during smp_scan. Then AP(vcpu1) will never enter
    non-root mode */

                                   [3]
                                   SeaBIOS: waits CountCPUs == 
expected_cpus_count and loops forever
                                   e.i. the AP(vcpu1) stays: 
EIP=0000fff0 && CS =f000 ffff0000
                                         and BSP(vcpu0) appears 100% 
utilized as it is in a while loop.

As for other emulators (like cloud-hypervisor and firecracker), there is 
no interactive command like 'info registers -a'.
But sorry again that I haven't had time to check code to confirm whether 
they invoke KVM_SET_VCPU_EVENTS in similar cases, maybe later. :)


Have a nice day, thanks
Fei


