Return-Path: <stable+bounces-45570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A5C8CC258
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 15:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837B01C227F7
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 13:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95E414038A;
	Wed, 22 May 2024 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJ696Q5J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAD913E3EB;
	Wed, 22 May 2024 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716385370; cv=none; b=dSxiqKioaVzCVTEYp7ffVaRChk4qMeWaz7UAYnXfqcPuObF+DJaGNFbS47y8aKG8OY0bFG0Lvg7Zz12ld1eR3XtjJoc6xJO2fJBlBxG4oxGtdeaziV5nKDNFZJMAIIbwCTDOtMkbg3vCGoLoysxG0pcuapcOqGuJ1IueLokRrvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716385370; c=relaxed/simple;
	bh=T28A7QNWQkhXDshEFyD2WCyzjLns6B7vVcmqDqKuwrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sB1dXmXuTcSB8IcizeD2rJ+kakpUFr1bUf9r/75lDa2akZu8OJ8rEAF/d2PuTMQGQIL9xthPAlbgnbLYjoEVImWxj3ZbJ01AU36lmcBtY84aWDDHHaOsAYLECgrJ3GRsd1FLWnWtsXtyLO4mEO6o7H6m/I5WPhqXQjJMCI3Md2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJ696Q5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54EFC2BD11;
	Wed, 22 May 2024 13:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716385370;
	bh=T28A7QNWQkhXDshEFyD2WCyzjLns6B7vVcmqDqKuwrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qJ696Q5JCZcBy1c+Hh1dk6OSrEb1z8kbbl0f12m4/wTOYaSHn8Y8416n1wYdFVwY1
	 fhLq7ycjinBoMSq+kG1jnULQlM+bFrkR193SAs04+1VPL4x1KIvYrw7nzqxyU8FB6R
	 RWgdyG9ivsLpIQV7CrwdeNH8B//BG7EAwpyHSqKaTu18pLxsZcddOdjfyVnNKzb8hk
	 MxadlOtdX4j/6MKs5K6lOQ5K2FcxBGz9XeG2xdItTnigjfoi0XMbrvVt5xUGJiWP3B
	 mdXIOPhhE8/u1f/WSBzHNI5TgNx1b5Lu403KULNZZ9PCJf8xiuwBJhSkx7yDzXJ4zH
	 m98ogOG27rpDA==
Date: Wed, 22 May 2024 08:57:31 -0400
From: Sasha Levin <sashal@kernel.org>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>, manishc@marvell.com,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 5/9] net: qede: sanitize 'rc' in
 qede_add_tc_flower_fltr()
Message-ID: <Zk3ruzqbpMAzZr9q@sashalap>
References: <20240507231406.395123-1-sashal@kernel.org>
 <20240507231406.395123-5-sashal@kernel.org>
 <ZkHMvNFzwPfMeJL3@duo.ucw.cz>
 <ea7ae0c4-a582-42ce-9bc9-5f3df1915ca0@fiberby.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea7ae0c4-a582-42ce-9bc9-5f3df1915ca0@fiberby.net>

On Mon, May 13, 2024 at 09:46:02AM +0000, Asbjørn Sloth Tønnesen wrote:
>Hi Pavel and Sasha,
>
>On 5/13/24 8:18 AM, Pavel Machek wrote:
>>>Explicitly set 'rc' (return code), before jumping to the
>>>unlock and return path.
>>>
>>>By not having any code depend on that 'rc' remains at
>>>it's initial value of -EINVAL, then we can re-use 'rc' for
>>>the return code of function calls in subsequent patches.
>>>
>>>Only compile tested.
>>
>>Only compile tested, and is a preparation for something we won't do in
>>stable. Does not fix a bug, please drop.
>
>Please see the original thread about this series[1], this patch is a requirement for
>two of the next patches, which does fix a few bugs with overruled error codes returned
>to user space.
>
>I was originally going to ignore these AUTOSEL mails, since the whole series was already
>added to the queued more than 24 hours earlier[2]. In the queue Sasha has also added "Stable-dep-of:'.
>
>So the weird thing is that AUTOSEL selected this patch, given that it was already in the queue.

Two different processes on my end, sorry for the noise!

-- 
Thanks,
Sasha

