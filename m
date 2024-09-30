Return-Path: <stable+bounces-78306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D785E98B12B
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 01:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45465B2549B
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 23:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EA1199EB1;
	Mon, 30 Sep 2024 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KhGA+gIS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845EC19DF74;
	Mon, 30 Sep 2024 23:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739834; cv=none; b=qp7SmuYCeLT7ZbCtmZOML8b0JagWNKFTFOVAxME6o4totpij5VpVXVm5ZghE6hh7ZqIGISNeOQzWDQvlrCaxrZniwaai2SQ4TtD9G7zpM03jLtb+XV3sZDEYlmj0sTlTSSgasj3dMG4kkLMD9lNWKrZQ1UgaPRoLMazV8mGpJVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739834; c=relaxed/simple;
	bh=6/Anv+xT63yPRfB/N/xPoSruDcxtQ92XNpgYzWAl8mI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E85Hsbux+Gyys/mIYhwTde34OQmWHh86Ruub1B4NGQq6WEgrRFjUuulNc+rq+UoxHBUK18DRpdTG+3lu+eA4DGgAQ2kwmfFysrXtWMdfeDxnNdsTzVs0243ZMmr3rtSvL688iGtmd8LfyBK0f3Pc0hQcczOapxVFZaU0juGoM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KhGA+gIS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727739833; x=1759275833;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=6/Anv+xT63yPRfB/N/xPoSruDcxtQ92XNpgYzWAl8mI=;
  b=KhGA+gISl+ZgoaA3aMIVVp0gwGjTnuye/SjEFsxvzgeRnY2SfcTixZGB
   oLIQEi89gD36jQ0TJX0Qmet0Eu/sGWxZcvOUOcyKpm+5Vij1UuhcMRZfZ
   rPeYOr7U1aTgVaLGS3QtjTYdcC/tReu3ScG68TtMXeZ7hAGcjxGpTOHB8
   k8Q+0bBgkK8WiqzeLp3ygu2WSw6PG8KUdPEdazSnSL3RDsZXEX0lXVzFu
   lTPo85ayrzPHyI/r9lYLAeRbTtpvA6/80J7wFZRc3uEMBGdXr5xWRpCdO
   4dap5QVBvhbBs7TNKflwNhqc1whjoAWTdLFD/es7j2oRmpxXqG2nF1Xiw
   A==;
X-CSE-ConnectionGUID: +6KI9yxfSJyc7yXXj+H3yw==
X-CSE-MsgGUID: caJgwAnuRJmEdpFScG2YAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="49375678"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="49375678"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:43:47 -0700
X-CSE-ConnectionGUID: j99LZzZzT+acawSy+yt8Xg==
X-CSE-MsgGUID: sU+SB+MVTeaXoQvcp5yjIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="78201228"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:43:43 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Barry Song <v-songbaohua@oppo.com>,
  Kairui Song <kasong@tencent.com>,  Yu Zhao <yuzhao@google.com>,  David
 Hildenbrand <david@redhat.com>,  Chris Li <chrisl@kernel.org>,  Hugh
 Dickins <hughd@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,
  Matthew Wilcox <willy@infradead.org>,  Michal Hocko <mhocko@suse.com>,
  Minchan Kim <minchan@kernel.org>,  Yosry Ahmed <yosryahmed@google.com>,
  SeongJae Park <sj@kernel.org>,  Kalesh Singh <kaleshsingh@google.com>,
  Suren Baghdasaryan <surenb@google.com>,  stable@vger.kernel.org,  Oven
 Liyang <liyangouwen1@oppo.com>
Subject: Re: [PATCH] mm: avoid unconditional one-tick sleep when
 swapcache_prepare fails
In-Reply-To: <CAGsJ_4w2PjN+4DKWM6qvaEUAX=FQW0rp+6Wjx1Qrq=jaAz7wsw@mail.gmail.com>
	(Barry Song's message of "Tue, 1 Oct 2024 02:18:13 +1300")
References: <20240926211936.75373-1-21cnbao@gmail.com>
	<871q13qj2t.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4w2PjN+4DKWM6qvaEUAX=FQW0rp+6Wjx1Qrq=jaAz7wsw@mail.gmail.com>
Date: Tue, 01 Oct 2024 07:40:09 +0800
Message-ID: <877caspv6u.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Sun, Sep 29, 2024 at 3:43=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Hi, Barry,
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > From: Barry Song <v-songbaohua@oppo.com>
>> >
>> > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache")
>> > introduced an unconditional one-tick sleep when `swapcache_prepare()`
>> > fails, which has led to reports of UI stuttering on latency-sensitive
>> > Android devices. To address this, we can use a waitqueue to wake up
>> > tasks that fail `swapcache_prepare()` sooner, instead of always
>> > sleeping for a full tick. While tasks may occasionally be woken by an
>> > unrelated `do_swap_page()`, this method is preferable to two scenarios:
>> > rapid re-entry into page faults, which can cause livelocks, and
>> > multiple millisecond sleeps, which visibly degrade user experience.
>>
>> In general, I think that this works.  Why not extend the solution to
>> cover schedule_timeout_uninterruptible() in __read_swap_cache_async()
>> too?  We can call wake_up() when we clear SWAP_HAS_CACHE.  To avoid
>
> Hi Ying,
> Thanks for your comments.
> I feel extending the solution to __read_swap_cache_async() should be done
> in a separate patch. On phones, I've never encountered any issues reported
> on that path, so it might be better suited for an optimization rather tha=
n a
> hotfix?

Yes.  It's fine to do that in another patch as optimization.

>> overhead to call wake_up() when there's no task waiting, we can use an
>> atomic to count waiting tasks.
>
> I'm not sure it's worth adding the complexity, as wake_up() on an empty
> waitqueue should have a very low cost on its own?

wake_up() needs to call spin_lock_irqsave() unconditionally on a global
shared lock.  On systems with many CPUs (such servers), this may cause
severe lock contention.  Even the cache ping-pong may hurt performance
much.

--
Best Regards,
Huang, Ying

