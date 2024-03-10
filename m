Return-Path: <stable+bounces-27215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CD2877756
	for <lists+stable@lfdr.de>; Sun, 10 Mar 2024 15:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28D41F21D26
	for <lists+stable@lfdr.de>; Sun, 10 Mar 2024 14:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD902D79D;
	Sun, 10 Mar 2024 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsz3ntQL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D292C856;
	Sun, 10 Mar 2024 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710080515; cv=none; b=b5r905+uS+x61WDtW4pqt/YNW4RgNVHvMR0EJgzk4YmFvT4xsQg/B/89161olwutCGixydhzOdhqzStt2wVVmhTRMZHiguUGtwMsgltp1xBDTxVSTx2QlHr0q4f4TOjTmmUP3twW9HDVTp8pCygkvWsYWyBApCkUQEV9xsBjlhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710080515; c=relaxed/simple;
	bh=OSnDB1+NJLW9YwIesp6bt5GyIcde7kuGfrg8ztUEVsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3a373KsPEffN0w2qotrNqiAQTESDv406D5Ka+xZVWvvnQDN38wnLfb43usvpcPa/YX6LNZJUxT8foOKpC+CyV2p9pkJkfh+RfSdbLITctc48gPj8aosh9eOy8aFTgYy6EorQ2IvccmZlOUw2sDZL9kI6bTUN7/VcYNSmbSBovc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsz3ntQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E41C433F1;
	Sun, 10 Mar 2024 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710080515;
	bh=OSnDB1+NJLW9YwIesp6bt5GyIcde7kuGfrg8ztUEVsk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hsz3ntQLHmyUm4zKdYxE1827zxFFkuRQGEkESkQGocugkZaDo9WJ91UmmqZXZJ++8
	 DJimCrAI2gLELiX2HwZNi7NR2MnqW5p3QnUjSLkAQxM/WVIJfTgrvBffp+zKktUx/n
	 ZFHtkimIVVMO7us6iu588infE1G8c7R0ZKAkF1aMRWZqfe35JvUjO+Qz9xpyBe4vbZ
	 EVi6zDcjSO4nddKaKm3Mqz1lOKpL+22r5wSY9R5OSeaksB25h1VksQqOLe28E1wuou
	 VsblkJNKLiUUfkbx/nCsQNvzuL/hI4n9u9WTyci5kBBdcZOUKMzIbxRNd0EITsENaP
	 rmJ0yz4CAsMyw==
Message-ID: <9f185a3f-9373-401c-9a5c-ec0f106c0cbc@kernel.org>
Date: Sun, 10 Mar 2024 15:21:49 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: Patch "selftests: mptcp: simult flows: format subtests results in
 TAP" has been added to the 6.1-stable tree
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, stable-commits@vger.kernel.org,
 stable@vger.kernel.org
References: <20240310023325.119298-1-sashal@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240310023325.119298-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sasha,

On 10/03/2024 03:33, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     selftests: mptcp: simult flows: format subtests results in TAP
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      selftests-mptcp-simult-flows-format-subtests-results.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Thank you for having backported this commit 675d99338e7a ("selftests:
mptcp: simult flows: format subtests results in TAP") -- as well as
commit 4d8e0dde0403 ("selftests: mptcp: simult flows: fix some subtest
names"), a fix for it -- as a "dependence" for commit 5e2f3c65af47
("selftests: mptcp: decrease BW in simult flows"), but I think it is
better not to include 675d99338e7a (and 4d8e0dde0403): they are not
dependences, just modifying the lines around, and they depend on other
commits to have this feature to work.

In other words, commit 675d99338e7a ("selftests: mptcp: simult flows:
format subtests results in TAP") -- and 4d8e0dde0403 ("selftests: mptcp:
simult flows: fix some subtest names") -- is now causing the MPTCP
simult flows selftest to fail. Could it be possible to remove them from
6.1 and 5.15 queues please?

> commit 4eeef0aaffa567f812390612c30f800de02edd73
> Author: Matthieu Baerts <matttbe@kernel.org>
> Date:   Mon Jul 17 15:21:31 2023 +0200
> 
>     selftests: mptcp: simult flows: format subtests results in TAP
>     
>     [ Upstream commit 675d99338e7a6cd925d61d7dbf8c26612f7f08a9 ]
>     
>     The current selftests infrastructure formats the results in TAP 13. This
>     version doesn't support subtests and only the end result of each
>     selftest is taken into account. It means that a single issue in a
>     subtest of a selftest containing multiple subtests forces the whole
>     selftest to be marked as failed. It also means that subtests results are
>     not tracked by CIs executing selftests.
>     
>     MPTCP selftests run hundreds of various subtests. It is then important
>     to track each of them and not one result per selftest.
>     
>     It is particularly interesting to do that when validating stable kernels
>     with the last version of the test suite: tests might fail because a
>     feature is not supported but the test didn't skip that part. In this
>     case, if subtests are not tracked, the whole selftest will be marked as
>     failed making the other subtests useless because their results are
>     ignored.
>     
>     This patch formats subtests results in TAP in simult_flows.sh selftest.
>     
>     Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
>     Acked-by: Paolo Abeni <pabeni@redhat.com>
>     Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>     Stable-dep-of: 5e2f3c65af47 ("selftests: mptcp: decrease BW in simult flows")

If needed, I can help to resolve the conflicts to have commit
5e2f3c65af47 ("selftests: mptcp: decrease BW in simult flows")
backported to 6.1 and 5.15.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


