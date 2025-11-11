Return-Path: <stable+bounces-194444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F022C4BBE4
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 07:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4AB1884477
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 06:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC9D32AAB9;
	Tue, 11 Nov 2025 06:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JzOUtCoe"
X-Original-To: stable@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB01279358;
	Tue, 11 Nov 2025 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844009; cv=none; b=ghR8XFXqqat5OVf69v9dl1fDIpPuuYIezlL8t1dFLx+wK0gU0+56zuglNvN7AckbuCgvX1YQQ9NBA7asL3aajoEae1+RLZL1R+XGLcA/biQbd6Wxnzsclwhl8pRfYuERvTn8u7H26FAAMA7NGTmikE4TMJ0W9odWj3VPKrgIBD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844009; c=relaxed/simple;
	bh=J6oK6+SeKxBrOPBo6r3183CAPm2M7ajgYMs0yyZy1Cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZJmG7oHKixmRjSJJMGB8Vbfkgp/27gCleYzi541fh88zf1Y+P7jo3PO+d2MmUcrt6bwTsHS68NHXZW/lb+9sbFEJAkEePTxannVw5OeaihtJHMjtwBr3IDRPtRzGQ7maOy6M2mL/s79oxHmLzFwfLeJt6Yqce1vgQzlvjsEfCX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JzOUtCoe; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762844003; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=cvJiQeCWKw1rGFL3Q8oVIkh9JusjXZv2HTeEiaF2AmI=;
	b=JzOUtCoeFcVGF8faGXQJeVUBUlEm4uZVMXwS2KFAA1FGNd/GNXyx40cubHKbCtkRep2KgK1xnljT1WCB46Rgc85CqM51Sd7KC3bhu+BeymT60PSWk/mQopkpRuBy3zt6q3nuQzR6k79tmFsntno8MeoPWqXT3fU+RZHcaAt2OD8=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WsACUYD_1762843681 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Nov 2025 14:48:02 +0800
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
In-Reply-To: <CAMgjq7BsnGFDCVGRQoa+evBdOposnAKM3yKpf5gGykefUvq-mg@mail.gmail.com>
	(Kairui Song's message of "Mon, 10 Nov 2025 19:37:01 +0800")
References: <20251110-revert-78524b05f1a3-v1-1-88313f2b9b20@tencent.com>
	<875xbiodl2.fsf@DESKTOP-5N7EMDA>
	<CAMgjq7CTdtjMUUk2YvanL_PMZxS_7+pQhHDP-DjkhDaUhDRjDw@mail.gmail.com>
	<877bvymaau.fsf@DESKTOP-5N7EMDA>
	<CAMgjq7BsnGFDCVGRQoa+evBdOposnAKM3yKpf5gGykefUvq-mg@mail.gmail.com>
Date: Tue, 11 Nov 2025 14:48:00 +0800
Message-ID: <87h5v1jc9r.fsf@DESKTOP-5N7EMDA>
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

> On Mon, Nov 10, 2025 at 6:50=E2=80=AFPM Huang, Ying
> <ying.huang@linux.alibaba.com> wrote:
>>
>> Kairui Song <ryncsn@gmail.com> writes:
>>
>> > On Mon, Nov 10, 2025 at 9:56=E2=80=AFAM Huang, Ying
>> > <ying.huang@linux.alibaba.com> wrote:
>> >>
>> >> Hi, Kairui,
>> >>
>> >> Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org> writ=
es:
>> >>
>> >> > From: Kairui Song <kasong@tencent.com>
>> >> >
>> >> > This reverts commit 78524b05f1a3e16a5d00cc9c6259c41a9d6003ce.
>> >> >
>> >> > While reviewing recent leaf entry changes, I noticed that commit
>> >> > 78524b05f1a3 ("mm, swap: avoid redundant swap device pinning") isn't
>> >> > correct. It's true that most all callers of __read_swap_cache_async=
 are
>> >> > already holding a swap entry reference, so the repeated swap device
>> >> > pinning isn't needed on the same swap device, but it is possible th=
at
>> >> > VMA readahead (swap_vma_readahead()) may encounter swap entries fro=
m a
>> >> > different swap device when there are multiple swap devices, and call
>> >> > __read_swap_cache_async without holding a reference to that swap de=
vice.
>> >> >
>> >> > So it is possible to cause a UAF if swapoff of device A raced with
>> >> > swapin on device B, and VMA readahead tries to read swap entries fr=
om
>> >> > device A. It's not easy to trigger but in theory possible to cause =
real
>> >> > issues. And besides, that commit made swap more vulnerable to issues
>> >> > like corrupted page tables.
>> >> >
>> >> > Just revert it. __read_swap_cache_async isn't that sensitive to
>> >> > performance after all, as it's mostly used for SSD/HDD swap devices=
 with
>> >> > readahead. SYNCHRONOUS_IO devices may fallback onto it for swap cou=
nt >
>> >> > 1 entries, but very soon we will have a new helper and routine for
>> >> > such devices, so they will never touch this helper or have redundant
>> >> > swap device reference overhead.
>> >>
>> >> Is it better to add get_swap_device() in swap_vma_readahead()?  Whene=
ver
>> >> we get a swap entry, the first thing we need to do is call
>> >> get_swap_device() to check the validity of the swap entry and prevent
>> >> the backing swap device from going under us.  This helps us to avoid
>> >> checking the validity of the swap entry in every swap function.  Does
>> >> this sound reasonable?
>> >
>> > Hi Ying, thanks for the suggestion!
>> >
>> > Yes, that's also a feasible approach.
>> >
>> > What I was thinking is that, currently except the readahead path, all
>> > swapin entry goes through the get_swap_device() helper, that helper
>> > also helps to mitigate swap entry corruption that may causes OOB or
>> > NULL deref. Although I think it's really not that helpful at all to
>> > mitigate page table corruption from the kernel side, but seems not a
>> > really bad idea to have.
>> >
>> > And the code is simpler this way, and seems more suitable for a stable
>> > & mainline fix. If we want  to add get_swap_device() in
>> > swap_vma_readahead(), we need to do that for every entry that doesn't
>> > match the target entry's swap device. The reference overhead is
>> > trivial compared to readhead and bio layer, and only non
>> > SYNCHRONOUS_IO devices use this helper (madvise is a special case, we
>> > may optimize that later). ZRAM may fallback to the readahead path but
>> > this fallback will be eliminated very soon in swap table p2.
>>
>> We have 2 choices in general.
>>
>> 1. Add get/put_swap_device() in every swap function.
>>
>> 2. Add get/put_swap_device() in every caller of the swap functions.
>>
>> Personally, I prefer 2.  It works better in situations like calling
>> multiple swap functions.  It can reduce duplicated references.  It helps
>> improve code reasoning and readability.
>
> Totally agree, that's exactly what the recently added kerneldoc is
> suggesting, caller of the swap function will need to use refcount or
> lock to protect the swap device.
>
> I'm not suggesting to add get/put in every function, just thinking
> that maybe reverting it can have some nice side effects.
>
> But anyway, this fix should also be good:
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 3f85a1c4cfd9..4cca4865627f 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -747,6 +747,7 @@ static struct folio
> *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>
>         blk_start_plug(&plug);
>         for (addr =3D start; addr < end; ilx++, addr +=3D PAGE_SIZE) {
> +               struct swap_info_struct *si =3D NULL;
>                 leaf_entry_t entry;
>
>                 if (!pte++) {
> @@ -761,8 +762,12 @@ static struct folio
> *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>                         continue;
>                 pte_unmap(pte);
>                 pte =3D NULL;
> +               if (swp_type(entry) !=3D swp_type(targ_entry))
> +                       si =3D get_swap_device(entry);
>                 folio =3D __read_swap_cache_async(entry, gfp_mask, mpol, =
ilx,
>                                                 &page_allocated, false);
> +               if (si)
> +                       put_swap_device(si);
>                 if (!folio)
>                         continue;
>                 if (page_allocated) {
>
> I'll post a patch if it looks ok.

LGTM with the NULL check as you said in another email.

---
Best Regards,
Huang, Ying

