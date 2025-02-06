Return-Path: <stable+bounces-114089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE5BA2AA02
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 14:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D534167A63
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 13:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC48D1EA7E8;
	Thu,  6 Feb 2025 13:32:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E65F1EA7D1
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848736; cv=none; b=etxESJnIgMkt5g0I6nodFM4V9PCvqrzJhe5G9+euhakTvAzoRppKNiC15/pKK4dE5HISERSRYzvWpcI92ENn6WG+YFPmszYp2DhPRE8QCiX/uJsaQj8ZIlF7tSkvSxp1AWDckHwfCLcfKNxr122wzNLGHiFeklTFfuZw6sxVSOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848736; c=relaxed/simple;
	bh=ogST319zHB0zhE9jRbaOO+sLcLnwd2QHq8LIMZfhqjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gr549cBkDN1zDVAMbe4odO5rdg0oYGNuzIJS4etaWpaA+igXe7tx7tAdM3XLGbnvfl1swtLSVrGY8Qp08kKG1r4V7GdvT71LMS/qVjOTCY10pezepinJG/KQWsA3LH3FSDJn61VCvmAqcPeudTa01OjfLEuQI74BxeCrCHN2QYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6E8DFEC;
	Thu,  6 Feb 2025 05:32:36 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 063D93F5A1;
	Thu,  6 Feb 2025 05:32:10 -0800 (PST)
Date: Thu, 6 Feb 2025 13:32:05 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com, eauger@redhat.com, fweimer@redhat.com,
	jeremy.linton@arm.com, oliver.upton@linux.dev, pbonzini@redhat.com,
	stable@vger.kernel.org, tabba@google.com, wilco.dijkstra@arm.com,
	will@kernel.org
Subject: Re: [PATCH 7/8] KVM: arm64: Mark some header functions as inline
Message-ID: <Z6S5rAYd5dfibJhd@J2N7QTR9R3>
References: <20250204152100.705610-1-mark.rutland@arm.com>
 <20250204152100.705610-8-mark.rutland@arm.com>
 <b76803b7-c1b3-426b-a375-0c01b98142c9@sirena.org.uk>
 <Z6SJAkogWN9D7ZKf@J2N7QTR9R3>
 <86seortkve.wl-maz@kernel.org>
 <Z6SVGbr7cvrVnNMz@J2N7QTR9R3>
 <86r04btfyd.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86r04btfyd.wl-maz@kernel.org>

On Thu, Feb 06, 2025 at 12:28:42PM +0000, Marc Zyngier wrote:
> On Thu, 06 Feb 2025 10:55:21 +0000,
> Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > On Thu, Feb 06, 2025 at 10:42:29AM +0000, Marc Zyngier wrote:
> > > On Thu, 06 Feb 2025 10:03:46 +0000,
> > > Mark Rutland <mark.rutland@arm.com> wrote:
> > > > That said, I'm going to go with the below, adding 'inline' to
> > > > kvm_hyp_handle_memory_fault() and using CPP defines to alias the
> > > > function names:
> > > > 
> > > > | static inline bool kvm_hyp_handle_memory_fault(struct kvm_vcpu *vcpu,
> > > > |                                                u64 *exit_code)
> > > > | {
> > > > |         if (!__populate_fault_info(vcpu))
> > > > |                 return true;
> > > > | 
> > > > |         return false;
> > > > | }
> > > > | #define kvm_hyp_handle_iabt_low         kvm_hyp_handle_memory_fault
> > > > | #define kvm_hyp_handle_watchpt_low      kvm_hyp_handle_memory_fault
> > > > 
> > > > I think that's clearer, and it's more alisnged with how we usually alias
> > > > function names in headers. Other than these two cases, __alias() is only
> > > > used in C files to create a sesparate exprted symbol, and it's odd to
> > > > use it in a header anyhow.
> > > > 
> > > > Marc, please should if you'd prefer otherwise.
> > > 
> > > Nah, that's fine by me.
> > > 
> > > My only issue was with marking functions as inline, and yet storing
> > > pointers to these functions. But it looks like the compiler (GCC 12.2
> > > in my case) is doing a good job noticing the weird pattern, and
> > > generating only one function, even if we store multiple pointers.
> > 
> > That's fair -- I'm fairly certain that we do this elsewhere too, but I
> > can switch to __maybe_unused if we're worried that might bite us in
> > future?
> 
> Sure, that'd be equally fine.

Looking around, we don't seem to do that elsewhere for functions in
headers, so I'll stick with inline for now unless anyone has a strong
opinion.

I'll send out v2 shortly.

Mark.

