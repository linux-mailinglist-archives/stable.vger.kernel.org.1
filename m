Return-Path: <stable+bounces-37862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D89389D909
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 14:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58470289F96
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 12:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3308F12BEBE;
	Tue,  9 Apr 2024 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KfhvdQtk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45C812B14A;
	Tue,  9 Apr 2024 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664974; cv=none; b=prp20iyVjG1P/p18DEX/599V4T/KJZPfVxD6shk+wxOxcML4XMNzIljK7uQB1PX1LUP33YWuVmDY0m//eAhcvGR689wTlaLUCQwYZlNj97u9G9nWmv8bJFce0zBgCMHxL0M9V2qfM4JvARGV3AKLGXSczg+Sk/4HcqXgRIbFXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664974; c=relaxed/simple;
	bh=oQNO+16hhnJmSZxUd8J4WSbYDbVHuD1/9tDfkkokQJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlBRVtu+ioF9ldMIotCiX5tW+hlrLTiJoyAdBtTFTIAAPUQwm7LLHO7I5AsqV97UXQV+v9AdqTjCVMOfzru1jyc9qBY6wo19jGkaul3cbO0HjPoAkMg1nT3ciUoB5nOzLZfHulwdRvl5hcXqelns5hqDsW0pIJjvz37w3l9ODEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KfhvdQtk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B0AC433C7;
	Tue,  9 Apr 2024 12:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712664973;
	bh=oQNO+16hhnJmSZxUd8J4WSbYDbVHuD1/9tDfkkokQJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KfhvdQtkSGffVkIlpGynKmvGfkzqhv1SIiX22zxaLt2WK9Vm4xAcJ/Mo+HnNyjbL0
	 AIF8rvLDWqWdf1tLxEmgWSzkjMB+fES+nENlBO9ydirjG6LcV1cK+OMIRNkM95vjZ1
	 R5IreR6RGw9sIEAHz5M1V0NETIFkEWjgMT5UJPz0=
Date: Tue, 9 Apr 2024 14:16:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.6.y 3/5] selftests: mptcp: use += operator to append
 strings
Message-ID: <2024040902-syrup-sneezing-62c4@gregkh>
References: <2024040520-unselect-antitrust-a41b@gregkh>
 <20240405153636.958019-10-matttbe@kernel.org>
 <2024040801-undaunted-boastful-5a01@gregkh>
 <26b5e6f5-6da2-44ff-adbd-c1c1eda3ccba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26b5e6f5-6da2-44ff-adbd-c1c1eda3ccba@kernel.org>

On Mon, Apr 08, 2024 at 06:10:38PM +0200, Matthieu Baerts wrote:
> Hi Greg,
> 
> On 08/04/2024 13:31, Greg KH wrote:
> > On Fri, Apr 05, 2024 at 05:36:40PM +0200, Matthieu Baerts (NGI0) wrote:
> >> From: Geliang Tang <tanggeliang@kylinos.cn>
> >>
> >> This patch uses addition assignment operator (+=) to append strings
> >> instead of duplicating the variable name in mptcp_connect.sh and
> >> mptcp_join.sh.
> >>
> >> This can make the statements shorter.
> >>
> >> Note: in mptcp_connect.sh, add a local variable extra in do_transfer to
> >> save the various extra warning logs, using += to append it. And add a
> >> new variable tc_info to save various tc info, also using += to append it.
> >> This can make the code more readable and prepare for the next commit.
> >>
> >> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> >> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >> Link: https://lore.kernel.org/r/20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-8-4f42c347b653@kernel.org
> >> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >> (cherry picked from commit e7c42bf4d320affe37337aa83ae0347832b3f568)
> >> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >> ---
> >>  .../selftests/net/mptcp/mptcp_connect.sh      | 53 ++++++++++---------
> >>  .../testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++------
> >>  2 files changed, 43 insertions(+), 40 deletions(-)
> > 
> > Odd, this one did not apply.
> 
> Indeed, that's odd. Do you use a different merge strategy?

I do not use any merge strategy at all, I use 'patch' to apply patches
(well, that's what quilt does), so git is not involved here.

> I just tried on my side with the default merge strategy coming with Git
> 2.43.0, and it works:
> 
>   $ git fetch
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> refs/heads/linux-6.6.y
>   $ git switch -c tmp FETCH_HEAD
>   $ git rebase -i 2f39e4380e73~ ## to drop these 3 patches you added:
>     # 2f39e4380e73 selftests: mptcp: connect: fix shellcheck warnings
> 
> 
> 
>     # bd3b5b0fff75 mptcp: don't overwrite sock_ops in mptcp_is_tcpsk()
> 
> 
> 
>     # f723f9449193 mptcp: don't account accept() of non-MPC client (...)
>   $ git cherry-pick -xs \
>     629b35a225b0 e3aae1098f10 e7c42bf4d320 8e2b8a9fa512 7a1b3490f47e
>   Auto-merging tools/testing/selftests/net/mptcp/mptcp_join.sh
>   (...)
>   $ echo $?
>   0
> 
> But if I try the 3 patches you selected
> 
>   $ git reset --hard HEAD~5
>   $ git cherry-pick -xs e3aae1098f10 8e2b8a9fa512 7a1b3490f47e
>   Auto-merging tools/testing/selftests/net/mptcp/mptcp_connect.sh
>   (...)
>   CONFLICT (content): Merge conflict in
> tools/testing/selftests/net/mptcp/mptcp_connect.sh
>   error: could not apply 7a1b3490f47e... mptcp: don't account accept()
> of non-MPC client as fallback to TCP
> 
> 
> And the conflict makes sense: with the version that is currently in
> linux-6.6.y branch, the new check is done after having printed "OK", so
> that's not correct.
> 
> 
> I can share the 5 patches I applied without conflicts on top of the
> current linux-6.6.y branch, without the 3 patches you added today if it
> can help.

How about just resending this one patch after the next 6.6.y release
that comes out in a day or so.

thanks,

greg k-h

