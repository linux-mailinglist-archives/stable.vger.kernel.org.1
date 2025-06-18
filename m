Return-Path: <stable+bounces-154652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F20ADEA78
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 13:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257C53A12C9
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 11:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E082E9EC3;
	Wed, 18 Jun 2025 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyqeBfE5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EEA2E9EBD;
	Wed, 18 Jun 2025 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246601; cv=none; b=j1JMW7XMktnXpVpmHk6o4MJ+sw0gPG6LPsZVkcHCxLV6P46tYV+FIKSHYUvlk69ZbtbRNltHGsDAvYpHR08fB6ywQk4JNv5A85Dt8u7IzKTZ46tIg/nRihBY6I1wDhn7dV76qEFo5gk08Qni7gLDFLF8/sH62CXtJaV3rs4ZZ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246601; c=relaxed/simple;
	bh=GVLbSPQbFmJsEWhBuQd4bgNbK7h2cLmm5XbplIfuN3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNolWQ+qU4gdGhWegxeb9LHW4/L7t9cnismnLYDODEDXzjjPzLHK7Nf3NzRn3QN591pvUeoNz3gaxe0SOS5sfV0RncltSQQ+fJimqdypRaAXUnXmR4Ccd/svxC2T4kbLku3fjhx4bMmucs1gCMBff2xIGfbJ/mn+GUe7NOtXT3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyqeBfE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C19FC4CEE7;
	Wed, 18 Jun 2025 11:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750246600;
	bh=GVLbSPQbFmJsEWhBuQd4bgNbK7h2cLmm5XbplIfuN3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NyqeBfE5keSm2NQskHcY9R6uGqvLEzDOJ3+hjLlMh84TIBIekDCJsZzMH3PTRFu5s
	 PuMbvAdmCmbjdQaSRnl7F8zBAZPHk2ATcxpAhGd0VAgHClRKxIySDw3DZXzkgEDuP5
	 shDp5G7odvpIwid+hL3WzrJOJD+1rhbtE5rvPRX3KsJfEJLOcg2/8ukA+vjK21O8Gs
	 kAhHDZRU3aQgPS24WmPyN3f9so4JHOEFG8C2qVfBTurRGJxVzvuYW3AEI5F9AT1+aw
	 FuM43AEMTiUBIvD1V+kVORu+6sYsIzjRISoRwShC4ZktfYYS5bCWCMMTOV2TQIPULe
	 hjbm4xloU2njA==
Date: Wed, 18 Jun 2025 12:36:36 +0100
From: Will Deacon <will@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: Re: [PATCH] arm64/ptdump: Ensure memory hotplug is prevented during
 ptdump_check_wx()
Message-ID: <20250618113635.GA20157@willie-the-truck>
References: <20250609041214.285664-1-anshuman.khandual@arm.com>
 <20250612145808.GA12912@willie-the-truck>
 <5c22c792-0648-4ced-b0ed-86882610b4be@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c22c792-0648-4ced-b0ed-86882610b4be@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jun 13, 2025 at 10:39:02AM +0530, Anshuman Khandual wrote:
> 
> 
> On 12/06/25 8:28 PM, Will Deacon wrote:
> > On Mon, Jun 09, 2025 at 05:12:14AM +0100, Anshuman Khandual wrote:
> >> The arm64 page table dump code can race with concurrent modification of the
> >> kernel page tables. When a leaf entries are modified concurrently, the dump
> >> code may log stale or inconsistent information for a VA range, but this is
> >> otherwise not harmful.
> >>
> >> When intermediate levels of table are freed, the dump code will continue to
> >> use memory which has been freed and potentially reallocated for another
> >> purpose. In such cases, the dump code may dereference bogus addresses,
> >> leading to a number of potential problems.
> >>
> >> This problem was fixed for ptdump_show() earlier via commit 'bf2b59f60ee1
> >> ("arm64/mm: Hold memory hotplug lock while walking for kernel page table
> >> dump")' but a same was missed for ptdump_check_wx() which faced the race
> >> condition as well. Let's just take the memory hotplug lock while executing
> >> ptdump_check_wx().
> > 
> > How do other architectures (e.g. x86) handle this? I don't see any usage
> > of {get,put}_online_mems() over there. Should this be moved into the core
> > code?
> 
> Memory hot remove on arm64 unmaps kernel linear and vmemmap mapping while
> also freeing page table pages if those become empty. Although this might
> not be true for all other architectures, which might just unmap affected
> kernel regions but does not tear down the kernel page table.

... that sounds like something we should be able to give a definitive
answer to?

Will

