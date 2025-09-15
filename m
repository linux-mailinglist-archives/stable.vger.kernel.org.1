Return-Path: <stable+bounces-179663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9E5B58863
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 01:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7EF1AA6C8A
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 23:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8152DA76C;
	Mon, 15 Sep 2025 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AnCtHntQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062982D238A;
	Mon, 15 Sep 2025 23:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757979770; cv=none; b=Vof92Ffcf1yBKPl7rkOnLDPEpooxvgdRWkP8y3Yt0I7K/YsyKS+OsXGnDYuFrFfp5kMWQPE1W9CpZvHgWoPJS/4vCJz80WndeHneOiUtEVq5V1KsKFKGLJop1GLyx0r02dmHhXwso4FuI8Gz36eRnnGIEfUrNHf8ZtNf3T2FwNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757979770; c=relaxed/simple;
	bh=jZaEOziBglpDbUCJBMp8aBXcUFCv9ylBZH717KvszyM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ih9CbCLkMQUeTkPBRFa5j7M9VVwUxs1TeHYg7JYkrYIkNckcZe9RxLZr4s1ulRn/BgeQlSl+krxPjyAueaZ36Y+jkkd1T+iGyX3fbSJw9nrFS4BrJufrzhUIZdVzTBXa8M0AIh9eha1tCWeo4MQwRF3IDRJJ4iPtOMSH4j3rDA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AnCtHntQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EDBC4CEF1;
	Mon, 15 Sep 2025 23:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757979769;
	bh=jZaEOziBglpDbUCJBMp8aBXcUFCv9ylBZH717KvszyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AnCtHntQV2wzjjVOmP7rYmJTYXrxHdpQNyC9lYZE3PU+JqtgKPEoQINB57cW+RvAU
	 N6E1+flXLdPkwdQGvd/3aobMeQFKOVIOXF4PA41hCKK4Dgw/SHpKYvv9l8NbY5c2zx
	 cF3Nj4j1aHnWP8rfbcVJEr79OfpmS7rIrYZNvvTU=
Date: Mon, 15 Sep 2025 16:42:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Donet Tom <donettom@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Ritesh Harjani
 <ritesh.list@gmail.com>, Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou
 <chengming.zhou@linux.dev>, Wei Yang <richard.weiyang@gmail.com>, Aboorva
 Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Giorgi Tchankvetadze
 <giorgitchankvetadze1997@gmail.com>, stable@vger.kernel.org, Joe Perches
 <joe@perches.com>
Subject: Re: [PATCH v2 1/3] mm/ksm: Fix incorrect KSM counter handling in
 mm_struct during fork
Message-Id: <20250915164248.788601c4dc614913081ec7d7@linux-foundation.org>
In-Reply-To: <4044e7623953d9f4c240d0308cf0b2fe769ee553.1757946863.git.donettom@linux.ibm.com>
References: <cover.1757946863.git.donettom@linux.ibm.com>
	<4044e7623953d9f4c240d0308cf0b2fe769ee553.1757946863.git.donettom@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 20:33:04 +0530 Donet Tom <donettom@linux.ibm.com> wrote:

> Currently, the KSM-related counters in `mm_struct`, such as
> `ksm_merging_pages`, `ksm_rmap_items`, and `ksm_zero_pages`, are
> inherited by the child process during fork. This results in inconsistent
> accounting.
> 
> When a process uses KSM, identical pages are merged and an rmap item is
> created for each merged page. The `ksm_merging_pages` and
> `ksm_rmap_items` counters are updated accordingly. However, after a
> fork, these counters are copied to the child while the corresponding
> rmap items are not. As a result, when the child later triggers an
> unmerge, there are no rmap items present in the child, so the counters
> remain stale, leading to incorrect accounting.
> 
> A similar issue exists with `ksm_zero_pages`, which maintains both a
> global counter and a per-process counter. During fork, the per-process
> counter is inherited by the child, but the global counter is not
> incremented. Since the child also references zero pages, the global
> counter should be updated as well. Otherwise, during zero-page unmerge,
> both the global and per-process counters are decremented, causing the
> global counter to become inconsistent.
> 
> To fix this, ksm_merging_pages and ksm_rmap_items are reset to 0
> during fork, and the global ksm_zero_pages counter is updated with the
> per-process ksm_zero_pages value inherited by the child. This ensures
> that KSM statistics remain accurate and reflect the activity of each
> process correctly.
> 
> Fixes: 7609385337a4 ("ksm: count ksm merging pages for each process")

Linux-v5.19

> Fixes: cb4df4cae4f2 ("ksm: count allocated ksm rmap_items for each process")

Linux-v6.1

> Fixes: e2942062e01d ("ksm: count all zero pages placed by KSM")

Linux-v6.10

> cc: stable@vger.kernel.org # v6.6

So how was Linux-v6.6 arrived at?

I think the most important use for Fixes: is to tell the -stable
maintainers which kernel version(s) we believe should receive the
patch.  So listing multiple Fixes: targets just causes confusion.

Maybe the -stable maintainers parse the "# v6.6" thing, I don't know. 
But providing them with a single Fixes: recommendation is a good thing
either way.

So can you please revisit this and suggest a single Fixes: target which
clarifies your reccomendation?

Thanks.

(Cc Joe.  Should checkpatch say something about this)?

