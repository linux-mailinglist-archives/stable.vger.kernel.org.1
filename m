Return-Path: <stable+bounces-67454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EB6950280
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 12:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FC6AB21EBC
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 10:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AC318A95E;
	Tue, 13 Aug 2024 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoTaMblr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8A2208AD;
	Tue, 13 Aug 2024 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545132; cv=none; b=Bo6Cwf+fzEvQr9Zr/+eFedld9MHrobg4+DysRVIU+aCL/YJx6esKZ92l0hlL3hU3RnPvf6JO1ipIHjwPZB+UoUTudSNUDahUReGYOCt8tIf/MZ8Z1oIP2Il2OqLA0uautgZ+GrluwRGWVx4cKI/JmUHr5QUpJ7CJ+mvLmMmIKxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545132; c=relaxed/simple;
	bh=ZjmBenwS6BE1vjuT8B0LhNFfM95R5DZMbadPgpteiw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjnZYfMUeEcf0XVF0vntpvUBTyhkhH6Y/CDgZgnGUIr/lTLKjZj8XUVbto5jJ/8TKhzeHuxtWHhevc39C9koujQsTuErwMXj0Lq9FwxjCpx4uA0IYAfdkzdLbST1k9XKR4Oj07FfN5WBeHzDVL9yEFQeCcheXzDxuykGUvMODdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoTaMblr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5EDC4AF0B;
	Tue, 13 Aug 2024 10:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723545132;
	bh=ZjmBenwS6BE1vjuT8B0LhNFfM95R5DZMbadPgpteiw0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OoTaMblrYSNYJaHsYW0moA3A5aJiP3LDO0VGTrx6HhMoaUnyg86chcbv8AN/AnAVc
	 3doU81OkV0dk5FM2KFND0cxaowJ3EEDzTzUbv8GRtt3VAADKbtrVzLICvNxLmPBGLV
	 FJ80nWFomK46sf6/rIw/OewsFmFCCSqVD3FYXRKmxeojLo3+pJ8aeo0sWwHT3DX+gc
	 pXzjYS1dqaAcpAmDsOv1dtc+HTtPYaxvgRgX+oGf+XsvnaZcbwUMZaAB4suLDtoOnK
	 oV3C16RqQ0G/fD8Ku8qyV7B1aL8sYsUOZ1Fcu3rFhjkAXpNGKVW8gSqWu2QVqbaiEF
	 WEJacLzx6FHPA==
Message-ID: <91d546ca-41b8-40dc-be6b-92737a3c3f19@kernel.org>
Date: Tue, 13 Aug 2024 12:32:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: FAILED: patch "[PATCH] mptcp: pm: don't try to create sf if alloc
 failed" failed to apply to 5.10-stable tree
Content-Language: en-GB
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, kuba@kernel.org, martineau@kernel.org,
 pabeni@redhat.com, MPTCP Linux <mptcp@lists.linux.dev>
References: <2024081248-exposable-uniformed-75e0@gregkh>
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
In-Reply-To: <2024081248-exposable-uniformed-75e0@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg,

On 12/08/2024 14:39, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x cd7c957f936f8cb80d03e5152f4013aae65bd986
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081248-exposable-uniformed-75e0@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..
> 
> Possible dependencies:
> 
> cd7c957f936f ("mptcp: pm: don't try to create sf if alloc failed")
> c95eb32ced82 ("mptcp: pm: reduce indentation blocks")
> 528cb5f2a1e8 ("mptcp: pass addr to mptcp_pm_alloc_anno_list")
> 77e4b94a3de6 ("mptcp: update userspace pm infos")
> 24430f8bf516 ("mptcp: add address into userspace pm list")
> fb00ee4f3343 ("mptcp: netlink: respect v4/v6-only sockets")
> 80638684e840 ("mptcp: get sk from msk directly")
> 5ccecaec5c1e ("mptcp: fix locking in mptcp_nl_cmd_sf_destroy()")
> 76a13b315709 ("mptcp: invoke MP_FAIL response when needed")
> d9fb797046c5 ("mptcp: Do not traverse the subflow connection list without lock")
> d42f9e4e2384 ("mptcp: Check for orphaned subflow before handling MP_FAIL timer")
> d7e6f5836038 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From cd7c957f936f8cb80d03e5152f4013aae65bd986 Mon Sep 17 00:00:00 2001
> From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
> Date: Wed, 31 Jul 2024 13:05:56 +0200
> Subject: [PATCH] mptcp: pm: don't try to create sf if alloc failed
> 
> It sounds better to avoid wasting cycles and / or put extreme memory
> pressure on the system by trying to create new subflows if it was not
> possible to add a new item in the announce list.
I think it is better not to backport this patch to v5.10: the
dependencies list is quite big, and the fix is probably not worth it: in
case of memory pressure, we don't try to do more actions (because they
will fail as well).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


