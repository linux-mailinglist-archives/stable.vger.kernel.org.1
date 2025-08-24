Return-Path: <stable+bounces-172690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39995B32DA6
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 08:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E95867A2D85
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 06:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5C6198A2F;
	Sun, 24 Aug 2025 06:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l0v9wvQK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B3734CF9;
	Sun, 24 Aug 2025 06:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756015426; cv=none; b=KAybDpsSmRmK5Vb+E6TOW6z6DDYRwNEJnh76qAkceyIB/LT24ufVvZRdEn4UK97pAKVse1HYOCSB5e+MlHFAZMQtc4P8ZHP0Jx4EPxBf6lZIjGYBSiXM1ITKcSDU9hZBmNcwgeZZ8sYMkpcRm0GQJAhWNeN5wh32n4ZSDWZPdC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756015426; c=relaxed/simple;
	bh=JM7Y8fZKei0R8TTZ4Y3zviWlvPivwcOmnRPos+eOBbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1Uz8NrcCKs3eTGWQaN3D/BucjiUBhpMSoC4Qishz95Nnx8DWoGSk1r9Lkn0nJ6MioZXqSHyK8l5ASs3gY2egQbvHN+GYV1T8Iuft8QXoSHWM8Lz8DadPxclvYBC5oLtpeyrMqb6JBSysfCD+O1Sue5//QsFRc6utYia6a/JWxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l0v9wvQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92AAC4CEEB;
	Sun, 24 Aug 2025 06:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756015425;
	bh=JM7Y8fZKei0R8TTZ4Y3zviWlvPivwcOmnRPos+eOBbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l0v9wvQKMzpfpolvZ+Nyp/fgokA3VxbM5xzjzQyFGDIuiPo7AXg6jJkxTLi2NEagM
	 Txblo9OnsWHEVk8Ko+hncV+WEpw3FglCnds7sIAkycNIVfHq7W+aDaTTfwNGrXIcNy
	 OlmoBaYY5PovvlDurbB4pRSpMB9nAn2syOB9UFc0=
Date: Sun, 24 Aug 2025 08:03:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chanho Min <chanho.min@lge.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, gunho.lee@lge.com,
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] ipv6: mcast: extend RCU protection in igmp6_send()
Message-ID: <2025082405-entomb-eligibly-c616@gregkh>
References: <20250818092453.38281-1-chanho.min@lge.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818092453.38281-1-chanho.min@lge.com>

On Mon, Aug 18, 2025 at 06:24:53PM +0900, Chanho Min wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> [ Upstream commit 087c1faa594fa07a66933d750c0b2610aa1a2946 ]
> 
> igmp6_send() can be called without RTNL or RCU being held.
> 
> Extend RCU protection so that we can safely fetch the net pointer
> and avoid a potential UAF.
> 
> Note that we no longer can use sock_alloc_send_skb() because
> ipv6.igmp_sk uses GFP_KERNEL allocations which can sleep.
> 
> Instead use alloc_skb() and charge the net->ipv6.igmp_sk
> socket under RCU protection.
> 
> Cc: stable@vger.kernel.org # 5.4
> Fixes: b8ad0cbc58f7 ("[NETNS][IPV6] mcast - handle several network namespace")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Link: https://patch.msgid.link/20250207135841.1948589-9-edumazet@google.com
> [ chanho: Backports to v5.4.y. v5.4.y does not include
> commit b4a11b2033b7(net: fix IPSTATS_MIB_OUTPKGS increment in OutForwDatagrams),
> so IPSTATS_MIB_OUTREQUESTS was changed to IPSTATS_MIB_OUTPKGS defined as
> 'OutRequests'. ]

We can not take patches for only older kernel versions, as when you
upgrade you would have a regression.  Please send backports for all of
the missing stable versions and we will be glad to queue them up.

thanks,

greg k-h

