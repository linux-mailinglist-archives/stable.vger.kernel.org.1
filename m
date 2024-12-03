Return-Path: <stable+bounces-98132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 698E49E2BDB
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 20:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 394F5B395F0
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F9A1F9EAB;
	Tue,  3 Dec 2024 17:10:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DF61F9F69;
	Tue,  3 Dec 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245830; cv=none; b=CcI75fsFi40GdtwwRcsULVPZXyhDSJ3Ia1ptYWypLEeH8WEnhwIf9z4L/C+wmmv8DAX7kNmdFYlK9p6jGVLTd1oDBSyd5qpR4RETdbK2hnDdGz8XL41yUoQvxuye8l6WAQN5W3wmYuHwFV+gxyi1cdP7/YbIGwmpH3oisPg9ZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245830; c=relaxed/simple;
	bh=layJ8AEP2jkieiFEILen2Xx0k2HD5GdQ7NJvRS5Hzpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnurQt5uEU1KHi/RH+i3Ms243LkKMJMfDRN9ELBJJtSxmZ2eRPGGcDdVi7+yO2eZw57KPMEcIp7/6SoqnRZ8YGpdeLdsjYTtmf6alBsBV6LfBNCykPliAaAQEJKQVDpveexOoWEphqe808VA5kW3GBZwzgGZx0tWoHUUUjhW1KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6E05FEC;
	Tue,  3 Dec 2024 09:10:54 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDD173F58B;
	Tue,  3 Dec 2024 09:10:25 -0800 (PST)
Date: Tue, 3 Dec 2024 17:10:23 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64/signal: Avoid corruption of SME state when
 entering signal handler
Message-ID: <Z087f9lkTBPFyOzA@e133380.arm.com>
References: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
 <20241203-arm64-sme-reenable-v1-5-d853479d1b77@kernel.org>
 <Z08kvi0znVM2RHx4@e133380.arm.com>
 <537fe318-a679-4b5c-b87f-93a7812dbeca@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <537fe318-a679-4b5c-b87f-93a7812dbeca@sirena.org.uk>

Hi,

On Tue, Dec 03, 2024 at 04:12:33PM +0000, Mark Brown wrote:
> On Tue, Dec 03, 2024 at 03:33:18PM +0000, Dave Martin wrote:
> > On Tue, Dec 03, 2024 at 12:45:57PM +0000, Mark Brown wrote:
> 
> > > +	get_cpu_fpsimd_context();
> 
> > > +		if (current->thread.svcr & SVCR_SM_MASK) {
> > > +			memset(&current->thread.uw.fpsimd_state.vregs, 0,
> > > +			       sizeof(current->thread.uw.fpsimd_state.vregs));
> 
> > Do we need to hold the CPU fpsimd context across this memset?
> 
> > IIRC, TIF_FOREIGN_FPSTATE can be spontaneously cleared along with
> > dumping of the regs into thread_struct (from current's PoV), but never
> > spontaneously set again.  So ... -> [*]
> 
> Yes, we could drop the lock here.  OTOH this is very simple and easy to
> understand.

Ack; it works either way.

Since this is a Fixes: patch, it may be better to keep it simple.

> 
> > > +		/* Ensure any copies on other CPUs aren't reused */
> > > +		fpsimd_flush_task_state(current);
> 
> > (This is very similar to fpsimd_flush_thread(); can they be unified?)
> 
> I have a half finished series to replace the whole setup around
> accessing the state with get/put operations for working on the state
> which should remove all these functions.  The pile of similarly and
> confusingly named operations we have for working on the state is one of
> the major sources of issues with this code, even when actively working
> on the code it's hard to remember exactly which operation does what
> never mind the rules for which is needed.

Sure, something like that would definitely help.

Cheers
---Dave

