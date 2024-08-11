Return-Path: <stable+bounces-66394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FB494E34E
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 23:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9601F220C3
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 21:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9E515886D;
	Sun, 11 Aug 2024 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqGGw5lT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A98879F4;
	Sun, 11 Aug 2024 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723411252; cv=none; b=s2rlF5CUHiKg67DnK3xS8OrsNBLNT/86JB01FWaKsdUVW8M59Hee1/66KNkctVKrLty+NDhMM0QCxCthTAVvnkcWK8d71yjYvQOKKIElwJY2Nq48vCQvBEGvP5d3ef3xpBE3TeLZbqM7e/evXNwu8wqHxFeQ9fgxl0n8KvIGQEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723411252; c=relaxed/simple;
	bh=wRo3Fj2ntgGct16RIXKjtY2mESy4UEDB1hu+1ctDdDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjTmf/VVQtqcDn7VitzyKUZgdZci+1ytGj67qcSNGflfXhKJT9bLp0suwuijGiuLHTMPYFgUdzYm79PZKHEcjK0sw+MH3aRvtwsjrgqFW2shqQf0xEJJC5JfK/fk7dNfrHQr83s8FBY3PiHowbSo8WOnULF4ZfAZw3s0LtIU/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqGGw5lT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05A3C32786;
	Sun, 11 Aug 2024 21:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723411252;
	bh=wRo3Fj2ntgGct16RIXKjtY2mESy4UEDB1hu+1ctDdDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqGGw5lTirzbAPil6610FoDnhSUxAGw0LXtCo0k/HncWJWA86Al4rHa7ChVHiB1Ob
	 zAW7U6Y/Tzzg9l75ViWvyzJgTvtGP+C4qf5qpiwPSHoaWmTB4Pu+KD8R/y170cxIYa
	 Cs9FDgWkTjKkc/BlLamiZg23TjiXaxW3vPugB7ZoPHIE8ddC85bgZenz/xoe/KFjIk
	 fiiSBuq7Q9RkuLQcqWohjYDleT9BIAptezxjbsu+L8A3/0srPFX5EzQ93Xmac580YI
	 bNglPunD5/BSfpCE3m0BjxgspjsSpbGF3vd/wB5EPaAUnsHJaEVzZ1kw/lr70NrUfO
	 6lofG8Dv6y1pg==
Date: Sun, 11 Aug 2024 17:20:50 -0400
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Mat Martineau <martineau@kernel.org>
Subject: Re: Patch "selftests: mptcp: join: ability to invert ADD_ADDR check"
 has been added to the 6.10-stable tree
Message-ID: <ZrkrMu55FR9ROhsQ@sashalap>
References: <20240811125614.1262228-1-sashal@kernel.org>
 <7180dcdb-694f-4014-9828-8baced3bfa7a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7180dcdb-694f-4014-9828-8baced3bfa7a@kernel.org>

On Sun, Aug 11, 2024 at 05:46:22PM +0200, Matthieu Baerts wrote:
>Hi Sasha, Greg,
>
>On 11/08/2024 14:56, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     selftests: mptcp: join: ability to invert ADD_ADDR check
>>
>> to the 6.10-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      selftests-mptcp-join-ability-to-invert-add_addr-chec.patch
>> and it can be found in the queue-6.10 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>>
>>
>> commit 469e6fe99988649029b7f136218d5c3d8854e705
>> Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Date:   Wed Jul 31 13:05:58 2024 +0200
>>
>>     selftests: mptcp: join: ability to invert ADD_ADDR check
>>
>>     [ Upstream commit bec1f3b119ebc613d08dfbcdbaef01a79aa7de92 ]
>>
>>     In the following commit, the client will initiate the ADD_ADDR, instead
>>     of the server. We need to way to verify the ADD_ADDR have been correctly
>>     sent.
>>
>>     Note: the default expected counters for when the port number is given
>>     are never changed by the caller, no need to accept them as parameter
>>     then.
>>
>>     The 'Fixes' tag here below is the same as the one from the previous
>>     commit: this patch here is not fixing anything wrong in the selftests,
>>     but it validates the previous fix for an issue introduced by this commit
>>     ID.
>
>Sorry, I just realised I forgot to add the "Cc: Stable" on all patches
>from this series :-/
>
>This patch and "selftests: mptcp: join: test both signal & subflow"
>should be backported with the other patches modifying files in
>net/mptcp. Without them, the two patches that have just been added to
>the queue will just make the selftests failing.
>
>Is it then possible to drop these two patches from the 6.10, 6.6 and 6.1
>queues for the moment please? I can send patches for these versions
>later on.
>
>  selftests-mptcp-join-ability-to-invert-add_addr-chec.patch: 6.10, 6.6
>  selftests-mptcp-join-test-both-signal-subflow.patch: 6.10, 6.6 and 6.1

Sure, now dropped.

-- 
Thanks,
Sasha

