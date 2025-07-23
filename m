Return-Path: <stable+bounces-164435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA375B0F431
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E9CE7ABF2D
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1DA2E762A;
	Wed, 23 Jul 2025 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xOhX6yVQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893012E5427;
	Wed, 23 Jul 2025 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277848; cv=none; b=kQN8kCfNdSP17BdRPHAi2MfOB8DBze1KHBvp3EDzzt+tFkM2o+AC1OrTeN5qqmdGZy8Qlkgz0VuGrKp3HZneXa3EjQ0d42aCXDdztRqL7tf1MfROX+abxfr1OFPj/WQLcbZDl0zF0j5ARXaTQLWnQ7sLwiG9zIkjq32BbqFpHbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277848; c=relaxed/simple;
	bh=ontAQSP9ZoCstNgW+Y64dRA97JnRfSTPhyjcI5ct844=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmKnfJpQbqxjGkwISjMaBgCmvoZt1J/GiNzNyWVoamTpMmQNcrjnigLaAY5JMx9ZxK7ObCBnF3ZAmoEGpJJht4sgp8i18Yv5YEdGlRf1e+3dWy0RGRekFV+RuAmcLDoY7ExePiWAT0sGboeTFz2+EeZWEQ3HL5wcvnLZkamQCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xOhX6yVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4B8C4CEE7;
	Wed, 23 Jul 2025 13:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753277848;
	bh=ontAQSP9ZoCstNgW+Y64dRA97JnRfSTPhyjcI5ct844=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xOhX6yVQ6cTzonb6kNsZy7dqJO/hjqU/67nj9L2PGqJduOCv2+36YxnWaE/laQA/6
	 GwCzHNh5mmmKbgFOKBKYtjByjuPG+09z2U6KKU2lq3fqBHHpNRpBsfe1DiESYdBAxl
	 nTnFD1OGFkm77widNinuwrzo/kxOIDkgr2TG9vp4=
Date: Wed, 23 Jul 2025 15:37:24 +0200
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
Message-ID: <2025072346-snowfall-graph-81ba@gregkh>
References: <20250723092250.3411923-1-maciej.wieczor-retman@intel.com>
 <2025072310-eldest-paddle-99b3@gregkh>
 <5pzffj2kde67oqgwpvw4j3lxd3fstuhgnosmhiyf5wcdr3je6i@juy3hfn4fiw7>
 <2025072347-legible-running-efbb@gregkh>
 <wx2sgywegtnbjckalxgkbuqib7s26jkwznazqfq3frrllf2ybn@sskadn2tutmh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wx2sgywegtnbjckalxgkbuqib7s26jkwznazqfq3frrllf2ybn@sskadn2tutmh>

On Wed, Jul 23, 2025 at 03:03:27PM +0200, Maciej Wieczor-Retman wrote:
> On 2025-07-23 at 13:57:34 +0200, Greg KH wrote:
> >On Wed, Jul 23, 2025 at 01:46:44PM +0200, Maciej Wieczor-Retman wrote:
> >> On 2025-07-23 at 11:45:22 +0200, Greg KH wrote:
> >> >On Wed, Jul 23, 2025 at 11:22:49AM +0200, Maciej Wieczor-Retman wrote:
> >> >> If some config options are disabled during compile time, they still are
> >> >> enumerated in macros that use the x86_capability bitmask - cpu_has() or
> >> >> this_cpu_has().
> >> >> 
> >> >> The features are also visible in /proc/cpuinfo even though they are not
> >> >> enabled - which is contrary to what the documentation states about the
> >> >> file. Examples of such feature flags are lam, fred, sgx, ibrs_enhanced,
> >> >> split_lock_detect, user_shstk, avx_vnni and enqcmd.
> >> >> 
> >> >> Add a DISABLED_MASK() macro that returns 32 bit chunks of the disabled
> >> >> feature bits bitmask.
> >> >> 
> >> >> Initialize the cpu_caps_cleared and cpu_caps_set arrays with the
> >> >> contents of the disabled and required bitmasks respectively. Then let
> >> >> apply_forced_caps() clear/set these feature bits in the x86_capability.
> >> >> 
> >> >> Fixes: 6449dcb0cac7 ("x86: CPUID and CR3/CR4 flags for Linear Address Masking")
> >> >> Fixes: 51c158f7aacc ("x86/cpufeatures: Add the CPU feature bit for FRED")
> >> >> Fixes: 706d51681d63 ("x86/speculation: Support Enhanced IBRS on future CPUs")
> >> >> Fixes: e7b6385b01d8 ("x86/cpufeatures: Add Intel SGX hardware bits")
> >> >> Fixes: 6650cdd9a8cc ("x86/split_lock: Enable split lock detection by kernel")
> >> >> Fixes: 701fb66d576e ("x86/cpufeatures: Add CPU feature flags for shadow stacks")
> >> >> Fixes: ff4f82816dff ("x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions")
> >> >
> >> >That is fricken insane.
> >> >
> >> >You are saying to people who backport stuff:
> >> >	This fixes a commit found in the following kernel releases:
> >> >		6.4
> >> >		6.9
> >> >		3.16.68 4.4.180 4.9.137 4.14.81 4.18.19 4.19
> >> >		5.11
> >> >		5.7
> >> >		6.6
> >> >		5.10
> >> >
> >> >You didn't even sort this in any sane order, how was it generated?
> >> >
> >> >What in the world is anyone supposed to do with this?
> >> >
> >> >If you were sent a patch with this in it, what would you think?  What
> >> >could you do with it?
> >> >
> >> >Please be reasonable and consider us overworked stable maintainers and
> >> >give us a chance to get things right.  As it is, this just makes things
> >> >worse...
> >> >
> >> >greg k-h
> >> 
> >> Sorry, I certainly didn't want to add you more work.
> >> 
> >> I noted down which features are present in the x86_capability bitmask while
> >> they're not compiled into the kernel. Then I noted down which commits added
> >> these feature flags. So I suppose the order is from least to most significant
> >> feature bit, which now I realize doesn't help much in backporting, again sorry.
> >> 
> >> Would a more fitting Fixes: commit be the one that changed how the feature flags
> >> are used? At some point docs started stating to have them set only when features
> >> are COMPILED & HARDWARE-SUPPORTED.
> >
> >What would you want to see if you had to do something with a "Fixes:"
> >line?
> 
> I suppose I'd want to see a Fixes:commit in a place that hasn't seen too many
> changes. So the backport process doesn't hit too many infrastructure changes
> since that makes things more tricky.
> 
> And I guess it would be great if the Fixes:commit pointed at some obvious error
> that happened - like a place that could dereference a NULL pointer for example.
> 
> But I thought Fixes: was supposed to mark the origin point of some error the
> patch is fixing?
> 
> In this case a documentation patch [1] changed how feature flags are supposed to
> behave. But these flags were added in various points in the past. So what should
> Fixes: point at then?
> 
> But anyway writing this now I get the feeling that [1] would be a better point
> to mark for the "Fixes:" line.
> 
> [1] ea4e3bef4c94 ("Documentation/x86: Add documentation for /proc/cpuinfo feature flags")

If you feel that this patch should be backported to only 5.10 and newer,
great, that's the correct marking place.  If not, you might want to
reconsider it :)

thanks,

greg k-h

