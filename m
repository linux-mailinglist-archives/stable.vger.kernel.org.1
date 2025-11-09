Return-Path: <stable+bounces-192826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E95C43912
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 07:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46C5C4E1E13
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 06:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4281E51EB;
	Sun,  9 Nov 2025 06:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YfmwViU/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lo2eUCYX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1093048CFC
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762669171; cv=none; b=lNTqkty3DqD79M+SgaAp02yarYbl+FXq+0OxoEMwXUjG46G1rhWRYHipclyoDLi/aj1HFr+1KHk+C9/+CXwujz8JGLNeQbWAVmD0A11AaAZNLCcLw1ln2SUwpocLfBrqXbR17rITa+MR0eL9ErekNXWwtPX4qRdQMo+xjd1bNZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762669171; c=relaxed/simple;
	bh=SP4vC2/hvVPYW+L5yxlw168oALFMbVlSqCktE0VNfcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/WqpFSOz/eHevJECZhUZUUnOls92+id3Zp9H+ighgUQYPQo4NGOI53bIwZGg6wYqlngr33RecDdnQYaLtFz0hahJAUh48YLl8GZIYC+nz044flUHfzwe/WdcizjBXtzI31smy6vSAFJIMnEdOuZuHOEVXKqCV2VniYSKeNlT1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YfmwViU/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lo2eUCYX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762669168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bVrRgmXsUu34ydz6PRK5FiXmgS7u5Ru1tv952Jc6wdc=;
	b=YfmwViU/yKS50IokD6RBsPLxcbolnskSY5kHL9gsUh7GVmQsb1X8lSkbiRAKItnvuIj+OZ
	ZsOwfQesWZHKKrKkuUG+H59L26Pnc3/Y+lcBPKne7xY0Uv7vWu60VLvzACPqDzSo3FAH6I
	42TBqvmI9EM2MPGO8EVERxeKUTMODas=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-YPIkhRqvNnallQoyZn5V5w-1; Sun, 09 Nov 2025 01:19:26 -0500
X-MC-Unique: YPIkhRqvNnallQoyZn5V5w-1
X-Mimecast-MFC-AGG-ID: YPIkhRqvNnallQoyZn5V5w_1762669165
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297f3710070so19290825ad.2
        for <stable@vger.kernel.org>; Sat, 08 Nov 2025 22:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762669165; x=1763273965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVrRgmXsUu34ydz6PRK5FiXmgS7u5Ru1tv952Jc6wdc=;
        b=lo2eUCYX7VbaM/QlCuRW9Fw1tGNdxMC8P53VH7lr44ooJIE7mwQGkupVGTchH4apOW
         PGtHE8an2ndVtXFoNltAY+jXFjUivSyXiPlX6+SvggI0K+Sd6zzsdr0pVhto2lIphujA
         6yGyi1mX47yHJw7tY5WWRNt/66ubS+wqjbezZFlFjC9Si38ROYp6M7H1o39vpCCX/8dR
         OkvOHQrKLBYB/4oRSH2cWkWp8PRNtRxmc7Q6vhGVYquBIvxVVTSgCE4jXdKw+Lr9k1zu
         YQGEWsZmBpCQ7TF+z8JtWy+7B4I/KufBi+qNvxlCLBYB+tcGNRsZ9wg20iKb69lFclgl
         ZcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762669165; x=1763273965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bVrRgmXsUu34ydz6PRK5FiXmgS7u5Ru1tv952Jc6wdc=;
        b=ayh5gGsUj+nhvPw8HMKH5z0ArWTiSKRWU23i/p5E+kHlJAHNzRT9E2JWIg3S6gIQue
         vtEDO7SnAvNUb4Z1tseCbAfwsvxQE94wb+3Ht1T6J/DBOOBwLBrTlgd9fTUsgUezr5D4
         4HGoLb5EFJKQS1QzRkIbLxH/zdgFzlif+J1gKBTzAYyrHC9Lm+gBAyYS94tejSrmd2Mc
         LEg00HBfxv1g+Xv9fdbh75qQrIPlvIPAeS6LSGHM5S5imNvKsPFjvWCd9O9/cyVf8Tm3
         0O/n2pNRdM3CFAKwWbNTR6aPzzkTFHeMCiGqrkxZ3XQz7PK5SHUW8dbOd2tvMyz/3U3E
         y3gA==
X-Forwarded-Encrypted: i=1; AJvYcCWd2H5cYA6ocI/zT42gDb5QbBeoYzrs6H8dQGEKPQk/sr4qnrlVDTb65uQgo69Z1SceatDWiiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze4Waaxey99ykrmVjt4LQ2Vpj4LMhfVounk9rEB4PI09U97+fT
	8Ut4Tae2MB0UDzMFTmtFkBhjJisU/YllrNsYpKHyt+YKsBB99zo8cPnbq1sa0/CILma/KZNqkac
	14L77lOmYJmcZfJsgv6n/Wwzk7TQS+y4F9braqOnSF+K6yIDAJKpMug13d98tfKIEU1/yqbKODg
	gqXbGNG6LIxGIf8YMryzcQzW3+kmwIZmKT
X-Gm-Gg: ASbGncvufZuFxm4YAdj6dGjeHa7fhpa3W9wNS0avLeesNhua2QFJhHm5iAxPobtszBG
	NN9t/ei8Dl3i9KH03hF/9YC5RY+IShWFEzdIuoid5w43AvF/KnFb8V7ZeHyle1jWCziB6JEtbFW
	vKHQHyU9L06qTzAaXFBvTUfL8UptNT6pr8qPrhb/7sp82NmwkWcq2vmQ==
X-Received: by 2002:a17:902:e888:b0:290:9a74:a8ad with SMTP id d9443c01a7336-297e56ef4d9mr48387485ad.53.1762669165191;
        Sat, 08 Nov 2025 22:19:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJ/sCq/hauK2bBklx8hx85BDHsDXwnBUJmSL/DIfAQJUFbFj1eM7mRCPYsekZc7IXd2P4FmnCHAZwSPWhMX70=
X-Received: by 2002:a17:902:e888:b0:290:9a74:a8ad with SMTP id
 d9443c01a7336-297e56ef4d9mr48387295ad.53.1762669164812; Sat, 08 Nov 2025
 22:19:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031161045.3263665-1-ttabi@nvidia.com>
In-Reply-To: <20251031161045.3263665-1-ttabi@nvidia.com>
From: David Airlie <airlied@redhat.com>
Date: Sun, 9 Nov 2025 16:19:13 +1000
X-Gm-Features: AWmQ_bnLbmy_9ptmxCReUuTl6BLSvquZ3oxgN9GrD4A-LnjMw7BbjefGKuFW_1g
Message-ID: <CAMwc25pOob3aXPH8u2ON7HZ-Bk+a_d9JWg0+wLNOycnFsVWHSg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau: set DMA mask before creating the flush page
To: Timur Tabi <ttabi@nvidia.com>
Cc: Lyude Paul <lyude@redhat.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 2:12=E2=80=AFAM Timur Tabi <ttabi@nvidia.com> wrote:
>
> Set the DMA mask before calling nvkm_device_ctor(), so that when the
> flush page is created in nvkm_fb_ctor(), the allocation will not fail
> if the page is outside of DMA address space, which can easily happen if
> IOMMU is disable.  In such situations, you will get an error like this:
>
> nouveau 0000:65:00.0: DMA addr 0x0000000107c56000+4096 overflow (mask fff=
fffff, bus limit 0).
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


So this caused a regression, because the sysmem flush page has to be
inside 40 bits.

look in openrm:
src/nvidia/src/kernel/gpu/mem_sys/arch/maxwell/kern_mem_sys_gm107.c:kmemsys=
InitFlushSysmemBuffer_GM107

The prop driver tries to use GFP_DMA32, then use 40 bits and the code
is all horrible. It's probably fine for use to just set the dma_bits
to 40 here before and then the full range after.

Dave.
>
> Fixes: 5728d064190e ("drm/nouveau/fb: handle sysmem flush page from commo=
n code")
> Signed-off-by: Timur Tabi <ttabi@nvidia.com>
> ---
>  .../gpu/drm/nouveau/nvkm/engine/device/pci.c  | 24 +++++++++----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c b/drivers/g=
pu/drm/nouveau/nvkm/engine/device/pci.c
> index 8f0261a0d618..7cc5a7499583 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c
> @@ -1695,6 +1695,18 @@ nvkm_device_pci_new(struct pci_dev *pci_dev, const=
 char *cfg, const char *dbg,
>         *pdevice =3D &pdev->device;
>         pdev->pdev =3D pci_dev;
>
> +       /* Set DMA mask based on capabilities reported by the MMU subdev.=
 */
> +       if (pdev->device.mmu && !pdev->device.pci->agp.bridge)
> +               bits =3D pdev->device.mmu->dma_bits;
> +       else
> +               bits =3D 32;
> +
> +       ret =3D dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(bit=
s));
> +       if (ret && bits !=3D 32) {
> +               dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(32)=
);
> +               pdev->device.mmu->dma_bits =3D 32;
> +       }
> +
>         ret =3D nvkm_device_ctor(&nvkm_device_pci_func, quirk, &pci_dev->=
dev,
>                                pci_is_pcie(pci_dev) ? NVKM_DEVICE_PCIE :
>                                pci_find_capability(pci_dev, PCI_CAP_ID_AG=
P) ?
> @@ -1708,17 +1720,5 @@ nvkm_device_pci_new(struct pci_dev *pci_dev, const=
 char *cfg, const char *dbg,
>         if (ret)
>                 return ret;
>
> -       /* Set DMA mask based on capabilities reported by the MMU subdev.=
 */
> -       if (pdev->device.mmu && !pdev->device.pci->agp.bridge)
> -               bits =3D pdev->device.mmu->dma_bits;
> -       else
> -               bits =3D 32;
> -
> -       ret =3D dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(bit=
s));
> -       if (ret && bits !=3D 32) {
> -               dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(32)=
);
> -               pdev->device.mmu->dma_bits =3D 32;
> -       }
> -
>         return 0;
>  }
>
> base-commit: 18a7e218cfcdca6666e1f7356533e4c988780b57
> --
> 2.51.0
>


