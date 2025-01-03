Return-Path: <stable+bounces-106728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8368AA00CF5
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 18:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3121883F03
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 17:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265561FBE8C;
	Fri,  3 Jan 2025 17:39:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F084D1FBC83
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735925983; cv=none; b=Zs93wAv3GEqeYnh5WtXQRu7V6RQmHAMAfPGM2IzTUP3FH5NSFymOcXyRdf2+NsP5Cxn8SzvPBAWkcBsW4+5V8XZzlC9plh9BnS6j5pFNfIHOavSkFMvhBXnLKJOTDdckZBDE9l0yWSqNDpVWYfey4tVOauY1BERhxm3S3Cypphw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735925983; c=relaxed/simple;
	bh=FDN9E3EwQFcL8rO5vmhOQCSIFqdHOo0yI3dnq1hhMOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcxWN2Dfu3Vtzpmh0zM+CUcxKGZX8wDK7fJB330VxCjNRJsoZzNnCHJuoBmC8HvEQuGPeWCi5ukcUjebiEFWMg4cPCL2q+7s8Z7a5oKu0dNEm+MHI6wgL5I/WMTddV0MIL4zi1882PdeI9fSjP2BaKgdrZbg8xRDhx7OoAhN9pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EA3C4CECE;
	Fri,  3 Jan 2025 17:39:41 +0000 (UTC)
Date: Fri, 3 Jan 2025 17:39:39 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: Filter out SVE hwcaps when FEAT_SVE isn't
 implemented
Message-ID: <Z3gg23G00THN-Ev5@arm.com>
References: <20250103142635.1759674-1-maz@kernel.org>
 <Z3gcRczN67LsMVST@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3gcRczN67LsMVST@arm.com>

On Fri, Jan 03, 2025 at 05:20:05PM +0000, Catalin Marinas wrote:
> On Fri, Jan 03, 2025 at 02:26:35PM +0000, Marc Zyngier wrote:
> > @@ -3022,6 +3027,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
> >  		.matches = match,						\
> >  	}
> >  
> > +#define HWCAP_CAP_MATCH_ID(match, reg, field, min_value, cap_type, cap)		\
> > +	{									\
> > +		__HWCAP_CAP(#cap, cap_type, cap)				\
> > +		HWCAP_CPUID_MATCH(reg, field, min_value) 			\
> > +		.matches = match,						\
> > +	}
> 
> Do we actually need this macro?

Ignore me, we still need this macro as HWCAP_CAP_MATCH does not take all
the arguments. Maybe not the read_scoped_sysreg() change though.

-- 
Catalin

