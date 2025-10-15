Return-Path: <stable+bounces-185754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAE4BDCAA7
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 08:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D323D3E2F5E
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 06:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5528304976;
	Wed, 15 Oct 2025 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nHiahtR2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7745D13C8EA;
	Wed, 15 Oct 2025 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760508900; cv=none; b=ue1hSehKt/eZHn2ubGHiOBCuAxsNUo42Tm2tb5XDheiydGO60En6/6cbM7WHKlbt/RBbdBsRlZoTgGh45cKP7EGP+GTRDdKhtyJGIXv6h6nPsVrXOetaMdu+Gbb1L3uJpU+7uXakHU5EW6rA7+h43+AilhyHlENedxOzPskLNEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760508900; c=relaxed/simple;
	bh=CcGNiFI+/JZ1qzeRMX10qG7kDVqNOmBzKfGBhLH14yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ey5yEwJVBHgUBeFjvSsClt5a00prijFLKukXhhgZDbb08JMhHePcUb2+dgNLn5QVZ50Iqw2ylRDhUa8zbGXf08JMnvUGwGcO5cQBAJyhMGZ6UvB6k6CZp7JSZnb1IyywX3NFBPRjQpUkFQmvkHjuV5ceUdGIg6uAIGIfK3iTYb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nHiahtR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7296DC4CEFE;
	Wed, 15 Oct 2025 06:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760508900;
	bh=CcGNiFI+/JZ1qzeRMX10qG7kDVqNOmBzKfGBhLH14yU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nHiahtR2KFphmEcqVGBr6RURDk+CN6hcYKeVJvhRGSkf3Mea9WWYSk2CPBFKoPmJ5
	 X6M6izPxyAVIeS3UNw7T7KNQdef2qw/M6+70e5HKrKPE9dcJ/54ZO4mLoIf4wTnlLu
	 +wscYnW4kzScxJlaOD59NbU3LSuJFqU16nhHf+Bc=
Date: Wed, 15 Oct 2025 08:14:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Matt Fleming <matt@readmodwrite.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>,
	Oleg Nesterov <oleg@redhat.com>, John Stultz <jstultz@google.com>,
	Chris Arges <carges@cloudflare.com>
Subject: Re: [PATCH v6.12] sched/fair: Block delayed tasks on throttled
 hierarchy during dequeue
Message-ID: <2025101516-skeletal-munchkin-0e85@gregkh>
References: <CAENh_SRj9pMyMLZAM0WVr3tuD5ogMQySzkPoiHu4SRoGFkmnZw@mail.gmail.com>
 <20251015060359.34722-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015060359.34722-1-kprateek.nayak@amd.com>

On Wed, Oct 15, 2025 at 06:03:59AM +0000, K Prateek Nayak wrote:
> Dequeuing a fair task on a throttled hierarchy returns early on
> encountering a throttled cfs_rq since the throttle path has already
> dequeued the hierarchy above and has adjusted the h_nr_* accounting till
> the root cfs_rq.
> 
> dequeue_entities() crucially misses calling __block_task() for delayed
> tasks being dequeued on the throttled hierarchies, but this was mostly
> harmless until commit b7ca5743a260 ("sched/core: Tweak
> wait_task_inactive() to force dequeue sched_delayed tasks") since all
> existing cases would re-enqueue the task if task_on_rq_queued() returned
> true and the task would eventually be blocked at pick after the
> hierarchy was unthrottled.
> 
> wait_task_inactive() is special as it expects the delayed task on
> throttled hierarchy to reach the blocked state on dequeue but since
> __block_task() is never called, task_on_rq_queued() continues to return
> true. Furthermore, since the task is now off the hierarchy, the pick
> never reaches it to fully block the task even after unthrottle leading
> to wait_task_inactive() looping endlessly.
> 
> Remedy this by calling __block_task() if a delayed task is being
> dequeued on a throttled hierarchy.
> 
> This fix is only required for stabled kernels implementing delay dequeue
> (>= v6.12) before v6.18 since upstream commit e1fad12dcb66 ("sched/fair:
> Switch to task based throttle model") indirectly fixes this by removing
> the early return conditions in dequeue_entities() as part of the per-task
> throttle feature.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Matt Fleming <matt@readmodwrite.com>
> Closes: https://lore.kernel.org/all/20250925133310.1843863-1-matt@readmodwrite.com/
> Fixes: b7ca5743a260 ("sched/core: Tweak wait_task_inactive() to force dequeue sched_delayed tasks")
> Tested-by: Matt Fleming <mfleming@cloudflare.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> Greg, Sasha,
> 
> This fix cleanly applies on top of v6.16.y and v6.17.y stable kernels
> too when cherry-picked from v6.12.y branch (or with 'git am -3'). Let me
> know if you would like me to send a seperate patch for each.
> 
> As mentioned above, the upstream fixes this as a part of larger feature
> and we would only like these bits backported. If there are any future
> conflicts in this area during backporting, I would be more than happy to
> help out resolve them.

Why not just backport all of the mainline changes instead?  As I say a
lot, whenever we do these "one off" changes, it's almost always wrong
and causes problems over the years going forward as other changes around
the same area can not be backported either.

So please, try to just backport the original commits.

thanks,

greg k-h

