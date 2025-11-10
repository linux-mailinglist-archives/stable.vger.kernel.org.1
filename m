Return-Path: <stable+bounces-192884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5942BC44C2A
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 03:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26664188BCF8
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 02:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AF3212F98;
	Mon, 10 Nov 2025 02:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HlIGB8AS"
X-Original-To: stable@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7B842AA9;
	Mon, 10 Nov 2025 02:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762740730; cv=none; b=dvy47Of0L0IC50GNdTocn3ic0RmDcpQdGubmpiicnQ1lKgDBMeU9fpo6pqqlsFGo3KmQs+EnPiaDGIBxWR+lgShckPWKeryYEAnwq8i6P/YAXKK7dMMyQMxrbEvQ4O6WCJ5GLx+CusGnjNvNap1gZ+T4m8J46CzdHllKrrN+S34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762740730; c=relaxed/simple;
	bh=VY1Aa2jKWQ8DhbaDGiVvCPYd4OpwjppIHA7NyUmGw5k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OO1MvWEe5Jg21D+1cf3+3WIqLQ758eXF6WBhdeibgG3ZE4jDkD05kxoyiTxvGyzd95i4epUckbaIyQSNWylWAVpjsUqlyUEyk04VVN5/9TacQbf9by5EzdurlLdzjms8WPIIDB2z7NQwF5VCTKzg4POjbfdrM2bfzbsZFO2siPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HlIGB8AS; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762740719; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=h2Vc1MCnbF/ttJ2+MkLrZKM08vvpbJ9pspqnCXu4l4I=;
	b=HlIGB8ASJ7rHoXQy+eClzh/5fVjhWG/ekEp04HGdmN4Wn1q7QZEeRs3cEXkUdKqMgyYtw8yY+5tnAM8mYMpjpyrK2HMJAK0K2XODOPNwrSqRa/QDWbO+D0hF33GE3eN5DwxIW+PkaDCTo0T2496IahGVIQLm2BFllWKXfI+rX8M=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wrz7d2o_1762739770 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Nov 2025 09:56:19 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Cc: linux-mm@kvack.org,  kasong@tencent.com,  Andrew Morton
 <akpm@linux-foundation.org>,  Kemeng Shi <shikemeng@huaweicloud.com>,
  Nhat Pham <nphamcs@gmail.com>,  Baoquan He <bhe@redhat.com>,  Barry Song
 <baohua@kernel.org>,  Chris Li <chrisl@kernel.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Yosry Ahmed <yosry.ahmed@linux.dev>,  Chengming
 Zhou <chengming.zhou@linux.dev>,  Youngjun Park <youngjun.park@lge.com>,
  Kairui Song <ryncsn@gmail.com>,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH] Revert "mm, swap: avoid redundant swap device pinning"
In-Reply-To: <20251110-revert-78524b05f1a3-v1-1-88313f2b9b20@tencent.com>
	(Kairui Song via's message of "Mon, 10 Nov 2025 02:06:03 +0800")
References: <20251110-revert-78524b05f1a3-v1-1-88313f2b9b20@tencent.com>
Date: Mon, 10 Nov 2025 09:56:09 +0800
Message-ID: <875xbiodl2.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Kairui,

Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org> writes:

> From: Kairui Song <kasong@tencent.com>
>
> This reverts commit 78524b05f1a3e16a5d00cc9c6259c41a9d6003ce.
>
> While reviewing recent leaf entry changes, I noticed that commit
> 78524b05f1a3 ("mm, swap: avoid redundant swap device pinning") isn't
> correct. It's true that most all callers of __read_swap_cache_async are
> already holding a swap entry reference, so the repeated swap device
> pinning isn't needed on the same swap device, but it is possible that
> VMA readahead (swap_vma_readahead()) may encounter swap entries from a
> different swap device when there are multiple swap devices, and call
> __read_swap_cache_async without holding a reference to that swap device.
>
> So it is possible to cause a UAF if swapoff of device A raced with
> swapin on device B, and VMA readahead tries to read swap entries from
> device A. It's not easy to trigger but in theory possible to cause real
> issues. And besides, that commit made swap more vulnerable to issues
> like corrupted page tables.
>
> Just revert it. __read_swap_cache_async isn't that sensitive to
> performance after all, as it's mostly used for SSD/HDD swap devices with
> readahead. SYNCHRONOUS_IO devices may fallback onto it for swap count >
> 1 entries, but very soon we will have a new helper and routine for
> such devices, so they will never touch this helper or have redundant
> swap device reference overhead.

Is it better to add get_swap_device() in swap_vma_readahead()?  Whenever
we get a swap entry, the first thing we need to do is call
get_swap_device() to check the validity of the swap entry and prevent
the backing swap device from going under us.  This helps us to avoid
checking the validity of the swap entry in every swap function.  Does
this sound reasonable?

> Fixes: 78524b05f1a3 ("mm, swap: avoid redundant swap device pinning")
> Signed-off-by: Kairui Song <kasong@tencent.com>

[snip]

---
Best Regards,
Huang, Ying

