Return-Path: <stable+bounces-139415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B9CAA661C
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 00:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8459C4FBD
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 22:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889D7264A95;
	Thu,  1 May 2025 22:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="adJUKtPZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1171257443
	for <stable@vger.kernel.org>; Thu,  1 May 2025 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746137843; cv=none; b=VkNJXNv6LPeL0U7xX+w/4FcJ5WZVbdQ17QKd7P3YN52MHxq6ZD5Y+sNmOaVfDbbRUE/AkS1D8Hn83MXnav/SrzWjQ/RLcw5SZVn5Jflw+6PmDxejy2eTUW2gJolkcbJXa8nEeuAziDophuOJt3nXCq0i2FDSK1lUgzO3t1w7TnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746137843; c=relaxed/simple;
	bh=5cHo0Mm20RQqNWKpzAwZmLr2mfVytRTOEY5RW1r0r2I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wp3d+pn3if0+8NU734D2MVHGttx9F/a9Hh0e5CRCIIey8hW9ltLK8O3rR1GzPaMercwPOiAKJAaG3er+SQss2JlvJt9RQJI4H0L1EbeQHNcPJURAowB2DhftcIQeuKkW7qRTLRoPAY1LILDhmQeHGiE25qULQTl/oUUFU4dg2BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=adJUKtPZ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-306b51e30ffso1134491a91.1
        for <stable@vger.kernel.org>; Thu, 01 May 2025 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746137841; x=1746742641; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XcYHXC/zLCO2MNqe4Etc9Opwvdj3DRYCSBBh0QjYkao=;
        b=adJUKtPZwJ887sky9f4JagtptFBsk1y7VpUezFJkeKXBY19R5gcKTtaG3AvkuJxEPU
         b9MEV2y4uuI7kVVaBRDqjiLAzv3cskLXGbwhg9jN/uXB7AF3WmOYF39iya2/4a+MH+Q3
         HMn8k1OzX3KwBUmOMrqXm7h1VRcTX1hsSNOD8ByJW36SkZn+AgheXYvW2mQEgp37ESQq
         Rm/l0uRTeuexNH7YZ2AIxK9L0bym3pwOivTIKz3OV8+UT8I9TpGVI4PriB/C56tai5PD
         v42Cepte2jULT6PE48ykDBdflOWmqSXG3me1Oe0TLJdoX6xubRLqnxmLTK6YPzP9SkxS
         Fj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746137841; x=1746742641;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XcYHXC/zLCO2MNqe4Etc9Opwvdj3DRYCSBBh0QjYkao=;
        b=JA+96kTSepsEWjtX/ml+1OmUCJi+d2cyPbNWVp1TrqxPww2kuJmlY+9GL2gcHigici
         /S+ng3AQhjG94ZEmJQxrwN1OpKUanH8EZ0G4fDYH3ZxxNpBI/8nMGkUg2Mn/T1FWOnV1
         QGgwRIt/AXOEGsf2S6nG4dg1Sm6IO7bFeceevSr0Y9MDyLmk5wDT3cDyV6iMUsZj5t9A
         y0HGIYuF7uo6M1j8xgbwnA5DYL/xUB5t9qLkxltwhfN1Krfdkhow7yiQRb6S1XX7WwUs
         L2wgYj8cd+2nmUp3eMOpGgh6WF2Kk/hZG4F2bgbZSqE5rvzWomxN/NmXDvEZTNBg40WT
         1VFQ==
X-Gm-Message-State: AOJu0Yx5j4h9Q82ex1rkFkPA7vniStIalRlNKbRuZ/eBBeAkpuTYNOrc
	UTfgY83clNSGhHogcAqHDqZVRJE53Got/22Cpsvw+43obfTMtvfFzDgXVk3HQk2bO6YR6BdsBip
	sYA==
X-Google-Smtp-Source: AGHT+IGm9/Pbqn798TrloIGPbY/Ts/OG5rouBU/uXY0vZUfa4ElRDOfnZHdByEkEJ7hHvSlvxzY4qh5sgnE=
X-Received: from pjbqi8.prod.google.com ([2002:a17:90b:2748:b0:301:1ea9:63b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:582e:b0:2ff:6488:e01c
 with SMTP id 98e67ed59e1d1-30a4e67c709mr1147139a91.29.1746137841045; Thu, 01
 May 2025 15:17:21 -0700 (PDT)
Date: Thu, 1 May 2025 15:17:19 -0700
In-Reply-To: <20250501171718.1267642-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025021815-protract-greasily-cdea@gregkh> <20250501171718.1267642-1-jthoughton@google.com>
Message-ID: <aBPy76PPVYIQ9eNA@google.com>
Subject: Re: [PATCH 5.15.y] KVM: x86: Load DR6 with guest value only before
 entering .vcpu_run() loop
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: stable@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, May 01, 2025, James Houghton wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit c2fee09fc167c74a64adb08656cb993ea475197e ]
> 
> Move the conditional loading of hardware DR6 with the guest's DR6 value
> out of the core .vcpu_run() loop to fix a bug where KVM can load hardware
> with a stale vcpu->arch.dr6.
> 
> When the guest accesses a DR and host userspace isn't debugging the guest,
> KVM disables DR interception and loads the guest's values into hardware on
> VM-Enter and saves them on VM-Exit.  This allows the guest to access DRs
> at will, e.g. so that a sequence of DR accesses to configure a breakpoint
> only generates one VM-Exit.
> 
> For DR0-DR3, the logic/behavior is identical between VMX and SVM, and also
> identical between KVM_DEBUGREG_BP_ENABLED (userspace debugging the guest)
> and KVM_DEBUGREG_WONT_EXIT (guest using DRs), and so KVM handles loading
> DR0-DR3 in common code, _outside_ of the core kvm_x86_ops.vcpu_run() loop.
> 
> But for DR6, the guest's value doesn't need to be loaded into hardware for
> KVM_DEBUGREG_BP_ENABLED, and SVM provides a dedicated VMCB field whereas
> VMX requires software to manually load the guest value, and so loading the
> guest's value into DR6 is handled by {svm,vmx}_vcpu_run(), i.e. is done
> _inside_ the core run loop.
> 
> Unfortunately, saving the guest values on VM-Exit is initiated by common
> x86, again outside of the core run loop.  If the guest modifies DR6 (in
> hardware, when DR interception is disabled), and then the next VM-Exit is
> a fastpath VM-Exit, KVM will reload hardware DR6 with vcpu->arch.dr6 and
> clobber the guest's actual value.
> 
> The bug shows up primarily with nested VMX because KVM handles the VMX
> preemption timer in the fastpath, and the window between hardware DR6
> being modified (in guest context) and DR6 being read by guest software is
> orders of magnitude larger in a nested setup.  E.g. in non-nested, the
> VMX preemption timer would need to fire precisely between #DB injection
> and the #DB handler's read of DR6, whereas with a KVM-on-KVM setup, the
> window where hardware DR6 is "dirty" extends all the way from L1 writing
> DR6 to VMRESUME (in L1).

...
 
> Reported-by: John Stultz <jstultz@google.com>
> Closes: https://lkml.kernel.org/r/CANDhNCq5_F3HfFYABqFGCA1bPd_%2BxgNj-iDQhH4tDk%2Bwi8iZZg%40mail.gmail.com
> Fixes: 375e28ffc0cf ("KVM: X86: Set host DR6 only on VMX and for KVM_DEBUGREG_WONT_EXIT")
> Fixes: d67668e9dd76 ("KVM: x86, SVM: isolate vcpu->arch.dr6 from vmcb->save.dr6")
> Cc: stable@vger.kernel.org
> Cc: Jim Mattson <jmattson@google.com>
> Tested-by: John Stultz <jstultz@google.com>
> Link: https://lore.kernel.org/r/20250125011833.3644371-1-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [jth: Handled conflicts with kvm_x86_ops reshuffle]
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

