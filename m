Return-Path: <stable+bounces-249728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDZVJzEhDWpptgUAu9opvQ
	(envelope-from <stable+bounces-249728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 04:49:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FCC586F30
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 04:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AB24306125E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 02:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FED72603;
	Wed, 20 May 2026 02:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iVWj2ar3"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4C946B5
	for <stable@vger.kernel.org>; Wed, 20 May 2026 02:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779245348; cv=none; b=rkNSqH0up0cPOmPW3JKTzwEP8Oh5kR+X+9ptvaGMKBQo1lMzvvQICwQaQ3bp1FUpj3mzxAqq/btOP6S0rdnXQh6Yf7HTdfnx3LrpwbVeB71Q3ZwFPqo8+0WIChKnqi37oGbBTcj4CBRB/nKB9/EDHYojBRgYXPchL7Z61mWLRdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779245348; c=relaxed/simple;
	bh=gsVfysqJMKHRA2McsoIlM4I/NhfXB6JBQhgaMzkkhAA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=epkWIPYvKe77sOy/9YPOxJK9r7nsDb4EmrbPo9ZjLAdWyE+F4m1CsCBwzhptj/nRQDmEr4Yf/BZgg9f1brJKKhBCy3GI130M1zXn6CCqGDCZIeRk4Ek8gRVzueEaJq0fiJThtLsog4RNb9oCCdvbCAOGeRyUf66SbM/ctQMGXPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iVWj2ar3; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779245334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yR5a/g6E0YQo8Yn47vVbWDxzDy8B4ttLwABPXqZO/PY=;
	b=iVWj2ar3W6DM9iZJ3unqUquzdYaVIuZfx+BLVyEnZvs2xAz49Un9DteKbYuYPovBK1eagB
	F1nWlqfJfQiojq7LeeHnSyGAT7ao4ZEvWlU7b5u4xd9e49Pe+8hGf1KCH6IrmWV2vr4jHy
	b52jkzG7DXAbiNevV1mhiZmnolBAjbA=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2] mm/hugetlb: restore reservation on error in
 hugetlb_mfill_atomic_pte() resubmission path
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260519230503.121293-1-devnexen@gmail.com>
Date: Wed, 20 May 2026 10:48:17 +0800
Cc: akpm@linux-foundation.org,
 david@kernel.org,
 almasrymina@google.com,
 osalvador@suse.de,
 yuehaibing@huawei.com,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <24F945C3-3A62-4250-909C-65D0CEB9F182@linux.dev>
References: <20260519230503.121293-1-devnexen@gmail.com>
To: David Carlier <devnexen@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249728-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 18FCC586F30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> On May 20, 2026, at 07:05, David Carlier <devnexen@gmail.com> wrote:
>=20
> When the resubmission path in hugetlb_mfill_atomic_pte() allocates a =
new
> hugetlb folio via alloc_hugetlb_folio(), a VMA reservation is =
consumed.
> If copy_user_large_folio() subsequently fails (e.g. -EHWPOISON when =
the
> source page is hwpoisoned), folio_put() restores the global hugetlb =
pool
> count through free_huge_folio(), but the per-VMA reservation map entry
> is left marked consumed.
>=20
> User-visible effect: on a UFFDIO_COPY into a private hugetlb VMA where
> the resubmission path's copy fails, the reservation for that address =
is
> leaked from the VMA's reserve map. A subsequent fault at the same
> address takes the no-reservation path, and under hugetlb pool pressure
> the task is SIGBUSed at an address it had previously reserved. One map
> entry is leaked per occurrence.
>=20
> Add the missing restore_reserve_on_error() call before folio_put(),
> matching the first-attempt error path which already handles this
> correctly.
>=20
> Fixes: 1cb9dc4b475c ("mm: hwpoison: support recovery from HugePage =
copy-on-write faults")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> v2:
>  - Add user-visible effects paragraph in changelog (per akpm,
>    required for Cc: stable).
>  - Correct Fixes: tag to 1cb9dc4b475c (per Muchun) -- the failing
>    arm only exists since copy_user_large_folio() became int-returning.
>=20
> Andrew, please drop the v1 currently queued as 270157aef0d1 in
> mm-unstable.
>=20
> v1: =
https://lore.kernel.org/all/20260322052120.14021-1-devnexen@gmail.com/
>=20
> mm/hugetlb.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4b80b167cc9c..c6dee98840db 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6270,6 +6270,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
> 	folio_put(*foliop);
> *	foliop =3D NULL;
> 	if (ret) {
> + 		restore_reserve_on_error(h, dst_vma, dst_addr, folio);

I think you should fix the same problem in copy_hugetlb_page_range()
within this patch as well since both are introduced by the same commit.

Muchun,
Thanks.

> 		folio_put(folio);
> 		goto out;
> 	}
> --=20
> 2.53.0
>=20


