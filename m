Return-Path: <stable+bounces-181581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7777BB98A99
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 09:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5AC919C5389
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 07:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F362C3255;
	Wed, 24 Sep 2025 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MCwROXoR"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3D12900A8
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699992; cv=none; b=PwtJtftLmv04RZNzINGL30W9fLA1VX53qU9VmrtMdEgzhPKyo2MjXhyiWxzTST5jRqWmaXe+IQOPP7NO8EzgzKPR/b3van1e3IPZlp/WRp1ynzsjBlNTuO8ZNQNMU21xk07+l52cHaswDhQS6gOD6zNY5K7nU0D/bC4oe0Vlj7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699992; c=relaxed/simple;
	bh=InkKcSboDJDNeKZNM7gzum8F1x+gdqN5FTI583iQip8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z7ygniH9az6BXaAxW0jXOajuFwDf27cOMjlSd8KhnvMTDXERiarvY9pTBLbE5SrPss6WuBnh5cWaXBZ0Z7HRMRRboigcu0NpeQnvF+E2gK5aLGnsGvI1gl/WXTicOZVvuH/8Oz2506aPVZTN7OK96p4gAUO7Ne/hfUj+jXP09rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MCwROXoR; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ea473582bcaso742403276.1
        for <stable@vger.kernel.org>; Wed, 24 Sep 2025 00:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758699988; x=1759304788; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FtPH/kNcXExHDftrtDl2DvrCPs+iLcMgYZM+kBcWRR8=;
        b=MCwROXoRZTVEI0ZHejiLBiX4oBZi6VxTOMmRHXnFa5TG8tfLyhFGfgWyQ5Vh4Ir/9p
         0+tm5jGlOcnFOSAbLMVCM5Cr/etoQktw3lYJ6ThprpgnWj0uKJEEJN9r0OUNMPnw0Flw
         JBmVRpa3A7Ll31PE5p0ygFCe4dTlDcpJTe3HDsl08SCNNbqzoQwjlYCF1/8I45anI3ja
         KyQ5q5YMbSXgGROE3G3sN/w7PHBSnEjVvd486jez7uvw0D5V+DAFME7qislNctsiiW1W
         A9lR0nqzxQZ2YGQ2h41UzKwpnPlxEIDF8cZi0x5Y1kNY9QQUWnqxsRj6wvXMuQxCHbVX
         20lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758699988; x=1759304788;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FtPH/kNcXExHDftrtDl2DvrCPs+iLcMgYZM+kBcWRR8=;
        b=S8HFMcpOrDEBoUv5ZNJ6KQrTcBN/C7LryPkxmBmdtSA8be9sfz5vh9HN4Q4es5hwec
         rxhmY251y/fePPVVaOs/n/7rszlweY6ifggDjxwC1nrRQvuAH6iEEZ0FnIMEQK2gsxVJ
         HfrN/vDuysPHcylJU9vrugI+JxxKKHgwdKBkdB+1h3/AJXSu+cXBMcCSvj1murrY8kOX
         GOywl9pMEVSrS56LXp+xE1nrgX4OMla1vPcHQ0NeqYnT6m8QuFL1XWUd/0GkCDzI1rXR
         hY3LvA7tdTSRSK+6gbfecBaMxN7LElqUiz8NbEnsjLzBs1LHN4bitxh1Lys+3UQ15/r6
         xlyA==
X-Forwarded-Encrypted: i=1; AJvYcCWMJb+VKC2RqlF2H4Vpo62INA+gwY5VZLkO2+rYMWALbcLqbM/Y+d2fxmj5327+T0HfKcTEEGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycxa48RYeBD3u6E4N6QW2A9iye870iknvyCuTJ4NZAUz/obDLg
	2npTdZLONRTlH1Bq6071l2Ojd8ypxymKyovBOJZB6pnCg/6qiEmhqvViP6ZYlTLD2A==
X-Gm-Gg: ASbGncvCc50hP7djXUPRQv0ulBmCG6kATe95I5BRWV9In7LL4Nu//p9Zq5NYBHaxwe1
	fqVKgr7+nZwfwg88RLPx11FDtof8gvs8cTyNbl9CiUu0WoXuO4fLfosWCWDRD85svShxJMoC+vX
	E8FxjS0gqh/nUVlqTPoXvgJtcyEwdlqRpk9hZyAUrFkFZ4XkfbjGZZVGOe0oQX5tNqaUSX+d/sD
	14dn/pQQZqX8NHm9+YRsGXFx2KuRirMuvqgCoz8R96x/mkbMfVgOo102cnDYrSYssuAuiQ5ZG1K
	xlyWRvMr4IsjeX5lsKoBNkyekZhCwroTIwp62eYKA/5ET9pPPMhGVoTUPSqxiXUO1DSQd+rZGeV
	RWqpZ/vlHmtUTaWib9PmgbdM8vm3XCCRKW54beCr3Y7yLbJ7eNKCG07HNNo0ONyRr2m/mqozaXw
	63/IDf3sbFnrcurA==
X-Google-Smtp-Source: AGHT+IEJlkyIV4gQUq/W0kBuMrzmmH1JiPw0TW6NmKl8/hItw71K8D6NxGyz5LA2gPjH7tb93FWcmQ==
X-Received: by 2002:a05:690e:248b:b0:636:cc3:af35 with SMTP id 956f58d0204a3-636103f9698mr676946d50.22.1758699987394;
        Wed, 24 Sep 2025 00:46:27 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce709f08sm5719318276.3.2025.09.24.00.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 00:46:26 -0700 (PDT)
Date: Wed, 24 Sep 2025 00:46:10 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: gregkh@linuxfoundation.org
cc: sashal@kernel.org, hughd@google.com, akpm@linux-foundation.org, 
    aneesh.kumar@kernel.org, axelrasmussen@google.com, chrisl@kernel.org, 
    david@redhat.com, hannes@cmpxchg.org, hch@infradead.org, jgg@ziepe.ca, 
    jhubbard@nvidia.com, kas@kernel.org, keirf@google.com, koct9i@gmail.com, 
    lizhe.67@bytedance.com, peterx@redhat.com, riel@surriel.com, 
    shivankg@amd.com, stable@vger.kernel.org, vbabka@suse.cz, 
    weixugc@google.com, will@kernel.org, willy@infradead.org, 
    yangge1116@126.com, yuanchu@google.com, yuzhao@google.com
Subject: Re: FAILED: patch "[PATCH] mm/gup: check ref_count instead of lru
 before migration" failed to apply to 6.6-stable tree
In-Reply-To: <2025092111-hedging-brunch-bdeb@gregkh>
Message-ID: <bdc4b129-34c2-7d3d-c0b4-c6711af81fcd@google.com>
References: <2025092111-hedging-brunch-bdeb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-1835507063-1758699986=:6369"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-1835507063-1758699986=:6369
Content-Type: text/plain; charset=US-ASCII

On Sun, 21 Sep 2025, gregkh@linuxfoundation.org wrote:

> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 98c6d259319ecf6e8d027abd3f14b81324b8c0ad
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092111-hedging-brunch-bdeb@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 98c6d259319ecf6e8d027abd3f14b81324b8c0ad Mon Sep 17 00:00:00 2001
> From: Hugh Dickins <hughd@google.com>
> Date: Mon, 8 Sep 2025 15:15:03 -0700
> Subject: [PATCH] mm/gup: check ref_count instead of lru before migration
> 
> Patch series "mm: better GUP pin lru_add_drain_all()", v2.
> 
> Series of lru_add_drain_all()-related patches, arising from recent mm/gup
> migration report from Will Deacon.
> 
> 
> This patch (of 5):
> 
> Will Deacon reports:-
> 
> When taking a longterm GUP pin via pin_user_pages(),
> __gup_longterm_locked() tries to migrate target folios that should not be
> longterm pinned, for example because they reside in a CMA region or
> movable zone.  This is done by first pinning all of the target folios
> anyway, collecting all of the longterm-unpinnable target folios into a
> list, dropping the pins that were just taken and finally handing the list
> off to migrate_pages() for the actual migration.
> 
> It is critically important that no unexpected references are held on the
> folios being migrated, otherwise the migration will fail and
> pin_user_pages() will return -ENOMEM to its caller.  Unfortunately, it is
> relatively easy to observe migration failures when running pKVM (which
> uses pin_user_pages() on crosvm's virtual address space to resolve stage-2
> page faults from the guest) on a 6.15-based Pixel 6 device and this
> results in the VM terminating prematurely.
> 
> In the failure case, 'crosvm' has called mlock(MLOCK_ONFAULT) on its
> mapping of guest memory prior to the pinning.  Subsequently, when
> pin_user_pages() walks the page-table, the relevant 'pte' is not present
> and so the faulting logic allocates a new folio, mlocks it with
> mlock_folio() and maps it in the page-table.
> 
> Since commit 2fbb0c10d1e8 ("mm/munlock: mlock_page() munlock_page() batch
> by pagevec"), mlock/munlock operations on a folio (formerly page), are
> deferred.  For example, mlock_folio() takes an additional reference on the
> target folio before placing it into a per-cpu 'folio_batch' for later
> processing by mlock_folio_batch(), which drops the refcount once the
> operation is complete.  Processing of the batches is coupled with the LRU
> batch logic and can be forcefully drained with lru_add_drain_all() but as
> long as a folio remains unprocessed on the batch, its refcount will be
> elevated.
> 
> This deferred batching therefore interacts poorly with the pKVM pinning
> scenario as we can find ourselves in a situation where the migration code
> fails to migrate a folio due to the elevated refcount from the pending
> mlock operation.
> 
> Hugh Dickins adds:-
> 
> !folio_test_lru() has never been a very reliable way to tell if an
> lru_add_drain_all() is worth calling, to remove LRU cache references to
> make the folio migratable: the LRU flag may be set even while the folio is
> held with an extra reference in a per-CPU LRU cache.
> 
> 5.18 commit 2fbb0c10d1e8 may have made it more unreliable.  Then 6.11
> commit 33dfe9204f29 ("mm/gup: clear the LRU flag of a page before adding
> to LRU batch") tried to make it reliable, by moving LRU flag clearing; but
> missed the mlock/munlock batches, so still unreliable as reported.
> 
> And it turns out to be difficult to extend 33dfe9204f29's LRU flag
> clearing to the mlock/munlock batches: if they do benefit from batching,
> mlock/munlock cannot be so effective when easily suppressed while !LRU.
> 
> Instead, switch to an expected ref_count check, which was more reliable
> all along: some more false positives (unhelpful drains) than before, and
> never a guarantee that the folio will prove migratable, but better.
> 
> Note on PG_private_2: ceph and nfs are still using the deprecated
> PG_private_2 flag, with the aid of netfs and filemap support functions.
> Although it is consistently matched by an increment of folio ref_count,
> folio_expected_ref_count() intentionally does not recognize it, and ceph
> folio migration currently depends on that for PG_private_2 folios to be
> rejected.  New references to the deprecated flag are discouraged, so do
> not add it into the collect_longterm_unpinnable_folios() calculation: but
> longterm pinning of transiently PG_private_2 ceph and nfs folios (an
> uncommon case) may invoke a redundant lru_add_drain_all().  And this makes
> easy the backport to earlier releases: up to and including 6.12, btrfs
> also used PG_private_2, but without a ref_count increment.
> 
> Note for stable backports: requires 6.16 commit 86ebd50224c0 ("mm:
> add folio_expected_ref_count() for reference count calculation").
> 
> Link: https://lkml.kernel.org/r/41395944-b0e3-c3ac-d648-8ddd70451d28@google.com
> Link: https://lkml.kernel.org/r/bd1f314a-fca1-8f19-cac0-b936c9614557@google.com
> Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pages allocated from CMA region")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Reported-by: Will Deacon <will@kernel.org>
> Closes: https://lore.kernel.org/linux-mm/20250815101858.24352-1-will@kernel.org/
> Acked-by: Kiryl Shutsemau <kas@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Keir Fraser <keirf@google.com>
> Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> Cc: Li Zhe <lizhe.67@bytedance.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Shivank Garg <shivankg@amd.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Wei Xu <weixugc@google.com>
> Cc: yangge <yangge1116@126.com>
> Cc: Yuanchu Xie <yuanchu@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index adffe663594d..82aec6443c0a 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2307,7 +2307,8 @@ static unsigned long collect_longterm_unpinnable_folios(
>  			continue;
>  		}
>  
> -		if (!folio_test_lru(folio) && drain_allow) {
> +		if (drain_allow && folio_ref_count(folio) !=
> +				   folio_expected_ref_count(folio) + 1) {
>  			lru_add_drain_all();
>  			drain_allow = false;
>  		}

Five gup/lrudrain backport patches against 6.6.108-rc1 attached.
---1463770367-1835507063-1758699986=:6369
Content-Type: text/x-patch; name=0001-mm-gup-revert-mm-gup-fix-infinite-loop-within-__get_.patch
Content-Transfer-Encoding: BASE64
Content-ID: <284a1db8-6aaa-defd-16d9-63f8e8068466@google.com>
Content-Description: 
Content-Disposition: attachment; filename=0001-mm-gup-revert-mm-gup-fix-infinite-loop-within-__get_.patch

RnJvbSBhNmVjOGExZjJiNWIwMzlhZWU4MDU3MTc2N2U5MjdmZjk5M2VjNzBm
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogRGF2aWQgSGlsZGVu
YnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQpEYXRlOiBXZWQsIDExIEp1biAy
MDI1IDE1OjEzOjE0ICswMjAwDQpTdWJqZWN0OiBbUEFUQ0ggMS81XSBtbS9n
dXA6IHJldmVydCAibW06IGd1cDogZml4IGluZmluaXRlIGxvb3Agd2l0aGlu
DQogX19nZXRfbG9uZ3Rlcm1fbG9ja2VkIg0KDQpbIFVwc3RyZWFtIGNvbW1p
dCA1MTdmNDk2ZTFlNjFiZDE2OWQ1ODVkYWI0ZGQ3N2U3MTQ3NTA2MzIyIF0N
Cg0KQWZ0ZXIgY29tbWl0IDFhYWY4YzEyMjkxOCAoIm1tOiBndXA6IGZpeCBp
bmZpbml0ZSBsb29wIHdpdGhpbg0KX19nZXRfbG9uZ3Rlcm1fbG9ja2VkIikg
d2UgYXJlIGFibGUgdG8gbG9uZ3Rlcm0gcGluIGZvbGlvcyB0aGF0IGFyZSBu
b3QNCnN1cHBvc2VkIHRvIGdldCBsb25ndGVybSBwaW5uZWQsIHNpbXBseSBi
ZWNhdXNlIHRoZXkgdGVtcG9yYXJpbHkgaGF2ZSB0aGUNCkxSVSBmbGFnIGNs
ZWFyZWQgKGVzcC4gIHRlbXBvcmFyaWx5IGlzb2xhdGVkKS4NCg0KRm9yIGV4
YW1wbGUsIHR3byBfX2dldF9sb25ndGVybV9sb2NrZWQoKSBjYWxsZXJzIGNh
biByYWNlLCBvcg0KX19nZXRfbG9uZ3Rlcm1fbG9ja2VkKCkgY2FuIHJhY2Ug
d2l0aCBhbnl0aGluZyBlbHNlIHRoYXQgdGVtcG9yYXJpbHkNCmlzb2xhdGVz
IGZvbGlvcy4NCg0KVGhlIGludHJvZHVjaW5nIGNvbW1pdCBtZW50aW9ucyB0
aGUgdXNlIGNhc2Ugb2YgYSBkcml2ZXIgdGhhdCB1c2VzDQp2bV9vcHMtPmZh
dWx0IHRvIGluc2VydCBwYWdlcyBhbGxvY2F0ZWQgdGhyb3VnaCBjbWFfYWxs
b2MoKSBpbnRvIHRoZSBwYWdlDQp0YWJsZXMsIGFzc3VtaW5nIHRoZXkgY2Fu
IGxhdGVyIGdldCBsb25ndGVybSBwaW5uZWQuICBUaGVzZSBwYWdlcy8gZm9s
aW9zDQp3b3VsZCBuZXZlciBoYXZlIHRoZSBMUlUgZmxhZyBzZXQgYW5kIGNv
bnNlcXVlbnRseSBjYW5ub3QgZ2V0IGlzb2xhdGVkLg0KVGhlcmUgaXMgbm8g
a25vd24gaW4tdHJlZSB1c2VyIG1ha2luZyB1c2Ugb2YgdGhhdCBzbyBmYXIs
IGZvcnR1bmF0ZWx5Lg0KDQpUbyBoYW5kbGUgdGhhdCBpbiB0aGUgZnV0dXJl
IC0tIGFuZCBhdm9pZCByZXRyeWluZyBmb3JldmVyIHRvDQppc29sYXRlL21p
Z3JhdGUgdGhlbSAtLSB3ZSB3aWxsIG5lZWQgYSBkaWZmZXJlbnQgbWVjaGFu
aXNtIGZvciB0aGUgQ01BDQphcmVhICpvd25lciogdG8gaW5kaWNhdGUgdGhh
dCBpdCBhY3R1YWxseSBhbHJlYWR5IGFsbG9jYXRlZCB0aGUgcGFnZSBhbmQN
CmlzIGZpbmUgd2l0aCBsb25ndGVybSBwaW5uaW5nIGl0LiAgVGhlIExSVSBm
bGFnIGlzIG5vdCBzdWl0YWJsZSBmb3IgdGhhdC4NCg0KUHJvYmFibHkgd2Ug
Y2FuIGxvb2t1cCB0aGUgcmVsZXZhbnQgQ01BIGFyZWEgYW5kIHF1ZXJ5IHRo
ZSBiaXRtYXA7IHdlIG9ubHkNCmhhdmUgaGF2ZSB0byBjYXJlIGFib3V0IHNv
bWUgcmFjZXMsIHByb2JhYmx5LiAgSWYgYWxyZWFkeSBhbGxvY2F0ZWQsIHdl
DQpjb3VsZCBqdXN0IGFsbG93IGxvbmd0ZXJtIHBpbm5pbmcpDQoNCkFueWhv
dywgbGV0J3MgZml4IHRoZSAibXVzdCBub3QgYmUgbG9uZ3Rlcm0gcGlubmVk
IiBwcm9ibGVtIGZpcnN0IGJ5DQpyZXZlcnRpbmcgdGhlIG9yaWdpbmFsIGNv
bW1pdC4NCg0KTGluazogaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDI1
MDYxMTEzMTMxNC41OTQ1MjktMS1kYXZpZEByZWRoYXQuY29tDQpGaXhlczog
MWFhZjhjMTIyOTE4ICgibW06IGd1cDogZml4IGluZmluaXRlIGxvb3Agd2l0
aGluIF9fZ2V0X2xvbmd0ZXJtX2xvY2tlZCIpDQpTaWduZWQtb2ZmLWJ5OiBE
YXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCkNsb3Nlczog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwNTIyMDkyNzU1LkdB
MzI3NzU5N0B0aWZmYW55Lw0KUmVwb3J0ZWQtYnk6IEh5ZXNvbyBZdSA8aHll
c29vLnl1QHNhbXN1bmcuY29tPg0KUmV2aWV3ZWQtYnk6IEpvaG4gSHViYmFy
ZCA8amh1YmJhcmRAbnZpZGlhLmNvbT4NCkNjOiBKYXNvbiBHdW50aG9ycGUg
PGpnZ0B6aWVwZS5jYT4NCkNjOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5j
b20+DQpDYzogWmhhb3lhbmcgSHVhbmcgPHpoYW95YW5nLmh1YW5nQHVuaXNv
Yy5jb20+DQpDYzogQWlqdW4gU3VuIDxhaWp1bi5zdW5AdW5pc29jLmNvbT4N
CkNjOiBBbGlzdGFpciBQb3BwbGUgPGFwb3BwbGVAbnZpZGlhLmNvbT4NCkNj
OiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6IEFu
ZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQpbIFJl
dmVydCB2Ni42Ljc5IGNvbW1pdCA5MzNiMDhjMGVkZmEgXQ0KU2lnbmVkLW9m
Zi1ieTogSHVnaCBEaWNraW5zIDxodWdoZEBnb29nbGUuY29tPg0KLS0tDQog
bW0vZ3VwLmMgfCAxNCArKysrKysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAxMCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvbW0vZ3VwLmMgYi9tbS9ndXAuYw0KaW5kZXggMjljNzE5YjNhYjMx
Li40OTdkN2NlNDNkMzkgMTAwNjQ0DQotLS0gYS9tbS9ndXAuYw0KKysrIGIv
bW0vZ3VwLmMNCkBAIC0xOTQ2LDE0ICsxOTQ2LDE0IEBAIHN0cnVjdCBwYWdl
ICpnZXRfZHVtcF9wYWdlKHVuc2lnbmVkIGxvbmcgYWRkcikNCiAvKg0KICAq
IFJldHVybnMgdGhlIG51bWJlciBvZiBjb2xsZWN0ZWQgcGFnZXMuIFJldHVy
biB2YWx1ZSBpcyBhbHdheXMgPj0gMC4NCiAgKi8NCi1zdGF0aWMgdm9pZCBj
b2xsZWN0X2xvbmd0ZXJtX3VucGlubmFibGVfcGFnZXMoDQorc3RhdGljIHVu
c2lnbmVkIGxvbmcgY29sbGVjdF9sb25ndGVybV91bnBpbm5hYmxlX3BhZ2Vz
KA0KIAkJCQkJc3RydWN0IGxpc3RfaGVhZCAqbW92YWJsZV9wYWdlX2xpc3Qs
DQogCQkJCQl1bnNpZ25lZCBsb25nIG5yX3BhZ2VzLA0KIAkJCQkJc3RydWN0
IHBhZ2UgKipwYWdlcykNCiB7DQorCXVuc2lnbmVkIGxvbmcgaSwgY29sbGVj
dGVkID0gMDsNCiAJc3RydWN0IGZvbGlvICpwcmV2X2ZvbGlvID0gTlVMTDsN
CiAJYm9vbCBkcmFpbl9hbGxvdyA9IHRydWU7DQotCXVuc2lnbmVkIGxvbmcg
aTsNCiANCiAJZm9yIChpID0gMDsgaSA8IG5yX3BhZ2VzOyBpKyspIHsNCiAJ
CXN0cnVjdCBmb2xpbyAqZm9saW8gPSBwYWdlX2ZvbGlvKHBhZ2VzW2ldKTsN
CkBAIC0xOTY1LDYgKzE5NjUsOCBAQCBzdGF0aWMgdm9pZCBjb2xsZWN0X2xv
bmd0ZXJtX3VucGlubmFibGVfcGFnZXMoDQogCQlpZiAoZm9saW9faXNfbG9u
Z3Rlcm1fcGlubmFibGUoZm9saW8pKQ0KIAkJCWNvbnRpbnVlOw0KIA0KKwkJ
Y29sbGVjdGVkKys7DQorDQogCQlpZiAoZm9saW9faXNfZGV2aWNlX2NvaGVy
ZW50KGZvbGlvKSkNCiAJCQljb250aW51ZTsNCiANCkBAIC0xOTg2LDYgKzE5
ODgsOCBAQCBzdGF0aWMgdm9pZCBjb2xsZWN0X2xvbmd0ZXJtX3VucGlubmFi
bGVfcGFnZXMoDQogCQkJCSAgICBOUl9JU09MQVRFRF9BTk9OICsgZm9saW9f
aXNfZmlsZV9scnUoZm9saW8pLA0KIAkJCQkgICAgZm9saW9fbnJfcGFnZXMo
Zm9saW8pKTsNCiAJfQ0KKw0KKwlyZXR1cm4gY29sbGVjdGVkOw0KIH0NCiAN
CiAvKg0KQEAgLTIwNzgsMTAgKzIwODIsMTIgQEAgc3RhdGljIGludCBtaWdy
YXRlX2xvbmd0ZXJtX3VucGlubmFibGVfcGFnZXMoDQogc3RhdGljIGxvbmcg
Y2hlY2tfYW5kX21pZ3JhdGVfbW92YWJsZV9wYWdlcyh1bnNpZ25lZCBsb25n
IG5yX3BhZ2VzLA0KIAkJCQkJICAgIHN0cnVjdCBwYWdlICoqcGFnZXMpDQog
ew0KKwl1bnNpZ25lZCBsb25nIGNvbGxlY3RlZDsNCiAJTElTVF9IRUFEKG1v
dmFibGVfcGFnZV9saXN0KTsNCiANCi0JY29sbGVjdF9sb25ndGVybV91bnBp
bm5hYmxlX3BhZ2VzKCZtb3ZhYmxlX3BhZ2VfbGlzdCwgbnJfcGFnZXMsIHBh
Z2VzKTsNCi0JaWYgKGxpc3RfZW1wdHkoJm1vdmFibGVfcGFnZV9saXN0KSkN
CisJY29sbGVjdGVkID0gY29sbGVjdF9sb25ndGVybV91bnBpbm5hYmxlX3Bh
Z2VzKCZtb3ZhYmxlX3BhZ2VfbGlzdCwNCisJCQkJCQlucl9wYWdlcywgcGFn
ZXMpOw0KKwlpZiAoIWNvbGxlY3RlZCkNCiAJCXJldHVybiAwOw0KIA0KIAly
ZXR1cm4gbWlncmF0ZV9sb25ndGVybV91bnBpbm5hYmxlX3BhZ2VzKCZtb3Zh
YmxlX3BhZ2VfbGlzdCwgbnJfcGFnZXMsDQotLSANCjIuNTEuMC41MzQuZ2M3
OTA5NWMwY2EtZ29vZw0KDQo=

---1463770367-1835507063-1758699986=:6369
Content-Type: text/x-patch; name=0002-mm-add-folio_expected_ref_count-for-reference-count-.patch
Content-Transfer-Encoding: BASE64
Content-ID: <1e6909df-88fd-a595-e799-eee380b22fa8@google.com>
Content-Description: 
Content-Disposition: attachment; filename=0002-mm-add-folio_expected_ref_count-for-reference-count-.patch

RnJvbSAyNmRjNzY2ODYzNWVlYWJhYjg0YTM2Yzk3ZjAwZTM5OTM4N2ZmMGRm
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogU2hpdmFuayBHYXJn
IDxzaGl2YW5rZ0BhbWQuY29tPg0KRGF0ZTogV2VkLCAzMCBBcHIgMjAyNSAx
MDowMTo1MSArMDAwMA0KU3ViamVjdDogW1BBVENIIDIvNV0gbW06IGFkZCBm
b2xpb19leHBlY3RlZF9yZWZfY291bnQoKSBmb3IgcmVmZXJlbmNlIGNvdW50
DQogY2FsY3VsYXRpb24NCg0KWyBVcHN0cmVhbSBjb21taXQgODZlYmQ1MDIy
NGMwNzM0ZDk2NTg0MzI2MGQwZGMwNTdhOTQzMWM2MSBdDQoNClBhdGNoIHNl
cmllcyAiIEpGUzogSW1wbGVtZW50IG1pZ3JhdGVfZm9saW8gZm9yIGpmc19t
ZXRhcGFnZV9hb3BzIiB2NS4NCg0KVGhpcyBwYXRjaHNldCBhZGRyZXNzZXMg
YSB3YXJuaW5nIHRoYXQgb2NjdXJzIGR1cmluZyBtZW1vcnkgY29tcGFjdGlv
biBkdWUNCnRvIEpGUydzIG1pc3NpbmcgbWlncmF0ZV9mb2xpbyBvcGVyYXRp
b24uICBUaGUgd2FybmluZyB3YXMgaW50cm9kdWNlZCBieQ0KY29tbWl0IDdl
ZTM2NDcyNDNlNSAoIm1pZ3JhdGU6IFJlbW92ZSBjYWxsIHRvIC0+d3JpdGVw
YWdlIikgd2hpY2ggYWRkZWQNCmV4cGxpY2l0IHdhcm5pbmdzIHdoZW4gZmls
ZXN5c3RlbSBkb24ndCBpbXBsZW1lbnQgbWlncmF0ZV9mb2xpby4NCg0KVGhl
IHN5emJvdCByZXBvcnRlZCBmb2xsb3dpbmcgWzFdOg0KICBqZnNfbWV0YXBh
Z2VfYW9wcyBkb2VzIG5vdCBpbXBsZW1lbnQgbWlncmF0ZV9mb2xpbw0KICBX
QVJOSU5HOiBDUFU6IDEgUElEOiA1ODYxIGF0IG1tL21pZ3JhdGUuYzo5NTUg
ZmFsbGJhY2tfbWlncmF0ZV9mb2xpbyBtbS9taWdyYXRlLmM6OTUzIFtpbmxp
bmVdDQogIFdBUk5JTkc6IENQVTogMSBQSUQ6IDU4NjEgYXQgbW0vbWlncmF0
ZS5jOjk1NSBtb3ZlX3RvX25ld19mb2xpbysweDcwZS8weDg0MCBtbS9taWdy
YXRlLmM6MTAwNw0KICBNb2R1bGVzIGxpbmtlZCBpbjoNCiAgQ1BVOiAxIFVJ
RDogMCBQSUQ6IDU4NjEgQ29tbTogc3l6LWV4ZWN1dG9yMjgwIE5vdCB0YWlu
dGVkIDYuMTUuMC1yYzEtbmV4dC0yMDI1MDQxMS1zeXprYWxsZXIgIzAgUFJF
RU1QVChmdWxsKQ0KICBIYXJkd2FyZSBuYW1lOiBHb29nbGUgR29vZ2xlIENv
bXB1dGUgRW5naW5lL0dvb2dsZSBDb21wdXRlIEVuZ2luZSwgQklPUyBHb29n
bGUgMDIvMTIvMjAyNQ0KICBSSVA6IDAwMTA6ZmFsbGJhY2tfbWlncmF0ZV9m
b2xpbyBtbS9taWdyYXRlLmM6OTUzIFtpbmxpbmVdDQogIFJJUDogMDAxMDpt
b3ZlX3RvX25ld19mb2xpbysweDcwZS8weDg0MCBtbS9taWdyYXRlLmM6MTAw
Nw0KDQpUbyBmaXggdGhpcyBpc3N1ZSwgdGhpcyBzZXJpZXMgaW1wbGVtZW50
IG1ldGFwYWdlX21pZ3JhdGVfZm9saW8oKSBmb3IgSkZTDQp3aGljaCBoYW5k
bGVzIGJvdGggc2luZ2xlIGFuZCBtdWx0aXBsZSBtZXRhcGFnZXMgcGVyIHBh
Z2UgY29uZmlndXJhdGlvbnMuDQoNCldoaWxlIG1vc3QgZmlsZXN5c3RlbXMg
bGV2ZXJhZ2UgZXhpc3RpbmcgbWlncmF0aW9uIGltcGxlbWVudGF0aW9ucyBs
aWtlDQpmaWxlbWFwX21pZ3JhdGVfZm9saW8oKSwgYnVmZmVyX21pZ3JhdGVf
Zm9saW9fbm9yZWZzKCkgb3INCmJ1ZmZlcl9taWdyYXRlX2ZvbGlvKCkgKHdo
aWNoIGludGVybmFsbHkgdXNlZCBmb2xpb19leHBlY3RlZF9yZWZzKCkpLA0K
SkZTJ3MgbWV0YXBhZ2UgYXJjaGl0ZWN0dXJlIHJlcXVpcmVzIHNwZWNpYWwg
aGFuZGxpbmcgb2YgaXRzIHByaXZhdGUgZGF0YQ0KZHVyaW5nIG1pZ3JhdGlv
bi4gIFRvIHN1cHBvcnQgdGhpcywgdGhpcyBzZXJpZXMgaW50cm9kdWNlIHRo
ZQ0KZm9saW9fZXhwZWN0ZWRfcmVmX2NvdW50KCksIHdoaWNoIGNhbGN1bGF0
ZXMgZXh0ZXJuYWwgcmVmZXJlbmNlcyB0byBhDQpmb2xpbyBmcm9tIHBhZ2Uv
c3dhcCBjYWNoZSwgcHJpdmF0ZSBkYXRhLCBhbmQgcGFnZSB0YWJsZSBtYXBw
aW5ncy4NCg0KVGhpcyBzdGFuZGFyZGl6ZWQgaW1wbGVtZW50YXRpb24gcmVw
bGFjZXMgdGhlIHByZXZpb3VzIGFkLWhvYw0KZm9saW9fZXhwZWN0ZWRfcmVm
cygpIGZ1bmN0aW9uIGFuZCBlbmFibGVzIEpGUyB0byBhY2N1cmF0ZWx5IGRl
dGVybWluZQ0Kd2hldGhlciBhIGZvbGlvIGhhcyB1bmV4cGVjdGVkIHJlZmVy
ZW5jZXMgYmVmb3JlIGF0dGVtcHRpbmcgbWlncmF0aW9uLg0KDQpJbXBsZW1l
bnQgZm9saW9fZXhwZWN0ZWRfcmVmX2NvdW50KCkgdG8gY2FsY3VsYXRlIGV4
cGVjdGVkIGZvbGlvIHJlZmVyZW5jZQ0KY291bnRzIGZyb206DQotIFBhZ2Uv
c3dhcCBjYWNoZSAoMSBwZXIgcGFnZSkNCi0gUHJpdmF0ZSBkYXRhICgxKQ0K
LSBQYWdlIHRhYmxlIG1hcHBpbmdzICgxIHBlciBtYXApDQoNCldoaWxlIG9y
aWdpbmFsbHkgbmVlZGVkIGZvciBwYWdlIG1pZ3JhdGlvbiBvcGVyYXRpb25z
LCB0aGlzIGltcHJvdmVkDQppbXBsZW1lbnRhdGlvbiBzdGFuZGFyZGl6ZXMg
cmVmZXJlbmNlIGNvdW50aW5nIGJ5IGNvbnNvbGlkYXRpbmcgYWxsDQpyZWZj
b3VudCBjb250cmlidXRvcnMgaW50byBhIHNpbmdsZSwgcmV1c2FibGUgZnVu
Y3Rpb24gdGhhdCBjYW4gYmVuZWZpdA0KYW55IHN1YnN5c3RlbSBuZWVkaW5n
IHRvIGRldGVjdCB1bmV4cGVjdGVkIHJlZmVyZW5jZXMgdG8gZm9saW9zLg0K
DQpUaGUgZm9saW9fZXhwZWN0ZWRfcmVmX2NvdW50KCkgcmV0dXJucyB0aGUg
c3VtIG9mIHRoZXNlIGV4dGVybmFsDQpyZWZlcmVuY2VzIHdpdGhvdXQgaW5j
bHVkaW5nIGFueSByZWZlcmVuY2UgdGhlIGNhbGxlciBpdHNlbGYgbWlnaHQg
aG9sZC4NCkNhbGxlcnMgY29tcGFyaW5nIGFnYWluc3QgdGhlIGFjdHVhbCBm
b2xpb19yZWZfY291bnQoKSBtdXN0IGFjY291bnQgZm9yDQp0aGVpciBvd24g
cmVmZXJlbmNlcyBzZXBhcmF0ZWx5Lg0KDQpMaW5rOiBodHRwczovL3N5emth
bGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9OGJiNmZkOTQ1YWY0ZTBhZDky
OTkgWzFdDQpMaW5rOiBodHRwczovL2xrbWwua2VybmVsLm9yZy9yLzIwMjUw
NDMwMTAwMTUwLjI3OTc1MS0xLXNoaXZhbmtnQGFtZC5jb20NCkxpbms6IGh0
dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAyNTA0MzAxMDAxNTAuMjc5NzUx
LTItc2hpdmFua2dAYW1kLmNvbQ0KU2lnbmVkLW9mZi1ieTogRGF2aWQgSGls
ZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBT
aGl2YW5rIEdhcmcgPHNoaXZhbmtnQGFtZC5jb20+DQpTdWdnZXN0ZWQtYnk6
IE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZyYWRlYWQub3JnPg0KQ28tZGV2
ZWxvcGVkLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNv
bT4NCkNjOiBBbGlzdGFpciBQb3BwbGUgPGFwb3BwbGVAbnZpZGlhLmNvbT4N
CkNjOiBEYXZlIEtsZWlrYW1wIDxzaGFnZ3lAa2VybmVsLm9yZz4NCkNjOiBE
b25ldCBUb20gPGRvbmV0dG9tQGxpbnV4LmlibS5jb20+DQpDYzogSmFuZSBD
aHUgPGphbmUuY2h1QG9yYWNsZS5jb20+DQpDYzogS2VmZW5nIFdhbmcgPHdh
bmdrZWZlbmcud2FuZ0BodWF3ZWkuY29tPg0KQ2M6IFppIFlhbiA8eml5QG52
aWRpYS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgTW9ydG9uIDxha3Bt
QGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KU3RhYmxlLWRlcC1vZjogOThjNmQy
NTkzMTllICgibW0vZ3VwOiBjaGVjayByZWZfY291bnQgaW5zdGVhZCBvZiBs
cnUgYmVmb3JlIG1pZ3JhdGlvbiIpDQpbIFRha2UgdGhlIG5ldyBmdW5jdGlv
biBpbiBtbS5oLCByZW1vdmluZyAiY29uc3QiIGZyb20gaXRzIHBhcmFtZXRl
ciB0byBzdG9wDQogIGJ1aWxkIHdhcm5pbmdzOyBidXQgYXZvaWQgYWxsIHRo
ZSBjb25mbGljdHMgb2YgdXNpbmcgaXQgaW4gbW0vbWlncmF0ZS5jLiBdDQpT
aWduZWQtb2ZmLWJ5OiBIdWdoIERpY2tpbnMgPGh1Z2hkQGdvb2dsZS5jb20+
DQotLS0NCiBpbmNsdWRlL2xpbnV4L21tLmggfCA1NSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNo
YW5nZWQsIDU1IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvbW0uaCBiL2luY2x1ZGUvbGludXgvbW0uaA0KaW5kZXggYjk3
ZDhhNjkxYjI4Li5iYTc3ZjA4OTAwY2EgMTAwNjQ0DQotLS0gYS9pbmNsdWRl
L2xpbnV4L21tLmgNCisrKyBiL2luY2x1ZGUvbGludXgvbW0uaA0KQEAgLTIx
NTYsNiArMjE1Niw2MSBAQCBzdGF0aWMgaW5saW5lIGludCBmb2xpb19lc3Rp
bWF0ZWRfc2hhcmVycyhzdHJ1Y3QgZm9saW8gKmZvbGlvKQ0KIAlyZXR1cm4g
cGFnZV9tYXBjb3VudChmb2xpb19wYWdlKGZvbGlvLCAwKSk7DQogfQ0KIA0K
Ky8qKg0KKyAqIGZvbGlvX2V4cGVjdGVkX3JlZl9jb3VudCAtIGNhbGN1bGF0
ZSB0aGUgZXhwZWN0ZWQgZm9saW8gcmVmY291bnQNCisgKiBAZm9saW86IHRo
ZSBmb2xpbw0KKyAqDQorICogQ2FsY3VsYXRlIHRoZSBleHBlY3RlZCBmb2xp
byByZWZjb3VudCwgdGFraW5nIHJlZmVyZW5jZXMgZnJvbSB0aGUgcGFnZWNh
Y2hlLA0KKyAqIHN3YXBjYWNoZSwgUEdfcHJpdmF0ZSBhbmQgcGFnZSB0YWJs
ZSBtYXBwaW5ncyBpbnRvIGFjY291bnQuIFVzZWZ1bCBpbg0KKyAqIGNvbWJp
bmF0aW9uIHdpdGggZm9saW9fcmVmX2NvdW50KCkgdG8gZGV0ZWN0IHVuZXhw
ZWN0ZWQgcmVmZXJlbmNlcyAoZS5nLiwNCisgKiBHVVAgb3Igb3RoZXIgdGVt
cG9yYXJ5IHJlZmVyZW5jZXMpLg0KKyAqDQorICogRG9lcyBjdXJyZW50bHkg
bm90IGNvbnNpZGVyIHJlZmVyZW5jZXMgZnJvbSB0aGUgTFJVIGNhY2hlLiBJ
ZiB0aGUgZm9saW8NCisgKiB3YXMgaXNvbGF0ZWQgZnJvbSB0aGUgTFJVICh3
aGljaCBpcyB0aGUgY2FzZSBkdXJpbmcgbWlncmF0aW9uIG9yIHNwbGl0KSwN
CisgKiB0aGUgTFJVIGNhY2hlIGRvZXMgbm90IGFwcGx5Lg0KKyAqDQorICog
Q2FsbGluZyB0aGlzIGZ1bmN0aW9uIG9uIGFuIHVubWFwcGVkIGZvbGlvIC0t
ICFmb2xpb19tYXBwZWQoKSAtLSB0aGF0IGlzDQorICogbG9ja2VkIHdpbGwg
cmV0dXJuIGEgc3RhYmxlIHJlc3VsdC4NCisgKg0KKyAqIENhbGxpbmcgdGhp
cyBmdW5jdGlvbiBvbiBhIG1hcHBlZCBmb2xpbyB3aWxsIG5vdCByZXN1bHQg
aW4gYSBzdGFibGUgcmVzdWx0LA0KKyAqIGJlY2F1c2Ugbm90aGluZyBzdG9w
cyBhZGRpdGlvbmFsIHBhZ2UgdGFibGUgbWFwcGluZ3MgZnJvbSBjb21pbmcg
KGUuZy4sDQorICogZm9yaygpKSBvciBnb2luZyAoZS5nLiwgbXVubWFwKCkp
Lg0KKyAqDQorICogQ2FsbGluZyB0aGlzIGZ1bmN0aW9uIHdpdGhvdXQgdGhl
IGZvbGlvIGxvY2sgd2lsbCBhbHNvIG5vdCByZXN1bHQgaW4gYQ0KKyAqIHN0
YWJsZSByZXN1bHQ6IGZvciBleGFtcGxlLCB0aGUgZm9saW8gbWlnaHQgZ2V0
IGRyb3BwZWQgZnJvbSB0aGUgc3dhcGNhY2hlDQorICogY29uY3VycmVudGx5
Lg0KKyAqDQorICogSG93ZXZlciwgZXZlbiB3aGVuIGNhbGxlZCB3aXRob3V0
IHRoZSBmb2xpbyBsb2NrIG9yIG9uIGEgbWFwcGVkIGZvbGlvLA0KKyAqIHRo
aXMgZnVuY3Rpb24gY2FuIGJlIHVzZWQgdG8gZGV0ZWN0IHVuZXhwZWN0ZWQg
cmVmZXJlbmNlcyBlYXJseSAoZm9yIGV4YW1wbGUsDQorICogaWYgaXQgbWFr
ZXMgc2Vuc2UgdG8gZXZlbiBsb2NrIHRoZSBmb2xpbyBhbmQgdW5tYXAgaXQp
Lg0KKyAqDQorICogVGhlIGNhbGxlciBtdXN0IGFkZCBhbnkgcmVmZXJlbmNl
IChlLmcuLCBmcm9tIGZvbGlvX3RyeV9nZXQoKSkgaXQgbWlnaHQgYmUNCisg
KiBob2xkaW5nIGl0c2VsZiB0byB0aGUgcmVzdWx0Lg0KKyAqDQorICogUmV0
dXJucyB0aGUgZXhwZWN0ZWQgZm9saW8gcmVmY291bnQuDQorICovDQorc3Rh
dGljIGlubGluZSBpbnQgZm9saW9fZXhwZWN0ZWRfcmVmX2NvdW50KHN0cnVj
dCBmb2xpbyAqZm9saW8pDQorew0KKwljb25zdCBpbnQgb3JkZXIgPSBmb2xp
b19vcmRlcihmb2xpbyk7DQorCWludCByZWZfY291bnQgPSAwOw0KKw0KKwlp
ZiAoV0FSTl9PTl9PTkNFKGZvbGlvX3Rlc3Rfc2xhYihmb2xpbykpKQ0KKwkJ
cmV0dXJuIDA7DQorDQorCWlmIChmb2xpb190ZXN0X2Fub24oZm9saW8pKSB7
DQorCQkvKiBPbmUgcmVmZXJlbmNlIHBlciBwYWdlIGZyb20gdGhlIHN3YXBj
YWNoZS4gKi8NCisJCXJlZl9jb3VudCArPSBmb2xpb190ZXN0X3N3YXBjYWNo
ZShmb2xpbykgPDwgb3JkZXI7DQorCX0gZWxzZSBpZiAoISgodW5zaWduZWQg
bG9uZylmb2xpby0+bWFwcGluZyAmIFBBR0VfTUFQUElOR19GTEFHUykpIHsN
CisJCS8qIE9uZSByZWZlcmVuY2UgcGVyIHBhZ2UgZnJvbSB0aGUgcGFnZWNh
Y2hlLiAqLw0KKwkJcmVmX2NvdW50ICs9ICEhZm9saW8tPm1hcHBpbmcgPDwg
b3JkZXI7DQorCQkvKiBPbmUgcmVmZXJlbmNlIGZyb20gUEdfcHJpdmF0ZS4g
Ki8NCisJCXJlZl9jb3VudCArPSBmb2xpb190ZXN0X3ByaXZhdGUoZm9saW8p
Ow0KKwl9DQorDQorCS8qIE9uZSByZWZlcmVuY2UgcGVyIHBhZ2UgdGFibGUg
bWFwcGluZy4gKi8NCisJcmV0dXJuIHJlZl9jb3VudCArIGZvbGlvX21hcGNv
dW50KGZvbGlvKTsNCit9DQorDQogI2lmbmRlZiBIQVZFX0FSQ0hfTUFLRV9Q
QUdFX0FDQ0VTU0lCTEUNCiBzdGF0aWMgaW5saW5lIGludCBhcmNoX21ha2Vf
cGFnZV9hY2Nlc3NpYmxlKHN0cnVjdCBwYWdlICpwYWdlKQ0KIHsNCi0tIA0K
Mi41MS4wLjUzNC5nYzc5MDk1YzBjYS1nb29nDQoNCg==

---1463770367-1835507063-1758699986=:6369
Content-Type: text/x-patch; name=0003-mm-gup-check-ref_count-instead-of-lru-before-migrati.patch
Content-Transfer-Encoding: BASE64
Content-ID: <fc4c6066-f63e-640c-17c7-05ffcd8966ec@google.com>
Content-Description: 
Content-Disposition: attachment; filename=0003-mm-gup-check-ref_count-instead-of-lru-before-migrati.patch

RnJvbSA2NDQ2N2IwYjlmZjdiYTJjZGRjNDg1NWFhODcyNmFmZGFmYmMxNDQ0
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSHVnaCBEaWNraW5z
IDxodWdoZEBnb29nbGUuY29tPg0KRGF0ZTogTW9uLCA4IFNlcCAyMDI1IDE1
OjE1OjAzIC0wNzAwDQpTdWJqZWN0OiBbUEFUQ0ggMy81XSBtbS9ndXA6IGNo
ZWNrIHJlZl9jb3VudCBpbnN0ZWFkIG9mIGxydSBiZWZvcmUgbWlncmF0aW9u
DQoNClsgVXBzdHJlYW0gY29tbWl0IDk4YzZkMjU5MzE5ZWNmNmU4ZDAyN2Fi
ZDNmMTRiODEzMjRiOGMwYWQgXQ0KDQpQYXRjaCBzZXJpZXMgIm1tOiBiZXR0
ZXIgR1VQIHBpbiBscnVfYWRkX2RyYWluX2FsbCgpIiwgdjIuDQoNClNlcmll
cyBvZiBscnVfYWRkX2RyYWluX2FsbCgpLXJlbGF0ZWQgcGF0Y2hlcywgYXJp
c2luZyBmcm9tIHJlY2VudCBtbS9ndXANCm1pZ3JhdGlvbiByZXBvcnQgZnJv
bSBXaWxsIERlYWNvbi4NCg0KVGhpcyBwYXRjaCAob2YgNSk6DQoNCldpbGwg
RGVhY29uIHJlcG9ydHM6LQ0KDQpXaGVuIHRha2luZyBhIGxvbmd0ZXJtIEdV
UCBwaW4gdmlhIHBpbl91c2VyX3BhZ2VzKCksDQpfX2d1cF9sb25ndGVybV9s
b2NrZWQoKSB0cmllcyB0byBtaWdyYXRlIHRhcmdldCBmb2xpb3MgdGhhdCBz
aG91bGQgbm90IGJlDQpsb25ndGVybSBwaW5uZWQsIGZvciBleGFtcGxlIGJl
Y2F1c2UgdGhleSByZXNpZGUgaW4gYSBDTUEgcmVnaW9uIG9yDQptb3ZhYmxl
IHpvbmUuICBUaGlzIGlzIGRvbmUgYnkgZmlyc3QgcGlubmluZyBhbGwgb2Yg
dGhlIHRhcmdldCBmb2xpb3MNCmFueXdheSwgY29sbGVjdGluZyBhbGwgb2Yg
dGhlIGxvbmd0ZXJtLXVucGlubmFibGUgdGFyZ2V0IGZvbGlvcyBpbnRvIGEN
Cmxpc3QsIGRyb3BwaW5nIHRoZSBwaW5zIHRoYXQgd2VyZSBqdXN0IHRha2Vu
IGFuZCBmaW5hbGx5IGhhbmRpbmcgdGhlIGxpc3QNCm9mZiB0byBtaWdyYXRl
X3BhZ2VzKCkgZm9yIHRoZSBhY3R1YWwgbWlncmF0aW9uLg0KDQpJdCBpcyBj
cml0aWNhbGx5IGltcG9ydGFudCB0aGF0IG5vIHVuZXhwZWN0ZWQgcmVmZXJl
bmNlcyBhcmUgaGVsZCBvbiB0aGUNCmZvbGlvcyBiZWluZyBtaWdyYXRlZCwg
b3RoZXJ3aXNlIHRoZSBtaWdyYXRpb24gd2lsbCBmYWlsIGFuZA0KcGluX3Vz
ZXJfcGFnZXMoKSB3aWxsIHJldHVybiAtRU5PTUVNIHRvIGl0cyBjYWxsZXIu
ICBVbmZvcnR1bmF0ZWx5LCBpdCBpcw0KcmVsYXRpdmVseSBlYXN5IHRvIG9i
c2VydmUgbWlncmF0aW9uIGZhaWx1cmVzIHdoZW4gcnVubmluZyBwS1ZNICh3
aGljaA0KdXNlcyBwaW5fdXNlcl9wYWdlcygpIG9uIGNyb3N2bSdzIHZpcnR1
YWwgYWRkcmVzcyBzcGFjZSB0byByZXNvbHZlIHN0YWdlLTINCnBhZ2UgZmF1
bHRzIGZyb20gdGhlIGd1ZXN0KSBvbiBhIDYuMTUtYmFzZWQgUGl4ZWwgNiBk
ZXZpY2UgYW5kIHRoaXMNCnJlc3VsdHMgaW4gdGhlIFZNIHRlcm1pbmF0aW5n
IHByZW1hdHVyZWx5Lg0KDQpJbiB0aGUgZmFpbHVyZSBjYXNlLCAnY3Jvc3Zt
JyBoYXMgY2FsbGVkIG1sb2NrKE1MT0NLX09ORkFVTFQpIG9uIGl0cw0KbWFw
cGluZyBvZiBndWVzdCBtZW1vcnkgcHJpb3IgdG8gdGhlIHBpbm5pbmcuICBT
dWJzZXF1ZW50bHksIHdoZW4NCnBpbl91c2VyX3BhZ2VzKCkgd2Fsa3MgdGhl
IHBhZ2UtdGFibGUsIHRoZSByZWxldmFudCAncHRlJyBpcyBub3QgcHJlc2Vu
dA0KYW5kIHNvIHRoZSBmYXVsdGluZyBsb2dpYyBhbGxvY2F0ZXMgYSBuZXcg
Zm9saW8sIG1sb2NrcyBpdCB3aXRoDQptbG9ja19mb2xpbygpIGFuZCBtYXBz
IGl0IGluIHRoZSBwYWdlLXRhYmxlLg0KDQpTaW5jZSBjb21taXQgMmZiYjBj
MTBkMWU4ICgibW0vbXVubG9jazogbWxvY2tfcGFnZSgpIG11bmxvY2tfcGFn
ZSgpIGJhdGNoDQpieSBwYWdldmVjIiksIG1sb2NrL211bmxvY2sgb3BlcmF0
aW9ucyBvbiBhIGZvbGlvIChmb3JtZXJseSBwYWdlKSwgYXJlDQpkZWZlcnJl
ZC4gIEZvciBleGFtcGxlLCBtbG9ja19mb2xpbygpIHRha2VzIGFuIGFkZGl0
aW9uYWwgcmVmZXJlbmNlIG9uIHRoZQ0KdGFyZ2V0IGZvbGlvIGJlZm9yZSBw
bGFjaW5nIGl0IGludG8gYSBwZXItY3B1ICdmb2xpb19iYXRjaCcgZm9yIGxh
dGVyDQpwcm9jZXNzaW5nIGJ5IG1sb2NrX2ZvbGlvX2JhdGNoKCksIHdoaWNo
IGRyb3BzIHRoZSByZWZjb3VudCBvbmNlIHRoZQ0Kb3BlcmF0aW9uIGlzIGNv
bXBsZXRlLiAgUHJvY2Vzc2luZyBvZiB0aGUgYmF0Y2hlcyBpcyBjb3VwbGVk
IHdpdGggdGhlIExSVQ0KYmF0Y2ggbG9naWMgYW5kIGNhbiBiZSBmb3JjZWZ1
bGx5IGRyYWluZWQgd2l0aCBscnVfYWRkX2RyYWluX2FsbCgpIGJ1dCBhcw0K
bG9uZyBhcyBhIGZvbGlvIHJlbWFpbnMgdW5wcm9jZXNzZWQgb24gdGhlIGJh
dGNoLCBpdHMgcmVmY291bnQgd2lsbCBiZQ0KZWxldmF0ZWQuDQoNClRoaXMg
ZGVmZXJyZWQgYmF0Y2hpbmcgdGhlcmVmb3JlIGludGVyYWN0cyBwb29ybHkg
d2l0aCB0aGUgcEtWTSBwaW5uaW5nDQpzY2VuYXJpbyBhcyB3ZSBjYW4gZmlu
ZCBvdXJzZWx2ZXMgaW4gYSBzaXR1YXRpb24gd2hlcmUgdGhlIG1pZ3JhdGlv
biBjb2RlDQpmYWlscyB0byBtaWdyYXRlIGEgZm9saW8gZHVlIHRvIHRoZSBl
bGV2YXRlZCByZWZjb3VudCBmcm9tIHRoZSBwZW5kaW5nDQptbG9jayBvcGVy
YXRpb24uDQoNCkh1Z2ggRGlja2lucyBhZGRzOi0NCg0KIWZvbGlvX3Rlc3Rf
bHJ1KCkgaGFzIG5ldmVyIGJlZW4gYSB2ZXJ5IHJlbGlhYmxlIHdheSB0byB0
ZWxsIGlmIGFuDQpscnVfYWRkX2RyYWluX2FsbCgpIGlzIHdvcnRoIGNhbGxp
bmcsIHRvIHJlbW92ZSBMUlUgY2FjaGUgcmVmZXJlbmNlcyB0bw0KbWFrZSB0
aGUgZm9saW8gbWlncmF0YWJsZTogdGhlIExSVSBmbGFnIG1heSBiZSBzZXQg
ZXZlbiB3aGlsZSB0aGUgZm9saW8gaXMNCmhlbGQgd2l0aCBhbiBleHRyYSBy
ZWZlcmVuY2UgaW4gYSBwZXItQ1BVIExSVSBjYWNoZS4NCg0KNS4xOCBjb21t
aXQgMmZiYjBjMTBkMWU4IG1heSBoYXZlIG1hZGUgaXQgbW9yZSB1bnJlbGlh
YmxlLiAgVGhlbiA2LjExDQpjb21taXQgMzNkZmU5MjA0ZjI5ICgibW0vZ3Vw
OiBjbGVhciB0aGUgTFJVIGZsYWcgb2YgYSBwYWdlIGJlZm9yZSBhZGRpbmcN
CnRvIExSVSBiYXRjaCIpIHRyaWVkIHRvIG1ha2UgaXQgcmVsaWFibGUsIGJ5
IG1vdmluZyBMUlUgZmxhZyBjbGVhcmluZzsgYnV0DQptaXNzZWQgdGhlIG1s
b2NrL211bmxvY2sgYmF0Y2hlcywgc28gc3RpbGwgdW5yZWxpYWJsZSBhcyBy
ZXBvcnRlZC4NCg0KQW5kIGl0IHR1cm5zIG91dCB0byBiZSBkaWZmaWN1bHQg
dG8gZXh0ZW5kIDMzZGZlOTIwNGYyOSdzIExSVSBmbGFnDQpjbGVhcmluZyB0
byB0aGUgbWxvY2svbXVubG9jayBiYXRjaGVzOiBpZiB0aGV5IGRvIGJlbmVm
aXQgZnJvbSBiYXRjaGluZywNCm1sb2NrL211bmxvY2sgY2Fubm90IGJlIHNv
IGVmZmVjdGl2ZSB3aGVuIGVhc2lseSBzdXBwcmVzc2VkIHdoaWxlICFMUlUu
DQoNCkluc3RlYWQsIHN3aXRjaCB0byBhbiBleHBlY3RlZCByZWZfY291bnQg
Y2hlY2ssIHdoaWNoIHdhcyBtb3JlIHJlbGlhYmxlDQphbGwgYWxvbmc6IHNv
bWUgbW9yZSBmYWxzZSBwb3NpdGl2ZXMgKHVuaGVscGZ1bCBkcmFpbnMpIHRo
YW4gYmVmb3JlLCBhbmQNCm5ldmVyIGEgZ3VhcmFudGVlIHRoYXQgdGhlIGZv
bGlvIHdpbGwgcHJvdmUgbWlncmF0YWJsZSwgYnV0IGJldHRlci4NCg0KTm90
ZSBvbiBQR19wcml2YXRlXzI6IGNlcGggYW5kIG5mcyBhcmUgc3RpbGwgdXNp
bmcgdGhlIGRlcHJlY2F0ZWQNClBHX3ByaXZhdGVfMiBmbGFnLCB3aXRoIHRo
ZSBhaWQgb2YgbmV0ZnMgYW5kIGZpbGVtYXAgc3VwcG9ydCBmdW5jdGlvbnMu
DQpBbHRob3VnaCBpdCBpcyBjb25zaXN0ZW50bHkgbWF0Y2hlZCBieSBhbiBp
bmNyZW1lbnQgb2YgZm9saW8gcmVmX2NvdW50LA0KZm9saW9fZXhwZWN0ZWRf
cmVmX2NvdW50KCkgaW50ZW50aW9uYWxseSBkb2VzIG5vdCByZWNvZ25pemUg
aXQsIGFuZCBjZXBoDQpmb2xpbyBtaWdyYXRpb24gY3VycmVudGx5IGRlcGVu
ZHMgb24gdGhhdCBmb3IgUEdfcHJpdmF0ZV8yIGZvbGlvcyB0byBiZQ0KcmVq
ZWN0ZWQuICBOZXcgcmVmZXJlbmNlcyB0byB0aGUgZGVwcmVjYXRlZCBmbGFn
IGFyZSBkaXNjb3VyYWdlZCwgc28gZG8NCm5vdCBhZGQgaXQgaW50byB0aGUg
Y29sbGVjdF9sb25ndGVybV91bnBpbm5hYmxlX2ZvbGlvcygpIGNhbGN1bGF0
aW9uOiBidXQNCmxvbmd0ZXJtIHBpbm5pbmcgb2YgdHJhbnNpZW50bHkgUEdf
cHJpdmF0ZV8yIGNlcGggYW5kIG5mcyBmb2xpb3MgKGFuDQp1bmNvbW1vbiBj
YXNlKSBtYXkgaW52b2tlIGEgcmVkdW5kYW50IGxydV9hZGRfZHJhaW5fYWxs
KCkuICBBbmQgdGhpcyBtYWtlcw0KZWFzeSB0aGUgYmFja3BvcnQgdG8gZWFy
bGllciByZWxlYXNlczogdXAgdG8gYW5kIGluY2x1ZGluZyA2LjEyLCBidHJm
cw0KYWxzbyB1c2VkIFBHX3ByaXZhdGVfMiwgYnV0IHdpdGhvdXQgYSByZWZf
Y291bnQgaW5jcmVtZW50Lg0KDQpOb3RlIGZvciBzdGFibGUgYmFja3BvcnRz
OiByZXF1aXJlcyA2LjE2IGNvbW1pdCA4NmViZDUwMjI0YzAgKCJtbToNCmFk
ZCBmb2xpb19leHBlY3RlZF9yZWZfY291bnQoKSBmb3IgcmVmZXJlbmNlIGNv
dW50IGNhbGN1bGF0aW9uIikuDQoNCkxpbms6IGh0dHBzOi8vbGttbC5rZXJu
ZWwub3JnL3IvNDEzOTU5NDQtYjBlMy1jM2FjLWQ2NDgtOGRkZDcwNDUxZDI4
QGdvb2dsZS5jb20NCkxpbms6IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3Iv
YmQxZjMxNGEtZmNhMS04ZjE5LWNhYzAtYjkzNmM5NjE0NTU3QGdvb2dsZS5j
b20NCkZpeGVzOiA5YTRlOWYzYjJkNzMgKCJtbTogdXBkYXRlIGdldF91c2Vy
X3BhZ2VzX2xvbmd0ZXJtIHRvIG1pZ3JhdGUgcGFnZXMgYWxsb2NhdGVkIGZy
b20gQ01BIHJlZ2lvbiIpDQpTaWduZWQtb2ZmLWJ5OiBIdWdoIERpY2tpbnMg
PGh1Z2hkQGdvb2dsZS5jb20+DQpSZXBvcnRlZC1ieTogV2lsbCBEZWFjb24g
PHdpbGxAa2VybmVsLm9yZz4NCkNsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtbW0vMjAyNTA4MTUxMDE4NTguMjQzNTItMS13aWxsQGtl
cm5lbC5vcmcvDQpBY2tlZC1ieTogS2lyeWwgU2h1dHNlbWF1IDxrYXNAa2Vy
bmVsLm9yZz4NCkFja2VkLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRA
cmVkaGF0LmNvbT4NCkNjOiAiQW5lZXNoIEt1bWFyIEsuViIgPGFuZWVzaC5r
dW1hckBrZXJuZWwub3JnPg0KQ2M6IEF4ZWwgUmFzbXVzc2VuIDxheGVscmFz
bXVzc2VuQGdvb2dsZS5jb20+DQpDYzogQ2hyaXMgTGkgPGNocmlzbEBrZXJu
ZWwub3JnPg0KQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFk
Lm9yZz4NCkNjOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCkNj
OiBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0BjbXB4Y2hnLm9yZz4NCkNjOiBK
b2huIEh1YmJhcmQgPGpodWJiYXJkQG52aWRpYS5jb20+DQpDYzogS2VpciBG
cmFzZXIgPGtlaXJmQGdvb2dsZS5jb20+DQpDYzogS29uc3RhbnRpbiBLaGxl
Ym5pa292IDxrb2N0OWlAZ21haWwuY29tPg0KQ2M6IExpIFpoZSA8bGl6aGUu
NjdAYnl0ZWRhbmNlLmNvbT4NCkNjOiBNYXR0aGV3IFdpbGNveCAoT3JhY2xl
KSA8d2lsbHlAaW5mcmFkZWFkLm9yZz4NCkNjOiBQZXRlciBYdSA8cGV0ZXJ4
QHJlZGhhdC5jb20+DQpDYzogUmlrIHZhbiBSaWVsIDxyaWVsQHN1cnJpZWwu
Y29tPg0KQ2M6IFNoaXZhbmsgR2FyZyA8c2hpdmFua2dAYW1kLmNvbT4NCkNj
OiBWbGFzdGltaWwgQmFia2EgPHZiYWJrYUBzdXNlLmN6Pg0KQ2M6IFdlaSBY
dSA8d2VpeHVnY0Bnb29nbGUuY29tPg0KQ2M6IHlhbmdnZSA8eWFuZ2dlMTEx
NkAxMjYuY29tPg0KQ2M6IFl1YW5jaHUgWGllIDx5dWFuY2h1QGdvb2dsZS5j
b20+DQpDYzogWXUgWmhhbyA8eXV6aGFvQGdvb2dsZS5jb20+DQpDYzogPHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBBbmRyZXcg
TW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KWyBDbGVhbiBj
aGVycnktcGljayBub3cgaW50byB0aGlzIHRyZWUgXQ0KU2lnbmVkLW9mZi1i
eTogSHVnaCBEaWNraW5zIDxodWdoZEBnb29nbGUuY29tPg0KLS0tDQogbW0v
Z3VwLmMgfCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL21tL2d1cC5jIGIv
bW0vZ3VwLmMNCmluZGV4IDQ5N2Q3Y2U0M2QzOS4uMDBhYzJkZjcxNjRjIDEw
MDY0NA0KLS0tIGEvbW0vZ3VwLmMNCisrKyBiL21tL2d1cC5jDQpAQCAtMTk3
NSw3ICsxOTc1LDggQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgY29sbGVjdF9s
b25ndGVybV91bnBpbm5hYmxlX3BhZ2VzKA0KIAkJCWNvbnRpbnVlOw0KIAkJ
fQ0KIA0KLQkJaWYgKCFmb2xpb190ZXN0X2xydShmb2xpbykgJiYgZHJhaW5f
YWxsb3cpIHsNCisJCWlmIChkcmFpbl9hbGxvdyAmJiBmb2xpb19yZWZfY291
bnQoZm9saW8pICE9DQorCQkJCSAgIGZvbGlvX2V4cGVjdGVkX3JlZl9jb3Vu
dChmb2xpbykgKyAxKSB7DQogCQkJbHJ1X2FkZF9kcmFpbl9hbGwoKTsNCiAJ
CQlkcmFpbl9hbGxvdyA9IGZhbHNlOw0KIAkJfQ0KLS0gDQoyLjUxLjAuNTM0
LmdjNzkwOTVjMGNhLWdvb2cNCg0K

---1463770367-1835507063-1758699986=:6369
Content-Type: text/x-patch; name=0004-mm-gup-local-lru_add_drain-to-avoid-lru_add_drain_al.patch
Content-Transfer-Encoding: BASE64
Content-ID: <f26fcb7b-6c70-1053-09fe-3789b16632ad@google.com>
Content-Description: 
Content-Disposition: attachment; filename=0004-mm-gup-local-lru_add_drain-to-avoid-lru_add_drain_al.patch

RnJvbSAyMGRlMWI0N2NmMDA0OTM3YjE2YmQzNjQ5MzZhN2RjOTM0YzMxMzZh
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSHVnaCBEaWNraW5z
IDxodWdoZEBnb29nbGUuY29tPg0KRGF0ZTogTW9uLCA4IFNlcCAyMDI1IDE1
OjE2OjUzIC0wNzAwDQpTdWJqZWN0OiBbUEFUQ0ggNC81XSBtbS9ndXA6IGxv
Y2FsIGxydV9hZGRfZHJhaW4oKSB0byBhdm9pZA0KIGxydV9hZGRfZHJhaW5f
YWxsKCkNCg0KWyBVcHN0cmVhbSBjb21taXQgYTA5YThhMWZiYjM3NGUwMDUz
Yjk3MzA2ZGE5ZGJjMDViZDM4NDY4NSBdDQoNCkluIG1hbnkgY2FzZXMsIGlm
IGNvbGxlY3RfbG9uZ3Rlcm1fdW5waW5uYWJsZV9mb2xpb3MoKSBkb2VzIG5l
ZWQgdG8gZHJhaW4NCnRoZSBMUlUgY2FjaGUgdG8gcmVsZWFzZSBhIHJlZmVy
ZW5jZSwgdGhlIGNhY2hlIGluIHF1ZXN0aW9uIGlzIG9uIHRoaXMNCnNhbWUg
Q1BVLCBhbmQgbXVjaCBtb3JlIGVmZmljaWVudGx5IGRyYWluZWQgYnkgYSBw
cmVsaW1pbmFyeSBsb2NhbA0KbHJ1X2FkZF9kcmFpbigpLCB0aGFuIHRoZSBs
YXRlciBjcm9zcy1DUFUgbHJ1X2FkZF9kcmFpbl9hbGwoKS4NCg0KTWFya2Vk
IGZvciBzdGFibGUsIHRvIGNvdW50ZXIgdGhlIGluY3JlYXNlIGluIGxydV9h
ZGRfZHJhaW5fYWxsKClzIGZyb20NCiJtbS9ndXA6IGNoZWNrIHJlZl9jb3Vu
dCBpbnN0ZWFkIG9mIGxydSBiZWZvcmUgbWlncmF0aW9uIi4gIE5vdGUgZm9y
IGNsZWFuDQpiYWNrcG9ydHM6IGNhbiB0YWtlIDYuMTYgY29tbWl0IGEwM2Ri
MjM2YWViZiAoImd1cDogb3B0aW1pemUgbG9uZ3Rlcm0NCnBpbl91c2VyX3Bh
Z2VzKCkgZm9yIGxhcmdlIGZvbGlvIikgZmlyc3QuDQoNCkxpbms6IGh0dHBz
Oi8vbGttbC5rZXJuZWwub3JnL3IvNjZmMjc1MWYtMjgzZS04MTZkLTk1MzAt
NzY1ZGI3ZWRjNDY1QGdvb2dsZS5jb20NClNpZ25lZC1vZmYtYnk6IEh1Z2gg
RGlja2lucyA8aHVnaGRAZ29vZ2xlLmNvbT4NCkFja2VkLWJ5OiBEYXZpZCBI
aWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCkNjOiAiQW5lZXNoIEt1
bWFyIEsuViIgPGFuZWVzaC5rdW1hckBrZXJuZWwub3JnPg0KQ2M6IEF4ZWwg
UmFzbXVzc2VuIDxheGVscmFzbXVzc2VuQGdvb2dsZS5jb20+DQpDYzogQ2hy
aXMgTGkgPGNocmlzbEBrZXJuZWwub3JnPg0KQ2M6IENocmlzdG9waCBIZWxs
d2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4NCkNjOiBKYXNvbiBHdW50aG9ycGUg
PGpnZ0B6aWVwZS5jYT4NCkNjOiBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0Bj
bXB4Y2hnLm9yZz4NCkNjOiBKb2huIEh1YmJhcmQgPGpodWJiYXJkQG52aWRp
YS5jb20+DQpDYzogS2VpciBGcmFzZXIgPGtlaXJmQGdvb2dsZS5jb20+DQpD
YzogS29uc3RhbnRpbiBLaGxlYm5pa292IDxrb2N0OWlAZ21haWwuY29tPg0K
Q2M6IExpIFpoZSA8bGl6aGUuNjdAYnl0ZWRhbmNlLmNvbT4NCkNjOiBNYXR0
aGV3IFdpbGNveCAoT3JhY2xlKSA8d2lsbHlAaW5mcmFkZWFkLm9yZz4NCkNj
OiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQpDYzogUmlrIHZhbiBS
aWVsIDxyaWVsQHN1cnJpZWwuY29tPg0KQ2M6IFNoaXZhbmsgR2FyZyA8c2hp
dmFua2dAYW1kLmNvbT4NCkNjOiBWbGFzdGltaWwgQmFia2EgPHZiYWJrYUBz
dXNlLmN6Pg0KQ2M6IFdlaSBYdSA8d2VpeHVnY0Bnb29nbGUuY29tPg0KQ2M6
IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+DQpDYzogeWFuZ2dlIDx5
YW5nZ2UxMTE2QDEyNi5jb20+DQpDYzogWXVhbmNodSBYaWUgPHl1YW5jaHVA
Z29vZ2xlLmNvbT4NCkNjOiBZdSBaaGFvIDx5dXpoYW9AZ29vZ2xlLmNvbT4N
CkNjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6
IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQpb
IFJlc29sdmVkIG1pbm9yIGNvbmZsaWN0cyBdDQpTaWduZWQtb2ZmLWJ5OiBI
dWdoIERpY2tpbnMgPGh1Z2hkQGdvb2dsZS5jb20+DQotLS0NCiBtbS9ndXAu
YyB8IDE1ICsrKysrKysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
bW0vZ3VwLmMgYi9tbS9ndXAuYw0KaW5kZXggMDBhYzJkZjcxNjRjLi41YmU3
NjQzOTVlMDQgMTAwNjQ0DQotLS0gYS9tbS9ndXAuYw0KKysrIGIvbW0vZ3Vw
LmMNCkBAIC0xOTUzLDcgKzE5NTMsNyBAQCBzdGF0aWMgdW5zaWduZWQgbG9u
ZyBjb2xsZWN0X2xvbmd0ZXJtX3VucGlubmFibGVfcGFnZXMoDQogew0KIAl1
bnNpZ25lZCBsb25nIGksIGNvbGxlY3RlZCA9IDA7DQogCXN0cnVjdCBmb2xp
byAqcHJldl9mb2xpbyA9IE5VTEw7DQotCWJvb2wgZHJhaW5fYWxsb3cgPSB0
cnVlOw0KKwlpbnQgZHJhaW5lZCA9IDA7DQogDQogCWZvciAoaSA9IDA7IGkg
PCBucl9wYWdlczsgaSsrKSB7DQogCQlzdHJ1Y3QgZm9saW8gKmZvbGlvID0g
cGFnZV9mb2xpbyhwYWdlc1tpXSk7DQpAQCAtMTk3NSwxMCArMTk3NSwxNyBA
QCBzdGF0aWMgdW5zaWduZWQgbG9uZyBjb2xsZWN0X2xvbmd0ZXJtX3VucGlu
bmFibGVfcGFnZXMoDQogCQkJY29udGludWU7DQogCQl9DQogDQotCQlpZiAo
ZHJhaW5fYWxsb3cgJiYgZm9saW9fcmVmX2NvdW50KGZvbGlvKSAhPQ0KLQkJ
CQkgICBmb2xpb19leHBlY3RlZF9yZWZfY291bnQoZm9saW8pICsgMSkgew0K
KwkJaWYgKGRyYWluZWQgPT0gMCAmJg0KKwkJCQlmb2xpb19yZWZfY291bnQo
Zm9saW8pICE9DQorCQkJCWZvbGlvX2V4cGVjdGVkX3JlZl9jb3VudChmb2xp
bykgKyAxKSB7DQorCQkJbHJ1X2FkZF9kcmFpbigpOw0KKwkJCWRyYWluZWQg
PSAxOw0KKwkJfQ0KKwkJaWYgKGRyYWluZWQgPT0gMSAmJg0KKwkJCQlmb2xp
b19yZWZfY291bnQoZm9saW8pICE9DQorCQkJCWZvbGlvX2V4cGVjdGVkX3Jl
Zl9jb3VudChmb2xpbykgKyAxKSB7DQogCQkJbHJ1X2FkZF9kcmFpbl9hbGwo
KTsNCi0JCQlkcmFpbl9hbGxvdyA9IGZhbHNlOw0KKwkJCWRyYWluZWQgPSAy
Ow0KIAkJfQ0KIA0KIAkJaWYgKCFmb2xpb19pc29sYXRlX2xydShmb2xpbykp
DQotLSANCjIuNTEuMC41MzQuZ2M3OTA5NWMwY2EtZ29vZw0KDQo=

---1463770367-1835507063-1758699986=:6369
Content-Type: text/x-patch; name=0005-mm-folio_may_be_lru_cached-unless-folio_test_large.patch
Content-Transfer-Encoding: BASE64
Content-ID: <b39214a9-d178-b6e8-3fbb-e80d444ef936@google.com>
Content-Description: 
Content-Disposition: attachment; filename=0005-mm-folio_may_be_lru_cached-unless-folio_test_large.patch

RnJvbSBlMzkwZjVlMzZkZGVlZmM2NmQyYTMzOTg1NTQ5YzFmMDBmOGMxOGQ4
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSHVnaCBEaWNraW5z
IDxodWdoZEBnb29nbGUuY29tPg0KRGF0ZTogTW9uLCA4IFNlcCAyMDI1IDE1
OjIzOjE1IC0wNzAwDQpTdWJqZWN0OiBbUEFUQ0ggNS81XSBtbTogZm9saW9f
bWF5X2JlX2xydV9jYWNoZWQoKSB1bmxlc3MgZm9saW9fdGVzdF9sYXJnZSgp
DQoNClsgVXBzdHJlYW0gY29tbWl0IDJkYTZkZTMwZTYwZGQ5YmIxNDYwMGVm
ZjFjYzk5ZGYyZmEyZGRhZTMgXQ0KDQptbS9zd2FwLmMgYW5kIG1tL21sb2Nr
LmMgYWdyZWUgdG8gZHJhaW4gYW55IHBlci1DUFUgYmF0Y2ggYXMgc29vbiBh
cyBhDQpsYXJnZSBmb2xpbyBpcyBhZGRlZDogc28gY29sbGVjdF9sb25ndGVy
bV91bnBpbm5hYmxlX2ZvbGlvcygpIGp1c3Qgd2FzdGVzDQplZmZvcnQgd2hl
biBjYWxsaW5nIGxydV9hZGRfZHJhaW5bX2FsbF0oKSBvbiBhIGxhcmdlIGZv
bGlvLg0KDQpCdXQgYWx0aG91Z2ggdGhlcmUgaXMgZ29vZCByZWFzb24gbm90
IHRvIGJhdGNoIHVwIFBNRC1zaXplZCBmb2xpb3MsIHdlDQptaWdodCB3ZWxs
IGJlbmVmaXQgZnJvbSBiYXRjaGluZyBhIHNtYWxsIG51bWJlciBvZiBsb3ct
b3JkZXIgbVRIUHMgKHRob3VnaA0KdW5jbGVhciBob3cgdGhhdCAic21hbGwg
bnVtYmVyIiBsaW1pdGF0aW9uIHdpbGwgYmUgaW1wbGVtZW50ZWQpLg0KDQpT
byBhc2sgaWYgZm9saW9fbWF5X2JlX2xydV9jYWNoZWQoKSByYXRoZXIgdGhh
biAhZm9saW9fdGVzdF9sYXJnZSgpLCB0bw0KaW5zdWxhdGUgdGhvc2UgcGFy
dGljdWxhciBjaGVja3MgZnJvbSBmdXR1cmUgY2hhbmdlLiAgTmFtZSBwcmVm
ZXJyZWQgdG8NCiJmb2xpb19pc19iYXRjaGFibGUiIGJlY2F1c2UgbGFyZ2Ug
Zm9saW9zIGNhbiB3ZWxsIGJlIHB1dCBvbiBhIGJhdGNoOiBpdCdzDQpqdXN0
IHRoZSBwZXItQ1BVIExSVSBjYWNoZXMsIGRyYWluZWQgbXVjaCBsYXRlciwg
d2hpY2ggbmVlZCBjYXJlLg0KDQpNYXJrZWQgZm9yIHN0YWJsZSwgdG8gY291
bnRlciB0aGUgaW5jcmVhc2UgaW4gbHJ1X2FkZF9kcmFpbl9hbGwoKXMgZnJv
bQ0KIm1tL2d1cDogY2hlY2sgcmVmX2NvdW50IGluc3RlYWQgb2YgbHJ1IGJl
Zm9yZSBtaWdyYXRpb24iLg0KDQpMaW5rOiBodHRwczovL2xrbWwua2VybmVs
Lm9yZy9yLzU3ZDJlYWY4LTM2MDctZjMxOC1lMGM1LWJlMDJkY2U2MWFkMEBn
b29nbGUuY29tDQpGaXhlczogOWE0ZTlmM2IyZDczICgibW06IHVwZGF0ZSBn
ZXRfdXNlcl9wYWdlc19sb25ndGVybSB0byBtaWdyYXRlIHBhZ2VzIGFsbG9j
YXRlZCBmcm9tIENNQSByZWdpb24iKQ0KU2lnbmVkLW9mZi1ieTogSHVnaCBE
aWNraW5zIDxodWdoZEBnb29nbGUuY29tPg0KU3VnZ2VzdGVkLWJ5OiBEYXZp
ZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCkFja2VkLWJ5OiBE
YXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCkNjOiAiQW5l
ZXNoIEt1bWFyIEsuViIgPGFuZWVzaC5rdW1hckBrZXJuZWwub3JnPg0KQ2M6
IEF4ZWwgUmFzbXVzc2VuIDxheGVscmFzbXVzc2VuQGdvb2dsZS5jb20+DQpD
YzogQ2hyaXMgTGkgPGNocmlzbEBrZXJuZWwub3JnPg0KQ2M6IENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4NCkNjOiBKYXNvbiBHdW50
aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCkNjOiBKb2hhbm5lcyBXZWluZXIgPGhh
bm5lc0BjbXB4Y2hnLm9yZz4NCkNjOiBKb2huIEh1YmJhcmQgPGpodWJiYXJk
QG52aWRpYS5jb20+DQpDYzogS2VpciBGcmFzZXIgPGtlaXJmQGdvb2dsZS5j
b20+DQpDYzogS29uc3RhbnRpbiBLaGxlYm5pa292IDxrb2N0OWlAZ21haWwu
Y29tPg0KQ2M6IExpIFpoZSA8bGl6aGUuNjdAYnl0ZWRhbmNlLmNvbT4NCkNj
OiBNYXR0aGV3IFdpbGNveCAoT3JhY2xlKSA8d2lsbHlAaW5mcmFkZWFkLm9y
Zz4NCkNjOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQpDYzogUmlr
IHZhbiBSaWVsIDxyaWVsQHN1cnJpZWwuY29tPg0KQ2M6IFNoaXZhbmsgR2Fy
ZyA8c2hpdmFua2dAYW1kLmNvbT4NCkNjOiBWbGFzdGltaWwgQmFia2EgPHZi
YWJrYUBzdXNlLmN6Pg0KQ2M6IFdlaSBYdSA8d2VpeHVnY0Bnb29nbGUuY29t
Pg0KQ2M6IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+DQpDYzogeWFu
Z2dlIDx5YW5nZ2UxMTE2QDEyNi5jb20+DQpDYzogWXVhbmNodSBYaWUgPHl1
YW5jaHVAZ29vZ2xlLmNvbT4NCkNjOiBZdSBaaGFvIDx5dXpoYW9AZ29vZ2xl
LmNvbT4NCkNjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NClNpZ25lZC1v
ZmYtYnk6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5v
cmc+DQpbIFJlc29sdmVkIGNvbmZsaWN0cyBpbiBtbS9zd2FwLmMgXQ0KU2ln
bmVkLW9mZi1ieTogSHVnaCBEaWNraW5zIDxodWdoZEBnb29nbGUuY29tPg0K
LS0tDQogaW5jbHVkZS9saW51eC9zd2FwLmggfCAxMCArKysrKysrKysrDQog
bW0vZ3VwLmMgICAgICAgICAgICAgfCAgNCArKy0tDQogbW0vbWxvY2suYyAg
ICAgICAgICAgfCAgNiArKystLS0NCiBtbS9zd2FwLmMgICAgICAgICAgICB8
ICA0ICsrLS0NCiA0IGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyks
IDcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L3N3YXAuaCBiL2luY2x1ZGUvbGludXgvc3dhcC5oDQppbmRleCBjYjI1ZGIy
YTkzZGQuLmQ3YTViNzgxNzk4NyAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGlu
dXgvc3dhcC5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3N3YXAuaA0KQEAgLTM3
NSw2ICszNzUsMTYgQEAgdm9pZCBmb2xpb19hZGRfbHJ1X3ZtYShzdHJ1Y3Qg
Zm9saW8gKiwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICopOw0KIHZvaWQgbWFy
a19wYWdlX2FjY2Vzc2VkKHN0cnVjdCBwYWdlICopOw0KIHZvaWQgZm9saW9f
bWFya19hY2Nlc3NlZChzdHJ1Y3QgZm9saW8gKik7DQogDQorc3RhdGljIGlu
bGluZSBib29sIGZvbGlvX21heV9iZV9scnVfY2FjaGVkKHN0cnVjdCBmb2xp
byAqZm9saW8pDQorew0KKwkvKg0KKwkgKiBIb2xkaW5nIFBNRC1zaXplZCBm
b2xpb3MgaW4gcGVyLUNQVSBMUlUgY2FjaGUgdW5iYWxhbmNlcyBhY2NvdW50
aW5nLg0KKwkgKiBIb2xkaW5nIHNtYWxsIG51bWJlcnMgb2YgbG93LW9yZGVy
IG1USFAgZm9saW9zIGluIHBlci1DUFUgTFJVIGNhY2hlDQorCSAqIHdpbGwg
YmUgc2Vuc2libGUsIGJ1dCBub2JvZHkgaGFzIGltcGxlbWVudGVkIGFuZCB0
ZXN0ZWQgdGhhdCB5ZXQuDQorCSAqLw0KKwlyZXR1cm4gIWZvbGlvX3Rlc3Rf
bGFyZ2UoZm9saW8pOw0KK30NCisNCiBleHRlcm4gYXRvbWljX3QgbHJ1X2Rp
c2FibGVfY291bnQ7DQogDQogc3RhdGljIGlubGluZSBib29sIGxydV9jYWNo
ZV9kaXNhYmxlZCh2b2lkKQ0KZGlmZiAtLWdpdCBhL21tL2d1cC5jIGIvbW0v
Z3VwLmMNCmluZGV4IDViZTc2NDM5NWUwNC4uNTMxNTRiNjMyOTVhIDEwMDY0
NA0KLS0tIGEvbW0vZ3VwLmMNCisrKyBiL21tL2d1cC5jDQpAQCAtMTk3NSwx
MyArMTk3NSwxMyBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBjb2xsZWN0X2xv
bmd0ZXJtX3VucGlubmFibGVfcGFnZXMoDQogCQkJY29udGludWU7DQogCQl9
DQogDQotCQlpZiAoZHJhaW5lZCA9PSAwICYmDQorCQlpZiAoZHJhaW5lZCA9
PSAwICYmIGZvbGlvX21heV9iZV9scnVfY2FjaGVkKGZvbGlvKSAmJg0KIAkJ
CQlmb2xpb19yZWZfY291bnQoZm9saW8pICE9DQogCQkJCWZvbGlvX2V4cGVj
dGVkX3JlZl9jb3VudChmb2xpbykgKyAxKSB7DQogCQkJbHJ1X2FkZF9kcmFp
bigpOw0KIAkJCWRyYWluZWQgPSAxOw0KIAkJfQ0KLQkJaWYgKGRyYWluZWQg
PT0gMSAmJg0KKwkJaWYgKGRyYWluZWQgPT0gMSAmJiBmb2xpb19tYXlfYmVf
bHJ1X2NhY2hlZChmb2xpbykgJiYNCiAJCQkJZm9saW9fcmVmX2NvdW50KGZv
bGlvKSAhPQ0KIAkJCQlmb2xpb19leHBlY3RlZF9yZWZfY291bnQoZm9saW8p
ICsgMSkgew0KIAkJCWxydV9hZGRfZHJhaW5fYWxsKCk7DQpkaWZmIC0tZ2l0
IGEvbW0vbWxvY2suYyBiL21tL21sb2NrLmMNCmluZGV4IDA2YmRmYWI4M2I1
OC4uNjg1ODA5NWMyMGRkIDEwMDY0NA0KLS0tIGEvbW0vbWxvY2suYw0KKysr
IGIvbW0vbWxvY2suYw0KQEAgLTI1Niw3ICsyNTYsNyBAQCB2b2lkIG1sb2Nr
X2ZvbGlvKHN0cnVjdCBmb2xpbyAqZm9saW8pDQogDQogCWZvbGlvX2dldChm
b2xpbyk7DQogCWlmICghZm9saW9fYmF0Y2hfYWRkKGZiYXRjaCwgbWxvY2tf
bHJ1KGZvbGlvKSkgfHwNCi0JICAgIGZvbGlvX3Rlc3RfbGFyZ2UoZm9saW8p
IHx8IGxydV9jYWNoZV9kaXNhYmxlZCgpKQ0KKwkgICAgIWZvbGlvX21heV9i
ZV9scnVfY2FjaGVkKGZvbGlvKSB8fCBscnVfY2FjaGVfZGlzYWJsZWQoKSkN
CiAJCW1sb2NrX2ZvbGlvX2JhdGNoKGZiYXRjaCk7DQogCWxvY2FsX3VubG9j
aygmbWxvY2tfZmJhdGNoLmxvY2spOw0KIH0NCkBAIC0yNzksNyArMjc5LDcg
QEAgdm9pZCBtbG9ja19uZXdfZm9saW8oc3RydWN0IGZvbGlvICpmb2xpbykN
CiANCiAJZm9saW9fZ2V0KGZvbGlvKTsNCiAJaWYgKCFmb2xpb19iYXRjaF9h
ZGQoZmJhdGNoLCBtbG9ja19uZXcoZm9saW8pKSB8fA0KLQkgICAgZm9saW9f
dGVzdF9sYXJnZShmb2xpbykgfHwgbHJ1X2NhY2hlX2Rpc2FibGVkKCkpDQor
CSAgICAhZm9saW9fbWF5X2JlX2xydV9jYWNoZWQoZm9saW8pIHx8IGxydV9j
YWNoZV9kaXNhYmxlZCgpKQ0KIAkJbWxvY2tfZm9saW9fYmF0Y2goZmJhdGNo
KTsNCiAJbG9jYWxfdW5sb2NrKCZtbG9ja19mYmF0Y2gubG9jayk7DQogfQ0K
QEAgLTMwMCw3ICszMDAsNyBAQCB2b2lkIG11bmxvY2tfZm9saW8oc3RydWN0
IGZvbGlvICpmb2xpbykNCiAJICovDQogCWZvbGlvX2dldChmb2xpbyk7DQog
CWlmICghZm9saW9fYmF0Y2hfYWRkKGZiYXRjaCwgZm9saW8pIHx8DQotCSAg
ICBmb2xpb190ZXN0X2xhcmdlKGZvbGlvKSB8fCBscnVfY2FjaGVfZGlzYWJs
ZWQoKSkNCisJICAgICFmb2xpb19tYXlfYmVfbHJ1X2NhY2hlZChmb2xpbykg
fHwgbHJ1X2NhY2hlX2Rpc2FibGVkKCkpDQogCQltbG9ja19mb2xpb19iYXRj
aChmYmF0Y2gpOw0KIAlsb2NhbF91bmxvY2soJm1sb2NrX2ZiYXRjaC5sb2Nr
KTsNCiB9DQpkaWZmIC0tZ2l0IGEvbW0vc3dhcC5jIGIvbW0vc3dhcC5jDQpp
bmRleCA0MjA4MmViYTQyZGUuLjhmZGUxYTI3YWE0OCAxMDA2NDQNCi0tLSBh
L21tL3N3YXAuYw0KKysrIGIvbW0vc3dhcC5jDQpAQCAtMjIwLDggKzIyMCw4
IEBAIHN0YXRpYyB2b2lkIGZvbGlvX2JhdGNoX21vdmVfbHJ1KHN0cnVjdCBm
b2xpb19iYXRjaCAqZmJhdGNoLCBtb3ZlX2ZuX3QgbW92ZV9mbikNCiBzdGF0
aWMgdm9pZCBmb2xpb19iYXRjaF9hZGRfYW5kX21vdmUoc3RydWN0IGZvbGlv
X2JhdGNoICpmYmF0Y2gsDQogCQlzdHJ1Y3QgZm9saW8gKmZvbGlvLCBtb3Zl
X2ZuX3QgbW92ZV9mbikNCiB7DQotCWlmIChmb2xpb19iYXRjaF9hZGQoZmJh
dGNoLCBmb2xpbykgJiYgIWZvbGlvX3Rlc3RfbGFyZ2UoZm9saW8pICYmDQot
CSAgICAhbHJ1X2NhY2hlX2Rpc2FibGVkKCkpDQorCWlmIChmb2xpb19iYXRj
aF9hZGQoZmJhdGNoLCBmb2xpbykgJiYNCisJICAgIGZvbGlvX21heV9iZV9s
cnVfY2FjaGVkKGZvbGlvKSAmJiAhbHJ1X2NhY2hlX2Rpc2FibGVkKCkpDQog
CQlyZXR1cm47DQogCWZvbGlvX2JhdGNoX21vdmVfbHJ1KGZiYXRjaCwgbW92
ZV9mbik7DQogfQ0KLS0gDQoyLjUxLjAuNTM0LmdjNzkwOTVjMGNhLWdvb2cN
Cg0K

---1463770367-1835507063-1758699986=:6369--

