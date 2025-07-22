Return-Path: <stable+bounces-163707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8CBB0D9D3
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900F016F356
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 12:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87A92E1C61;
	Tue, 22 Jul 2025 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sUH/DDdS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AFCD53C
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187899; cv=none; b=pnTzEWJIOgsDBAvX6nSgnR7T3fUaPKG3cWFcEjtOdLqAJimjAMQClwXPxijFkfP1qzhd1Rp+JUETq5jrYBBr6WGRFxYKriiMvx+imGVzma4bSGCl7GWlaZgsY5g9mXh/J5HY/Q+wwtBPCG8ftYWD0dJy28gX1QQ/xkmlRKSePaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187899; c=relaxed/simple;
	bh=aGXPYNJb0C5r/ROmgFR4xOMg5Xm7MSSSP5q6x2IOq+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rg4Zt46L+rCCaW/2L3QJUSA1b9gBm+JIu3WtTAtjxL84jkiSYe3+hg9IQ9NxJ3jan4f+4TLz79Rw+pUyGkO/izZjJCqdlo4JzL3Ugpox7wiRJPYylZsmxhxGK4He2MhB03zVoTiq4vyjy7K0cFKqW5eASf5kvTWOqwE0nMQ7ML4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sUH/DDdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94075C4CEEB;
	Tue, 22 Jul 2025 12:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753187899;
	bh=aGXPYNJb0C5r/ROmgFR4xOMg5Xm7MSSSP5q6x2IOq+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUH/DDdSbAjclH4++TRxZcErW1KYDYxaOTscVtJbQn59IQmc15Zqmx9JsGYlTs+t7
	 6YjcV+JooPA4RCKV8I1a68bdiFIxdmFmI4RFd0/mpIMuNSza1nCkXaMKi32O6wyOhx
	 2JCcIgUHXe/PzXziDprWNFSSjGb+c98t++5eROf4=
Date: Tue, 22 Jul 2025 14:38:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: chenridong <chenridong@huawei.com>, stable@vger.kernel.org,
	"stable-commits@vger.kernel.org Sasha Levin" <sashal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: Patch "Revert "cgroup_freezer: cgroup_freezing: Check if not
 frozen"" has been added to the 6.15-stable tree
Message-ID: <2025072253-gravity-shown-3a37@gregkh>
References: <20250721125251.814862-1-sashal@kernel.org>
 <1bafc8a024da4a95b28c02430f3d0c9d@huawei.com>
 <3f80facc-8bef-4fc7-ac7e-59279906a707@huaweicloud.com>
 <2025072222-effective-jumble-c817@gregkh>
 <ebec24b9-e65e-4050-a960-d127b7215543@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebec24b9-e65e-4050-a960-d127b7215543@huaweicloud.com>

On Tue, Jul 22, 2025 at 08:25:49PM +0800, Chen Ridong wrote:
> 
> 
> On 2025/7/22 20:18, Greg KH wrote:
> > On Tue, Jul 22, 2025 at 09:29:13AM +0800, Chen Ridong wrote:
> >>
> >>> This is a note to let you know that I've just added the patch titled
> >>>
> >>>     Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"
> >>>
> >>> to the 6.15-stable tree which can be found at:
> >>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >>>
> >>> The filename of the patch is:
> >>>      revert-cgroup_freezer-cgroup_freezing-check-if-not-f.patch
> >>> and it can be found in the queue-6.15 subdirectory.
> >>>
> >>> If you, or anyone else, feels it should not be added to the stable tree, please let <stable@vger.kernel.org> know about it.
> >>>
> >>
> >> The patch ("sched,freezer: Remove unnecessary warning in __thaw_task") should also be merged to
> >> prevent triggering another warning in __thaw_task().
> > 
> > What is the git commit id of that change in Linus's tree?
> > 
> > thanks,
> > 
> > greg k-h
> 
> 9beb8c5e77dc10e3889ff5f967eeffba78617a88 ("sched,freezer: Remove unnecessary warning in __thaw_task")

Thanks, but that didn't apply to 6.1.y or 6.6.y.  Shouldn't it also go
there as that's what this revert was applied back to.

greg k-h

