Return-Path: <stable+bounces-114069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3AFA2A69D
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 12:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3DA3A8D37
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 11:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA66622AE71;
	Thu,  6 Feb 2025 10:55:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB59235C1C
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839328; cv=none; b=rAuf9zZb3PQCuQQ+9A4Fp4Mc8l+aX4rjcKAQmMWe2JOJ549k5M7vInGq6oTVzg6H1Lbp5oF10Z6yXUwJNsYOpTnDX3pSJYGuswToWqTQfM6HNpyXbJuXQomJpiFze+Ff5H0bpC89CJH+9/TM4JccgX29DzcOAgsOiNJMkyFHm2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839328; c=relaxed/simple;
	bh=sy8M91HBUWr7M/07pVxnLLD9fdpd6WvT6C95wTdtHVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrLH8suo9oVHyT4GdxomE7XmctioL1CupNv3Fjdq/34jzaTaqKcvDiOE7GG/QRE3Ko5G01qKxniEt/m1MU2YqKsBheHA3BcU7ngqaQnTaEhOwdSiIktyUsnlNToervJd7D4V2bzq0LZRKU/7fHE1IeYfr0ABC38fjFfiKrqk+mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5E7A1CC4;
	Thu,  6 Feb 2025 02:55:49 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 548BC3F5A1;
	Thu,  6 Feb 2025 02:55:24 -0800 (PST)
Date: Thu, 6 Feb 2025 10:55:21 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com, eauger@redhat.com, fweimer@redhat.com,
	jeremy.linton@arm.com, oliver.upton@linux.dev, pbonzini@redhat.com,
	stable@vger.kernel.org, tabba@google.com, wilco.dijkstra@arm.com,
	will@kernel.org
Subject: Re: [PATCH 7/8] KVM: arm64: Mark some header functions as inline
Message-ID: <Z6SVGbr7cvrVnNMz@J2N7QTR9R3>
References: <20250204152100.705610-1-mark.rutland@arm.com>
 <20250204152100.705610-8-mark.rutland@arm.com>
 <b76803b7-c1b3-426b-a375-0c01b98142c9@sirena.org.uk>
 <Z6SJAkogWN9D7ZKf@J2N7QTR9R3>
 <86seortkve.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86seortkve.wl-maz@kernel.org>

On Thu, Feb 06, 2025 at 10:42:29AM +0000, Marc Zyngier wrote:
> On Thu, 06 Feb 2025 10:03:46 +0000,
> Mark Rutland <mark.rutland@arm.com> wrote:
> > That said, I'm going to go with the below, adding 'inline' to
> > kvm_hyp_handle_memory_fault() and using CPP defines to alias the
> > function names:
> > 
> > | static inline bool kvm_hyp_handle_memory_fault(struct kvm_vcpu *vcpu,
> > |                                                u64 *exit_code)
> > | {
> > |         if (!__populate_fault_info(vcpu))
> > |                 return true;
> > | 
> > |         return false;
> > | }
> > | #define kvm_hyp_handle_iabt_low         kvm_hyp_handle_memory_fault
> > | #define kvm_hyp_handle_watchpt_low      kvm_hyp_handle_memory_fault
> > 
> > I think that's clearer, and it's more alisnged with how we usually alias
> > function names in headers. Other than these two cases, __alias() is only
> > used in C files to create a sesparate exprted symbol, and it's odd to
> > use it in a header anyhow.
> > 
> > Marc, please should if you'd prefer otherwise.
> 
> Nah, that's fine by me.
> 
> My only issue was with marking functions as inline, and yet storing
> pointers to these functions. But it looks like the compiler (GCC 12.2
> in my case) is doing a good job noticing the weird pattern, and
> generating only one function, even if we store multiple pointers.

That's fair -- I'm fairly certain that we do this elsewhere too, but I
can switch to __maybe_unused if we're worried that might bite us in
future?

Mark.

