Return-Path: <stable+bounces-146037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0158DAC055F
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 09:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF46E174231
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 07:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C177149C6F;
	Thu, 22 May 2025 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nz7YsQFu"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E7221FB4
	for <stable@vger.kernel.org>; Thu, 22 May 2025 07:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747898063; cv=none; b=Vbvpl2cU7HREfBQZFeePLZ7MSl/uJxHhNN1ZYbEyASqIVXgDc0HKW82E7Liu31XcUoBzCutaLoLRQfFk8YuV70I4f4nRN8XCe3mQuzWUInwazI7WMCumghOFZUy9/akAnRz7g8g+83ZYCKh2giKfVXGlj57+oyfzBsOI7B1m/uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747898063; c=relaxed/simple;
	bh=ZPXMvyJncnOSPn+KFA6L0BPzzxvja+21kaYiqM/017I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rz62Ivh04YIYTKFJq+DQxF3dThsMfPYq6EhB7dFSvcBPWsv0jNGN6UdAaIz7+Kj2dIpZBT8buzhha1cAO9DdSoaxGA+4toPni07sLJkL/2OdN0mCR6LuaPtEwlU+/dwNp0klhIHD01f0+A4Zde9aKYyZmDudrJQwVF/pSGcXBCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nz7YsQFu; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747898056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0y7gJ4cOrVsehNbWughqJepfz7W/QByEig+k3NtHTc=;
	b=nz7YsQFuIa7nrdgDsoaHb7j5MDbfb2+J+cOEDBDeRZuf7qcnUeVSCOOzy8+qs4EbDpvKsf
	OrNFaHUN/ygleWNvCEahkEKcTBttf7Dr+zzUVAYbTT8hTcBXAPdx9TTMLxLHb44MqT9ofJ
	eEb8Kg5FOQEoplq4md8QS9CjVRtevMA=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] mm/hugetlb: fix kernel NULL pointer dereference when
 replacing free hugetlb folios
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <aC63fmFKK84K7YiZ@localhost.localdomain>
Date: Thu, 22 May 2025 15:13:31 +0800
Cc: yangge1116@126.com,
 akpm@linux-foundation.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 21cnbao@gmail.com,
 david@redhat.com,
 baolin.wang@linux.alibaba.com,
 liuzixing@hygon.cn
Content-Transfer-Encoding: quoted-printable
Message-Id: <065093C4-3599-456F-84B7-EDCC1A3E8AFC@linux.dev>
References: <1747884137-26685-1-git-send-email-yangge1116@126.com>
 <644FF836-9DC7-42B4-BACE-C433E637B885@linux.dev>
 <aC63fmFKK84K7YiZ@localhost.localdomain>
To: Oscar Salvador <osalvador@suse.de>
X-Migadu-Flow: FLOW_OUT



> On May 22, 2025, at 13:34, Oscar Salvador <osalvador@suse.de> wrote:
>=20
> On Thu, May 22, 2025 at 11:47:05AM +0800, Muchun Song wrote:
>> Thanks for fixing this problem. BTW, in order to catch future similar =
problem,
>> it is better to add WARN_ON into folio_hstate() to assert if =
hugetlb_lock
>> is not held when folio's reference count is zero. For this fix, LGTM.
>=20
> Why cannot we put all the burden in =
alloc_and_dissolve_hugetlb_folio(),
> which will again check things under the lock?

I've also considered about this choice, because there is another similar
case in isolate_or_dissolve_huge_page() which could benefit from this
change. I am fine with both approaches. Anyway, adding an assertion into
folio_hstate() is an improvement for capturing invalid users in the =
future.
Because any user of folio_hstate() should hold a reference to folio or
hold the hugetlb_lock to make sure it returns a valid hstate for a =
hugetlb
folio.

Muchun,
Thanks.

> I mean, I would be ok to save cycles and check upfront in
> replace_free_hugepage_folios(), but the latter has only one user which
> is alloc_contig_range(), which is not really an expected-to-be =
optimized
> function.
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index bd8971388236..b4d937732256 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2924,13 +2924,6 @@ int replace_free_hugepage_folios(unsigned long =
start_pfn, unsigned long end_pfn)
>=20
>   	while (start_pfn < end_pfn) {
>   		folio =3D pfn_folio(start_pfn);
> - 		if (folio_test_hugetlb(folio)) {
> - 			h =3D folio_hstate(folio);
> - 		} else {
> - 			start_pfn++;
> - 			continue;
> - 		}
> -
>   		if (!folio_ref_count(folio)) {
>   			ret =3D alloc_and_dissolve_hugetlb_folio(h, =
folio,
>         						&isolate_list);
>=20
>=20
>=20
> --=20
> Oscar Salvador
> SUSE Labs


