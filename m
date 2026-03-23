Return-Path: <stable+bounces-229997-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNt4OlmYwWlNUAQAu9opvQ
	(envelope-from <stable+bounces-229997-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:45:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6963A2FC8BB
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E45530672DE
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8594C32E68D;
	Mon, 23 Mar 2026 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TAMRB8qX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E18327C08
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293195; cv=none; b=YSItQpC8wyBkNMyzr7sheSOInKzhNeeoB/+uKIWnFvE5RVegGzCQZccnU2iiUeAvl9hpvjLLCA8SKJsTLaGjoa86T6buagloFDpk9FPLV/BMFLse6EXwCqaLKnM5e0QhfrIhW8ZrF4+kkiZfSVFhugrVVW4G0sUxG/joC2zIUVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293195; c=relaxed/simple;
	bh=YPvCdw6C6+qB9yiSepX6OYKDZRFLBohSuc7vCWJMFPI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GqilNUk5tOwYno3zsvzIv62ftvSJ3bqsGabEcLk1c4CYgnKrPXM7agACbxwQg39OqkZaVev1+FegCpnAeapERjO6tN6rUy7aF1sVkAvGR5fhfQ7u10nidESUdzPzW1j4e4K7M0RaozY4hC7+kdwkxRRUqUWq1f8BL/W+/DIc5r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TAMRB8qX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9C5C4CEF7;
	Mon, 23 Mar 2026 19:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774293195;
	bh=YPvCdw6C6+qB9yiSepX6OYKDZRFLBohSuc7vCWJMFPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TAMRB8qXJk10MxytYpTANIJOrkT9qs7dbZvwtCcqk881kLgNewAwXxSzLkyFca/bM
	 3IpTnTkYr6HEyeyXNs1ZbUHQ62mOcqhfGchZcGpyks1Q4Hx9ebnnMu3MdXwa/xK5zf
	 KZ6SDeOCMVWczyd7p84hZnY1XR9YGMWRXDbkGZfg=
Date: Mon, 23 Mar 2026 12:13:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Carlier <devnexen@gmail.com>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>, YueHaibing <yuehaibing@huawei.com>,
 Mina Almasry <almasrymina@google.com>, linux-mm@kvack.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: restore reservation on error in
 hugetlb_mfill_atomic_pte() resubmission path
Message-Id: <20260323121314.ab3c389ae368c0179624de8c@linux-foundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-229997-lists,stable=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:dkim,linux-foundation.org:mid]
X-Rspamd-Queue-Id: 6963A2FC8BB
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
> 
> ...
>
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

I guess we could goto out_release_nounlock here, although I'm not sure
that improves anything - keeping track of the value of
folio_in_pagecache is rather twisty.


