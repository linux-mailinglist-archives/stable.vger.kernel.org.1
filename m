Return-Path: <stable+bounces-108123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4922CA07944
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 15:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E29E168BB3
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 14:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7B9217F5C;
	Thu,  9 Jan 2025 14:32:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E6921578A;
	Thu,  9 Jan 2025 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736433133; cv=none; b=Wh62tUL5Z0G0HDOorTwKoIjHOI8OrxVjWA6Es2S1MO1cYuwQMOfKL3Dk+jNFMh3JkFahE1NUYfM04c9jbPhIdGIuPqsQb9hR66CVzJcqHUHAvMN+2nVQHH1PCKSi6U8Jg6PlzC0oDFQLdCgK/B/zgIyyCThsK8J4dV59Qv0iP1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736433133; c=relaxed/simple;
	bh=vcSAgrlYiHAx/a3t+RcmRwWPjPVl30K3+NtviCFb5ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5NX1ATG2M4ygQi2N5M0pjbgGHxvQ2S1OG32icR3kxH+ikmUPTdoT5eTT5HMtxWTVSRlU94a9evIPFPRWpkbLS7ovIlJBmoxO8+GXB7TlkN0VzNuiwy8WgauoSrHBv+n3GqRnqs521aQLylTwTV/U+arB1GaWwXLWxDsFAr1JZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7948C4CED2;
	Thu,  9 Jan 2025 14:32:09 +0000 (UTC)
Date: Thu, 9 Jan 2025 14:32:07 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, will@kernel.org,
	ardb@kernel.org, ryan.roberts@arm.com, mark.rutland@arm.com,
	joey.gouly@arm.com, dave.hansen@linux.intel.com,
	akpm@linux-foundation.org, chenfeiyang@loongson.cn,
	chenhuacai@kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	quic_tingweiz@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH v4] arm64: mm: Populate vmemmap/linear at the page level
 for hotplugged sections
Message-ID: <Z3_d59kp4CuHQp97@arm.com>
References: <20250107074252.1062127-1-quic_zhenhuah@quicinc.com>
 <Z31--x4unDHRU5Zo@arm.com>
 <406d5113-ff3d-4c2a-81f0-de791bcbeffb@quicinc.com>
 <1c1504a7-3515-48f2-8ca7-15b2379dea22@arm.com>
 <1515dae4-cb53-4645-8c72-d33b27ede7eb@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515dae4-cb53-4645-8c72-d33b27ede7eb@quicinc.com>

On Thu, Jan 09, 2025 at 03:04:22PM +0800, Zhenhua Huang wrote:
> On 2025/1/8 18:52, Anshuman Khandual wrote:
> > > I found another bug, that even for early section, when
> > > vmemmap_populate is called, SECTION_IS_EARLY is not set.
> > > Therefore, early_section() always return false.
[...]
> > > Since vmemmap_populate() occurs during section initialization, it
> > > may be hard to say it is a bug.. However, should we instead using
> > > SECTION_MARKED_PRESENT to check? I tested well in my setup.
> > > 
> > > Hot plug flow:
> > > 1. section_activate -> vmemmap_populate
> > > 2. mark PRESENT
> > > 
> > > In contrast, the early flow:
> > > 1. memblocks_present -> mark PRESENT
> > > 2. __populate_section_memmap -> vmemmap_populate
> > 
> > But from a semantics perspective, should SECTION_MARKED_PRESENT be marked on a
> > section before SECTION_IS_EARLY ? Is it really the expected behaviour here or
> > that needs to be fixed first ?
> 
> The tricky part is vmemmap_populate initializes mem_map, that happens during
> mem_section initialization process. PRESENT or EARLY tag is in the same
> process as well. There doesn't appear to be a compelling reason to enforce a
> specific sequence..

The order in which a section is marked as present and vmemmap created
does seem a bit arbitrary. At least the early code seems to rely on the
for_each_present_section_nr() loop, so we'll always have this first but
it's not some internal kernel API that guarantees this.

> > Although SYSTEM_BOOTING state check might help but section flag seems to be the
> > right thing to do here.
> 
> Good idea, I prefer to vote for this alternative rather than PRESENT tag. As
> I see we already took this stage to determine whether memmap pages are boot
> pages or not in common mm code:
> https://elixir.bootlin.com/linux/v6.13-rc3/source/mm/sparse-vmemmap.c#L465

The advantage of SYSTEM_BOOTING is that we don't need to rely on the
section information at all, though we could add a WARN_ON_ONCE if the
section is not present.

-- 
Catalin

