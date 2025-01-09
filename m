Return-Path: <stable+bounces-108142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D0BA07ED9
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 18:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D74168327
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 17:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD2618FC90;
	Thu,  9 Jan 2025 17:35:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1B318C91F;
	Thu,  9 Jan 2025 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444111; cv=none; b=ORRPJ4XIetCTo6gJk0MDo86/jB3Rh9V6ukdUg0TnY/1YHrdld2/H8jKQjweDr2fiKGYmsDUjkMkzfLtuC2i9pZTSxVEn6ZQG/gHQZ2KnfR3u/bBIYZn2vP/fXfFEqbYuTbTz2ZNqnfpFLo1jsMNMHZ0ak99Y1svGib8e09G16qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444111; c=relaxed/simple;
	bh=zXbUDOEx5jjqRjVTA549/9OFG6fapkyMQPFWxzwbYfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWPefXrC6EQbxY+ipOK57Ef/HEnnR27hTbYr5HEbde2Q5+rd7Qvox09fqpr7UGgl6qexriZS4OFuP5gtJ6fxkMbIfwmboqQiqdPJ92m+OBwj/cEBlWiS/cBZSzqe81s1SDrbwdOAmZMfwK9FPMe89WuaNhJCJiVnxEycA2rudDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B7BF1515;
	Thu,  9 Jan 2025 09:35:37 -0800 (PST)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F70A3F673;
	Thu,  9 Jan 2025 09:35:07 -0800 (PST)
Date: Thu, 9 Jan 2025 17:35:00 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Martin <Dave.Martin@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/6] arm64/sme: Collected SME fixes
Message-ID: <Z4AIxM3fYh5WEw--@J2N7QTR9R3.cambridge.arm.com>
References: <20241204-arm64-sme-reenable-v2-0-bae87728251d@kernel.org>
 <20250108124957.GA9312@willie-the-truck>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108124957.GA9312@willie-the-truck>

On Wed, Jan 08, 2025 at 12:49:58PM +0000, Will Deacon wrote:
> On Wed, Dec 04, 2024 at 03:20:48PM +0000, Mark Brown wrote:
> > This series collects the various SME related fixes that were previously
> > posted separately.  These should address all the issues I am aware of so
> > a patch which reenables the SME configuration option is also included.
> > 
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > ---
> > Changes in v2:
> > - Pull simplification of the signal restore code after the SME
> >   reenablement, it's not a fix but there's some code overlap.
> > - Comment updates.
> > - Link to v1: https://lore.kernel.org/r/20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org
> 
> Mark (R), are you happy with this? I know you were digging into some
> other issues in this area but I'm not sure whether they invalidate the
> fixes here or not.

Hi Will, sorry for the delay -- this has turned out to be more fractal
than I had hoped. :(

I think some of the fixes I'm working on are going to conflict with or
supersede portions of this series (e.g. portions of ptrace and signal
handling), and I'm aware of a couple more SME-specific issues that are
not addressed here.

I'll try to get that out in the next few days, and then look at this in
a bit more detail.

Rutland.

