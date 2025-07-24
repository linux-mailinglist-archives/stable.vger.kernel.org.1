Return-Path: <stable+bounces-164634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5D4B10EDB
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 17:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1281C2860C
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 15:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A71285CA6;
	Thu, 24 Jul 2025 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZMotdzgW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D243D21D584
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371527; cv=none; b=J1lCVn+pDmT+ftKSK2iZX4u2eWAC5Zos/rD01ld6snwLGRRKOpd0En9UkyUI5bNPEFfwkZSjDEHmuTDzRQiLCoDAzntgn+nM0BA4w7Z+C8JjarNN1F1SdIHqnucrRZU0l82TY3wrwecVf6BmO4vQYTuxmr6TLI4lErhQnMIdafo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371527; c=relaxed/simple;
	bh=vQD/ZA3Nc+ZGmtfNk25QUd/8OIjHhZa+bizOHTVZedc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f+SqW1JVmi21jNUA1IKm13a24ROAk/vfTAo4TAaFM2c+4hbQKTBiAf/ogTcKT+DmnidxyXdvyzJzeTwQQNSUx40qVDeaqZtSPuVzyhnWXfovNcxGOmQIqubeVmJ326qXEEuMRTfLFGOxPYl6WWt4M7o6zU5EAezxX7C9Kkh7JQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZMotdzgW; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2356ce66d7cso17331835ad.1
        for <stable@vger.kernel.org>; Thu, 24 Jul 2025 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753371525; x=1753976325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=huJjmIbXJy0ZGytJKTa5ox8MAh/+i+MWMO7H2GbTEbk=;
        b=ZMotdzgWqBN6rdEIJYqThtmZVuZUWwK6jotUdI0teJNgAvOHmz3H8ppbOTc97f4smI
         G4ON/hGrxbXMqjD7eEzJRQ8AsQT8UqTbRenRMETh11GQq9dKYzIx/5LppEsN4Tg4zJ78
         77JifBB7tPNQEZUOgn+Ihe8/T2fP84+ynlvynul2CrDpIZKTJrsXirPdF2rIsvgcslrD
         hxIElJebCiDhQaq08xyZAMXoQXzRtfYUPPX/8E+D9Tnzpxgg8ZCnDEb44lqFlgz6IQXj
         raqRXiB4dmJPm7XQY7c+9C2UvNZihkNo17kHG5uJy4t8y9MHCUQDRqm6cO2j3Lf5fWR8
         rYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753371525; x=1753976325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huJjmIbXJy0ZGytJKTa5ox8MAh/+i+MWMO7H2GbTEbk=;
        b=b6Vcb3UzMee6rIfOB6Oj66OMqDli2PHW+LsmZoSHv+Sszp95ua0ARmzo1kuKvcNCN0
         rnVtHHUedlpbA/2+pLHFxB370uQh8kDdH5e8rr8OkD/Usj+oE0pgjMkm5awS2BvxOjY9
         iVSZcd514ZSHO6GiELKO/2pn0DTuQUqK1s+2Hp+dCac7NrP5Y3opy9nuHFkvRiG+zesf
         zqQikERFRi3KhPIPi86Y4o3z2l9nwJWzHjTbgw+tt5phytjwrsl7HLDvTKl7EEc1fV4P
         WJEe6rS9t8UWIvEnnFH9Fd0aWPS04jQFDWUZv75vHUIzduwDqpISU3E9vnuKcZmLkO/v
         irOg==
X-Gm-Message-State: AOJu0Yz2TeiUPYsMEj0Q3zEC4Ae8ycgd9MoawI07MkUfYlKApYyZf+6Y
	GxaATiAqky+JABrJuIeCBCTMhSqE+EikmlW0+GHSvADt+nn3g94Bhcw+xwYtc3Lw25BPWoNq9yD
	HhcsbDw==
X-Google-Smtp-Source: AGHT+IFM0qax5yTCw1BwVRrdZ1W+eSyRP1bR+8t30hBi8Xlj6s8sm/vLvqJtZDqRc6bUdzdGzx90YVN0YjM=
X-Received: from pjur4.prod.google.com ([2002:a17:90a:d404:b0:308:6685:55e6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3bcc:b0:234:a44c:ff8c
 with SMTP id d9443c01a7336-23f9813f3femr81542975ad.18.1753371525219; Thu, 24
 Jul 2025 08:38:45 -0700 (PDT)
Date: Thu, 24 Jul 2025 08:38:43 -0700
In-Reply-To: <20250723151416.1092631-4-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025071240-phoney-deniable-545a@gregkh> <20250723151416.1092631-1-sashal@kernel.org>
 <20250723151416.1092631-4-sashal@kernel.org>
Message-ID: <aIJTg3JWW3LHBfuC@google.com>
Subject: Re: [PATCH 6.12.y 4/5] KVM: x86: model canonical checks more precisely
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 23, 2025, Sasha Levin wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> [ Upstream commit 9245fd6b8531497d129a7a6e3eef258042862f85 ]
> 
> As a result of a recent investigation, it was determined that x86 CPUs
> which support 5-level paging, don't always respect CR4.LA57 when doing
> canonical checks.
> 
> In particular:
> 
> 1. MSRs which contain a linear address, allow full 57-bitcanonical address
> regardless of CR4.LA57 state. For example: MSR_KERNEL_GS_BASE.
> 
> 2. All hidden segment bases and GDT/IDT bases also behave like MSRs.
> This means that full 57-bit canonical address can be loaded to them
> regardless of CR4.LA57, both using MSRS (e.g GS_BASE) and instructions
> (e.g LGDT).
> 
> 3. TLB invalidation instructions also allow the user to use full 57-bit
> address regardless of the CR4.LA57.
> 
> Finally, it must be noted that the CPU doesn't prevent the user from
> disabling 5-level paging, even when the full 57-bit canonical address is
> present in one of the registers mentioned above (e.g GDT base).
> 
> In fact, this can happen without any userspace help, when the CPU enters
> SMM mode - some MSRs, for example MSR_KERNEL_GS_BASE are left to contain
> a non-canonical address in regard to the new mode.
> 
> Since most of the affected MSRs and all segment bases can be read and
> written freely by the guest without any KVM intervention, this patch makes
> the emulator closely follow hardware behavior, which means that the
> emulator doesn't take in the account the guest CPUID support for 5-level
> paging, and only takes in the account the host CPU support.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Link: https://lore.kernel.org/r/20240906221824.491834-4-mlevitsk@redhat.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: fa787ac07b3c ("KVM: x86/hyper-v: Skip non-canonical addresses during PV TLB flush")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

