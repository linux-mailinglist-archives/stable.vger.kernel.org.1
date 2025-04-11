Return-Path: <stable+bounces-132273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A00E8A8611B
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 16:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBD18C137F
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898FE1F7575;
	Fri, 11 Apr 2025 14:56:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAD4537FF;
	Fri, 11 Apr 2025 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744383400; cv=none; b=TlLVzmee3Xywm9aZ3aZl5V6Pmq0WyMOYHcDuMR+qnEch67P6Yzo4/vaSYezwyGD5niwCCvtapMCJ4U2JhLI25KKpsxlENAiogzeeWyjZiiuJIWzO1c47H/UFLcKRLbWe45eZs9dhMHU6AOuYfiftNRtPcIJzzZ8uSVblSsTmUdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744383400; c=relaxed/simple;
	bh=zWdF7QoaOLIE+jmvSXVqWmHLvhor+vabMK1HXjfyclg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=epddOafcF+PGTBkOfeG7jKEGC0THUiApJf9Is6C76nHW17s015/+PMdHxpHU/QJfmaJzl+PNmdnpPlQQxVAVQMr6WgKImO97aIn/qXcnItlvpoaagE0AuZz5ilVRz1bqEfZ2sinRrv87MmmrdEadIPwxGxPlGpZT0xGTVsT77Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:8180:83cc:5a47:caff:fe78:8708] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1u3FjC-000000005D4-2uHd;
	Fri, 11 Apr 2025 10:51:34 -0400
Date: Fri, 11 Apr 2025 10:51:34 -0400
From: Rik van Riel <riel@surriel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Pat Cody <pat@patcody.io>, mingo@redhat.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, patcody@meta.com, kernel-team@meta.com,
 stable@vger.kernel.org, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] sched/fair: Add null pointer check to
 pick_next_entity()
Message-ID: <20250411105134.1f316982@fangorn>
In-Reply-To: <20250409152703.GL9833@noisy.programming.kicks-ass.net>
References: <20250320205310.779888-1-pat@patcody.io>
	<20250324115613.GD14944@noisy.programming.kicks-ass.net>
	<9d38c61098b426777c1a748cf1baf8e57c41c334.camel@surriel.com>
	<20250402180734.GX5880@noisy.programming.kicks-ass.net>
	<b40f830845f1f97aa4b686c5c1333ff1bf5d59b3.camel@surriel.com>
	<20250409152703.GL9833@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com

On Wed, 9 Apr 2025 17:27:03 +0200
Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Apr 09, 2025 at 10:29:43AM -0400, Rik van Riel wrote:
> > Our trouble workload still makes the scheduler crash
> > with this patch.
> > 
> > I'll go put the debugging patch on our kernel.
> > 
> > Should I try to get debugging data with this patch
> > part of the mix, or with the debugging patch just
> > on top of what's in 6.13 already?  
> 
> Whatever is more convenient I suppose.
> 
> If you can dump the full tree that would be useful. Typically the
> se::{vruntime,weight} and cfs_rq::{zero_vruntime,avg_vruntime,avg_load}
> such that we can do full manual validation of the numbers.

Here is a dump of the scheduler tree of the crashing CPU.

Unfortunately the CPU crashed in pick_next_entity, and not in your
debugging code. I'll add two more calls to avg_vruntime_validate(),
one from avg_vruntime_update(), and one rfom __update_min_vruntime()
when we skip the call to avg_vruntime_update(). The line numbers in
the backtrace could be a clue.

I have edited the cgroup names to make things more readable, but everything
else is untouched.

One thing that stands out to me is how the vruntime of each of the
entities on the CPU's cfs_rq are really large negative numbers.

vruntime = 18429030910682621789 equals 0xffc111f8d9ee675d

I do not know how those se->vruntime numbers got to that point,
but they are a suggestive cause of the overflow.

I'll go comb through the se->vruntime updating code to see how those
large numbers could end up as the vruntime for these sched entities.


nr_running = 3
min_vruntime = 107772371139014
avg_vruntime = -1277161882867784752
avg_load = 786
tasks_timeline = [
  {
    cgroup /A
    weight = 10230 => 9
    rq = {
      nr_running = 0
      min_vruntime = 458975898004
      avg_vruntime = 0
      avg_load = 0
      tasks_timeline = [
      ]
    }
  },
  {
    cgroup /B
    vruntime = 18445226958208703357
    weight = 319394 => 311
    rq = {
      nr_running = 2
      min_vruntime = 27468255210769
      avg_vruntime = 0
      avg_load = 93
      tasks_timeline = [
        {
          cgroup /B/a
          vruntime = 27468255210769
          weight = 51569 => 50
          rq = {
            nr_running = 1
            min_vruntime = 820449693961
            avg_vruntime = 0
            avg_load = 15
            tasks_timeline = [
              {
                task = 3653382 (fc0)
                vruntime = 820449693961
                weight = 15360 => 15
              },
            ]
          }
        },
        {
          cgroup /B/b
          vruntime = 27468255210769
          weight = 44057 => 43
          rq = {
            nr_running = 1
            min_vruntime = 563178567930
            avg_vruntime = 0
            avg_load = 15
            tasks_timeline = [
              {
                task = 3706454 (fc0)
                vruntime = 563178567930
                weight = 15360 => 15
              },
            ]
          }
        },
      ]
    }
  },
  {
    cgroup /C
    vruntime = 18445539757376619550
    weight = 477855 => 466
    rq = {
      nr_running = 0
      min_vruntime = 17163581720739
      avg_vruntime = 0
      avg_load = 0
      tasks_timeline = [
      ]
    }
  },
]


