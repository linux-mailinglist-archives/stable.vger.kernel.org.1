Return-Path: <stable+bounces-164427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 105EBB0F1BF
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063DE1C84BD6
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 11:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B342E49AD;
	Wed, 23 Jul 2025 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="052dEdrh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2414A2E4257;
	Wed, 23 Jul 2025 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753271859; cv=none; b=nTdIeTd7GQ4eR3OOKGbwEh7GoMsuXMyPbH9wzQCX6Fsn5zv998KB/lcFx026pqJ3SddAvFBl4PEFOEFMywbI6AaHfhPdl0+xBcl6uDj0Fc9RcdnWkJWOwmkD2xqASsQ6SGxXWWGuylqdpK5YREZm8AZuoXrh5gMxTBqCLYmuIVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753271859; c=relaxed/simple;
	bh=BjTE+1VS+45LArrbJs6YQ54EMN556aHmCu91/b0/ooY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNtldevc0kyEkOqQOBws+Bx6uRuU9DHMoOmoELzD2Lh+shwlRDsWY5NtFEUmHRmh6di4QE/MB3AtZNIYuitaQYlxTZb5Z7cizFklj0S8OGZUjttXHIEKMCX+Kk//8ow+0FBlQhigMSf1QIa21+hE8p3kggxKEmrbW4I02C8lShY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=052dEdrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE427C4CEE7;
	Wed, 23 Jul 2025 11:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753271857;
	bh=BjTE+1VS+45LArrbJs6YQ54EMN556aHmCu91/b0/ooY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=052dEdrhEVx0fMTiMnIMXN5lNCFpceQgmVJ7YZvH4n91wqFspOWc2yJuUBwSNbHRD
	 kX3HBQuuM8b1elJf6rM/U9KU2bPecgJDQxpizRtbtS6C50EtqYdC9+PTVdWin5ysGE
	 rc3SefbiUPHP0stRQ2yhMNIxN9lC4kE0wi3Buh+U=
Date: Wed, 23 Jul 2025 13:57:34 +0200
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
Message-ID: <2025072347-legible-running-efbb@gregkh>
References: <20250723092250.3411923-1-maciej.wieczor-retman@intel.com>
 <2025072310-eldest-paddle-99b3@gregkh>
 <5pzffj2kde67oqgwpvw4j3lxd3fstuhgnosmhiyf5wcdr3je6i@juy3hfn4fiw7>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5pzffj2kde67oqgwpvw4j3lxd3fstuhgnosmhiyf5wcdr3je6i@juy3hfn4fiw7>

On Wed, Jul 23, 2025 at 01:46:44PM +0200, Maciej Wieczor-Retman wrote:
> On 2025-07-23 at 11:45:22 +0200, Greg KH wrote:
> >On Wed, Jul 23, 2025 at 11:22:49AM +0200, Maciej Wieczor-Retman wrote:
> >> If some config options are disabled during compile time, they still are
> >> enumerated in macros that use the x86_capability bitmask - cpu_has() or
> >> this_cpu_has().
> >> 
> >> The features are also visible in /proc/cpuinfo even though they are not
> >> enabled - which is contrary to what the documentation states about the
> >> file. Examples of such feature flags are lam, fred, sgx, ibrs_enhanced,
> >> split_lock_detect, user_shstk, avx_vnni and enqcmd.
> >> 
> >> Add a DISABLED_MASK() macro that returns 32 bit chunks of the disabled
> >> feature bits bitmask.
> >> 
> >> Initialize the cpu_caps_cleared and cpu_caps_set arrays with the
> >> contents of the disabled and required bitmasks respectively. Then let
> >> apply_forced_caps() clear/set these feature bits in the x86_capability.
> >> 
> >> Fixes: 6449dcb0cac7 ("x86: CPUID and CR3/CR4 flags for Linear Address Masking")
> >> Fixes: 51c158f7aacc ("x86/cpufeatures: Add the CPU feature bit for FRED")
> >> Fixes: 706d51681d63 ("x86/speculation: Support Enhanced IBRS on future CPUs")
> >> Fixes: e7b6385b01d8 ("x86/cpufeatures: Add Intel SGX hardware bits")
> >> Fixes: 6650cdd9a8cc ("x86/split_lock: Enable split lock detection by kernel")
> >> Fixes: 701fb66d576e ("x86/cpufeatures: Add CPU feature flags for shadow stacks")
> >> Fixes: ff4f82816dff ("x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions")
> >
> >That is fricken insane.
> >
> >You are saying to people who backport stuff:
> >	This fixes a commit found in the following kernel releases:
> >		6.4
> >		6.9
> >		3.16.68 4.4.180 4.9.137 4.14.81 4.18.19 4.19
> >		5.11
> >		5.7
> >		6.6
> >		5.10
> >
> >You didn't even sort this in any sane order, how was it generated?
> >
> >What in the world is anyone supposed to do with this?
> >
> >If you were sent a patch with this in it, what would you think?  What
> >could you do with it?
> >
> >Please be reasonable and consider us overworked stable maintainers and
> >give us a chance to get things right.  As it is, this just makes things
> >worse...
> >
> >greg k-h
> 
> Sorry, I certainly didn't want to add you more work.
> 
> I noted down which features are present in the x86_capability bitmask while
> they're not compiled into the kernel. Then I noted down which commits added
> these feature flags. So I suppose the order is from least to most significant
> feature bit, which now I realize doesn't help much in backporting, again sorry.
> 
> Would a more fitting Fixes: commit be the one that changed how the feature flags
> are used? At some point docs started stating to have them set only when features
> are COMPILED & HARDWARE-SUPPORTED.

What would you want to see if you had to do something with a "Fixes:"
line?

thanks,

greg k-h

