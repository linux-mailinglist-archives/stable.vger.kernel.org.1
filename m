Return-Path: <stable+bounces-110158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3C0A19102
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 12:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D9587A0F97
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 11:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6A7211A31;
	Wed, 22 Jan 2025 11:55:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A678B20FA85
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737546913; cv=none; b=b/zLe4M+5rzKElpBT2UVkoJnUJea6ce16/9aCQVHnCQO8ggonVqxWDe+karsDlG2Az635le7heJV/Of1uWOCcLx5iYvyF793XsGV30bbSHGrK4xgHbgos7LqwyssY4+3DFZjtXEOmlQhG4Tf894gs52YbPcE1GMdIX25ePPaEVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737546913; c=relaxed/simple;
	bh=v9TzIPPL+L5NtlVdVOp9hjTC4FUeT6bj5Q3a45lh3hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Md5GxhTqxKSqXvVXTn7Isw+G0D66NidMxw3KtA+Lo3kJP3GYOM81xtba16oX29LV2lgHpcjcrJ9+EJDzKPGt/H4IUJkwZT5H88aHFnDTRbnzFKXkigib4eudoMHJLPairwulzVR31djIHvErtchSToM5n1AF+ukLwwL+9g40tgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A9BE1007;
	Wed, 22 Jan 2025 03:55:39 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDC733F738;
	Wed, 22 Jan 2025 03:55:08 -0800 (PST)
Date: Wed, 22 Jan 2025 11:55:03 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, fweimer@redhat.com,
	jeremy.linton@arm.com, oliver.upton@linux.dev, pbonzini@redhat.com,
	stable@vger.kernel.org, wilco.dijkstra@arm.com, will@kernel.org
Subject: Re: [PATCH] KVM: arm64/sve: Ensure SVE is trapped after guest exit
Message-ID: <Z5DclwGtm_6TMCTJ@J2N7QTR9R3>
References: <20250121100026.3974971-1-mark.rutland@arm.com>
 <86r04wv2fv.wl-maz@kernel.org>
 <Z4--YuG5SWrP_pW7@J2N7QTR9R3>
 <86plkful48.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86plkful48.wl-maz@kernel.org>

On Wed, Jan 22, 2025 at 11:46:31AM +0000, Marc Zyngier wrote:
> On Tue, 21 Jan 2025 15:37:13 +0000, Mark Rutland <mark.rutland@arm.com> wrote:

> > Alternatively, we could take the large hammer approach and always save
> > and unbind the host state prior to entering the guest, so that hyp
> > doesn't need to save anything. An unconditional call to
> > fpsimd_save_and_flush_cpu_state() would suffice, and that'd also
> > implicitly fix the SME issue below.
> 
> I think I'd rather see that. Even if that costs us a few hundred
> cycles on vcpu_load(), I would take that any time over the current
> fragile/broken behaviour.

Cool -- I'll go do that. I'm also happier with that approach.

> > > > +		 *
> > > > +		 * If hyp code does not save the host state, then the host
> > > > +		 * state remains live on the CPU and saved fp_type is
> > > > +		 * irrelevant until it is overwritten by a later call to
> > > > +		 * fpsimd_save_user_state().
> > > 
> > > I'm not sure I understand this. If fp_type is irrelevant, surely it is
> > > *forever* irrelevant, not until something else happens. Or am I
> > > missing something?
> > 
> > Sorry, this was not very clear.
> > 
> > What this is trying to say is that *while the state is live on a CPU*
> > fp_type is irrelevant, and it's only meaningful when saving/restoring
> > state. As above, the only reason to set it here is so that *if* hyp
> > saves and unbinds the state, fp_type will accurately describe what the
> > hyp code saved.
> > 
> > The key thing is that there are two possibilities:
> > 
> > (1) The guest doesn't use FPSIMD/SVE, and no trap is taken to save the
> >     host state. In this case, fp_type is not consumed before the next
> >     time state has to be written back to memory (the act of which will
> >     set fp_type).
> > 
> >     So in this case, setting fp_type is redundant but benign.
> > 
> > (2) The guest *does* use FPSIMD/SVE, and a trap is taken to hyp to save
> >     the host state. In this case the hyp code will save the task's
> >     FPSIMD state to task->thread.uw.fpsimd_state, but will not update
> >     task->thread.fp_type accordingly, and:
> > 
> >     * If fp_type happened to be FP_STATE_FPSIMD, all is good and a later
> >       restore will load the state saved by the hyp code.
> > 
> >     * If fp_type happened to be FP_STATE_SVE, a later restore will load
> >       stale state from task->thread.sve_state.
> > 
> > ... does that make sense?
> 
> It does now, thanks. But with your above alternative suggestion, this
> becomes completely moot, right?

Yep.

[...]

> > So I can:
> > 
> > (a) Add the dependency, as you suggest.
> > 
> > (b) Leave that as-is.
> > 
> > (c) Solve this in a different way so that we don't need a BUILD_BUG() or
> >     dependency. e.g. fix the SME case at the same time, at the cost of
> >     possibly needing to do a bit more work when backporting.
> > 
> > ... any preference?
> 
> My preference would be on (c), if at all possible. My understanding is
> now that the fpsimd_save_and_flush_cpu_state() approach solves all of
> these problems, at the expense of a bit of overhead.
> 
> Did I get that correctly?

Yep -- I'll go spin that now.

Mark.

