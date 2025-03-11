Return-Path: <stable+bounces-124044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D37A5CAC6
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 17:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F40189BC09
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B952E25F988;
	Tue, 11 Mar 2025 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hzs6x+Rz"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDEA25F790
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741710404; cv=none; b=Gs2YPsMl+kkne6hBcTbTrerosoeKhbqY7X5+l49TXYTcV3Qe9BqOD7wyTHL6PSCOluBV9noowwbvh25njV9t2cv4/IXsyTb30G52QhqR5ucWzU43XD5a1uFmXfaD2X4xHDQmG3bF/Srhyl1yzQcrZn+S6IBchdMGxao8Xfcn5xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741710404; c=relaxed/simple;
	bh=hKC54g++R1G+XXuF0lAdxlj7rxnHNuR8kyyjmE1wPkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YH5d6xhk9uzdPjsWm/Wm4BhwQJbge0kRS8HMj9iIwqa1bnM73+qd2cyUAarZtvFMW7r6A2Ld5UJydejguf6n82axK6QwzU/vGQtzpI6TrsH3tZg16WDPndFobtU8nTbZe/52S7cDd7TFTTsrH1v9Ig9JK0BJLHdqcQUYBP7rxmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hzs6x+Rz; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 11 Mar 2025 16:26:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741710399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V2mnFFnUijG9A/gZIz5QOKtJPBK4Pn57c7YnZizYs6g=;
	b=Hzs6x+Rzgb48DJUaYA8dcBu9P4KaphhCvBK6PDI/xDYc20+Ix1DnzuXl3MLVpFHc+/5WNz
	o7sF8qDuDp6OvmiiOtY5vEtxYtmTHnvOXi1bMCoUzOw0PS8BMWxBNkdMb5WPcADd3UrWwe
	FbNy/uDzx8xH2be/izyHuAW905pj/5M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, stable@vger.kernel.org
Subject: Re: [PATCH] memcg: drain obj stock on cpu hotplug teardown
Message-ID: <Z9BkOgZIK1iSQKd5@google.com>
References: <20250310230934.2913113-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310230934.2913113-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 10, 2025 at 04:09:34PM -0700, Shakeel Butt wrote:
> Currently on cpu hotplug teardown, only memcg stock is drained but we
> need to drain the obj stock as well otherwise we will miss the stats
> accumulated on the target cpu as well as the nr_bytes cached. The stats
> include MEMCG_KMEM, NR_SLAB_RECLAIMABLE_B & NR_SLAB_UNRECLAIMABLE_B. In
> addition we are leaking reference to struct obj_cgroup object.
> 
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

