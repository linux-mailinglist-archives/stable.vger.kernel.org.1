Return-Path: <stable+bounces-169610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8084DB26EA8
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 20:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402E1A26763
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F36319860;
	Thu, 14 Aug 2025 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGfSf5v3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B3263B9
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195277; cv=none; b=kY1bgSj3XjZGfKf9W7jUOlfSwgCI3k32pzqhRj6FV6LNKv86S/JF0XCpuJvxMgmtE4p2h/bIzTKDDlWFVNyc9aRJZ7lrbByNCO0WW8UqzXU/fE7ERLqHGHJQ63mkxLWYhD2WLBSt/QEIANvNqpMsmrugUGeS11oe6rxxjXKU0MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195277; c=relaxed/simple;
	bh=xqzXTVOo+HfT+Rper86W1+Na9+JYHsYieDn1A76TjJ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QL9GIbBjEfo43FNu0jAT4CGDwMtYFzKYapZCgxShkvzEunhRFO3aO4UMIA0mLGlf5RSkqy5ho02UZnL7UUtqr0pqfwBvryeC/4gShrIInainjfSoBWKPHHqdZSPIcG89W5y7nsVnAR+TxHJ5EP2mLTXqiKsGdQ2Bpxk/KCHtcmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hGfSf5v3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323266ce853so2157432a91.0
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 11:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755195275; x=1755800075; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z41RRsboEJtxmQimda9s5PepaOeeDoU3YZi9zLLblsM=;
        b=hGfSf5v3O0UuFvUCrfWdmPP3bxuNTJslHPbDqonpBLv9oveALSc03hMsPqHqgVSD5y
         oT6il3CJi1sXHiuBwxYe6Lf1PikBLjaWfwJpdBZBSRKMmBpZYmYS7n0+NVeuFRk4kUly
         BKy0Oc6BZmGfTaxDSCPxgiOarcWxVFo4wHgfFrYQYS/yizMKCZPRDSMsjb810hKhj9NO
         mpEg9HfCA6KAB4++F8g6xryTDSErFGxC8+YZVcZP08bBWAv1YeCTSxghG/VZ7CyCBJ+B
         bPfrxLP24Z9ykp9j3Ly8bPW46YO0/txpr06xfYG7sZszW2cr3Fv7qsTfp06bknYcEWln
         7g+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755195275; x=1755800075;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z41RRsboEJtxmQimda9s5PepaOeeDoU3YZi9zLLblsM=;
        b=q7ttT4+oARcvLqywjuv04EuVq6CZhvQdssztT3gyeFiv4eJ/Vtz7MyrSQlxeZz+HfK
         LR4rFtBGVBIn7vgT/AXuT9dO+f6Zq2kjcVbve9UmLlOWD//fjjBma8L1Evf//BxVHSnO
         8nOMVZebmMOG28DPEviIyV6/Yw7y4SUx3xe7pXGTT9mY/tayEllSdnw+IlDvyix+wh8k
         ZaOQzRTYhg4JNqZvcruzIsbuZvXueEy86o9GS1yf12SKxN295i5AvL7m0aWGgcjdVWEo
         REs2ukNnrloMQoXS2Aef5j2qOor9bO4jUVJJawQKQAywLCrp0uhGoPuJx5p4GmZZINf+
         tkZg==
X-Gm-Message-State: AOJu0YxXnyhvYk167snl1hd11zxyC6THlz0+SEIj0SWhkmr7OR7AMOPY
	f19QSO9nZtw8+HV8Rqz90KEHbYLWlAvPQ2fkrYAkgkuBcorbMcDIGGQ7xJI3csRLKISIHQ7WsqE
	NdN93Xw==
X-Google-Smtp-Source: AGHT+IGX3Hq+afOm3A1jgp7o1SOC4X8WQrNY9vWC6ngvMb374VCtWJV07DS+hLguQecRlz0hEvIIt5Eaw1s=
X-Received: from pjn16.prod.google.com ([2002:a17:90b:5710:b0:321:c441:a0a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d50:b0:31f:3cfd:d334
 with SMTP id 98e67ed59e1d1-32327b09c1amr6184244a91.4.1755195275354; Thu, 14
 Aug 2025 11:14:35 -0700 (PDT)
Date: Thu, 14 Aug 2025 11:14:34 -0700
In-Reply-To: <20250814161212.2107674-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081231-vengeful-creasing-d789@gregkh> <20250814161212.2107674-1-sashal@kernel.org>
 <20250814161212.2107674-2-sashal@kernel.org>
Message-ID: <aJ4nitwghGrnj5Xs@google.com>
Subject: Re: [PATCH 6.16.y 2/6] KVM: x86: Drop kvm_x86_ops.set_dr6() in favor
 of a new KVM_RUN flag
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 14, 2025, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit 80c64c7afea1da6a93ebe88d3d29d8a60377ef80 ]
> 
> Instruct vendor code to load the guest's DR6 into hardware via a new
> KVM_RUN flag, and remove kvm_x86_ops.set_dr6(), whose sole purpose was to
> load vcpu->arch.dr6 into hardware when DR6 can be read/written directly
> by the guest.
> 
> Note, TDX already WARNs on any run_flag being set, i.e. will yell if KVM
> thinks DR6 needs to be reloaded.  TDX vCPUs force KVM_DEBUGREG_AUTO_SWITCH
> and never clear the flag, i.e. should never observe KVM_RUN_LOAD_GUEST_DR6.
> 
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20250610232010.162191-4-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: 6b1dd26544d0 ("KVM: VMX: Preserve host's DEBUGCTLMSR_FREEZE_IN_SMM while running the guest")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

