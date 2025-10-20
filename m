Return-Path: <stable+bounces-188161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A81DCBF2441
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB06189FC43
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8591B27A12C;
	Mon, 20 Oct 2025 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOfrCbL7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436B722652D;
	Mon, 20 Oct 2025 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975958; cv=none; b=VRGaiwivGFjVHgEDu3PM5KfCILzliVXgHXMLxGmzVoXXx/VchQLCZmjvJ7bPIzrfNHzz0HVi/h5oWXSdJNMdiNY9pGs4a/F94XI9RAe2TH+0m/yKZ9wciX5905pGoKY9LJ/YG3AIzjJNpnodOK6ic19BSAHMBEXjH4J8QdiOGiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975958; c=relaxed/simple;
	bh=z9AgmlNOJT3LEVbLAQG9gIGGqSSqCri2xopx34BdR7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsRLrFO9oZu9XOBHMdcMvWwOYW0NX6eV6ijuSkUSEB4hKdqt7C0kJGgJ9adDrx5S+tdi8lDx/Gf48aDMZR4045eF6G6xCcZPFyckc7ESAJxGv+pDIQ5Aw9oLk59awS7Y5Vwu0lY9v7dr7VStz528n/lUx1qnTNKdMmbaGuE+wtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOfrCbL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5800DC4CEF9;
	Mon, 20 Oct 2025 15:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760975956;
	bh=z9AgmlNOJT3LEVbLAQG9gIGGqSSqCri2xopx34BdR7g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sOfrCbL7Gnlyc2u9qKcuWdhUj2vdfiYwEfbvl/5UGyfTDhRPvasrNjMK7fz+63uIK
	 W1diSE6ahzcIb7QdDYlAe+oCRxftjjAhSztPcc3iJo7irsVyBTrvyVj5svsUbTQ64s
	 RgYCLfJUNU6jKWcuM41fahE8xepGaz3MWT065XJYt5jIs/2LmPjYLV1d8gE5s6QcGL
	 BcEp9c9kT41yT06eHmaBgrKhhQ8wmNRmMK72Zeit7fPVfDRO+9wXO+00/Awl87HCpW
	 SBRB8eIMIrxrWNLN06YSjQ8XV9eBLNDW9VIFX/AidEE9b3aUu/kxhMXkvmY3lyhQuJ
	 NbaQjbSftyQaQ==
Message-ID: <a01bc438-8f27-4bf8-8bbe-05801fd3157a@kernel.org>
Date: Mon, 20 Oct 2025 17:59:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4.y 0/5] v5.4: fix build with GCC 15
Content-Language: en-GB, fr-BE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 MPTCP Upstream <mptcp@lists.linux.dev>, Nathan Chancellor
 <nathan@kernel.org>, Kostadin Shishmanov
 <kostadinshishmanov@protonmail.com>, Jakub Jelinek <jakub@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin (Intel)" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20251017-v5-4-gcc-15-v1-0-6d6367ee50a1@kernel.org>
 <2025102004-throwaway-compare-75c2@gregkh>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2025102004-throwaway-compare-75c2@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg,

Thank you for your reply!

On 20/10/2025 15:29, Greg Kroah-Hartman wrote:
> On Fri, Oct 17, 2025 at 07:33:37PM +0200, Matthieu Baerts (NGI0) wrote:
>> Two backports linked to build issues with GCC 15 have failed in this
>> version:
>>
>>   - ee2ab467bddf ("x86/boot: Use '-std=gnu11' to fix build with GCC 15")
>>   - 8ba14d9f490a ("efi: libstub: Use '-std=gnu11' to fix build with GCC 15")
>>
>> Conflicts have been solved, and described.
>>
>> After that, this kernel version still didn't build with GCC 15:
>>
>>   In file included from include/uapi/linux/posix_types.h:5,
>>                    from include/uapi/linux/types.h:14,
>>                    from include/linux/types.h:6,
>>                    from arch/x86/realmode/rm/wakeup.h:11,
>>                    from arch/x86/realmode/rm/wakemain.c:2:
>>   include/linux/stddef.h:11:9: error: cannot use keyword 'false' as enumeration constant
>>      11 |         false   = 0,
>>         |         ^~~~~
>>   include/linux/stddef.h:11:9: note: 'false' is a keyword with '-std=c23' onwards
>>   include/linux/types.h:30:33: error: 'bool' cannot be defined via 'typedef'
>>      30 | typedef _Bool                   bool;
>>         |                                 ^~~~
>>   include/linux/types.h:30:33: note: 'bool' is a keyword with '-std=c23' onwards
>>   include/linux/types.h:30:1: warning: useless type name in empty declaration
>>      30 | typedef _Bool                   bool;
>>         | ^~~~~~~
>>
>> I initially fixed this by adding -std=gnu11 in arch/x86/Makefile, then I
>> realised this fix was already done in an upstream commit, created before
>> the GCC 15 release and not mentioning the error I had. This is patch 3.
>>
>> When I was investigating my error, I noticed other commits were already
>> backported to stable versions. They were all adding -std=gnu11 in
>> different Makefiles. In their commit message, they were mentioning
>> 'gnu11' was picked to use the same as the one from the main Makefile.
>> But this is not the case in this kernel version. Patch 4 fixes that.
>>
>> Finally, I noticed extra warnings I didn't have in v5.10. Patch 5 fixes
>> that.
> 
> 5.4 is only going to be alive for about 1 more month, so I really don't
> think trying to "downgrade" things here is worth it at all.  Anyone
> still stuck on this old, obsolete, and very insecure kernel tree isn't
> going to be attempting to build it using the bleeding edge gcc release :)

Fine by me for v5.4. I only suggested these very small patches because I
had issues with GCC 15 when building v5.15, and I did the small work for
older kernels.

Please note that the two last patches are not directly linked to GCC 15:

- Patch 4/5 fixes the possible bump to C11 standard for some arch. So if
I'm not mistaken, it changes the minimal requirements from GCC 4.6 to
GCC 4.9. Is it not an issue for such old kernel?
(Note: this patch depends on the parents ones, but can be adapted)

- Patch 5/5 fixes a warning I saw, but I don't know from which version
GCC complains about that.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


