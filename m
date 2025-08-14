Return-Path: <stable+bounces-169627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE067B27035
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 22:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F445E708F
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 20:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEEE248F4F;
	Thu, 14 Aug 2025 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XnRxFV8Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681041FF7D7
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755203498; cv=none; b=cRNUY9g8PfxTtkEhuQRSvlHa/etRmQqt1P41Qluh6rMITOBZfov2VALiWFS2YhzQpaNrYVAoLM/UnL5A1edkdsEryc9MzFIuELNeaIWQ+N9MBEMMs34Ccf526zKDqwUVZsURU4+Ckeiol9IKATD7LPfDTS4Nz7TBR62aHStesYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755203498; c=relaxed/simple;
	bh=y4Pt29GJ6h5f9ZgKyV+eRqEN247at6KUfcHwP1E7Weg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sRrt3mS7bU1oIabNY+L/RS2DSe+d7UDqXh9R1EBayVv9PF2fzxe52Lzhb7ZhRHpGTAMIvlYMNBKlvpF9/K2Njiq9iu0QNFhijB0+PZbpvHjiF2bAun1Ruw5iwxB7gcpHAvE3149ejpLtWxYfiWjb6yyQFei3hL7pvVU+XEqgFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XnRxFV8Y; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323267915ebso2582258a91.1
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 13:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755203496; x=1755808296; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kRmyDevc7OSePStTxsqM/w9E+pwYb9ZDiqDW6ho9GwE=;
        b=XnRxFV8Yq+4anhaqUbksk+uta09S2C/LMK6bSKnYglk6OYPloHpZ17VQBN+IYKZR7l
         s3ixsPurb8tWf8ZpP2no7Vma/joqWl1MBShI/Axdp7UrzPf3gfljJteIAxBpavnqTRhx
         +BKtoaUoFFui9Rwlwj+/HFCGbPXEeMvv22nzBXqPrw5wZMSj/5otjZkW6B23KOMQERvh
         E4Eab166ZTmcMoaO/XViRpH7ZLKkLsxaVjfExcw8qbxjlpWN9Q10GHrm0L34SMGnCNaq
         ZhkdhnkW9oEmEsb+RjmCSeJ8lUbWYbhrqRmjfl1GDe44kAseilVmbcVxXFMgRSdXXgO1
         K4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755203496; x=1755808296;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRmyDevc7OSePStTxsqM/w9E+pwYb9ZDiqDW6ho9GwE=;
        b=OT9RdRpavZ14rQCkNRPi5jIS1qtnsCSmDiqknk5FSQO3R5L+vt9ZpIEbHJiVpwVDRQ
         F0zDLzlA6/d8DqgmADJv/QWRc9oCoTHPr0nNsWJegFdYIMZo/mt+hWqLp957onViThNH
         8FqdcdZZgFPEdUCZQLnAKTVT81sZfl6tE4NJXgSgO05KQRqHAnKDu4KxKcGJqUWQPEZq
         /shvjgfPYPW+QhJd1lD9qaEXdtxj8xQpFHacp5Fp5eVw9dauztsUSIpLkwrHxHWo6vWM
         AUO3yG31O0e8aeVntEZxNPABKoO3m0wjjb8icSlUDBw6RQIvNpOj2N4VOS/wJHEdOaHt
         ghAw==
X-Gm-Message-State: AOJu0Yxb208uGPTXh+2bmnVd5cQOYTbAqEXWLC+oUteW99Qr4rdUXamC
	7xikxpLvCvengUBj9AE9kw0wQO7Am+7WqUH/VrxzkJwBNsP8Qw1oUfT65bUypRcQoIoAUKGdcS1
	7gXmn8Q==
X-Google-Smtp-Source: AGHT+IEn9Iz+ptVZSVAnLhwBvYuKq+ss/jEgc51FGXRDc4EHKNRUlw0uPDYDMcNLv3R6pg+pAPbaVY/gcHw=
X-Received: from plbla4.prod.google.com ([2002:a17:902:fa04:b0:23c:7695:dcc5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b45:b0:240:aba:fe3b
 with SMTP id d9443c01a7336-2446a298542mr3709455ad.16.1755203495661; Thu, 14
 Aug 2025 13:31:35 -0700 (PDT)
Date: Thu, 14 Aug 2025 13:31:34 -0700
In-Reply-To: <20250814132434.2096873-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081215-variable-implicit-aa4c@gregkh> <20250814132434.2096873-1-sashal@kernel.org>
 <20250814132434.2096873-3-sashal@kernel.org>
Message-ID: <aJ5HppgpdlrLHTYV@google.com>
Subject: Re: [PATCH 6.1.y 3/4] KVM: nVMX: Check vmcs12->guest_ia32_debugctl on
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

Just in case you read this before my other N emails that say the exact same thing...

Needs to land after the RTM_DEBUG patch:
https://lore.kernel.org/all/20250813184918.2071296-1-sashal@kernel.org

