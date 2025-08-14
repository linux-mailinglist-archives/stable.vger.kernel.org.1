Return-Path: <stable+bounces-169617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A90B26F7B
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 21:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4851CC1F8E
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 19:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55F1220698;
	Thu, 14 Aug 2025 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MxQJnWs8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AB310E0
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755198324; cv=none; b=JXlEAPV3a7JIbQCuc+n+APSkUKWsDYtAq0zd97WR+LhJ0fIOHMM22gXkF8vlzx3u/dn9rGEVmT3IB79de3UCXbDoXWoCE2xy6Qkg+bqB9rM5kZpgbL3Jq3aXB2yuuWBRf8pxIJ04aUDbhxaZ7VmmGq1MdSnUg+J7CUt1udSki1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755198324; c=relaxed/simple;
	bh=AN8qz/ITEUM5LRnJa3X9A8S8tftQ2fJgnHqHAaZHT7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LVn6QpERBfSecmaPgSglIXUyLgQf8Sq3UsBs2VyPWaalc/9NJFrygCOUPwf9q/7pBp65xwLZIzAag1RtXSRp8GVPonwTmDQTcfKXjo+888tgUuCyjlqmb65kLDw5azvd6wM/X8DRWbIt6I64pFs1wQjfqTf+8phnpWKR6AxCA2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MxQJnWs8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3232677ad11so1245222a91.1
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 12:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755198322; x=1755803122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2DFNw3wArC7yOUYWlWO5gneOvkuHKG1tXFsZhvGkvUI=;
        b=MxQJnWs8uNICgJAdcDgyy9mnNQc/sCo+6pNeKt5o5j5dQf3XIONgAFXQBEkEbbpH06
         Z79kWdHHX8vj2VYku15WSbl2ihehjdMIcf/M5PSCFCarQXK2V8oZh8Wk21a5tm6ELWG1
         QiVlQN+iHqj/MUMQfwELDg759d4wnxbrZWBLPjJAjJnaT8Rfx6wlvjprZqRhB27yquPr
         JYMKaFOL+fekRYHdCOjvGqfm7vcTetN8bcht3g0itWVPgoOzuCrUd8ROkxF6JbJJz7mV
         iFTnNRSQrq9VsXXDn+XCeFCfKleQs8sZlSctSqNXlrdilq0M7LMx8nMgDOKFJrUKkjzK
         yYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755198322; x=1755803122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DFNw3wArC7yOUYWlWO5gneOvkuHKG1tXFsZhvGkvUI=;
        b=igi7zBGfK13EgaELFYlWM8MZocPKnRLsG5YL3a2gym0gNWrlT8hLzepjVnWEFLdqyo
         pDSpn1qlFNEiFYqqkp5QiX3CbH3JTISfTh+MYt7+gXlbjGaEwcHsHSNYEnVZIrWVODct
         vDVMKUTZ5eyimdtyv7uYnsW3cCUT+NOlVzC3NC5sI/+k6ANqQSrh87nPXbkVvoG0NyGG
         DqsH26J97SfpvuC6kZR250dkgsOcNF9MQ3B7xcZqQXccIuqujlXImhfTnDI+9MszGCO0
         Qex6CIPBiaMdFzv6LkncxC4DdvZM8oShqXBFTLlCPIVFNw38RcWyTzwcLUj4awFmMbrd
         3dug==
X-Gm-Message-State: AOJu0YysiybQC9XcX19kWP0F4efaQ2StOcb35jw92iOZg/pMf3I7DuxN
	S8ftisjsHtUGFNQK25DRJmi+oH2+oHv6nhlVdZ8MOBbBaT8+99MIAJl9XGA7/NL3xrdwFq/mXiR
	rpNZEQw==
X-Google-Smtp-Source: AGHT+IH2s+I1TSjeIAje9qDRzYT7oUTiJGlIez0qBhglzuXW+2EZOz+sXrUhTXz8K4L2QNsDcU3DcyVjE4I=
X-Received: from pjb12.prod.google.com ([2002:a17:90b:2f0c:b0:321:c2a7:cbce])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:58cf:b0:321:2b8a:430a
 with SMTP id 98e67ed59e1d1-32327b495f9mr6693312a91.28.1755198322479; Thu, 14
 Aug 2025 12:05:22 -0700 (PDT)
Date: Thu, 14 Aug 2025 12:05:21 -0700
In-Reply-To: <20250814131146.2093579-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081214-bonanza-germproof-173f@gregkh> <20250814131146.2093579-1-sashal@kernel.org>
 <20250814131146.2093579-2-sashal@kernel.org>
Message-ID: <aJ4zcdyjLovEVFGi@google.com>
Subject: Re: [PATCH 6.6.y 2/3] KVM: nVMX: Check vmcs12->guest_ia32_debugctl on
 nested VM-Enter
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
> Stable-dep-of: 7d0cce6cbe71 ("KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

Once again with the caveat that this lands after the RTM_DEBUG patch (which I
also acked).

https://lore.kernel.org/all/20250813183728.2070321-1-sashal@kernel.org

