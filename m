Return-Path: <stable+bounces-58139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D7E928AD7
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 16:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11992B21367
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 14:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A597216A94A;
	Fri,  5 Jul 2024 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YliE/fNc"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41AE1465B3;
	Fri,  5 Jul 2024 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720190632; cv=none; b=e/JJE63Q7zwM/9f4yNwGmRXp3b5ESaZ4dVhANh5NBIE9B8r4/RvaMWJ5ZXC6/aiPHYg+wAuxI3d/Bb0hY+Vfx62DakmpqX/c2CTffnQKM7K1bngpG4SEMobNhEZ2+bEjlvpHyfD8yznPVgrm7YmPXLDdPnhFdPKX3A1igTPMlDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720190632; c=relaxed/simple;
	bh=Vhntci0wzGkw+gduQ/JT/972+ITFydSC0rXzJYt6SD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/wT7Q1AElX6ItrC0ZQ5s6XNzP5yZK/GeVtN3WYleTYn7MppjQeSy9+Aqj8V88A8pOA322FbktguXl1ZOUMNFYJ/YoHwV3CphJua/MjL+O5d+spNjTT5FYbcP+/oiZrv+HNAiDxgejRfZbKG1cQO7MMOKAsbUQ2upvvoAULMWoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YliE/fNc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j0SJsEEP11U4Vk7UXdQukCdPjJQfadC3871Fcu4WmXw=; b=YliE/fNcZFURKz25OvdBvqgnuf
	+1PmeQN/O1v6WBIJ+Gv+jojfC/8t3vkeTLZYoSn/auGiQgisQAkSqGDwla2AXCLDSikU4RoVMVIBd
	hWK2horQVBCMKv75MM/NUwlC/rY46ZaHjfKZTGe4IIdpwj7at//b6yeNX1+9dpuir3Gq1UlKhgiTx
	mZwFQO3KOpWy3j02EhgCJY/8hqPdV1kIHfs8ZMnvhXe5dbYZBtjUy7rZpk6JDXCgC3IJ/QlwqDetr
	8HuGC0hEY02EYq5rWDwyY0lnE+Yw7d5dbaphF8MvvQjtGF1iwHWMoCzJteMpydff6sj/IMMNZBBSt
	NHh3YJvw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPk9y-0000000447K-1T2F;
	Fri, 05 Jul 2024 14:43:38 +0000
Date: Fri, 5 Jul 2024 15:43:38 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Tvrtko Ursulin <tursulin@igalia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Huang Ying <ying.huang@intel.com>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@surriel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/numa_balancing: Teach mpol_to_str about the
 balancing mode
Message-ID: <ZogGmvTfOXqUtyz6@casper.infradead.org>
References: <20240705143218.21258-1-tursulin@igalia.com>
 <20240705143218.21258-2-tursulin@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705143218.21258-2-tursulin@igalia.com>

On Fri, Jul 05, 2024 at 03:32:16PM +0100, Tvrtko Ursulin wrote:
> +		if (flags & MPOL_F_NUMA_BALANCING) {
> +			if (hweight16(flags & MPOL_MODE_FLAGS) > 1)

hweight() > 1 seems somewhat inefficient.
!is_power_of_2() would be better.  Or clear off the bits as they're
printed and print the bar if the remaining flags are not 0.

> +				p += snprintf(p, buffer + maxlen - p, "|");
> +			p += snprintf(p, buffer + maxlen - p, "balancing");
> +		}
>  	}
>  
>  	if (!nodes_empty(nodes))
> -- 
> 2.44.0
> 
> 

