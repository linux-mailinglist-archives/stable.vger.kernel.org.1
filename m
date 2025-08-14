Return-Path: <stable+bounces-169598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D99B26C4C
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 18:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754F31883C46
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331A0220F55;
	Thu, 14 Aug 2025 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y9/MWTIM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3461A9B24
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188232; cv=none; b=F94tP8QvxJxAgVXiAUzGGbSsys6cBSEH+50WS8CksxaCaASk0n8VuWBZDYOT2E9DeERxLk9KNMxCM/7MoEBYXXeWp/WhfKd7A9ks0RKpAPGeYkd1hg/BBGYkGWjKAB5DINBKKLsAAGzaGzj310bFBFqCi8p4VVXyULLcKz1ZefQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188232; c=relaxed/simple;
	bh=qm4sJIAbvHbaMYpcH+1Lp87YAMKK3OmEhn43nB5qoAg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HHoNBHFlOsHDsQZAF8hT5S0kwd3lnTd3/D9YEoxJdKZiiM6p7wT3kyh+/azHB9jUbN25q+spZnuGPRqGp1gS6zv+dNq9uX2UDGROE6bbhLuIUEbOUzYgB/5ElgmozgdI/9XCzfW4XQh9X1TEg9WyWlzuc091Ck2GabnZSp+QFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y9/MWTIM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-323267915ebso2144227a91.1
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755188230; x=1755793030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ib1aMJQeVnxOBq2+znYic6DVJjnFLkElsxAP6tuqDCk=;
        b=Y9/MWTIMN8sq+cbSfz7x0ZU3grUXrMrnu6uQ1klIh4C3Vw6FPHNN0VMW0J0znmSDXm
         rJXgxwlh3kps3dCgl49+4SsWoKbrUyV9X0wbtAsALhrb3EUN1F6j2ePHgpMLKFt98hzK
         LyN64R/qjVGll5XAzqW87bG98FvdCOPr8SgFTCASb2z5ubPjm7609NPfy1FHCXsvlS1D
         fwltS3Jhylvnb1q4v5asQtLhAYuc1+e3diWcOhhCxLwYM3/5gVWhAOVibAUa/s1OKi5e
         cUwBT1GVbdb+h18wt6HV//7nhsc67bPz0xH714tk0Vh3M0wSOz5VB7Dt4HtxjVJ/Ym8P
         zfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755188230; x=1755793030;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ib1aMJQeVnxOBq2+znYic6DVJjnFLkElsxAP6tuqDCk=;
        b=F21BGAkUmHaqnIvgKV520d/0Zs4ikoi/tVBSBNNP3c0p+Fd1NpagJDovGGk/hA+5yr
         6pxpCX4pucyOUPiAxyXKAyhR4ciu99PtN1ITb1nZHtj/wiPTBSJHd1ROPjqWqZMTlNJs
         UQeOk92qi/hHHnhKVTn7znX/w9l8bH2+uNrDrNo/7JR+10qiYAWdbsPKgO5YVa8dcZiu
         9EAzu2rSyL+t+XL8zw1lKf+guZP+U892c0bJZaAD7N6TeuNpSqekgC0D9DTlCp6KE6c8
         k4sXEm7yUO8S1bMJjaKjFBrjkLLrOrYvTTrEdpX5dohHIMWAq3cUmK09tYRJa6H58rfR
         ZKGg==
X-Gm-Message-State: AOJu0YzU6YunpCpKiGjDoFhoBZ2YYuhZqKSuwGtvWy7H8XYAqRcJkjRT
	V3ZV5RAcCTK/Uiwb75ukrBSJop1ZjYpKvKlIlwOcQRAtn8vS2NL9ZgE04XIpJwOwxx1aooJLLZ2
	RsTnm7A==
X-Google-Smtp-Source: AGHT+IF8su2SI/KnQ31NYzGHIAAoguVmTqfiZQ2hOqQR2at7Fh/jl4itW2sRf0S/X6fU8G8Tegt5NhZZlQU=
X-Received: from pjbqx15.prod.google.com ([2002:a17:90b:3e4f:b0:31f:d4f:b20d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c8e:b0:31f:6ddd:ef3
 with SMTP id 98e67ed59e1d1-32327accb65mr5200175a91.35.1755188229788; Thu, 14
 Aug 2025 09:17:09 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:17:08 -0700
In-Reply-To: <20250814125614.2090890-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081209-sworn-unholy-36ad@gregkh> <20250814125614.2090890-1-sashal@kernel.org>
Message-ID: <aJ4MBBiDTewc6i06@google.com>
Subject: Re: [PATCH 6.12.y 1/3] KVM: VMX: Extract checking of guest's DEBUGCTL
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
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

