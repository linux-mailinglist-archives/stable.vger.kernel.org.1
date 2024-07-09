Return-Path: <stable+bounces-58264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A675892B000
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 08:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40B51C21826
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 06:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3345312EBE7;
	Tue,  9 Jul 2024 06:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ci09Fy4P"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5BD12C475;
	Tue,  9 Jul 2024 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506090; cv=none; b=YAqyDKtDrKMEzIEwT07mo4scHxwpMoAPdxjOUNrkz+j1AOgxu6VBzXhx9GoA0q2RhiLft4TL6VhhPYra/ie2aB/9mj5myQsG+rnU/gaBnNMw9ShLn0beJXbQ/KzenZ0HOZgrZkVGVNCJt6Q95xm4VqMksotoOcPIVJ9zHNGXRM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506090; c=relaxed/simple;
	bh=GR3LjQQcsOfDijR4d6rjFBNH45bQPCCpzk+BKwaObsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qVERcAeD5S5fwPvo71t1u+qZI5tespsJRkNnReE1Y/s+Jo4o4bULqcXzY40gfW3+WYCxGcntkEIAhHmkHyGg4HDqzYcCrV0IkLMlRS+Jn/6czXztKzgqcQ9JB0lv/uokVqJ4Jjt9IzhM81yO8L5ODE8kEwZhANRZ9hjXTVL7Cdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ci09Fy4P; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720506087; x=1752042087;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=GR3LjQQcsOfDijR4d6rjFBNH45bQPCCpzk+BKwaObsc=;
  b=Ci09Fy4P8O9QqdqNVUEmQoDB+zFQdTCrGZ+3j4IZEj5FZGbMm9+NrCIn
   ZryFPWBPa53Fg5VDC13WosuWveODxwy0sA04jYa2ib8lNqvf7gN94p0bj
   0ttEAP7FFAoGMODcRzW/17/h7ENfLlMpyWgF4C+jLLgIjIdT4198ZynY3
   pVXNMmaflt7xJxclHUc0ack1n1pLNbL07Kvq0JGHHSDrBpBb1CNTUxZt/
   iQqDuSgYLJh+W8tjsrsSS+iVrWB0/56f2zV6EpwSKGynfyEldOT8FQCb4
   2D54qy6smmfZiRlHwrAAIRAwcO5jojfSxIid5OKHZT4PItO1HyQ4/803f
   g==;
X-CSE-ConnectionGUID: GgT9SpFsQUuRN04vsjgj4Q==
X-CSE-MsgGUID: vyLEBw0MTUyD5hQag9ZW0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="28339678"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="28339678"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 23:21:25 -0700
X-CSE-ConnectionGUID: v1qVtX4QRTGO3OSeC7LAcw==
X-CSE-MsgGUID: LWlTtEBXQgy55AgPWu0piw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="52146100"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 23:21:21 -0700
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
Subject: Re: [PATCH v4] mm/numa_balancing: Teach mpol_to_str about the
 balancing mode
In-Reply-To: <20240708075632.95857-1-tursulin@igalia.com> (Tvrtko Ursulin's
	message of "Mon, 8 Jul 2024 08:56:32 +0100")
References: <20240708075632.95857-1-tursulin@igalia.com>
Date: Tue, 09 Jul 2024 14:19:29 +0800
Message-ID: <87ttgzaxzi.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> v4:
>  * Use is_power_of_2.
>  * Use ARRAY_SIZE and update recommended buffer size for two flags.
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

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/mempolicy.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index aec756ae5637..a1bf9aa15c33 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3293,8 +3293,9 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
>   * @pol:  pointer to mempolicy to be formatted
>   *
>   * Convert @pol into a string.  If @buffer is too short, truncate the string.
> - * Recommend a @maxlen of at least 32 for the longest mode, "interleave", the
> - * longest flag, "relative", and to display at least a few node ids.
> + * Recommend a @maxlen of at least 51 for the longest mode, "weighted
> + * interleave", plus the longest flag flags, "relative|balancing", and to
> + * display at least a few node ids.
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
> +	      pol <= &preferred_node_policy[ARRAY_SIZE(preferred_node_policy) - 1])) {
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
> +			if (!is_power_of_2(flags & MPOL_MODE_FLAGS))
> +				p += snprintf(p, buffer + maxlen - p, "|");
> +			p += snprintf(p, buffer + maxlen - p, "balancing");
> +		}
>  	}
>  
>  	if (!nodes_empty(nodes))

