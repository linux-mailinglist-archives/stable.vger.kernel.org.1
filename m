Return-Path: <stable+bounces-87791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5859ABB43
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 04:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE29284617
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 02:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41440487BE;
	Wed, 23 Oct 2024 02:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+4V1WyK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3945420322;
	Wed, 23 Oct 2024 02:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729648881; cv=none; b=E11xILs4GiothSovai1sPXF/7QWjQZ/5Ff5WiIpSZneB5TQIbpy5+rXmWrxBDrsYVVaLGdaC4jbA02quNr0n2rIt0cVTZ2m0LPHMOvxH6VT1KgLUoeDPC7dBDN4275k9bQHvS8NbufJLojItaJbd1fpuHW9yYQtTg8SoGSVtJ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729648881; c=relaxed/simple;
	bh=1i3ThIkrrVe2fLu6Tt2tqRj2QRumtfMWOK9itQrA6xA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ywv/GD/Wl2TKWEQc8ZEkGa0PErDne1i65MWi+pYbJY2eExuvTvIltqMjoopCMzLcLlrbmB8KIPbCkiCql4c+2BqOjIZPEzvs/J/fVJ9AhY6SmHMngg795c5/MwsW/oTZ2wIL99P2twKly6omt/NHTAehT9nfsPXaueXdPw+arWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+4V1WyK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729648879; x=1761184879;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=1i3ThIkrrVe2fLu6Tt2tqRj2QRumtfMWOK9itQrA6xA=;
  b=m+4V1WyKTWkv9diUU5zR8QSB1tDqmK9mh7lmEStXIpZGx3BdwDw7mqEW
   7TkxSqar/iPz97H+kRlCCDy2gs9kcJ6/T9j3T/ShX29DXyqRxi55XABVJ
   /xrGbyHBW6xx9rHHJSfgpAw4QaLxK4S5w/kUvTpP1OjkSrQ4MUonZUB/p
   kTcFYYazgkc1U5L2zUuv5RpegpUWLL4ELltk8iDI1S3Ap+hF0g64WIuhF
   +rxk8fmPkvT8YXUb+v/RRhvSu8FIBGzREdB34U/WVrM2hzuYQtpa+eueT
   mRrJIA5GK8a7CpSxWQbwA3thHgNpFpnGAXMq8+RNQAzlsyeqneU+WusnJ
   w==;
X-CSE-ConnectionGUID: OKpY9xzhQ5200lJnTuH86g==
X-CSE-MsgGUID: QrUG8SA/TYu1/lE3/ZybWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39763195"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39763195"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 19:01:18 -0700
X-CSE-ConnectionGUID: NqEj6QBqTYCHESkKj4X0+Q==
X-CSE-MsgGUID: EBVpR1IVTC2bIlI0mIUBkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="79623556"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 19:01:14 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: akpm@linux-foundation.org,  chrisl@kernel.org,  david@redhat.com,
  hannes@cmpxchg.org,  hughd@google.com,  kaleshsingh@google.com,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  liyangouwen1@oppo.com,  mhocko@suse.com,  minchan@kernel.org,
  sj@kernel.org,  stable@vger.kernel.org,  surenb@google.com,
  v-songbaohua@oppo.com,  willy@infradead.org,  yosryahmed@google.com,
  yuzhao@google.com,  Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] mm: avoid unconditional one-tick sleep when
 swapcache_prepare fails
In-Reply-To: <CAMgjq7D6Ku4-0mfJUexB9ARxY5eHwJjMS_M9qqXrvR=ScW0jtA@mail.gmail.com>
	(Kairui Song's message of "Tue, 22 Oct 2024 17:21:07 +0800")
References: <87ikuani1f.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20241008130807.40833-1-21cnbao@gmail.com>
	<87set6m73u.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAMgjq7D6Ku4-0mfJUexB9ARxY5eHwJjMS_M9qqXrvR=ScW0jtA@mail.gmail.com>
Date: Wed, 23 Oct 2024 09:57:41 +0800
Message-ID: <87iktj4m3u.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kairui Song <ryncsn@gmail.com> writes:

> On Wed, Oct 9, 2024 at 8:55=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Thu, Oct 3, 2024 at 8:35=E2=80=AFAM Huang, Ying <ying.huang@intel.c=
om> wrote:
>> >>
>> >> Barry Song <21cnbao@gmail.com> writes:
>> >>
>> >> > On Wed, Oct 2, 2024 at 8:43=E2=80=AFAM Huang, Ying <ying.huang@inte=
l.com> wrote:
>> >> >>
>> >> >> Barry Song <21cnbao@gmail.com> writes:
>> >> >>
>> >> >> > On Tue, Oct 1, 2024 at 7:43=E2=80=AFAM Huang, Ying <ying.huang@i=
ntel.com> wrote:
>> >> >> >>
>> >> >> >> Barry Song <21cnbao@gmail.com> writes:
>> >> >> >>
>> >> >> >> > On Sun, Sep 29, 2024 at 3:43=E2=80=AFPM Huang, Ying <ying.hua=
ng@intel.com> wrote:
>> >> >> >> >>
>> >> >> >> >> Hi, Barry,
>> >> >> >> >>
>> >> >> >> >> Barry Song <21cnbao@gmail.com> writes:
>> >> >> >> >>
>> >> >> >> >> > From: Barry Song <v-songbaohua@oppo.com>
>> >> >> >> >> >
>> >> >> >> >> > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swap=
cache")
>> >> >> >> >> > introduced an unconditional one-tick sleep when `swapcache=
_prepare()`
>> >> >> >> >> > fails, which has led to reports of UI stuttering on latenc=
y-sensitive
>> >> >> >> >> > Android devices. To address this, we can use a waitqueue t=
o wake up
>> >> >> >> >> > tasks that fail `swapcache_prepare()` sooner, instead of a=
lways
>> >> >> >> >> > sleeping for a full tick. While tasks may occasionally be =
woken by an
>> >> >> >> >> > unrelated `do_swap_page()`, this method is preferable to t=
wo scenarios:
>> >> >> >> >> > rapid re-entry into page faults, which can cause livelocks=
, and
>> >> >> >> >> > multiple millisecond sleeps, which visibly degrade user ex=
perience.
>> >> >> >> >>
>> >> >> >> >> In general, I think that this works.  Why not extend the sol=
ution to
>> >> >> >> >> cover schedule_timeout_uninterruptible() in __read_swap_cach=
e_async()
>> >> >> >> >> too?  We can call wake_up() when we clear SWAP_HAS_CACHE.  T=
o avoid
>> >> >> >> >
>> >> >> >> > Hi Ying,
>> >> >> >> > Thanks for your comments.
>> >> >> >> > I feel extending the solution to __read_swap_cache_async() sh=
ould be done
>> >> >> >> > in a separate patch. On phones, I've never encountered any is=
sues reported
>> >> >> >> > on that path, so it might be better suited for an optimizatio=
n rather than a
>> >> >> >> > hotfix?
>> >> >> >>
>> >> >> >> Yes.  It's fine to do that in another patch as optimization.
>> >> >> >
>> >> >> > Ok. I'll prepare a separate patch for optimizing that path.
>> >> >>
>> >> >> Thanks!
>> >> >>
>> >> >> >>
>> >> >> >> >> overhead to call wake_up() when there's no task waiting, we =
can use an
>> >> >> >> >> atomic to count waiting tasks.
>> >> >> >> >
>> >> >> >> > I'm not sure it's worth adding the complexity, as wake_up() o=
n an empty
>> >> >> >> > waitqueue should have a very low cost on its own?
>> >> >> >>
>> >> >> >> wake_up() needs to call spin_lock_irqsave() unconditionally on =
a global
>> >> >> >> shared lock.  On systems with many CPUs (such servers), this ma=
y cause
>> >> >> >> severe lock contention.  Even the cache ping-pong may hurt perf=
ormance
>> >> >> >> much.
>> >> >> >
>> >> >> > I understand that cache synchronization was a significant issue =
before
>> >> >> > qspinlock, but it seems to be less of a concern after its implem=
entation.
>> >> >>
>> >> >> Unfortunately, qspinlock cannot eliminate cache ping-pong issue, as
>> >> >> discussed in the following thread.
>> >> >>
>> >> >> https://lore.kernel.org/lkml/20220510192708.GQ76023@worktop.progra=
mming.kicks-ass.net/
>> >> >>
>> >> >> > However, using a global atomic variable would still trigger cach=
e broadcasts,
>> >> >> > correct?
>> >> >>
>> >> >> We can only change the atomic variable to non-zero when
>> >> >> swapcache_prepare() returns non-zero, and call wake_up() when the =
atomic
>> >> >> variable is non-zero.  Because swapcache_prepare() returns 0 most =
times,
>> >> >> the atomic variable is 0 most times.  If we don't change the value=
 of
>> >> >> atomic variable, cache ping-pong will not be triggered.
>> >> >
>> >> > yes. this can be implemented by adding another atomic variable.
>> >>
>> >> Just realized that we don't need another atomic variable for this, ju=
st
>> >> use waitqueue_active() before wake_up() should be enough.
>> >>
>> >> >>
>> >> >> Hi, Kairui,
>> >> >>
>> >> >> Do you have some test cases to test parallel zram swap-in?  If so,=
 that
>> >> >> can be used to verify whether cache ping-pong is an issue and whet=
her it
>> >> >> can be fixed via a global atomic variable.
>> >> >>
>> >> >
>> >> > Yes, Kairui please run a test on your machine with lots of cores be=
fore
>> >> > and after adding a global atomic variable as suggested by Ying. I am
>> >> > sorry I don't have a server machine.
>> >> >
>> >> > if it turns out you find cache ping-pong can be an issue, another
>> >> > approach would be a waitqueue hash:
>> >>
>> >> Yes.  waitqueue hash may help reduce lock contention.  And, we can ha=
ve
>> >> both waitqueue_active() and waitqueue hash if necessary.  As the first
>> >> step, waitqueue_active() appears simpler.
>> >
>> > Hi Andrew,
>> > If there are no objections, can you please squash the below change? Ov=
en
>> > has already tested the change and the original issue was still fixed w=
ith
>> > it. If you want me to send v2 instead, please let me know.
>> >
>> > From a5ca401da89f3b628c3a0147e54541d0968654b2 Mon Sep 17 00:00:00 2001
>> > From: Barry Song <v-songbaohua@oppo.com>
>> > Date: Tue, 8 Oct 2024 20:18:27 +0800
>> > Subject: [PATCH] mm: wake_up only when swapcache_wq waitqueue is active
>> >
>> > wake_up() will acquire spinlock even waitqueue is empty. This might
>> > involve cache sync overhead. Let's only call wake_up() when waitqueue
>> > is active.
>> >
>> > Suggested-by: "Huang, Ying" <ying.huang@intel.com>
>> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> > ---
>> >  mm/memory.c | 6 ++++--
>> >  1 file changed, 4 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/mm/memory.c b/mm/memory.c
>> > index fe21bd3beff5..4adb2d0bcc7a 100644
>> > --- a/mm/memory.c
>> > +++ b/mm/memory.c
>> > @@ -4623,7 +4623,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >       /* Clear the swap cache pin for direct swapin after PTL unlock */
>> >       if (need_clear_cache) {
>> >               swapcache_clear(si, entry, nr_pages);
>> > -             wake_up(&swapcache_wq);
>> > +             if (waitqueue_active(&swapcache_wq))
>> > +                     wake_up(&swapcache_wq);
>> >       }
>> >       if (si)
>> >               put_swap_device(si);
>> > @@ -4641,7 +4642,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >       }
>> >       if (need_clear_cache) {
>> >               swapcache_clear(si, entry, nr_pages);
>> > -             wake_up(&swapcache_wq);
>> > +             if (waitqueue_active(&swapcache_wq))
>> > +                     wake_up(&swapcache_wq);
>> >       }
>> >       if (si)
>> >               put_swap_device(si);
>>
>> Hi, Kairui,
>>
>> Do you have time to give this patch (combined with the previous patch
>> from Barry) a test to check whether the overhead introduced in the
>> previous patch has been eliminated?
>
> Hi Ying, Barry
>
> I did a rebase on mm tree and run more tests with the latest patch:
>
> Before the two patches:
> make -j96 (64k): 33814.45 35061.25 35667.54 36618.30 37381.60 37678.75
> make -j96: 20456.03 20460.36 20511.55 20584.76 20751.07 20780.79
> make -j64:7490.83 7515.55 7535.30 7544.81 7564.77 7583.41
>
> After adding workqueue:
> make -j96 (64k): 33190.60 35049.57 35732.01 36263.81 37154.05 37815.50
> make -j96: 20373.27 20382.96 20428.78 20459.73 20534.59 20548.48
> make -j64: 7469.18 7522.57 7527.38 7532.69 7543.36 7546.28
>
> After adding workqueue with workqueue_active() check:
> make -j96 (64k): 33321.03 35039.68 35552.86 36474.95 37502.76 37549.04
> make -j96: 20601.39 20639.08 20692.81 20693.91 20701.35 20740.71
> make -j64: 7538.63 7542.27 7564.86 7567.36 7594.14 7600.96
>
> So I think it's just noise level performance change, it should be OK
> in either way.

Thanks for your test results.  There should be bottlenecks in other
places.

--
Best Regards,
Huang, Ying

