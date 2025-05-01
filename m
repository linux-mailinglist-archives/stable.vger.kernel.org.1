Return-Path: <stable+bounces-139413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A60AA6613
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 00:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2187B4A620F
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 22:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F66B211A1E;
	Thu,  1 May 2025 22:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RJFXdTYM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F9620E01E
	for <stable@vger.kernel.org>; Thu,  1 May 2025 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746137694; cv=none; b=BhG7g9HX6xgO2O8MzEkXSlrDPA89pDqplipkHFrGp8lbhX+HzvaoMPyQ1Kf63p4JgEow5hLD3L6h0JHOABWcrbvfxCddVPINkGwGjyyQKbgdlQ3EHvKqo+DXQpFlHzuH6s+l8UZtyQnwA28R0e7SWh7GBgZ2w3c8dfZgU22J0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746137694; c=relaxed/simple;
	bh=akZaj9oNKybRwgy4QmU0OkCcWJC3btGnBKQoTl0rRGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hlmqLLDNnrhCdz2u3JSyHNnY8h1hDj4XyLRUii04grUgJ4qciUccWNsp1FzLoxZZ2Va6XEa2CLPkvqfFuS4iaIVSiK6j0GoRH6dq0Gz2xhAwBB1zm2E4wHhifviJL6vdCz+/bpoyjVWikq8rozMqNeD7nrqtQa7Jg649/Q3kNS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RJFXdTYM; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22c31b55ac6so19530715ad.0
        for <stable@vger.kernel.org>; Thu, 01 May 2025 15:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746137692; x=1746742492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XcYHXC/zLCO2MNqe4Etc9Opwvdj3DRYCSBBh0QjYkao=;
        b=RJFXdTYMxO+NMKQYz692FkIQbSx6/PNETOXN/I5LPvNOZSrMt6apCHDSfe520SNP2H
         okXlyEihIjIIkz/6/aKPJ/rSRRNDf+H5OllOGQ5+tk8Yq9O8Z2X1DifN1F1XDUPLwd8o
         VF6yw4IOltH6MrFqtS1Tz4Bc3d4zuCD12gI7ynA3guBTmcK6dBgdlO8o/IBgks18iA2G
         L4zUKs/3TdDyUAOUp58ZSfWFL9qAyAjBYAuzVkSyw0ObKWJftaV1zn+HQaHRH+xJxeDZ
         REJsRHTG/RZw9vKGigkr2MmsP8aH0IB3aJrWUtPNXZ0htihiPJVdQUQirXGfbyf0TP9X
         mq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746137692; x=1746742492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XcYHXC/zLCO2MNqe4Etc9Opwvdj3DRYCSBBh0QjYkao=;
        b=Z6BSdwQo8fvp5okbyq6eocpN3V3pR3vLyfX0iIQdb1U5mZU/M1/EUjv/q2FJQO2jyg
         HgigoLIcOH/r4NuqYFzos5uJFJ6OaxJNZf45oJ7SpksmCX7sJErxxePriQgPKi9x1f6j
         ZYkzvCHknPjS1UA5k3m/5798dtBOuBGSPDYDt7RYauht9TdJdzl21+SZ4wM6mvQaa4cB
         aSluYdYGB+QQ/ApxPoVOpCXoGH+lrkd6Wq+VK1ZZZ0/SDIB3xmcPOr3OcWzvJZ8q9IBH
         Yh3uWxMHfp7RDoJANuOQGajBm99Nxr71q9AkTYOj8iCVYm3ENoO5+FRIkHH+StPcqsNN
         xS6w==
X-Gm-Message-State: AOJu0Yx/X7NITewAEF922f2xwPgVaGdFrHtBJJ4MsHGBHHgVKGBbw/Pn
	dnI8smClKzEXH0lsQXqMamJNkeJut58/9ihVtZ3Ux6kKui5aBYAVpd/7SovXq2F1PgTCQWik6UZ
	1dA==
X-Google-Smtp-Source: AGHT+IHc7Wy9zF+dKc0emCQeTyXjeg6W4TpzmP9Sm4y/fVX8PStTbnrmy17g0yro6qS4H/t7Ebp343mv1p4=
X-Received: from plrt7.prod.google.com ([2002:a17:902:b207:b0:223:fab5:e761])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3bae:b0:21f:35fd:1b6c
 with SMTP id d9443c01a7336-22e103d1592mr9089265ad.45.1746137692115; Thu, 01
 May 2025 15:14:52 -0700 (PDT)
Date: Thu, 1 May 2025 15:14:50 -0700
In-Reply-To: <20250501171459.1263002-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025021812-candied-hamper-7f08@gregkh> <20250501171459.1263002-1-jthoughton@google.com>
Message-ID: <aBPyWkALR394pcwZ@google.com>
Subject: Re: [PATCH 6.1.y] KVM: x86: Load DR6 with guest value only before
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

