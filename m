Return-Path: <stable+bounces-28425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA09880108
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 16:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2402428299A
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 15:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F99B657CF;
	Tue, 19 Mar 2024 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwmreV05"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03C01EEE8;
	Tue, 19 Mar 2024 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863273; cv=none; b=qwZrc0q9EGNglsI4j70VsMm81X5MsMomxWFxC8jyUK+VjNG85Nx7ie7TCbYW8Unz/90hwuAP6TeGc8anYosHmpaWkQgsVvh4w9od2cRe1AdPX/RRrAte12ulgyvMjbpglv5JfHerkq+YS59qJ/jYRF5UR3BKAjrQPxZrhUCV++A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863273; c=relaxed/simple;
	bh=TfGzIDZGL6CbyNtqYWXl6DXZQ/mdt3vXIBDajqSOyAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE0IUUH/qT6TLmLwmS101coLOA3oiH32DyBxI5cfhW7z2QPAjjL7I7Q+1CcHHmHSYIRdzuFD96Imutu7tHvWK9YdvL+MpdaSbX3WYsIOZ8weCdfTC7kSzbIqbdJisjmjk0Ls3PC/ly70GCqFOf91Wq1mALXQ+rbNlqJLl9UclxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwmreV05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C9DC433F1;
	Tue, 19 Mar 2024 15:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710863273;
	bh=TfGzIDZGL6CbyNtqYWXl6DXZQ/mdt3vXIBDajqSOyAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DwmreV05a/zGbKgGjuCNBRVWNlGrph2FF4mblhal9b6SIUnElGHUdK/U9TPup/tWh
	 yj5KZU5KA5OiAtOo+TVMdzpXtXmP4s1yNaFvcEox32vL/Ec2qdit8ylgpyxNWxP/yB
	 BnrkJdOwI+SZaR5bEYI9cSw5y1X1+mYyUVTeRFjDoxo/8dejfEv9E7ccfawu6qkSrN
	 mnvnOJ9KyRNlqooHl89dYvUtWg87cl7C8reAWToIHn4AC/bIpfucrkL+ocBW0Ol73F
	 1zOjusg0FXFgnO5rW53Kydt9wegLcnlUxvYveNVXMH4OXno1JYHh2Mone+iWO0tSty
	 vOyoI7E+ZdZuA==
Date: Tue, 19 Mar 2024 11:25:36 -0400
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	pabeni@redhat.com, stable-commits@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: Patch "selftests: mptcp: explicitly trigger the listener diag
 code-path" has been added to the 6.7-stable tree
Message-ID: <ZfmucN89q-5SL9H8@sashalap>
References: <20240318230045.2162042-1-sashal@kernel.org>
 <07543c96-f3f4-4df8-b77c-3824d6f53f29@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <07543c96-f3f4-4df8-b77c-3824d6f53f29@kernel.org>

On Tue, Mar 19, 2024 at 03:49:52PM +0100, Matthieu Baerts wrote:
>Hi Sasha,
>
>On 19/03/2024 00:00, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     selftests: mptcp: explicitly trigger the listener diag code-path
>>
>> to the 6.7-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      selftests-mptcp-explicitly-trigger-the-listener-diag.patch
>> and it can be found in the queue-6.7 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>I do :)
>
>> commit 02dc7e7327bc1a3551665745a40029cf96d6a8e6
>> Author: Paolo Abeni <pabeni@redhat.com>
>> Date:   Fri Feb 23 17:14:20 2024 +0100
>>
>>     selftests: mptcp: explicitly trigger the listener diag code-path
>>
>>     [ Upstream commit b4b51d36bbaa3ddb93b3e1ca3a1ef0aa629d6521 ]
>
>I think something went wrong: this patch was not supposed to be added to
>both 6.6 and 6.7 queues:
>
>  https://lore.kernel.org/stable/Zfg36tcGXUsZnJCh@sashalap/
>
>Do you mind dropping them from both queues, please?

Gah, sorry, I messed up. Now dropped.

-- 
Thanks,
Sasha

