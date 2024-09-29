Return-Path: <stable+bounces-78199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD4A9892BF
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 04:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9308F1C228E2
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 02:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0F518C31;
	Sun, 29 Sep 2024 02:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8m7cIif"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538E32770B;
	Sun, 29 Sep 2024 02:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727577799; cv=none; b=ZHNwp0XO8V2yi1gcS7EpokbXthBB26mHII+v8OMsJabEGhi0DtNcnY6/e+KPtYce7MEOjKXTLDpg9t6n5pSj9ibxbv/j/jHhvCiGAv8TkVMX3zovqRDkEVeDeipMrtvujBXgE/lHk6S548A7PzpPGh+pWEsd43lpEWOwpzMYGlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727577799; c=relaxed/simple;
	bh=g8uX7WlDZec4SnDsF7a5R6meNAivR0E+SHDO40mm4IU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bs21vp//71d4BnKgIRV9/Pfm0RU0/PT974f4uHfXhSjT3MDQ3GjdqnU/OUq8wBSZYlDbZtkMoP1LBPPZQL01K6dLZ5szWu6K0Er+cD8MGitZ/puM8395bHMr59pjim5gsN+uPMyN2W3Pfwvrk1f8CTT/mr4obQzUIkcDWkhM4dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8m7cIif; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727577798; x=1759113798;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=g8uX7WlDZec4SnDsF7a5R6meNAivR0E+SHDO40mm4IU=;
  b=E8m7cIifSufcxxRrCICZ95FFMGmVk06lRSLPWNbSCA9VuIdy7Y6yVNgx
   3jzP2h7+iFdCoSJFnEPh7B0UesUPHn44IvPBC70oL9QUPZuwwuhQvKRzJ
   lBXyVrSQt/e/yCrsjzYHueecm2KmcY+cd631MBAUgx7/a5FORq3mb6IOC
   URDtknP6RD2hl91g6vvJf09ICG7Jpe1QQoLhC3pNXSyyFkdY+MqfY6d96
   XGfu7GGdsd0HR4CsxyNPJzQx2lG2WFzXnLxlTaJPkX8FZAxOmYu7Jo8WX
   dFODaRsz7He+nqap0R+6gWl3prw09k63n1xXjpM34fkD4alVeE2KhC0YS
   g==;
X-CSE-ConnectionGUID: +0SaHYiNQvO3blUmGmbNYQ==
X-CSE-MsgGUID: FQLo0IQzTBSEH37GcU/f2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="26820099"
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="26820099"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 19:43:17 -0700
X-CSE-ConnectionGUID: 4DrfJr3eTpKPJm6yD4yWqA==
X-CSE-MsgGUID: rHlnvx1cTy6q6al5OHj5fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="103713140"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 19:43:12 -0700
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
In-Reply-To: <20240926211936.75373-1-21cnbao@gmail.com> (Barry Song's message
	of "Fri, 27 Sep 2024 09:19:36 +1200")
References: <20240926211936.75373-1-21cnbao@gmail.com>
Date: Sun, 29 Sep 2024 10:39:38 +0800
Message-ID: <871q13qj2t.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Barry,

Barry Song <21cnbao@gmail.com> writes:

> From: Barry Song <v-songbaohua@oppo.com>
>
> Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache")
> introduced an unconditional one-tick sleep when `swapcache_prepare()`
> fails, which has led to reports of UI stuttering on latency-sensitive
> Android devices. To address this, we can use a waitqueue to wake up
> tasks that fail `swapcache_prepare()` sooner, instead of always
> sleeping for a full tick. While tasks may occasionally be woken by an
> unrelated `do_swap_page()`, this method is preferable to two scenarios:
> rapid re-entry into page faults, which can cause livelocks, and
> multiple millisecond sleeps, which visibly degrade user experience.

In general, I think that this works.  Why not extend the solution to
cover schedule_timeout_uninterruptible() in __read_swap_cache_async()
too?  We can call wake_up() when we clear SWAP_HAS_CACHE.  To avoid
overhead to call wake_up() when there's no task waiting, we can use an
atomic to count waiting tasks.

[snip]

--
Best Regards,
Huang, Ying

