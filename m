Return-Path: <stable+bounces-169628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2A4B27036
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 22:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFEA3A1866
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 20:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69A1245022;
	Thu, 14 Aug 2025 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="29k5/Vh1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6762331984B
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 20:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755203518; cv=none; b=fkAn1TXi0FfPTdN7BV0OJ4Pnh+z9Lmcz+QT0Uqf4Uxq76qPO26ZIsW2BSMSRgJM4VHRo+v2xBlG5aOvBA+zbPG3Vz8o1JbaHoa5KBRPjM8iNiLoAKqmQqhgJFf7Lm7oRVVDnBM8Z12FUK1w/8SnTtlNaqVIvlPZ81RC3WcHWM/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755203518; c=relaxed/simple;
	bh=3M6olNCkfBgg79SBlkoN6YaHd1iwdF64SMcb1OiDJSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hoTafG3ehELu2bcDweQ2lLxh7br7dwtESCuJC0+Ja+wODGgFFt+njCGbpf8RgYgf/up/ux0lTG5lTl0vw396rj2Ks6D0aHYpJx7ea4JCxOsXgAxJIYh8RoO5Sm5FQXIGTGn8zMe6jMVHnCtmaL+ru0yMH7/6NvjpcsvSKpk8tdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=29k5/Vh1; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4716fb3aedso895106a12.0
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755203516; x=1755808316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dZln5AlMLNKwBYNNEImRxFo070vZbrB9DRk7vU6UURM=;
        b=29k5/Vh1tbVjgABpXe9em/37dU3Qvf840drH+yHJespDrLeDcb6nn+Bp2wIlWUo3gZ
         pgLW58Bfg0JrTtroUKQ84sI776r2xAy51qUe4AFl4thfl6kEG4LUPxsDahOKLP7yyLCz
         FS3xwttPB/mMOytKhUVm6rBNSgTXDCVTSFi3IeL68E5bCAw1Vb0UzGn6bjsKaUgv80UQ
         iSH1XWYTS5uGMo9JRp34kNlMyGy6dAvQPk7Vm7HohFmbhXrke6kAkh5L3sxSKVL+0SbP
         iszeEcr7Pb8qwJF4Qh06LoB6EPa7k2dslncEqTeEf//d6gBAPJbf+xqQSOY9j0+Ny2Ht
         jKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755203516; x=1755808316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZln5AlMLNKwBYNNEImRxFo070vZbrB9DRk7vU6UURM=;
        b=eFQfZbscw+eNX7NxJkkowCcnVru/CQ1Ixd1gSfqTaAE4K7IX3759k6r8ZC7vt7kto+
         QfBNKSslOhZ9eQZM4nauMo8QBaYPe+q5sCBftWhwBOuF8mEFs1tkTC8M8DrMx5jRp/YX
         kEWX1HaQNYGNES2qyOaJPsQtFQpLyrJjZMHo+5cNyT6SylAC0uemTxQ5X7hBGRNH4rT6
         mDOEN2XPXqjeRLgg5F9ZNTb9N8Metp4YrXONKOUkkjPWvsRuiYb7yKHF39ycpH7aDz/t
         GC44WvkKc21uBMV3SWb87PixgbX2uboCcHeUj2VFlfrQ0edl/jmShBk8iriUTZ4xbMQv
         qKGA==
X-Gm-Message-State: AOJu0YwNMR7sj5oY+OQlvmN+iOc7L83DB3TvoWaoE1iJh4G8VvMNvBej
	6EZCY+pGZR8bnGHGVUBi3lsjfHH13KiC1F9uQaO1SrT27xjveS4FZWhrb1EbXDY1EAj+o3Gngut
	KYPIiGg==
X-Google-Smtp-Source: AGHT+IHNf+bQcSx2oh25JtWWGs2NnMsV1i2M0oht9aK6mFQAMYcnJ/hcTp0n0Plru10yLB6SGwK/WrOYgpk=
X-Received: from pjuw7.prod.google.com ([2002:a17:90a:d607:b0:31f:6ddd:ef5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f68f:b0:23f:f68b:fa1d
 with SMTP id d9443c01a7336-244586c6bedmr75585855ad.39.1755203516468; Thu, 14
 Aug 2025 13:31:56 -0700 (PDT)
Date: Thu, 14 Aug 2025 13:31:54 -0700
In-Reply-To: <20250814132434.2096873-4-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081215-variable-implicit-aa4c@gregkh> <20250814132434.2096873-1-sashal@kernel.org>
 <20250814132434.2096873-4-sashal@kernel.org>
Message-ID: <aJ5Hut4Af3P8Lpn6@google.com>
Subject: Re: [PATCH 6.1.y 4/4] KVM: VMX: Wrap all accesses to IA32_DEBUGCTL
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
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

