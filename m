Return-Path: <stable+bounces-165662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A604FB1716A
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 14:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E02A7AA63C
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 12:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7A029DB81;
	Thu, 31 Jul 2025 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yxrM5q7F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CCB23ABB7
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753965699; cv=none; b=Ir/E1z+e7JP0crHz7vdfcux8+8u0Z7raOWphenB/Cc65cRS+TFZzmjN3fomBM5+c2C5SF8kXHl/yxQzxieIAGnloOaD7ES1+qc7HtNxDH+YHIXzWQsWh4RdxPxB5noGIULCAMPLUuyGE8q9TkKb1lYmjwSd+xACsNzYkURQULBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753965699; c=relaxed/simple;
	bh=bD0HKxme1JTSpYqCQrpQOjIcZyY5tlyQ9UEBBftzPps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhHc+ewhtWkl62qEi1msKNzhb2t1ym8cdxLoqMtPFCMkhSHgXLm7JPaU8nA0ElJVKY686TOaqqx1lB05stTat7un/ZgBO+y7d7/+25gtQ/HFqEh+5X4NPoWvkZHFsvSymVr4cILNx/5TVioI3WSKr47zOZCXAqKW96Slzvp2IdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yxrM5q7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E323C4CEEF;
	Thu, 31 Jul 2025 12:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753965698;
	bh=bD0HKxme1JTSpYqCQrpQOjIcZyY5tlyQ9UEBBftzPps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yxrM5q7FqOZSkOeDTZIweeKQFm3fifIYHKrTJOiDK8Hvicqs6DxLSN3YC03l5yqGp
	 dewlELuXrWjIOhDDljTS0/vLDd6z4DMT49ECM9z/gRDamGabNDeew9xYUd7aMrU/6A
	 nbtM73m9dhk3O7XCeB2NKp52gieZVGUGbZR7Z0zo=
Date: Thu, 31 Jul 2025 14:41:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	Robert Pang <robertpang@google.com>, Coly Li <colyli@kernel.org>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y] Revert "bcache: remove heap-related macros and
 switch to generic min_heap"
Message-ID: <2025073126-stapling-glitzy-225a@gregkh>
References: <20250731123819.31647-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731123819.31647-1-visitorckw@gmail.com>

On Thu, Jul 31, 2025 at 08:38:19PM +0800, Kuan-Wei Chiu wrote:
> This reverts commit 866898efbb25bb44fd42848318e46db9e785973a.
> 
> The generic bottom-up min_heap implementation causes performance
> regression in invalidate_buckets_lru(), a hot path in bcache.  Before the
> cache is fully populated, new_bucket_prio() often returns zero, leading to
> many equal comparisons.  In such cases, bottom-up sift_down performs up to
> 2 * log2(n) comparisons, while the original top-down approach completes
> with just O() comparisons, resulting in a measurable performance gap.
> 
> The performance degradation is further worsened by the non-inlined
> min_heap API functions introduced in commit 92a8b224b833 ("lib/min_heap:
> introduce non-inline versions of min heap API functions"), adding function
> call overhead to this critical path.
> 
> As reported by Robert, bcache now suffers from latency spikes, with P100
> (max) latency increasing from 600 ms to 2.4 seconds every 5 minutes.
> These regressions degrade bcache's effectiveness as a low-latency cache
> layer and lead to frequent timeouts and application stalls in production
> environments.
> 
> This revert aims to restore bcache's original low-latency behavior.
> 
> Link: https://lore.kernel.org/lkml/CAJhEC05+0S69z+3+FB2Cd0hD+pCRyWTKLEOsc8BOmH73p1m+KQ@mail.gmail.com
> Link: https://lkml.kernel.org/r/20250614202353.1632957-3-visitorckw@gmail.com
> Fixes: 866898efbb25 ("bcache: remove heap-related macros and switch to generic min_heap")
> Fixes: 92a8b224b833 ("lib/min_heap: introduce non-inline versions of min heap API functions")
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Reported-by: Robert Pang <robertpang@google.com>
> Closes: https://lore.kernel.org/linux-bcache/CAJhEC06F_AtrPgw2-7CvCqZgeStgCtitbD-ryuPpXQA-JG5XXw@mail.gmail.com
> Acked-by: Coly Li <colyli@kernel.org>
> Cc: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  drivers/md/bcache/alloc.c     |  64 +++++-------------
>  drivers/md/bcache/bcache.h    |   2 +-
>  drivers/md/bcache/bset.c      | 124 ++++++++++++----------------------
>  drivers/md/bcache/bset.h      |  40 ++++++-----
>  drivers/md/bcache/btree.c     |  69 ++++++++-----------
>  drivers/md/bcache/extents.c   |  53 ++++++---------
>  drivers/md/bcache/movinggc.c  |  41 +++--------
>  drivers/md/bcache/super.c     |   3 +-
>  drivers/md/bcache/sysfs.c     |   4 +-
>  drivers/md/bcache/util.h      |  67 +++++++++++++++++-
>  drivers/md/bcache/writeback.c |  13 ++--
>  11 files changed, 217 insertions(+), 263 deletions(-)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

