Return-Path: <stable+bounces-169613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C24B26EAB
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 20:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF88A568010
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 18:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF34C1ADFFB;
	Thu, 14 Aug 2025 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nf/5uINW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468B978F2B
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195317; cv=none; b=W57cjKQIyElGWvwT2ASThqAP3/E9ItwaVomDdjlW67PihieXGgh08bzbWt6tcRYwjoZ6JPMU0yYThcHgpI79HK9ADzZK4LAFet3RHtdNWDKBtn4oEiu51yXfRFnuBH1zLbOtogqa5iu5qUJ98O0citqtcWJF7G4LkLkRDXA/1gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195317; c=relaxed/simple;
	bh=aiZjWoHogGc0BWbA4VY2g50AG8B9F3v56KyenpJ1qpI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bjIPNakv9517SgShh93ugZC6k45JDdZUWrkNdCViSUqH4/04DJSvo/HY7KYZPX4m6JWBo57PtdC+tyN9COuclHiTutk1beHK0zjtbtkXfprNg0r1NdbON6iHl+daImZyb4cv1aH0KKH2AlPnKOwJVekO9mW3U50ACPs7G5kTxeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nf/5uINW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323266ce853so2158588a91.0
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 11:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755195316; x=1755800116; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TCAs+0BrsSFnDS4AaRtsQxrs6kkdPzAQ7lx3zsAwYaA=;
        b=Nf/5uINW7GdkNJdc9/Y6qk+sXU3afoNKzRJnJfcpi/13UWag3Zg02KyuZ92pa0aMsb
         N7HMqnMAMHTF+/yRDoPPlWRxsLxwIp5u+k38jDOqxm31SE9zGsNfivzVZsF2VQMjA1UC
         dF93qgt//s4Pn9eo/t6d4IsyZKTnoSSgN36RX3c3SzWNAvRShj2w6WNrinf03e5/fkJJ
         eitRTxNAYLlFUz6TG1KXMS04CR+GwVxL2XQkn/K3tuktP3fdMlcxo5b9ivee/F64mpq/
         kPZ7C2QWqgCOlAjo+XKLcnLt8dnmCuB0JC/JiA4RbU11wasGXR4PLpy0yRzEPs8cmJ1P
         R65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755195316; x=1755800116;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCAs+0BrsSFnDS4AaRtsQxrs6kkdPzAQ7lx3zsAwYaA=;
        b=nOAn7IXk6NaLtBGs3Dz/yF1+up0p43vjb5kTIloRJNylL6NzDHMs8a27r23Shvi3fK
         reJsLdFjWovPWesdGxmX0UcSWOliOSkfXZ/VBWY2cgivZz87GomrCZATAjSHfP7eKzHn
         AUG9j3guZVH/SaOoPRzo48DJq09+zFCm8SFKItO93crTsEzhn65JiM+J0K2MKoXAa4zc
         IbbVV3qoMiSoDNfsqxAcLCdG42iouTHLBiGRmfIjtpdjT+o5nLE7L/wr95KvHsvIlzwA
         uS3yIlnCgRL+qiQ+UAE0gtRd+WC0w+CzNy8W+0xj2MlxmDzxw8S2KIxWVsZilcWW2HEL
         Hs0w==
X-Gm-Message-State: AOJu0YygDtTcabCB8W//s6652/eEfYw1yP/9tDGYqus/2EgBz+Kv8jIN
	2cg2K8H64Dt1/uDjgQNp9yIyP37zFl1JZ+8PZi7m8QQtezfYkbDD0SLeXvOlDXR2DA8+iVGrKAC
	Hc/fi5Q==
X-Google-Smtp-Source: AGHT+IHRtfqaVwLKL9aGr/VMqXBtDcMNKuoubp6htCrxOgM9QDEwFU+B8UvfoxKkDz8o/B/x4imbvLflTWY=
X-Received: from pjbli7.prod.google.com ([2002:a17:90b:48c7:b0:31f:3029:884a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3dd0:b0:313:62ee:45a
 with SMTP id 98e67ed59e1d1-32327b28ee7mr5927167a91.13.1755195315345; Thu, 14
 Aug 2025 11:15:15 -0700 (PDT)
Date: Thu, 14 Aug 2025 11:15:13 -0700
In-Reply-To: <20250814161212.2107674-5-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081231-vengeful-creasing-d789@gregkh> <20250814161212.2107674-1-sashal@kernel.org>
 <20250814161212.2107674-5-sashal@kernel.org>
Message-ID: <aJ4nsb6iUcXSCkSr@google.com>
Subject: Re: [PATCH 6.16.y 5/6] KVM: VMX: Wrap all accesses to IA32_DEBUGCTL
 with getter/setter APIs
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 14, 2025, Sasha Levin wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> [ Upstream commit 7d0cce6cbe71af6e9c1831bff101a2b9c249c4a2 ]
> 
> Introduce vmx_guest_debugctl_{read,write}() to handle all accesses to
> vmcs.GUEST_IA32_DEBUGCTL. This will allow stuffing FREEZE_IN_SMM into
> GUEST_IA32_DEBUGCTL based on the host setting without bleeding the state
> into the guest, and without needing to copy+paste the FREEZE_IN_SMM
> logic into every patch that accesses GUEST_IA32_DEBUGCTL.
> 
> No functional change intended.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> [sean: massage changelog, make inline, use in all prepare_vmcs02() cases]
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Link: https://lore.kernel.org/r/20250610232010.162191-8-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: 6b1dd26544d0 ("KVM: VMX: Preserve host's DEBUGCTLMSR_FREEZE_IN_SMM while running the guest")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

