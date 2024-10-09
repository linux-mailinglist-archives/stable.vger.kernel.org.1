Return-Path: <stable+bounces-83120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC92995C79
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 02:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9B91C21393
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 00:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522427462;
	Wed,  9 Oct 2024 00:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOSxj2sd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78775684;
	Wed,  9 Oct 2024 00:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435298; cv=none; b=lVtHMMyplqmhrAC2FgA6j8kaKTO6KKRV/8rWOL++xTz4TqZBKCayi5HuLmTz5IeNSNjUNG6mx0NGtmaNsS8bnmEqNH00Vx4H5w1WPvIg78S4Kk/gD6QMbUFgV7SU1+bmwEItGqwoudxAQshGMMJw7WMK4K5uKfdk9aU5TzalbN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435298; c=relaxed/simple;
	bh=2wt8OZmZXZiHffk+E3soDo1i7Jyy9ZL3xsfV3wdF90c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lFwgIb3LnzhK5f1cD6kAEkVhMuVvXbKoPpy80xqpzZj7Jpmpqpx/cAR93vofmt0y4N87ZiqLxn2CxPfrNmFudWLSif6M/7I/RJQiqqk3qzhyULnFzLzruWA+XoPj3BAKINwRhTlDPR8NP/el01i+SMvM5aCC+GxIyfJD9LghJHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOSxj2sd; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728435296; x=1759971296;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=2wt8OZmZXZiHffk+E3soDo1i7Jyy9ZL3xsfV3wdF90c=;
  b=FOSxj2sdVA/6zoKCJ5/zxefrPfNNySirIy9bn3f3QbYZ5jnKJRWREMcR
   KsPrSYEnO7wR0lpv8z/5ZB+BMp6l2bnhRuenQjaZdDPlU9OZMyY35754C
   i5moVlpzWmAhm2zE9u2BB3JQBQHTafEEBeKJ+eWlhEZb7IcEn9nDUwz8b
   IQ72tbKGz1jGW2tqs6nJ2oBXTB1beOvV/f12vUMzYK5nMANimv14QcUgA
   YxZls5KIXZNOQ3esTzj4giztBudS9efBrNCzIwQ8N2/R+4wLYxz04myfb
   L42tC0TeGB8xODnVe+pq3ZSFKfDXbWtBz+Uy4p1HWIzXz4SuqOP7Fmslk
   Q==;
X-CSE-ConnectionGUID: fcKm6xFYSpCBkDVgKOZkMw==
X-CSE-MsgGUID: GP1o26vFTTakHfukCh6f5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27182005"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="27182005"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 17:54:55 -0700
X-CSE-ConnectionGUID: RIUbv4x9RO6dI75ZOq+IpA==
X-CSE-MsgGUID: GtXaVDiGTdG+m+d1KQ1olg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106816873"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 17:54:50 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <kasong@tencent.com>
Cc: akpm@linux-foundation.org,  chrisl@kernel.org,  david@redhat.com,
  hannes@cmpxchg.org,  hughd@google.com,  kaleshsingh@google.com,
  kasong@tencent.com,  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  liyangouwen1@oppo.com,  mhocko@suse.com,  minchan@kernel.org,
  sj@kernel.org,  stable@vger.kernel.org,  surenb@google.com,
  v-songbaohua@oppo.com,  willy@infradead.org,  yosryahmed@google.com,
  yuzhao@google.com, Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] mm: avoid unconditional one-tick sleep when
 swapcache_prepare fails
In-Reply-To: <20241008130807.40833-1-21cnbao@gmail.com> (Barry Song's message
	of "Tue, 8 Oct 2024 21:08:07 +0800")
References: <87ikuani1f.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20241008130807.40833-1-21cnbao@gmail.com>
Date: Wed, 09 Oct 2024 08:51:17 +0800
Message-ID: <87set6m73u.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> writes:

> On Thu, Oct 3, 2024 at 8:35=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Wed, Oct 2, 2024 at 8:43=E2=80=AFAM Huang, Ying <ying.huang@intel.c=
om> wrote:
>> >>
>> >> Barry Song <21cnbao@gmail.com> writes:
>> >>
>> >> > On Tue, Oct 1, 2024 at 7:43=E2=80=AFAM Huang, Ying <ying.huang@inte=
l.com> wrote:
>> >> >>
>> >> >> Barry Song <21cnbao@gmail.com> writes:
>> >> >>
>> >> >> > On Sun, Sep 29, 2024 at 3:43=E2=80=AFPM Huang, Ying <ying.huang@=
intel.com> wrote:
>> >> >> >>
>> >> >> >> Hi, Barry,
>> >> >> >>
>> >> >> >> Barry Song <21cnbao@gmail.com> writes:
>> >> >> >>
>> >> >> >> > From: Barry Song <v-songbaohua@oppo.com>
>> >> >> >> >
>> >> >> >> > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcac=
he")
>> >> >> >> > introduced an unconditional one-tick sleep when `swapcache_pr=
epare()`
>> >> >> >> > fails, which has led to reports of UI stuttering on latency-s=
ensitive
>> >> >> >> > Android devices. To address this, we can use a waitqueue to w=
ake up
>> >> >> >> > tasks that fail `swapcache_prepare()` sooner, instead of alwa=
ys
>> >> >> >> > sleeping for a full tick. While tasks may occasionally be wok=
en by an
>> >> >> >> > unrelated `do_swap_page()`, this method is preferable to two =
scenarios:
>> >> >> >> > rapid re-entry into page faults, which can cause livelocks, a=
nd
>> >> >> >> > multiple millisecond sleeps, which visibly degrade user exper=
ience.
>> >> >> >>
>> >> >> >> In general, I think that this works. =C2=A0Why not extend the s=
olution to
>> >> >> >> cover schedule_timeout_uninterruptible() in __read_swap_cache_a=
sync()
>> >> >> >> too? =C2=A0We can call wake_up() when we clear SWAP_HAS_CACHE. =
=C2=A0To avoid
>> >> >> >
>> >> >> > Hi Ying,
>> >> >> > Thanks for your comments.
>> >> >> > I feel extending the solution to __read_swap_cache_async() shoul=
d be done
>> >> >> > in a separate patch. On phones, I've never encountered any issue=
s reported
>> >> >> > on that path, so it might be better suited for an optimization r=
ather than a
>> >> >> > hotfix?
>> >> >>
>> >> >> Yes. =C2=A0It's fine to do that in another patch as optimization.
>> >> >
>> >> > Ok. I'll prepare a separate patch for optimizing that path.
>> >>
>> >> Thanks!
>> >>
>> >> >>
>> >> >> >> overhead to call wake_up() when there's no task waiting, we can=
 use an
>> >> >> >> atomic to count waiting tasks.
>> >> >> >
>> >> >> > I'm not sure it's worth adding the complexity, as wake_up() on a=
n empty
>> >> >> > waitqueue should have a very low cost on its own?
>> >> >>
>> >> >> wake_up() needs to call spin_lock_irqsave() unconditionally on a g=
lobal
>> >> >> shared lock. =C2=A0On systems with many CPUs (such servers), this =
may cause
>> >> >> severe lock contention. =C2=A0Even the cache ping-pong may hurt pe=
rformance
>> >> >> much.
>> >> >
>> >> > I understand that cache synchronization was a significant issue bef=
ore
>> >> > qspinlock, but it seems to be less of a concern after its implement=
ation.
>> >>
>> >> Unfortunately, qspinlock cannot eliminate cache ping-pong issue, as
>> >> discussed in the following thread.
>> >>
>> >> https://lore.kernel.org/lkml/20220510192708.GQ76023@worktop.programmi=
ng.kicks-ass.net/
>> >>
>> >> > However, using a global atomic variable would still trigger cache b=
roadcasts,
>> >> > correct?
>> >>
>> >> We can only change the atomic variable to non-zero when
>> >> swapcache_prepare() returns non-zero, and call wake_up() when the ato=
mic
>> >> variable is non-zero. =C2=A0Because swapcache_prepare() returns 0 mos=
t times,
>> >> the atomic variable is 0 most times. =C2=A0If we don't change the val=
ue of
>> >> atomic variable, cache ping-pong will not be triggered.
>> >
>> > yes. this can be implemented by adding another atomic variable.
>>
>> Just realized that we don't need another atomic variable for this, just
>> use waitqueue_active() before wake_up() should be enough.
>>
>> >>
>> >> Hi, Kairui,
>> >>
>> >> Do you have some test cases to test parallel zram swap-in? =C2=A0If s=
o, that
>> >> can be used to verify whether cache ping-pong is an issue and whether=
 it
>> >> can be fixed via a global atomic variable.
>> >>
>> >
>> > Yes, Kairui please run a test on your machine with lots of cores before
>> > and after adding a global atomic variable as suggested by Ying. I am
>> > sorry I don't have a server machine.
>> >
>> > if it turns out you find cache ping-pong can be an issue, another
>> > approach would be a waitqueue hash:
>>
>> Yes. =C2=A0waitqueue hash may help reduce lock contention. =C2=A0And, we=
 can have
>> both waitqueue_active() and waitqueue hash if necessary. =C2=A0As the fi=
rst
>> step, waitqueue_active() appears simpler.
>
> Hi Andrew,
> If there are no objections, can you please squash the below change? Oven
> has already tested the change and the original issue was still fixed with
> it. If you want me to send v2 instead, please let me know.
>
> From a5ca401da89f3b628c3a0147e54541d0968654b2 Mon Sep 17 00:00:00 2001
> From: Barry Song <v-songbaohua@oppo.com>
> Date: Tue, 8 Oct 2024 20:18:27 +0800
> Subject: [PATCH] mm: wake_up only when swapcache_wq waitqueue is active
>
> wake_up() will acquire spinlock even waitqueue is empty. This might
> involve cache sync overhead. Let's only call wake_up() when waitqueue
> is active.
>
> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/memory.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index fe21bd3beff5..4adb2d0bcc7a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4623,7 +4623,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	/* Clear the swap cache pin for direct swapin after PTL unlock */
>  	if (need_clear_cache) {
>  		swapcache_clear(si, entry, nr_pages);
> -		wake_up(&swapcache_wq);
> +		if (waitqueue_active(&swapcache_wq))
> +			wake_up(&swapcache_wq);
>  	}
>  	if (si)
>  		put_swap_device(si);
> @@ -4641,7 +4642,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	}
>  	if (need_clear_cache) {
>  		swapcache_clear(si, entry, nr_pages);
> -		wake_up(&swapcache_wq);
> +		if (waitqueue_active(&swapcache_wq))
> +			wake_up(&swapcache_wq);
>  	}
>  	if (si)
>  		put_swap_device(si);

Hi, Kairui,

Do you have time to give this patch (combined with the previous patch
from Barry) a test to check whether the overhead introduced in the
previous patch has been eliminated?

--
Best Regards,
Huang, Ying

