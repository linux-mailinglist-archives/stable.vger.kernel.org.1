Return-Path: <stable+bounces-77701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D26986197
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8815528991D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A73618C025;
	Wed, 25 Sep 2024 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="ZC1AKWtz"
X-Original-To: stable@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B011E1591F1;
	Wed, 25 Sep 2024 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274447; cv=none; b=Tp1b1FOOz9nl7kyUhcSN0OiRjx10nyKh3Vvyn7tD7l64+DpNtuvpYwVb0oflXRa4xpOL+W2+f0Ff9XOgI0170gzgHbQD30Fb9Law3t8oJaDqVcgMD51h3pSGpeEJrslCzyqh6sdtJumKaGthAVQ7j3KAlQu+fzlA4NBCVsFT6Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274447; c=relaxed/simple;
	bh=bhvtRarpHSVTNks2vCbLrJjJOWzryXa6FZRUsxuqhgY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=KWaeZ5OdOXZE0TJaykwemLZv+m5sSciHFl8N0krmHgODQTV11Of0nzCi1UvZROY5EiP+patoyc/jY33YFR/6zq682YbdNqVo8QVJVlN3+YHDfFExilrJwnncTHjF/NvC00c5TPsUvl/57X0VYZqrGO9+59Mnll78TV+s0a/mQSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=ZC1AKWtz; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:2:fd3b:359b:7b1f:f7be] (unknown [IPv6:2a02:8010:6359:2:fd3b:359b:7b1f:f7be])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 0CDC67D118;
	Wed, 25 Sep 2024 15:27:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1727274444; bh=bhvtRarpHSVTNks2vCbLrJjJOWzryXa6FZRUsxuqhgY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<20e00433-dc5c-74aa-6195-16281867dbb1@katalix.com>|
	 Date:=20Wed,=2025=20Sep=202024=2015:27:23=20+0100|MIME-Version:=20
	 1.0|To:=20Sasha=20Levin=20<sashal@kernel.org>,=20linux-kernel@vger
	 .kernel.org,=0D=0A=20stable@vger.kernel.org|Cc:=20Tom=20Parkin=20<
	 tparkin@katalix.com>,=20"David=20S=20.=20Miller"=0D=0A=20<davem@da
	 vemloft.net>,=20edumazet@google.com,=20kuba@kernel.org,=0D=0A=20pa
	 beni@redhat.com,=20netdev@vger.kernel.org|References:=20<202409251
	 21137.1307574-1-sashal@kernel.org>=0D=0A=20<20240925121137.1307574
	 -30-sashal@kernel.org>|From:=20James=20Chapman=20<jchapman@katalix
	 .com>|Subject:=20Re:=20[PATCH=20AUTOSEL=206.6=20030/139]=20l2tp:=2
	 0don't=20use=20tunnel=20socket=0D=0A=20sk_user_data=20in=20ppp=20p
	 rocfs=20output|In-Reply-To:=20<20240925121137.1307574-30-sashal@ke
	 rnel.org>;
	b=ZC1AKWtzVyJZmXy1gcgEoqlEWTNljDUJVxisRw4uNm12TSTdEAu+y1t3i/yCASYvw
	 NvgCeynlzwgSQTVQLlDHSezrbhq8Wa5Xb/7eBPpscjUVHo2qelJDlXlQb0c7QLF5sy
	 emjNCo17IyQt65dBNxwyZc9Dg1OmXkcTY1LWbDMD8k0joXKmyq1LuonD/CP3GN9G1p
	 UYVejp0CeQ344veXv3h3Bw/rjjFXNGuAVRKIWB5Xb3Y9p0T+04BI0cclQd32BAan/h
	 PluO32AzdMCCFYefBGMpInxCMxTuj9dTDF6Fr8zPczy/3ktEu4U7WlyS0AAy3JV5hq
	 NA0wT44Wb19Tw==
Message-ID: <20e00433-dc5c-74aa-6195-16281867dbb1@katalix.com>
Date: Wed, 25 Sep 2024 15:27:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Tom Parkin <tparkin@katalix.com>, "David S . Miller"
 <davem@davemloft.net>, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
References: <20240925121137.1307574-1-sashal@kernel.org>
 <20240925121137.1307574-30-sashal@kernel.org>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCH AUTOSEL 6.6 030/139] l2tp: don't use tunnel socket
 sk_user_data in ppp procfs output
In-Reply-To: <20240925121137.1307574-30-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/09/2024 13:07, Sasha Levin wrote:
> From: James Chapman <jchapman@katalix.com>
> 
> [ Upstream commit eeb11209e000797d555aefd642e24ed6f4e70140 ]
> 
> l2tp's ppp procfs output can be used to show internal state of
> pppol2tp. It includes a 'user-data-ok' field, which is derived from
> the tunnel socket's sk_user_data being non-NULL. Use tunnel->sock
> being non-NULL to indicate this instead.
> 
> Signed-off-by: James Chapman <jchapman@katalix.com>
> Signed-off-by: Tom Parkin <tparkin@katalix.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   net/l2tp/l2tp_ppp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> index 6146e4e67bbb5..6ab8c47487161 100644
> --- a/net/l2tp/l2tp_ppp.c
> +++ b/net/l2tp/l2tp_ppp.c
> @@ -1511,7 +1511,7 @@ static void pppol2tp_seq_tunnel_show(struct seq_file *m, void *v)
>   
>   	seq_printf(m, "\nTUNNEL '%s', %c %d\n",
>   		   tunnel->name,
> -		   (tunnel == tunnel->sock->sk_user_data) ? 'Y' : 'N',
> +		   tunnel->sock ? 'Y' : 'N',
>   		   refcount_read(&tunnel->ref_count) - 1);
>   	seq_printf(m, " %08x %ld/%ld/%ld %ld/%ld/%ld\n",
>   		   0,

This change isn't needed in 6.6. The commit was part of a series for 
6.12 that removed use of sk_user_data in l2tp tunnel sockets.


