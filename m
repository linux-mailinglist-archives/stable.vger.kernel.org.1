Return-Path: <stable+bounces-43610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B92AA8C3E52
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 11:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D9D283108
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 09:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F1C148FE7;
	Mon, 13 May 2024 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="p0H3BHkH"
X-Original-To: stable@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00144148833;
	Mon, 13 May 2024 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715593578; cv=none; b=fZSnV5BK2HW2tUDx1Yjng/JR166A/brmf0NOHSyBI6OTtmIceuVBXsUIx9gC3bxpUb5F8deknBEtarIMtgOCHi2tiLieo89Xz9Y9tU0g0NNbFzCD0v9PAMpiwFuMSTL1q4ObXN4qJbG6aZBNI5K18zHaIQ62G52NIrvQ06fFo84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715593578; c=relaxed/simple;
	bh=78JACrpwAIJUzYoSzz7DFXvGbWIB1h/emV8sTNs8WJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMGzcOG+otdgxJBLdjUoHixvNcLa8v4Nom/9gt9WdXp0MR9VYyK8S/sfs75ihOgBDpasztTulg+cRCs/Yr5yqyfGjz6sUblq98+/w0o20Cd488vb0rMwrXz4Srvxxkalyx33xX7Xz+oWpt9MR5hsq67EGTmXsmB6Qtoau1JyIPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=p0H3BHkH; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 20651600A2;
	Mon, 13 May 2024 09:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715593567;
	bh=78JACrpwAIJUzYoSzz7DFXvGbWIB1h/emV8sTNs8WJ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p0H3BHkHa1+VvaLOC6d0yomZXawT6XotRgEQvHOncpF2JprfpLoVLURmLXzIzM8rl
	 6frgSiMW586WJKv8ogFTn7km7PQ3AVBs/xNjc+ar31gParFkzipPOYTZjexUgjhm11
	 3LTiSIyrMZxzLSwItQNL9TIS7wu9TxCKVixtDVx7LxbHG6siKX4mtUCr3KSu9iE0RW
	 NNyLb80DzaWQZoyfiWhL8DuqBOQK0FSGKGCWDD1GJdzP6YizNN2rshsEbvHdyFEYFs
	 cForyHpnDHxrJIwGTK982CdChYZonIuiB13oGPhcZnebd2G+1IqsPFn/GsbnqKwB+y
	 rQwF4fWbmbXGA==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 6EB5C202E4D;
	Mon, 13 May 2024 09:46:02 +0000 (UTC)
Message-ID: <ea7ae0c4-a582-42ce-9bc9-5f3df1915ca0@fiberby.net>
Date: Mon, 13 May 2024 09:46:02 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 5.10 5/9] net: qede: sanitize 'rc' in
 qede_add_tc_flower_fltr()
To: Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Simon Horman <horms@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 manishc@marvell.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
References: <20240507231406.395123-1-sashal@kernel.org>
 <20240507231406.395123-5-sashal@kernel.org> <ZkHMvNFzwPfMeJL3@duo.ucw.cz>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <ZkHMvNFzwPfMeJL3@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Pavel and Sasha,

On 5/13/24 8:18 AM, Pavel Machek wrote:
>> Explicitly set 'rc' (return code), before jumping to the
>> unlock and return path.
>>
>> By not having any code depend on that 'rc' remains at
>> it's initial value of -EINVAL, then we can re-use 'rc' for
>> the return code of function calls in subsequent patches.
>>
>> Only compile tested.
> 
> Only compile tested, and is a preparation for something we won't do in
> stable. Does not fix a bug, please drop.

Please see the original thread about this series[1], this patch is a requirement for
two of the next patches, which does fix a few bugs with overruled error codes returned
to user space.

I was originally going to ignore these AUTOSEL mails, since the whole series was already
added to the queued more than 24 hours earlier[2]. In the queue Sasha has also added "Stable-dep-of:'.

So the weird thing is that AUTOSEL selected this patch, given that it was already in the queue.

[1] https://lore.kernel.org/netdev/20240426091227.78060-1-ast@fiberby.net/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=queue/5.10

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

