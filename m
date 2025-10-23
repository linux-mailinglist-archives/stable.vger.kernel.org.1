Return-Path: <stable+bounces-189058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 430C7BFF475
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 07:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33603A8033
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 05:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1361EB9F2;
	Thu, 23 Oct 2025 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlLE8J3M"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A1D2153D2
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761198694; cv=none; b=VZ4rBxHJ8ImUn3m5wnKMhIQK8pkR2JDPEqYL4MzqnjkNMpPl9oy1y51rTY+1etg1ehIvn02NwuHn186y8hvBUmkJmrodk5Gj7JU8XED5Tphx2dpiNu4bqnGR2D9eSespH8etDwtUxzOqpW5kTG6uIBb/XjczlQ+rrPRI6RAZgRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761198694; c=relaxed/simple;
	bh=trsvToJEKKHu/XmsqmtPz8jWxaj1IbQyjRyBsIyHHfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClhAmaS3ap1WLtcBLjT/0clNZhENqge9EFypx7yiccZ8RMZLgft5BBdBhtnmvMtAUc4T4WwqrwBwh/NidWlsOPV6DMWzsrPDFK9JRWRxBBJwRMFGw9VIPIwBJ3o4fS+M5kjkZ0B9wX4fpMc83qFnmXaf9lze8/vio5A0OX8ZdvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlLE8J3M; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4e89ffd95b9so5229191cf.0
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 22:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761198692; x=1761803492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+c+NbgHrZN7bWRSFiex5X5KJePzhxA+ZHYyLdwSqtl4=;
        b=YlLE8J3ML71LBUjAIfM2jyecWpXrRd1q8BwQbRknZRHG8NEA4UITNNxbdQy3Wy7fgG
         tnQYnH9oCXSjntPJzj1Y73aNuD8FG4rWRhgIMQ8wAsGjeHYdNKCa40v6D2um2H94SqvC
         zYyIr+0NbHSn4cdA75isKl21HFM2ZerpBDCsnPhnE8iRk3u1Q+0qJ9KC2lmMfv1LJPZw
         9poDI6l7HsuiS9JccxKC6Nyag7R7VF+WjUXKzzIzqkcdR7JOCpahdJxVuINIY0B8Te9a
         TpcvnKQNSVB7yzCZKjq9KXuBdmZfEfT3H0NQpbVu376T1QDsbRInZ0QvMrvzRwYFQmsv
         86Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761198692; x=1761803492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+c+NbgHrZN7bWRSFiex5X5KJePzhxA+ZHYyLdwSqtl4=;
        b=NK6mGUUKnfrz/7mSfTxTqTBbqGWRu7xB66+dEtur1wlaBMQwTofrswF+g5CXsIBjuE
         dXsCWtlNZ+IVyLSoaw6xPx+jlRIkVHgIeLNsN4tsWkXHaxyco6yZhhJGmUKTIYeqnDVH
         PGZPpO//thVCXV2Q9gGgzmYVy3gRjQVjXaWmTeWyqoUuCrxEtA4nWAdIRI1q5W4NOwUr
         91EAgrqOwARc5Bbeal0lfIiVXt5ZKHHgByL2a3o3EXyGew0Bcao02yWcfCH0DmePSk7J
         SkHV1iekcD+ES6UQbzEfiaXYERKumfOgeF6akmIUTJRTCRtIFS9VbVJ93maEF7tyqd7p
         1eQw==
X-Forwarded-Encrypted: i=1; AJvYcCVwyKwffWjguS8NbOmouewjLIWp9H8l4dLQVw+Ft6jdAlCF0kCq4qVd7JMw+HZtdcvCNF058ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGUQMJQZDmE8bc3Ra6LDvVmJmzxb+xNkyN/dernRV9lYjgKCKB
	FJp0OPg+svtOzuW71ohMRPlETPOoUdT5HBdGz/Y9azuhMjPrGSIOf/X5UENOtfqMOJZ6qKo6b0a
	2QVQooCQ9kK4Hv9TGOM8Ldt2Zdpx/7/M=
X-Gm-Gg: ASbGncvCRyPGgUsHdo5qHGM1p21mpenPnyYQkL/6Y0OCpHga9PX9JjSpn+HvpzMPNt7
	RShzJOxamS/3ZZGmRilLT19Af5yyOVoVuBAjrJ2zA+p3oK13uzUGZsHB2vocucD/znld5q90Gtw
	lt+p1eBlM8t5WFUpe+oirgMe2g7BXa3ZEoDpST+HENo7EkhkYPc+MIvJ4BgZBP0ByHnw4sCF/Ew
	d1urFj8/l8mOq46oMs3xUpIW9sJ1de4H8/IlH9GbMqHAnSzyxJxKHapfyt1jL/A+YCjnmfsVp4E
	SZdaX90XciM2Ztkz
X-Google-Smtp-Source: AGHT+IG2Mi7vqdQCnyt6kuAmhI1WiYtd9JowlwNahGI5Sn/aHmlC3Vnbemadnf9/Q0GK32HOEsS1UsxfrANhNicTuQg=
X-Received: by 2002:a05:622a:8d:b0:4e8:a621:7912 with SMTP id
 d75a77b69052e-4e8a6217a5fmr273669031cf.84.1761198691860; Wed, 22 Oct 2025
 22:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022105719.18321-1-ryncsn@gmail.com>
In-Reply-To: <20251022105719.18321-1-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 23 Oct 2025 18:51:20 +1300
X-Gm-Features: AS18NWB1yQIOT_rwx8pqsyu31KsQcKncmHw5kIG8Uc-XrpaBEO8kE7dzlBnI0ZI
Message-ID: <CAGsJ_4zKcxO-Tacy0jCZSs83+fGsgqQYNib9nCXoLTuL+hdLxQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/shmem: fix THP allocation and fallback loop
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, 
	Dev Jain <dev.jain@arm.com>, David Hildenbrand <david@redhat.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Mariano Pache <npache@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b50ce7dbc84a..7559773ebb30 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1895,10 +1895,11 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>                 order = highest_order(suitable_orders);
>                 while (suitable_orders) {
>                         pages = 1UL << order;
> -                       index = round_down(index, pages);
> -                       folio = shmem_alloc_folio(gfp, order, info, index);
> -                       if (folio)
> +                       folio = shmem_alloc_folio(gfp, order, info, round_down(index, pages));
> +                       if (folio) {
> +                               index = round_down(index, pages);
>                                 goto allocated;
> +                       }

Could this be a temporary variable to store round_down(index, pages)?

>
>                         if (pages == HPAGE_PMD_NR)
>                                 count_vm_event(THP_FILE_FALLBACK);
> --

Thanks
Barry

