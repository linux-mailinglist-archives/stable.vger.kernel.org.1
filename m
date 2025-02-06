Return-Path: <stable+bounces-114061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51212A2A57E
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 11:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E7F3A2E6E
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 10:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B66B226522;
	Thu,  6 Feb 2025 10:03:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B99225A44
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738836234; cv=none; b=iLl85IO4EaHHrRaltOpnvJ5Jt3scfadULvF5ZAzk51UlpGETZ+sAyuB4dJh5M/uAQIxy4q986pnZjx4R9bL8LMdeS1obvT8Hi5+Yj3GvaBMH7APlpXMXsgzbChQfYQcoHWE36o4pFff/sPd6c4Eo8bfSj2f2Ib5aMbUR5TT+q2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738836234; c=relaxed/simple;
	bh=l9nFNofogmYl72i9uO4yhTmKZqCyLQ3uaiivWVp8uAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXwN8RrHmQgP8LbU/Pg5mFb66IOIjgeMLFJKVEtsXs5fKfNJDQm7pwsAVFkdXlVODMIhzWEkm9P63edQHcmWnxCc2XLxExwFZxfNhtVkbq0UdZZ/4hVDEwWXH74dCVnf53IyYhb+CVghC10iFBNMfG/GH2DIayIxJtDa76Wvr6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E2AD12FC;
	Thu,  6 Feb 2025 02:04:15 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BA033F63F;
	Thu,  6 Feb 2025 02:03:49 -0800 (PST)
Date: Thu, 6 Feb 2025 10:03:46 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>, maz@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	eauger@redhat.com, fweimer@redhat.com, jeremy.linton@arm.com,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	tabba@google.com, wilco.dijkstra@arm.com, will@kernel.org
Subject: Re: [PATCH 7/8] KVM: arm64: Mark some header functions as inline
Message-ID: <Z6SJAkogWN9D7ZKf@J2N7QTR9R3>
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

[resending as I corrupted MarcZ's email when moving from CC into TO]

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

