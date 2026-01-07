Return-Path: <stable+bounces-206186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1C0CFEFCB
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 18:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14A933455331
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 16:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5DD3A7F67;
	Wed,  7 Jan 2026 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQjsH7jj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0900438D4BC;
	Wed,  7 Jan 2026 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767803637; cv=none; b=u70Ma8+EaWRfgthavs8MDAhRiOP6t8MnPMQ6wcOCh41jRBkZu/ArvfeTpwCVp0wh0cYFNqr+w0dyzmYDeJ6az8FC70f+ZuRQddrh8myqgmtIYPK6GWI3D2ZXZ/LW2jCGi6YL7A5H4RDz/qowAgHwJSMKOQMw7vxqHtZ4aI3z3yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767803637; c=relaxed/simple;
	bh=WmWZBR3qZNNjQFP+VxnmCTmNhfkitwmDjgm+bpwc6KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldEFJ4fz24glbdacTMhAlC4oQoYfpwFBZlu7BrbdKaZZej6g81CPKG/7GR6clUBCyQ62jv7wDwBbMmsBI4PjRJhpCiLo4o9P2FmUqF+vovYRUdC19hjeN6i1nu183OWQyMv5slYJOGVwdP/CxLMhZUfRJLY0jFmh23zan5/ThHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQjsH7jj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8966CC4CEF1;
	Wed,  7 Jan 2026 16:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767803635;
	bh=WmWZBR3qZNNjQFP+VxnmCTmNhfkitwmDjgm+bpwc6KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JQjsH7jjzEOMh+NzlZcnrEdADGCJJIxJZN7laW2VI8p5q+R1QTKR+JDMHOEZY08cb
	 WIcsEzdKjUlhQ3aJ1+NJgBauqORDgkX/Kg15AONFGN/g+bw/aR4jyGVz65EjXhvq2f
	 lXmynqhZBxA/SH8nwJGx4niEPtEFAdrAIy8qIDsoxJEmp7auFXiVqgL6EpgS32B+Jl
	 3Ec14JWh4Txt90r28e+3rqmxPsWOdGKYi1wHTV/GL0Wu1k5teQnFsgTb2ze02s9TLY
	 lNM1bz1HWJbOQnZL5f0lxzaaXINEocyqXmemb1HugN0Gq5QXgL3Hz+utGafb3Cj1JA
	 wa6PZPI8SIc1Q==
Date: Wed, 7 Jan 2026 16:33:49 +0000
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Lucas Wei <lucaswei@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, sjadavani@google.com,
	kernel test robot <lkp@intel.com>, stable@vger.kernel.org,
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, smostafa@google.com
Subject: Re: [PATCH v2] arm64: errata: Workaround for SI L1 downstream
 coherency issue
Message-ID: <aV6K7QnUa7jDpKw-@willie-the-truck>
References: <20251229033621.996546-1-lucaswei@google.com>
 <87o6ndduye.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6ndduye.wl-maz@kernel.org>

Hey Marc,

On Thu, Jan 01, 2026 at 06:55:05PM +0000, Marc Zyngier wrote:
> On Mon, 29 Dec 2025 03:36:19 +0000,
> Lucas Wei <lucaswei@google.com> wrote:
> > diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> > index 8cb3b575a031..5c0ab6bfd44a 100644
> > --- a/arch/arm64/kernel/cpu_errata.c
> > +++ b/arch/arm64/kernel/cpu_errata.c
> > @@ -141,6 +141,30 @@ has_mismatched_cache_type(const struct arm64_cpu_capabilities *entry,
> >  	return (ctr_real != sys) && (ctr_raw != sys);
> >  }
> >  
> > +#ifdef CONFIG_ARM64_ERRATUM_4311569
> > +static DEFINE_STATIC_KEY_FALSE(arm_si_l1_workaround_4311569);
> > +static int __init early_arm_si_l1_workaround_4311569_cfg(char *arg)
> > +{
> > +	static_branch_enable(&arm_si_l1_workaround_4311569);
> > +	pr_info("Enabling cache maintenance workaround for ARM SI-L1 erratum 4311569\n");
> > +
> > +	return 0;
> > +}
> > +early_param("arm_si_l1_workaround_4311569", early_arm_si_l1_workaround_4311569_cfg);
> > +
> > +/*
> > + * We have some earlier use cases to call cache maintenance operation functions, for example,
> > + * dcache_inval_poc() and dcache_clean_poc() in head.S, before making decision to turn on this
> > + * workaround. Since the scope of this workaround is limited to non-coherent DMA agents, its
> > + * safe to have the workaround off by default.
> > + */
> > +static bool
> > +need_arm_si_l1_workaround_4311569(const struct arm64_cpu_capabilities *entry, int scope)
> > +{
> > +	return static_branch_unlikely(&arm_si_l1_workaround_4311569);
> > +}
> > +#endif
> 
> But this isn't a detection mechanism. That's relying on the user
> knowing they are dealing with broken hardware. How do they find out?

Sadly, I'm not aware of a mechanism to detect this reliably at runtime
but adding Robin in case he knows of one. Linux generally doesn't need
to worry about the SLC, so we'd have to add something to DT to detect
it and even then I don't know whether it's something that is typically
exposed to non-secure...

We also need the workaround to be up early enough that drivers don't
run into issues, so that would probably involve invasive surgery in the
DT parsing code.

> You don't even call out what platform is actually affected...

Well, it's an Android phone :)

More generally, it's going to be anything with an Arm "SI L1" configured
to work with non-coherent DMA agents below it. Christ knows whose bright
idea it was to put "L1" in the name of the thing containing the system
cache.

> The other elephant in the room is virtualisation: how does a guest
> performing CMOs deals with this? How does it discover the that the
> host is broken? I also don't see any attempt to make KVM handle the
> erratum on behalf of the guest...

A guest shouldn't have to worry about the problem, as it only affects
clean to PoC for non-coherent DMA agents that reside downstream of the
SLC in the interconnect. Since VFIO doesn't permit assigning
non-coherent devices to a guest, guests shouldn't ever need to push
writes that far (and FWB would cause bigger problems if that was
something we wanted to support)

+Mostafa to keep me honest on the VFIO front.

Will

