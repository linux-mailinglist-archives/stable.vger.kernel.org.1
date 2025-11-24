Return-Path: <stable+bounces-196750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9408C80F93
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 15:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50C53A81C4
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841C030C63C;
	Mon, 24 Nov 2025 14:21:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB089308F32
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763994082; cv=none; b=fX8OSOhSVjMlKxsmQ7pWQbUdfXZRGkruQUkhbz6yHQEYT+6TrlLo0Kaw0ouMwPw3Gd8RkE7VJG4a8NmWlXC+Gjty6RKyOndXeHY1N19Owm5Vqh2fLUS3d0HGzFWuv2IEwrsWHZ2roAKVUoEgJXuc7+2/GZLWxT9ZqkC3uoahqoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763994082; c=relaxed/simple;
	bh=dCfY/5dMEkVPjD6YAtXB+73QblfC2Qoexi2JBaX5Sok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvpvxkWnZAcYRJ4HjkiKTo/H4dWoKLeaXMp3C841+Y+G6BmQiZMM0WuTeCTKP0lcjoq+nl67zixFg0VbawOPDVHzVvK75HhqGpnB5tcFnOmxfHwKphi7VRhEz+TJ0GGIb6KdEvJSDAXfJ+Z4o/wiuN7uknP5YgnI3erzISlFWP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so7362175a12.3
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 06:21:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763994078; x=1764598878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUFSLiAWL8OVw+Y8TYrXfAUgXhJH/5VJkp3fvGhEutY=;
        b=kl3ghU0iOwXrp3d0C5k2rxlhklTPCOycaQpMjKFTNGZBYE9LK2AUN5S7kF5fMMahzZ
         HoEvx9Zouuv90lUwNhFXRPbpgl0xoJxggob3vJZ5r5w0vBEAs6XtRWuewYZb0wDNceWw
         SHTjxGi/FcC9qJ1Pu8p9vE3HPxLgerPUYxai0q8WWVYCheDMMORDVLddqq0jCanCU74f
         /AAOy0cuBVUU03jnnPKow4mKidKpZQNvAafDmodlMhgFVWZjc02zdTK8I3kxPGNotZ3S
         Fw7XuD43D2J+naNNR9K/BDvxufOMhid4vKt3T+/AZbnh/6fiesY1xJJsKWnqre4l4hNs
         u8tA==
X-Forwarded-Encrypted: i=1; AJvYcCXPj6UT+c2nA1hTbipy3Md930qtGPDd4mhIuwH0mtLtk3Vy25rsCdJMRKAoeOzm/lHvCHWfS2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvxKQzYNGGoOycnu37Zde8ndlbpNNcoqKJ7gVRCSxGH9O1NCJn
	v7F004egzeyUO0kpP74lX0yo+99gxb1eSIzULiGudl6p+aRHuB8wYKVrzb6GBgDj0bg=
X-Gm-Gg: ASbGnctrh5W8Nk2noViDyYrbBICdhUzxWKQMEXryJ7JK/y/vgp8I7eHLJXdbRBYm7IT
	hHXGRUc2bG7AuxoROgB7+QsY4A2PyiIUxqv+ZomrcvNua6L2ZpYGZxRefB7x3tJHhVuAx/EFXVz
	3UR5p5UElW8Bt/zP5Qbj1Qsf3CmTKFG1Qz9EiDcD4BJJ5zSk1KqNIs7i9dSs+qck7D4udJg/oNA
	A/ImJDeNe3y0OA9Yd0t9+orSURi3yRf017KgwMG6dq+8DuQYzCRyUrrqfS9Wsa8M2+/AblbT3SI
	OX6kT8nl+Nq25wYUp9lo8Gw8lBUhqFBaxR7X9fTSL0WBsbv3mAV6W41P6+7r3RiTzX+yxICy4gu
	B4D8h4S9DXNgzT58s0LaA790fYXR0ttrX0S7ubtZJvWSP+3UVhD6Z2E1aPfdKPkjTo/ZAKpB4ju
	Tgm8fm5DAkheLgj9SrFHxuiG76b85jdJRcfJiXpg3CWoLyWdkQ
X-Google-Smtp-Source: AGHT+IEFuAq2k1Su1vnNMGbG11nYSPfD/Gk5EoEl6Boffe6emBHqgU8aOY3Vn1uP47hTi40gvqCw2A==
X-Received: by 2002:a17:907:968c:b0:b3c:8940:6239 with SMTP id a640c23a62f3a-b7671b12672mr1241899866b.52.1763994077564;
        Mon, 24 Nov 2025 06:21:17 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7655038011sm1304796566b.62.2025.11.24.06.21.14
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 06:21:15 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7373fba6d1so693973366b.3
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 06:21:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVK5eSV0axRfjPnc4+NNH6GCCBfi++kzQzd0yaxm4hA1MSfjDKvyTWxMFTbhdnX6UTcn9G9poA=@vger.kernel.org
X-Received: by 2002:a17:907:7213:b0:b73:2ce9:fa76 with SMTP id
 a640c23a62f3a-b7671a469a1mr1156653166b.33.1763994073952; Mon, 24 Nov 2025
 06:21:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114193711.3277912-1-chris.brandt@renesas.com>
In-Reply-To: <20251114193711.3277912-1-chris.brandt@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Nov 2025 15:20:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW98bnhfGMhvX9gUekgjS1fEhebOUvxzv9GXY8v3u5aRA@mail.gmail.com>
X-Gm-Features: AWmQ_bllDnnos8zJ8Mu8saYcqAuJrQ-8hDIk3lfEy3od343oWUHxQ6XMSDK77dQ
Message-ID: <CAMuHMdW98bnhfGMhvX9gUekgjS1fEhebOUvxzv9GXY8v3u5aRA@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: rzg2l: Fix intin variable size
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Hien Huynh <hien.huynh.px@renesas.com>, 
	Nghia Vo <nghia.vo.zn@renesas.com>, Hugo Villeneuve <hugo@hugovil.com>, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Nov 2025 at 20:37, Chris Brandt <chris.brandt@renesas.com> wrote:
> INTIN is a 12-bit register value, so u8 is too small.
>
> Fixes: 1561380ee72f ("clk: renesas: rzg2l: Add FOUTPOSTDIV clk support")
> Cc: stable@vger.kernel.org
> Reported-by: Hugo Villeneuve <hugo@hugovil.com>

Closes: https://lore.kernel.org/all/20251107113058.f334957151d1a8dd94dd740b@hugovil.com

> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.20.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

