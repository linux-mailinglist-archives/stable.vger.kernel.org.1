Return-Path: <stable+bounces-118533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B394EA3E8FC
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 01:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571793B9A86
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 00:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BF71367;
	Fri, 21 Feb 2025 00:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlHJ/LYK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC8B360;
	Fri, 21 Feb 2025 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740096459; cv=none; b=ISAFMtL7vRP02raWiFIKtVzAKfsMZv+C4E7ujB447APD81FxU3402TjMMHlrvDf6cWjzWxGur8bdnXoViQdPjz/pZnxWfikqxH5x8SvoN4b1NA7f2Hf02y1KsvAQ1YNvyugvlU42URE46Z4caPih/OZ+vOyTFMtLTLlQv6moMlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740096459; c=relaxed/simple;
	bh=X2kyRsO+9WySc2rQQjqLlYnMMJxaeDw6df+h2DL8EAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eoMoSXQ81My2GIkoyKaJiM66Blf5B705vwgM9WzSiasItpQaWqCVLZPsaBkmOJUpM58S2Pf6ejrv7MgZpdSjHKv77icXx38Zd87ET6OnP6erEIP/Gh+Rr5GOeS7imzBff/t8o7EmSc612tlG0TKtYRJKCr5PwOTjzhMv2ctS6EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlHJ/LYK; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-8670fd79990so398129241.3;
        Thu, 20 Feb 2025 16:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740096457; x=1740701257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNjxgVeVeHgcdYvbJZlSUczEpc3RlMwxUrdKBdaJztk=;
        b=IlHJ/LYKPcn7GLNwivypQuMTTxU82I67HiW1eMVvyQwa0ZLJq2ZzdWupWLhirV279M
         EiUng07rEIlifYKYw4ZS0Z8H2cFzjQFsAq8hjSCzfhnVDXOhhpsS/g2y8RGWwvckWI0I
         LSCRSpLFhh9KVkZmTpkzZJHgzuwHa3uF5SgMZOuNz28/TsyJbKeEmjnMw0shcfu5/Ycl
         6Y2oyfrr+cdYrkBhqb28ldh20TbsPAR2fcRlnmH49VrZNEnSsSbjuIS2V3NsWaDS9yAC
         zFaIerXq8uPRabSI40QsvhyKJZh+rXWwdcglLaWB+pJpUQyzaJ3C+AWdJgz4RCBMxrVb
         Y9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740096457; x=1740701257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNjxgVeVeHgcdYvbJZlSUczEpc3RlMwxUrdKBdaJztk=;
        b=FR13lcuIswpGp4Kr9L0Tg0YQ7wsvafRqyzBfgWL/iwiJimP9RAJqFUl7wBnjXTuPOK
         /Oxs1DzjmihRtFgLhi5LWDhPE92A7mEuGM5XfFwVcsw7drh2v2OMQG67fmwrQCvWoXJR
         iKGLvCSQyOsXxjy2q0JtdC8LCFbx7ftsT5IqXVVNJmG9e8sG5vL082A7zRLlW9svyFXr
         UQ1hbwYvP58zcQn91RXP8SIBjI4BnFDQ4XqPZHmsTGkRVs1Y6kh+XVpzFYpgOFQtnRb1
         NWTaIieRXKorqDwE8jjuJXEj9RL88APusVmVXlrIJwLfCXSYoS7UkAkZNi7kPlnXdV0z
         b9lA==
X-Forwarded-Encrypted: i=1; AJvYcCUQEYnoDqTtajzgCQp+/VWuEkNwM1y/biqAf+8IW0Gq3L7pO7GdhtzEpWuCRY8G/b6sgrGDZpboqW1U3zM=@vger.kernel.org, AJvYcCWmWG/Hutf/TEaDfp1Jn3U0KyYpLDTUV0OWwUkdINnF/OuJ787/EwslULA/eh0XwMHI/7lhie4E@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2lmU5RWX3j7r/nnfb0jJptag0C6F0Bzpn9tce7KmN5JAqk2Bu
	jO/ye7cgSGLW7Lw515W8kmDk1HhQhQOg2JsCI6U4o4JtMGzyAGmYELDycfOxCEgLm6H/0oNOZ5L
	dCfQMCILOLDIIi27x2pp687LbMSo=
X-Gm-Gg: ASbGncsSHhNbviHRAl+h8YDBldOQ30WAvCquhdPH3qOElJPtgGv23GurgK/axtLrifw
	1LNBXEOSoBYbLSwY2x9OZIlQJekAQ9PQeG+RrFtWmfc0LpWY9YGiCodE8kD13iQFMUFPYRyur
X-Google-Smtp-Source: AGHT+IHSi4HiluB+91pGBYRnFv0s7RilYgXxztGrydm4XkVVegmkknDiPOeVM3lAYDVKBlM1KqAXHwzwMmKUUBEUV/8=
X-Received: by 2002:a05:6102:41a5:b0:4bd:3c41:7f6c with SMTP id
 ada2fe7eead31-4bfc009c888mr1027889137.10.1740096456724; Thu, 20 Feb 2025
 16:07:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69dbca2b-cf67-4fd8-ba22-7e6211b3e7c4@redhat.com>
 <20250220092101.71966-1-21cnbao@gmail.com> <Z7e7iYNvGweeGsRU@x1.local>
In-Reply-To: <Z7e7iYNvGweeGsRU@x1.local>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 21 Feb 2025 13:07:24 +1300
X-Gm-Features: AWEUYZkGBaS0O8lQ1W43gky4VX6JpyFPxRw29m5phtbNiHuJDt6ylGK9DhTerNk
Message-ID: <CAGsJ_4zXMj3hxazV1R-e9kCi_q-UDyYDhU6onWQRtRNgEEV3rw@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
To: Peter Xu <peterx@redhat.com>
Cc: david@redhat.com, Liam.Howlett@oracle.com, aarcange@redhat.com, 
	akpm@linux-foundation.org, axelrasmussen@google.com, bgeffon@google.com, 
	brauner@kernel.org, hughd@google.com, jannh@google.com, 
	kaleshsingh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lokeshgidra@google.com, mhocko@suse.com, ngeoffray@google.com, 
	rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org, surenb@google.com, 
	v-songbaohua@oppo.com, viro@zeniv.linux.org.uk, willy@infradead.org, 
	zhangpeng362@huawei.com, zhengtangquan@oppo.com, yuzhao@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 12:32=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Thu, Feb 20, 2025 at 10:21:01PM +1300, Barry Song wrote:
> > 2. src_anon_vma and its lock =E2=80=93 swapcache doesn=E2=80=99t requir=
e it=EF=BC=88folio is not mapped=EF=BC=89
>
> Could you help explain what guarantees the rmap walk not happen on a
> swapcache page?
>
> I'm not familiar with this path, though at least I see damon can start a
> rmap walk on PageAnon almost with no locking..  some explanations would b=
e
> appreciated.

I am observing the following in folio_referenced(), which the anon_vma lock
was originally intended to protect.

        if (!pra.mapcount)
                return 0;

I assume all other rmap walks should do the same?

int folio_referenced(struct folio *folio, int is_locked,
                     struct mem_cgroup *memcg, unsigned long *vm_flags)
{

        bool we_locked =3D false;
        struct folio_referenced_arg pra =3D {
                .mapcount =3D folio_mapcount(folio),
                .memcg =3D memcg,
        };

        struct rmap_walk_control rwc =3D {
                .rmap_one =3D folio_referenced_one,
                .arg =3D (void *)&pra,
                .anon_lock =3D folio_lock_anon_vma_read,
                .try_lock =3D true,
                .invalid_vma =3D invalid_folio_referenced_vma,
        };

        *vm_flags =3D 0;
        if (!pra.mapcount)
                return 0;
        ...
}

By the way, since the folio has been under reclamation in this case and
isn't in the lru, this should also prevent the rmap walk, right?

>
> --
> Peter Xu
>

Thanks
Barry

