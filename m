Return-Path: <stable+bounces-165637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CB7B16EA1
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 11:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792B83A711A
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 09:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B1A292B56;
	Thu, 31 Jul 2025 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fO2zK68h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2668529CB5F
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753954111; cv=none; b=HXYCoi3iJUe0lXawEovtf6ehO3JsWhhzf8Z3cNjXn54tLhlul28RmfrAHNYtCnuHuJQoBx8h7RCVOqycM0dmXOlX3GnVpBltxOxdZs7+PPAvi7RxeMagdjyFng7Zdo5xRRpyDWdQchllFHJQnvXNnRDzfkJAtCI4dD+UjfXO6Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753954111; c=relaxed/simple;
	bh=+ToyXm8AytAHRuxmH/iWCUCGm4TnAy6187J4fubpUzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dymLsrPdyBvVYxLIdFK5z7KkTZAyfdJe0UEvRsSWc54ZPk6KFU0/VI/xgdZyrN6y788UCy3wPIPNRAJym92rp8Vo700axIS3JZdsbuoRjP9E4JznBF9pYotev8b4tHowjxYcmROuWwAfX2hz0jRVecNuN0LqQ/QF0zyF44405O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fO2zK68h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7F0C4CEF5;
	Thu, 31 Jul 2025 09:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753954110;
	bh=+ToyXm8AytAHRuxmH/iWCUCGm4TnAy6187J4fubpUzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fO2zK68hcozd6xvySMQZsiUKDrfHirUUauic/XHlzSCBWg72f+mvRGEyVKkhIwTin
	 1iR6dZHd5JCepr26qIWyoF8Oo1G01aUwDCoqIqVB9MJ/DFCyxEsu/YvxqJr6+yso3s
	 gl+95Jnt+6q2197ybCrfaPKicCWJ2+KprL+DZ3SP4+bfwnsKarVFB7GOz+X7mMqUQd
	 0E+DQOk7JCtQkYgYt9x7hkrdCvw9umuqT9U937fUWjtwJ4dPL9gCRsAcfzjBX3sRcU
	 J9bUJm9KM573r7m4uJJyWLUkFq3quUUe3XSTM+H1TLrVfl4KZFXRFyYvCE0joyafaJ
	 Cz3N1MpCQCYaw==
Message-ID: <c3740876-7949-4a50-ae5e-ec5b46431cbc@kernel.org>
Date: Thu, 31 Jul 2025 11:28:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 5.15.y 2/3] selftests: mptcp: connect: also cover alt
 modes
Content-Language: en-GB, fr-BE
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
References: <1753887608-2e6325ec@stable.kernel.org>
 <bf0ed59b-c519-4aa1-b05e-160dac6b5b8f@kernel.org> <aIrCUht5H3ALyGsu@lappy>
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
In-Reply-To: <aIrCUht5H3ALyGsu@lappy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sasha,

Thank you for your reply!

On 31/07/2025 03:09, Sasha Levin wrote:
> On Wed, Jul 30, 2025 at 06:41:19PM +0200, Matthieu Baerts wrote:
>> Hi Sasha,
>>
>> On 30/07/2025 18:28, Sasha Levin wrote:
>>> [ Sasha's backport helper bot ]
>>>
>>> Hi,
>>>
>>> Summary of potential issues:
>>> ℹ️ This is part 2/3 of a series
>>> ⚠️ Could not find matching upstream commit
>>>
>>> The claimed upstream commit SHA1
>>> (37848a456fc38c191aedfe41f662cc24db8c23d9) was not found.
>>
>> Is there maybe an issue with your bot? The SHA1 looks correct:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
>> commit/?id=37848a456fc38c191aedfe41f662cc24db8c23d9
>>
>> Also the same as the one mentioned in Greg's email:
>>
>>  https://lore.kernel.org/2025072839-wildly-gala-e85f@gregkh
> 
> The SHA1 is correct, but it wasn't in Linus's tree until earlier today
> via 8be4d31cb8aa ("Merge tag 'net-next-6.17' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next").

If I'm not mistaken, the commit was part of a previous pull request via
407c114c983f ("Merge tag 'net-6.16-rc8' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net"), and was part
of the v6.16 release.

But that's OK, a detail I suppose, despite what the bot said yesterday,
the SHA1's here and in the other patches are correct :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


