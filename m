Return-Path: <stable+bounces-80617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C10198E7E4
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 02:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5339628350A
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 00:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E89CBA49;
	Thu,  3 Oct 2024 00:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jw4OUQHi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F81401C;
	Thu,  3 Oct 2024 00:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727916146; cv=none; b=pMczcLrF59acFhJvrzeIfYQGOnI6j1PuMrUr+l1xmkEWpwysF6XEvBzmG56dHMc69IH+NuZOt/V1lAIV5kkp4cHIzHgnQdBo4UNXHkdk4ze2l+/NmWnd50HDEp2ozlsMrZAUk3YkUr5j86B4oyLlM4LtkqLDt9RrNZS4uZErWrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727916146; c=relaxed/simple;
	bh=QapNPDWW0D6xJOFkvf3OmH3dvhr7KwJvo4JUoMz4Ih8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=asyuLpoDadG1k5CqcK+l1J8MJ/OnTXGgMi3t/YKIf2ESg7dK2J2McfloxnUvnFUA13kLQPbOFxOMruZceArI+8+TyR5XaJIGo8umlwhLmSGXp1hKojNh2+zFgsTDJ29ji+OjDVncRp0TmlyJM+pTqapjPgfI8mtzw6ziFNqN450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jw4OUQHi; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727916144; x=1759452144;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=QapNPDWW0D6xJOFkvf3OmH3dvhr7KwJvo4JUoMz4Ih8=;
  b=Jw4OUQHiUQzf3ZuYbIi9Tu846JO2g3JMykLe0obESvDyxZvQ/UIQkKvZ
   65SXAbLLx25VpHxnkGmJ8XVrQXLIl9etoxpzsa7IX6eY3krw/6BDM9UEB
   CafYSiyPUBD9TSzEBldYyTo4HctJ66/HstuGaaxNyTfi4V9z+AoqBbnlq
   a06MgtTW6BD3kvoHybNGRKGVjDkNDxY4I56nqKNpU+3IMq+jBVhVdberB
   Q4XfqSiV7ldaG/DY6JMm0vhFywJeRuzirQA5laIFjr+P5czPHf+s5yfnI
   /QpZ8ZlbGsW5Nh9dkH60oNS+n0migZRgq9KG+AGLGN3zEJ7389dMe+830
   w==;
X-CSE-ConnectionGUID: qqKq5oh4Ql6TqlkgVIv+uA==
X-CSE-MsgGUID: fr2h7Y2TRraZyQHwkmDdgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="49625985"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="49625985"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 17:42:24 -0700
X-CSE-ConnectionGUID: fSM5io+RQ22OuT3atUyjTg==
X-CSE-MsgGUID: B/nHh/MZTy+qdU6hSAldDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74426139"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 17:42:19 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>,  akpm@linux-foundation.org,
  chrisl@kernel.org,  david@redhat.com,  hannes@cmpxchg.org,
  hughd@google.com,  kaleshsingh@google.com,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  liyangouwen1@oppo.com,  mhocko@suse.com,
  minchan@kernel.org,  sj@kernel.org,  stable@vger.kernel.org,
  surenb@google.com,  v-songbaohua@oppo.com,  willy@infradead.org,
  yosryahmed@google.com,  yuzhao@google.com
Subject: Re: [PATCH] mm: avoid unconditional one-tick sleep when
 swapcache_prepare fails
In-Reply-To: <CAMgjq7D5qoFEK9Omvd5_Zqs6M+TEoG03+2i_mhuP5CQPSOPrmQ@mail.gmail.com>
	(Kairui Song's message of "Thu, 3 Oct 2024 02:30:29 +0800")
References: <87y137nxqs.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20241002015754.969-1-21cnbao@gmail.com>
	<CAMgjq7D5qoFEK9Omvd5_Zqs6M+TEoG03+2i_mhuP5CQPSOPrmQ@mail.gmail.com>
Date: Thu, 03 Oct 2024 08:38:46 +0800
Message-ID: <87ed4ynhpl.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, Kairui,

Kairui Song <ryncsn@gmail.com> writes:

> On Wed, Oct 2, 2024 at 10:02=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
>>
>> On Wed, Oct 2, 2024 at 8:43=E2=80=AFAM Huang, Ying <ying.huang@intel.com=
> wrote:
>> >
>> > Barry Song <21cnbao@gmail.com> writes:
>> >
>> > > On Tue, Oct 1, 2024 at 7:43=E2=80=AFAM Huang, Ying <ying.huang@intel=
.com> wrote:
>> > >>
>> > >> Barry Song <21cnbao@gmail.com> writes:
>> > >>
>> > >> > On Sun, Sep 29, 2024 at 3:43=E2=80=AFPM Huang, Ying <ying.huang@i=
ntel.com> wrote:
>> > >> >>
>> > >> >> Hi, Barry,
>> > >> >>
>> > >> >> Barry Song <21cnbao@gmail.com> writes:
>> > >> >>
>> > >> >> > From: Barry Song <v-songbaohua@oppo.com>
>> > >> >> >
>> > >> >> > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcach=
e")
>> > >> >> > introduced an unconditional one-tick sleep when `swapcache_pre=
pare()`
>> > >> >> > fails, which has led to reports of UI stuttering on latency-se=
nsitive
>> > >> >> > Android devices. To address this, we can use a waitqueue to wa=
ke up
>> > >> >> > tasks that fail `swapcache_prepare()` sooner, instead of always
>> > >> >> > sleeping for a full tick. While tasks may occasionally be woke=
n by an
>> > >> >> > unrelated `do_swap_page()`, this method is preferable to two s=
cenarios:
>> > >> >> > rapid re-entry into page faults, which can cause livelocks, and
>> > >> >> > multiple millisecond sleeps, which visibly degrade user experi=
ence.
>> > >> >>
>> > >> >> In general, I think that this works.  Why not extend the solutio=
n to
>> > >> >> cover schedule_timeout_uninterruptible() in __read_swap_cache_as=
ync()
>> > >> >> too?  We can call wake_up() when we clear SWAP_HAS_CACHE.  To av=
oid
>> > >> >
>> > >> > Hi Ying,
>> > >> > Thanks for your comments.
>> > >> > I feel extending the solution to __read_swap_cache_async() should=
 be done
>> > >> > in a separate patch. On phones, I've never encountered any issues=
 reported
>> > >> > on that path, so it might be better suited for an optimization ra=
ther than a
>> > >> > hotfix?
>
> Hi Barry and Ying,
>
> For the __read_swap_cache_async case, I'm not really against adding a
> similar workqueue, but if no one is really suffering from it, and if
> the workqueue do causes extra overhead, maybe we can ignore it for the
> __read_swap_cache_async case now, and I plan to resent the following
> patch:
> https://lore.kernel.org/linux-mm/20240326185032.72159-9-ryncsn@gmail.com/=
#r
>
> It removed all schedule_timeout_uninterruptible workaround and other
> similar things, and the performance will go even higher.

Sounds good to me.  Please resend it.  It's more complex than Barry's
fix.  So, I suggest to merge Barry's version first.

>> > >>
>> > >> Yes.  It's fine to do that in another patch as optimization.
>> > >
>> > > Ok. I'll prepare a separate patch for optimizing that path.
>> >
>> > Thanks!
>> >
>> > >>
>> > >> >> overhead to call wake_up() when there's no task waiting, we can =
use an
>> > >> >> atomic to count waiting tasks.
>> > >> >
>> > >> > I'm not sure it's worth adding the complexity, as wake_up() on an=
 empty
>> > >> > waitqueue should have a very low cost on its own?
>> > >>
>> > >> wake_up() needs to call spin_lock_irqsave() unconditionally on a gl=
obal
>> > >> shared lock.  On systems with many CPUs (such servers), this may ca=
use
>> > >> severe lock contention.  Even the cache ping-pong may hurt performa=
nce
>> > >> much.
>> > >
>> > > I understand that cache synchronization was a significant issue befo=
re
>> > > qspinlock, but it seems to be less of a concern after its implementa=
tion.
>> >
>> > Unfortunately, qspinlock cannot eliminate cache ping-pong issue, as
>> > discussed in the following thread.
>> >
>> > https://lore.kernel.org/lkml/20220510192708.GQ76023@worktop.programmin=
g.kicks-ass.net/
>> >
>> > > However, using a global atomic variable would still trigger cache br=
oadcasts,
>> > > correct?
>> >
>> > We can only change the atomic variable to non-zero when
>> > swapcache_prepare() returns non-zero, and call wake_up() when the atom=
ic
>> > variable is non-zero.  Because swapcache_prepare() returns 0 most time=
s,
>> > the atomic variable is 0 most times.  If we don't change the value of
>> > atomic variable, cache ping-pong will not be triggered.
>>
>> yes. this can be implemented by adding another atomic variable.
>>
>> >
>> > Hi, Kairui,
>> >
>> > Do you have some test cases to test parallel zram swap-in?  If so, that
>> > can be used to verify whether cache ping-pong is an issue and whether =
it
>> > can be fixed via a global atomic variable.
>> >
>>
>> Yes, Kairui please run a test on your machine with lots of cores before
>> and after adding a global atomic variable as suggested by Ying. I am
>> sorry I don't have a server machine.
>
> I just had a try with the build kernel test which I used for the
> allocator patch series, with -j64, 1G memcg on my local branch:
>
> Without the patch:
> 2677.63user 9100.43system 3:33.15elapsed 5452%CPU (0avgtext+0avgdata
> 863284maxresident)k
> 2671.40user 8969.07system 3:33.67elapsed 5447%CPU (0avgtext+0avgdata
> 863316maxresident)k
> 2673.66user 8973.90system 3:33.18elapsed 5463%CPU (0avgtext+0avgdata
> 863284maxresident)k
>
> With the patch:
> 2655.05user 9134.21system 3:35.63elapsed 5467%CPU (0avgtext+0avgdata
> 863288maxresident)k
> 2652.57user 9104.87system 3:35.07elapsed 5466%CPU (0avgtext+0avgdata
> 863272maxresident)k
> 2665.44user 9155.97system 3:35.92elapsed 5474%CPU (0avgtext+0avgdata
> 863316maxresident)k
>
> Only three test runs, the main bottleneck for the test is still some
> other locks (list_lru lock, swap cgroup lock etc), but it does show
> the performance seems a bit lower. Could be considered a trivial
> amount of overhead so I think it's acceptable for the SYNC_IO path.

Thanks!  The difference appears measurable although small.  And, in some
use cases, multiple memcg may be used, so list_lru, swap cgroup lock
will be less contended.

--
Best Regards,
Huang, Ying

