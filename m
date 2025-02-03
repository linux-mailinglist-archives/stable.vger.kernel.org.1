Return-Path: <stable+bounces-111992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39063A25537
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 10:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205AB18861A0
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 09:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01EE207DF6;
	Mon,  3 Feb 2025 09:00:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026B1207DEF
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573200; cv=none; b=SZ6anQoyJZK3E4QyRf0ZY0lCUte4JePD8WY0RS1iXvTIaytlnutT1a73AIXp0dwP5GDxNS9UxhkBOga42dQ3OOY8ET5n6c2XsUWsDN2kjbyErObySJp77W3Uk9fOVUYrhMJgOr8fpvdh9G1P852asDti00PCAXAf+wiI9RdA17w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573200; c=relaxed/simple;
	bh=SB5hAFZ26iw6wEf+BpzUKhisAwZI70P/N7z0aAbxzL0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LaIFFgh+heR47IYf6h2MS31j68RxGXyjUPZa12gMTK2/HFzwTRNSiPHvUxkw/S0U5GhROrkmtv/StCFTdhR0bdtgzjOuCIufDWuIChmQLCnwYwHsla5kgs0RN6+Ksn7WE+5Pz8XNa13GHeTyR1MK0TWk+hbRr9aWTZyoLeVK710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1tesJB-0006l4-HK; Mon, 03 Feb 2025 09:59:57 +0100
Message-ID: <d8b6c3b4eda513277f19640c8f792c6d70b03f06.camel@pengutronix.de>
Subject: Re: Patch "drm/etnaviv: Drop the offset in page manipulation" has
 been added to the 6.12-stable tree
From: Lucas Stach <l.stach@pengutronix.de>
To: stable@vger.kernel.org, stable-commits@vger.kernel.org, 
	sui.jingfeng@linux.dev
Cc: Russell King <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>
Date: Mon, 03 Feb 2025 09:59:56 +0100
In-Reply-To: <20250202043355.1913248-1-sashal@kernel.org>
References: <20250202043355.1913248-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Hi Sasha,

Am Samstag, dem 01.02.2025 um 23:33 -0500 schrieb Sasha Levin:
> This is a note to let you know that I've just added the patch titled
>=20
>     drm/etnaviv: Drop the offset in page manipulation
>=20
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>=20
> The filename of the patch is:
>      drm-etnaviv-drop-the-offset-in-page-manipulation.patch
> and it can be found in the queue-6.12 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>=20
please drop this patch and all its dependencies from all stable queues.

While the code makes certain assumptions that are corrected in this
patch, those assumptions are always true in all use-cases today. I
don't see a reason to introduce this kind of churn to the stable trees
to fix a theoretical issue.

Regards,
Lucas

>=20
>=20
> commit cc5b6c4868e20f34d46e359930f0ca45a1cab9e3
> Author: Sui Jingfeng <sui.jingfeng@linux.dev>
> Date:   Fri Nov 15 20:32:44 2024 +0800
>=20
>     drm/etnaviv: Drop the offset in page manipulation
>    =20
>     [ Upstream commit 9aad03e7f5db7944d5ee96cd5c595c54be2236e6 ]
>    =20
>     The etnaviv driver, both kernel space and user space, assumes that GP=
U page
>     size is 4KiB. Its IOMMU map/unmap 4KiB physical address range once a =
time.
>     If 'sg->offset !=3D 0' is true, then the current implementation will =
map the
>     IOVA to a wrong area, which may lead to coherency problem. Picture 0 =
and 1
>     give the illustration, see below.
>    =20
>       PA start drifted
>       |
>       |<--- 'sg_dma_address(sg) - sg->offset'
>       |               .------ sg_dma_address(sg)
>       |              |  .---- sg_dma_len(sg)
>       |<-sg->offset->|  |
>       V              |<-->|    Another one cpu page
>       +----+----+----+----+   +----+----+----+----+
>       |xxxx|         ||||||   |||||||||||||||||||||
>       +----+----+----+----+   +----+----+----+----+
>       ^                   ^   ^                   ^
>       |<---   da_len  --->|   |                   |
>       |                   |   |                   |
>       |    .--------------'   |                   |
>       |    | .----------------'                   |
>       |    | |                   .----------------'
>       |    | |                   |
>       |    | +----+----+----+----+
>       |    | |||||||||||||||||||||
>       |    | +----+----+----+----+
>       |    |
>       |    '--------------.  da_len =3D sg_dma_len(sg) + sg->offset, usin=
g
>       |                   |  'sg_dma_len(sg) + sg->offset' will lead to G=
PUVA
>       +----+ ~~~~~~~~~~~~~+  collision, but min_t(unsigned int, da_len, v=
a_len)
>       |xxxx|              |  will clamp it to correct size. But the IOVA =
will
>       +----+ ~~~~~~~~~~~~~+  be redirect to wrong area.
>       ^
>       |             Picture 0: Possibly wrong implementation.
>     GPUVA (IOVA)
>    =20
>     ---------------------------------------------------------------------=
-----
>    =20
>                      .------- sg_dma_address(sg)
>                      |  .---- sg_dma_len(sg)
>       |<-sg->offset->|  |
>       |              |<-->|    another one cpu page
>       +----+----+----+----+   +----+----+----+----+
>       |              ||||||   |||||||||||||||||||||
>       +----+----+----+----+   +----+----+----+----+
>                      ^    ^   ^                   ^
>                      |    |   |                   |
>       .--------------'    |   |                   |
>       |                   |   |                   |
>       |    .--------------'   |                   |
>       |    | .----------------'                   |
>       |    | |                   .----------------'
>       |    | |                   |
>       +----+ +----+----+----+----+
>       |||||| ||||||||||||||||||||| The first one is SZ_4K, the second is =
SZ_16K
>       +----+ +----+----+----+----+
>       ^
>       |           Picture 1: Perfectly correct implementation.
>     GPUVA (IOVA)
>    =20
>     If sg->offset !=3D 0 is true, IOVA will be mapped to wrong physical a=
ddress.
>     Either because there doesn't contain the data or there contains wrong=
 data.
>     Strictly speaking, the memory area that before sg_dma_address(sg) doe=
sn't
>     belong to us, and it's likely that the area is being used by other pr=
ocess.
>    =20
>     Because we don't want to introduce confusions about which part is vis=
ible
>     to the GPU, we assumes that the size of GPUVA is always 4KiB aligned.=
 This
>     is very relaxed requirement, since we already made the decision that =
GPU
>     page size is 4KiB (as a canonical decision). And softpin feature is l=
anded,
>     Mesa's util_vma_heap_alloc() will certainly report correct length of =
GPUVA
>     to kernel with desired alignment ensured.
>    =20
>     With above statements agreed, drop the "offset in page" manipulation =
will
>     return us a correct implementation at any case.
>    =20
>     Fixes: a8c21a5451d8 ("drm/etnaviv: add initial etnaviv DRM driver")
>     Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
>     Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etna=
viv/etnaviv_mmu.c
> index a382920ae2be0..b7c09fc86a2cc 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> @@ -82,8 +82,8 @@ static int etnaviv_iommu_map(struct etnaviv_iommu_conte=
xt *context,
>  		return -EINVAL;
> =20
>  	for_each_sgtable_dma_sg(sgt, sg, i) {
> -		phys_addr_t pa =3D sg_dma_address(sg) - sg->offset;
> -		unsigned int da_len =3D sg_dma_len(sg) + sg->offset;
> +		phys_addr_t pa =3D sg_dma_address(sg);
> +		unsigned int da_len =3D sg_dma_len(sg);
>  		unsigned int bytes =3D min_t(unsigned int, da_len, va_len);
> =20
>  		VERB("map[%d]: %08x %pap(%x)", i, iova, &pa, bytes);


