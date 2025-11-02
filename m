Return-Path: <stable+bounces-192072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB4AC29301
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 17:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12693AD702
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E7320A5EA;
	Sun,  2 Nov 2025 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3iQ/N9p"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744951EC018
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762102749; cv=none; b=hAzeNYzDIlNcEcn6MJY7Hnyxg6zsZnsrlWYjzJSmbFtYgSbAgzATp5zyY7rOs4TyXkyIz/iJt9eMBkmvTlad4hylm/ZtIQ+s4v8ybqW7Vwjh1vWfR0gFtgGSYZzpJT/B2Kh5W5y4yGWyFu5CNa0IApm7fJLRzc5zm0d5Pfrv6Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762102749; c=relaxed/simple;
	bh=iQQNDzmzdTr8GNVIzf2v3/GcbPld6+I+wWoN2T18alw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0IfTYdgH/37Zv/OQLLBmvn39PODtNtiMRHCXM9K3Yf+3GSYL7gWr5b/LeemJjsw2jOi9sN9nbVM2yKat6EWSUE0RWHSa53ld9Yz27fkMBFGB4k/BsaxFbUXEhg+bY08TsZRFmhkbHnGawcp/hmDtRfH37FHdbRtq9Y73xKwQWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3iQ/N9p; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33292adb180so4099072a91.3
        for <stable@vger.kernel.org>; Sun, 02 Nov 2025 08:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762102746; x=1762707546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2H8A9cw3kvMs3bkUEbK9NC3MLhUkDdEmf0tI4Urblvg=;
        b=e3iQ/N9porphCWxJmNXQnZQ9MVG3cjl1Q8Kt755FGS2/vN7SrM+vVXbz45IMOke6v1
         4n3BCcN5xC9HfmfJcJnIVEq1jy+4ZlXk9CmqOA6IyXAS6trTLKkMBpMPyijLnpPG0389
         lFTVShXBAgPU8/QGw0sZ9/hz1yoaLgQQW02GX56nrKnGhqladV3p4o62vczqrKRdXEg7
         LpURi7aR9JyeCTmhPEwBhVlZFX7BEedoQPown/3vSC9yuPs0gFrPXsXh32oA0ThXgPBp
         kyuS7n5PhQsYakviT+oOU/Sk+lA10LRnJFWF7g3kB08cZesUEct7K6SndGzaN7d5pmBT
         OIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762102747; x=1762707547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2H8A9cw3kvMs3bkUEbK9NC3MLhUkDdEmf0tI4Urblvg=;
        b=W4D0gutt31qpDNIvnZ3VR4lSOQF6Fj0OPx1GEiMas+ypod6txfZZbxPgMKdxY5SwUl
         /boj9VVn4zAxs6q1fBny7nIWhsjzqcKymEPeg3BPHGv0nkJxcVAxtwvjPN/YVhEjicAz
         UClWh69OISQpabZ235JyrDV8TTAMgfHMlD5cnl+gdxIXB2Wd6BbINc9caSAiXg+6pFxl
         YbccykQFF/8Tt9YH3JRVwTOzZKuqcMRV2gFgbiFP6yigAADtE36jZyla0ZcMHdQI2f2k
         jXAqM/WzpDPLYBvlveENV3YNrKl24TovzRHZ9a5Ms9PQe0xV3PMV4yQn0Cm37cYqo+it
         oITg==
X-Forwarded-Encrypted: i=1; AJvYcCUdb7iIgfbjG7mkjWIwgH2TCi6Z6tqkNbl8xn75No8Q5uaz6rB5j9Q74Vz2sDlfHPMIMGIVnTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6lOd6wxmenkNZ8r3lt3ChxR3aN8aEHXG3u5y6jih6WUgYQzup
	ZtEX6VTbXUC5tLvCLUS1ymQfJR+Hqkx34hcg3158FxvFWF08hptBlTk4qmxv/FqqGQQtEyMDHz1
	4SSUd1QkQfs5Wve1TXu3qnY2Y4ruA7Ps=
X-Gm-Gg: ASbGncugSRT7w/CR2c8C4f/NikArj6m6WLnd14qEHOPjHq1yCTYu7EvYTJe2vV5o08+
	f/9anGYa1CqeOMyvPcytfZuYw4ulSCZPYVpQR+O+qeCr4QxgjgMv3kPQjPR6XcyBMO3AsO9lRpS
	t0DHdpSTokex6E4ORvUzuFfkaCFM2PrqGc0Lms7HP6LwX1nybGOnNlLT05Zwb+cHZPF1IIYVNG+
	L6K5jIjt3Tqdp7hyP0vvTr3AvkAoWbJcwbPYVVTZs9IAyZEt1UrqE/g9WUosUsQyvsDHHdvW3g=
X-Google-Smtp-Source: AGHT+IFjlhqpuH5VGDhb2suMV/zsTD+1QVQkmaCxgbxr/Pp8L/y4CtuYgIYJ6lyEP01I8OaXB9/MAlSGrK0mTOo6Q50=
X-Received: by 2002:a17:90b:314e:b0:340:d511:e15f with SMTP id
 98e67ed59e1d1-340d511e56fmr4995965a91.18.1762102746574; Sun, 02 Nov 2025
 08:59:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102082456.79807-1-youngjun.park@lge.com>
In-Reply-To: <20251102082456.79807-1-youngjun.park@lge.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 3 Nov 2025 00:58:25 +0800
X-Gm-Features: AWmQ_bkcGo-PpbWMfhxdt3eXO4V0cB_Au_-2jF3It7BqxZY_Pu4fYLIIF6egW60
Message-ID: <CAMgjq7BENujWdD_7htQ6WmvP70sZUTSvLu8vV0YGapEjkvpVxg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: swap: remove duplicate nr_swap_pages decrement
 in get_swap_page_of_type()
To: Youngjun Park <youngjun.park@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 4:36=E2=80=AFPM Youngjun Park <youngjun.park@lge.com=
> wrote:
>
> After commit 4f78252da887, nr_swap_pages is decremented in
> swap_range_alloc(). Since cluster_alloc_swap_entry() calls
> swap_range_alloc() internally, the decrement in get_swap_page_of_type()
> causes double-decrementing.
>
> Remove the duplicate decrement.
>
> Fixes: 4f78252da887 ("mm: swap: move nr_swap_pages counter decrement from=
 folio_alloc_swap() to swap_range_alloc()")
> Cc: stable@vger.kernel.org # v6.17-rc1
> Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> Acked-by: Chris Li <chrisl@kernel.org>
> Reviewed-by: Barry Song <baohua@kernel.org>
> ---
> v1 -> v2:
>  - Collect Acked-by from Chris - thank you!
>  - Collect Reviewed-by from Barry - thank you!
>  - Link to v1: https://lore.kernel.org/linux-mm/20251101134158.69908-1-yo=
ungjun.park@lge.com/
>
>  mm/swapfile.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 543f303f101d..66a502cd747b 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2020,10 +2020,8 @@ swp_entry_t get_swap_page_of_type(int type)
>                         local_lock(&percpu_swap_cluster.lock);
>                         offset =3D cluster_alloc_swap_entry(si, 0, 1);
>                         local_unlock(&percpu_swap_cluster.lock);
> -                       if (offset) {
> +                       if (offset)
>                                 entry =3D swp_entry(si->type, offset);
> -                               atomic_long_dec(&nr_swap_pages);
> -                       }
>                 }
>                 put_swap_device(si);
>         }
> --
> 2.34.1

Thanks.

Reviewed-by: Kairui Song <kasong@tencent.com>

