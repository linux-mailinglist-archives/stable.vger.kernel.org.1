Return-Path: <stable+bounces-164387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A1EB0E9F0
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 07:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA325170AA0
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 05:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A481DDC2B;
	Wed, 23 Jul 2025 05:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x1f3PHxY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1015442A8C
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753247171; cv=none; b=rgNckJLcZUlroZlL5zugjMHCJdzsfTvGXYwGHBroFMYNk1XTJ0yVJTeXk60ZYfcL41Swl1KmHOdADUTl+BB5enZE9IIh/L60OTQntSonv5gZtsbIPEpyu+w6I2efm289DMGONG4hW84EsL70mhzdbTEWS7/LZn9H3DH6U7fzeag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753247171; c=relaxed/simple;
	bh=QzjL6rU0NBErZshVWp0JETEvqzY99OmTykSakXQA3yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvSsLVdqsTt647qRSZLQYKkzCPWNIq52g6V3vz6U/+ldSYn1UMH5LezcYg3Cztae8fkviJYU8Z3MFK3ZbMfcyCl8/0cNm3QZqxsbCq1LlRsTsw31qDVr9mxZsQcL2j72iHUlxqwhS4c9RmwypzV4eRPyC1585NxIdGddguLiVck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x1f3PHxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF6CC4CEE7;
	Wed, 23 Jul 2025 05:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753247170;
	bh=QzjL6rU0NBErZshVWp0JETEvqzY99OmTykSakXQA3yE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x1f3PHxYDDuSVXYWaDmnjlzFgjwzbkC2Dw1k3cCwXkPzBpYuDw04r2PYoYFZ2zMbo
	 0Dp1B++WwBdi+/6AUPjw7uQEvMeFenrJ6r0zrG5X6ulbauCktLNAfYzkO0xGgNzw9n
	 Q3GcMbomtaQinmz6zsdea5ONsK7tjcmVRUnVm2go=
Date: Wed, 23 Jul 2025 07:06:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: chenridong <chenridong@huawei.com>, stable@vger.kernel.org,
	"stable-commits@vger.kernel.org Sasha Levin" <sashal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: Patch "Revert "cgroup_freezer: cgroup_freezing: Check if not
 frozen"" has been added to the 6.15-stable tree
Message-ID: <2025072344-arrogance-shame-7114@gregkh>
References: <20250721125251.814862-1-sashal@kernel.org>
 <1bafc8a024da4a95b28c02430f3d0c9d@huawei.com>
 <3f80facc-8bef-4fc7-ac7e-59279906a707@huaweicloud.com>
 <2025072222-effective-jumble-c817@gregkh>
 <ebec24b9-e65e-4050-a960-d127b7215543@huaweicloud.com>
 <2025072253-gravity-shown-3a37@gregkh>
 <5c09fe1c-cb0c-46bf-ab6d-fda063a0e812@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c09fe1c-cb0c-46bf-ab6d-fda063a0e812@huaweicloud.com>

On Wed, Jul 23, 2025 at 09:01:43AM +0800, Chen Ridong wrote:
> 
> 
> On 2025/7/22 20:38, Greg KH wrote:
> > On Tue, Jul 22, 2025 at 08:25:49PM +0800, Chen Ridong wrote:
> >>
> >>
> >> On 2025/7/22 20:18, Greg KH wrote:
> >>> On Tue, Jul 22, 2025 at 09:29:13AM +0800, Chen Ridong wrote:
> >>>>
> >>>>> This is a note to let you know that I've just added the patch titled
> >>>>>
> >>>>>     Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"
> >>>>>
> >>>>> to the 6.15-stable tree which can be found at:
> >>>>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >>>>>
> >>>>> The filename of the patch is:
> >>>>>      revert-cgroup_freezer-cgroup_freezing-check-if-not-f.patch
> >>>>> and it can be found in the queue-6.15 subdirectory.
> >>>>>
> >>>>> If you, or anyone else, feels it should not be added to the stable tree, please let <stable@vger.kernel.org> know about it.
> >>>>>
> >>>>
> >>>> The patch ("sched,freezer: Remove unnecessary warning in __thaw_task") should also be merged to
> >>>> prevent triggering another warning in __thaw_task().
> >>>
> >>> What is the git commit id of that change in Linus's tree?
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
> >>
> >> 9beb8c5e77dc10e3889ff5f967eeffba78617a88 ("sched,freezer: Remove unnecessary warning in __thaw_task")
> > 
> > Thanks, but that didn't apply to 6.1.y or 6.6.y.  Shouldn't it also go
> > there as that's what this revert was applied back to.
> > 
> > greg k-h
> 
> Hi Greg,
> 
> The commit 9beb8c5e77dc ("sched,freezer: Remove unnecessary warning...") should be merged together
> with 14a67b42cb6f ("Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"") to avoid the
> warning for 6.1.y or 6.6.y.

Ok, but 9beb8c5e77dc does not apply properly there.  Can you please
provide a working backport?

thanks,

greg k-h

