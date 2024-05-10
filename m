Return-Path: <stable+bounces-43530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9258C228D
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 12:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E793281EB1
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 10:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3C416ABC3;
	Fri, 10 May 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QefonEiI"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2C168AFC;
	Fri, 10 May 2024 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715338503; cv=none; b=q97BD8frC3/12LWQR5KBaNRTCA/e7lAshX3JAr55qbLJUmN7vwzB3HAvBs78duJrOEkhJF+205GmTN/Y2ieMbMJYIuCarVKzQu3ml2i8icl1d8Ibc/pW5FusCQm479P+IMWzASDq/cnrJCI6FH42AiqaXJkgJGuTVJWm5z+PLi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715338503; c=relaxed/simple;
	bh=Xc/cXEVgw9u0jMbXKst96nBJlyCSNol4PbtonuV86l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2Iw2Rmo69+SzESDsC/vFsmsBEZqrLORuL5rkQGOQbxvhRRp1MMEFlQ1KMOQcDknF0TxTaz2bHayW9ZIRm6G3tVAU3U0d0Aj+4MVh45cq+mR1WQqem4FjCzgtdj7wDMo6hlII6FuMmXeEa4+VOwRgJps4iMINwL8g+X/BkmTGUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QefonEiI; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4df4016b3c9so715886e0c.1;
        Fri, 10 May 2024 03:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715338500; x=1715943300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wlupgt5KecgpQVJqF2FhR9ZPlaju+6jPVqD7qRDHUs=;
        b=QefonEiIf91q1vQ3uqSZrxWF7SEWLj3ucRor3fFemRL9FapvGt4I8F5A31S9VkFSHn
         CNiMjkZuagG8wMVoaHmXRa9BY0yBcEhu5+I2TVP9eo8ScNQRjrs9jLdJr56O1f2vopLR
         OacSqPJO8U1Bk2UfTd8e+qcSRbNhGPzpojhEVPVPfTo489LyuLpFLZ1uYuQTQmGLaTiT
         /Z/ElLf/F0xlKWWWQpntX8wcxI3LcdbXyTOVB188F9KAYeCs45BGad7usywybxdb8FVO
         oBH97NzlLWX8r6+ZKNxfDms7IgCiTiOkZmk5LoZqogI3Om2erwhsNTHlHZTLLLOsQYQ2
         pV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715338500; x=1715943300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wlupgt5KecgpQVJqF2FhR9ZPlaju+6jPVqD7qRDHUs=;
        b=BRN2TLDmNILk6slLC1XXmLTd/LhDSwYrxwNpQOOLTfYnHXZuiucY8UVladckEGM9hy
         6RM1derFkBWDGLC4I+B6YziyLXpRiPWCZ+4L2Zb/HInde34Aak/dBJ3CS6YNHtz6sUrG
         VWAD1dmZtgR+mkaPdQiYnPRIhVwTB2NG140D5JhoTWyQeAw9Qtv1K/+xKypfH42hDaen
         GAkY6KXrBEN+wK+JPazdjcc4WDcaFvfa14UYwhckrf4UuAFSFiqnobD3cdSysG/bO0Lf
         8rOwtEeB3UhOUP2P1nHQRQwtgJE6TwmvGpy4Sgw5J33+xWi+QfmHKZCgWWIayjb8wgT6
         hCaA==
X-Forwarded-Encrypted: i=1; AJvYcCWPd5R0UySHkESJRrL90SflFyI9JArEdi2QiuQbhkMSnfqlwIZoUt77qEhBEjDYs3BIpQBHTHRsSsaFX2tbPsXtaWYEgawnLwpGG6+ZgKgVl+9+7UoHe398/JONuOSE8s27S4lS
X-Gm-Message-State: AOJu0YxvfsjQbwVL0zJaUgZIqlaPaS4KmKPay7n8Nab6ziqL0Usn5PF6
	LXGI+tIeR6lZo7wGb1CWujlUgZ1nMZhGuIKtEq3/bX0LLcNb2jsBQorcBkiBz2M8+e3diEt0wrF
	uZHcT6X01fGdDniyauNuQwcymRFQ=
X-Google-Smtp-Source: AGHT+IFR2+tVUJwKSg0yCQqekFJUJKlDpXohzwpk4X8JX2XpMN0jt0HmJOqMsnO+dytDXoRDBxrkKutlKBCdH2sJhjY=
X-Received: by 2002:a05:6122:411b:b0:4df:2b08:f217 with SMTP id
 71dfb90a1353d-4df882c2bf7mr2526033e0c.6.1715338499019; Fri, 10 May 2024
 03:54:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510100131.1865-1-hailong.liu@oppo.com>
In-Reply-To: <20240510100131.1865-1-hailong.liu@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 10 May 2024 22:54:47 +1200
Message-ID: <CAGsJ_4y0adNv2ukxNeGct3yPDgscWXFKSvSjZiA3S=CeUWEftw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
To: hailong.liu@oppo.com
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org, 
	lstoakes@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	xiang@kernel.org, chao@kernel.org, mhocko@suse.com, stable@vger.kernel.org, 
	Oven <liyangouwen1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 10:01=E2=80=AFPM <hailong.liu@oppo.com> wrote:
>
> From: "Hailong.Liu" <hailong.liu@oppo.com>
>
> commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
> includes support for __GFP_NOFAIL, but it presents a conflict with
> commit dd544141b9eb ("vmalloc: back off when the current task is
> OOM-killed"). A possible scenario is as follows:
>
> process-a
> __vmalloc_node_range(GFP_KERNEL | __GFP_NOFAIL)
>     __vmalloc_area_node()
>         vm_area_alloc_pages()
>                 --> oom-killer send SIGKILL to process-a
>         if (fatal_signal_pending(current)) break;
> --> return NULL;
>
> To fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
> if __GFP_NOFAIL set.
>
> Fixes: 9376130c390a ("mm/vmalloc: add support for __GFP_NOFAIL")
> Cc: <stable@vger.kernel.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Suggested-by: Barry Song <21cnbao@gmail.com>
> Reported-by: Oven <liyangouwen1@oppo.com>
> Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  mm/vmalloc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 125427cbdb87..109272b8ee2e 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3492,7 +3492,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  {
>         unsigned int nr_allocated =3D 0;
>         gfp_t alloc_gfp =3D gfp;
> -       bool nofail =3D false;
> +       bool nofail =3D gfp & __GFP_NOFAIL;
>         struct page *page;
>         int i;
>
> @@ -3549,12 +3549,11 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>                  * and compaction etc.
>                  */
>                 alloc_gfp &=3D ~__GFP_NOFAIL;
> -               nofail =3D true;
>         }
>
>         /* High-order pages or fallback path if "bulk" fails. */
>         while (nr_allocated < nr_pages) {
> -               if (fatal_signal_pending(current))
> +               if (!nofail && fatal_signal_pending(current))
>                         break;
>
>                 if (nid =3D=3D NUMA_NO_NODE)
> ---

