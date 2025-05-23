Return-Path: <stable+bounces-146153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EE2AC1AD6
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 05:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDFF3B1569
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 03:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EF317ADF8;
	Fri, 23 May 2025 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S9OzoP15"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D502DCBE7
	for <stable@vger.kernel.org>; Fri, 23 May 2025 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747972631; cv=none; b=GbM8SFewL1WrDgZgMzCd7uYY3c1P9YL1qCPOsUsXop+c18lPI75dB5GS3SMpOSvmHFmbxi1Z5urlLOkSTP4myPj/eov+4iE7HZW0QJShZP1mAcZD4IW/5prOe+gFRvs+ay9BSZOtgpqqR/uQok0z3RXlgX8xhz77zkwx+gv/xZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747972631; c=relaxed/simple;
	bh=1wmftH4+1CyP4uZ75vOAyuBVMc6P1BmvNKUb+IESNQc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nwG2iuJ6HnaeUWhRsHpxd502XuQcz8/NTJcF7gZDSEuayvMr4glwgztD0DrOTIXwaSw302bDxXLHYWOIQdHs3SlYPyQfap8GJWp2FgUnbtPFhypNKZt1d9DyTo3Z61Kn4Gly6wOgnv1Nkob0x/57wtpqHnnmfENzjQhGxFoDmeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S9OzoP15; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747972614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u6qNdPv7J8gfgypOptH2B2wxSfGN00CcXcZhVQxMpKw=;
	b=S9OzoP15OwVpDAPDuHOpq6gcuxnTztYLM95nwFD4B9AK0NZwuCkeMbRE0EBh8cROyAudfN
	T88Cj2bQRKe0iodB9Lo34vZXtKv8Zoa2alqS/LtQ+5NS4kLuvg4xwkpuyC996wzkPdrQ1s
	DL+c8yhMEtO6U1+kbnDaI1lCJxj1EMM=
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
In-Reply-To: <4e408146-7c77-4f6d-90e8-bb311d7ab53d@126.com>
Date: Fri, 23 May 2025 11:56:11 +0800
Cc: Oscar Salvador <osalvador@suse.de>,
 akpm@linux-foundation.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 21cnbao@gmail.com,
 david@redhat.com,
 baolin.wang@linux.alibaba.com,
 liuzixing@hygon.cn
Content-Transfer-Encoding: quoted-printable
Message-Id: <299A777D-DC94-4724-BAD7-DD02F7CDBAFA@linux.dev>
References: <1747884137-26685-1-git-send-email-yangge1116@126.com>
 <644FF836-9DC7-42B4-BACE-C433E637B885@linux.dev>
 <aC63fmFKK84K7YiZ@localhost.localdomain>
 <ff6bd560-d249-418f-81f4-7cbe055a25ec@126.com>
 <aC8PRkyd3y74Ph5R@localhost.localdomain>
 <3B8641A1-5345-44A5-B610-9BCBC980493D@linux.dev>
 <aC974OtOuj9Tqzsa@localhost.localdomain>
 <DF103E57-601C-4CBB-99CA-088E1C29F517@linux.dev>
 <4e408146-7c77-4f6d-90e8-bb311d7ab53d@126.com>
To: Ge Yang <yangge1116@126.com>
X-Migadu-Flow: FLOW_OUT



> On May 23, 2025, at 11:46, Ge Yang <yangge1116@126.com> wrote:
>=20
>=20
>=20
> =E5=9C=A8 2025/5/23 11:27, Muchun Song =E5=86=99=E9=81=93:
>>> On May 23, 2025, at 03:32, Oscar Salvador <osalvador@suse.de> wrote:
>>>=20
>>> On Thu, May 22, 2025 at 08:39:39PM +0800, Muchun Song wrote:
>>>> But I think we could use "folio_order() > MAX_PAGE_ORDER" to =
replace the check
>>>> of hstate_is_gigantic(), right? Then ee could remove the first =
parameter of hstate
>>>> from alloc_and_dissolve_hugetlb_folio() and obtain hstate in it.
>>>=20
>>> Yes, I think we can do that.
>>> So something like the following (compily-tested only) maybe?
>>>=20
>>> =46rom d7199339e905f83b54d22849e8f21f631916ce94 Mon Sep 17 00:00:00 =
2001
>>> From: Oscar Salvador <osalvador@suse.de>
>>> Date: Thu, 22 May 2025 19:51:04 +0200
>>> Subject: [PATCH] TMP
>>>=20
>>> ---
>>>  mm/hugetlb.c | 38 +++++++++-----------------------------
>>>  1 file changed, 9 insertions(+), 29 deletions(-)
>> Pretty simple. The code LGTM.
>> Thanks.
>=20
> Thanks.
>=20
> The implementation of alloc_and_dissolve_hugetlb_folio differs between =
kernel 6.6 and kernel 6.15. To facilitate backporting, I'm planning to =
submit another patch based on Oscar Salvador's suggestion.

A separate improving patch LGTM.

>=20


