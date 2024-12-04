Return-Path: <stable+bounces-98287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4C19E38DC
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 12:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B995F16084C
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 11:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5091B21AB;
	Wed,  4 Dec 2024 11:33:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7EA1B0F36;
	Wed,  4 Dec 2024 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311989; cv=none; b=WXbVUev2NPE4y1FCJ5YiPvQiP6xfVXVFtfP+Atb+zEWd5bIfsPXxstrt2+Mcq0xM7sOI4m/lokURLZKDCc9SOCaBZb/Pe6vRaFRq4ieq+RsF98YXNqUm9xkylHUmH3GA5ErqYP2SrYgQscNjI6/TiTWuCXMNR2HY0CAd4c5ap6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311989; c=relaxed/simple;
	bh=4WTW9FUmZwSnNbESxNLpj77cDzjJTxm2vPyChPJTCXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfGCd3gr3Sr8DQqE9/V0aO7Ob27vh4ryoMoT+vyFzdj4tR0By3IFH3DjXxcA6DZozacjIorc7i0Fn9xd3YZ12VNATGXMOxeCJd/LyqxUIkVQnSYMJEFaxqJh+DxRvsqiAzZuqQAo73q6F7MosbOMbm93jlrmkBMaGhA5iYt3kew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC120FEC;
	Wed,  4 Dec 2024 03:33:33 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F9C33F71E;
	Wed,  4 Dec 2024 03:33:04 -0800 (PST)
Date: Wed, 4 Dec 2024 11:33:02 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/6] arm64/sme: Flush foreign register state in
 do_sme_acc()
Message-ID: <Z1A97pR+un1Trtyg@e133380.arm.com>
References: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
 <20241203-arm64-sme-reenable-v1-1-d853479d1b77@kernel.org>
 <Z08khk6Mg6+T6VV9@e133380.arm.com>
 <9365be76-8da6-47ce-b88e-dfa244b9e5b7@sirena.org.uk>
 <Z085GKS8jzEhcZdW@e133380.arm.com>
 <44d67835-1e43-47cc-9a18-c279c885dcec@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44d67835-1e43-47cc-9a18-c279c885dcec@sirena.org.uk>

On Tue, Dec 03, 2024 at 05:24:39PM +0000, Mark Brown wrote:
> On Tue, Dec 03, 2024 at 05:00:08PM +0000, Dave Martin wrote:
> > On Tue, Dec 03, 2024 at 04:00:45PM +0000, Mark Brown wrote:

[...]

> We know that the only bit of register state which is not up to date at
> this point is the SME vector length, we don't configure that for tasks
> that do not have SME.  SVCR is always configured since we have to exit
> streaming mode for FPSIMD and SVE to work properly so we know it's
> already 0, all the other SME specific state is gated by controls in
> SVCR.
> 
> > fpsimd_flush_task_state() means that we do the necessary work when re-
> > entering userspace, but is there a problem with simply marking all the
> > FPSIMD/vector state as stale?  If FPSR or FPCR is dirty for example, it
> > now looks like they won't get written back to thread struct if there is
> > a context switch before current re-enters userspace?
> 
> > Maybe the other flags distinguish these cases -- I haven't fully got my
> > head around it.
> 
> We are doing fpsimd_flush_task_state() in the TIF_FOREIGN_FPSTATE case
> so we know there is no dirty state in the registers.

Ah, that wasn't obvious from the diff context, but you're right.

I was confused by the fpsimd_bind_task_to_cpu() call; I forgot that
there are reasons to call this even when TIF_FOREIGN_FPSTATE is clear.
Perhaps it would be worth splitting some of those uses up, but it would
need some thinking about.  Doesn't really belong in this series anyway.

> > (Actually, the ARM ARM says (IMHTLZ) that toggling PSTATE.SM by any
> > means causes FPSR to become 0x800009f.  I'm not sure where that fits in
> > -- do we handle that anywhere?  I guess the "soft" SM toggling via
> 
> Urgh, not seen that one - that needs handling in the signal entry path
> and ptrace.  That will have been defined while the feature was being
> implemented.  It's not relevant here though since we are in the SME
> access trap, we might be trapping due to a SMSTART or equivalent
> operation but that SMSTART has not yet run at the point where we return
> to userspace.
> 
> > ptrace, signal delivery or maybe exec, ought to set this?  Not sure how
> > that interacts with the expected behaviour of the fenv(3) API...  Hmm.
> > I see no corresponding statement about FPCR.)
> 
> Fun.  I'm not sure how the ABI is defined there by libc.

I guess this should be left as-is, for now.  There's an argument for
sanitising FPCR/FPSR on signal delivery, but neither signal(7) nor
fenv(3) give any clue about the expected behaviour...

For ptrace, the user has the opportunity to specify exactly what they
want to happen to all the registers, so I suppose it's best to stick to
the current model and require the tracer to specify all changes
explicitly rather than add new magic ptrace behaviour.

Not relevant for this series, in any case.

Cheers
---Dave

