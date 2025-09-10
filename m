Return-Path: <stable+bounces-179185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1E4B5134D
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 11:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6A43B0CBD
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 09:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4423112CF;
	Wed, 10 Sep 2025 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orwxfTZ0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736E23019CB;
	Wed, 10 Sep 2025 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498129; cv=none; b=F5t49Sxufy6joSATcQi75GcqjVxcOgPQtqb3RGs4WuCDdU9lrD2k944B+Zqi6u3VDe7a4Cze2RzJyos1qZrxYWWmk1ISKO9X41vKTR56XMh2rZI2dOmrF0JqhBfpZ33g2jNk1/3krYsXkNLn6928VcHSx9ix4TDcCigfDdeyKhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498129; c=relaxed/simple;
	bh=gwB7IsSFnafsHhjWiTmkHgy5V/fzmzLmzwOnP4sv0Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SM1F9g9VS2mJfsQjg6VWf7oz5AC6ANGNPm4x648ZQzoYorhgFn2wRE3sxPN+h6F4fL7S0+uYNVRNAMXbBJqfWLJVySXKkEMHolcGNNTjKl3q+c20Z1DQU6k3blnoh6yCoJXvbrK877sBflUZz+ZnlHS4DpfECQYyPaeeFNemQoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orwxfTZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23E0C4CEF0;
	Wed, 10 Sep 2025 09:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757498129;
	bh=gwB7IsSFnafsHhjWiTmkHgy5V/fzmzLmzwOnP4sv0Sk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=orwxfTZ0ex27Hl9cR5OrLc6DngPR8k5DtzR3ge2XhatQIgmqS1LLO9nVwygWnaSRk
	 PxUcY6zDjdQNzuzOTVOVhrBR6KcNoPBKus2U5e466UOzvUz5PQ1F2vTTOutdmqeoP7
	 QpCuEN1GgwkZuY21Nzee7izs5Vp41v6H4irqkEiJmpZFlzb1Dzn9laDKADT4drNlcZ
	 V9gZfU1431Rs/bTD9DXwosuKyqCmQQ4cyJL+ejJrkmZxo1qqTAOjJhp3AZ7BgigDIO
	 YZtrVjxMl2XRGdQrqPYP5Q9fsqqdafU2tRuKRn94hiAkjoz1+H4UwjjqIL6DPBNalu
	 8N7IP/yKnL9QQ==
Message-ID: <5b0b81b3-aaa1-4b5f-886e-8083276b7f65@kernel.org>
Date: Wed, 10 Sep 2025 11:55:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 5.10] mptcp: pm: kernel: flush: do not reset ADD_ADDR
 limit
Content-Language: en-GB, fr-BE
To: "Heyne, Maximilian" <mheyne@amazon.de>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Thomas Dreibholz <dreibh@simula.no>, Mat Martineau <martineau@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Matthieu Baerts <matthieu.baerts@tessares.net>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mptcp@lists.01.org" <mptcp@lists.01.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250910-nicety-alert-0e004251@mheyne-amazon>
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
In-Reply-To: <20250910-nicety-alert-0e004251@mheyne-amazon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Maximilian,

On 10/09/2025 11:28, Heyne, Maximilian wrote:
> From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
> 
> commit 68fc0f4b0d25692940cdc85c68e366cae63e1757 upstream.
> 
> A flush of the MPTCP endpoints should not affect the MPTCP limits. In
> other words, 'ip mptcp endpoint flush' should not change 'ip mptcp
> limits'.
> 
> But it was the case: the MPTCP_PM_ATTR_RCV_ADD_ADDRS (add_addr_accepted)
> limit was reset by accident. Removing the reset of this counter during a
> flush fixes this issue.
> 
> Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
> Cc: stable@vger.kernel.org
> Reported-by: Thomas Dreibholz <dreibh@simula.no>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/579
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-2-521fe9957892@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [adjusted patch by removing WRITE_ONCE to take into account the missing
>  commit 72603d207d59 ("mptcp: use WRITE_ONCE for the pernet *_max")]
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> ---
> For some reason only the corresponding selftest patch was backported and
> it's now failing on 5.10 kernels. I tested that with this patch the
> selftest is succeeding again.

Thank you for this backport. It looks good to me!

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>


I was waiting for the FAILED notification for this patch before adapting
it for v5.10, but it looks like I never got it, see:

https://lore.kernel.org/017c0cd3-7391-4d53-9e3e-ebdea5fa26da@kernel.org

No problem, that was not critical, and we now have a fix :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


