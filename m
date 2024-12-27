Return-Path: <stable+bounces-106191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F479FD1AD
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 08:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8872D18831F0
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 07:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C097314C59C;
	Fri, 27 Dec 2024 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XQUscpec"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485B51E495;
	Fri, 27 Dec 2024 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286342; cv=none; b=a4IX/hjsOzPD5BJ36pi3h5WARLvWzXo/z59VL/5jNs6xRleIJpsovj6B7D6h8sxs2dUpM9vNisXl5JWfJ5ru5ao9LBcigKU3b4sBMvmE720QS4L/GnfMvH/wdx/uera/ycXUAR4zeb+Qa/9ETZfUWInuWuuQKcqjh8wDA+psQXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286342; c=relaxed/simple;
	bh=jm1RYTQY7LJ4qbIfPO3KSN9Mx6BcILm8uE3LFOmCLKI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CaIuBuVlFjXPYyNWVo21fWIvyB/txOkTWeUpPZt1Lwt4XK2/JlGtxz5Tkd6ZpruCCFK4iBMdU9d/jZGSvTCPRffvyVQSZDdfgpQjKzfiE0CYgC9xkD87GneIKJWZrJQ2NdF/12S833HqEOq0VedZY0XZGts9zeq8N0FZjcRHPDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XQUscpec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885AFC4CED0;
	Fri, 27 Dec 2024 07:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1735286341;
	bh=jm1RYTQY7LJ4qbIfPO3KSN9Mx6BcILm8uE3LFOmCLKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XQUscpecphgYEMXHTscPORqu4AK0HvYZjoKM9AAqYqUj/Ob4GnAnN7+iZq70E7NcL
	 GWXKByH3W0tmCKd7tUDZNTqTtuba9WIi0FrGlbcHa5uSgM33igqED0laJz+XoZ4DzW
	 5nykr7zBfUpVNC1EYfIg1Qo0BjqlLRgLTJN8xkZ8=
Date: Thu, 26 Dec 2024 23:59:00 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, yuzhao@google.com, 00107082@163.com,
 quic_zhenhuah@quicinc.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] alloc_tag: skip pgalloc_tag_swap if profiling is
 disabled
Message-Id: <20241226235900.5a4e3ab79840e08482380976@linux-foundation.org>
In-Reply-To: <CAJuCfpG_cbwFSdL5mt0_M_t0Ejc_P3TA+QGxZvHMAK1P+z7_BA@mail.gmail.com>
References: <20241226211639.1357704-1-surenb@google.com>
	<20241226211639.1357704-2-surenb@google.com>
	<20241226150127.73d1b2a08cf31dac1a900c1e@linux-foundation.org>
	<CAJuCfpFSYqQ1LN0OZQT+jU=vLXZa5-L2Agdk1gzMdk9J0Zb-vg@mail.gmail.com>
	<20241226162315.cbf088cb28fe897bfe1b075b@linux-foundation.org>
	<CAJuCfpG_cbwFSdL5mt0_M_t0Ejc_P3TA+QGxZvHMAK1P+z7_BA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 26 Dec 2024 16:56:00 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> On Thu, Dec 26, 2024 at 4:23 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 26 Dec 2024 15:07:39 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > > On Thu, Dec 26, 2024 at 3:01 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Thu, 26 Dec 2024 13:16:39 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > > When memory allocation profiling is disabled, there is no need to swap
> > > > > allocation tags during migration. Skip it to avoid unnecessary overhead.
> > > > >
> > > > > Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
> > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > Cc: stable@vger.kernel.org
> > > >
> > > > Are these changes worth backporting?  Some indication of how much
> > > > difference the patches make would help people understand why we're
> > > > proposing a backport.
> > >
> > > The first patch ("alloc_tag: avoid current->alloc_tag manipulations
> > > when profiling is disabled") I think is worth backporting. It
> > > eliminates about half of the regression for slab allocations when
> > > profiling is disabled.
> >
> > um, what regression?  The changelog makes no mention of this.  Please
> > send along a suitable Reported-by: and Closes: and a summary of the
> > benefits so that people can actually see what this patch does, and why.
> 
> Sorry, I should have used "overhead" instead of "regression".
> When one sets CONFIG_MEM_ALLOC_PROFILING=y, the code gets instrumented
> and even if profiling is turned off, it still has a small performance
> cost minimized by the use of mem_alloc_profiling_key static key. I
> found a couple of places which were not protected with
> mem_alloc_profiling_key, which means that even when profiling is
> turned off, the code is still executed. Once I added these checks, the
> overhead of the mode when memory profiling is enabled but turned off
> went down by about 50%.

Well, a 50% reduction in a 0.0000000001% overhead ain't much.  But I
added the final sentence to the changelog.

It still doesn't tell us the very simple thing which we're all eager to
know: how much faster did the kernel get??

