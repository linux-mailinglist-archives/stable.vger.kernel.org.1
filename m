Return-Path: <stable+bounces-66087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 153DC94C627
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 23:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D4328917B
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 21:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C033A14F9EA;
	Thu,  8 Aug 2024 21:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpFPRAR/"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A57E1;
	Thu,  8 Aug 2024 21:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723151119; cv=none; b=cdWCVfM1/0f8e0/pWo/M2sPGOc3RAz7kW/4f03Lygm1p8H7BN29u8IDNwedKUuwuesisdKdA+XIfsAFGZxFwelG2MAS5nYpiYbhq3TuzPYDHOoufP0r4RYg0ZeUrO9SokvMh1xqxTuVbO7o92JHVVgsj6gATG7vwRxAv9RBFCwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723151119; c=relaxed/simple;
	bh=AzxTlK8d/8HPZmIPTyg8dGto3vYoDePium7toEyLDM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAU00zwYb4V0w9H+7nJ3v/vGAwyLT+Xo9Ie4fe0nLXEBmXk5/y+0jPj9uGB/yVqpCfQ9R7R9J6v4xK+ap838NsxJmDJZyCoZ7TCr/UNASw4ALJtKKqGw3Vl8IuTDtzm3f+upU/kGsmOWO1ccggOgfXeCJKAPue1GmPgBnNDhxcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpFPRAR/; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3dc16d00ba6so992030b6e.0;
        Thu, 08 Aug 2024 14:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723151116; x=1723755916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiuna0tSCDQBT7Iidr/W4z/hr7onQ/GC0/68Zq0Ogtk=;
        b=OpFPRAR/e+gr9QlimS56Y/zJFLOnHOkGZOMYF/As4L6EP2JxsSPwh0NRMpBzM4nnrI
         m+mZZeMcK/3aku0Vzo40wbMJBlscegUB0aKpHPwPOqZ1QagegFgfqtzdXbnqCmxxgfqa
         ddUNY48KrlDVjIT5w6L0dIaTabt8UfyJsuP7C/L0MYGkVZG0jmWEBoVugfpE7QZDBTGO
         G3PRN4yDWgx3oUS7xV+k4Kqul54zcBTaNCDWgyFbfCOfJxVmggQhf4yfhrHR9u4ZMOav
         xXnKBsF7ZEzU+z64PTOzNybRUR5weCTe4fYCMRMvIeElDnxyteHnLW8SrH2dnyKKUkDm
         b83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723151116; x=1723755916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiuna0tSCDQBT7Iidr/W4z/hr7onQ/GC0/68Zq0Ogtk=;
        b=VRZiEY7hqdc1EgmCHhkXkb6tVJ1tOGhKOPUNKWHlxNl3WAiuygxErC4GcxcO7X4L0O
         lGrd5zMs+LCZkalH55SOzS5SoKofiVvBifXYYcYA5pRUumnnJJBSKzn/2mPOnCzzHPCO
         44ZN7q/lEsFXR77iYpZiiYQXNcFLtFgUX+ynlhiDPN2+r/TOPNALGtFVXDXt+sroqfWV
         UH9FZp20wgSFzCajpfjfG7Dso4PXrwUS54AmeXueuqcJXRHFy6fYUeWtjTyOCloiVBpt
         9BFHinJJuJl7+Df2YIyG5mABJVb2AMvIwlkIeTmsqiBO11s7ZFvT50qWdfpVjYKwhLNz
         eP/w==
X-Forwarded-Encrypted: i=1; AJvYcCWxsRIv09RPr5X+Dy3u8vUeaYbdZbP3jvXMKdZQyY0S3x6Sdi5/kPMQnKyolhLvEU8RUkPIE8yR3ImYkukqsaN7RUXG8ovS0xV7FgnKwGRarSUykyonp3aANcwRXCuwGrYgOgZo
X-Gm-Message-State: AOJu0Yw+7B02Cc0Wvx1xkSwVlLnGtSCbkdGPnFzbUdR0dy2O40GiBxyp
	XjHUwNCv1s7BdFU1/hafKt6kR/lLtUUIcapclt7cd4BsHW09iuBCSrgnxmh+tEffTO0foOaBjiB
	p7sWKBwV38DV+nSPPwEY1kU2usPI=
X-Google-Smtp-Source: AGHT+IH1naOuZoG8Xqc6HAUdtz5PmzN418+Kgpawt6IZkftwIf0pPolI/YMYZpCUzr2EhVq2FcQ0SA4hjYUHvVuUL1Q=
X-Received: by 2002:a05:6808:178c:b0:3db:251b:c16 with SMTP id
 5614622812f47-3dc3b45fa99mr3744915b6e.42.1723151116528; Thu, 08 Aug 2024
 14:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808122019.3361-1-hailong.liu@oppo.com>
In-Reply-To: <20240808122019.3361-1-hailong.liu@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 9 Aug 2024 09:05:05 +1200
Message-ID: <CAGsJ_4z4+CCDoPR7+dPEhemBQN60Cj84rCeqRY7-xvWapY4LGg@mail.gmail.com>
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, 
	Tangquan Zheng <zhengtangquan@oppo.com>, stable@vger.kernel.org, 
	Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 12:20=E2=80=AFAM Hailong Liu <hailong.liu@oppo.com> =
wrote:
>
> The __vmap_pages_range_noflush() assumes its argument pages** contains
> pages with the same page shift. However, since commit e9c3cda4d86e
> ("mm, vmalloc: fix high order __GFP_NOFAIL allocations"), if gfp_flags
> includes __GFP_NOFAIL with high order in vm_area_alloc_pages()
> and page allocation failed for high order, the pages** may contain
> two different page shifts (high order and order-0). This could
> lead __vmap_pages_range_noflush() to perform incorrect mappings,
> potentially resulting in memory corruption.
>
> Users might encounter this as follows (vmap_allow_huge =3D true, 2M is fo=
r PMD_SIZE):
> kvmalloc(2M, __GFP_NOFAIL|GFP_X)
>     __vmalloc_node_range_noprof(vm_flags=3DVM_ALLOW_HUGE_VMAP)
>         vm_area_alloc_pages(order=3D9) ---> order-9 allocation failed and=
 fallback to order-0
>             vmap_pages_range()
>                 vmap_pages_range_noflush()
>                     __vmap_pages_range_noflush(page_shift =3D 21) ----> w=
rong mapping happens
>
> We can remove the fallback code because if a high-order
> allocation fails, __vmalloc_node_range_noprof() will retry with
> order-0. Therefore, it is unnecessary to fallback to order-0
> here. Therefore, fix this by removing the fallback code.
>
> Fixes: e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocation=
s")
> Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
> Reported-by: Tangquan Zheng <zhengtangquan@oppo.com>
> Cc: <stable@vger.kernel.org>
> CC: Barry Song <21cnbao@gmail.com>
> CC: Baoquan He <bhe@redhat.com>
> CC: Matthew Wilcox <willy@infradead.org>
> ---

Acked-by: Barry Song <baohua@kernel.org>

because we already have a fallback here:

void *__vmalloc_node_range_noprof :

fail:
        if (shift > PAGE_SHIFT) {
                shift =3D PAGE_SHIFT;
                align =3D real_align;
                size =3D real_size;
                goto again;
        }


>  mm/vmalloc.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6b783baf12a1..af2de36549d6 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3584,15 +3584,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>                         page =3D alloc_pages_noprof(alloc_gfp, order);
>                 else
>                         page =3D alloc_pages_node_noprof(nid, alloc_gfp, =
order);
> -               if (unlikely(!page)) {
> -                       if (!nofail)
> -                               break;
> -
> -                       /* fall back to the zero order allocations */
> -                       alloc_gfp |=3D __GFP_NOFAIL;
> -                       order =3D 0;
> -                       continue;
> -               }
> +               if (unlikely(!page))
> +                       break;
>
>                 /*
>                  * Higher order allocations must be able to be treated as
> ---
> Sorry for fat fingers. with .rej file. resend this.
>
> Baoquan suggests set page_shift to 0 if fallback in (2 and concern about
> performance of retry with order-0. But IMO with retry,
> - Save memory usage if high order allocation failed.
> - Keep consistancy with align and page-shift.
> - make use of bulk allocator with order-0
>
> [2] https://lore.kernel.org/lkml/20240725035318.471-1-hailong.liu@oppo.co=
m/
> --
> 2.30.0

