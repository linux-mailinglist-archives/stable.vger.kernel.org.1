Return-Path: <stable+bounces-249704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN8sHcnbDGpbowUAu9opvQ
	(envelope-from <stable+bounces-249704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 23:53:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC99585523
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 23:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CC7A301ECD7
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FD13B52F5;
	Tue, 19 May 2026 21:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MsYoRyby"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F82A395DAA
	for <stable@vger.kernel.org>; Tue, 19 May 2026 21:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227537; cv=none; b=EC53GT4S4jxmZ8w6hOvsv9YkU5HR2Pk4Z+FC7B39Bnb/V15vd/LTGuTUiZHklOBn9N6DNJjB6j/1Y9x5w24ja009lsh+W+6ZOBD4nhobz4dJz8mSv/bMgOLPgPkdNrAYchk1KP3YDARk3zvGieFIV4RcVpjlZIlgl0tpM685oTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227537; c=relaxed/simple;
	bh=gWTw3nIQBFCZ5yhMNWUHEDLOy2Bb2a9RdFo/9JSx3Rw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BkA77h7obnIh65D3q1W6benfIFxQQflkRTuoa/N0ERpj3zFM8TE2zoolbUZTEummNlecRASyZZM4gNzrbOzFiPktFtSEd3KmMgu3mg3IlIrWxO335tu/65phz1LHTiPK9T8UWd3ZIzfAt7UVIDKtgeqTfoMsWGVpsQl7HhciJsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MsYoRyby; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD7E1F000E9;
	Tue, 19 May 2026 21:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779227535;
	bh=hbNL8A/9L4h5m2K9/Sbmf4X0mZVOLkpQOD2l2GUfgH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MsYoRybynENNTCGOj5Sb8uoJZTBelACh8X0O4u0SEIFR8bp3JIv7dY6FB8uFgA6A3
	 xucxjzUu0ZeFXZyo1rMG8scATrsvJrwORBPMMZxfH5vwvSZ3uSlVEDkZmM7jf2JAC8
	 1bTSmmO76PGlxvuLXyw7BV/GcLZkdFDTWtf40E4k=
Date: Tue, 19 May 2026 14:52:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: David Carlier <devnexen@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>, YueHaibing <yuehaibing@huawei.com>,
 Mina Almasry <almasrymina@google.com>, linux-mm@kvack.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: restore reservation on error in
 hugetlb_mfill_atomic_pte() resubmission path
Message-Id: <20260519145215.ef37484626f23a82fc7ef992@linux-foundation.org>
In-Reply-To: <EE9ACFDB-E601-4C1D-87D1-F5DAC2767CE2@linux.dev>
References: <20260322052120.14021-1-devnexen@gmail.com>
	<EE9ACFDB-E601-4C1D-87D1-F5DAC2767CE2@linux.dev>
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
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249704-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,kernel.org,huawei.com,google.com,kvack.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,suse.de:email]
X-Rspamd-Queue-Id: CDC99585523
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 4 Apr 2026 20:59:11 +0800 Muchun Song <muchun.song@linux.dev> wrote:

> 
> 
> > On Mar 22, 2026, at 13:21, David Carlier <devnexen@gmail.com> wrote:
> > 
> > When the resubmission path in hugetlb_mfill_atomic_pte() allocates a new
> > hugetlb folio via alloc_hugetlb_folio(), a VMA reservation is consumed. If
> > copy_user_large_folio() subsequently fails, folio_put() restores the global
> > hugetlb pool count through free_huge_folio(), but the per-VMA reservation
> > map entry is left in an inconsistent state.
> > 
> > Add the missing restore_reserve_on_error() call before folio_put(), matching
> > the first-attempt error path which already handles this correctly.
> > 
> > Fixes: 8cc5fcbb5be8 ("mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY")
> 
> Hi David,
> 
> Thanks for this fix. The patch looks good to me and clearly solves the
> reservation leak in the resubmission path of hugetlb_mfill_atomic_pte().
> 
> However, I'm a bit curious about the Fixes tag. While commit 8cc5fcbb5be8
> did introduce this code structure and the retry path, it seems the bug
> wasn't actually introduced there. At that time, copy_huge_page() returned
> void, so the failure path simply did not exist.
> 
> Instead, looking at the git history, the failure branch `if (ret)` was
> added later by commit 1cb9dc4b475c ("mm: hwpoison: support recovery from
> HugePage copy-on-write faults"). It modified copy_user_large_folio() to
> return an int and introduced error handling paths that unfortunately
> missed restoring the reservations. Should the Fixes tag perhaps point to
> 1cb9dc4b475c instead?
> 
> Furthermore, if commit 1cb9dc4b475c is indeed the root cause, I noticed
> it also introduced similar error handling paths in other places. For
> example, in copy_hugetlb_page_range():
> 
>         ret = copy_user_large_folio(new_folio, pte_folio, addr, dst_vma);
>         folio_put(pte_folio);
>         if (ret) {
>                 folio_put(new_folio);
>                 break;
>         }
> 
> Here, new_folio was allocated with alloc_hugetlb_folio(), which consumes
> reservations. But if the copy fails, new_folio is freed via folio_put()
> without calling restore_reserve_on_error() first.
> 
> Does this imply we might have similar reservation leaks in other error
> paths touched by 1cb9dc4b475c? I'd love to hear your thoughts on this.

It's been a while.  Can people please refocus on this?

David, your patch had cc:stable but I'm not seeing a description of the
userspace-visible effects of the bug.  Can you please describe?


From: David Carlier <devnexen@gmail.com>
Subject: mm/hugetlb: restore reservation on error in hugetlb_mfill_atomic_pte() resubmission path
Date: Sun, 22 Mar 2026 05:21:20 +0000

When the resubmission path in hugetlb_mfill_atomic_pte() allocates a new
hugetlb folio via alloc_hugetlb_folio(), a VMA reservation is consumed. 
If copy_user_large_folio() subsequently fails, folio_put() restores the
global hugetlb pool count through free_huge_folio(), but the per-VMA
reservation map entry is left in an inconsistent state.

Add the missing restore_reserve_on_error() call before folio_put(),
matching the first-attempt error path which already handles this
correctly.

Link: https://lore.kernel.org/20260322052120.14021-1-devnexen@gmail.com
Fixes: 8cc5fcbb5be8 ("mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY")
Signed-off-by: David Carlier <devnexen@gmail.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: yuehaibing <yuehaibing@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/hugetlb.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/hugetlb.c~mm-hugetlb-restore-reservation-on-error-in-hugetlb_mfill_atomic_pte-resubmission-path
+++ a/mm/hugetlb.c
@@ -6290,6 +6290,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_
 		folio_put(*foliop);
 		*foliop = NULL;
 		if (ret) {
+			restore_reserve_on_error(h, dst_vma, dst_addr, folio);
 			folio_put(folio);
 			goto out;
 		}
_


