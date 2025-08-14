Return-Path: <stable+bounces-169586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E618CB26BAF
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 17:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A233116EA89
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 15:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EB021FF5D;
	Thu, 14 Aug 2025 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ukgLlMTK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC671A2545
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186779; cv=none; b=JaQuqpY1fr0dYVuAjrmJPT3zbHLaxmkxlAU7+glxGYmZUF7/Wu8g4quPE6vxQhodR1pgtsX2tYJ0f+4KpHPt9GDeOmms9F5fQp03BcyIiCA4xG7Yx5erhhHQlVs+wYVK5h3YRaHlk/Z6ppI4MTqhUHUJOCATQ9W7rDmcsivLOYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186779; c=relaxed/simple;
	bh=pih+xaVwVG5lHZ0vsgK0G2GYbuIPv9VaRQUnM3mKpk0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PD3mZkf5iCEYzC1fsQWGA2Yknb+ZFVUo4sX6/L1lzypoz+zrVhwufU5axBe2Q7AoI0d1KwNCW9+OoKx7u8QyobLjFx8VX/mk+HU2KbVHMoVdJkox9s/Npg8l2E6H6IZZhJVZJ8dhrXEmXtik2KMUp0//k4njF9PyEgl58LuAxQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ukgLlMTK; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-323266b700cso2123131a91.0
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755186776; x=1755791576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o5SZAicg05zUJtVp55Upcb0XfdWo4kt+hojadvKAeRU=;
        b=ukgLlMTKxwLYEb4PMOX0MPPTtC2+yARMmCnTSYuReJpdkcMEEVaGhNo3k2bdN4g/st
         acjb2XL0rqwsrp0CuTKnshf+TT5kzqCt7Zqe/CUeS6pMS2MGfHh0Ix3VIgksB3t5vEkc
         M5tlJyI0nG8n97tqZLd95TPEnVOjauCGCamq2Q9cyf3cmAKoN9qpLHH2PS8sX1Y6PjQ3
         P1RsqTfBPfB+o97D75MpVUQzb0NP2iXe+FZTPQ6zrXJaCBBtFsv4JFKohwighKxfUkXV
         Grzs1CLwZxwj0uRHLH57kAQM/nwb6TsfqQByDhgtMDGNkbRntFmaeNJ8TZsYVcxqqck0
         RC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186776; x=1755791576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5SZAicg05zUJtVp55Upcb0XfdWo4kt+hojadvKAeRU=;
        b=mOOE6LM59un6/AlqA4cpQs98HM++n6nl7ake4IpM29mT0LYp6tRQGhLe9QWP+xdlW2
         FVEoqHdud+qjiesEwYX3Gk0+jjuGfIGyWvV1zPyh4YXYHFYCXBS4q9RYaLw+mtv0jg04
         ps00E4gy5rwBSXkCCPVbMSpigKVDpNR6wMGlV3KL+lsprPBsHxa7u/urA83tMBx2gc2y
         UjnmYmgcdpQGLZYEWPf5nuNTRUBzyfMe5zExQfTuIqpsx5y70JGTdpD196ToxowPQZGi
         SermmYHC7gfLRr6WbwMyKghuEBMLQMFmna1jza1obsI3u69EhHR19IBEUNQQFT1iY0Sq
         LHQg==
X-Gm-Message-State: AOJu0YzETSTas6huWy4tQDd7lDTn5znmQrvfDqM4PLhU13xqL2CKIaU/
	DpfZDdoRT2to0fN3j5x6kT5wl2L3ZkODtrEK7pTnWApkPRsHgcNSaK22Ho+R3r3e1YZPxKy9/fU
	mekO0hw==
X-Google-Smtp-Source: AGHT+IEC7bRX8fhXC0Y5mCpRknI7UTdrT4Jf6royneK/2rPovbZUTIKCAYzN5eFbEJJR1Hz3IY9bPQEPzbU=
X-Received: from pjbsp16.prod.google.com ([2002:a17:90b:52d0:b0:320:e3b2:68de])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3fcf:b0:31e:998f:7b75
 with SMTP id 98e67ed59e1d1-323279c8b82mr6372693a91.9.1755186776623; Thu, 14
 Aug 2025 08:52:56 -0700 (PDT)
Date: Thu, 14 Aug 2025 08:52:54 -0700
In-Reply-To: <20250814125201.2090009-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081208-petition-barcode-1e2a@gregkh> <20250814125201.2090009-1-sashal@kernel.org>
Message-ID: <aJ4GVvToJmrYy4eE@google.com>
Subject: Re: [PATCH 6.15.y 1/3] KVM: VMX: Extract checking of guest's DEBUGCTL
 into helper
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 14, 2025, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit 8a4351ac302cd8c19729ba2636acfd0467c22ae8 ]
> 
> Move VMX's logic to check DEBUGCTL values into a standalone helper so that
> the code can be used by nested VM-Enter to apply the same logic to the
> value being loaded from vmcs12.
> 
> KVM needs to explicitly check vmcs12->guest_ia32_debugctl on nested
> VM-Enter, as hardware may support features that KVM does not, i.e. relying
> on hardware to detect invalid guest state will result in false negatives.
> Unfortunately, that means applying KVM's funky suppression of BTF and LBR
> to vmcs12 so as not to break existing guests.
> 
> No functional change intended.
> 
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Link: https://lore.kernel.org/r/20250610232010.162191-6-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: 7d0cce6cbe71 ("KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs")

Gah, forgot to tag this one for stable.

> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

