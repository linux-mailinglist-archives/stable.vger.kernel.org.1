Return-Path: <stable+bounces-169609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2F2B26EA7
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 20:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B95087A78A7
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 18:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A2B319860;
	Thu, 14 Aug 2025 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RiA5RqZG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CBA63B9
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195267; cv=none; b=epcXuh0CqWIpfJb83Qa3BiJGKw6xdDT2nMiAW75M7euqAdKmaWSvd5Eu4JZBpFaUUfwihLVMdFpZaxrIb00BDQay0b5YTiWIvY0/EZONrn/1N5oAMhmsSW82V34aH/fJ7rpR9aFH4AJH6emOEUCqLv+phUdH06Bh7ZpiO3WLSRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195267; c=relaxed/simple;
	bh=cEcgLfnH8qB86md3DafGSLJIphbcDsAhpZa0ovLyBoc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kJDa/NMfAhz00fU8rAFLYMP9eGaaH+2UuX3h35BG+9vJBN4jd5dVzCKeO6QJDmw2huOMNfhB/TmFCJzTEVoPXoqq944fU5SOirQnXS4VNR6EBUPLFwB62ci8o3MukSz7FG1C6BKTNTsk64I0/Vx+OS5kgfFn9mf2Y+tPWC1xbkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RiA5RqZG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326779c67so1226931a91.1
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 11:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755195265; x=1755800065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6zJxmr6Q3oUTF40FA8b4sFor7bgpdzB95ggviVzNBz4=;
        b=RiA5RqZGGDCH/Y4EAJFlXKTdFPp7Wj5WQomLNFJgoW0a01+V+VzF4tuPVl4uqvAMJU
         32gfUYZfefGGor2kp34JIOpsc/47wruLuOrdZGgo6ecCoY/JgyL7njifOK6bpFksvljL
         jeVE+J4LR/5Guwg2X1q3566prKXBnXKhpsnAE0eVtV0AxxUP9L+biHqGDzzBaQOam1VY
         eprsP9HWf47LF+ZQrxi7t8www63+Tr9qducTKB8kzgQQZHyf4A+FQesvFc2K8AgKwteq
         b0Ip3pb53m7EUER1FVQ0J0nYSYUKysPC6PhQgJp+mw7muzA8it1jKuARoMTLhlqZdCmb
         LKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755195265; x=1755800065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6zJxmr6Q3oUTF40FA8b4sFor7bgpdzB95ggviVzNBz4=;
        b=W4kRynk5vTkHvi5nzTAn1W+RODNESDKOs04PSeLO00lFliMSO/uIOIz2lxssseVqvQ
         R78wG7PW6mqAP0gyH8GkbfPKl0crSm/5zA28y7u81l2hr7bSUZ+BcwjQbITASr6gooym
         GGaBR/h7WlX96O1SUrehRdC9fU8wAONskreU4UB8ZzYhxQsROIHLIhm1+mb6xKOh7mVi
         35nLYUXJ7lIUhaByQ0NAXH20pfHtzuhfcn1M7CByHZ1eIb6q1UudR3u3PQjVwLxsQJIh
         JqAk6+H2AushTwymDb0A6S2c2XyacLZCHAijC2cKsXxbTjlxsTTzXpinLiYq/Gioekw3
         1c4A==
X-Gm-Message-State: AOJu0YzdDjZAIYZUcw6uj1UegKT9EgdZmsCyChT9CTXxaZ+Cc7ka1/Z8
	nDviq2Vo+wEyyWuMTW+PEl5/+TQhxt1y4MQso+NiimpONMdx6SScqcfNtW31yolz+fMeqqqlnlQ
	004dHJw==
X-Google-Smtp-Source: AGHT+IHO3+Fh08cj4HvSGbu/92Fiet/nfshgA5o1eOHNIKAwIRpx1AJRbdEagPuTvgtPLeDgYrQhkkQdZSQ=
X-Received: from pjc13.prod.google.com ([2002:a17:90b:2f4d:b0:312:14e5:174b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7c6:b0:316:e77:e2cf
 with SMTP id 98e67ed59e1d1-3232b7bc4a5mr5373680a91.35.1755195265364; Thu, 14
 Aug 2025 11:14:25 -0700 (PDT)
Date: Thu, 14 Aug 2025 11:14:23 -0700
In-Reply-To: <20250814161212.2107674-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081231-vengeful-creasing-d789@gregkh> <20250814161212.2107674-1-sashal@kernel.org>
Message-ID: <aJ4nf6WOwtOQvP0G@google.com>
Subject: Re: [PATCH 6.16.y 1/6] KVM: x86: Convert vcpu_run()'s immediate exit
 param into a generic bitmap
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 14, 2025, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit 2478b1b220c49d25cb1c3f061ec4f9b351d9a131 ]
> 
> Convert kvm_x86_ops.vcpu_run()'s "force_immediate_exit" boolean parameter
> into an a generic bitmap so that similar "take action" information can be
> passed to vendor code without creating a pile of boolean parameters.
> 
> This will allow dropping kvm_x86_ops.set_dr6() in favor of a new flag, and
> will also allow for adding similar functionality for re-loading debugctl
> in the active VMCS.
> 
> Opportunistically massage the TDX WARN and comment to prepare for adding
> more run_flags, all of which are expected to be mutually exclusive with
> TDX, i.e. should be WARNed on.
> 
> No functional change intended.
> 
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20250610232010.162191-3-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: 6b1dd26544d0 ("KVM: VMX: Preserve host's DEBUGCTLMSR_FREEZE_IN_SMM while running the guest")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

