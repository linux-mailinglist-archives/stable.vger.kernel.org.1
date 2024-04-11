Return-Path: <stable+bounces-38058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D961E8A09D8
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 09:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19450B26697
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 07:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2938413E416;
	Thu, 11 Apr 2024 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SB6GCJGQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE37713E057;
	Thu, 11 Apr 2024 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820776; cv=none; b=JjZ/N8ZSvzyuDvATF2lCudeVFM8rJ1vg6XAAlActzP4aqRL9x0cz/WidHxJB+UVsz5vNE5QgOKhXY5KjPKEYSCtRbLnu1Um0s/JZ476AHrBE7y7/KeCckn1xqEbhC1r/jmQLvfTpzN5xlQ2ODqZtSLtOVlcL1zdzjrSig0TXrdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820776; c=relaxed/simple;
	bh=P/JEPZ8/bdZlLFI8atcD5Myhc+wd+nhuxTDkpIWpa0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bd3kMHJb9CKrdyrgNZ3Mp7T0cikdicqhqWTiovl4kWwJyasccbW93OIc7GPg7dYt9VVummRynCAf2h4iIGysb5IvYxfScPCu5GIC6f9/MEa6s1QyPA4kB0FtI5yuA1qbj6n7gn1IXE+Jr2XEBu0oSBsC6bPYREaJW7knPrVhstU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SB6GCJGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02210C433F1;
	Thu, 11 Apr 2024 07:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712820775;
	bh=P/JEPZ8/bdZlLFI8atcD5Myhc+wd+nhuxTDkpIWpa0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SB6GCJGQDLQjg2mTCjbfYv52aBNNJ+vX7IPsWVjsN9UtAv+0q6obdgg1LQ7QeR7vM
	 Q9/5CukrEvq10Jhp3F/r5uZxC1CPwuLygU0k/eC+Ni6JnraLdaRmbhmM8jciA2VQ8e
	 ucynii3reSfDdgTULemsTZzbm4IUm6g+6hpoCr1g=
Date: Thu, 11 Apr 2024 09:32:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.6.y 3/5] selftests: mptcp: use += operator to append
 strings
Message-ID: <2024041111-shirt-germicide-b316@gregkh>
References: <2024040520-unselect-antitrust-a41b@gregkh>
 <20240405153636.958019-10-matttbe@kernel.org>
 <2024040801-undaunted-boastful-5a01@gregkh>
 <26b5e6f5-6da2-44ff-adbd-c1c1eda3ccba@kernel.org>
 <2024040902-syrup-sneezing-62c4@gregkh>
 <af60b8c3-e3c4-48b2-a4c6-f2f430aa9c68@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af60b8c3-e3c4-48b2-a4c6-f2f430aa9c68@kernel.org>

On Tue, Apr 09, 2024 at 05:04:02PM +0200, Matthieu Baerts wrote:
> Hi Greg,
> 
> On 09/04/2024 14:16, Greg KH wrote:
> > On Mon, Apr 08, 2024 at 06:10:38PM +0200, Matthieu Baerts wrote:
> >> Hi Greg,
> >>
> >> On 08/04/2024 13:31, Greg KH wrote:
> >>> On Fri, Apr 05, 2024 at 05:36:40PM +0200, Matthieu Baerts (NGI0) wrote:
> >>>> From: Geliang Tang <tanggeliang@kylinos.cn>
> >>>>
> >>>> This patch uses addition assignment operator (+=) to append strings
> >>>> instead of duplicating the variable name in mptcp_connect.sh and
> >>>> mptcp_join.sh.
> >>>>
> >>>> This can make the statements shorter.
> >>>>
> >>>> Note: in mptcp_connect.sh, add a local variable extra in do_transfer to
> >>>> save the various extra warning logs, using += to append it. And add a
> >>>> new variable tc_info to save various tc info, also using += to append it.
> >>>> This can make the code more readable and prepare for the next commit.
> >>>>
> >>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> >>>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >>>> Link: https://lore.kernel.org/r/20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-8-4f42c347b653@kernel.org
> >>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >>>> (cherry picked from commit e7c42bf4d320affe37337aa83ae0347832b3f568)
> >>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >>>> ---
> >>>>  .../selftests/net/mptcp/mptcp_connect.sh      | 53 ++++++++++---------
> >>>>  .../testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++------
> >>>>  2 files changed, 43 insertions(+), 40 deletions(-)
> >>>
> >>> Odd, this one did not apply.
> >>
> >> Indeed, that's odd. Do you use a different merge strategy?
> > 
> > I do not use any merge strategy at all, I use 'patch' to apply patches
> > (well, that's what quilt does), so git is not involved here.
> 
> Ah OK, thank you for the explanation. I thought git was used to do the
> cherry-pick + generate the patch for quilt.

No, git is used only to export the patch from the tree if a git id is
used.  As you sent a patch here, I just used your patch for this.

> I'm still surprised quilt didn't accept these patches generated on top
> of the 6.6-y branch. (By "chance", did you not have conflicts because
> the patch 1/5 (commit 629b35a225b0 ("selftests: mptcp: display simult in
> extra_msg")) didn't get backported by accident? It is strange it is also
> missing in the v6.6.y branch.)

I do not remember if there were conflicts or not, sorry.

> > How about just resending this one patch after the next 6.6.y release
> > that comes out in a day or so.
> 
> No hurry, that can indeed wait for the next 6.6.y release.
> 
> Just to be sure we are aligned: I suggested backporting these 5 commits:
> 
> - 629b35a225b0 ("selftests: mptcp: display simult in extra_msg")

This one I've now queued up.

> - e3aae1098f10 ("selftests: mptcp: connect: fix shellcheck warnings")

Was already in the tree.

> - e7c42bf4d320 ("selftests: mptcp: use += operator to append strings")

Failed to apply

> - 8e2b8a9fa512 ("mptcp: don't overwrite sock_ops in mptcp_is_tcpsk()")

In the tree.

> - 7a1b3490f47e ("mptcp: don't account accept() of non-MPC client as
> fallback to TCP")

In the tree.

> But only these 3 got backported to 6.6.y:
> 
> - e3aae1098f10 ("selftests: mptcp: connect: fix shellcheck warnings")
> - 8e2b8a9fa512 ("mptcp: don't overwrite sock_ops in mptcp_is_tcpsk()")
> - 7a1b3490f47e ("mptcp: don't account accept() of non-MPC client as
> fallback to TCP")
> 
> The last commit ("mptcp: don't account accept() of non-MPC client as
> fallback to TCP") has a small problem in 6.6.y (only):
> 
> - In case of issue, a message will say that the subtest is OK and not
> OK, and the TAP report will report that everything is OK with this
> subtest => that's OK, nothing critical, that's the tests.
> - We can solve that in the next 6.6 version by manually backporting
> commit e7c42bf4d320 ("selftests: mptcp: use += operator to append
> strings") and its dependence: commit 629b35a225b0 ("selftests: mptcp:
> display simult in extra_msg").

Patches gladly accepted :)

thanks,

greg k-h

