Return-Path: <stable+bounces-134637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5027FA93BDB
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 19:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9329F3B6C49
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AEB218AD4;
	Fri, 18 Apr 2025 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VT3MPZzZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763A62192E0
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744996757; cv=none; b=FDJDb2zvKIhS3mqXx66mYIiQmUJhrNExAeBTkoRWnIUXTNO0F3JZd9aqjN9VWPLrAisLEaLwk1U/x5Cl4Ybtjx8OSUN4M3aI04N/nhtpUSYnp6XVURotcB50z1w7AdIgvW3yYvJrB+/dp9GRbTtu3O6T9ppk8t1Zt42RDmIKa4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744996757; c=relaxed/simple;
	bh=umH6ywsc4drx9G9NcplmJ0TyaUjkmwExCrK7GVRNt5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q6WuWShYI/WY28x3+pjJtUfAV/qivC6q3z49McDD9WfRNR1S6DFVpbCNL+LXASGsjP/Z6R92wA/V8cHSVzOBOWBjSTQpumPhRlOwXNJ25MegoRQNvH/AXbzPdhkgTv0uRkNPsGka3CBKp8zmBe252ikqbf3qg2FreZY323sTin4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VT3MPZzZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3085f5855c4so1836728a91.1
        for <stable@vger.kernel.org>; Fri, 18 Apr 2025 10:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744996756; x=1745601556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JAMiTnJq5wGTimzHorBniJSJQObCz8zh4bLLKuMUOgs=;
        b=VT3MPZzZ3msHT1dZ/LgMoKOu7PthXRi4XQgX2oplccXQv3iA/oYjAnqreKsJhXDPvW
         NYgMmMwlg7bAI+OMZOSnJVnX6bYLt2cR6t5y9m2bYKaCAx1BdpBkB4P2lrQ9xCUu1YUp
         jK3SSdxDxNpzXm2vq8fVYMdylRQiXpRe9iV+rniQLGTdVsOeuiVAd4DPXGOrJBQ6ICZV
         mmkRP8hbixGpBm4htemOKsJOilwLR7qRNZNJ4GNVV2f7pU9HULWijOKsVgwy7/zUukkP
         OE3PGk2FlzbCDVDIaIw/5Ke3P/mjpV9XiKIMu1xlTL24VQzZ3rGb+q4JTf62To2r29mo
         PSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744996756; x=1745601556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JAMiTnJq5wGTimzHorBniJSJQObCz8zh4bLLKuMUOgs=;
        b=qUPjlHqYztDWrh/DMTFDYN16I/04nUS23gT7KURhheyXPOnt3uCexXHqKQp7XoC4Wa
         eBwuoAteMnoSghnWp0kCUl4Rt9MEBf38LZsG6OI8x150q2QpZk5H164U5XvdutQBG3FH
         NIzz0JuJqm+v4PxAghfI8Zuyg4yz5S2OCsWWmPVzwi3hw4btvUJZ7FYWXUjO2s2J+fwY
         vvPhI7l+DKby8W7/vN+VTWcEt4H0+zyzIftcrmLhK2mOOSvnlkbmpPgfJgWYkbJCz4WL
         4R6C4OQT8cHLtOjv3HY87zK4MxErCufHk8pViG84+pAFovyOHcJWNoJRmR7l+dSySmsx
         AiLA==
X-Forwarded-Encrypted: i=1; AJvYcCVdryw3E94qRE67OurU4jChPMMonVIucwjbw6V8mMwJ3//co8wisoudlY4lbG3MSRjOnzm1O3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyilMVoo6w9r2IWIHawBHBXb1Q6o/zrneeb58JH+jGn93NoCTrK
	E51efVa3/JTKyL/dQx/mRhv4qZm6UPtA8xBpfdHPdPbBb8l2bfjLjEwWZR+2ILiu9zGmxSMnKgx
	b0w==
X-Google-Smtp-Source: AGHT+IFYpkpjQzZ7Z5ctAJdgsF/swLP7xsl0a2d3B1YurqSDpfIGlQl4nOWEChP8tGh5x1hWI4qHIsV7y44=
X-Received: from pjbee4.prod.google.com ([2002:a17:90a:fc44:b0:308:7499:3dfc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:37c5:b0:2fe:8902:9ecd
 with SMTP id 98e67ed59e1d1-3087bb3e830mr4814615a91.1.1744996755737; Fri, 18
 Apr 2025 10:19:15 -0700 (PDT)
Date: Fri, 18 Apr 2025 10:19:14 -0700
In-Reply-To: <aAKDyGpzNOCdGmN2@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250331143710.1686600-1-sashal@kernel.org> <20250331143710.1686600-2-sashal@kernel.org>
 <aAKDyGpzNOCdGmN2@duo.ucw.cz>
Message-ID: <aAKJkrQxp5on46nC@google.com>
Subject: Re: [PATCH AUTOSEL 5.10 2/6] x86/cpu: Don't clear X86_FEATURE_LAHF_LM
 flag in init_amd_k8() on AMD when running in a virtual machine
From: Sean Christopherson <seanjc@google.com>
To: Pavel Machek <pavel@denx.de>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Max Grobecker <max@grobecker.info>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, 
	x86@kernel.org, thomas.lendacky@amd.com, perry.yuan@amd.com, 
	mario.limonciello@amd.com, riel@surriel.com, mjguzik@gmail.com, 
	darwi@linutronix.de
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 18, 2025, Pavel Machek wrote:
> Hi!
> 
> > From: Max Grobecker <max@grobecker.info>
> > 
> > [ Upstream commit a4248ee16f411ac1ea7dfab228a6659b111e3d65 ]
> 
> > This can prevent some docker containers from starting or build scripts to create
> > unoptimized binaries.
> > 
> > Admittably, this is more a small inconvenience than a severe bug in the kernel
> > and the shoddy scripts that rely on parsing /proc/cpuinfo
> > should be fixed instead.

Uh, and the hypervisor too?  Why is the hypervisor enumerating an old K8 CPU for
what appears to be a modern workload?

> I'd say this is not good stable candidate.

Eh, practically speaking, there's no chance of this causing problems.  The setup
is all kinds of weird, but AIUI, K8 CPUs don't support virtualization so there's
no chance that the underlying CPU is actually affected by the K8 bug, because the
underlying CPU can't be K8.  And no bare metal CPU will ever set the HYPERVISOR
bit, so there won't be false positives on that front.

I personally object to the patch itself; it's not the kernel's responsibility to
deal with a misconfigured VM.  But unless we revert the commit, I don't see any
reason to withhold this from stable@.

