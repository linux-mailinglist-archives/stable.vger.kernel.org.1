Return-Path: <stable+bounces-121338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A050A55DB0
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 03:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715E618965B4
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 02:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBC0188904;
	Fri,  7 Mar 2025 02:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D1qIFAev"
X-Original-To: stable@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7177717E45B
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 02:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741314565; cv=none; b=rDlfhMOlwhg3lxxh7DdhBcmpVDLocrsfq/agg4/1k9OuCS4wF9a9kr5E0U8jc/YU2UBQ95UszHIBChhdJr+G/l9ddeHirBXpOAsOXd9F8kZyuUrjY9hV5PiATjA2HK0+HVc7me4UU62WKbE2AKk80I/Ht6FyIu7OUj75X2dWpmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741314565; c=relaxed/simple;
	bh=TiywCEGjGXVyJ7rV06IXU3+OqvQV2e3a/X7hTHzQJi8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PzVF+bEE/9pp2AtqEUazXDValBRZ32/UjjOV/Lwth3R6CxZBodcbxaz2l6Yv0Pf4aKIe4Ip+ZSw6ahZNvgpuvwFOye+sTiKvvmASVDRfjAQo6FUrcvII7CxgfSKB2vQj+l9QUjtklFf70g/CKcvtDG0FMEtp5bwcFyRLBz6XCtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D1qIFAev; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741314550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S5iiMgCTiEWsFPEP57NRn/hQnxZm6wGqGwBHu+DParc=;
	b=D1qIFAevA+kRZFqH55xQgQ9Oy1gk21CRqrHc9OFwXYZnEH3IyI441NbgZL/Fmwt0qUxRP3
	c9nPcho1Ar6IS85NSOm2bIxPBtPSVOZ2kG417PPbrd2AX7LkPsWLEfCTZKdG3kdFIsOwP1
	VpfBvzOFJ0UFGmA74Qdua5n4pHCiR6g=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] mm: memcontrol: fix swap counter leak from offline cgroup
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20250306143735.GB290530@cmpxchg.org>
Date: Fri, 7 Mar 2025 10:28:32 +0800
Cc: Kairui Song <ryncsn@gmail.com>,
 Muchun Song <songmuchun@bytedance.com>,
 mhocko@kernel.org,
 roman.gushchin@linux.dev,
 shakeel.butt@linux.dev,
 akpm@linux-foundation.org,
 chrisl@kernel.org,
 linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A4994942-1844-4F51-BF23-08848E069484@linux.dev>
References: <20250306023133.44838-1-songmuchun@bytedance.com>
 <CAMgjq7B5SyqYFbLhbgNCvQejqxVs5C6SaV_iot4P64EZLHZ8Gg@mail.gmail.com>
 <20250306143735.GB290530@cmpxchg.org>
To: Johannes Weiner <hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT



> On Mar 6, 2025, at 22:37, Johannes Weiner <hannes@cmpxchg.org> wrote:
>=20
> On Thu, Mar 06, 2025 at 10:54:12AM +0800, Kairui Song wrote:
>> On Thu, Mar 6, 2025 at 10:32=E2=80=AFAM Muchun Song =
<songmuchun@bytedance.com> wrote:
>>>=20
>>> The commit 6769183166b3 has removed the parameter of id from
>>> swap_cgroup_record() and get the memcg id from
>>> mem_cgroup_id(folio_memcg(folio)). However, the caller of it
>>> may update a different memcg's counter instead of
>>> folio_memcg(folio). E.g. in the caller of mem_cgroup_swapout(),
>>> @swap_memcg could be different with @memcg and update the counter
>>> of @swap_memcg, but swap_cgroup_record() records the wrong memcg's
>>> ID. When it is uncharged from __mem_cgroup_uncharge_swap(), the
>>> swap counter will leak since the wrong recorded ID. Fix it by
>>> bring the parameter of id back.
>>>=20
>>> Fixes: 6769183166b3 ("mm/swap_cgroup: decouple swap cgroup recording =
and clearing")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>=20
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>=20
> Looking at the original commit again, we also should do this:
>=20
> ---
>=20
> =46rom 2685ca87d73d0c2b91cfd6959e381a40db235119 Mon Sep 17 00:00:00 =
2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Thu, 6 Mar 2025 09:31:42 -0500
> Subject: [PATCH] mm: swap_cgroup: remove double initialization of =
locals
>=20
> Fixes: 6769183166b3 ("mm/swap_cgroup: decouple swap cgroup recording =
and clearing")
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Yes.

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.

> ---
> mm/swap_cgroup.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> index 1007c30f12e2..de779fed8c21 100644
> --- a/mm/swap_cgroup.c
> +++ b/mm/swap_cgroup.c
> @@ -92,8 +92,7 @@ void swap_cgroup_record(struct folio *folio, =
unsigned short id,
>  */
> unsigned short swap_cgroup_clear(swp_entry_t ent, unsigned int =
nr_ents)
> {
> - 	pgoff_t offset =3D swp_offset(ent);
> - 	pgoff_t end =3D offset + nr_ents;
> + 	pgoff_t offset, end;
> 	struct swap_cgroup *map;
> 	unsigned short old, iter =3D 0;
>=20
> --=20
> 2.48.1



