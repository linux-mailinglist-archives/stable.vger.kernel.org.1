Return-Path: <stable+bounces-169614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B5DB26EAC
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 20:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5E5A2680B
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 18:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9164678F2B;
	Thu, 14 Aug 2025 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gDHBxdtZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22C84315F
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195329; cv=none; b=UR204IUPBU0tq9jBKgvyRB6QaaC/sdsScQSIMgh7hH1UgWQ8TcuLDs3vyR4tm2lSH6fnNJgKuByyQrlYVTmEEX0cVy9r7hfen63bRTwAuFIrKBY+c6J3nrjR3HZeAnnTWSHKkLjy/wRWPE7ClndIDoyrGH5YGHWWxF5MEhBNyJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195329; c=relaxed/simple;
	bh=Xdtl1v1ITtelsyZoeMV3BMVqYSF7aKmV+5vzygTwCM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YwTzu7irp+ro41ukBxPgul0e4aP4Ja9p5vu86DIkVvNpoz13867TubHokPn0eTUheHK5qfMLBhlWsMFYMxqpXmYXOxhv/cJdT9EOyXaRo/xjmtEdCWnonDNsi5x/ow7NppWv+saetrLQNbTRSlZd2aCI8E/Wz9f7GXptqklbe8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gDHBxdtZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244581950a1so14293075ad.2
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755195327; x=1755800127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8WGvXs/xMgvv+thH3QWqQ2BYxve2fSDtOYFqpkEYDaE=;
        b=gDHBxdtZn0JNwPE/4VfIZFQc1s9ToPa3qQN5kI6CHcC3AKjneooO/poHhj2OD5MD34
         ye9B+KjIFQw/4F3j5tkNBsA92+gHcw5qLdQSBtgi359hNS2U2q6M2u5hfmtf9RIn0Sj/
         RdiNt+4VeTcQebszgsObhMs35BmZFkUSrtcr+7fAPlrdTaAWAdoeJFEq0hKR9JzHijvx
         +zaARYJ+yx0lMbyVyF/A2v5iCRS/SpqW/PeuqbF+LfIFn8xX1QLhFH3e3FMnUifbyw0r
         CXiRjY3LZEuoEfB/Ivtb5VD6KzCKlz8oP4y4DEG2VPSh2M/YlDfwgJcXdjvwiyWIoljn
         haTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755195327; x=1755800127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WGvXs/xMgvv+thH3QWqQ2BYxve2fSDtOYFqpkEYDaE=;
        b=MXJRKdl1uDWZVC9T+uNeTmyoaRbqWsZoGrp8BIdDU24sVkiPfgNCfMVXMo69GwfBOG
         Cy0KOiJGqfptblQbM7Qbi7y8P3RXjQypMIGurKiXMNaqhp+maL3UfFur4Rk2wEZll0HR
         JAXxt7qGlxnw3Z/XagQ3pzlzEMh8tgAqX18Ll1jSUQniMOYdj4h+4O3mOI/d9X5sCXww
         67HUWwN4h2+wsU0UrFKFODWWl25TIpTjaTPXP/BBVk2kbirRC3eHY8e2ukSmWDwadAaF
         Mza0bIkayIUGsCxm6cqwFSBROd9RGZvAOp0BJaVCQvvFW4yhJskfi/Ifa2uMwH8OQ4y/
         3RSw==
X-Gm-Message-State: AOJu0YzMWUmOehnDFm0U70dcM3/cjzBDiAjXEzXpP6ZWJcccPX0v4reY
	lX/dxIjgjCM361XxCyViLohYPO/6WgbqERiRT3ry5AamBc1zU3NnsuqMAmTyZPqrfYc6lTNiNWf
	DK9PbcQ==
X-Google-Smtp-Source: AGHT+IEUseMsFBkkBEtRrkC1tqxPVOaqG9gM+cycTYVGaEeb1nu8+amQeGn9rMckfJwddJrZZ04i72zo3bo=
X-Received: from pjbqc5.prod.google.com ([2002:a17:90b:2885:b0:31c:4a51:8b75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebc8:b0:23d:fa76:5c3b
 with SMTP id d9443c01a7336-244584f4d9bmr54900305ad.22.1755195327289; Thu, 14
 Aug 2025 11:15:27 -0700 (PDT)
Date: Thu, 14 Aug 2025 11:15:26 -0700
In-Reply-To: <20250814161212.2107674-6-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081231-vengeful-creasing-d789@gregkh> <20250814161212.2107674-1-sashal@kernel.org>
 <20250814161212.2107674-6-sashal@kernel.org>
Message-ID: <aJ4nvh4p-S4fCIpQ@google.com>
Subject: Re: [PATCH 6.16.y 6/6] KVM: VMX: Preserve host's DEBUGCTLMSR_FREEZE_IN_SMM
 while running the guest
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 14, 2025, Sasha Levin wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> [ Upstream commit 6b1dd26544d045f6a79e8c73572c0c0db3ef3c1a ]
> 
> Set/clear DEBUGCTLMSR_FREEZE_IN_SMM in GUEST_IA32_DEBUGCTL based on the
> host's pre-VM-Enter value, i.e. preserve the host's FREEZE_IN_SMM setting
> while running the guest.  When running with the "default treatment of SMIs"
> in effect (the only mode KVM supports), SMIs do not generate a VM-Exit that
> is visible to host (non-SMM) software, and instead transitions directly
> from VMX non-root to SMM.  And critically, DEBUGCTL isn't context switched
> by hardware on SMI or RSM, i.e. SMM will run with whatever value was
> resident in hardware at the time of the SMI.
> 
> Failure to preserve FREEZE_IN_SMM results in the PMU unexpectedly counting
> events while the CPU is executing in SMM, which can pollute profiling and
> potentially leak information into the guest.
> 
> Check for changes in FREEZE_IN_SMM prior to every entry into KVM's inner
> run loop, as the bit can be toggled in IRQ context via IPI callback (SMP
> function call), by way of /sys/devices/cpu/freeze_on_smi.
> 
> Add a field in kvm_x86_ops to communicate which DEBUGCTL bits need to be
> preserved, as FREEZE_IN_SMM is only supported and defined for Intel CPUs,
> i.e. explicitly checking FREEZE_IN_SMM in common x86 is at best weird, and
> at worst could lead to undesirable behavior in the future if AMD CPUs ever
> happened to pick up a collision with the bit.
> 
> Exempt TDX vCPUs, i.e. protected guests, from the check, as the TDX Module
> owns and controls GUEST_IA32_DEBUGCTL.
> 
> WARN in SVM if KVM_RUN_LOAD_DEBUGCTL is set, mostly to document that the
> lack of handling isn't a KVM bug (TDX already WARNs on any run_flag).
> 
> Lastly, explicitly reload GUEST_IA32_DEBUGCTL on a VM-Fail that is missed
> by KVM but detected by hardware, i.e. in nested_vmx_restore_host_state().
> Doing so avoids the need to track host_debugctl on a per-VMCS basis, as
> GUEST_IA32_DEBUGCTL is unconditionally written by prepare_vmcs02() and
> load_vmcs12_host_state().  For the VM-Fail case, even though KVM won't
> have actually entered the guest, vcpu_enter_guest() will have run with
> vmcs02 active and thus could result in vmcs01 being run with a stale value.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Link: https://lore.kernel.org/r/20250610232010.162191-9-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

