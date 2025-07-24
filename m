Return-Path: <stable+bounces-164583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ECFB106D8
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 11:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB52E3A5BD0
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 09:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557CB23C397;
	Thu, 24 Jul 2025 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dyOWayWM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153D3237186
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350224; cv=none; b=PK9xrYkCCB1XH6BVgXA/70ijeDYAhH4FRRWvHb43eA9RigrdwMf5T62XugGW1cyfhRyRaJxEOMGryA9BykSG7iwLBYBZLFJJItVoFY8ho6aXrIn8PLeLIwExEqjoOvnz520mJCnqgB6YXgoelkAX7WkJZdjLF9kyHNzs9amTXYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350224; c=relaxed/simple;
	bh=o2CmPJDYbbhkmplAxuuOkvI1b+CPp8/9oNO1vqwhH8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IL/D0V8YCHLFkVp5xsnvNM9jV16aJWev1rTWnrNFV8SaF76Pq7uqmAwLELVb0awBei0e6ptVH+40/t25NpqWMmWEvqs7YQN7bQJUGA/gfuWLe2RWUA3qUCCL1UdMorOHZRbdcNe4fCYoP/wgaC0EAPWmWglt0yGXSwfpA4ea1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dyOWayWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06C3C4CEED;
	Thu, 24 Jul 2025 09:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753350221;
	bh=o2CmPJDYbbhkmplAxuuOkvI1b+CPp8/9oNO1vqwhH8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dyOWayWMeL4FGgTGvhfApCQBZ+P+b97Auu4+xcATG0FOfoCNOZccG/DROGvShWTWJ
	 HLAee2c/+JsSxMMmD8qrQZYH76XHTSOEQPTMq/xUVoM2eDZ5qt/+NbatxuWdpWwUXq
	 IuIYIRKjQiUYtVrvV9OwPavUNmfUr+6GGiz8fbXI=
Date: Thu, 24 Jul 2025 11:43:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	chenridong <chenridong@huawei.com>, stable@vger.kernel.org,
	"stable-commits@vger.kernel.org Sasha Levin" <sashal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: Patch "Revert "cgroup_freezer: cgroup_freezing: Check if not
 frozen"" has been added to the 6.15-stable tree
Message-ID: <2025072421-deviate-skintight-bbd5@gregkh>
References: <20250721125251.814862-1-sashal@kernel.org>
 <1bafc8a024da4a95b28c02430f3d0c9d@huawei.com>
 <3f80facc-8bef-4fc7-ac7e-59279906a707@huaweicloud.com>
 <2025072222-effective-jumble-c817@gregkh>
 <ebec24b9-e65e-4050-a960-d127b7215543@huaweicloud.com>
 <2025072253-gravity-shown-3a37@gregkh>
 <5c09fe1c-cb0c-46bf-ab6d-fda063a0e812@huaweicloud.com>
 <2025072344-arrogance-shame-7114@gregkh>
 <9da3269a-9e50-48e9-a1de-6311942f6ea1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9da3269a-9e50-48e9-a1de-6311942f6ea1@huaweicloud.com>

On Thu, Jul 24, 2025 at 05:38:52PM +0800, Chen Ridong wrote:
> 
> 
> On 2025/7/23 13:06, Greg KH wrote:
> > On Wed, Jul 23, 2025 at 09:01:43AM +0800, Chen Ridong wrote:
> >>
> >>
> >> On 2025/7/22 20:38, Greg KH wrote:
> >>> On Tue, Jul 22, 2025 at 08:25:49PM +0800, Chen Ridong wrote:
> >>>>
> >>>>
> >>>> On 2025/7/22 20:18, Greg KH wrote:
> >>>>> On Tue, Jul 22, 2025 at 09:29:13AM +0800, Chen Ridong wrote:
> >>>>>>
> >>>>>>> This is a note to let you know that I've just added the patch titled
> >>>>>>>
> >>>>>>>     Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"
> >>>>>>>
> >>>>>>> to the 6.15-stable tree which can be found at:
> >>>>>>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >>>>>>>
> >>>>>>> The filename of the patch is:
> >>>>>>>      revert-cgroup_freezer-cgroup_freezing-check-if-not-f.patch
> >>>>>>> and it can be found in the queue-6.15 subdirectory.
> >>>>>>>
> >>>>>>> If you, or anyone else, feels it should not be added to the stable tree, please let <stable@vger.kernel.org> know about it.
> >>>>>>>
> >>>>>>
> >>>>>> The patch ("sched,freezer: Remove unnecessary warning in __thaw_task") should also be merged to
> >>>>>> prevent triggering another warning in __thaw_task().
> >>>>>
> >>>>> What is the git commit id of that change in Linus's tree?
> >>>>>
> >>>>> thanks,
> >>>>>
> >>>>> greg k-h
> >>>>
> >>>> 9beb8c5e77dc10e3889ff5f967eeffba78617a88 ("sched,freezer: Remove unnecessary warning in __thaw_task")
> >>>
> >>> Thanks, but that didn't apply to 6.1.y or 6.6.y.  Shouldn't it also go
> >>> there as that's what this revert was applied back to.
> >>>
> >>> greg k-h
> >>
> >> Hi Greg,
> >>
> >> The commit 9beb8c5e77dc ("sched,freezer: Remove unnecessary warning...") should be merged together
> >> with 14a67b42cb6f ("Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"") to avoid the
> >> warning for 6.1.y or 6.6.y.
> > 
> > Ok, but 9beb8c5e77dc does not apply properly there.  Can you please
> > provide a working backport?
> > 
> > thanks,
> > 
> > greg k-h
> 
> IIUC, we need to backport these two commits together:
> 1.commit 23ab79e8e469 ("freezer,sched: Do not restore saved_state of a thawed task")
> 2.commit 9beb8c5e77dc ("sched,freezer: Remove unnecessary warning...").
> 
> After applying these prerequisites, the required change becomes minimal:
> 
> diff --git a/kernel/freezer.c b/kernel/freezer.c
> index 4fad0e6fca64..288d1cce1fc4 100644
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -196,7 +196,7 @@ void __thaw_task(struct task_struct *p)
>         unsigned long flags, flags2;
> 
>         spin_lock_irqsave(&freezer_lock, flags);
> -       if (WARN_ON_ONCE(freezing(p)))
> +       if (!frozen(p))
>                 goto unlock;
> 
>         if (lock_task_sighand(p, &flags2)) {
> 
> Would you like me to prepare and submit this patch for the stable branches (6.6.y and 6.1.y)?

Yes, please send me the missing patches as a series for each branch that
needs them.

thanks,

greg k-h

