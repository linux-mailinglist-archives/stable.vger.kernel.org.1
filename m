Return-Path: <stable+bounces-142868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 424B5AAFD70
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1141C250FF
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 14:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AE72750F2;
	Thu,  8 May 2025 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="joPXtsfm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED862741CA
	for <stable@vger.kernel.org>; Thu,  8 May 2025 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715351; cv=none; b=a4EDPy+0LNPSMzl9B1fcD/UQ6pPR74ac+8cQr3w2y+kzlrGCnYQYpU4C36OQ5CA3ajQMDih5uwPZa6MfETYqD+8aTHqoSHnjyfeP3FiQ1nFbd5INZsWslou+i9IVmHEMLKqvlVJ4SmxD9fPpCRA+cNze0kXNhYV5o/vK9bk7Zc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715351; c=relaxed/simple;
	bh=HgapASh5XA8oVv/Lz/V7hhXc6nFQHYF1VgUr9bgNK50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXYHa4UkpaqyNurm+gxROlt4WlRRwLmojk8QOgYVRTv/FVXSYFqSAQ+YlTAf4Mh5wQ3pYNndhoKbvZMgsUndsxapx4A1ZUddP62Xh2qYR/F8NFolGu6yQbDhu39nJK4dkqc70oskGNigJgpwB2dYAWmHO1aPzXrT6s5bjhlSEEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=joPXtsfm; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5fbcd9088a7so2075264a12.0
        for <stable@vger.kernel.org>; Thu, 08 May 2025 07:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746715348; x=1747320148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrrj7tzRV0HSot50MsrZe31qPKZT2X3/IHla60zHnEo=;
        b=joPXtsfmTt4r3RRG+PHu+ZVZv3tF5wk8iVc38n0njzje4Hrhhkj4Bd5OSAvCTE/q/w
         U1dxRtno7XBPhfZSf4IlU1srcFjYDijE+d++dUxBwywqV+zg79MJqHQlqyihVOxBj/pd
         8+/PtQFXYXHLr+vSiHrpqY2UYpzofsn6c7/QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746715348; x=1747320148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrrj7tzRV0HSot50MsrZe31qPKZT2X3/IHla60zHnEo=;
        b=r14SXqKiDf6d1WHwyethrPbPUZwxE9DyfpKpaZJ+gJe4gyenwwsxcJpbDARRcg1LcS
         YyWSanycOQHQ4vtwM9Cn58zfguRzhyOftZJJQV4ic5ZRgqWJkVqLb/LX9+nmJ+bZDphh
         K0SQIZ0HV61MQfydyO2IbPs5ogL69A+lsh+QD9XCyVh8gYBEZUx6sEtyZMXMHweQMx04
         s23ywU+5tFlQ/R2HxEBGaJvfvrtJRmqjPiEoYB6Bb9vQZ38x7hixG3q7CM8NjjNGu8Oy
         fAYYRKH34uiMmMTvemBNscvj+SvN84MYGCaZG/ll6gojT6VkLfHbMt9GYwkLMwyLWoRh
         JsdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFnvhsAmLquS1MIdpMMHI/KCSzPNRekMgQQJsU48RsVSRz/6kDIy4Q97uKWFNg1RPiW9G3v7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFXFGF4PterNCXCkPeFKjaf4DaeEPhHcypGnRbx/LI9w+DMbBD
	UuSTFSMBll4yO9xs6JWmDNPkruELiKTGTCKt8b8d8Bs4rqeNhdD5VdNM3KvM/T9Kx9TUr6dtkHM
	=
X-Gm-Gg: ASbGncuF2GhL+h4CFQWviz/QlFxgw5ym8m9P9x8cMQiegQeNQSyoUColq8JdR3AbIXm
	P0/15QnZjvuow1QTBpe2rPSEVkzBJGHHYhtRQH9CGz922r3geOtRJpg1oCPnrjMp+EaZoyMRoSQ
	0+yTK9z0viZZLSl0lN7ReQszxy/6PlaESDPv00kCf7SpJ8UJdDdLsq52S+pP5UKOjniOyk0Mzg9
	9ibLIq7FiKfydb9zyPnGDOFsqSlZ6XJZSGgTr/KWLq3KjFfaOZIUGjlNClvmFMV/t61VY24BwYL
	DPglVCjfGVqMDJrQKpENAr4Zv+FRQpa4WAaJh3NkX2ujauyvmvbpOVADUsgigPUoVUk/4u8sg9U
	y
X-Google-Smtp-Source: AGHT+IHEhaLqg1bICFj+5ngzqkH5z+G54dpaeRS6c291kstdpuLDGgymd5IvHyI95IzrRvtnEJtwjA==
X-Received: by 2002:a05:6402:5243:b0:5f6:22ca:8aae with SMTP id 4fb4d7f45d1cf-5fc34b0feaamr3327749a12.2.1746715347729;
        Thu, 08 May 2025 07:42:27 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc5bc05f9dsm1348837a12.18.2025.05.08.07.42.26
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 07:42:26 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5fab85c582fso11911a12.0
        for <stable@vger.kernel.org>; Thu, 08 May 2025 07:42:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDvZ1eGKRezra45CceEyVbrPaWb+KiTn9OhUuVAAiY8xoDc7OJbYm7OXg4dXu+N1UvUqiRpcg=@vger.kernel.org
X-Received: by 2002:a50:8e57:0:b0:5fb:f573:78fe with SMTP id
 4fb4d7f45d1cf-5fc6d3df3d1mr75346a12.1.1746715346027; Thu, 08 May 2025
 07:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250507160921eucas1p2aa77e0930944aadaaa7c090c8d3d0e73@eucas1p2.samsung.com>
 <20250507160913.2084079-1-m.szyprowski@samsung.com> <20250507160913.2084079-2-m.szyprowski@samsung.com>
In-Reply-To: <20250507160913.2084079-2-m.szyprowski@samsung.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 8 May 2025 23:42:09 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CUOJJ_fpzXrihtqxRiAZfWBNtCxkaDi6GeZk0rc+XKvA@mail.gmail.com>
X-Gm-Features: ATxdqUGjYbxgU6zpFJMZMGQW-VMwakmlnKiG_rNSxR-mybkfMglw3-_t5QXxPAE
Message-ID: <CAAFQd5CUOJJ_fpzXrihtqxRiAZfWBNtCxkaDi6GeZk0rc+XKvA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] media: videobuf2: use sgtable-based scatterlist wrappers
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Robin Murphy <robin.murphy@arm.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 1:09=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Use common wrappers operating directly on the struct sg_table objects to
> fix incorrect use of scatterlists sync calls. dma_sync_sg_for_*()
> functions have to be called with the number of elements originally passed
> to dma_map_sg_*() function, not the one returned in sgt->nents.
>
> Fixes: d4db5eb57cab ("media: videobuf2: add begin/end cpu_access callback=
s to dma-sg")
> CC: stable@vger.kernel.org
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/media/common/videobuf2/videobuf2-dma-sg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/=
media/common/videobuf2/videobuf2-dma-sg.c
> index c6ddf2357c58..b3bf2173c14e 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> @@ -469,7 +469,7 @@ vb2_dma_sg_dmabuf_ops_begin_cpu_access(struct dma_buf=
 *dbuf,
>         struct vb2_dma_sg_buf *buf =3D dbuf->priv;
>         struct sg_table *sgt =3D buf->dma_sgt;
>
> -       dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir)=
;
> +       dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
>         return 0;
>  }
>
> @@ -480,7 +480,7 @@ vb2_dma_sg_dmabuf_ops_end_cpu_access(struct dma_buf *=
dbuf,
>         struct vb2_dma_sg_buf *buf =3D dbuf->priv;
>         struct sg_table *sgt =3D buf->dma_sgt;
>
> -       dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->nents, buf->dma_d=
ir);
> +       dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
>         return 0;
>  }
>
> --
> 2.34.1
>

Thanks for the fix!

Acked-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz

