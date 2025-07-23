Return-Path: <stable+bounces-164480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB87B0F783
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 17:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452D6170B07
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A009D1E3DFE;
	Wed, 23 Jul 2025 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="eoyniq4X"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800EC1F03DE;
	Wed, 23 Jul 2025 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285976; cv=none; b=fvsKPAV1MUOzfvKctcvFmfH1a0JyX5gRYKkZSs2WLSM5TY1Hj3kkQVq2BK1xoeq47IDMcsH/D+xRf+9HubMmFlaVAgx9nTbcRT9mgfQtShn4ojOSznuRac3YCzMWozgzm4s5sclPDIW85ru4yGzOG092vL6vy5SEJKgzEikzOZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285976; c=relaxed/simple;
	bh=hZ5Jvtu6+FQLQRQd+lkSew0Bz666yQfCCqiEmN5+LT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=exJWRxzLFw5ugGbrLZvTvvnE+FYqYlWyml9QdBQvUHKHeOdfHdvuGdxhQxPiT3+5a8VGedGeAc1mUm9lONliXvTqUBmtYmRN3093IFcu/hQWgtYnCiYoY/1j2Hr++8Phl3+z7ttOMnAz1pF5XYdTF/QTLxI4GKk2rYdqfEi4n2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=eoyniq4X; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56NFqHBd1227017
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 23 Jul 2025 08:52:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56NFqHBd1227017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1753285939;
	bh=d/+8gTZPif6HCef/uB3jSX66PXNPDLL9JAI36/Ah/2Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eoyniq4XlAViIvK5wYVluxdiML69Z8E9/7dZP117PKAjyoSG68E22xpiOZ0vU+aLY
	 e4ex/affF+2N8wKkIK4oIgSuEknV0kH6BPYa3s4MUwkbZOAR/CNCopjDUQ/U8CweeQ
	 EmR1//04h+ihXfruyFGNtPXD+1y5eC+558Z2iGjk+TodAZS9HYGzyWTn2YwTcUm75M
	 WByNMkoeuAWlQ1Pcak0y6PIPadK9xVlC6Bb1gNF8sYWc/5YvLb5dZ7iUgJK2sD9OsW
	 kgyNsjzwfuVyDKV7RtXF/jwGwocxPowfQdP2PLr9koincDGi7hgvUrdQfjAy+cLqzJ
	 PwxHl6+7xJiuA==
Message-ID: <0e52c9c5-006e-406b-8ae0-7f5c5273cba2@zytor.com>
Date: Wed, 23 Jul 2025 08:52:17 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86: Clear feature bits disabled at compile-time
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
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
        "Mike Rapoport (IBM)" <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, stable@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org
References: <20250723092250.3411923-1-maciej.wieczor-retman@intel.com>
 <2025072310-eldest-paddle-99b3@gregkh>
 <5pzffj2kde67oqgwpvw4j3lxd3fstuhgnosmhiyf5wcdr3je6i@juy3hfn4fiw7>
 <2025072347-legible-running-efbb@gregkh>
 <wx2sgywegtnbjckalxgkbuqib7s26jkwznazqfq3frrllf2ybn@sskadn2tutmh>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <wx2sgywegtnbjckalxgkbuqib7s26jkwznazqfq3frrllf2ybn@sskadn2tutmh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/2025 6:03 AM, Maciej Wieczor-Retman wrote:
> On 2025-07-23 at 13:57:34 +0200, Greg KH wrote:
>> On Wed, Jul 23, 2025 at 01:46:44PM +0200, Maciej Wieczor-Retman wrote:
>>> On 2025-07-23 at 11:45:22 +0200, Greg KH wrote:
>>>> On Wed, Jul 23, 2025 at 11:22:49AM +0200, Maciej Wieczor-Retman wrote:
>>>>> If some config options are disabled during compile time, they still are
>>>>> enumerated in macros that use the x86_capability bitmask - cpu_has() or
>>>>> this_cpu_has().
>>>>>
>>>>> The features are also visible in /proc/cpuinfo even though they are not
>>>>> enabled - which is contrary to what the documentation states about the
>>>>> file. Examples of such feature flags are lam, fred, sgx, ibrs_enhanced,
>>>>> split_lock_detect, user_shstk, avx_vnni and enqcmd.
>>>>>
>>>>> Add a DISABLED_MASK() macro that returns 32 bit chunks of the disabled
>>>>> feature bits bitmask.
>>>>>
>>>>> Initialize the cpu_caps_cleared and cpu_caps_set arrays with the
>>>>> contents of the disabled and required bitmasks respectively. Then let
>>>>> apply_forced_caps() clear/set these feature bits in the x86_capability.
>>>>>
>>>>> Fixes: 6449dcb0cac7 ("x86: CPUID and CR3/CR4 flags for Linear Address Masking")
>>>>> Fixes: 51c158f7aacc ("x86/cpufeatures: Add the CPU feature bit for FRED")
>>>>> Fixes: 706d51681d63 ("x86/speculation: Support Enhanced IBRS on future CPUs")
>>>>> Fixes: e7b6385b01d8 ("x86/cpufeatures: Add Intel SGX hardware bits")
>>>>> Fixes: 6650cdd9a8cc ("x86/split_lock: Enable split lock detection by kernel")
>>>>> Fixes: 701fb66d576e ("x86/cpufeatures: Add CPU feature flags for shadow stacks")
>>>>> Fixes: ff4f82816dff ("x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions")
>>>>
>>>> That is fricken insane.
>>>>
>>>> You are saying to people who backport stuff:
>>>> 	This fixes a commit found in the following kernel releases:
>>>> 		6.4
>>>> 		6.9
>>>> 		3.16.68 4.4.180 4.9.137 4.14.81 4.18.19 4.19
>>>> 		5.11
>>>> 		5.7
>>>> 		6.6
>>>> 		5.10
>>>>
>>>> You didn't even sort this in any sane order, how was it generated?
>>>>
>>>> What in the world is anyone supposed to do with this?
>>>>
>>>> If you were sent a patch with this in it, what would you think?  What
>>>> could you do with it?
>>>>
>>>> Please be reasonable and consider us overworked stable maintainers and
>>>> give us a chance to get things right.  As it is, this just makes things
>>>> worse...
>>>>
>>>> greg k-h
>>>
>>> Sorry, I certainly didn't want to add you more work.
>>>
>>> I noted down which features are present in the x86_capability bitmask while
>>> they're not compiled into the kernel. Then I noted down which commits added
>>> these feature flags. So I suppose the order is from least to most significant
>>> feature bit, which now I realize doesn't help much in backporting, again sorry.
>>>
>>> Would a more fitting Fixes: commit be the one that changed how the feature flags
>>> are used? At some point docs started stating to have them set only when features
>>> are COMPILED & HARDWARE-SUPPORTED.
>>
>> What would you want to see if you had to do something with a "Fixes:"
>> line?
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
> 

We need to investigate the root cause of this bug; and this seems like a
regression caused by my patch set that automatically generates CPU 
feature masks.

Just further debugging is needed to identify the culprit.

Thanks!
     Xin

