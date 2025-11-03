Return-Path: <stable+bounces-192158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CC9C2A8D0
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 09:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7938D3A91C8
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 08:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C520A271447;
	Mon,  3 Nov 2025 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bo6qKhDF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848F223A984
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762158037; cv=none; b=d+lrJcjEP6wl9T64rGlTzY6haLqNFH3LVY/mIHmS4FKUyoH6J9/hP4D9x8BxHft3OOBOoLZ8hMPdmd0C1bup7ub2kLcXw+dLazlDPuMQ7B6rgcDy5VoZ6VYdom5tVMS2hLVsjJmCNYmTSitc2/doVg/5qb6mBi9ZnO2QS1k5WOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762158037; c=relaxed/simple;
	bh=3u/rpGXSihKqhfsVaZzxD5/gPGk7i3CnGVWA2evOHm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWQHM172wuU+ndSc3Hdjg6uWQzUrbnZmupPgyMh4DTWZrdztsS/r8AffGoqqe8D23UhraG7HeUS7foJy+r5e0sOxTg4Cz1cJRIzDzg0NotqubebsqoumxaP5LHfudF2PbHn6ZNwxjKsvq0/ctfg+E5mWL7ls+DayAUTkxq09heQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bo6qKhDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A942C4CEFD
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 08:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762158037;
	bh=3u/rpGXSihKqhfsVaZzxD5/gPGk7i3CnGVWA2evOHm0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bo6qKhDFHmuEJrGxsGfbPwk4ypwIUxeAtTJIdr9604PVDl4I/oOpfS4Vi23P1E43F
	 neKKqnyh2KaCp7otUPCYu8ZRZO23ozrXMqAEq/VbsAkIPE3+S9+kROvXbU4d6NPVYg
	 6roav74lpadCO9XfZgltpFdH0kHt4Z021ObnVQDPjMrosBZPILdCXmG/1xDisHzNlB
	 OzX6hG7i7kMoCjPCCw7f8nLQyowMTE6judYkAULirbqkO1LFLXOoSqzX3EsJ6qa4Et
	 OeGWalWTun2UxibmNAoVLKAOPybj1c4jGwYU9S0r+6KqZOZ0eL7H77UMdgbIODwc2O
	 9l2Jy8LNjpyjg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3761e5287c9so42929711fa.2
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 00:20:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVANDnstEnVGBrPU+uCO3I2l8IvlzjpIX4mjvgcaM51Pk50BudNK29guHn+a0da40xXwRuSwkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb1MNSCTqyxXOMAob20IVNLJ0Krgf0iRjx9P7xBPm92oLfnqy7
	Q2Ub94rFC9+vaBbLMaPLWKuZDmHt4o6pwILaZ0SkBvdkn8XrQEiapOOHdnKYP2yy6VZ8jsBtJWL
	MUhIhOy0a0HBi1iByaO0lpaitIqsqXZM=
X-Google-Smtp-Source: AGHT+IGTpms4Fl8IC9UDLuBvkSZZN6ewiudTr09vFFaNQ3RItMcme3lUUXAuf1yj3RWqjLu6U8QKVyN3Upfje/kcWnA=
X-Received: by 2002:a2e:be13:0:b0:37a:2e32:320a with SMTP id
 38308e7fff4ca-37a2e3232cbmr17803521fa.21.1762158035470; Mon, 03 Nov 2025
 00:20:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031161045.3263665-1-ttabi@nvidia.com>
In-Reply-To: <20251031161045.3263665-1-ttabi@nvidia.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 3 Nov 2025 09:20:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFigMpbzWAVz2gOSQxmtMYU22LRWQWVwkd4QeQy8J6Kqg@mail.gmail.com>
X-Gm-Features: AWmQ_bmLEk2zs6nUGb6SmLqMwVdIEOX-8EEsac_ycKBkfyzRAgVAgpeoAQZMtoU
Message-ID: <CAMj1kXFigMpbzWAVz2gOSQxmtMYU22LRWQWVwkd4QeQy8J6Kqg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau: set DMA mask before creating the flush page
To: Timur Tabi <ttabi@nvidia.com>
Cc: Lyude Paul <lyude@redhat.com>, Dave Airlie <airlied@redhat.com>, 
	Danilo Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 17:12, Timur Tabi <ttabi@nvidia.com> wrote:
>
> Set the DMA mask before calling nvkm_device_ctor(), so that when the
> flush page is created in nvkm_fb_ctor(), the allocation will not fail
> if the page is outside of DMA address space, which can easily happen if
> IOMMU is disable.  In such situations, you will get an error like this:
>
> nouveau 0000:65:00.0: DMA addr 0x0000000107c56000+4096 overflow (mask ffffffff, bus limit 0).
>
> Commit 38f5359354d4 ("rm/nouveau/pci: set streaming DMA mask early")
> set the mask after calling nvkm_device_ctor(), but back then there was
> no flush page being created, which might explain why the mask wasn't
> set earlier.
>
> Flush page allocation was added in commit 5728d064190e ("drm/nouveau/fb:
> handle sysmem flush page from common code").  nvkm_fb_ctor() calls
> alloc_page(), which can allocate a page anywhere in system memory, but
> then calls dma_map_page() on that page.  But since the DMA mask is still
> set to 32, the map can fail if the page is allocated above 4GB.  This is
> easy to reproduce on systems with a lot of memory and IOMMU disabled.
>
> An alternative approach would be to force the allocation of the flush
> page to low memory, by specifying __GFP_DMA32.  However, this would
> always allocate the page in low memory, even though the hardware can
> access high memory.
>
> Fixes: 5728d064190e ("drm/nouveau/fb: handle sysmem flush page from common code")
> Signed-off-by: Timur Tabi <ttabi@nvidia.com>
> ---
>  .../gpu/drm/nouveau/nvkm/engine/device/pci.c  | 24 +++++++++----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>

This is the third time you are sending the exact same patch, right? Or
is there a difference between the versions?

> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c
> index 8f0261a0d618..7cc5a7499583 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c
> @@ -1695,6 +1695,18 @@ nvkm_device_pci_new(struct pci_dev *pci_dev, const char *cfg, const char *dbg,
>         *pdevice = &pdev->device;
>         pdev->pdev = pci_dev;
>
> +       /* Set DMA mask based on capabilities reported by the MMU subdev. */
> +       if (pdev->device.mmu && !pdev->device.pci->agp.bridge)
> +               bits = pdev->device.mmu->dma_bits;
> +       else
> +               bits = 32;
> +
> +       ret = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(bits));
> +       if (ret && bits != 32) {
> +               dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(32));
> +               pdev->device.mmu->dma_bits = 32;
> +       }
> +
>         ret = nvkm_device_ctor(&nvkm_device_pci_func, quirk, &pci_dev->dev,
>                                pci_is_pcie(pci_dev) ? NVKM_DEVICE_PCIE :
>                                pci_find_capability(pci_dev, PCI_CAP_ID_AGP) ?
> @@ -1708,17 +1720,5 @@ nvkm_device_pci_new(struct pci_dev *pci_dev, const char *cfg, const char *dbg,
>         if (ret)
>                 return ret;
>
> -       /* Set DMA mask based on capabilities reported by the MMU subdev. */
> -       if (pdev->device.mmu && !pdev->device.pci->agp.bridge)
> -               bits = pdev->device.mmu->dma_bits;
> -       else
> -               bits = 32;
> -
> -       ret = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(bits));
> -       if (ret && bits != 32) {
> -               dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(32));
> -               pdev->device.mmu->dma_bits = 32;
> -       }
> -
>         return 0;
>  }
>
> base-commit: 18a7e218cfcdca6666e1f7356533e4c988780b57
> --
> 2.51.0
>

