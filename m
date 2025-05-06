Return-Path: <stable+bounces-141745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB6FAAB8FD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5753BC526
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4E2297A4B;
	Tue,  6 May 2025 03:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b97niDiW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E06B298997
	for <stable@vger.kernel.org>; Tue,  6 May 2025 01:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746493474; cv=none; b=HfH0tY7X3eOAvJaGEg7mcdyk6F2rVgaIsCJd4blI2wWn/YnJ4i1ZyLdPvparT563TsPndtnmkDmLNOMy2zbwwVshP+ur7+G9JCfCQXTf2KkWhoN8VTnVm04LGw/xlsmLQ2tV0k7Q2lg0CTQI8e0+0fNsng4CTQI7A3k8G2ujl5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746493474; c=relaxed/simple;
	bh=YxKErPKqB1yhT8kB53msiulttYQI4O2yls7UujzmHhs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SffiuerSDJAYryXnnmpecc2f7VWShxFx7vjC5W9IHDvUEF3pFj9dgUHpm35mbw1baE5guk/qvgHpCFGrppxlTzdLANvJRx+6bRxcAHLOFXKHqs8tugoYsVnXwyTKguW6BhccGYM2DLTgFOzqfXrXmwXI7WeRjiZwHV+IiUQ4FCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b97niDiW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30a0a8ddcc4so5267238a91.3
        for <stable@vger.kernel.org>; Mon, 05 May 2025 18:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746493473; x=1747098273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SocenwpJ1lxGwEmYMcIawyM4BAz5/nHkaKsC+d97qlQ=;
        b=b97niDiWFHMHCc+HuDVKMFEN6UvmLxTlkwS+Yb5dGU6PGU20khsryiWw+F8M9cyOPV
         bHbAq120E+kVmdfDOsoOM6Jl+EGxn35oStNyOnBfXjvLAi5PfBHnHAOJHttjPLXoKefl
         55MbsT/mjLZaCZh3dU3b+qnRS36L+JlJziLvw40A+Vcu4g9kMGvLlcGTxDb3eUJbw/kY
         xf3e0ixR/Pjiy7Aqa6y6GISmC9Pr0HA+E/+7UCGwUmUPPoddTwlKnLzm14D5tArEK5Iz
         9MPy8LPskuVkJfJ2lr79hD23ikYX7MR2SjQUoQVuyQrlWozgaaPFadQAlYPd6KZW/Wrp
         FZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746493473; x=1747098273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SocenwpJ1lxGwEmYMcIawyM4BAz5/nHkaKsC+d97qlQ=;
        b=vf4PFaGE0FRlI5nuDIPIfSbhsJV3eE47WhEnq/TlOkF/7SQXWDE6s5W6ng8AWd7O9V
         ywDzf65AL7KEATEK2txOBTIc/Z3UypE1xAGaf9d715DDfRk0A0HQ4lApQMuxhghF4mFc
         ssxj79RehTSaa6Z9MEzueSnlhuXRClOMANanwXUaGDuecsD0sOTFzI+D7+gfbyej0nGK
         AylRkuxcdyyPc6OsYe+ApC2vRa9ANx/GtoUYuxZfwYLAXJR/4dqhraS4YPUPH8EEelRe
         zZTAgV1sl3kK4mDDpWUURTbcJJS6JviYk2lSoWtngETfQiTqiX9MKiEFu4mepaWb/xib
         hg4g==
X-Forwarded-Encrypted: i=1; AJvYcCW4Z177xXUI3wjhfpRa568WrgZYmWx3K3EF/+syaUI5RlZJW5+F+d0NHVyTVm8mied+lRIQ0Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUIkzEmCoyJHVim0s7VlQXUxfh/fmMLTaptviLVZq7fbWjbGRI
	dUKs7K6eNUxNtdH6WDX6upxapt4Mw3uM8AGBYuqSQA+w0PMdndMbQ+6IpOE37YNfsBqe/hSSwnt
	11A==
X-Google-Smtp-Source: AGHT+IGdlsB+EHSVfbtv8XHlKK/WjJXJWIgHA3FCb9kGzawtjlIfFplRDWV+n/TPPTG4wzGKzuChBtuKRNY=
X-Received: from pjbkl6.prod.google.com ([2002:a17:90b:4986:b0:2ef:8055:93d9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:578f:b0:2ee:f076:20f1
 with SMTP id 98e67ed59e1d1-30a6174fda0mr16698675a91.0.1746493472687; Mon, 05
 May 2025 18:04:32 -0700 (PDT)
Date: Mon, 5 May 2025 18:04:31 -0700
In-Reply-To: <71D468BB-CE40-47DC-8E3D-74C336B15045@alien8.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aAfQbiqp_yIV3OOC@google.com> <20250422173355.GDaAfTA8GqnGBfDk7G@renoirsky.local>
 <aAfynEK3wcfQa1qQ@google.com> <20250423072017.GAaAiUsYzDOdt7cmp2@renoirsky.local>
 <aAj0ySpCnHf_SX2J@google.com> <20250423184326.GCaAk0zinljkNHa_M7@renoirsky.local>
 <aAqOmjQ_bNy8NhDh@google.com> <20250424203110.GCaAqfjnr-fogRgnt7@renoirsky.local>
 <aAwj_Tkqj4GtywDe@google.com> <71D468BB-CE40-47DC-8E3D-74C336B15045@alien8.de>
Message-ID: <aBlgH4CAsO9oYXAo@google.com>
Subject: Re: CONFIG_X86_HYPERVISOR (was: Re: [PATCH AUTOSEL 5.10 2/6] x86/cpu:
 Don't clear X86_FEATURE_LAHF_LM flag in init_amd_k8() on AMD when running in
 a virtual machine)
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Max Grobecker <max@grobecker.info>, Ingo Molnar <mingo@kernel.org>, 
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, 
	x86@kernel.org, thomas.lendacky@amd.com, perry.yuan@amd.com, 
	mario.limonciello@amd.com, riel@surriel.com, mjguzik@gmail.com, 
	darwi@linutronix.de, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, Apr 26, 2025, Borislav Petkov wrote:
> On April 26, 2025 3:08:29 AM GMT+03:00, Sean Christopherson <seanjc@google.com> wrote:
> >No, that would defeat the purpose of the check.  The X86_FEATURE_HYPERVISOR has
> >nothing to do with correctness, it's all about performance.  Critically, it's a
> >static check that gets patched at runtime.  It's a micro-optimization for bare
> >metal to avoid a single cache miss (the __this_cpu_read(cpu_dr7)).  Routing
> >through cc_platform_has() would be far, far heavier than calling hw_breakpoint_active().
> 
> Huh, we care so much about speed here?

That's a PeterZ question :-)

