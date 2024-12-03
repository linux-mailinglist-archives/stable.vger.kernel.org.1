Return-Path: <stable+bounces-98130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA3A9E2BED
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 20:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26C20B3E99D
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03981F76DD;
	Tue,  3 Dec 2024 17:00:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B851F8AE4;
	Tue,  3 Dec 2024 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245215; cv=none; b=nOR2Mn4mi5uvukOf/P8TN6/pmIkZleMLfeN8qLmvkDfQiPy5/sfVS4puRI49VP0Ogq6j9YcqFwr8OvvNSXZ+ITBem/Jip/V8fil4LR8VErOzFgjaCdoo+8GgLrssbKUYELUyI+RCRMBMiJdGOhJ7y4ryQb4KHuy0dr5kfsVa0rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245215; c=relaxed/simple;
	bh=K6Mo9QA394RSuqUOSYgaqvfgpcWPJYZdHRg2BCGaixk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHde8DbxelOAYjOXmMeDuyWPJGtw9UR0Uhc7svcQB+H2am4xCTuayTQa3P2GFgvNNlznRqA6DNsjYSA97BkSKvxoCznQa3RYNioyt3FdsK9LaBfnOJaMxYz1czkG/wsPup8LR7ltnrkAI9LYGIjIfsz6Npxx77aTWNW3kw/uAOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 529A7FEC;
	Tue,  3 Dec 2024 09:00:39 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64CCD3F58B;
	Tue,  3 Dec 2024 09:00:10 -0800 (PST)
Date: Tue, 3 Dec 2024 17:00:08 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/6] arm64/sme: Flush foreign register state in
 do_sme_acc()
Message-ID: <Z085GKS8jzEhcZdW@e133380.arm.com>
References: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
 <20241203-arm64-sme-reenable-v1-1-d853479d1b77@kernel.org>
 <Z08khk6Mg6+T6VV9@e133380.arm.com>
 <9365be76-8da6-47ce-b88e-dfa244b9e5b7@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9365be76-8da6-47ce-b88e-dfa244b9e5b7@sirena.org.uk>

On Tue, Dec 03, 2024 at 04:00:45PM +0000, Mark Brown wrote:
> On Tue, Dec 03, 2024 at 03:32:22PM +0000, Dave Martin wrote:
> > On Tue, Dec 03, 2024 at 12:45:53PM +0000, Mark Brown wrote:
> 
> > > @@ -1460,6 +1460,8 @@ void do_sme_acc(unsigned long esr, struct pt_regs *regs)
> > >  		sme_set_vq(vq_minus_one);
> > >  
> > >  		fpsimd_bind_task_to_cpu();
> > > +	} else {
> > > +		fpsimd_flush_task_state(current);
> 
> > TIF_FOREIGN_FPSTATE is (or was) a cache of the task<->CPU binding that
> > you're clobbering here.
> 
> > So, this fpsimd_flush_task_state() should have no effect unless
> > TIF_FOREIGN_FPSTATE is already wrong?  I'm wondering if the apparent
> > need for this means that there is an undiagnosed bug elsewhere.
> 
> > (My understanding is based on FPSIMD/SVE; I'm less familiar with the
> > SME changes, so I may be missing something important here.)
> 
> It's to ensure that the last recorded CPU for the current task is
> invalid so that if the state was loaded on another CPU and we switch
> back to that CPU we reload the state from memory, we need to at least
> trigger configuration of the SME VL.

OK, so the logic here is something like:

Disregarding SME, the FPSIMD/SVE regs are up to date, which is fine
because SME is trapped.

When we take the SME trap, we suddenly have some work to do in order to
make sure that the SME-specific parts of the register state are up to
date, so we need to mark the state as stale before setting TIF_SME and
returning.

fpsimd_flush_task_state() means that we do the necessary work when re-
entering userspace, but is there a problem with simply marking all the
FPSIMD/vector state as stale?  If FPSR or FPCR is dirty for example, it
now looks like they won't get written back to thread struct if there is
a context switch before current re-enters userspace?

Maybe the other flags distinguish these cases -- I haven't fully got my
head around it.


(Actually, the ARM ARM says (IMHTLZ) that toggling PSTATE.SM by any
means causes FPSR to become 0x800009f.  I'm not sure where that fits in
-- do we handle that anywhere?  I guess the "soft" SM toggling via
ptrace, signal delivery or maybe exec, ought to set this?  Not sure how
that interacts with the expected behaviour of the fenv(3) API...  Hmm.
I see no corresponding statement about FPCR.)

Cheers
---Dave

