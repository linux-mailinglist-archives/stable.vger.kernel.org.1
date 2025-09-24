Return-Path: <stable+bounces-181582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 417DAB98B54
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 09:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0122A2E6EA6
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 07:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DC628D82F;
	Wed, 24 Sep 2025 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gfYYAeOr"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BED028031D
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700347; cv=none; b=b5p5aYNjg4D9EHDM8nD+INu+R/wCoSKJ5EeWj49Fgd1DfmXz2Mu0V31poo4UT13RN9LqIlXvO0eqPlloduiaAI70uJWG8kkfPuUfOETqBq0cjMoTRmDfX4rKhT1+AYSLawCE+U9FJVvvROGrd0zDub/mpJgEpcxbN2obROunO70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700347; c=relaxed/simple;
	bh=sEVH+iEqHd7eb4Nll7z+J4nOljC6tUuLoYbjV7D3SBE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eSNhLk1Bdz9mHocBO7hRzVj9T54vnqkVdoRvxF3wGgxkALYQYIWO9qxS4IRRAt3q8EuJ+UIud+VDg32/A5/zmxJRW2ZHLr6PmuTZYYy1FsP6ueP96Mcctq7wr5PouP5DGVkicuIU+/GSkGsbby0yejYE4SMAn160qOmakal+/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gfYYAeOr; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-ea5ca8dbd37so4231801276.2
        for <stable@vger.kernel.org>; Wed, 24 Sep 2025 00:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758700343; x=1759305143; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WjZZVny/gSKuSeNOzRZdrI4WlVrU3+ktw/Vu0DnzldI=;
        b=gfYYAeOraB8TuqMo8taLIaepaT5mkddQBAHEa5TKGxLigQ7FH2Ajln/pbVoiKha5hu
         9H5X4lQuE+Nmbg6kKOkNbiwqehs2kPM/VmR5XGhwG15uupcfdlWp3huEhyX+i4DyfDTZ
         LKpAZSZaHnnm/YRvHDb1foc1RL8Gbili7VT8BHt6/RFLu+ZRF9DxaU8a6s9ah/Gv99H1
         9uECwknUnaqe+sdj7Z/GJT0zvNfHBD5XxUSHdCmqskQAXrTcGJfjhmclV1e56ZFFx3xe
         c79HmqE+AoFbxH4Z41D6ImbdRVaoOu2oLPYhFkjjJJdwcJB2zDbusgzguzZq/IrBjKqz
         AcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758700343; x=1759305143;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjZZVny/gSKuSeNOzRZdrI4WlVrU3+ktw/Vu0DnzldI=;
        b=lImeh9XjwSt5dnAvsR6IglBK1FiCpQJFEU9gE+InQZdunErAm/iOvOWLEhfnziozDQ
         KYsq0vUh1dRVYWVNATs/bbjmMALTrd/pdWx9CfE+n2GC/goTsGYT8RgDSl/2M9/Gq9Cp
         K2xA/LyefsjiMnLQYseFwDmcO3CSPGKR6IjqBaO5TA3TmA6fuw21fWoDI/AjCuNOycWI
         M2oSUPPn4Y1F1jnfIU/pqOEUi+VZ8u3A1iuQ0F/DHiSWjiYuA+rSGcGCpyHN57mY6Ne2
         c5cmdnMfEmmewK1V3rix1lBt4AYLWrNi7K+bjgzWfmjyWL7Cgmnf1vtmgC6m5/JD+JJq
         oRHg==
X-Forwarded-Encrypted: i=1; AJvYcCUjItBlDlj2lNJVD27OzhSu1FNaVTVLnaGyi945fYWBJ4OmAbiuPOdxE2LnYKwepYNT0OXLiX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywwnfZk6+cQi8Tgkx2V6JGGnGlXcCCqHZ2mPhFrO6qcYwc2aIR
	hA+rX3WNTdVcirJdrXy216eT/hVet1Undoi3HrV1PBkFuqzTaweqx75RO50f8I16yR5vPjGRP1N
	HDQ1C6w==
X-Gm-Gg: ASbGnctKzzwrkKPzT3gr9A/3BkIkpliSKDAGpXQHEUWHv5+wphC/mD1Mr/3BuYcM2FQ
	0SIrk9l3lTJsGo4O5BcagayXCs/HiZFtz0GmZs4jiDpjAdS3qPK717poCB0MJKFPvUheYrtqorA
	g3l7cP7vD1LGFm+w1lPtWFGGA9QcD8v8VbbMvacZCXBKdD1icw0P51GDbU0YR2Z2OJvqEscijaQ
	XQ9KDxVvf2cWsay8KNK+GT3aB5cEW9A6ejKynCfv630+XN2sKfgkCQGBB/IEW9O9yZQNo/oYhio
	QUV17Tnu9/F/ZyBmo3LFpw1D1GRwG8D2AfWJzLEFZGmz2Exvl9c5aJCpigHOrWU2Oa5fODkkb2W
	x3H5Vc+cO9l7w/U8aZ40A4R0yyEID9DfV42Mh372NYgr78przz9M4OCz/uCOcKsloxVtTI7dDDX
	TbncR5SRD3e1feCtAy6ZSbyjSl
X-Google-Smtp-Source: AGHT+IHqXMLAqb37JtIt4syBdThFG+bn9kovD4X7c6HU7+Cz4aZOFR7wca4B/V/nhAV6Ep/dTsWD0w==
X-Received: by 2002:a05:6902:2612:b0:e97:b52:a814 with SMTP id 3f1490d57ef6-eb32fab14ffmr4769799276.34.1758700342869;
        Wed, 24 Sep 2025 00:52:22 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce85420esm5724222276.20.2025.09.24.00.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 00:52:16 -0700 (PDT)
Date: Wed, 24 Sep 2025 00:52:13 -0700 (PDT)
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
 before migration" failed to apply to 6.1-stable tree
In-Reply-To: <2025092154-unnoticed-collide-5621@gregkh>
Message-ID: <03ab1aac-fcdb-43d9-452a-2b2e3f162b13@google.com>
References: <2025092154-unnoticed-collide-5621@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-134898003-1758700336=:6369"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-134898003-1758700336=:6369
Content-Type: text/plain; charset=US-ASCII

On Sun, 21 Sep 2025, gregkh@linuxfoundation.org wrote:

> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 98c6d259319ecf6e8d027abd3f14b81324b8c0ad
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092154-unnoticed-collide-5621@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
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

Five gup/lrudrain backport patches against 6.1.154-rc1 attached.
---1463770367-134898003-1758700336=:6369
Content-Type: text/x-patch; name=0001-mm-gup-revert-mm-gup-fix-infinite-loop-within-__get_.patch
Content-Transfer-Encoding: BASE64
Content-ID: <259692ec-08ac-e427-7a6f-5af1cb051e10@google.com>
Content-Description: 
Content-Disposition: attachment; filename=0001-mm-gup-revert-mm-gup-fix-infinite-loop-within-__get_.patch

RnJvbSA5ZjJmNDRmMGI0Yjg5YjdkNjZmNWVmZGVlMTllY2Y2NWY0Y2NhZjc4
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
dmVydCB2Ni4xLjEyOSBjb21taXQgYzk4NmE1ZmIxNWVkIF0NClNpZ25lZC1v
ZmYtYnk6IEh1Z2ggRGlja2lucyA8aHVnaGRAZ29vZ2xlLmNvbT4NCi0tLQ0K
IG1tL2d1cC5jIHwgMTQgKysrKysrKysrKy0tLS0NCiAxIGZpbGUgY2hhbmdl
ZCwgMTAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL21tL2d1cC5jIGIvbW0vZ3VwLmMNCmluZGV4IDM3YzU1ZTYxNDYw
ZS4uNTk5YzZiOTQ1MzE2IDEwMDY0NA0KLS0tIGEvbW0vZ3VwLmMNCisrKyBi
L21tL2d1cC5jDQpAQCAtMTk2MSwxNCArMTk2MSwxNCBAQCBzdHJ1Y3QgcGFn
ZSAqZ2V0X2R1bXBfcGFnZSh1bnNpZ25lZCBsb25nIGFkZHIpDQogLyoNCiAg
KiBSZXR1cm5zIHRoZSBudW1iZXIgb2YgY29sbGVjdGVkIHBhZ2VzLiBSZXR1
cm4gdmFsdWUgaXMgYWx3YXlzID49IDAuDQogICovDQotc3RhdGljIHZvaWQg
Y29sbGVjdF9sb25ndGVybV91bnBpbm5hYmxlX3BhZ2VzKA0KK3N0YXRpYyB1
bnNpZ25lZCBsb25nIGNvbGxlY3RfbG9uZ3Rlcm1fdW5waW5uYWJsZV9wYWdl
cygNCiAJCQkJCXN0cnVjdCBsaXN0X2hlYWQgKm1vdmFibGVfcGFnZV9saXN0
LA0KIAkJCQkJdW5zaWduZWQgbG9uZyBucl9wYWdlcywNCiAJCQkJCXN0cnVj
dCBwYWdlICoqcGFnZXMpDQogew0KKwl1bnNpZ25lZCBsb25nIGksIGNvbGxl
Y3RlZCA9IDA7DQogCXN0cnVjdCBmb2xpbyAqcHJldl9mb2xpbyA9IE5VTEw7
DQogCWJvb2wgZHJhaW5fYWxsb3cgPSB0cnVlOw0KLQl1bnNpZ25lZCBsb25n
IGk7DQogDQogCWZvciAoaSA9IDA7IGkgPCBucl9wYWdlczsgaSsrKSB7DQog
CQlzdHJ1Y3QgZm9saW8gKmZvbGlvID0gcGFnZV9mb2xpbyhwYWdlc1tpXSk7
DQpAQCAtMTk4MCw2ICsxOTgwLDggQEAgc3RhdGljIHZvaWQgY29sbGVjdF9s
b25ndGVybV91bnBpbm5hYmxlX3BhZ2VzKA0KIAkJaWYgKGZvbGlvX2lzX2xv
bmd0ZXJtX3Bpbm5hYmxlKGZvbGlvKSkNCiAJCQljb250aW51ZTsNCiANCisJ
CWNvbGxlY3RlZCsrOw0KKw0KIAkJaWYgKGZvbGlvX2lzX2RldmljZV9jb2hl
cmVudChmb2xpbykpDQogCQkJY29udGludWU7DQogDQpAQCAtMjAwMSw2ICsy
MDAzLDggQEAgc3RhdGljIHZvaWQgY29sbGVjdF9sb25ndGVybV91bnBpbm5h
YmxlX3BhZ2VzKA0KIAkJCQkgICAgTlJfSVNPTEFURURfQU5PTiArIGZvbGlv
X2lzX2ZpbGVfbHJ1KGZvbGlvKSwNCiAJCQkJICAgIGZvbGlvX25yX3BhZ2Vz
KGZvbGlvKSk7DQogCX0NCisNCisJcmV0dXJuIGNvbGxlY3RlZDsNCiB9DQog
DQogLyoNCkBAIC0yMDkzLDEwICsyMDk3LDEyIEBAIHN0YXRpYyBpbnQgbWln
cmF0ZV9sb25ndGVybV91bnBpbm5hYmxlX3BhZ2VzKA0KIHN0YXRpYyBsb25n
IGNoZWNrX2FuZF9taWdyYXRlX21vdmFibGVfcGFnZXModW5zaWduZWQgbG9u
ZyBucl9wYWdlcywNCiAJCQkJCSAgICBzdHJ1Y3QgcGFnZSAqKnBhZ2VzKQ0K
IHsNCisJdW5zaWduZWQgbG9uZyBjb2xsZWN0ZWQ7DQogCUxJU1RfSEVBRCht
b3ZhYmxlX3BhZ2VfbGlzdCk7DQogDQotCWNvbGxlY3RfbG9uZ3Rlcm1fdW5w
aW5uYWJsZV9wYWdlcygmbW92YWJsZV9wYWdlX2xpc3QsIG5yX3BhZ2VzLCBw
YWdlcyk7DQotCWlmIChsaXN0X2VtcHR5KCZtb3ZhYmxlX3BhZ2VfbGlzdCkp
DQorCWNvbGxlY3RlZCA9IGNvbGxlY3RfbG9uZ3Rlcm1fdW5waW5uYWJsZV9w
YWdlcygmbW92YWJsZV9wYWdlX2xpc3QsDQorCQkJCQkJbnJfcGFnZXMsIHBh
Z2VzKTsNCisJaWYgKCFjb2xsZWN0ZWQpDQogCQlyZXR1cm4gMDsNCiANCiAJ
cmV0dXJuIG1pZ3JhdGVfbG9uZ3Rlcm1fdW5waW5uYWJsZV9wYWdlcygmbW92
YWJsZV9wYWdlX2xpc3QsIG5yX3BhZ2VzLA0KLS0gDQoyLjUxLjAuNTM0Lmdj
NzkwOTVjMGNhLWdvb2cNCg0K

---1463770367-134898003-1758700336=:6369
Content-Type: text/x-patch; name=0002-mm-add-folio_expected_ref_count-for-reference-count-.patch
Content-Transfer-Encoding: BASE64
Content-ID: <ef063ce7-32b7-d794-ee8c-a84f747e2d9a@google.com>
Content-Description: 
Content-Disposition: attachment; filename=0002-mm-add-folio_expected_ref_count-for-reference-count-.patch

RnJvbSBmZTQzYjRjMTJiMzJmZGI1MzczMWIxMDYwM2QyMzk1YTdiZmEwYjZk
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
DQotLS0NCiBpbmNsdWRlL2xpbnV4L21tLmggfCA1NCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNo
YW5nZWQsIDU0IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvbW0uaCBiL2luY2x1ZGUvbGludXgvbW0uaA0KaW5kZXggOWUx
NzY3MGRlODQ4Li4zYmY3ODIzZTEwOTcgMTAwNjQ0DQotLS0gYS9pbmNsdWRl
L2xpbnV4L21tLmgNCisrKyBiL2luY2x1ZGUvbGludXgvbW0uaA0KQEAgLTE3
ODIsNiArMTc4Miw2MCBAQCBzdGF0aWMgaW5saW5lIGludCBmb2xpb19lc3Rp
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
dW50KGZvbGlvKTsNCit9DQogDQogI2lmbmRlZiBIQVZFX0FSQ0hfTUFLRV9Q
QUdFX0FDQ0VTU0lCTEUNCiBzdGF0aWMgaW5saW5lIGludCBhcmNoX21ha2Vf
cGFnZV9hY2Nlc3NpYmxlKHN0cnVjdCBwYWdlICpwYWdlKQ0KLS0gDQoyLjUx
LjAuNTM0LmdjNzkwOTVjMGNhLWdvb2cNCg0K

---1463770367-134898003-1758700336=:6369
Content-Type: text/x-patch; name=0003-mm-gup-check-ref_count-instead-of-lru-before-migrati.patch
Content-Transfer-Encoding: BASE64
Content-ID: <15bf861d-6c6a-44e6-da9e-d7a5a3f5b592@google.com>
Content-Description: 
Content-Disposition: attachment; filename=0003-mm-gup-check-ref_count-instead-of-lru-before-migrati.patch

RnJvbSBiZDE4OTljMGJiOTZjODRiMzc3NDM5YjVlNzRjZWJkMmQ0ZmQzZjQ4
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
bW0vZ3VwLmMNCmluZGV4IDU5OWM2Yjk0NTMxNi4uNDRlNWZlMjUzNWQwIDEw
MDY0NA0KLS0tIGEvbW0vZ3VwLmMNCisrKyBiL21tL2d1cC5jDQpAQCAtMTk5
MCw3ICsxOTkwLDggQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgY29sbGVjdF9s
b25ndGVybV91bnBpbm5hYmxlX3BhZ2VzKA0KIAkJCWNvbnRpbnVlOw0KIAkJ
fQ0KIA0KLQkJaWYgKCFmb2xpb190ZXN0X2xydShmb2xpbykgJiYgZHJhaW5f
YWxsb3cpIHsNCisJCWlmIChkcmFpbl9hbGxvdyAmJiBmb2xpb19yZWZfY291
bnQoZm9saW8pICE9DQorCQkJCSAgIGZvbGlvX2V4cGVjdGVkX3JlZl9jb3Vu
dChmb2xpbykgKyAxKSB7DQogCQkJbHJ1X2FkZF9kcmFpbl9hbGwoKTsNCiAJ
CQlkcmFpbl9hbGxvdyA9IGZhbHNlOw0KIAkJfQ0KLS0gDQoyLjUxLjAuNTM0
LmdjNzkwOTVjMGNhLWdvb2cNCg0K

---1463770367-134898003-1758700336=:6369
Content-Type: text/x-patch; name=0004-mm-gup-local-lru_add_drain-to-avoid-lru_add_drain_al.patch
Content-Transfer-Encoding: BASE64
Content-ID: <fbf2792d-a951-c197-dd6a-e751e814ebfd@google.com>
Content-Description: 
Content-Disposition: attachment; filename=0004-mm-gup-local-lru_add_drain-to-avoid-lru_add_drain_al.patch

RnJvbSA1MmE5ZGQzMmM2NGQzNTY0MjRkMjRkYzhjZTEzY2JhNTBhMWU4YTg3
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
bW0vZ3VwLmMgYi9tbS9ndXAuYw0KaW5kZXggNDRlNWZlMjUzNWQwLi5lMWYx
MjVhZjljODQgMTAwNjQ0DQotLS0gYS9tbS9ndXAuYw0KKysrIGIvbW0vZ3Vw
LmMNCkBAIC0xOTY4LDcgKzE5NjgsNyBAQCBzdGF0aWMgdW5zaWduZWQgbG9u
ZyBjb2xsZWN0X2xvbmd0ZXJtX3VucGlubmFibGVfcGFnZXMoDQogew0KIAl1
bnNpZ25lZCBsb25nIGksIGNvbGxlY3RlZCA9IDA7DQogCXN0cnVjdCBmb2xp
byAqcHJldl9mb2xpbyA9IE5VTEw7DQotCWJvb2wgZHJhaW5fYWxsb3cgPSB0
cnVlOw0KKwlpbnQgZHJhaW5lZCA9IDA7DQogDQogCWZvciAoaSA9IDA7IGkg
PCBucl9wYWdlczsgaSsrKSB7DQogCQlzdHJ1Y3QgZm9saW8gKmZvbGlvID0g
cGFnZV9mb2xpbyhwYWdlc1tpXSk7DQpAQCAtMTk5MCwxMCArMTk5MCwxNyBA
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
Ow0KIAkJfQ0KIA0KIAkJaWYgKGZvbGlvX2lzb2xhdGVfbHJ1KGZvbGlvKSkN
Ci0tIA0KMi41MS4wLjUzNC5nYzc5MDk1YzBjYS1nb29nDQoNCg==

---1463770367-134898003-1758700336=:6369
Content-Type: text/x-patch; name=0005-mm-folio_may_be_lru_cached-unless-folio_test_large.patch
Content-Transfer-Encoding: BASE64
Content-ID: <d4711a40-dc5e-26b6-fcfd-5b9ff21132ed@google.com>
Content-Description: 
Content-Disposition: attachment; filename=0005-mm-folio_may_be_lru_cached-unless-folio_test_large.patch

RnJvbSBlYjRlMjcxNzM0MmMyZjI5NTlhMDNkOWY0MWRmMTNjNmNhNzFkNzIy
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
cmc+DQpbIFJlc29sdmVkIGNvbmZsaWN0cyBpbiBtbS9zd2FwLmM7IGxlZnQg
InBhZ2UiIHBhcnRzIG9mIG1tL21sb2NrLmMgYXMgaXMgXQ0KU2lnbmVkLW9m
Zi1ieTogSHVnaCBEaWNraW5zIDxodWdoZEBnb29nbGUuY29tPg0KLS0tDQog
aW5jbHVkZS9saW51eC9zd2FwLmggfCAxMCArKysrKysrKysrDQogbW0vZ3Vw
LmMgICAgICAgICAgICAgfCAgNCArKy0tDQogbW0vbWxvY2suYyAgICAgICAg
ICAgfCAgMiArLQ0KIG1tL3N3YXAuYyAgICAgICAgICAgIHwgIDQgKystLQ0K
IDQgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc3dhcC5oIGIv
aW5jbHVkZS9saW51eC9zd2FwLmgNCmluZGV4IGFkZDQ3ZjQzZTU2OC4uM2Vl
Y2Y5N2RmYmI4IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9zd2FwLmgN
CisrKyBiL2luY2x1ZGUvbGludXgvc3dhcC5oDQpAQCAtMzkyLDYgKzM5Miwx
NiBAQCB2b2lkIGxydV9jYWNoZV9hZGQoc3RydWN0IHBhZ2UgKik7DQogdm9p
ZCBtYXJrX3BhZ2VfYWNjZXNzZWQoc3RydWN0IHBhZ2UgKik7DQogdm9pZCBm
b2xpb19tYXJrX2FjY2Vzc2VkKHN0cnVjdCBmb2xpbyAqKTsNCiANCitzdGF0
aWMgaW5saW5lIGJvb2wgZm9saW9fbWF5X2JlX2xydV9jYWNoZWQoc3RydWN0
IGZvbGlvICpmb2xpbykNCit7DQorCS8qDQorCSAqIEhvbGRpbmcgUE1ELXNp
emVkIGZvbGlvcyBpbiBwZXItQ1BVIExSVSBjYWNoZSB1bmJhbGFuY2VzIGFj
Y291bnRpbmcuDQorCSAqIEhvbGRpbmcgc21hbGwgbnVtYmVycyBvZiBsb3ct
b3JkZXIgbVRIUCBmb2xpb3MgaW4gcGVyLUNQVSBMUlUgY2FjaGUNCisJICog
d2lsbCBiZSBzZW5zaWJsZSwgYnV0IG5vYm9keSBoYXMgaW1wbGVtZW50ZWQg
YW5kIHRlc3RlZCB0aGF0IHlldC4NCisJICovDQorCXJldHVybiAhZm9saW9f
dGVzdF9sYXJnZShmb2xpbyk7DQorfQ0KKw0KIGV4dGVybiBhdG9taWNfdCBs
cnVfZGlzYWJsZV9jb3VudDsNCiANCiBzdGF0aWMgaW5saW5lIGJvb2wgbHJ1
X2NhY2hlX2Rpc2FibGVkKHZvaWQpDQpkaWZmIC0tZ2l0IGEvbW0vZ3VwLmMg
Yi9tbS9ndXAuYw0KaW5kZXggZTFmMTI1YWY5Yzg0Li5iMDI5OTNjOWE4Y2Qg
MTAwNjQ0DQotLS0gYS9tbS9ndXAuYw0KKysrIGIvbW0vZ3VwLmMNCkBAIC0x
OTkwLDEzICsxOTkwLDEzIEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIGNvbGxl
Y3RfbG9uZ3Rlcm1fdW5waW5uYWJsZV9wYWdlcygNCiAJCQljb250aW51ZTsN
CiAJCX0NCiANCi0JCWlmIChkcmFpbmVkID09IDAgJiYNCisJCWlmIChkcmFp
bmVkID09IDAgJiYgZm9saW9fbWF5X2JlX2xydV9jYWNoZWQoZm9saW8pICYm
DQogCQkJCWZvbGlvX3JlZl9jb3VudChmb2xpbykgIT0NCiAJCQkJZm9saW9f
ZXhwZWN0ZWRfcmVmX2NvdW50KGZvbGlvKSArIDEpIHsNCiAJCQlscnVfYWRk
X2RyYWluKCk7DQogCQkJZHJhaW5lZCA9IDE7DQogCQl9DQotCQlpZiAoZHJh
aW5lZCA9PSAxICYmDQorCQlpZiAoZHJhaW5lZCA9PSAxICYmIGZvbGlvX21h
eV9iZV9scnVfY2FjaGVkKGZvbGlvKSAmJg0KIAkJCQlmb2xpb19yZWZfY291
bnQoZm9saW8pICE9DQogCQkJCWZvbGlvX2V4cGVjdGVkX3JlZl9jb3VudChm
b2xpbykgKyAxKSB7DQogCQkJbHJ1X2FkZF9kcmFpbl9hbGwoKTsNCmRpZmYg
LS1naXQgYS9tbS9tbG9jay5jIGIvbW0vbWxvY2suYw0KaW5kZXggNzAzMmY2
ZGQwY2UxLi4zYmY5ZTFkMjYzZGEgMTAwNjQ0DQotLS0gYS9tbS9tbG9jay5j
DQorKysgYi9tbS9tbG9jay5jDQpAQCAtMjU2LDcgKzI1Niw3IEBAIHZvaWQg
bWxvY2tfZm9saW8oc3RydWN0IGZvbGlvICpmb2xpbykNCiANCiAJZm9saW9f
Z2V0KGZvbGlvKTsNCiAJaWYgKCFwYWdldmVjX2FkZChwdmVjLCBtbG9ja19s
cnUoJmZvbGlvLT5wYWdlKSkgfHwNCi0JICAgIGZvbGlvX3Rlc3RfbGFyZ2Uo
Zm9saW8pIHx8IGxydV9jYWNoZV9kaXNhYmxlZCgpKQ0KKwkgICAgIWZvbGlv
X21heV9iZV9scnVfY2FjaGVkKGZvbGlvKSB8fCBscnVfY2FjaGVfZGlzYWJs
ZWQoKSkNCiAJCW1sb2NrX3BhZ2V2ZWMocHZlYyk7DQogCWxvY2FsX3VubG9j
aygmbWxvY2tfcHZlYy5sb2NrKTsNCiB9DQpkaWZmIC0tZ2l0IGEvbW0vc3dh
cC5jIGIvbW0vc3dhcC5jDQppbmRleCA4NWFhMDRmYzQ4YTYuLmUwZmRmMjUz
NTAwMCAxMDA2NDQNCi0tLSBhL21tL3N3YXAuYw0KKysrIGIvbW0vc3dhcC5j
DQpAQCAtMjQ5LDggKzI0OSw4IEBAIHN0YXRpYyB2b2lkIGZvbGlvX2JhdGNo
X21vdmVfbHJ1KHN0cnVjdCBmb2xpb19iYXRjaCAqZmJhdGNoLCBtb3ZlX2Zu
X3QgbW92ZV9mbikNCiBzdGF0aWMgdm9pZCBmb2xpb19iYXRjaF9hZGRfYW5k
X21vdmUoc3RydWN0IGZvbGlvX2JhdGNoICpmYmF0Y2gsDQogCQlzdHJ1Y3Qg
Zm9saW8gKmZvbGlvLCBtb3ZlX2ZuX3QgbW92ZV9mbikNCiB7DQotCWlmIChm
b2xpb19iYXRjaF9hZGQoZmJhdGNoLCBmb2xpbykgJiYgIWZvbGlvX3Rlc3Rf
bGFyZ2UoZm9saW8pICYmDQotCSAgICAhbHJ1X2NhY2hlX2Rpc2FibGVkKCkp
DQorCWlmIChmb2xpb19iYXRjaF9hZGQoZmJhdGNoLCBmb2xpbykgJiYNCisJ
ICAgIGZvbGlvX21heV9iZV9scnVfY2FjaGVkKGZvbGlvKSAmJiAhbHJ1X2Nh
Y2hlX2Rpc2FibGVkKCkpDQogCQlyZXR1cm47DQogCWZvbGlvX2JhdGNoX21v
dmVfbHJ1KGZiYXRjaCwgbW92ZV9mbik7DQogfQ0KLS0gDQoyLjUxLjAuNTM0
LmdjNzkwOTVjMGNhLWdvb2cNCg0K

---1463770367-134898003-1758700336=:6369--

