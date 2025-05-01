Return-Path: <stable+bounces-139414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A11FAA6617
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 00:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9504A6293
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 22:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FAB2620F1;
	Thu,  1 May 2025 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PkIamYCr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EDB1A38E1
	for <stable@vger.kernel.org>; Thu,  1 May 2025 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746137746; cv=none; b=nXyLVZFD+Ke61OXO90sEjiGlfSn2lwDWeqEdGZbfBVpGGJnyJah4zpDNqRPVWk7GzX5e5UTbdkz4A2KwA+Ru8+rD1PoEvkv0nr+ueSV+S+dUSh4g0wNTzoeKhDJ9TegFdh0AVf9TDzIALf2pfeAp9UvL91Z+xmunx17rUGt3yTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746137746; c=relaxed/simple;
	bh=akZaj9oNKybRwgy4QmU0OkCcWJC3btGnBKQoTl0rRGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BJxWBz7XGUF8R7nwoNp+YpFbz0JPqcWVkCTR9JnZquhi5JPGIWDLj7S1HcOKgjgVLJXGITMw1CgvKJzn07k0QZgNS5K3izkmQGARBtEu0u4FTz2y0NYP730SzL3fHMg2crDN3OcA4DzYXgZIfEXtbCOGuEi77K4cejRoYZICqAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PkIamYCr; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b00e4358a34so816402a12.0
        for <stable@vger.kernel.org>; Thu, 01 May 2025 15:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746137743; x=1746742543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XcYHXC/zLCO2MNqe4Etc9Opwvdj3DRYCSBBh0QjYkao=;
        b=PkIamYCrXD5h/r/DFoE2rZCdFYHKkqctXotqRcTTTJW79ODlJGTiIrF1K9DWeF2Vhm
         y4iodYXtWManV1XrL8+2wpxCkBp1tam61mmulgG0G0gH0zzMdg+isU2Po9I7XcDLnVYx
         Uvqcw1yYGuPZxHtqehnAO3MIZkHnigqP3gn/qIz2T/E6LgsXS5eUfspRngB++R2uYYAB
         y6vm/3oeiM0R+BE8RkIctPwyLtaym9ulw/uC8ayFc7CWWcPegcmKSMuBszYK9D1a6YyJ
         Apdaw/B0SIcQFLulpRC/PQqrIFGUbNaNmvlTL0KdcqZ16hiGx7C/e7Us2VOOkeHpI60L
         2XKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746137743; x=1746742543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XcYHXC/zLCO2MNqe4Etc9Opwvdj3DRYCSBBh0QjYkao=;
        b=I8X87wKo2UshzQFtTViBOoZ+HUeNhhbF69VjEbGRaAxBFz901FozLTP7RlnuanHuIC
         S2A0hKmT6hBZeqrnwSs7R85TcSZz/KIjqofLouxTPx6jxwgfOo1m176eE5kObds0Q+Sd
         Tt/Ufu7nFlG9Aitg3nlSuYqIyCCo6EK2idZQANBenL+6UCZnQJo9YHTHV1mcx2D1AmgS
         jWMpxhEUKhD+XO0YclgpsfFUvdTis23XeHMAiMKIjKDUf1moL+nNtG4n+vs9Lb9nBeZ5
         oV1c6NRt+U0qsFQ/eZpbVj+QxgOhIN0S9KbjI8vArf6RSknbSv2+fJ7J5mZoEU3c8j+s
         SklQ==
X-Gm-Message-State: AOJu0YzgLtM8azfLjL9jdqBDKlgK3SUNasB1c20Ly8mQQuVp3EPv1aa2
	5+ZRMJe7fMUSu7TlAYbJZBOj+9n/38C3YWiJ4edGgJczoQQ78vT2jrTJ10wIqGHSnf8e0ddYPjg
	8iA==
X-Google-Smtp-Source: AGHT+IFgY+dThCFtWw2XUt/jKenPE0prADVtUt1qrW21XapQDgl7yXCnkQUSSKDcx/IOqYRBQkYXlFR+FjU=
X-Received: from pjbpw4.prod.google.com ([2002:a17:90b:2784:b0:2f8:49ad:406c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5244:b0:309:e195:59d4
 with SMTP id 98e67ed59e1d1-30a4e5b1cefmr1066795a91.12.1746137742728; Thu, 01
 May 2025 15:15:42 -0700 (PDT)
Date: Thu, 1 May 2025 15:15:41 -0700
In-Reply-To: <20250501171226.1257503-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025021809-census-mammal-224b@gregkh> <20250501171226.1257503-1-jthoughton@google.com>
Message-ID: <aBPyjUAaijTthCfl@google.com>
Subject: Re: [PATCH 6.6.y] KVM: x86: Load DR6 with guest value only before
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

