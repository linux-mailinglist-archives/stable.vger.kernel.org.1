Return-Path: <stable+bounces-106180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F259FCF3B
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 01:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E2F1638FE
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 00:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9018488;
	Fri, 27 Dec 2024 00:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MR6HUthq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC6F2F28;
	Fri, 27 Dec 2024 00:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735258996; cv=none; b=lJMeTBXbwQelCrzKt/u/Cq6njnyvuPMZwActO8i4sGnMqeMwJtu6+SA8gr3W3y66h7Yl4U7S5pt9fQra051eO5/WYnqmgNlYxiUgqTjGrZPDUokWchmaSvFbGZlZiOHduSryDJOdLRocd5VUnow1JeE1vYS6bRbDgrAlMasEI2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735258996; c=relaxed/simple;
	bh=/vZcApYuz/cKEiouEx/Lz1TxKN1JZIqm2ya1Z6PJasE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sD1Ue2okqeVtupjqUrxMO+q/Xlz/hVOXbQsYd2dbn0k8F2ZWoyxlfHx4UZXRe5XiB+cd9OFA+2Qf3rhAuayfqsDNyZMI8cemsq0bE0iG9m3IrUkD1kSZoTTxKPsYwgc9vBdxL9vgdoZICrxp7nj8bL0JoflbELX7GoAtoZyHKm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MR6HUthq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB0DC4CED1;
	Fri, 27 Dec 2024 00:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1735258996;
	bh=/vZcApYuz/cKEiouEx/Lz1TxKN1JZIqm2ya1Z6PJasE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MR6HUthqtyJKDRNHZntDDIi19c/cnLf5fyQfQMd40D8lXvjU9KGrJ4Dtpbdc1mv8o
	 NhlI4zcuTW0PURTt5HS+mxm/u6FOUrwU1BYL2hZLQqBva9zK3sdUnH7QiiQnfLiqHT
	 AHV2SoXuWAF+k9LngDfeT7coeFX4pdYE+sl8f+kM=
Date: Thu, 26 Dec 2024 16:23:15 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, yuzhao@google.com, 00107082@163.com,
 quic_zhenhuah@quicinc.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] alloc_tag: skip pgalloc_tag_swap if profiling is
 disabled
Message-Id: <20241226162315.cbf088cb28fe897bfe1b075b@linux-foundation.org>
In-Reply-To: <CAJuCfpFSYqQ1LN0OZQT+jU=vLXZa5-L2Agdk1gzMdk9J0Zb-vg@mail.gmail.com>
References: <20241226211639.1357704-1-surenb@google.com>
	<20241226211639.1357704-2-surenb@google.com>
	<20241226150127.73d1b2a08cf31dac1a900c1e@linux-foundation.org>
	<CAJuCfpFSYqQ1LN0OZQT+jU=vLXZa5-L2Agdk1gzMdk9J0Zb-vg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 26 Dec 2024 15:07:39 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> On Thu, Dec 26, 2024 at 3:01 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 26 Dec 2024 13:16:39 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > > When memory allocation profiling is disabled, there is no need to swap
> > > allocation tags during migration. Skip it to avoid unnecessary overhead.
> > >
> > > Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Cc: stable@vger.kernel.org
> >
> > Are these changes worth backporting?  Some indication of how much
> > difference the patches make would help people understand why we're
> > proposing a backport.
> 
> The first patch ("alloc_tag: avoid current->alloc_tag manipulations
> when profiling is disabled") I think is worth backporting. It
> eliminates about half of the regression for slab allocations when
> profiling is disabled.

um, what regression?  The changelog makes no mention of this.  Please
send along a suitable Reported-by: and Closes: and a summary of the
benefits so that people can actually see what this patch does, and why.


