Return-Path: <stable+bounces-233185-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHXoNhbJz2lH0QYAu9opvQ
	(envelope-from <stable+bounces-233185-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 16:05:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51684394EFB
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 16:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C45933020FE4
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 14:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56013B7B64;
	Fri,  3 Apr 2026 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5C3Ymjl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7603AC0C8
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775224831; cv=pass; b=RIjHM/kI51U9LcnFLLimy/Wc9tUpwFa/uEKBPotV8AT1K69uvVneauBflUO8lF8SaWkcpGMmdCbhAAju/g83n4K4E0wECOMLOXUHe4HNrA09fINqTCWELM9oxHZcHoe/Sw0vReVpWsVjjsNo4kFoMqvjTOHtRgMbt1NJAljtCf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775224831; c=relaxed/simple;
	bh=ICrRvlzJ7grzfWZQnrb2ZUVpkcjJ8wGbkxRLDrmId8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oz6btDgY93O/TF/bTgSWOieESyZU4uli2gXGt8iqQ62RLXkp8+fji9WLXb00vKgWAHhPYFvxYQFdB048iYac5mKezxSd7FH3ew04syKewcgDgomRWDbpBqmN+DI1h1hRNblt8zf3xNUOu67UMKkPmtVpVMKJy86eT48vtvpTWJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s5C3Ymjl; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66b2f6e983bso3174218a12.0
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 07:00:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775224822; cv=none;
        d=google.com; s=arc-20240605;
        b=VcEVhZ9MWj7yeuzI3On7TycHDaXioELnim2ue7xLWyHa6bwOctHXO4P8fKD+p2w9+n
         bt3PrwoHwpJfOQsG01evnvshzzAxCZy4JXL6gV028/iwX1gJmXU55zHLZYuF0so5ZeHS
         eIrYm05oqqHI4y3A8EwpUxsCeW72A/w0xgLDj9G18981fJAf5QsDHhJaqZ02rHAuYzcH
         vjKdEt03TaLaUIqfle3NQ0Wwdvu2nzgQ72iF6mi/GcaVlu4b/MEYCq13IVEPMQkJ0Msq
         XFF76OhiOzNtcgCWm+vZUwa918FJtzCUdsNbDviK6vM8PEIDoSJCNM7oytXVm5e3n57Q
         GJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GZJMb8BpsQsC5OCqpX0KvnetYnrUPrII+wbhqXuacG4=;
        fh=A3lyTij/A7eARfNd153uIGgmT18nGi3D3fNwh3gXQkw=;
        b=UeXNgdjoYT7A9lwew9C1MstZ+daiwloN4cVfYsetiQzERS6hTDOSCJ+vdNYr5BxJNr
         o7DTP+vQXxjpwhjrYgSiaUoT33ermzc0tqHetmotR0+PdruNdPUzDpOSVGG9ldL6dFTM
         I0pc0j+InhcIVdFy6v36+leq3QLC+C7L79wKWtQXD22I04E4rCX9YARDh/VTwRbJYaeP
         3DXYUArDl5ynsck4ZZw1VQ6Hui8yhkxSFgpb404JcDiGGx9/G/frl1CZVCSZT1/9z255
         A57f7wG4h1//pjQpZeIELWpS+3ONCSUesjKmRAZT+0O+vFnYLqLNTW2CQy0fd91wGBFk
         9IPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775224822; x=1775829622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZJMb8BpsQsC5OCqpX0KvnetYnrUPrII+wbhqXuacG4=;
        b=s5C3YmjljAlx0CXszeTXv+uc65RLcYMlAYeqcqGK6CQEjOpHNt+KDoWR6P6u7uz36m
         i5PYnzA0eewAYibPVT5dEeURQpyoDJ754UYg5gDmFseLQ3qTtgSJeilMBIbVnGW7Ysv0
         gto+nQdwv5lln7d8uNOkYnDcEVUqlrpJ6CgM/D/5Bpd3NM63Q0eyqYx4BkREdvbPh89C
         VM5r9TqelFhj0z1f3qoKrnroRhe1ZUKJIJ71+gdo3tcZZaiE/2Hk1Oh5KZqIwFj63HFP
         4Cy2PmqRAJ9S/9wpLGpL5wLy9pBUfDNctn+oJhcrc3/FbQXtTf6ONDVjgkz94g/E58tZ
         Y1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775224822; x=1775829622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GZJMb8BpsQsC5OCqpX0KvnetYnrUPrII+wbhqXuacG4=;
        b=Qnt3QM8QraulUp3eYTWQ+SRV4tSwaJcBvClYlxPAwpc50wtIfwFWqYz+mZwV/WtieD
         MyWtVTQukttdMAE5VlCFUfIjX9+uPzGcQ8CHAW6/1M+wgFJ1DCVZCVbRFjMeG0UQ0n+c
         LIZWcBODojSk6WJopikonLk4AdwnxfoNGsMA/eEUeL2iMKmqIzoqV6AuvRmsEhSrSVy8
         gxm0x18nsjEEMkFIkWp/U/zsYlTigoFMu2B2HuEr1sViYnvpP3664U+X2RLgYNsK9++n
         hVIJwV6IZ0xthp5N54HxlHxiSMpTkW6eqzeUO4WBXZlfQXFKINtt2lDTfcKgwfeEDIwk
         4nLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVSpZqlQYs1eVKj2ONyz6naLr7enZgOf0DU4gS7lhd5nFnILrGY1YxWjfDsw2EQnIP8Yb0YcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDfHTgGCy9YtXvsjybX4AlBmFogtXXzCVzMuNkep0uha+CjvI6
	9OOhEiuQKFXZxYavaf2mcJjI+plpVGxuxZNIqkhQIjW8jkCbhW7S80JKddbiLW5B0e9m+yv1n0h
	gpWT8Ywg3ik8TdT51jJ4WEnn9hiXIUh4=
X-Gm-Gg: AeBDiet/K8E48SJJRG5Z8m3h2mYl7RBTPdJgg3GX9mI3Cr30oII7tgDovzwfkjKLZeB
	KOpMIWH8k7JUMSAwRgN2Zg/4sLFRM4nZsYaBW5JqU1c76CHTgNoRyxP0tGr+0bA2X4SVPQSFrfP
	gYmjZrHs8Q5GhOCHD6QcAp6UYXf8WphuPLEN2tVejXY0mF20eeeXhP39IT1tb++aEa5SH/DGJaG
	iFprYH45yx1hItbtjgk8chLvm+8oHCt2D9xK+K6Mpv01lpybRy3SW+12KF68N0ODtFtWTwaBsKJ
	e27b4oCkXHen5tTNfA==
X-Received: by 2002:a05:6402:5241:b0:668:50ef:427d with SMTP id
 4fb4d7f45d1cf-66e3f70d42cmr1446085a12.21.1775224821948; Fri, 03 Apr 2026
 07:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331075010.1463-1-midgy971@gmail.com> <0f285782-b12a-4abd-bca7-b6c549bed59f@rock-chips.com>
 <e622cc9e-8fb0-454a-b88e-dc13cf2ff507@kwiboo.se> <89ed223d-1a2c-447d-9f21-76969e668855@rock-chips.com>
 <5663593b-2c53-4632-ad2c-db9efa8e9ab2@rock-chips.com>
In-Reply-To: <5663593b-2c53-4632-ad2c-db9efa8e9ab2@rock-chips.com>
From: Midgy Balon <midgy971@gmail.com>
Date: Fri, 3 Apr 2026 16:02:02 +0200
X-Gm-Features: AQROBzC2wzA0RbJXoNrMzE6k6aC5-WfVfCFoYB3Sb0oM_n_1ycoKvDZTyy5IIMA
Message-ID: <CA+GS1Y3K=N3emYYC-4KAZ27MO7W7ZPgczbk8xPtWC+cYm-5F1w@mail.gmail.com>
Subject: Re: [PATCH] iommu/rockchip: fix page table allocation flags for v2 IOMMU
To: Simon Xue <xxm@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, iommu@lists.linux.dev, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, Heiko Stuebner <heiko@sntech.de>, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233185-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[midgy971@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 51684394EFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 From: Midgy BALON <midgy971@gmail.com>
 To: Simon Xue <xxm@rock-chips.com>
 Cc: Jonas Karlman <jonas@kwiboo.se>, iommu@lists.linux.dev,
     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
     heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
     stable@vger.kernel.org
 In-Reply-To: <5663593b-2c53-4632-ad2c-db9efa8e9ab2@rock-chips.com>
 References: <20260331075010.1463-1-midgy971@gmail.com>
             <0f285782-b12a-4abd-bca7-b6c549bed59f@rock-chips.com>
             <e622cc9e-8fb0-454a-b88e-dc13cf2ff507@kwiboo.se>
             <89ed223d-1a2c-447d-9f21-76969e668855@rock-chips.com>
             <5663593b-2c53-4632-ad2c-db9efa8e9ab2@rock-chips.com>
 Subject: Re: [PATCH] iommu/rockchip: fix page table allocation flags
for v2 IOMMU

 On 4/3/2026, Simon Xue wrote:
 > We internally checked that the RK356x SoCs integrate two different
 > IOMMU versions (v1.0 and v2.0), like NPU and ISP use the v1.0 IOMMU.
 >
 > Both versions can map 40-bit physical pages, but v1.0 does not support
 > placing the first-level page table above 4 GB.
 >
 > To fix this, I think we need to land this patch first:
 > https://lore.kernel.org/all/20260310105303.128859-1-xxm@rock-chips.com/
 >
 > Then on top of that, we can add a new compatible string to distinguish
 > the IOMMU versions.

 Thank you Simon and Jonas for the internal investigation. This explains
 exactly what I observed.

 To answer Simon's earlier question: the IP block hitting both failure
 modes is the NPU IOMMU (rknpu_mmu, at 0xfde4b000), currently bound
 to "rockchip,rk3568-iommu" in rk356x-base.dtsi. Both the downstream
 rknpu driver and the upstream Rocket accel driver (drivers/accel/rocket/)
 use this IOMMU.

 The v1.0 first-level page table constraint explains both failure modes.
 On boards with more than 4 GB of RAM the DTE table can be allocated
 above 0x100000000, and the v1.0 hardware silently truncates or errors
 on that address. The SWIOTLB bounce-buffer path is a consequence of
 the same root cause: with DMA_BIT_MASK(32) on the NPU device, bounce
 buffers land below 4 GB, phys_to_virt() of the bounce address is then
 used as the PTE write target, and the subsequent
 dma_sync_single_for_device(DMA_TO_DEVICE) overwrites those PTEs with
 zeros from the original buffer.

 Please consider my original patch withdrawn. Modifying iommu_data_ops_v2
 was too broad and would have incorrectly constrained VOP2 MMU and all
 other v2 IOMMU users.

 I agree fully with the two-step approach. On top of your per-device-ops
 patch [1], I plan to send:

   [1/2] iommu/rockchip: Add "rockchip,rk3568-iommu-v1" compatible
         for IOMMU v1.0 blocks (NPU, ISP/VICAP) on RK3568
         =E2=80=94 ops with .gfp_flags =3D GFP_DMA32,
                .dma_bit_mask =3D DMA_BIT_MASK(40)
         (v1.0 can still map 40-bit physical pages; only the DTE
         table base must be below 4 GB)
   [2/2] arm64: dts: rockchip: rk356x: Use "rockchip,rk3568-iommu-v1"
         for rknpu_mmu (0xfde4b000) and vicap_mmu (0xfdfe0800)

 One note on the SWIOTLB issue: with GFP_DMA32 in the new ops, page
 table allocations never reach SWIOTLB, so the "track L2 base addresses"
 approach you suggested should not be necessary =E2=80=94 GFP_DMA32 prevent=
s the
 bounce-buffer poisoning at the source. Happy to be corrected if there
 is another path where it is still needed.

 I am happy to add Tested-by to your per-device-ops patch [1].

 [1] https://lore.kernel.org/all/20260310105303.128859-1-xxm@rock-chips.com=
/

 Regards,
 Midgy BALON

Le ven. 3 avr. 2026 =C3=A0 06:40, Simon Xue <xxm@rock-chips.com> a =C3=A9cr=
it :
>
>
> =E5=9C=A8 2026/4/1 18:22, Simon Xue =E5=86=99=E9=81=93:
> > Hi Jonas,
> >
> > =E5=9C=A8 2026/4/1 16:41, Jonas Karlman =E5=86=99=E9=81=93:
> >> Hi Simon,
> >>
> >> On 4/1/2026 9:48 AM, Simon wrote:
> >>> Hi Midgy,
> >>>
> >>> =E5=9C=A8 2026/3/31 15:50, Midgy BALON =E5=86=99=E9=81=93:
> >>>> commit 2a7e6400f72b ("iommu: rockchip: Allocate tables from all
> >>>> available memory for IOMMU v2") removed GFP_DMA32 from
> >>>> iommu_data_ops_v2, reasoning that RK356x and RK3588 IOMMU v2 hardwar=
e
> >>>> supports up to 40-bit physical addresses for page tables. However, t=
he
> >>>> RK3568 IOMMU page-table walker uses a 32-bit AXI bus: it cannot acce=
ss
> >>>> physical addresses above 4 GB regardless of the address encoding
> >>>> range.
> >>>>
> >>>> On boards with more than 4 GB of RAM (e.g. 8 GB LPDDR4X), removing
> >>>> GFP_DMA32 causes two distinct failure modes:
> >>>>
> >>>> 1. Direct allocation above 4 GB: iommu_alloc_pages_sz() may return
> >>>>      memory above 0x100000000.  The hardware page-table walker
> >>>> issues a
> >>>>      bus error trying to dereference those addresses, causing an IOM=
MU
> >>>>      fault on the first DMA transaction.
> >>> Which IP block is hitting this? We'd like to take a look on our end.
> >> I have seen reports that the NPU MMU on RK3568/RK3566 is having some
> >> issue using DTE/PTE with >32-bit addresses, maybe it uses a different
> >> MMU hw revision or has some hw errata?
> >>
> >>  From my own testing at least the VOP2 MMU on RK3568 (and RK3588) was
> >> able to handle 40-bit addressable DTE/PTE, hence the original commit
> >> 2a7e6400f72b ("iommu: rockchip: Allocate tables from all available
> >> memory for IOMMU v2").
> >>
> >> As also mentioned in my reply at [1], maybe the NPU MMU has some hw
> >> limitation or errata and may need to use a different compatible.
> >
> > Yes,  We are checking internally whether different IOMMU versions
> > integrated.
> >
> > I will share what we find once we have results.
> >
> We internally checked that the RK356x SoCs integrate two different IOMMU
> versions (v1.0 and v2.0), like NPU and ISP use the v1.0 IOMMU.
>
> Both versions can map 40-bit physical pages, but v1.0 does not support
> placing the first-level page table above 4 GB.
>
> To fix this, I think we need to land this patch first:
> https://lore.kernel.org/all/20260310105303.128859-1-xxm@rock-chips.com/
>
> Then on top of that, we can add a new compatible string to distinguish
> the IOMMU versions.
>
> >> [1]
> >> https://lore.kernel.org/r/3cd63b3d-1c5e-4a11-856e-c4aeb5d97d55@kwiboo.=
se/
> >>
> >> Regards,
> >> Jonas
> >>
> >>>> 2. SWIOTLB bounce-buffer poisoning: without GFP_DMA32, page tables
> >>>> land
> >>>>      above the SWIOTLB window.  dma_map_single() with DMA_BIT_MASK(3=
2)
> >>>>      then bounces them into a buffer below 4 GB.
> >>>> rk_dte_get_page_table()
> >>>>      returns phys_to_virt() of the bounce buffer address; PTEs are
> >>>> written
> >>>>      there; the next dma_sync_single_for_device(DMA_TO_DEVICE)
> >>>> copies the
> >>>>      original (zero) data back over the bounce buffer, silently
> >>>> erasing the
> >>>>      freshly written PTEs.  The IOMMU faults because every PTE
> >>>> reads as zero.
> >>> This probably need a separate patch. One way to fix it would be to
> >>> track the
> >>> original L2 page table base addresses in struct rk_iommu_domain,
> >>> then have rk_dte_get_page_table() return the tracked address instead =
of
> >>> deriving it from the DTE.
> >>>
> >>>> Restore GFP_DMA32 (and DMA_BIT_MASK(32)) for iommu_data_ops_v2, whic=
h
> >>>> currently only serves "rockchip,rk3568-iommu" in mainline.
> >>>>
> >>>> Tested on Radxa ROCK 3B (RK3568, 8 GB LPDDR4X):
> >>>>     - MobileNetV1 via RKNN: 5.8 ms/inference (IOMMU mode)
> >>>>     - YOLOv5s 640x640 via RKNN: ~57 ms/inference (IOMMU mode)
> >>>>     - No IOMMU faults, correct inference results
> >>>>
> >>>> Fixes: 2a7e6400f72b ("iommu: rockchip: Allocate tables from all
> >>>> available memory for IOMMU v2")
> >>>> Cc: stable@vger.kernel.org
> >>>> Cc: Jonas Karlman <jonas@kwiboo.se>
> >>>> Signed-off-by: Midgy BALON <midgy971@gmail.com>
> >>>> ---
> >>>>    drivers/iommu/rockchip-iommu.c | 4 ++--
> >>>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/iommu/rockchip-iommu.c
> >>>> b/drivers/iommu/rockchip-iommu.c
> >>>> index 85f3667e797..8b45db29471 100644
> >>>> --- a/drivers/iommu/rockchip-iommu.c
> >>>> +++ b/drivers/iommu/rockchip-iommu.c
> >>>> @@ -1358,8 +1358,8 @@ static struct rk_iommu_ops iommu_data_ops_v2 =
=3D {
> >>>>        .pt_address =3D &rk_dte_pt_address_v2,
> >>>>        .mk_dtentries =3D &rk_mk_dte_v2,
> >>>>        .mk_ptentries =3D &rk_mk_pte_v2,
> >>>> -    .dma_bit_mask =3D DMA_BIT_MASK(40),
> >>>> -    .gfp_flags =3D 0,
> >>>> +    .dma_bit_mask =3D DMA_BIT_MASK(32),
> >>>> +    .gfp_flags =3D GFP_DMA32,
> >>>>    };
> >>>>       static const struct of_device_id rk_iommu_dt_ids[] =3D {
> >>

