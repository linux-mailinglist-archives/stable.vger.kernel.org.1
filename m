Return-Path: <stable+bounces-192926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8AAC46136
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 11:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA58A4E60D3
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 10:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794EA305979;
	Mon, 10 Nov 2025 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S0Xsly9W"
X-Original-To: stable@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9E323B60A;
	Mon, 10 Nov 2025 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772131; cv=none; b=TmrzwRjqiP46Ih22zTSrdXmm5zn8Zyk71ENMg+ll/xaOp8zkh3ndFqitgDjB0VIMWOJTZiqlfQqjNgnX9yqvQNV8po/dkI+k2xlW2701bDaJEu9E6aduGLeSUFc+a+sucznVmkvJ9lSjgyD7E2KytQG3TYIQZspw+NWhR6O3T1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772131; c=relaxed/simple;
	bh=Q8IujptSu2LeCXU8JhQKUxaH7FsIZEOd9utsCw4OaiA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CD9lk6tPoYcSw28LO894WEm0xjzpZ0OILJIqUdtlCx+/Iocv2Lp/pLrrC5t7Ab266eH++BTh53AlRvNG9o43YAXEgicDzPcMhtpkBAyjch3WNlsPfNKF8I/ZOty0wqZlkmcXz11f5ul9az1slyWB2tj/MhZ9Fto0MdVR92+62E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S0Xsly9W; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762772124; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=IYGpWxlfS7Ghtlne/3hBnEGQd5/vaVez4+R8iM/BRvc=;
	b=S0Xsly9W6abOUcCOpwfQjpjm12cwEqHwLF0vC24JAfMXWy1cA4AQNyqV8mq+NyusVZA+hAUmL3Ur/9oODTxOqU7AwCsrAIa5B9EJ8QyvC/nXG2l2fO54ao8XkngaeJXCkxdIl7AUP8b/Ki0g1ykuOnmEvm1Lh+ur2EbW37KQn6A=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Ws1z-Vy_1762771801 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Nov 2025 18:50:02 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>,
  linux-mm@kvack.org,  Andrew Morton <akpm@linux-foundation.org>,  Kemeng
 Shi <shikemeng@huaweicloud.com>,  Nhat Pham <nphamcs@gmail.com>,  Baoquan
 He <bhe@redhat.com>,  Barry Song <baohua@kernel.org>,  Chris Li
 <chrisl@kernel.org>,  Johannes Weiner <hannes@cmpxchg.org>,  Yosry Ahmed
 <yosry.ahmed@linux.dev>,  Chengming Zhou <chengming.zhou@linux.dev>,
  Youngjun Park <youngjun.park@lge.com>,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org,  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH] Revert "mm, swap: avoid redundant swap device pinning"
In-Reply-To: <CAMgjq7CTdtjMUUk2YvanL_PMZxS_7+pQhHDP-DjkhDaUhDRjDw@mail.gmail.com>
	(Kairui Song's message of "Mon, 10 Nov 2025 13:32:52 +0800")
References: <20251110-revert-78524b05f1a3-v1-1-88313f2b9b20@tencent.com>
	<875xbiodl2.fsf@DESKTOP-5N7EMDA>
	<CAMgjq7CTdtjMUUk2YvanL_PMZxS_7+pQhHDP-DjkhDaUhDRjDw@mail.gmail.com>
Date: Mon, 10 Nov 2025 18:50:01 +0800
Message-ID: <877bvymaau.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kairui Song <ryncsn@gmail.com> writes:

> On Mon, Nov 10, 2025 at 9:56=E2=80=AFAM Huang, Ying
> <ying.huang@linux.alibaba.com> wrote:
>>
>> Hi, Kairui,
>>
>> Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org> writes:
>>
>> > From: Kairui Song <kasong@tencent.com>
>> >
>> > This reverts commit 78524b05f1a3e16a5d00cc9c6259c41a9d6003ce.
>> >
>> > While reviewing recent leaf entry changes, I noticed that commit
>> > 78524b05f1a3 ("mm, swap: avoid redundant swap device pinning") isn't
>> > correct. It's true that most all callers of __read_swap_cache_async are
>> > already holding a swap entry reference, so the repeated swap device
>> > pinning isn't needed on the same swap device, but it is possible that
>> > VMA readahead (swap_vma_readahead()) may encounter swap entries from a
>> > different swap device when there are multiple swap devices, and call
>> > __read_swap_cache_async without holding a reference to that swap devic=
e.
>> >
>> > So it is possible to cause a UAF if swapoff of device A raced with
>> > swapin on device B, and VMA readahead tries to read swap entries from
>> > device A. It's not easy to trigger but in theory possible to cause real
>> > issues. And besides, that commit made swap more vulnerable to issues
>> > like corrupted page tables.
>> >
>> > Just revert it. __read_swap_cache_async isn't that sensitive to
>> > performance after all, as it's mostly used for SSD/HDD swap devices wi=
th
>> > readahead. SYNCHRONOUS_IO devices may fallback onto it for swap count >
>> > 1 entries, but very soon we will have a new helper and routine for
>> > such devices, so they will never touch this helper or have redundant
>> > swap device reference overhead.
>>
>> Is it better to add get_swap_device() in swap_vma_readahead()?  Whenever
>> we get a swap entry, the first thing we need to do is call
>> get_swap_device() to check the validity of the swap entry and prevent
>> the backing swap device from going under us.  This helps us to avoid
>> checking the validity of the swap entry in every swap function.  Does
>> this sound reasonable?
>
> Hi Ying, thanks for the suggestion!
>
> Yes, that's also a feasible approach.
>
> What I was thinking is that, currently except the readahead path, all
> swapin entry goes through the get_swap_device() helper, that helper
> also helps to mitigate swap entry corruption that may causes OOB or
> NULL deref. Although I think it's really not that helpful at all to
> mitigate page table corruption from the kernel side, but seems not a
> really bad idea to have.
>
> And the code is simpler this way, and seems more suitable for a stable
> & mainline fix. If we want  to add get_swap_device() in
> swap_vma_readahead(), we need to do that for every entry that doesn't
> match the target entry's swap device. The reference overhead is
> trivial compared to readhead and bio layer, and only non
> SYNCHRONOUS_IO devices use this helper (madvise is a special case, we
> may optimize that later). ZRAM may fallback to the readahead path but
> this fallback will be eliminated very soon in swap table p2.

We have 2 choices in general.

1. Add get/put_swap_device() in every swap function.

2. Add get/put_swap_device() in every caller of the swap functions.

Personally, I prefer 2.  It works better in situations like calling
multiple swap functions.  It can reduce duplicated references.  It helps
improve code reasoning and readability.

> Another approach I thought about is that we might want readahead to
> stop when it sees entries from a different swap device. That swap
> device might be ZRAM where VMA readahead is not helpful.
>
> How do you think?

One possible solution is to skip or stop for a swap entry from the
SYNCHRONOUS_IO swap device.

---
Best Regards,
Huang, Ying

