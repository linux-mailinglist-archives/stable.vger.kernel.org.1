Return-Path: <stable+bounces-80772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE47990933
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD682820AA
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 16:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31F51CACC7;
	Fri,  4 Oct 2024 16:31:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936A61C82E6;
	Fri,  4 Oct 2024 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059468; cv=none; b=Z1OYkzYxZ6J4xG75wr9x/LVloPwQoCLk7V0nGn1cywdH/XJ3n+0jCfMISuhAsL1mQyOQR/cC5bohYZozSTsUWgNi3KFH5vlyloOBRiN/BJhWWJcjizjVJSWssoAP1O/ORJtT9wxlC1np/nvYEg1j80MVGn+pjKN+DMpf2DGS/74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059468; c=relaxed/simple;
	bh=YmdSNPfR/tRO4uGaJI4F8DBmFm4uoOY1QMZOT8LKZ60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6ulPUqOsrz8l1vePx/bHSrPJ695h59Zwfe6DfLJU21WQ+UrkGv4qkJQ1/vabnVC9NOCpOtx1qwSYSNrpheOXAIDB4aDwl5c8wlelZD6tLg9ylVnbiCpojzAIewaFTn4Ljy/Wc0ae6I/Z15Gc5QdCZDqNrvW7PJnTDScO1WPuJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63C55339;
	Fri,  4 Oct 2024 09:31:35 -0700 (PDT)
Received: from arm.com (unknown [10.57.22.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38BEC3F640;
	Fri,  4 Oct 2024 09:31:03 -0700 (PDT)
Date: Fri, 4 Oct 2024 19:31:00 +0300
From: Catalin Marinas <catalin.marinas@arm.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Rob Herring <robh@kernel.org>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, James More <james.morse@arm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: Subscribe Microsoft Azure Cobalt 100 to erratum
 3194386
Message-ID: <ZwAYRH208DS-HDpV@arm.com>
References: <20241003225239.321774-1-eahariha@linux.microsoft.com>
 <172804243078.2676985.11423830386246877637.b4-ty@arm.com>
 <f64f2cb8-de7a-4131-a0ae-e986b4857777@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f64f2cb8-de7a-4131-a0ae-e986b4857777@linux.microsoft.com>

On Fri, Oct 04, 2024 at 09:24:15AM -0700, Easwar Hariharan wrote:
> On 10/4/2024 4:47 AM, Catalin Marinas wrote:
> > On Thu, 03 Oct 2024 22:52:35 +0000, Easwar Hariharan wrote:
> >> Add the Microsoft Azure Cobalt 100 CPU to the list of CPUs suffering
> >> from erratum 3194386 added in commit 75b3c43eab59 ("arm64: errata:
> >> Expand speculative SSBS workaround")
> > 
> > Applied to arm64 (for-next/fixes), thanks!
> > 
> > [1/1] arm64: Subscribe Microsoft Azure Cobalt 100 to erratum 3194386
> >       https://git.kernel.org/arm64/c/3eddb108abe3
> > 
> 
> Thanks for queuing, I just saw that I typoed James' last name in the CC
> of the commit message. i.e. it needs s/More/Morse/
> 
> I'll let you decide if it needs fixing up.

Too late, I already sent the pull request to Linus. I doubt anyone else
would notice ;).

-- 
Catalin

