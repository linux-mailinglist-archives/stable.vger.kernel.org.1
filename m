Return-Path: <stable+bounces-37783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCD489C95F
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 18:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD35D1F234B4
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 16:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDEB1422B5;
	Mon,  8 Apr 2024 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbRVLdHm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308601422AC;
	Mon,  8 Apr 2024 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592644; cv=none; b=I/sOODUxHdsT3UVp7mahf/JtZ2xRSQZuFfcSx1Vzs1RAC/wJC/ElaaUm8iXlbEFgroUWYF9l32LDmA3uDIAyYqg4G4zdBNQ4igg7Nce/N2ojtYEze5TUIfGcTeDBIVa9qVljwB47UY+zOIYGooZxCb6C+7PqwjLhzFgLIlR1b/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592644; c=relaxed/simple;
	bh=WU1dAnBPBYUs5YVwHT2GQEbOUF6Cch5bk9bErVfgI5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZjpgQygOWxWw96Qwx5+v+HlPisekaSYnzExNCjKmwyzKtn1yHribUprblkuYIO2i6pQvlzToNapEKnggO7ApEevB0Ik7tAuzQBdI1vS0VAH1rqpQCgonMCmcKUVC7upxA/S8uoxgSu8e9+k+BFCfiE+1PB2ACuHgy6TM6hEHYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbRVLdHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B9AC433F1;
	Mon,  8 Apr 2024 16:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712592643;
	bh=WU1dAnBPBYUs5YVwHT2GQEbOUF6Cch5bk9bErVfgI5o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qbRVLdHmWe1SG5k4lTlF6pmlo7rhZEal3fcoIXMD4DgdfjCp4ryFuR/H+NsyN0F/k
	 IPK0kKiCkGvKR1gm8r0Cs+aDKCmqWvI//BtUuEBKieHXF4ZMeycmABHn92qbUoKeG0
	 CSLHejeQSGuwKF0zRlR8uo9DYYcl+YiRWVyW/V3sNtB686Fpbx9GbLfn3EeqbSGzrf
	 92Q72qqPfv5iYthASNvFxZbFoNoEQFlkhMylHvlMGYW5cM4XYXj8IMirfBGiS/Q1ZX
	 Nu6hqVDAtX9Ig8+G26gSm8wjvk3c8YqukNZIEwqYR4mbJiF+WFSybZay4vh+Ux134R
	 oAkA1icwfO/+w==
Message-ID: <26b5e6f5-6da2-44ff-adbd-c1c1eda3ccba@kernel.org>
Date: Mon, 8 Apr 2024 18:10:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 6.6.y 3/5] selftests: mptcp: use += operator to append
 strings
Content-Language: en-GB
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org,
 Geliang Tang <tanggeliang@kylinos.cn>, Jakub Kicinski <kuba@kernel.org>
References: <2024040520-unselect-antitrust-a41b@gregkh>
 <20240405153636.958019-10-matttbe@kernel.org>
 <2024040801-undaunted-boastful-5a01@gregkh>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2024040801-undaunted-boastful-5a01@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg,

On 08/04/2024 13:31, Greg KH wrote:
> On Fri, Apr 05, 2024 at 05:36:40PM +0200, Matthieu Baerts (NGI0) wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> This patch uses addition assignment operator (+=) to append strings
>> instead of duplicating the variable name in mptcp_connect.sh and
>> mptcp_join.sh.
>>
>> This can make the statements shorter.
>>
>> Note: in mptcp_connect.sh, add a local variable extra in do_transfer to
>> save the various extra warning logs, using += to append it. And add a
>> new variable tc_info to save various tc info, also using += to append it.
>> This can make the code more readable and prepare for the next commit.
>>
>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Link: https://lore.kernel.org/r/20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-8-4f42c347b653@kernel.org
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> (cherry picked from commit e7c42bf4d320affe37337aa83ae0347832b3f568)
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  .../selftests/net/mptcp/mptcp_connect.sh      | 53 ++++++++++---------
>>  .../testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++------
>>  2 files changed, 43 insertions(+), 40 deletions(-)
> 
> Odd, this one did not apply.

Indeed, that's odd. Do you use a different merge strategy?

I just tried on my side with the default merge strategy coming with Git
2.43.0, and it works:

  $ git fetch
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
refs/heads/linux-6.6.y
  $ git switch -c tmp FETCH_HEAD
  $ git rebase -i 2f39e4380e73~ ## to drop these 3 patches you added:
    # 2f39e4380e73 selftests: mptcp: connect: fix shellcheck warnings



    # bd3b5b0fff75 mptcp: don't overwrite sock_ops in mptcp_is_tcpsk()



    # f723f9449193 mptcp: don't account accept() of non-MPC client (...)
  $ git cherry-pick -xs \
    629b35a225b0 e3aae1098f10 e7c42bf4d320 8e2b8a9fa512 7a1b3490f47e
  Auto-merging tools/testing/selftests/net/mptcp/mptcp_join.sh
  (...)
  $ echo $?
  0

But if I try the 3 patches you selected

  $ git reset --hard HEAD~5
  $ git cherry-pick -xs e3aae1098f10 8e2b8a9fa512 7a1b3490f47e
  Auto-merging tools/testing/selftests/net/mptcp/mptcp_connect.sh
  (...)
  CONFLICT (content): Merge conflict in
tools/testing/selftests/net/mptcp/mptcp_connect.sh
  error: could not apply 7a1b3490f47e... mptcp: don't account accept()
of non-MPC client as fallback to TCP


And the conflict makes sense: with the version that is currently in
linux-6.6.y branch, the new check is done after having printed "OK", so
that's not correct.


I can share the 5 patches I applied without conflicts on top of the
current linux-6.6.y branch, without the 3 patches you added today if it
can help.


> All others did, thanks!

Thank you!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


