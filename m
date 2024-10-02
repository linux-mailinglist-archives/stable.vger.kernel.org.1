Return-Path: <stable+bounces-78589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBBC98CA1E
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 02:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D811F23C2F
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 00:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A7015D1;
	Wed,  2 Oct 2024 00:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NeVJWx6g"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D0879CC;
	Wed,  2 Oct 2024 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727829831; cv=none; b=KSV/bBSq0mZ5Zqh3RXfQd23LS8SuukfV+3LAlKMZoVVFbIPtMl+n18F923tOIcfvL9zIbl8M9Y+hfW7gQ371NmNuhR56V5PSqF81MSDAnffmfUBClkzFQPHvesuH71SAyZqZZz/URdLW7CfZFwqg/LzjXHjS5YguEe+rxJeHZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727829831; c=relaxed/simple;
	bh=tcXTdEFpw72XF6DZDqbt/wfDaFhysJTtY2A9zo6XIT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DkDG/GxkKIrjPF6WJY6enP1YXqvPTP65RrM4kT6ZzCu9LkURMVrDWPFTGcGn7Vu8jOcgcFMZYB+Xp2RpG5Bu2W17+96sMv/XILkoAbAsGCdTB6h0vD7h9f4M78Yb9cTG/VP3s5jse2ipfhDXv6ufq4P7GobTD5jK5rX4xzHlnes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NeVJWx6g; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727829831; x=1759365831;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=tcXTdEFpw72XF6DZDqbt/wfDaFhysJTtY2A9zo6XIT4=;
  b=NeVJWx6gTx8MDmgDn4G9bw3wAVxeBpju3Dq7gX5FE2b+KKUlwGBOAJSq
   twsqWCKStfUGPFVjZ5witvdyvPGxXcMEw6sYRAualxzmzs2XIszuDKzZz
   wiWOcZ2MFgo2yzWstABn5iAn34c+KMAWaFcWDydsr5ZBhwjjjCwxQrdeM
   GSVsRyfg/gR/8KbtPtIuUS0Y8vkJkVi+7KZPKE3paa6HOZOSK+lxKZlFG
   FyeGMyzha+OU18LFA3Dsh2y09STlC2lS6yMOI//f3CFxxvGt7BJUbY1Tn
   aqM+8uPVs3/4xaxSdgMtd6AStojp7hWnvNYl2TdztOwVGmXAbveVqMWc8
   Q==;
X-CSE-ConnectionGUID: tSZw+QBMT+mFkEnfZCpGhA==
X-CSE-MsgGUID: GzLY1hTfTkiyx5tmlTcgpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="38120600"
X-IronPort-AV: E=Sophos;i="6.11,170,1725346800"; 
   d="scan'208";a="38120600"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 17:43:50 -0700
X-CSE-ConnectionGUID: h996thFRSziLfQDCq8t10g==
X-CSE-MsgGUID: NPFLuKCjQ1ietow+3qFIag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,170,1725346800"; 
   d="scan'208";a="74166951"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 17:43:46 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>,  Kairui Song <kasong@tencent.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Barry Song <v-songbaohua@oppo.com>,  Yu
 Zhao <yuzhao@google.com>,  David Hildenbrand <david@redhat.com>,  Chris Li
 <chrisl@kernel.org>,  Hugh Dickins <hughd@google.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Matthew Wilcox <willy@infradead.org>,  Michal Hocko
 <mhocko@suse.com>,  Minchan Kim <minchan@kernel.org>,  Yosry Ahmed
 <yosryahmed@google.com>,  SeongJae Park <sj@kernel.org>,  Kalesh Singh
 <kaleshsingh@google.com>,  Suren Baghdasaryan <surenb@google.com>,
  stable@vger.kernel.org,  Oven Liyang <liyangouwen1@oppo.com>
Subject: Re: [PATCH] mm: avoid unconditional one-tick sleep when
 swapcache_prepare fails
In-Reply-To: <CAGsJ_4wfjo2-dnGwybx5YR_o+FEzoVG+V=O1mxQ801FdHPSGiA@mail.gmail.com>
	(Barry Song's message of "Tue, 1 Oct 2024 22:16:40 +0800")
References: <20240926211936.75373-1-21cnbao@gmail.com>
	<871q13qj2t.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4w2PjN+4DKWM6qvaEUAX=FQW0rp+6Wjx1Qrq=jaAz7wsw@mail.gmail.com>
	<877caspv6u.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4wfjo2-dnGwybx5YR_o+FEzoVG+V=O1mxQ801FdHPSGiA@mail.gmail.com>
Date: Wed, 02 Oct 2024 08:40:11 +0800
Message-ID: <87y137nxqs.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Tue, Oct 1, 2024 at 7:43=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Sun, Sep 29, 2024 at 3:43=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Hi, Barry,
>> >>
>> >> Barry Song <21cnbao@gmail.com> writes:
>> >>
>> >> > From: Barry Song <v-songbaohua@oppo.com>
>> >> >
>> >> > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache")
>> >> > introduced an unconditional one-tick sleep when `swapcache_prepare(=
)`
>> >> > fails, which has led to reports of UI stuttering on latency-sensiti=
ve
>> >> > Android devices. To address this, we can use a waitqueue to wake up
>> >> > tasks that fail `swapcache_prepare()` sooner, instead of always
>> >> > sleeping for a full tick. While tasks may occasionally be woken by =
an
>> >> > unrelated `do_swap_page()`, this method is preferable to two scenar=
ios:
>> >> > rapid re-entry into page faults, which can cause livelocks, and
>> >> > multiple millisecond sleeps, which visibly degrade user experience.
>> >>
>> >> In general, I think that this works.  Why not extend the solution to
>> >> cover schedule_timeout_uninterruptible() in __read_swap_cache_async()
>> >> too?  We can call wake_up() when we clear SWAP_HAS_CACHE.  To avoid
>> >
>> > Hi Ying,
>> > Thanks for your comments.
>> > I feel extending the solution to __read_swap_cache_async() should be d=
one
>> > in a separate patch. On phones, I've never encountered any issues repo=
rted
>> > on that path, so it might be better suited for an optimization rather =
than a
>> > hotfix?
>>
>> Yes.  It's fine to do that in another patch as optimization.
>
> Ok. I'll prepare a separate patch for optimizing that path.

Thanks!

>>
>> >> overhead to call wake_up() when there's no task waiting, we can use an
>> >> atomic to count waiting tasks.
>> >
>> > I'm not sure it's worth adding the complexity, as wake_up() on an empty
>> > waitqueue should have a very low cost on its own?
>>
>> wake_up() needs to call spin_lock_irqsave() unconditionally on a global
>> shared lock.  On systems with many CPUs (such servers), this may cause
>> severe lock contention.  Even the cache ping-pong may hurt performance
>> much.
>
> I understand that cache synchronization was a significant issue before
> qspinlock, but it seems to be less of a concern after its implementation.

Unfortunately, qspinlock cannot eliminate cache ping-pong issue, as
discussed in the following thread.

https://lore.kernel.org/lkml/20220510192708.GQ76023@worktop.programming.kic=
ks-ass.net/

> However, using a global atomic variable would still trigger cache broadca=
sts,
> correct?

We can only change the atomic variable to non-zero when
swapcache_prepare() returns non-zero, and call wake_up() when the atomic
variable is non-zero.  Because swapcache_prepare() returns 0 most times,
the atomic variable is 0 most times.  If we don't change the value of
atomic variable, cache ping-pong will not be triggered.

Hi, Kairui,

Do you have some test cases to test parallel zram swap-in?  If so, that
can be used to verify whether cache ping-pong is an issue and whether it
can be fixed via a global atomic variable.

--
Best Regards,
Huang, Ying

