Return-Path: <stable+bounces-40297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F287C8AB187
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 17:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920071F22E1D
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5A512F5A7;
	Fri, 19 Apr 2024 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Huu6lu15"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0D112F386
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539825; cv=none; b=K0xyrNNyuZUshvKWKTz9yf3/eviKOOqJH853nH/cbHlp92yq2pVlvSXD1ZKQaM5cId9iJUQ2hAN6DXZvXj/3JAKJaSC6QBPo219xkLhHIhHH9JihgJ9GEbwhO/+FFBKtnj7IlrE34pPN5+2+e1/YrDJXlyWUP4cgFKh9uwGo+X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539825; c=relaxed/simple;
	bh=NK0v0Rj0ooM2z0ZXghNw5yCj6eyFI20OYerd9Uwa8VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trAf8iFmKGya8qn5LmJ/igk6CTHqAHqd3USQe3EX9eLsRQcvOJQgdtapsqElXQFKU1QF6U3zRfVW3lFLmms1EVbs2myyRwdXaXNjRCs2nNSfKANXfnQ4sA3giXWJBCx7cu2fT2AIstXSpnihkTDLCGtgmCHqg1oBwVR6/U0JLiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Huu6lu15; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4715991c32so231028366b.1
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713539821; x=1714144621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKVsh5Q6uavCX2L8UHvFm8eJ4q1LcfOkw4OmFRzHRl0=;
        b=Huu6lu15aisNyufIrdgt+YQ6b0ehvr1RrIkEpJ51gpM44QggmMquqkwv816bOzARKP
         d8sULdlitEQhEBd08ZR1sMfHyEZpcELzIlPJ//ZF14kKNROFMevjzSSn2lPWfAl0Y2od
         UScmqmh7DFShWcUL3J4glFj2YI8Ulv3CfYKTsLP3MarJ0/FfVbhqwU9bfUe5IucwyJOy
         ynZXNTthO+sy5vC58v4PX2GsAIhGnY0/dFr4gTNoaTPXAMz1Bo3Wf1VtBsvYpeorXS9V
         evFXgcxB+fOURIR6Kylg8ERhaPR1dre/TGJwZ7NzvSO0qYZtO3djpJbZIMtudCsinUGU
         Vr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713539821; x=1714144621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKVsh5Q6uavCX2L8UHvFm8eJ4q1LcfOkw4OmFRzHRl0=;
        b=XgoiQoHIxC0nHA1uYZLZVghlOAbOsPRMdr1G1HvXGOMiPWLA3jGqwIqzWSsAjj7pgS
         qcglUm62Hhc//4i+eY6OKhufoRSSh8FsTdXYNpCScz5lSt2XZkbpOEGbYHZsDNHOamx8
         ChMTcNG3BiCtN1UWnNp/Ko8ykU9xmPaxgXwQHhS5Op2cMAhti5QgpQmUR5Ykkwfw7toL
         i82tfCPl8kk1CDisRu605aFQKoz0ymQZ9YPRQbaokud/aTnyShrXnfOYGkBKqYm/t0Ii
         p7GUOxbOOEewdVmPgMTUfR0lByQjl8mBR1xFaHhMsop4CYyp7nqknv7MJhBRn3nmDQUU
         aQnw==
X-Forwarded-Encrypted: i=1; AJvYcCXuVWgiekLO5Av7y61bQ8SsVwfF41DQlvhEFRYu3ZCxF3kOXZk2qtrbRtg+aOTUwzrEudxQmR/OQKDB9wDFbTkNp3BDY/R0
X-Gm-Message-State: AOJu0YxH7+4fCfTNj2rwv106TXdQWwqVw/LJ3o1bZK+Dy1RcyRBb/e9X
	iPHnxbwgFiZcMMYIQEVt9bszAt6ez2XmzbHiUB5z2e5hgb/AjQmyozbi8VtjU3x4CAasE9Gl+14
	5jPyP8cMPvg/Mdh1mnQC4j6YeRp1omHB1B+SE
X-Google-Smtp-Source: AGHT+IGSF4R/7XyVxnbZU+tg0tRVhzLFWy1sVPooyzjHSt4OkmCfCHyvuqMsmrQd3CiTr11yPzmQ/sLnIiwlWdA353c=
X-Received: by 2002:a17:906:4fc7:b0:a52:5925:2a31 with SMTP id
 i7-20020a1709064fc700b00a5259252a31mr1836689ejw.29.1713539820384; Fri, 19 Apr
 2024 08:17:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417211836.2742593-1-peterx@redhat.com> <20240417211836.2742593-3-peterx@redhat.com>
In-Reply-To: <20240417211836.2742593-3-peterx@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 19 Apr 2024 08:16:48 -0700
Message-ID: <CAHS8izPqCyQxMN_hRqwXQkG6WbaFg9GnmY-4=PHZSErNGjiaOQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/hugetlb: Fix missing hugetlb_lock for resv uncharge
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, David Rientjes <rientjes@google.com>, 
	syzbot+4b8077a5fccc61c385a1@syzkaller.appspotmail.com, 
	linux-stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 2:18=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> There is a recent report on UFFDIO_COPY over hugetlb:
>
> https://lore.kernel.org/all/000000000000ee06de0616177560@google.com/
>
> 350:    lockdep_assert_held(&hugetlb_lock);
>
> Should be an issue in hugetlb but triggered in an userfault context, wher=
e
> it goes into the unlikely path where two threads modifying the resv map
> together.  Mike has a fix in that path for resv uncharge but it looks lik=
e
> the locking criteria was overlooked: hugetlb_cgroup_uncharge_folio_rsvd()
> will update the cgroup pointer, so it requires to be called with the lock
> held.
>
> Looks like a stable material, so have it copied.
>
> Reported-by: syzbot+4b8077a5fccc61c385a1@syzkaller.appspotmail.com
> Cc: Mina Almasry <almasrymina@google.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-stable <stable@vger.kernel.org>
> Fixes: 79aa925bf239 ("hugetlb_cgroup: fix reservation accounting")
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  mm/hugetlb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 26ab9dfc7d63..3158a55ce567 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3247,9 +3247,12 @@ struct folio *alloc_hugetlb_folio(struct vm_area_s=
truct *vma,
>
>                 rsv_adjust =3D hugepage_subpool_put_pages(spool, 1);
>                 hugetlb_acct_memory(h, -rsv_adjust);
> -               if (deferred_reserve)
> +               if (deferred_reserve) {
> +                       spin_lock_irq(&hugetlb_lock);
>                         hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h=
),
>                                         pages_per_huge_page(h), folio);
> +                       spin_unlock_irq(&hugetlb_lock);
> +               }
>         }
>
>         if (!memcg_charge_ret)
> --
> 2.44.0
>


--=20
Thanks,
Mina

