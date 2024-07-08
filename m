Return-Path: <stable+bounces-58191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 910C6929AAF
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 04:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFED5B20BF7
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 02:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B1A1C06;
	Mon,  8 Jul 2024 02:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTJFDE6/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E641878;
	Mon,  8 Jul 2024 02:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720404604; cv=none; b=l0so1/eET2t7/vk9S8Yvb9muYMAPXWdnpa1UqGlZuDRgS7dfxtz/bUZX25HKqL+ngvfF45PBetFrk8YQHk2LuFxPuo1M2SGFgoMlBrRYqiC8baylf5pgVT7b/uhKz/GgxxzfJzN/29jPY1xMlOWJPrkelCqBbKeoFqjZEj7l9Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720404604; c=relaxed/simple;
	bh=bielFRYZBuFDdZGgB2itutKTB4UtPntaiyjVKayA8mY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y1K28lHmHjjWZQuoW/RnqPRfFjCN8zVgcnd6vZLzur8nCQFpCscjuyTCZm0UyPvB+VbI4uq/RTrlHHHHHQPG4bzwgJdo8VQs7ejjl9Ny6Xu61OCZ1kfxJX5ms0oJSBrDnx3S9CJL4qCSrantGWCDBn254iZFh0zVPIaNwqc0cgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTJFDE6/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720404600; x=1751940600;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=bielFRYZBuFDdZGgB2itutKTB4UtPntaiyjVKayA8mY=;
  b=VTJFDE6/uW6T5GmC52nx8e6LcLywwRfX+MfkRfqP/bJMNSlcTyvW/bYG
   Zp7qdNhQd+e9H99QA7OOvAPKVTW/25PgrfSMS8f/fXDsuWx3/LyRclKDq
   HpjWoNv4agrMyCfEb4gGJNzaUdVzQAenbQDQ2mXlUVrP5Eik05M8MMXPD
   fz1xQ0J/0VwimyGCtrbHwSnUfnfv2QEiK1XE/VXlK6x+JvHpdSJ4TAPAK
   k/kxlvQd1kcofWaNNvjnyVDJ7LIBcVtZaB/Nzv/rDZsu/MhxYbekzL/Bc
   a1tgw3A5IjqvuDXyLQTXprPbstcoXL4tSAyXz0CFVotqNuVw3+fkvg9B4
   g==;
X-CSE-ConnectionGUID: arA34LLDQk6ywJ4diid2jg==
X-CSE-MsgGUID: 6TEmoAgCSimqb9+rlzdyfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="17234112"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="17234112"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 19:09:59 -0700
X-CSE-ConnectionGUID: lD7LPvPlQcSO5Z3geuux7w==
X-CSE-MsgGUID: Q1fUjy21TCWmG69T/QD65A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="52181108"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 19:09:56 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Tvrtko Ursulin <tursulin@igalia.com>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  kernel-dev@igalia.com,  Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,  Mel
 Gorman <mgorman@suse.de>,  Peter Zijlstra <peterz@infradead.org>,  Ingo
 Molnar <mingo@redhat.com>,  Rik van Riel <riel@surriel.com>,  Johannes
 Weiner <hannes@cmpxchg.org>,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,  Dave Hansen <dave.hansen@intel.com>,  Andi Kleen
 <ak@linux.intel.com>,  Michal Hocko <mhocko@suse.com>,  David Rientjes
 <rientjes@google.com>,  stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/numa_balancing: Teach mpol_to_str about the
 balancing mode
In-Reply-To: <20240705143218.21258-2-tursulin@igalia.com> (Tvrtko Ursulin's
	message of "Fri, 5 Jul 2024 15:32:16 +0100")
References: <20240705143218.21258-1-tursulin@igalia.com>
	<20240705143218.21258-2-tursulin@igalia.com>
Date: Mon, 08 Jul 2024 10:08:05 +0800
Message-ID: <874j90eiuy.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Tvrtko Ursulin <tursulin@igalia.com> writes:

> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Since balancing mode was added in
> bda420b98505 ("numa balancing: migrate on fault among multiple bound nodes"),
> it was possible to set this mode but it wouldn't be shown in
> /proc/<pid>/numa_maps since there was no support for it in the
> mpol_to_str() helper.
>
> Furthermore, because the balancing mode sets the MPOL_F_MORON flag, it
> would be displayed as 'default' due a workaround introduced a few years
> earlier in
> 8790c71a18e5 ("mm/mempolicy.c: fix mempolicy printing in numa_maps").
>
> To tidy this up we implement two changes:
>
> Replace the MPOL_F_MORON check by pointer comparison against the
> preferred_node_policy array. By doing this we generalise the current
> special casing and replace the incorrect 'default' with the correct
> 'bind' for the mode.
>
> Secondly, we add a string representation and corresponding handling for
> the MPOL_F_NUMA_BALANCING flag.
>
> With the two changes together we start showing the balancing flag when it
> is set and therefore complete the fix.
>
> Representation format chosen is to separate multiple flags with vertical
> bars, following what existed long time ago in kernel 2.6.25. But as
> between then and now there wasn't a way to display multiple flags, this
> patch does not change the format in practice.
>
> Some /proc/<pid>/numa_maps output examples:
>
>  555559580000 bind=balancing:0-1,3 file=...
>  555585800000 bind=balancing|static:0,2 file=...
>  555635240000 prefer=relative:0 file=
>
> v2:
>  * Fully fix by introducing MPOL_F_KERNEL.
>
> v3:
>  * Abandoned the MPOL_F_KERNEL approach in favour of pointer comparisons.
>  * Removed lookup generalisation for easier backporting.
>  * Replaced commas as separator with vertical bars.
>  * Added a few more words about the string format in the commit message.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: bda420b98505 ("numa balancing: migrate on fault among multiple bound nodes")
> References: 8790c71a18e5 ("mm/mempolicy.c: fix mempolicy printing in numa_maps")
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: <stable@vger.kernel.org> # v5.12+
> ---
>  mm/mempolicy.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index aec756ae5637..1bfb6c73a39c 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3293,8 +3293,9 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
>   * @pol:  pointer to mempolicy to be formatted
>   *
>   * Convert @pol into a string.  If @buffer is too short, truncate the string.
> - * Recommend a @maxlen of at least 32 for the longest mode, "interleave", the
> - * longest flag, "relative", and to display at least a few node ids.
> + * Recommend a @maxlen of at least 42 for the longest mode, "weighted
> + * interleave", the longest flag, "balancing", and to display at least a few

And we may display 2 flags now, +9 further?

> + * node ids.
>   */
>  void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>  {
> @@ -3303,7 +3304,10 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>  	unsigned short mode = MPOL_DEFAULT;
>  	unsigned short flags = 0;
>  
> -	if (pol && pol != &default_policy && !(pol->flags & MPOL_F_MORON)) {
> +	if (pol &&
> +	    pol != &default_policy &&
> +	    !(pol >= &preferred_node_policy[0] &&
> +	      pol <= &preferred_node_policy[MAX_NUMNODES - 1])) {

Better to replace MAX_NUMNODES with ARRAY_SIZE() here.

>  		mode = pol->mode;
>  		flags = pol->flags;
>  	}
> @@ -3331,12 +3335,18 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>  		p += snprintf(p, buffer + maxlen - p, "=");
>  
>  		/*
> -		 * Currently, the only defined flags are mutually exclusive
> +		 * Static and relative are mutually exclusive.
>  		 */
>  		if (flags & MPOL_F_STATIC_NODES)
>  			p += snprintf(p, buffer + maxlen - p, "static");
>  		else if (flags & MPOL_F_RELATIVE_NODES)
>  			p += snprintf(p, buffer + maxlen - p, "relative");
> +
> +		if (flags & MPOL_F_NUMA_BALANCING) {
> +			if (hweight16(flags & MPOL_MODE_FLAGS) > 1)
> +				p += snprintf(p, buffer + maxlen - p, "|");
> +			p += snprintf(p, buffer + maxlen - p, "balancing");
> +		}

Still think that it's better to move this part to [2/3].  Unless you can
make the change small and the resulting code looks good.

>  	}
>  
>  	if (!nodes_empty(nodes))

--
Best Regards,
Huang, Ying

