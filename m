Return-Path: <stable+bounces-200035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1A6CA4416
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 16:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B76BC30E0B52
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 15:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355C92D1303;
	Thu,  4 Dec 2025 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBvdOx4O"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E1719E839
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764861767; cv=none; b=FFuE6+Q1T6+xNgw9qHg7VL09+hlpWtw1yJSB+7fw+7IacenVsWO9LBdmbiEdApyCUuB9mDRUKb0qWBzDI/TQhRADmyBMaTxF5We2Bac5T/nSL7Srupo/C5oUlGrvIXIjI0hbDOKFCDkkOrGYsQ6QOskfIkH03+d562wSN0Ds8PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764861767; c=relaxed/simple;
	bh=6kinwtoMrSikR6J/HYxCVBBndy56gwZbMj2SXFHTGXY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N86V4A7juYSOF959QAjvc63ozJPgBIDB+lvvPWMGpQDaDtZkteo2hqRUe3Yrzrdou7DbFN7zy4XRjjQ2yVsP/n4ts8p2ytBZ4aaLgpXPiPcbmXWJWE/4uiUWtlkw05s/G044+KWyCOru1dXr5GIyyWh6gJS3c6ahdQEUenS3SVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fBvdOx4O; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297f587dc2eso26267945ad.2
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 07:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764861763; x=1765466563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cvG93Phi2gJpAwnpQNJdys+CWwc4XuSm9VwBEo6yBsw=;
        b=fBvdOx4OQYiwRuxtlG/qtauUesSFNmfb0lFmth3bAY4gFwPdIrZb6bwKYfMh1WeFIP
         n4SYYM0XnA4HTxwj4jvO8OB8TzgwgwErDzPEEkbCbKVjyx9CY2Ut3mDejIjXvgPUEsW7
         BaMANtT1TSi4+MOiKSU9O19gPMobKvu8Q4HKKYulU9Y1BQNr58ZzzJrmbzBhq/bBRctV
         fkx7TqHGzRu4kusAr/QIhni5BbfZrEzuWkO7lP7SVsx0+M1AAQujbSFTQ5YICwsmzzkB
         l6L3bB4czYF6Lvk7AKmJ8GkHQMBfOplrFwNB/4BUMnvzycK4NCLjbiJVXIH30ZZQDqnI
         KJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764861763; x=1765466563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cvG93Phi2gJpAwnpQNJdys+CWwc4XuSm9VwBEo6yBsw=;
        b=WQq+fFBvuKZtRBjGeyaMgrxcup91xY9D66IHNepLFXKkDBfLvHqm1q4QPI9PiXvvWU
         aFpMEAAvZaELHDDB/IoCzlGUrEm8jK2jleURdK31FowDlrIqGScvUkBOZgJ7ZAd+QgWt
         H+LGxjd35GwFgRdTJLwwrIZd6zMyojV2nCs1q4LV+V7Xlc4EhkqQTaKHYvMBAnDhNuz0
         rfquWMdZAXc4SwBDHX7XtvXQjnmodfGykfpaG0nMxNp6q0t74/JTtzrTUUP4GDNkRE1u
         gR2vwUB1sFxYN7Ui+fNLda3ybXMKzJnDyvyR44wNA4UEBztQ/HPrzykhTDk5JjwMd12l
         vIHA==
X-Gm-Message-State: AOJu0Ywj1wgmBOtmpFd+pTFRwR0+zi/MyZb308v3GnfsWbBw93IKb3dL
	BvRvZlZYVqfxak9XEHT1yFg4is6kr8ua6t79LbV87qi3aGPVXPir9wLzaRe4Lm/r4d1DCQRe31s
	fIecOqQ==
X-Google-Smtp-Source: AGHT+IFnpucGHhSNehQFPkWsHAmO38Ss5I2OGhGRDMbUHDMtT0gv7y3OQ/LJrpJxqiBlwHIoaLNEHTGvaTI=
X-Received: from pglg15.prod.google.com ([2002:a63:110f:0:b0:bac:6acd:817f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1251:b0:296:1beb:6776
 with SMTP id d9443c01a7336-29d683e6b2dmr78924315ad.58.1764861762992; Thu, 04
 Dec 2025 07:22:42 -0800 (PST)
Date: Thu, 4 Dec 2025 07:22:41 -0800
In-Reply-To: <20251204081931.14728-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251204081931.14728-1-681739313@139.com>
Message-ID: <aTGnNdBU9_kcrkUs@google.com>
Subject: Re: [PATCH 5.15.y] KVM: x86: Acquire kvm->srcu when handling KVM_SET_VCPU_EVENTS
From: Sean Christopherson <seanjc@google.com>
To: Rajani Kantha <681739313@139.com>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Dec 04, 2025, Rajani Kantha wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> commit 4bcdd831d9d01e0fb64faea50732b59b2ee88da1 upstream.
> 
> Grab kvm->srcu when processing KVM_SET_VCPU_EVENTS, as KVM will forcibly
> leave nested VMX/SVM if SMM mode is being toggled, and leaving nested VMX
> reads guest memory.
> 
> Note, kvm_vcpu_ioctl_x86_set_vcpu_events() can also be called from KVM_RUN
> via sync_regs(), which already holds SRCU.  I.e. trying to precisely use
> kvm_vcpu_srcu_read_lock() around the problematic SMM code would cause
> problems.  Acquiring SRCU isn't all that expensive, so for simplicity,
> grab it unconditionally for KVM_SET_VCPU_EVENTS.
> 
>  =============================
>  WARNING: suspicious RCU usage
>  6.10.0-rc7-332d2c1d713e-next-vm #552 Not tainted
>  -----------------------------
>  include/linux/kvm_host.h:1027 suspicious rcu_dereference_check() usage!
> 
>  other info that might help us debug this:
> 
>  rcu_scheduler_active = 2, debug_locks = 1
>  1 lock held by repro/1071:
>   #0: ffff88811e424430 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0x7d/0x970 [kvm]
> 
>  stack backtrace:
>  CPU: 15 PID: 1071 Comm: repro Not tainted 6.10.0-rc7-332d2c1d713e-next-vm #552
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x7f/0x90
>   lockdep_rcu_suspicious+0x13f/0x1a0
>   kvm_vcpu_gfn_to_memslot+0x168/0x190 [kvm]
>   kvm_vcpu_read_guest+0x3e/0x90 [kvm]
>   nested_vmx_load_msr+0x6b/0x1d0 [kvm_intel]
>   load_vmcs12_host_state+0x432/0xb40 [kvm_intel]
>   vmx_leave_nested+0x30/0x40 [kvm_intel]
>   kvm_vcpu_ioctl_x86_set_vcpu_events+0x15d/0x2b0 [kvm]
>   kvm_arch_vcpu_ioctl+0x1107/0x1750 [kvm]
>   ? mark_held_locks+0x49/0x70
>   ? kvm_vcpu_ioctl+0x7d/0x970 [kvm]
>   ? kvm_vcpu_ioctl+0x497/0x970 [kvm]
>   kvm_vcpu_ioctl+0x497/0x970 [kvm]
>   ? lock_acquire+0xba/0x2d0
>   ? find_held_lock+0x2b/0x80
>   ? do_user_addr_fault+0x40c/0x6f0
>   ? lock_release+0xb7/0x270
>   __x64_sys_ioctl+0x82/0xb0
>   do_syscall_64+0x6c/0x170
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  RIP: 0033:0x7ff11eb1b539
>   </TASK>
> 
> Fixes: f7e570780efc ("KVM: x86: Forcibly leave nested virt when SMM state is toggled")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20240723232055.3643811-1-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [ Based on kernel 5.15 available functions, using srcu_read_lock/srcu_read_unlock instead of
> kvm_vcpu_srcu_read_lock/kvm_vcpu_srcu_read_unlock ]
> Signed-off-by: Rajani Kantha <681739313@139.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

