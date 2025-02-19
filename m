Return-Path: <stable+bounces-116956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130C6A3B02C
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 04:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2491F188C7CE
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 03:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A440E189F3B;
	Wed, 19 Feb 2025 03:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U4lKHWWr"
X-Original-To: stable@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355D68C0B
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 03:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739937042; cv=none; b=lCSMOLKze7OCRSzYgxU6DsG3LRgZgNE5PW7gmBLwLfmncl+zEc4bKSwnWibXhNrcQG/XgsDY+S0RzwxvJBDqSgPMwJVKCXGek3BS0puYbeNaqKgCKVdssD32rFZr0c/3Mxe18Z9KaSYqGBjeQlWG66i7685yWIqhGTBdYHYTZFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739937042; c=relaxed/simple;
	bh=J8+NPZwTw8bslS0dqKvL9vPv+Cqwy7Gi7z+qq6XDXAU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=miku73S/GoB9h2Iui+SMbNTWqtL/vJM91ximPwucjo4dkiJueRL9PMfIOjbwIu03QOeAPlLMv69XCN6VrMzrASd0e1mEL2si+Mtlmtwe1JoarDNFuX0QVMklxqpOGzvniHOZ08bXorZ4gjX3XyuopBaZyoBNwlOG91jovJXpmhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U4lKHWWr; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739937036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+mTZtKiZbGjUlF//qydZXq9I7TGlMAO3W6yY9azH3lk=;
	b=U4lKHWWrRTAt+1u9ZvH2qjJeFRMKnGlVYnfmPMhDK5kXTuxn91feHvigeA+D6nGpHxqjf/
	rSUq49Cow9bhTvx/R4AXLTgWmLOARvhEUGp+F1+PL/z67+cO5LQ1s5mQpjfrgT8qMbriEW
	t8c02WOCwhRjUi15bOEz7v/tiBWlbik=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH V4] mm/hugetlb: wait for hugetlb folios to be freed
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <1739936804-18199-1-git-send-email-yangge1116@126.com>
Date: Wed, 19 Feb 2025 11:49:57 +0800
Cc: akpm@linux-foundation.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 21cnbao@gmail.com,
 david@redhat.com,
 baolin.wang@linux.alibaba.com,
 osalvador@suse.de,
 liuzixing@hygon.cn
Content-Transfer-Encoding: quoted-printable
Message-Id: <1C15A7E5-D78A-40DA-B7C5-3F49E790AC58@linux.dev>
References: <1739936804-18199-1-git-send-email-yangge1116@126.com>
To: yangge1116@126.com
X-Migadu-Flow: FLOW_OUT



> On Feb 19, 2025, at 11:46, yangge1116@126.com wrote:
>=20
> From: Ge Yang <yangge1116@126.com>
>=20
> Since the introduction of commit c77c0a8ac4c52 ("mm/hugetlb: defer =
freeing
> of huge pages if in non-task context"), which supports deferring the
> freeing of hugetlb pages, the allocation of contiguous memory through
> cma_alloc() may fail probabilistically.
>=20
> In the CMA allocation process, if it is found that the CMA area is =
occupied
> by in-use hugetlb folios, these in-use hugetlb folios need to be =
migrated
> to another location. When there are no available hugetlb folios in the
> free hugetlb pool during the migration of in-use hugetlb folios, new =
folios
> are allocated from the buddy system. A temporary state is set on the =
newly
> allocated folio. Upon completion of the hugetlb folio migration, the
> temporary state is transferred from the new folios to the old folios.
> Normally, when the old folios with the temporary state are freed, it =
is
> directly released back to the buddy system. However, due to the =
deferred
> freeing of hugetlb pages, the PageBuddy() check fails, ultimately =
leading
> to the failure of cma_alloc().
>=20
> Here is a simplified call trace illustrating the process:
> cma_alloc()
>    ->__alloc_contig_migrate_range() // Migrate in-use hugetlb folios
>        ->unmap_and_move_huge_page()
>            ->folio_putback_hugetlb() // Free old folios
>    ->test_pages_isolated()
>        ->__test_page_isolated_in_pageblock()
>             ->PageBuddy(page) // Check if the page is in buddy
>=20
> To resolve this issue, we have implemented a function named
> wait_for_freed_hugetlb_folios(). This function ensures that the =
hugetlb
> folios are properly released back to the buddy system after their =
migration
> is completed. By invoking wait_for_freed_hugetlb_folios() before =
calling
> PageBuddy(), we ensure that PageBuddy() will succeed.
>=20
> Fixes: c77c0a8ac4c52 ("mm/hugetlb: defer freeing of huge pages if in =
non-task context")
> Signed-off-by: Ge Yang <yangge1116@126.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


