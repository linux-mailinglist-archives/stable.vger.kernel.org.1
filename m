Return-Path: <stable+bounces-176632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C40B3A3D1
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 17:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2CC1C2585D
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 15:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D9825A64C;
	Thu, 28 Aug 2025 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AcedoJ/b"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05963259CBC
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394014; cv=none; b=C1NfFXyp6wDKNkdlnAC4ipn2aMuzklaCzUX5rULNa1lIW8lCXQXM+ODheG0myxrVmz3XGmcmZmW5ZqH5o8BVGGVZhhMtALmzoIPK/NppRcoH7JTXGEQEkNikijl5FAbLeC9FotZFoTcvOTb63GPh9UeDaClaPslGem1KqBxXAr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394014; c=relaxed/simple;
	bh=w2+P6LuZxNLocswuyLR6jCH7IucTlMDmyCyEUgbj0c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8e+1LrvMjThUHhy4J4zSL8iLKQFWYO4HXq5TFJ6jbDTMWm5nnOwzn2hAs6Vg7b6LZnAUZB+zzEgAeJa+hh2lA8V5NBkWm94Mc8r36vyuuAlNtXBjs4lZLNRFUMIj9vY9w5rwxi4i9kUU6BL1eg8bMlcbPC1ZKBrPQ5ewaPyXKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AcedoJ/b; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-323266cdf64so937314a91.0
        for <stable@vger.kernel.org>; Thu, 28 Aug 2025 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756394011; x=1756998811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Ayg5INEbzaZhjUJB+PggkJhdT02eVoUoex1wYs37Eg=;
        b=AcedoJ/btH/aEleVwBujrhBs/HJqH1ZYoDgutiE+A7CXRZIXuFNDRCUocXgCNDKAnh
         SyqOAuxCY2UEO4nTXb689MUg2dWQFFxK4P504Vn8rZmRJ3ctm2wEDm49R01G16X0G2nL
         wMk0Iio/Qr7yvcrWqTVHxSmxE4wTkD+jwaYvFFXTj20i5F4a8CsVoPzurk7wxCRMxqlz
         u5jjx9JpuTAszdj8FAVE80JDq6TFg4KdoAnVhZTkngS3HVYRRfB9rNR6GxRqzv9SjNfG
         +heP4jprP8DMm6mHD7MCd1sK6+wDn23I0apH2Ms2YSVicbsEn/B+IpmD4k1AIm6fFJ4M
         xKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756394011; x=1756998811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ayg5INEbzaZhjUJB+PggkJhdT02eVoUoex1wYs37Eg=;
        b=FMB3DyMBm15cxhWA0veJbX9VyX/XvGK7MwGCr3ahmMsF4bHwem22Rd1sJD6gBKfOzX
         2rvgpBBEuvuynd03OR+ASFILIfojUxaSI2sfn8HITq8n12sbbB+cALzFSxcpcpNrdFh+
         yZ32eDxkAuUMMr2IaqrOrRdMpk6NiimVwiRtEhcoai9d8DlpA1WFb7th6kXhefwMH+Uw
         V/j4d8wIJe5So44/eudVXDSjGf0ni8PuGnBvTdKnihEm4DBqL4g0Z2bNgw6l4+KS0aWO
         OEjWzO5Rb8FGBVQwUKNt2scZJ9GzaVr5NMBg2GQId+AyzjmEoZVzB1HqdXFOELAhQ+XT
         XVRA==
X-Forwarded-Encrypted: i=1; AJvYcCX4y5ozt4uOBJ8O3dRbWb+oXtiw6DC+Urqex/x6OGZzNelq4e5VHAnR6FLhkqyqwZEZiDoJUtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWGDB9DP9HRedoSfPL05EhB7d64N627ro+Fp1fedFiAugoN7Q/
	Bt+pxxka13CJHW52cN6LWlaMI/K0hJK5KFOvJ2ubeF5QD2RwvTT8ufdUFYc823wSKOA=
X-Gm-Gg: ASbGnctheD6T2gN6ziykOK9feIiBN9upAXgOI8fV14Xw0DULNztLM1lanYsVkaZTHTG
	rL2Q3aVt1kZlXjIv17VOBaWfRe393CfNGjYsCaFtpwA0A4pJyIWOwmUZu2edsSi4clT6+TtfNer
	V9dim5iQv79X/hxB+4zvFTp3n5xJk1VLVSV+vvyaqeFXl2LCQ1y214Nn/JQyCrYLEqXHS3crZdP
	4JTTFwCL1897qBISR6l+NziY85rO0k1Sb9YT7IjDEEpML6dscb26H7UDfFkUFxWhtMjJ1W7wKCE
	c7ynb0fmeGVfHlcfhHy4b/c1izv4hblqLlkSSN9wXfaeMmaz58KGg80YrZN2F0D8QTCLU/ys4nH
	z9HYI59MubU7Q5CySScm2iqi8nVRm5B8N4A16u5I+HlfYfOdeiR3eFY6blAnn9vaV0Q==
X-Google-Smtp-Source: AGHT+IFeBD8+FsFOIfhdVfCuBI9Q22Evk4whBnaoZs4OTHBuqiV6OsCzuYJCKNJmIqpVWno7FbQ4rw==
X-Received: by 2002:a17:90b:2ccf:b0:312:959:dc42 with SMTP id 98e67ed59e1d1-32515ef6f25mr25874725a91.11.1756394011030;
        Thu, 28 Aug 2025 08:13:31 -0700 (PDT)
Received: from [10.4.109.226] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f5a0bf9sm5578927a91.13.2025.08.28.08.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 08:13:30 -0700 (PDT)
Message-ID: <f904b674-98ba-4e13-a64c-fd30b6ac4a2e@bytedance.com>
Date: Thu, 28 Aug 2025 23:13:25 +0800
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
Content-Language: en-US
From: Fei Li <lifei.shirley@bytedance.com>
In-Reply-To: <CABgObfYqVTK3uB00pAyZAdX=Vx1Xx_M0MOwUzm+D1C04mrVfig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/28/25 12:08 AM, Paolo Bonzini wrote:
> On Wed, Aug 27, 2025 at 6:01 PM Sean Christopherson <seanjc@google.com> wrote:
>> On Wed, Aug 27, 2025, Fei Li wrote:
>>> Commit ff90afa75573 ("KVM: x86: Evaluate latched_init in
>>> KVM_SET_VCPU_EVENTS when vCPU not in SMM") changes KVM_SET_VCPU_EVENTS
>>> handler to set pending LAPIC INIT event regardless of if vCPU is in
>>> SMM mode or not.
>>>
>>> However, latch INIT without checking CPU state exists race condition,
>>> which causes the loss of INIT event. This is fatal during the VM
>>> startup process because it will cause some AP to never switch to
>>> non-root mode. Just as commit f4ef19108608 ("KVM: X86: Fix loss of
>>> pending INIT due to race") said:
>>>        BSP                          AP
>>>                       kvm_vcpu_ioctl_x86_get_vcpu_events
>>>                         events->smi.latched_init = 0
>>>
>>>                       kvm_vcpu_block
>>>                         kvm_vcpu_check_block
>>>                           schedule
>>>
>>> send INIT to AP
>>>                       kvm_vcpu_ioctl_x86_set_vcpu_events
>>>                       (e.g. `info registers -a` when VM starts/reboots)
>>>                         if (events->smi.latched_init == 0)
>>>                           clear INIT in pending_events
>> This is a QEMU bug, no?
> I think I agree.
Actually this is a bug triggered by one monitor tool in our production 
environment. This monitor executes 'info registers -a' hmp at a fixed 
frequency, even during VM startup process, which makes some AP stay in 
KVM_MP_STATE_UNINITIALIZED forever. But thisrace only occurs with 
extremely low probability, about 1~2 VM hangs per week.

Considering other emulators, like cloud-hypervisor and firecracker maybe 
also have similar potential race issues, I think KVM had better do some 
handling. But anyway, I will check Qemu code to avoid such race. Thanks 
for both of your comments. 🙂

Have a nice day, thanks
Fei
>
>> IIUC, it's invoking kvm_vcpu_ioctl_x86_set_vcpu_events()
>> with stale data.
> More precisely, it's not expecting other vCPUs to change the pending
> events asynchronously.
Yes, will sort out a more complete calling process later.
>
>> I'm also a bit confused as to how QEMU is even gaining control
>> of the vCPU to emit KVM_SET_VCPU_EVENTS if the vCPU is in
>> kvm_vcpu_block().
> With a signal. :)
>
> Paolo
>

