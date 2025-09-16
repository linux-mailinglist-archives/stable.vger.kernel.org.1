Return-Path: <stable+bounces-179680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC9AB58CD5
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 06:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3E91B27369
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 04:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E056D8287E;
	Tue, 16 Sep 2025 04:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UA4pT+Xx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBE92A1CF;
	Tue, 16 Sep 2025 04:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757997191; cv=none; b=NbQ0nVWWm7IdA5iFchW2rzMGTxfNi/SAy2ODhlweg3HAfyhDNZgjhXew/up9wWK1bis+vgB67a/u4nNrQT0nVPEXKu92ENW+TTMEYGizmKJe/nC6deUe/8cHCHxC6+ARPOSKJb8zvaV1N+Xae4snUTQLBZkkQCUFTkOvjmB1F/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757997191; c=relaxed/simple;
	bh=XUv2PggEgcd7aiSvIefqjmLXrdWBq5ZtfvsjcSnF6Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlZLfVGQksd9lEltBSL+p0VvyboS07thVd68EeiQqzjYLwWBfp8yYah5LVJMJskKjKcjUC2K48kwYklfoyE4RwI/6lfedLeKHUihsipoIH2gp8HPVa/1ZEm569yXaYWbHUwD/JPhoGllLlYZvZYGJG0T3Pgp9WKtpx+C8UqE1UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UA4pT+Xx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA138C4CEEB;
	Tue, 16 Sep 2025 04:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757997191;
	bh=XUv2PggEgcd7aiSvIefqjmLXrdWBq5ZtfvsjcSnF6Ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UA4pT+XxdcvTwEXm0XQVMVK4IeeqDbY7dO/AZA7fAeL9BZlVOrkBtl9586nWqhkit
	 fEkVxPoPy009mzMJg2WqrM7m5GFCL161QrthTG+XB1OHtQ/sncY+fKBcq9IWtfaFdv
	 4Zos33vOsW2M9yPRjEznTzzxr6vPBWDL5Kiopuql9MOcVGBJ3PrzJOA0RiPiJMwGDp
	 TX3sx9Sqd43Lm344yY4+U2wvV5fYdb00S3j/giclSX62pecxjwbq0lkY/wEzyO2LJQ
	 8bJ7BpxlVNzY/ZtqSab19+Ggpge+n2hOyyJq1VzrYQhCdqldnvwgAa+ANrZJo8Y+Cu
	 zrQw1c1t8/Kmg==
Date: Tue, 16 Sep 2025 00:33:09 -0400
From: Sasha Levin <sashal@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Donet Tom <donettom@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Wei Yang <richard.weiyang@gmail.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
	stable@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 1/3] mm/ksm: Fix incorrect KSM counter handling in
 mm_struct during fork
Message-ID: <aMjohar0r-nffx9V@laps>
References: <cover.1757946863.git.donettom@linux.ibm.com>
 <4044e7623953d9f4c240d0308cf0b2fe769ee553.1757946863.git.donettom@linux.ibm.com>
 <20250915164248.788601c4dc614913081ec7d7@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250915164248.788601c4dc614913081ec7d7@linux-foundation.org>

On Mon, Sep 15, 2025 at 04:42:48PM -0700, Andrew Morton wrote:
>On Mon, 15 Sep 2025 20:33:04 +0530 Donet Tom <donettom@linux.ibm.com> wrote:
>
>> Currently, the KSM-related counters in `mm_struct`, such as
>> `ksm_merging_pages`, `ksm_rmap_items`, and `ksm_zero_pages`, are
>> inherited by the child process during fork. This results in inconsistent
>> accounting.
>>
>> When a process uses KSM, identical pages are merged and an rmap item is
>> created for each merged page. The `ksm_merging_pages` and
>> `ksm_rmap_items` counters are updated accordingly. However, after a
>> fork, these counters are copied to the child while the corresponding
>> rmap items are not. As a result, when the child later triggers an
>> unmerge, there are no rmap items present in the child, so the counters
>> remain stale, leading to incorrect accounting.
>>
>> A similar issue exists with `ksm_zero_pages`, which maintains both a
>> global counter and a per-process counter. During fork, the per-process
>> counter is inherited by the child, but the global counter is not
>> incremented. Since the child also references zero pages, the global
>> counter should be updated as well. Otherwise, during zero-page unmerge,
>> both the global and per-process counters are decremented, causing the
>> global counter to become inconsistent.
>>
>> To fix this, ksm_merging_pages and ksm_rmap_items are reset to 0
>> during fork, and the global ksm_zero_pages counter is updated with the
>> per-process ksm_zero_pages value inherited by the child. This ensures
>> that KSM statistics remain accurate and reflect the activity of each
>> process correctly.
>>
>> Fixes: 7609385337a4 ("ksm: count ksm merging pages for each process")
>
>Linux-v5.19
>
>> Fixes: cb4df4cae4f2 ("ksm: count allocated ksm rmap_items for each process")
>
>Linux-v6.1
>
>> Fixes: e2942062e01d ("ksm: count all zero pages placed by KSM")
>
>Linux-v6.10
>
>> cc: stable@vger.kernel.org # v6.6
>
>So how was Linux-v6.6 arrived at?

e2942062e01d is in v6.6, not in v6.10 - I suspect that this is why the "# v6.6"
part was added.

>I think the most important use for Fixes: is to tell the -stable
>maintainers which kernel version(s) we believe should receive the
>patch.  So listing multiple Fixes: targets just causes confusion.

Right - there's no way of communicating if all the commits listed in multiple
Fixes tags should exist in the tree, or any one of them, for the new fix to be
applicable.

-- 
Thanks,
Sasha

