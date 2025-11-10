Return-Path: <stable+bounces-192950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D44C469EE
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 13:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91E2C4E9DA4
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BB430EF85;
	Mon, 10 Nov 2025 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/2BybgX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3346230E83A
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778054; cv=none; b=dbfVc0wWUZ/bXSWNoj844cA6H0+/QXJJD/qIMdruS4IBePNsF8jU6A1kC2idCMwAqPTrSxTcxJJR3ZBzGLdie95Uttt2u5ttWvOkyTCxUtehI140pjmD+2MldIXJsOX4TYf5NDA7/zOIl9OUCzHV4l7NKQj6lEqfAmjQYqCZNZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778054; c=relaxed/simple;
	bh=AMVbyD8nNSVZt+FCVLLq05ihtlDP/Tor4+bfXvY17so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WaPQXU02LAggiEWlslmxoV1OYLGzM1DCTijJV35KsN2fTd5KvhRDHWWoriPWzFVY4YacIGUZF3T3fUuqQwPKVl5/t+eeZ9LXB5o3ZcxIbbU9QDJDSQG282sYjK+k0EVN2shDTB3twDyCdNHEH7IpDHWjBQzjcSXy6EyHF1fNPSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/2BybgX; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a4c202a30aso2278458b3a.2
        for <stable@vger.kernel.org>; Mon, 10 Nov 2025 04:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762778050; x=1763382850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy5DjoSQimDCENwTSGtt2eMZiZGbRj1r/HV/Tgc/t8U=;
        b=W/2BybgXGkPDMgwtj8AxEXt4CtgYTa0cl0094yUHseYRcLYre2lo15f6RE0CmowP/2
         /Am/hWB995bk6EHtZmAxTfylES6zm36xHOMvl9d8y2L170bQVjXmCcmYjTK9n48Z4NqC
         6r2DAblGCFM4MPzn/wpsvN3iwZHsp+UDQ5wrJpzaEIgSWg/4L39elLbwcJMdjYP1Mkr2
         Z2P5PiUptJPLgwXDGE9xMQ0c6/Yaa0TfLjoFlnXXNBmmTkLK8BwrJqBndXh6x8YbqOVG
         GJ1j7RaEtTxrwwZuTKWxbZYMWK3yZL7BpcFlWZqDtj+FdRYtwtG0hE0vQ/KnXdomrALh
         5zHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778050; x=1763382850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sy5DjoSQimDCENwTSGtt2eMZiZGbRj1r/HV/Tgc/t8U=;
        b=fB8kngl/6rlzLii3c557FiH1WqBSgSeaHq5rfAgJi1SRt2bj1m8eGNeaBrmdhr56FL
         LBeD31DKHHIQ5+q7OU1bww1eheNY/c68HRgQoKCv0KquBor5c3yOajV1GqdIBX2y822G
         5h08PpR6rIbXiwUIDJtTdkYdp0wo5Wrwg9rjoG39KW/FbfciJE6j0r4abPyf2HXTGEqh
         bQ1g87gF01Eb1jdPFXPLENoAJg5XKgXwooqe2Hhv3TPXuQM3bxz3egtpy5Vtj3eeJlGF
         x8pnmH4D7iIliRU4yCEWXNPX/zlCvAUHX/tscItSaYnLSfHnvG92B91kLpT1WZESkGC/
         aDDg==
X-Forwarded-Encrypted: i=1; AJvYcCVJalyYqveHE9SlH6QoBYvjoszNgCJRI/UxfAh7/nZD3Fl/NtKyFMDM3i1ovkbNBXi0n00hbBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywld//Lsmlh8HXQ4dn6RPaVxvctZyNHKaiMJKPftFdcCE26Oapq
	9mt9h4s5odGrnWJpsdI0nb6XQb1ONeM9iiAn9MPW3AYmgQiObRywfCyG7ZHAnNWeuF+ZNVXcMjS
	v8lEuPeEPmP9fTw9HQhNx8mLSv0UOCpg=
X-Gm-Gg: ASbGncs7qe2eRDAlCfJGC0x9wMv/dqNy5okz0Y+9oB3VUm8ZiWv3eiQj6/STcp+B/3s
	GuVHjSvIEvU3PwDgY9/EStWdv3xcjcYWo52+AqDFgkviExpkZ2cYpu/JHFoP9Qv6rpXTZjo7+a6
	2W4/Ocgf3x/GVq8VR3sV5sIqTTZMCzC5uo5OhoCWY3QA6T5637M3BOqiv5HlDuEgt7mbenoBGH2
	eqvk0Aw9DgAOiweELp4I24OGZzudI/S+cx2E+GlKj5Vs86TyPtA/0CYIqcTGyPzGD9LzeCan96t
	Po7Szo7XsFUtdjVP85wjxVLbA7o=
X-Google-Smtp-Source: AGHT+IGyg9aZV4dgyvFuRtdSsElpeyZ+CpTXqovvGuPUeZo+pqdjOClLE9fxRv8gppzbemj2+mN2w/AMZs0pWBdc88E=
X-Received: by 2002:a17:90b:3b43:b0:340:dd2c:a3da with SMTP id
 98e67ed59e1d1-3436cb7aa3emr8354432a91.8.1762778050319; Mon, 10 Nov 2025
 04:34:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110-revert-78524b05f1a3-v1-1-88313f2b9b20@tencent.com>
 <875xbiodl2.fsf@DESKTOP-5N7EMDA> <CAMgjq7CTdtjMUUk2YvanL_PMZxS_7+pQhHDP-DjkhDaUhDRjDw@mail.gmail.com>
 <877bvymaau.fsf@DESKTOP-5N7EMDA> <CAMgjq7BsnGFDCVGRQoa+evBdOposnAKM3yKpf5gGykefUvq-mg@mail.gmail.com>
In-Reply-To: <CAMgjq7BsnGFDCVGRQoa+evBdOposnAKM3yKpf5gGykefUvq-mg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 10 Nov 2025 20:33:31 +0800
X-Gm-Features: AWmQ_bnm3NOQhTmQKSG361K0h_1KBf9RdCY2Qg8AObjYfkOGH4tdJ9Y2X52coCY
Message-ID: <CAMgjq7C5H0rV4tkosUEtwvHTd5bO+jxyQkW4xjP+8-qnjh=oiA@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm, swap: avoid redundant swap device pinning"
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Chris Li <chrisl@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Youngjun Park <youngjun.park@lge.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 7:37=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 3f85a1c4cfd9..4cca4865627f 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -747,6 +747,7 @@ static struct folio
> *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>
>         blk_start_plug(&plug);
>         for (addr =3D start; addr < end; ilx++, addr +=3D PAGE_SIZE) {
> +               struct swap_info_struct *si =3D NULL;
>                 leaf_entry_t entry;
>
>                 if (!pte++) {
> @@ -761,8 +762,12 @@ static struct folio
> *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>                         continue;
>                 pte_unmap(pte);
>                 pte =3D NULL;
> +               if (swp_type(entry) !=3D swp_type(targ_entry))
> +                       si =3D get_swap_device(entry);

Oops I missed a NULL check here.


>                 folio =3D __read_swap_cache_async(entry, gfp_mask, mpol, =
ilx,
>                                                 &page_allocated, false);
> +               if (si)
> +                       put_swap_device(si);
>                 if (!folio)
>                         continue;
>                 if (page_allocated) {
>
> I'll post a patch if it looks ok.

