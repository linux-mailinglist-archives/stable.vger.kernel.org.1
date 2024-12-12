Return-Path: <stable+bounces-100841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 694D89EE088
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 08:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6E5188788F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 07:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A0620B7EA;
	Thu, 12 Dec 2024 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GhOyHITR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7F3188591
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733989627; cv=none; b=eBeRYYnmoGkNWxw+JcSwH57KuYRG+FR+AXLmyp6rlmlnvZKv8W2dOuk9S+N+dVLNur3Lhp9dbksjgMJ7KdV6euNjo2L7yUN1ySj9uWikNGIzf0eCplV7l1QfSBHCPUkQ5wRHWinaE1hroKUWJ82JiaZWj1cfT1hSy+sfbqWSn7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733989627; c=relaxed/simple;
	bh=DKyfKTrWzTrMsASAtE+tPUlc9uXaCWV84aVX09nFkpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDeaktBJV4BC8ZucWWD+Mj+j8T4dYLlcSpkE2poij2/+/4atUvtQ4jQeLjnMt+PzR6p8jk4UmjiBe/u1zlkRTutSwsHtyzJ57526S8JyT51E3NtLWvG2gNBh4M+vyUKsIVx96KIkDKg+1qqnISxV3VbbedxzV+7Vmu43nLn28rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GhOyHITR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F19C4CED1;
	Thu, 12 Dec 2024 07:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733989626;
	bh=DKyfKTrWzTrMsASAtE+tPUlc9uXaCWV84aVX09nFkpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GhOyHITRayLAmL5CWryVjSfc9ZSba2mVW6YTnXUweMJLlho8BNMEH3181oqmoCfgp
	 r4CDVylSWXLCEqkRSgyHatLvdBuPR1khex50T+5wvjFtj+0DETh169/Bn78tghqv0F
	 w5zwAWFT6FtpPBdfz5EDXtEtuw+3pHq5PN6KlPVs=
Date: Thu, 12 Dec 2024 08:47:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: guocai.he.cn@windriver.com, Sasha Levin <sashal@kernel.org>,
	mschmidt@redhat.com, selvin.xavier@broadcom.com, leon@kernel.org,
	xiangyu.chen@windriver.com,
	Vegard Nossum <vegard.nossum@oracle.com>, stable@vger.kernel.org
Subject: Re: [PATCH V2][5.15.y] bnxt_re: avoid shift undefined behavior in
 bnxt_qplib_alloc_init_hwq
Message-ID: <2024121213-scallop-backdrop-22d8@gregkh>
References: <20241212064846.1079097-1-guocai.he.cn@windriver.com>
 <2024121257-enticing-uncolored-fe71@gregkh>
 <2d9b921b-c7fa-4bb1-ad51-16c176888618@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d9b921b-c7fa-4bb1-ad51-16c176888618@oracle.com>

On Thu, Dec 12, 2024 at 12:40:19PM +0530, Harshit Mogalapalli wrote:
> Hi Greg,
> 
> On 12/12/24 12:24, Greg KH wrote:
> ...
> > > 
> > > Fixes: 0c4dcd602817 ("RDMA/bnxt_re: Refactor hardware queue memory allocation")
> > > Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> > > Link: https://lore.kernel.org/r/20240507103929.30003-1-mschmidt@redhat.com
> > > Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > Signed-off-by: Leon Romanovsky <leon@kernel.org>
> > > Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > I have not signed off on this backport, why did you add this here?  You
> > do know what this is saying right?
> > 
> 
> Note: I think Guocai cherry-picked 6.1.y commit: (probable reason for your
> SOB and Xiangyu Chen's SOB there)

Maybe, but how am I supposed to know that?

> stable-6.1      : v6.1.117  - 84d2f2915218 bnxt_re: avoid shift undefined
> behavior in bnxt_qplib_alloc_init_hwq
> 
> This clean cherry-picks to 5.15.y
> 
> Question: In cases like this where we benefit from cherry-picking a commit
> from another stable branch as opposed to upstream commit(if we used original
> upstream for cherry-picking, we would get conflicts and probably have to
> resolve in the same way as we did for 6.1.y], how do we differentiate that
> in commit message ? May be with a comment before SOB [ Harshit:
> Cherry-picked it from 6.1.y branch, it is a clean cherry-pick], as per
> Option 3 documented in [1], the first line (commit
> 78cfd17142ef70599d6409cbd709d94b3da58659 upstream) should still point to
> upstream commit right ?
> 
> [1] https://www.kernel.org/doc/html/v6.12/process/stable-kernel-rules.html

What would you want to see if you get a random backport sent to you to
do something with and the signed-off-by lines do NOT match with what is
upstream?

Be reasonable here people, realize that someone is on the other side of
these emails and I have to verify that they are actually what they claim
to be (hint, that's getting harder recently with the uptick in backports
that are not correct...)

Make it simple for us please.

thanks,

greg k-h

