Return-Path: <stable+bounces-27223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF0D8778A3
	for <lists+stable@lfdr.de>; Sun, 10 Mar 2024 22:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C252811B4
	for <lists+stable@lfdr.de>; Sun, 10 Mar 2024 21:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D6C3A8CA;
	Sun, 10 Mar 2024 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWKz5aAT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6062DF7D;
	Sun, 10 Mar 2024 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710107540; cv=none; b=lD5mvrijQjRaIurpshThGP+nuZWNMKjZCAmzdWr8KWjU2DAvXDutOTKFCUyorZvNh/dyp1XCdenyXEJle0nPRryTRMUXv/lD6H6Jd+xNJ2Bn8m/BZn+iU7snNsEkn1kZUt2YcrJTtXKOkKFu5k/MbIfIJ4qZUCXdz5UJ2+KY12c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710107540; c=relaxed/simple;
	bh=Nu+HpKTnprxT1UB9q0gUEwsAEM927nwo9ElTKHsVT+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WP0q9rn/QxZfXQbZjjkdJsaiNMBFLwg/PGSBydLQoEI7Kz/tXccaO8LNXyaG//PkHyWa/cYaJJNf+eBmqoaAZqBpQ/L6diPx/3hgdxsa1ZJcTSwul26ucQ8HYFm2viFoDp5CyzxWSBmkDKaG9IHJpnd71FUI44SOjuEsQASPDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWKz5aAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2984C433C7;
	Sun, 10 Mar 2024 21:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710107540;
	bh=Nu+HpKTnprxT1UB9q0gUEwsAEM927nwo9ElTKHsVT+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NWKz5aATe06FU9a1jAlZYEsNTgmp2bLl66ZAj0LwloMVaO+7fy7Cf1YnraUIMLf/K
	 aBRw1L9WfvN2OXD+u3bwzmpMY1AZ/kNRwUhVO82135WwxhK0mQVy8VcDhRNMDiFTzV
	 Ku9w81HytWVWPF8+WFDYrhAqlJMZBG8b53lLobO8Dc912gqD4Zet8kww9sv31SJpnK
	 QhBvYTiKTNM8KFmuc34KIXGye7YKAecz39fGCaNjf90p8fXKGnpOlF4oCWgFna6Fd/
	 VTqSq8jLSENjjGtXDT1DRu5QzfKAxNHFIkJTvmV7B1ILs8XTw8WyScdc2BlFoB+1EG
	 Igaut7Rso2SOA==
Date: Sun, 10 Mar 2024 17:52:18 -0400
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, stable-commits@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: Patch "selftests: mptcp: simult flows: format subtests results
 in TAP" has been added to the 6.1-stable tree
Message-ID: <Ze4rksofBwNxQkFL@sashalap>
References: <20240310023325.119298-1-sashal@kernel.org>
 <9f185a3f-9373-401c-9a5c-ec0f106c0cbc@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9f185a3f-9373-401c-9a5c-ec0f106c0cbc@kernel.org>

On Sun, Mar 10, 2024 at 03:21:49PM +0100, Matthieu Baerts wrote:
>Hi Sasha,
>
>On 10/03/2024 03:33, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     selftests: mptcp: simult flows: format subtests results in TAP
>>
>> to the 6.1-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      selftests-mptcp-simult-flows-format-subtests-results.patch
>> and it can be found in the queue-6.1 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>Thank you for having backported this commit 675d99338e7a ("selftests:
>mptcp: simult flows: format subtests results in TAP") -- as well as
>commit 4d8e0dde0403 ("selftests: mptcp: simult flows: fix some subtest
>names"), a fix for it -- as a "dependence" for commit 5e2f3c65af47
>("selftests: mptcp: decrease BW in simult flows"), but I think it is
>better not to include 675d99338e7a (and 4d8e0dde0403): they are not
>dependences, just modifying the lines around, and they depend on other
>commits to have this feature to work.
>
>In other words, commit 675d99338e7a ("selftests: mptcp: simult flows:
>format subtests results in TAP") -- and 4d8e0dde0403 ("selftests: mptcp:
>simult flows: fix some subtest names") -- is now causing the MPTCP
>simult flows selftest to fail. Could it be possible to remove them from
>6.1 and 5.15 queues please?

I'll drop it, thanks!

-- 
Thanks,
Sasha

