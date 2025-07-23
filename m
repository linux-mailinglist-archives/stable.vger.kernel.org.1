Return-Path: <stable+bounces-164409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14326B0EEB1
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 11:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F03737B6AD1
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 09:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAE2281526;
	Wed, 23 Jul 2025 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xtwUIDT2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC56C1F1302;
	Wed, 23 Jul 2025 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753263926; cv=none; b=Mr6WSBabndTARV5jiOB1YLSMtX3c6uRHSeYLTeYuuX/6n62oW4sR+cJoqHK3n2STVyDZvcIsHZQLSsdTA92TcrLg7ngtC7L4eV2UdzSbl9RgOGnch4eTMmAXZBg0z4duUTsIU7848OZlxTKtb+dL2Bxd7Mw47qynCfANIVWdRV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753263926; c=relaxed/simple;
	bh=PDEeI1ivMDfKIOi4Ka3l8JqzcYedC/VHBhmrDn9EQ6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAlyZ+CQ+I6LK8YRYFKply9ajzs4/1xEPQrS9nkwBR1/zIM4EhXJx++lWtzXgCkgHVWJ53GrzAXLcwaB6hc2y6gSLBSPFETj5ZrctNIE3Ufb+NS39OQoXynfq5sMh5BvJPbvwbtnknRBDedDUHVjYIK3LRMZqp1iVUbPoap4RvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xtwUIDT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44DFC4CEE7;
	Wed, 23 Jul 2025 09:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753263925;
	bh=PDEeI1ivMDfKIOi4Ka3l8JqzcYedC/VHBhmrDn9EQ6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xtwUIDT2ZkL012VPgHrS3FTEkrtO1TSry8KSZ6cfysLIlWp3zNROecdoatGX+JowI
	 IgO52Bg3y/cG28QXw3aP5bnqq2Xm5NZl+SmvmletrtL5Le3T+Mu6lDMSvKWr1QTJjq
	 U84YFBINSQgUZpQKuifr5RIsoa6ouLoHmMMysqdU=
Date: Wed, 23 Jul 2025 11:45:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Xin Li <xin3.li@intel.com>,
	Sai Praneeth <sai.praneeth.prakhya@intel.com>,
	Jethro Beekman <jethro@fortanix.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>, stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Clear feature bits disabled at compile-time
Message-ID: <2025072310-eldest-paddle-99b3@gregkh>
References: <20250723092250.3411923-1-maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723092250.3411923-1-maciej.wieczor-retman@intel.com>

On Wed, Jul 23, 2025 at 11:22:49AM +0200, Maciej Wieczor-Retman wrote:
> If some config options are disabled during compile time, they still are
> enumerated in macros that use the x86_capability bitmask - cpu_has() or
> this_cpu_has().
> 
> The features are also visible in /proc/cpuinfo even though they are not
> enabled - which is contrary to what the documentation states about the
> file. Examples of such feature flags are lam, fred, sgx, ibrs_enhanced,
> split_lock_detect, user_shstk, avx_vnni and enqcmd.
> 
> Add a DISABLED_MASK() macro that returns 32 bit chunks of the disabled
> feature bits bitmask.
> 
> Initialize the cpu_caps_cleared and cpu_caps_set arrays with the
> contents of the disabled and required bitmasks respectively. Then let
> apply_forced_caps() clear/set these feature bits in the x86_capability.
> 
> Fixes: 6449dcb0cac7 ("x86: CPUID and CR3/CR4 flags for Linear Address Masking")
> Fixes: 51c158f7aacc ("x86/cpufeatures: Add the CPU feature bit for FRED")
> Fixes: 706d51681d63 ("x86/speculation: Support Enhanced IBRS on future CPUs")
> Fixes: e7b6385b01d8 ("x86/cpufeatures: Add Intel SGX hardware bits")
> Fixes: 6650cdd9a8cc ("x86/split_lock: Enable split lock detection by kernel")
> Fixes: 701fb66d576e ("x86/cpufeatures: Add CPU feature flags for shadow stacks")
> Fixes: ff4f82816dff ("x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions")

That is fricken insane.

You are saying to people who backport stuff:
	This fixes a commit found in the following kernel releases:
		6.4
		6.9
		3.16.68 4.4.180 4.9.137 4.14.81 4.18.19 4.19
		5.11
		5.7
		6.6
		5.10

You didn't even sort this in any sane order, how was it generated?

What in the world is anyone supposed to do with this?

If you were sent a patch with this in it, what would you think?  What
could you do with it?

Please be reasonable and consider us overworked stable maintainers and
give us a chance to get things right.  As it is, this just makes things
worse...

greg k-h

