Return-Path: <stable+bounces-169626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8369B27032
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 22:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE3F1CE02A4
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 20:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C22248F4F;
	Thu, 14 Aug 2025 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFStVlqM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C9E31984B
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 20:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755203478; cv=none; b=pjr6oNkcq8/Ok18D0SzZFiLgTbmXSkXGuuqI0zRYktdQv51jzeC9Dt6ocptew8yTPaC8VS0hZT4NeKDNtkix/lDdL5f3JcmzoQfhMG6G+sMOD2WKvfobLZYxAZqBm2UJrMZth3bphs5lPMr+adQzq+U0sGXaCs78zqytmxpKnu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755203478; c=relaxed/simple;
	bh=qm4sJIAbvHbaMYpcH+1Lp87YAMKK3OmEhn43nB5qoAg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yo+/07TkT/ELhGSWP2EPlE7hjoflmAjxI/8WcWXZVbBb0MmagkrRPNmiEkgWJlMnl+YNKP0vvRkMOina0WtZNGRtcOD9YnV1b6tcRp4hDtgaA0eNrrsAvg5jb/7+JauCySaGYTJsxfa7wswbMpQv3afW8r+rC45T0WVyyFO+1EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GFStVlqM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326e0c0baso1484799a91.2
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 13:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755203476; x=1755808276; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ib1aMJQeVnxOBq2+znYic6DVJjnFLkElsxAP6tuqDCk=;
        b=GFStVlqMEToMnnBVW/t3BBBf+fKe/EWXHqAebaHCelBnJ0vn3ZIjHoCHugk1HyhOUv
         XZ8hxcypdIwCDaoUgT5Yht5iK1uRUiX/Upv6Nmp46+4ADB5dL9BDEUCZLAwO48olwcda
         l2HXJvb2ApACcMiDYcZblGr6K+iHBUfj1DzZxcdGFVsH/OPBF3ec+zUooSOxoGBF3I53
         JGLBO5lTXD7ixg8N4WvlfwOcw4geWL+cVi9FqgMYbmwh1myEEnpGIIBjsVLgTcFfzEP/
         Svt/6lDeWyvHmm1YaPjZ8SGCulFrpMd6L0LOg3YseNt4SpdYfTWq0WlFxBjA3eIVQvgM
         7PdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755203476; x=1755808276;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ib1aMJQeVnxOBq2+znYic6DVJjnFLkElsxAP6tuqDCk=;
        b=vIx+qtty+HchvzMPpMExZAlbKuGXAGE0HFytjSiJFRJpL/cYoGmvag+4VpxBFXXo27
         kiNXd6K31KU9+UZ2zGPJbXzfGOvWAoMcQD32pDm07cOX8U1AQ5Og3cHyEDXqDvFgu+Q6
         FNxxwLmI7mUbQrdFlLDwkLjJ7jLxbuR+50CvKDmSdcXeedD1h2RTNHzdjVaJETZdIvEd
         E0Mp27aWvFB08HWQolGf+wVKYiFNXIfJUezhZ8IF/9PitsGcU6d2xU+aLdODtBwC4J5R
         VVEAO79kOst/hkiKIt7PkGJvIb6eLBHDkE6WMMr8CS2/l44ZPJ/nv2M0a5frJx8NmoEb
         PABQ==
X-Gm-Message-State: AOJu0YzAwIBP7q6t1Hfamve6sw6vglgFzcKi3R9WdcP69H/xF5bC+Sd9
	ZSuCTuHrDdk3TqKEjYGavwJc1SwpkvAD/xSyfj301lvwBfRrf3O1G3/RGBUW2eZx2oCtRT7Pp+u
	9n00OpQ==
X-Google-Smtp-Source: AGHT+IGAk5Rt0iVHjAv7+OLMHWXT0RalVdtnOhHsAyf8sNuHs1k96r7ax+3CJUWjBDjtPWdAGuW7mWCB+4E=
X-Received: from pjbsd7.prod.google.com ([2002:a17:90b:5147:b0:31e:a094:a39])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38ce:b0:31a:ab75:6e45
 with SMTP id 98e67ed59e1d1-32327ac0f4cmr6461002a91.28.1755203476387; Thu, 14
 Aug 2025 13:31:16 -0700 (PDT)
Date: Thu, 14 Aug 2025 13:31:14 -0700
In-Reply-To: <20250814132434.2096873-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081215-variable-implicit-aa4c@gregkh> <20250814132434.2096873-1-sashal@kernel.org>
 <20250814132434.2096873-2-sashal@kernel.org>
Message-ID: <aJ5HkiaWkprgGWhd@google.com>
Subject: Re: [PATCH 6.1.y 2/4] KVM: VMX: Extract checking of guest's DEBUGCTL
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

