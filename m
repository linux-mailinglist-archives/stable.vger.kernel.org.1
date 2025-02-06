Return-Path: <stable+bounces-114059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6CFA2A56E
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 11:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597F3166D57
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 10:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D9A226522;
	Thu,  6 Feb 2025 10:01:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3CC2248A1
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738836086; cv=none; b=BwyGV/XjSGqtcR87btKpIELtVkgfRhFzTaWU5WJPI3v1I3RAOrLfbXOgYRVd9otx8AiG1UW0VNGzKqS+NXABNEoq60G5x6CgB8vyjlI6wZ+U5M7lymwQpGWZnZ2tYz4bSUN0XPTB+48jK5Vw5rJwxAG02eQIXbx7mEecRJ9APX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738836086; c=relaxed/simple;
	bh=voMQgCHWdN7flNyr23XyD9VTl1o5w8MZZTZ2Apae/Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kz4AFfoUU8QuhmMauB9xjsH3++lNnSCqJcdBtYBs+U9iEje+YK9/7g0tXo9YyG4z6W7MSdLeoIxGXbXrW29IJ80RYqyPiWojwi+AxjaG6JfpdzZvQu/VBQn8/BcLqx0WRFaoG1GdEK44m/4KNOwpjAfE7LrRjIc7N/bqZYPWpbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6252912FC;
	Thu,  6 Feb 2025 02:01:47 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE06E3F63F;
	Thu,  6 Feb 2025 02:01:21 -0800 (PST)
Date: Thu, 6 Feb 2025 10:01:16 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>, maz@kenrel.org
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	eauger@redhat.com, fweimer@redhat.com, jeremy.linton@arm.com,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	tabba@google.com, wilco.dijkstra@arm.com, will@kernel.org
Subject: Re: [PATCH 7/8] KVM: arm64: Mark some header functions as inline
Message-ID: <Z6SIDg9wtwUCGvJW@J2N7QTR9R3>
References: <20250204152100.705610-1-mark.rutland@arm.com>
 <20250204152100.705610-8-mark.rutland@arm.com>
 <b76803b7-c1b3-426b-a375-0c01b98142c9@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b76803b7-c1b3-426b-a375-0c01b98142c9@sirena.org.uk>

On Wed, Feb 05, 2025 at 09:50:30PM +0000, Mark Brown wrote:
> On Tue, Feb 04, 2025 at 03:20:59PM +0000, Mark Rutland wrote:
> > The shared hyp swtich header has a number of static functions which
> > might not be used by all files that include the header, and when unused
> > they will provoke compiler warnings, e.g.
> 
> With at least LLVM 18 we still have some issues with unused statics
> arising from the aliased function definitions:
> 
> In file included from arch/arm64/kvm/hyp/nvhe/hyp-main.c:8:
> ./arch/arm64/kvm/hyp/include/hyp/switch.h:699:13: warning: unused function 'kvm_hyp_handle_iabt_low' [-Wunused-function]
>   699 | static bool kvm_hyp_handle_iabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~
> ./arch/arm64/kvm/hyp/include/hyp/switch.h:701:13: warning: unused function 'kvm_hyp_handle_watchpt_low' [-Wunused-function]
>   701 | static bool kvm_hyp_handle_watchpt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The simplest thing would be to expand the alises into simple wrapper
> functions but that doesn't feel amazing, I don't know what people's
> taste is there?

Adding 'inline' seems to work, which seems simpler?

That said, I'm going to go with the below, adding 'inline' to
kvm_hyp_handle_memory_fault() and using CPP defines to alias the
function names:

| static inline bool kvm_hyp_handle_memory_fault(struct kvm_vcpu *vcpu,
|                                                u64 *exit_code)
| {
|         if (!__populate_fault_info(vcpu))
|                 return true;
| 
|         return false;
| }
| #define kvm_hyp_handle_iabt_low         kvm_hyp_handle_memory_fault
| #define kvm_hyp_handle_watchpt_low      kvm_hyp_handle_memory_fault

I think that's clearer, and it's more alisnged with how we usually alias
function names in headers. Other than these two cases, __alias() is only
used in C files to create a sesparate exprted symbol, and it's odd to
use it in a header anyhow.

Marc, please should if you'd prefer otherwise.

Mark.

