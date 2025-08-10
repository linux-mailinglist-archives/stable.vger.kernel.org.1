Return-Path: <stable+bounces-166952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD567B1FA02
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 14:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC84E16FE0E
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 12:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9D822CBC6;
	Sun, 10 Aug 2025 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHHaXfoN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2322126D
	for <stable@vger.kernel.org>; Sun, 10 Aug 2025 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754830632; cv=none; b=GsANtVZyNTu9p/ZrIhmGRJ31oTyErsMVYRf2IFq1JuKnlzVI0pikxvrhwFaR+izYqTmTdo7+2sfHNq0kIl77MP7j7sgXvGyXOCVPVQdr+lEgu+NkL1qs/z/UDOnj+0dCUGQLuloHhSPjMIKZDvoRQ+RT9dE2ik4tSzsbeKHkKYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754830632; c=relaxed/simple;
	bh=ROlzLEeCg00gkMTWYeNV/cvX3Uji6kaCC41uqFQv3Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tx4BsQhKJa/b6gXdZ6HhYjGdyuTwXqZqZQF9thhjFdYZe9zpadPl72F+gJsvrp/2NVL5BIrVw7MJg18GJFeHsGLTuPLKN/m3hURJ0E1TcDNsH8NTqCRGWR60WswL6cJEYy9/zV4j/sIBA47uWZKullPxorXkSEO1gxpg5yHVJXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHHaXfoN; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7430835eae1so2224479a34.1
        for <stable@vger.kernel.org>; Sun, 10 Aug 2025 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754830629; x=1755435429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hk0vQpEQc96pPsBzVddcY2ri747yVEKfcp+ejDRXV+8=;
        b=JHHaXfoN0YZw9QnEEoYn17GaJHRfjKdlJ6kNXBSUiRSIJXEr4au8nTMegIXTMLBs6i
         ZfovNCHmsrMZjN8KJO3OJQVCNucgjJcll86oJ48Ok4LzAFs/n+lR3LyeRJsinUsYaRf0
         bC7Fp196SIYh+Ck/a5hS5RZfX6RM0Rv0tFOsT/lg0rRSe0YloGzIFaYOIa9WC1Yv3MZj
         fiNAwn8P9lWHArYSlJBWwSj5au4o7NJKMcJtoqcnkk98Le+ZUXLxG1sJ84udgnocNggQ
         5W9ITmCfo1Uj2ScdyD49q6+NeuShgK91ig/HLqXYRA+LZzJ3C74GTLRGhbOWVbR1c9A6
         wkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754830629; x=1755435429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hk0vQpEQc96pPsBzVddcY2ri747yVEKfcp+ejDRXV+8=;
        b=ETCmQkiqjqqHyxp6r/VL2yGQFDpYJ6X6SwyEeJLn5dUUj74ZBfwz5bzb6tV6gQ524s
         /ZQpyT0nq20GmiNh35zkkJ10Mqp3lsA41M2WdXbrS/tJ0UuNKICiGC7KGSCuqbVpGDBI
         4QvY4xHY6pBugSMTNJLRManfOEJjmgr31QF+fnsCmEd7k2rlxPNkCTar3CF3jcLc0j+j
         S1RxtrhtbXivuNCTasq8tad4IXIZwoL3a3oKmlJ/JCpx3CVwkR+UDLETac2CUSN3WBaQ
         o/VIkT9PKhxPV5LMCmxHUTD0OEJ+eb5gwY6MJ+OrRcrpiFUeZ2BG3ILcn9YscUsy8krq
         wDMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMe1/iSbaJdM6rMlJ3AK7DXuDbxFlX/nmXbYDSJpQR+a9cFMm+V9layb9/yIeJHxVOMg2nlIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytQE9hcNkO527FBUO5eWaFP1kJc6pswp2dRBHcfi5ekMJDxSY1
	6/SmrZlYxoDd9xWFzUOc4q6ovXvw4CYbvHjXcpe6nBCt56SHwMV//IuXlTeBDxPNu2L95aZUOrI
	HI/DP+ozkF+iYyUNZ5exxLiBlQi+EudZs+MIwZm5NkA==
X-Gm-Gg: ASbGncvKjdvhFLtOGXRA/4mn/wnG2+2k+9TuPvY/SuE85KpP09B9QIRI7si4G2o4PK3
	c2eaDWgsi9hY2I8j0oFaOyBScQ/yZ6bViDEfMkfwnVWkGXKAucKlxHOCIHfzp4ZrAydVH4kDMoR
	E83icXrE+cG38p8GvG21P6saeWRVQIJq/UogDArGEwG8BLzr3VUqfZdf6XE+0Oduzn3H6KgP3oN
	5ht
X-Google-Smtp-Source: AGHT+IEHY5r6Gce1oZK2OIKAsnl5ILZ147Y/o1PNH7xhcU6UAD3tqVBOQ1FMnzzZRxl24LGN1z+AQ/cYR3zDsNhaclg=
X-Received: by 2002:a05:6830:6c88:b0:73e:5540:730e with SMTP id
 46e09a7af769-74318ee5b56mr7154681a34.4.1754830629127; Sun, 10 Aug 2025
 05:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810124201.15743-1-ekffu200098@gmail.com>
In-Reply-To: <20250810124201.15743-1-ekffu200098@gmail.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Sun, 10 Aug 2025 21:56:56 +0900
X-Gm-Features: Ac12FXwymO9fVmgHrw4TsFCYnXlG-bVN2vqISj3bUbiPHnM0Tf9frR-EF_q3LEk
Message-ID: <CABFDxMGw6usfYmccAAvu7HRO6xCz708=9tTx-Ln-HgQ6GN49Mw@mail.gmail.com>
Subject: Re: [PATCH v3] mm/damon/core: fix commit_ops_filters by using correct
 nth function
To: sj@kernel.org, honggyu.kim@sk.com
Cc: damon@lists.linux.dev, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 9:42=E2=80=AFPM Sang-Heon Jeon <ekffu200098@gmail.c=
om> wrote:
>
> damos_commit_ops_filters() incorrectly uses damos_nth_filter() which
> iterates core_filters. As a result, performing a commit unintentionally
> corrupts ops_filters.
>
> Add damos_nth_ops_filter() which iterates ops_filters. Use this function
> to fix issues caused by wrong iteration.
>
> Fixes: 3607cc590f18 ("mm/damon/core: support committing ops_filters") # 6=
.15.x
> Cc: stable@vger.kernel.org
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---

I just forgot to add change logs.

Changes from v1 [1]:
1. Fix code and commit message style.
2. Merge patch set into one patch.
3. Add fixes and cc section for backporting.

Changes from v2 [2]:
1. Separate the patch into two parts(code modifications and tests) And
this is part of code

[1] https://lore.kernel.org/damon/20250808195518.563053-1-ekffu200098@gmail=
.com/
[2] https://lore.kernel.org/damon/20250809130756.637304-1-ekffu200098@gmail=
.com/

>  mm/damon/core.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 883d791a10e5..19c8f01fc81a 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -862,6 +862,18 @@ static struct damos_filter *damos_nth_filter(int n, =
struct damos *s)
>         return NULL;
>  }
>
> +static struct damos_filter *damos_nth_ops_filter(int n, struct damos *s)
> +{
> +       struct damos_filter *filter;
> +       int i =3D 0;
> +
> +       damos_for_each_ops_filter(filter, s) {
> +               if (i++ =3D=3D n)
> +                       return filter;
> +       }
> +       return NULL;
> +}
> +
>  static void damos_commit_filter_arg(
>                 struct damos_filter *dst, struct damos_filter *src)
>  {
> @@ -925,7 +937,7 @@ static int damos_commit_ops_filters(struct damos *dst=
, struct damos *src)
>         int i =3D 0, j =3D 0;
>
>         damos_for_each_ops_filter_safe(dst_filter, next, dst) {
> -               src_filter =3D damos_nth_filter(i++, src);
> +               src_filter =3D damos_nth_ops_filter(i++, src);
>                 if (src_filter)
>                         damos_commit_filter(dst_filter, src_filter);
>                 else
> --
> 2.43.0
>

