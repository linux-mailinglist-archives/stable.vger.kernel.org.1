Return-Path: <stable+bounces-172026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472B4B2F94A
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BE187AF840
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B52320399;
	Thu, 21 Aug 2025 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9wflG+3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0FF13A41F;
	Thu, 21 Aug 2025 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781495; cv=none; b=Z/rVLTMsrq59Tt5Rr8ejiSYqKQrj8DdYN3Uf06xBrezntnOw+Lb91C4uaAmz/jcYxKhxovaTMK7J7t4O6OUMV+AdNqV6RIOyktahEh4adnwjbqb3XJwJohL88R1dWxsI5niDdx2xoLkgbJOIVPhdPG3RF2j4PzGc7/dv79RNOWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781495; c=relaxed/simple;
	bh=afNeEt1xEIocZL5b/k7qATVzHSM7KVBgB9ZGL4lIsuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PT4ImDkQnIjeBXSHpMm2lJBQUqWhMC0KqNdzoalOkU4igilpss4AsJWuPl6LEO36RiAm7jaU7rSHSv8qRpML4Df1MfIDEpHEU/3j7sEy9/5HiMsktwxfh3UOZupaMtkGGY4InvPu0vlhjNU+FTjbWPzEaS3AkQI8deByumTJGTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9wflG+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F7FC4CEEB;
	Thu, 21 Aug 2025 13:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755781494;
	bh=afNeEt1xEIocZL5b/k7qATVzHSM7KVBgB9ZGL4lIsuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9wflG+3N1h8gqB+XnE+COeD536k9o98/BStH3ltto9n+BGberzNanAp/XKcq6psC
	 VjboWYzTCfvwqeaoWLwT8M+l/RxNBJenkRcnQ1O4IkGUZUUr8AmIhypECc142GJOVm
	 O8fwegSwmXg7DjmJCw81EeFe9hXnPnCZnHY7EOiDVoRmpIuNAlnC6innPrgfBhxgy2
	 dh97W43SRNw8FljCkgfRAyK9KB9WGwG47doiTTjB02FUjjrTdiHbPM1jRy5J3PiliG
	 iihONR8huulx+2yVat3Q9YIpGBGKO66j0ewyU1+txOUuTG6UeheyYmG3FsPjkAzXlA
	 GjNWOBee/Y54A==
Date: Thu, 21 Aug 2025 09:04:53 -0400
From: Sasha Levin <sashal@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Chanho Min <chanho.min@lge.com>,
	"David S . Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, gunho.lee@lge.com,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] ipv6: mcast: extend RCU protection in igmp6_send()
Message-ID: <aKcZdaEtye817DgO@laps>
References: <20250818092453.38281-1-chanho.min@lge.com>
 <062219ff-6abf-4289-84da-67a5c731564e@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <062219ff-6abf-4289-84da-67a5c731564e@redhat.com>

On Thu, Aug 21, 2025 at 11:23:23AM +0200, Paolo Abeni wrote:
>On 8/18/25 11:24 AM, Chanho Min wrote:
>> From: Eric Dumazet <edumazet@google.com>
>>
>> [ Upstream commit 087c1faa594fa07a66933d750c0b2610aa1a2946 ]
>>
>> igmp6_send() can be called without RTNL or RCU being held.
>>
>> Extend RCU protection so that we can safely fetch the net pointer
>> and avoid a potential UAF.
>>
>> Note that we no longer can use sock_alloc_send_skb() because
>> ipv6.igmp_sk uses GFP_KERNEL allocations which can sleep.
>>
>> Instead use alloc_skb() and charge the net->ipv6.igmp_sk
>> socket under RCU protection.
>>
>> Cc: stable@vger.kernel.org # 5.4
>> Fixes: b8ad0cbc58f7 ("[NETNS][IPV6] mcast - handle several network namespace")
>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>> Reviewed-by: David Ahern <dsahern@kernel.org>
>> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>> Link: https://patch.msgid.link/20250207135841.1948589-9-edumazet@google.com
>> [ chanho: Backports to v5.4.y. v5.4.y does not include
>> commit b4a11b2033b7(net: fix IPSTATS_MIB_OUTPKGS increment in OutForwDatagrams),
>> so IPSTATS_MIB_OUTREQUESTS was changed to IPSTATS_MIB_OUTPKGS defined as
>> 'OutRequests'. ]
>> Signed-off-by: Chanho Min <chanho.min@lge.com>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>FWIW, the SoB chain above looks incorrect, as I think that neither Jakub
>nor Sasha have touched yet this patch.

It's a backport of an older backport where there already exists a commit with
both Jakub's any my signoff:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=81b25a07ebf53f9ef4ca8f3d96a8ddb94561dd5a

But yes, the SoB chain is wrong because Chanho Min's SoB should come after
ours, not before.

-- 
Thanks,
Sasha

