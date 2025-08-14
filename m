Return-Path: <stable+bounces-169612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74337B26EAA
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 20:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C023568068
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 18:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A6821C176;
	Thu, 14 Aug 2025 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bb2nyo3d"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DE420C029
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195306; cv=none; b=NwdRAegudUYjHJJlwT7hzXiqJTT4B34kRv93+dfmaIlccqIYEWTvVLXC/ZJTtlDPIkIb/fJ/QkcG3M0RiRpyRUEv2M+wSBR9+2syGOMYKpekPs8CiqCJgdEDLtjLhRg5pomt3tgQqK1cZ+T9REv1C+jNhZchFwFX21AtRekKpdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195306; c=relaxed/simple;
	bh=iUu55Xcevt2aaE9t08V5rgjK4CzFKaPtrTubHnIUY4k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ibjGixTKDLKkOhc13ZuhjhVWyef3jNIsCszDhn0X2tw9OFaxkV2Gj7uLtMY5yyHnbrp/szCy7ozMv9gc+Zd5OCul2z1nfk/s/NxIg58hfITti/JhqEg6NKJrMNaR2eoxStIccQARRzI+un6YbrvK4muAf5FCmKx/FsvKeEyVl/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bb2nyo3d; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326e017eeso1286987a91.3
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 11:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755195305; x=1755800105; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FUd6PoN+c5hdmQ2iHQjtxlrpojdsuimTu6wnku27ak0=;
        b=bb2nyo3dDbVgQPRJbJRr1Zm6CeWGOrh66aFI+aztjvKUEKnWrf+wzEwpDLJa3qJatS
         riFocLPoRljmGKfOime3Ukw+eq7M6sUHeaMnAM3wvWqnepwa6/CZpXKGyvf1LHN7B9TS
         oHdtm6WrFhbqwVAD3rIejbo50F/9y3AVEox7v4A/uyTtxqKrhJHsEC4nrE/3bfrVaEF+
         JVk07x++CtJB1Y39LztasWML8SEd6zWVWRHW4QNbtK17tMUzMEPdjK5Xltx5KWb9R0Ef
         JRHUBugKchXN2in7Wbkq5Debx2fK2noPbRuxDvrKPxkD0hCJwsfRW8ruCYJY46j7Jaex
         PaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755195305; x=1755800105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUd6PoN+c5hdmQ2iHQjtxlrpojdsuimTu6wnku27ak0=;
        b=RYebgvI0WV9qqD8yndibzfDuUIFTeGWYvGGBYgEewO2DMX4NSQjHudm/AhL8yaX7pf
         n+dh7wQAUhGRK/mp/+HvleVcfitFZ1KIP9tWMBgCvBFD7c1dAp0rxocMIAMf9iIRPgRd
         O5uh1QwEAL91mUQDGWknKHofr4IF6XIhoXe81NjS9DPUWZSOAHkR7bUwTS5hjka5Yijb
         6b0Ek2xIgs3e4rTu+HwEpYPoloui8xmGMkBIEZ8lmItnk+4FTUaYQ2MGwZBSdYg8NAav
         YVrdJ9xScjuOcO/UFznlMEXpH7l+MqqiukzjB7kAleJRuYtAS/Nb2AZsZN5R/e6L+mKc
         t03g==
X-Gm-Message-State: AOJu0Ywf233jJaI5AkY3pKG86UrTFMhiPypkmMLVEzbJpMs0u8jnpv9H
	Eo2oCIxngNZ2C2LPmJYKsp+gZFh2dTI7OMZpGh2TSDh1JhG//kuuDPE86sPBot2kuz0oVEo9LSA
	ZQn4fiQ==
X-Google-Smtp-Source: AGHT+IEro5kTTKIfllOQo3Pl8VLX9SeETQsJoo3E9SkVfvbxtTiRuOmSTdIEWaYnZOs3DYV3EKpwhnn/AMA=
X-Received: from pjhk32.prod.google.com ([2002:a17:90a:4ca3:b0:321:cbe5:b93c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5346:b0:31e:3bbc:e9e6
 with SMTP id 98e67ed59e1d1-3232b2c6158mr4970597a91.19.1755195304530; Thu, 14
 Aug 2025 11:15:04 -0700 (PDT)
Date: Thu, 14 Aug 2025 11:15:03 -0700
In-Reply-To: <20250814161212.2107674-4-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081231-vengeful-creasing-d789@gregkh> <20250814161212.2107674-1-sashal@kernel.org>
 <20250814161212.2107674-4-sashal@kernel.org>
Message-ID: <aJ4np2au1jjyqkx5@google.com>
Subject: Re: [PATCH 6.16.y 4/6] KVM: nVMX: Check vmcs12->guest_ia32_debugctl
 on nested VM-Enter
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 14, 2025, Sasha Levin wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> [ Upstream commit 095686e6fcb4150f0a55b1a25987fad3d8af58d6 ]
> 
> Add a consistency check for L2's guest_ia32_debugctl, as KVM only supports
> a subset of hardware functionality, i.e. KVM can't rely on hardware to
> detect illegal/unsupported values.  Failure to check the vmcs12 value
> would allow the guest to load any harware-supported value while running L2.
> 
> Take care to exempt BTF and LBR from the validity check in order to match
> KVM's behavior for writes via WRMSR, but without clobbering vmcs12.  Even
> if VM_EXIT_SAVE_DEBUG_CONTROLS is set in vmcs12, L1 can reasonably expect
> that vmcs12->guest_ia32_debugctl will not be modified if writes to the MSR
> are being intercepted.
> 
> Arguably, KVM _should_ update vmcs12 if VM_EXIT_SAVE_DEBUG_CONTROLS is set
> *and* writes to MSR_IA32_DEBUGCTLMSR are not being intercepted by L1, but
> that would incur non-trivial complexity and wouldn't change the fact that
> KVM's handling of DEBUGCTL is blatantly broken.  I.e. the extra complexity
> is not worth carrying.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Link: https://lore.kernel.org/r/20250610232010.162191-7-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: 6b1dd26544d0 ("KVM: VMX: Preserve host's DEBUGCTLMSR_FREEZE_IN_SMM while running the guest")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

