Return-Path: <stable+bounces-233286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFjXIWEL0WmmEAcAu9opvQ
	(envelope-from <stable+bounces-233286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 15:00:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E09E739B28A
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 15:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5CC6300D303
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 13:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ED333F598;
	Sat,  4 Apr 2026 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o39tLpN/"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A507223ABB9
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775307613; cv=none; b=bZy1Gb/jcZlPYSrOZPVNaed6APqXDhfziyh1U92d3IV7x9JBp2DgRVXBdXKfFtaFIKW6etnl1EDzbyphA/Ucytu/VvvvmAf6fc5BH7QH4vZikdnZbf35BXCYTYU55bxk/seUUmurUtaFaT8ov/mbNuwevtx/8aHmcbumTAWxbag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775307613; c=relaxed/simple;
	bh=bUvYYTszXjZFoQTKFYXwgkahooMtzfKCCJ0Kn1vx64c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=a1idHMgMITrfNh39iK0GG+OdfMjPIsSizcIEyDWwNRm0zBeOTBTTbFzTiZFXUsghHKBmi0S40CfIVq05J47xB2tjLVkgJlpFZzzmdaXrvdMcjX6mdCEK9f6/yyAAavs5WckPgT34QYakFqLf2zdW6TTuQc3e4VsQq5dLlZktoXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o39tLpN/; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775307608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+/xCFsixabF/oYHDluWmOQqI46QTrRWpFhihHLF3f6w=;
	b=o39tLpN/X1/ghIr3SpkvRvoAfOqlCyzm7GTaiBFhBY90D+7jvG6B8D8jg8fCn6yXJKMxbA
	j4q9WKRLEtu1oWfFCVkkTWFGlDV/3j6QAxqJKeb3p3l6jOXtXplsd3/K1cEQL5/owIdvpn
	wr5A04yiVv/SGp8tA9domOBWJf43wJU=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] mm/hugetlb: restore reservation on error in
 hugetlb_mfill_atomic_pte() resubmission path
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260322052120.14021-1-devnexen@gmail.com>
Date: Sat, 4 Apr 2026 20:59:11 +0800
Cc: Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 YueHaibing <yuehaibing@huawei.com>,
 Mina Almasry <almasrymina@google.com>,
 linux-mm@kvack.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE9ACFDB-E601-4C1D-87D1-F5DAC2767CE2@linux.dev>
References: <20260322052120.14021-1-devnexen@gmail.com>
To: David Carlier <devnexen@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233286-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: E09E739B28A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> On Mar 22, 2026, at 13:21, David Carlier <devnexen@gmail.com> wrote:
>=20
> When the resubmission path in hugetlb_mfill_atomic_pte() allocates a =
new
> hugetlb folio via alloc_hugetlb_folio(), a VMA reservation is =
consumed. If
> copy_user_large_folio() subsequently fails, folio_put() restores the =
global
> hugetlb pool count through free_huge_folio(), but the per-VMA =
reservation
> map entry is left in an inconsistent state.
>=20
> Add the missing restore_reserve_on_error() call before folio_put(), =
matching
> the first-attempt error path which already handles this correctly.
>=20
> Fixes: 8cc5fcbb5be8 ("mm, hugetlb: fix racy resv_huge_pages underflow =
on UFFDIO_COPY")

Hi David,

Thanks for this fix. The patch looks good to me and clearly solves the
reservation leak in the resubmission path of hugetlb_mfill_atomic_pte().

However, I'm a bit curious about the Fixes tag. While commit =
8cc5fcbb5be8
did introduce this code structure and the retry path, it seems the bug
wasn't actually introduced there. At that time, copy_huge_page() =
returned
void, so the failure path simply did not exist.

Instead, looking at the git history, the failure branch `if (ret)` was
added later by commit 1cb9dc4b475c ("mm: hwpoison: support recovery from
HugePage copy-on-write faults"). It modified copy_user_large_folio() to
return an int and introduced error handling paths that unfortunately
missed restoring the reservations. Should the Fixes tag perhaps point to
1cb9dc4b475c instead?

Furthermore, if commit 1cb9dc4b475c is indeed the root cause, I noticed
it also introduced similar error handling paths in other places. For
example, in copy_hugetlb_page_range():

        ret =3D copy_user_large_folio(new_folio, pte_folio, addr, =
dst_vma);
        folio_put(pte_folio);
        if (ret) {
                folio_put(new_folio);
                break;
        }

Here, new_folio was allocated with alloc_hugetlb_folio(), which consumes
reservations. But if the copy fails, new_folio is freed via folio_put()
without calling restore_reserve_on_error() first.

Does this imply we might have similar reservation leaks in other error
paths touched by 1cb9dc4b475c? I'd love to hear your thoughts on this.

Thanks,
Muchun

> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> mm/hugetlb.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 88009cd2a846..d6ea11113f1d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6295,6 +6295,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
> 	folio_put(*foliop);
> 	*foliop =3D NULL;
> 	if (ret) {
> + 		restore_reserve_on_error(h, dst_vma, dst_addr, folio);
> 		folio_put(folio);
> 		goto out;
> 	}
> --=20
> 2.53.0
>=20


