Return-Path: <stable+bounces-165078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A5CB14F48
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 16:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2497D16FAD2
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 14:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1C652F66;
	Tue, 29 Jul 2025 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QoJKcJ/x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBD63597E
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799621; cv=none; b=FNZNt5slIc4jEH5iUSs6fTUjvh8TZLwRiYrYQiURzodkfjFVaQhDLXZVIfXE61bd7ScM+Tu+R4C52kY3Fsq4DQJVI49Po62ycKIjJLM5QgBJ1qhXbv2CVwIqjsX4/iTFtxnsMoFH9/+dk/PS6nDpJRPhy4VBl1lBSdOtRjsyWBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799621; c=relaxed/simple;
	bh=9UHzrNKYv1Pz4xHddHDnCcg02s8jUDCoWgpHGN/oeUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyUAz2rW3LN6waZMndC8Ig/wKdBdOuIsd6RY/Ppv5ZN+/3hKLNx+JzO+e/GQx08a0iX6Ndei2i8HLqs/q5jEOEHc4GdG0dWIPNnj3HDuzjWoyNQMYCmUcm2S6Sn1MYqdNLCYyLraDm7SSjlq9txsde2HbJj7BoTzoIk4HCKPgp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QoJKcJ/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1846EC4CEEF;
	Tue, 29 Jul 2025 14:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753799620;
	bh=9UHzrNKYv1Pz4xHddHDnCcg02s8jUDCoWgpHGN/oeUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QoJKcJ/xbAlGRNTceld4O2EdnqtCK+MLb6fLnMaqoLF5hPLb97x/ukur0Zm7ujrBS
	 5z0ig1RJYJlHhmHc2oO5X4xgEoOd02m3PLQVbHC05PO8uyeX9c4te/xa1TW4EomZP+
	 F2947jX2/V6fJphZa6xa7Z8dB44IINDScSo/0enU=
Date: Tue, 29 Jul 2025 16:33:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	chenridong <chenridong@huawei.com>, stable@vger.kernel.org,
	"stable-commits@vger.kernel.org Sasha Levin" <sashal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: Patch "Revert "cgroup_freezer: cgroup_freezing: Check if not
 frozen"" has been added to the 6.15-stable tree
Message-ID: <2025072950-tamale-rural-8332@gregkh>
References: <1bafc8a024da4a95b28c02430f3d0c9d@huawei.com>
 <3f80facc-8bef-4fc7-ac7e-59279906a707@huaweicloud.com>
 <2025072222-effective-jumble-c817@gregkh>
 <ebec24b9-e65e-4050-a960-d127b7215543@huaweicloud.com>
 <2025072253-gravity-shown-3a37@gregkh>
 <5c09fe1c-cb0c-46bf-ab6d-fda063a0e812@huaweicloud.com>
 <2025072344-arrogance-shame-7114@gregkh>
 <9da3269a-9e50-48e9-a1de-6311942f6ea1@huaweicloud.com>
 <2025072421-deviate-skintight-bbd5@gregkh>
 <89465e3f-7c07-4354-ba41-36d5a5139261@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89465e3f-7c07-4354-ba41-36d5a5139261@huaweicloud.com>

On Tue, Jul 29, 2025 at 09:22:10PM +0800, Chen Ridong wrote:
> 
> 
> On 2025/7/24 17:43, Greg KH wrote:
> > On Thu, Jul 24, 2025 at 05:38:52PM +0800, Chen Ridong wrote:
> >>
> >>
> >> On 2025/7/23 13:06, Greg KH wrote:
> >>> On Wed, Jul 23, 2025 at 09:01:43AM +0800, Chen Ridong wrote:
> >>>>
> >>>>
> >>>> On 2025/7/22 20:38, Greg KH wrote:
> >>>>> On Tue, Jul 22, 2025 at 08:25:49PM +0800, Chen Ridong wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 2025/7/22 20:18, Greg KH wrote:
> >>>>>>> On Tue, Jul 22, 2025 at 09:29:13AM +0800, Chen Ridong wrote:
> >>>>>>>>
> >>>>>>>>> This is a note to let you know that I've just added the patch titled
> >>>>>>>>>
> >>>>>>>>>     Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"
> >>>>>>>>>
> >>>>>>>>> to the 6.15-stable tree which can be found at:
> >>>>>>>>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >>>>>>>>>
> >>>>>>>>> The filename of the patch is:
> >>>>>>>>>      revert-cgroup_freezer-cgroup_freezing-check-if-not-f.patch
> >>>>>>>>> and it can be found in the queue-6.15 subdirectory.
> >>>>>>>>>
> >>>>>>>>> If you, or anyone else, feels it should not be added to the stable tree, please let <stable@vger.kernel.org> know about it.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> The patch ("sched,freezer: Remove unnecessary warning in __thaw_task") should also be merged to
> >>>>>>>> prevent triggering another warning in __thaw_task().
> >>>>>>>
> >>>>>>> What is the git commit id of that change in Linus's tree?
> >>>>>>>
> >>>>>>> thanks,
> >>>>>>>
> >>>>>>> greg k-h
> >>>>>>
> >>>>>> 9beb8c5e77dc10e3889ff5f967eeffba78617a88 ("sched,freezer: Remove unnecessary warning in __thaw_task")
> >>>>>
> >>>>> Thanks, but that didn't apply to 6.1.y or 6.6.y.  Shouldn't it also go
> >>>>> there as that's what this revert was applied back to.
> >>>>>
> >>>>> greg k-h
> >>>>
> >>>> Hi Greg,
> >>>>
> >>>> The commit 9beb8c5e77dc ("sched,freezer: Remove unnecessary warning...") should be merged together
> >>>> with 14a67b42cb6f ("Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"") to avoid the
> >>>> warning for 6.1.y or 6.6.y.
> >>>
> >>> Ok, but 9beb8c5e77dc does not apply properly there.  Can you please
> >>> provide a working backport?
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
> >>
> >> IIUC, we need to backport these two commits together:
> >> 1.commit 23ab79e8e469 ("freezer,sched: Do not restore saved_state of a thawed task")
> >> 2.commit 9beb8c5e77dc ("sched,freezer: Remove unnecessary warning...").
> >>
> >> After applying these prerequisites, the required change becomes minimal:
> >>
> >> diff --git a/kernel/freezer.c b/kernel/freezer.c
> >> index 4fad0e6fca64..288d1cce1fc4 100644
> >> --- a/kernel/freezer.c
> >> +++ b/kernel/freezer.c
> >> @@ -196,7 +196,7 @@ void __thaw_task(struct task_struct *p)
> >>         unsigned long flags, flags2;
> >>
> >>         spin_lock_irqsave(&freezer_lock, flags);
> >> -       if (WARN_ON_ONCE(freezing(p)))
> >> +       if (!frozen(p))
> >>                 goto unlock;
> >>
> >>         if (lock_task_sighand(p, &flags2)) {
> >>
> >> Would you like me to prepare and submit this patch for the stable branches (6.6.y and 6.1.y)?
> > 
> > Yes, please send me the missing patches as a series for each branch that
> > needs them.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Greg and maintainers,
> 
> I've sent the patch series for 6.6.y. Backporting commit 9beb8c5e77dc ("sched,freezer: Remove
> unnecessary warning...") requires 4 patches for 6.6.y, and the backport to 6.1.y would be even more
> complex.
> 
> As an alternative, I'm considering addressing the warning directly with the patch I mentioned
> previously. What are your thoughts on this approach?
> 
> The new patch:
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

I have no idea, sorry, please work with the developers/maintainers of
the original change and get their approval.  But normally, we do NOT
want one-off changes being made to older kernel trees unless it has to
be done, as that makes maintaining them much much much harder over time.

thanks,

greg k-h

