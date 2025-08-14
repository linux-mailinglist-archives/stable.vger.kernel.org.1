Return-Path: <stable+bounces-169616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 786CDB26F77
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 21:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 509727ACFEE
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 19:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C481233733;
	Thu, 14 Aug 2025 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tlC0iwKG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7120207DFE
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755198284; cv=none; b=RBVM3yQOKgX/BQlFs9g1PBndUau0Z6T3p+DDnYVaNbFq12u73fyJzZXrLcB7Xx2uTG+N83x1PT6BNX6PRmkix4IzRePG2SI5OriZyjEewJIFbLU9CorPuZguxKcVadka9GkqxVzleDmshZw4dktQTTbAHBE2G/sdrZ7yEWGPbv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755198284; c=relaxed/simple;
	bh=qm4sJIAbvHbaMYpcH+1Lp87YAMKK3OmEhn43nB5qoAg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G5YFW4p5FAb7XZk9MTrEDqD9rRB4louT/L4bjVvFbDLVxjwhTQCFlhAgGt8J0evjyy8zQD67WUYz2FCmjozjvYrlrX+Y8HTnZqZ5my5cqR7bjMsZscEsl9aZfQDSO8s/WmHouQQoOYID9U9AlDMWDDjcxaVv7MT9CkYCrUPTxIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tlC0iwKG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24457f44a29so13981615ad.0
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 12:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755198282; x=1755803082; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ib1aMJQeVnxOBq2+znYic6DVJjnFLkElsxAP6tuqDCk=;
        b=tlC0iwKGjEuNGZKIr58S+syGYuLuK0rdUnfjNhAv7jTx14ixChnCTbDUaVma/cGlt+
         AIMS3mkpMr/lf4SGPNpPUHASr+T1Mnf1ETXeoQPbtglq5Y6pSMe+6U/qy8E3Bp/SOMJQ
         fTkFvAcSQd4Iw/WhJnmvMROP1bFj1FF3/tOvuRzlqh32L6u6SDvWYsd/twJ0l4pKQ01A
         PF4d52sTT9Sj+4YIZhMtNtM7/fNJt5YeXzLRR6a7yJXWcQkCsdB7wUb8wPCaKYgYGjXT
         aw1K4JKXYveXEWpAY6vN7KBNSO+AO/EvQCXu8Nmf/5tYUex3VUuKz2sc+qR1FY2iNARP
         Mv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755198282; x=1755803082;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ib1aMJQeVnxOBq2+znYic6DVJjnFLkElsxAP6tuqDCk=;
        b=e3m2q2VMTaxFy/A6HvxMYrH1kInoPkFpv8DGtR9Rn7l5HyuqilKfYqYW3Oez7gGjTo
         OAeFZ66S3EpKIX//pT1djVt8/xoOjDIHQ7wg0Jdn4jaHjhQ/F7pCgoVGdlM9KuzXuInb
         9iHMrXSvGaez6G8Le6YI/ILug2EdRFgK5Dyq5iiX/pu8kXypjovCpJfcsUh3gdn6RXRx
         b3Qe7rLBB8OikMsrSWwvr4ooFndGvLYwX9G55VEdBbVAM0n1rvjq4toj1p9Fp5MlpVUK
         fBuP4IBfIiS/Uxp0IGRB4cprFrFMykjPlSu9gbqATCG3BrMqeRyfc6aqEXmL0g7ZqmJX
         sGCA==
X-Gm-Message-State: AOJu0YzFoUtwfAdizVYuLBdo5oAwGJf5v8RmpPzj/NaSZrkVQd1ooui2
	RBkYfNyazhXQgiNPGVs6hZ8ZEHld4Mw8oYuSbFm6T70pO21oiYp7iZrgPh/kT+HBpEksnb8gbYD
	da+uOiA==
X-Google-Smtp-Source: AGHT+IEI+C0rlAmH3zBh0mBSUE4toz6V1mDNrj7lQVkWGfEe0JlgUObHmqJas/8VD64XqfM0vZQ5MunjeUI=
X-Received: from pjbov7.prod.google.com ([2002:a17:90b:2587:b0:31f:335d:342d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:230c:b0:240:5549:708e
 with SMTP id d9443c01a7336-244586c501emr66249995ad.46.1755198282070; Thu, 14
 Aug 2025 12:04:42 -0700 (PDT)
Date: Thu, 14 Aug 2025 12:04:40 -0700
In-Reply-To: <20250814131146.2093579-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081214-bonanza-germproof-173f@gregkh> <20250814131146.2093579-1-sashal@kernel.org>
Message-ID: <aJ4zSFLLsvhprN1K@google.com>
Subject: Re: [PATCH 6.6.y 1/3] KVM: VMX: Extract checking of guest's DEBUGCTL
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

