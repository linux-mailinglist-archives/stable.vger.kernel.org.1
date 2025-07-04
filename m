Return-Path: <stable+bounces-160163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1476AAF8D17
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 11:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0172F761490
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 08:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FD1283FD6;
	Fri,  4 Jul 2025 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kgrZDhLX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D97262FDB
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619158; cv=none; b=JwV6PRF0HGzA+qTi25mCEHzXd04mRtcGNeC3yvpbsmSl3SXFazeu/WFVEvE4axzaTDdRuLF6fxrV73BkKdO6ibmlUNFHXgN3SkXVoQKOQI4YdYJyL69hmhLMTji+Co+YYvZpUQENgNPgvK0Mu+3eMdy0MWo1xXXfS8ww+bFV7b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619158; c=relaxed/simple;
	bh=FEQ76hLztLW70pSJQvzQygOGzLIkUvmkg6GUcviKXpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqYpMI+D2M3rUSgyr9ZgWnIi0Tq/zQkEACUYvOXnnMJuqEm2YcwQmsUF2FtpH6/1BFNT/HLEhJ/ga1YEo1ceok1KqQA4EFDr1K04dq5V6iaUXIgVOaZ3D9bxPnezfH7Ojui/8vf/4sUQnErkU9E9h4m3ftJXeokVH0whYp2NLCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kgrZDhLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3DBC4CEE3;
	Fri,  4 Jul 2025 08:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751619157;
	bh=FEQ76hLztLW70pSJQvzQygOGzLIkUvmkg6GUcviKXpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kgrZDhLXJtPI/IUFmA5KySd3RI2AhIYpLhh6ukz8gb8I3GJjWQmG+tArCHyiC2X62
	 Elzt1hrWKcGQtX5Nkn7LxQuZe9rfyGpmYDg0VWv9MWmqb7AvWJ3XFZvTNXL/vBtHCX
	 DC2TCdNr7pVM+j7tEqZKj49wA9baFuW8XdyX0Pxs=
Date: Fri, 4 Jul 2025 10:52:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] xfs: fix super block buf log item UAF during
 force shutdown
Message-ID: <2025070412-underline-email-3f4d@gregkh>
References: <20250624134840.47853-1-pranav.tyagi03@gmail.com>
 <20250624191559-d8d1fb6d1407e834@stable.kernel.org>
 <CAH4c4jLg+X-2AoC6WgHVkS7gR1Vr2zmEy-Sv-oey8sg0DU6ZeQ@mail.gmail.com>
 <2025070449-lubricant-bullish-4653@gregkh>
 <CAH4c4jLL8naS6R=8gRaVYK-bJ-oi6ioT1qmvUJy=QVzL0PBi+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH4c4jLL8naS6R=8gRaVYK-bJ-oi6ioT1qmvUJy=QVzL0PBi+Q@mail.gmail.com>

On Fri, Jul 04, 2025 at 02:15:46PM +0530, Pranav Tyagi wrote:
> On Fri, Jul 4, 2025 at 1:58 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jul 04, 2025 at 01:16:01PM +0530, Pranav Tyagi wrote:
> > > On Wed, Jun 25, 2025 at 7:39 PM Sasha Levin <sashal@kernel.org> wrote:
> > > >
> > > > [ Sasha's backport helper bot ]
> > > >
> > > > Hi,
> > > >
> > > > ✅ All tests passed successfully. No issues detected.
> > > > No action required from the submitter.
> > > >
> > > > The upstream commit SHA1 provided is correct: 575689fc0ffa6c4bb4e72fd18e31a6525a6124e0
> > > >
> > > > WARNING: Author mismatch between patch and upstream commit:
> > > > Backport author: Pranav Tyagi<pranav.tyagi03@gmail.com>
> > > > Commit author: Guo Xuenan<guoxuenan@huawei.com>
> > > >
> > > > Status in newer kernel trees:
> > > > 6.15.y | Present (exact SHA1)
> > > > 6.12.y | Present (exact SHA1)
> > > > 6.6.y | Present (exact SHA1)
> > > > 6.1.y | Present (different SHA1: 0d889ae85fcf)
> > > >
> > > > Note: The patch differs from the upstream commit:
> > > > ---
> > > > 1:  575689fc0ffa6 ! 1:  9876b048d8f68 xfs: fix super block buf log item UAF during force shutdown
> > > >     @@ Metadata
> > > >       ## Commit message ##
> > > >          xfs: fix super block buf log item UAF during force shutdown
> > > >
> > > >     +    [ Upstream commit 575689fc0ffa6c4bb4e72fd18e31a6525a6124e0 ]
> > > >     +
> > > >          xfs log io error will trigger xlog shut down, and end_io worker call
> > > >          xlog_state_shutdown_callbacks to unpin and release the buf log item.
> > > >          The race condition is that when there are some thread doing transaction
> > > >     @@ Commit message
> > > >          ==================================================================
> > > >          Disabling lock debugging due to kernel taint
> > > >
> > > >     +    [ Backport to 5.15: context cleanly applied with no semantic changes.
> > > >     +    Build-tested. ]
> > > >     +
> > > >          Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> > > >          Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > >          Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > >     +    Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> > > >
> > > >       ## fs/xfs/xfs_buf_item.c ##
> > > >      @@ fs/xfs/xfs_buf_item.c: xfs_buf_item_relse(
> > > > ---
> > > >
> > > > Results of testing on various branches:
> > > >
> > > > | Branch                    | Patch Apply | Build Test |
> > > > |---------------------------|-------------|------------|
> > > > | stable/linux-5.15.y       |  Success    |  Success   |
> > >
> > > Hi,
> > >
> > > Just following up on this 5.15.y backport.
> > > Please let me know if anything else is needed from my side.
> >
> > xfs patches need to go through the xfs maintainers for their approval.
> > "build tested" just doesn't cut it at all, you MUST actually test this
> > at runtime.  Otherwise, why would you even want this patch applied if
> > you don't have xfs systems that you care about?
> >
> > thanks,
> >
> > greg k-h
> 
> Hi Greg,
> 
> Apologies for the oversight. I had assumed that a build test would
> suffice for a backport since the patch is already merged upstream. I now
> understand the importance of runtime testing, even for backports. I’ll
> test it on the XFS setup and resend the patch.

Why do you want/need this backported if it wasn't even tested?  Why do
the backport at all?

confused,

greg k-h

