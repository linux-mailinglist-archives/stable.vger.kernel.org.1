Return-Path: <stable+bounces-41738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F618B5B14
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 16:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E8A1F2187B
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 14:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE2776413;
	Mon, 29 Apr 2024 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vl4oWP69"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CC29468
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714400286; cv=none; b=qdPoY8FKEPkrM/ExOFDZlOZxuI27nV8SPFhWlUD0LPU1wufk2PIY3N4ZMJ0RTMzCrre5lYX8sQ4LY+IKrvLeMHw4IkNzNSNpUK4m017QVDpQGRvCuireDsfbTIuUYFqzkZIVEFiW/VTDj8CAFmB4LHGiwYb6mrlJtgJrtIC6jzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714400286; c=relaxed/simple;
	bh=/WFgc1n1CCANuQ8/uY/4YcdmDP5mkDWZ02T0w4iKNAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5WJS+RU88E8gbt1TfWSw75KJIAkKZw9RjkGYbShYsS8LT6528xl5wDN2j72tVMxfBnwZJj5NOur+ty2NFjfgw+b4Y2bvZcegkl1kXZ6R9aXkYkVqAi9WDQHNki+DlmXm2EiafbB0i7HyS+BTWSmE6q6Um2ciHjl08IAixKdL1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vl4oWP69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FF2C113CD;
	Mon, 29 Apr 2024 14:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714400286;
	bh=/WFgc1n1CCANuQ8/uY/4YcdmDP5mkDWZ02T0w4iKNAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vl4oWP69xwyi/c5M6EQVtZI3SYc51DEwetlcbHiiHKDrt5/V7VacOdXLMC34C39Kn
	 o1ZlRDAKHmZh99F47c6a3D+e7nTjoakfP7edVcQZt4yMUwZ3fsjH+rD5j2rps0FmyG
	 3KrqrMbukKhz75nNC/VbI9Zdbizs7451nzPA6VoU=
Date: Mon, 29 Apr 2024 16:18:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev,
	christian@heusel.eu, ddstreet@ieee.org, nphamcs@gmail.com,
	rjones@redhat.com, sjenning@redhat.com, stable@vger.kernel.org,
	vitaly.wool@konsulko.com, yosryahmed@google.com
Subject: Re: [PATCH 6.8.y] mm: zswap: fix shrinker NULL crash with
 cgroup_disable=memory
Message-ID: <2024042954-hardship-arise-b7cd@gregkh>
References: <2024042923-monday-hamlet-26ca@gregkh>
 <20240429130216.GB1155473@cmpxchg.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429130216.GB1155473@cmpxchg.org>

On Mon, Apr 29, 2024 at 09:02:16AM -0400, Johannes Weiner wrote:
> Christian reports a NULL deref in zswap that he bisected down to the zswap
> shrinker.  The issue also cropped up in the bug trackers of libguestfs [1]
> and the Red Hat bugzilla [2].
> 
> The problem is that when memcg is disabled with the boot time flag, the
> zswap shrinker might get called with sc->memcg == NULL.  This is okay in
> many places, like the lruvec operations.  But it crashes in
> memcg_page_state() - which is only used due to the non-node accounting of
> cgroup's the zswap memory to begin with.
> 
> Nhat spotted that the memcg can be NULL in the memcg-disabled case, and I
> was then able to reproduce the crash locally as well.
> 
> [1] https://github.com/libguestfs/libguestfs/issues/139
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=2275252
> 
> Link: https://lkml.kernel.org/r/20240418124043.GC1055428@cmpxchg.org
> Link: https://lkml.kernel.org/r/20240417143324.GA1055428@cmpxchg.org
> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Reported-by: Christian Heusel <christian@heusel.eu>
> Debugged-by: Nhat Pham <nphamcs@gmail.com>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Tested-by: Christian Heusel <christian@heusel.eu>
> Acked-by: Yosry Ahmed <yosryahmed@google.com>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Dan Streetman <ddstreet@ieee.org>
> Cc: Richard W.M. Jones <rjones@redhat.com>
> Cc: Seth Jennings <sjenning@redhat.com>
> Cc: Vitaly Wool <vitaly.wool@konsulko.com>
> Cc: <stable@vger.kernel.org>	[v6.8]
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 682886ec69d22363819a83ddddd5d66cb5c791e1)
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/zswap.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)

Now queued up, thanks.

greg k-h

