Return-Path: <stable+bounces-88019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E7D9AE027
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 11:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016111F2253A
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 09:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492DB1B0F00;
	Thu, 24 Oct 2024 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IWf+Uuew"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F47319CD16
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761023; cv=none; b=S2ul2wcRsAAFKKYsfmMXSzZSGn57o9HBNtC6CCsr5Or89SbJWROaLMAtnhaujNGZhZaRr3maLC2ilZIg531ICVsGxdY7xY8PTCLh182xvhCISONGP6KcAbWGZOnzwS4a3pBU3+wbRYOOiEQclmN9IV8k3AV4HVaR50qZegMUSS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761023; c=relaxed/simple;
	bh=kF0owm5ghlXcyHKXDz2YYlI3bQaPzE7ESh0MNMU2Ioc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=df0HUqrRGDOORnRwUl7yaVr85gxgnoGFXMouROJrrN8emPvbie/ibKqY8x56C+wbEJZZ3+NkCeSMq/lNS71aKGobZUiQxvGzLoy0p96iH+ovsG8NBOijd3D4vGYeOKio+pRNGxCukNVWw6wlxSB7IfafksWcApSVjIUIbKjEICA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IWf+Uuew; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37ec4e349f4so490894f8f.0
        for <stable@vger.kernel.org>; Thu, 24 Oct 2024 02:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729761018; x=1730365818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X9LoXdthvwTdUdvUT8FIZ+lOtep4g0DZCjOS42GSTK8=;
        b=IWf+UuewMoLceSq/LTu5x41BJ4IkXjlrFpMnd0Ev/YMAq7xhaADeWmwp7JLGVmOxoB
         ICcvm0CoTfj197XAXK5At+jWbyQkRjflkbpbuLQShtHHI0KAi7Sf882ps28mna66I/AY
         e+I3gg5UhARw27QenIJOv9KmzLyGUoFSiO/WPk6w9y7UKxA/pscDli8Pwv2NSIEMWZEz
         4r7/BL2eETU1/DSO2832UtON2ZdFFL2+UXo/1X6wEpL6iMWUPD4Ut35vygVaoVKo2P54
         Fmz5wZe8+VpxB4RMPfzLsQoirkZuHjndqUoKh1JLuqi7/0jQaQ+VT1VatbcuE0QdhUjw
         wdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761018; x=1730365818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9LoXdthvwTdUdvUT8FIZ+lOtep4g0DZCjOS42GSTK8=;
        b=NTDVlLNmpEl11WVx56hbJN/ROnTzhdONx2UuOLoLoncYMt0HyS2KU16rFYuxEAivwF
         dPcnMaezz8cRrpQlL3TwahW0/6a3JBhVpcPEwtGofEIU41UdHcglQHEtnoaz4wutbWJd
         J3gApCXsegsz9jLCQ0HEDjIE15m4vP+idx7NhSrFGnfE7v4j0c56y2n0o1ij5Hc8JxIi
         LpSMp+W3cHD1ePPdNaZB7+JNeHa2SmjCN+FpkFzNaz2NB5N1q6Zw5NlqzeKFMjBf68yP
         2lSpyncvf9m8N33EIzQYrmBPxGGcs6E0MmKFhoQfZf4gmuVUi3DRD4u9ypA1YpAOtDcj
         fbAw==
X-Forwarded-Encrypted: i=1; AJvYcCXf5iZIr7B/X8fltgUjXwZACqIqMBXVdex7Au92EhppicZxs/dmFT+9lNFtZgNOn/qKJep11yg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynml88uV/y0xSoVhn3VD5RfPlTRb5RpgI6bGsHRvuNbYqHObgC
	bRcCmCub6Lv/9gGKsV0oOBXcdE4K1ebqjrgldAOgg3akPGcFLdjxa2vVJjHe0CQ=
X-Google-Smtp-Source: AGHT+IEs87YGRH3B9ZpyIa05wUtX3bTwEGoWK0QtKbsJSeSxfZItVEg1D+ggmRTUb+ZG3oPRZ/wJaA==
X-Received: by 2002:a5d:6048:0:b0:37d:3973:cb8d with SMTP id ffacd0b85a97d-37efcf18c21mr3567583f8f.24.1729761018211;
        Thu, 24 Oct 2024 02:10:18 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37df9sm10806887f8f.19.2024.10.24.02.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:10:17 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:10:16 +0200
From: Michal Hocko <mhocko@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, stable@vger.kernel.org, nifan@outlook.com,
	dave@stgolabs.net, dan.j.williams@intel.com,
	a.manzanares@samsung.com, dongjoo.linux.dev@gmail.com
Subject: Re: + mm-page_alloc-fix-numa-stats-update-for-cpu-less-nodes.patch
 added to mm-hotfixes-unstable branch
Message-ID: <ZxoO-NEVYaZQbpxN@tiehlicka>
References: <20241023204125.C4DFBC4CECC@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023204125.C4DFBC4CECC@smtp.kernel.org>

I believe this patch should be dropped. Not only it doesn't really
describes an actual problem I believe it is indeed incorrect as
explained https://lore.kernel.org/all/ZxoEWBakAv64wfhD@tiehlicka/T/#u

On Wed 23-10-24 13:41:25, Andrew Morton wrote:
> From: Dongjoo Seo <dongjoo.linux.dev@gmail.com>
> Subject: mm/page_alloc: fix NUMA stats update for cpu-less nodes
> Date: Wed, 23 Oct 2024 10:50:37 -0700
> 
> In the case of memoryless node, when a process prefers a node with no
> memory(e.g., because it is running on a CPU local to that node), the
> kernel treats a nearby node with memory as the preferred node.  As a
> result, such allocations do not increment the numa_foreign counter on the
> memoryless node, leading to skewed NUMA_HIT, NUMA_MISS, and NUMA_FOREIGN
> stats for the nearest node.
> 
> This patch corrects this issue by:
> 1. Checking if the zone or preferred zone is CPU-less before updating
>    the NUMA stats.
> 2. Ensuring NUMA_HIT is only updated if the zone is not CPU-less.
> 3. Ensuring NUMA_FOREIGN is only updated if the preferred zone is not
>    CPU-less.
> 
> Example Before and After Patch:
> - Before Patch:
>  node0                   node1           node2
>  numa_hit                86333181       114338269            5108
>  numa_miss                5199455               0        56844591
>  numa_foreign            32281033        29763013               0
>  interleave_hit                91              91               0
>  local_node              86326417       114288458               0
>  other_node               5206219           49768        56849702
> 
> - After Patch:
>                             node0           node1           node2
>  numa_hit                 2523058         9225528               0
>  numa_miss                 150213           10226        21495942
>  numa_foreign            17144215         4501270               0
>  interleave_hit                91              94               0
>  local_node               2493918         9208226               0
>  other_node                179351           27528        21495942
> 
> Similarly, in the context of cpuless nodes, this patch ensures that NUMA
> statistics are accurately updated by adding checks to prevent the
> miscounting of memory allocations when the involved nodes have no CPUs. 
> This ensures more precise tracking of memory access patterns accross all
> nodes, regardless of whether they have CPUs or not, improving the overall
> reliability of NUMA stat.  The reason is that page allocation from
> dev_dax, cpuset, memcg ..  comes with preferred allocating zone in cpuless
> node and its hard to track the zone info for miss information.
> 
> Link: https://lkml.kernel.org/r/20241023175037.9125-1-dongjoo.linux.dev@gmail.com
> Signed-off-by: Dongjoo Seo <dongjoo.linux.dev@gmail.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Fan Ni <nifan@outlook.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Adam Manzanares <a.manzanares@samsung.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  mm/page_alloc.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> --- a/mm/page_alloc.c~mm-page_alloc-fix-numa-stats-update-for-cpu-less-nodes
> +++ a/mm/page_alloc.c
> @@ -2858,19 +2858,21 @@ static inline void zone_statistics(struc
>  {
>  #ifdef CONFIG_NUMA
>  	enum numa_stat_item local_stat = NUMA_LOCAL;
> +	bool z_is_cpuless = !node_state(zone_to_nid(z), N_CPU);
> +	bool pref_is_cpuless = !node_state(zone_to_nid(preferred_zone), N_CPU);
>  
> -	/* skip numa counters update if numa stats is disabled */
>  	if (!static_branch_likely(&vm_numa_stat_key))
>  		return;
>  
> -	if (zone_to_nid(z) != numa_node_id())
> +	if (zone_to_nid(z) != numa_node_id() || z_is_cpuless)
>  		local_stat = NUMA_OTHER;
>  
> -	if (zone_to_nid(z) == zone_to_nid(preferred_zone))
> +	if (zone_to_nid(z) == zone_to_nid(preferred_zone) && !z_is_cpuless)
>  		__count_numa_events(z, NUMA_HIT, nr_account);
>  	else {
>  		__count_numa_events(z, NUMA_MISS, nr_account);
> -		__count_numa_events(preferred_zone, NUMA_FOREIGN, nr_account);
> +		if (!pref_is_cpuless)
> +			__count_numa_events(preferred_zone, NUMA_FOREIGN, nr_account);
>  	}
>  	__count_numa_events(z, local_stat, nr_account);
>  #endif
> _
> 
> Patches currently in -mm which might be from dongjoo.linux.dev@gmail.com are
> 
> mm-page_alloc-fix-numa-stats-update-for-cpu-less-nodes.patch

-- 
Michal Hocko
SUSE Labs

