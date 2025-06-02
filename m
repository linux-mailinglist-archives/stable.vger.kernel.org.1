Return-Path: <stable+bounces-150618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A33ACBA78
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 19:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C84417788C
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDE517B421;
	Mon,  2 Jun 2025 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bccasQbK"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF846523A
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748886648; cv=none; b=cATLc3Ux5F2rXPfIlys2jX29rBI8lGTFsODhV5E+dQ1e1YFGGSIMEN9IbvZFkl/IkOz3TMSSxU+Kys7F5kmCHQO/e2LdP/ZeiITIFnVnodkGYVrxkXnDFOA0eHAbNSxM/uxzxdY0t8JdL34yuxJ/QRPmnwsXK20HAvW0poS1kjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748886648; c=relaxed/simple;
	bh=u4v9ck0jhO0ttgXyycH2496NJIQ/f+ugFhEKKoD4Vd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+KGxkH/WnYHfnNB2dgXnoOgTNyoo7HZMk3GtSkF+N7Lxj2V5EvscLz9t9IjhmaIg2GXa3/XS8QDXw4k9XD14nSEygz7avzW/WNu/N9EgJswSI8j8OKbotqzEcjpi/vP/Ab/QJx3RxoszE+nxMHDe4fUizR43vsouH83m5/dsqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bccasQbK; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 2 Jun 2025 10:50:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748886642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+US7plg1nUi/tNcrcTbRg68+uKx2W3vNq0vkWat981E=;
	b=bccasQbKXwtK2x8QGEDjUYasWPuU6PbsRWQOr1WkfYutbqDabCVecf0vq3N0o2zly2Eda5
	dCz2lKOViYAqVv92HovqxBuhQ9iT9XwzOWhqQV4Jn92DcWImCw5mWf5kiRr+UTwG+QwW/5
	/yhZsaPV4FkSZoDZN++Wpmbx2sRccvA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Mingwei Zhang <mizhang@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: Add MIDR-based check for FEAT_ECBHB
Message-ID: <aD3kZb0ZZQxsrNF6@linux.dev>
References: <20250522204148.4007406-1-oliver.upton@linux.dev>
 <20250602120831.GC1227@willie-the-truck>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602120831.GC1227@willie-the-truck>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 02, 2025 at 01:08:31PM +0100, Will Deacon wrote:
> On Thu, May 22, 2025 at 01:41:48PM -0700, Oliver Upton wrote:
> > +	/*
> > +	 * Prior to commit e8cde32f111f ("arm64/cpufeatures/kvm: Add ARMv8.9
> > +	 * FEAT_ECBHB bits in ID_AA64MMFR1 register"), KVM masked FEAT_ECBHB
> > +	 * on implementations that actually have the feature. That sucks; infer
> > +	 * presence of FEAT_ECBHB based on MIDR.
> > +	 */
> > +	if (is_midr_in_range_list(spectre_ecbhb_list))
> > +		return true;
> > +
> 
> I really don't think we want to go down this route.

Like I said, not a fan of doing this but...

> If finer grained control of the spectre mitigations is needed, I think
> extending the existing command-line options is probably the best bet
> rather then inferring behaviours based on the MIDR.

Looks like all of the Neoverse-V2 based VMs available for rent are
unintentionally hiding FEAT_ECBHB despite hardware support. I wouldn't
expect CSPs to go and change this field after creating a VM, so that's a
lot of hardware we're giving a poor experience on.

I just don't think a command-line switch is going to have any practical
impact on the situation.

Thanks,
Oliver

