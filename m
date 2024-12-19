Return-Path: <stable+bounces-105348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E81D89F837A
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 19:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14E1188A94E
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 18:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FC21A3BA1;
	Thu, 19 Dec 2024 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fW/L2Nsx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F16D19F43B;
	Thu, 19 Dec 2024 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734633785; cv=none; b=QFnSHycZ6p31ycyUcc3JNBSFTd/vO3P9X1/P8gsJMhsMhCokn1UzDgydcruBnQ1wLuSrwW40egpaMOJUghUdQLHGFL+/mIUUuJTKd/jX0XTSMtH+qqxu3ieZdNuraYCBYW6ct7wAocZZ+0yR7QbF1RL82RWfxTYJTMoEspp0RKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734633785; c=relaxed/simple;
	bh=mKNSTQ0nCK2Xknz+TuQ8UROuFq8WTO0dLrlz10TFyNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mf2LJOEjkKq7CKXlGFgNYvqXH4/WVKbIykiZQekjAxT0xVvLtozC42AHJPtFKZ4Asnnw4Zsd9luWCj7jUY7KyqN2i/3TrXcu1I/5e+nogkAtPjNe2OASKpCzWgMHkrMi01jLEv6Y9dKAdK5Hafm7VIylH40mkPx1QUiZYRlRcWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fW/L2Nsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBD6C4CECE;
	Thu, 19 Dec 2024 18:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734633784;
	bh=mKNSTQ0nCK2Xknz+TuQ8UROuFq8WTO0dLrlz10TFyNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fW/L2Nsxf6w+J8agIFM1jHCwVwXmTkstwwrKI5xzRsWvlRdx34A7HKO8V1jkqAPxv
	 42yQvHzeEcQkd3ujQnTX1Yr8dmmqW/VYeuzZoYKj8pxM/ofXAkFbCq0ncaKlyCPp7q
	 8K8x4Ft1grDCKECOIm7Yf+VlkI3uAMHb8YiunvaGb6NZVyLgXH0Pw81plVyWW4/czZ
	 rOmVYMuJz8vZzH2JPLiC9XxshG9MnmyDhU3G8cXZHTgj4+O5qPWYkoP+6S5PmA/Ape
	 F1x61mwdD82bRrHGpNdKBO9ZwO5GY22xRv7Yt9Ciw87N+YDBs53N7/N/JkKBGBH9RA
	 I937KzlVHs61w==
From: SeongJae Park <sj@kernel.org>
To: yangge1116@126.com
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	21cnbao@gmail.com,
	david@redhat.com,
	baolin.wang@linux.alibaba.com,
	muchun.song@linux.dev,
	liuzixing@hygon.cn
Subject: Re: [PATCH] replace free hugepage folios after migration
Date: Thu, 19 Dec 2024 10:43:01 -0800
Message-Id: <20241219184301.63011-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <1734503588-16254-1-git-send-email-yangge1116@126.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Wed, 18 Dec 2024 14:33:08 +0800 yangge1116@126.com wrote:

[...]
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ae4fe86..7d36ac8 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -681,6 +681,7 @@ struct huge_bootmem_page {
>  };
>  
>  int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
> +int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
>  struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  				unsigned long addr, int avoid_reserve);
>  struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
> @@ -1059,6 +1060,11 @@ static inline int isolate_or_dissolve_huge_page(struct page *page,
>  	return -ENOMEM;
>  }
>  
> +int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn)
> +{
> +	return 0;
> +}
> +

I think this should be static inline.  Otherwise, build fails when
CONFIG_HUGETLB_PAGE is unset.  Since this is already merged into mm-unstable
and the problem and fix seems straigthforward, I directly sent my fix:
https://lore.kernel.org/20241219183753.62922-1-sj@kernel.org


Thanks,
SJ

[...]

