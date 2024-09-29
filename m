Return-Path: <stable+bounces-78221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF577989649
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 18:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208FE284698
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 16:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB72317BB13;
	Sun, 29 Sep 2024 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4fvbiva"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FD02B9B7;
	Sun, 29 Sep 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727627551; cv=none; b=kNiLeqDYE98Mgu2LXs9lm0HOzGFQbMD9+L0MwB7lxq6UnAY5lbebZmOcpzQqX8PrGhl2Ke1Ikdbe0/52nD98AwVK8f4LGa4NcD6ipk1fADb9PGbkzkD3ToKzqqN5FfA27JlLWZbeRmU+LZzJEWa/GPjlxq66jh4Jf13cqxdKYhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727627551; c=relaxed/simple;
	bh=i908Yxa0CpGKiaBwpSxM83MAbs0HFj3QffWoptapr2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcRpCutkaQzV2aNBpyA9NF+idBAHAF76vKX69o4Fi8nQnnNbWmo7WACVhsrI/j4f+Cr+dBOVHZEvXhRmYObk+wIutyAI/1dWE0gnwHi7WdVZcckHZZ2w1CWpmmAWgOgYjJxeRybt0/GbcMlytv6LurJasSvcy5LV0RHVDtVIjdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4fvbiva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42C3C4CEC5;
	Sun, 29 Sep 2024 16:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727627550;
	bh=i908Yxa0CpGKiaBwpSxM83MAbs0HFj3QffWoptapr2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e4fvbiva9AlaLzkqr4WB3HjgcUbM5VhxTJJ1Nb5ASzWGNJDdvT+Qd3wTXy6bO/bpk
	 Yv7yeFFJM66+eg0Y5EG/wKdOn5v1CMI2dTdWbRKupJWao/+5VGsheRZ0M5XlwWCzgw
	 Zp/40Gz9PU6ikk/CJ/JPfoWHKPNd3N8ppd76MQy2ugBiZkhM3AjDoEupVuK8UT9qRo
	 UIQsPZallNjWcqE6BkgyjmddwobBpBxhd9YS7IYgCFFdQYrz9zfE3+GKlmhdAgPwNn
	 LnKRbwx0Nv8HajLnVf9EoFvBpgMfktqumw8llEbD1nMpmtiw2F1zXwRG9N+e4dHQUx
	 yfkgPgNafri1Q==
Message-ID: <6676d990-e7b4-4b90-8d2b-a96107e38b63@kernel.org>
Date: Sun, 29 Sep 2024 10:32:28 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vrf: revert "vrf: Remove unnecessary RCU-bh critical
 section"
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, stable@vger.kernel.org,
 greearb@candelatech.com, fw@strlen.de, Willem de Bruijn <willemb@google.com>
References: <20240929061839.1175300-1-willemdebruijn.kernel@gmail.com>
 <ZvkZ0Ex0k6_G6hNo@shredder.mtl.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZvkZ0Ex0k6_G6hNo@shredder.mtl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/24 3:11 AM, Ido Schimmel wrote:
> On Sun, Sep 29, 2024 at 02:18:20AM -0400, Willem de Bruijn wrote:
>> From: Willem de Bruijn <willemb@google.com>
>>
>> This reverts commit 504fc6f4f7f681d2a03aa5f68aad549d90eab853.
>>
>> dev_queue_xmit_nit is expected to be called with BH disabled.
>> __dev_queue_xmit has the following:
>>
>>         /* Disable soft irqs for various locks below. Also
>>          * stops preemption for RCU.
>>          */
>>         rcu_read_lock_bh();
>>
>> VRF must follow this invariant. The referenced commit removed this
>> protection. Which triggered a lockdep warning:
> 
> [...]
> 
>>
>> Fixes: 504fc6f4f7f6 ("vrf: Remove unnecessary RCU-bh critical section")
>> Link: https://lore.kernel.org/netdev/20240925185216.1990381-1-greearb@candelatech.com/
>> Reported-by: Ben Greear <greearb@candelatech.com>
>> Signed-off-by: Willem de Bruijn <willemb@google.com>
>> Cc: stable@vger.kernel.org
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Tested-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: David Ahern <dsahern@kernel.org>


> 
> Thanks Willem!
> 
> The reason my script from 504fc6f4f7f6 did not trigger the problem is
> that it was pinging the address inside the VRF, so vrf_finish_direct()
> was only called from the Rx path.
> 
> If you ping the address outside of the VRF:
> 
> ping -I vrf1 -i 0.1 -c 10 -q 192.0.2.1
> 
> Then vrf_finish_direct() is called from process context and the lockdep
> warning is triggered. Tested that it does not trigger after applying the
> revert.

That case should be covered by the fcnal-test suite which does all
combinations of addresses.


