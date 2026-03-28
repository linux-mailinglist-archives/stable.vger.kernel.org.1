Return-Path: <stable+bounces-230738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KvmqBboix2kbTgUAu9opvQ
	(envelope-from <stable+bounces-230738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 01:37:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E48B34CBA8
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 01:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3F743005990
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 00:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB571BD9D0;
	Sat, 28 Mar 2026 00:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y9qLy03L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40411A9FA8
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 00:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774658157; cv=none; b=sZ8J1GFqmvcUWEfZveBpqy/I+TZ9mXuVEUu4k6uCu7eFUdrjlHjEFPQGe1NqU+p3ZTBo5NslBgnSVDy+FbWsjU4SlXZubbIe1PA17Qlu3ZGin9Uz0jBwK1tX9Z1B5YwpvrzY+F3j2aQiD6m2NSPTmDxie1u7wqAVuVWjxWOK4WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774658157; c=relaxed/simple;
	bh=h6Tk7IjG9yZpu1BCQvPI6noMo2JTbvhpbbfGx73+Odo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=D05PrHR225kMMRax7R/Hd4Nqkapr1PUh9gy/bWte3twz0GrHK8vMzWjACpAcXcb6fV8ADWXXwl95EyTfOL093NV4djlYxFvOaFgT4vQvFp7dFoiIOY9tr/fpuDRqUQwcZDTKxU72S7mJ7RxM1lujlQa8kJqdBrr5xVGhCy13IUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y9qLy03L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43897C19423;
	Sat, 28 Mar 2026 00:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774658157;
	bh=h6Tk7IjG9yZpu1BCQvPI6noMo2JTbvhpbbfGx73+Odo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y9qLy03LKdAX10P3aoEQWYcqF6NlkNuAQpyt1wsdHQWKl+BVtHruV+Nzy90HZ9J6x
	 qiXx3d+thuu+aBnzGrAASn9DRzDzP2Vih0F8qWq9MlbES6avDEX3+4oEJIl9UbTAeE
	 w0Op9wanwiAuB/InG28i3FAH9II8LhoOFkhJ5DZ0=
Date: Fri, 27 Mar 2026 17:35:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Carlier <devnexen@gmail.com>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>, YueHaibing <yuehaibing@huawei.com>,
 Mina Almasry <almasrymina@google.com>, linux-mm@kvack.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: restore reservation on error in
 hugetlb_mfill_atomic_pte() resubmission path
Message-Id: <20260327173556.8feb91aa8b40d2510a20de09@linux-foundation.org>
In-Reply-To: <20260322052120.14021-1-devnexen@gmail.com>
References: <20260322052120.14021-1-devnexen@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-230738-lists,stable=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E48B34CBA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 22 Mar 2026 05:21:20 +0000 David Carlier <devnexen@gmail.com> wrote:

> When the resubmission path in hugetlb_mfill_atomic_pte() allocates a new
> hugetlb folio via alloc_hugetlb_folio(), a VMA reservation is consumed. If
> copy_user_large_folio() subsequently fails, folio_put() restores the global
> hugetlb pool count through free_huge_folio(), but the per-VMA reservation
> map entry is left in an inconsistent state.
> 
> Add the missing restore_reserve_on_error() call before folio_put(), matching
> the first-attempt error path which already handles this correctly.

Could we please have some review here?

> Fixes: 8cc5fcbb5be8 ("mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY")
> Cc: stable@vger.kernel.org

And agreement that this is desirable.

Thanks.

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 88009cd2a846..d6ea11113f1d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6295,6 +6295,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>  		folio_put(*foliop);
>  		*foliop = NULL;
>  		if (ret) {
> +			restore_reserve_on_error(h, dst_vma, dst_addr, folio);
>  			folio_put(folio);
>  			goto out;
>  		}
> -- 
> 2.53.0
> 

