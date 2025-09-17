Return-Path: <stable+bounces-179809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5318B7D631
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6DF4E1F49
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 08:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F7E309EFD;
	Wed, 17 Sep 2025 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nMFHz4rL"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4D230C60A
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098868; cv=none; b=hbPl5iXqXL17pwNeW/VkzQMwmhyDrNaYWcA/n/tkD2i+Pz4J1/faPrNBznv4Kz7ngoXWC7bOtdfwKnp6q7bStl+w1BS5HdHcuiKteaaq6UvMbsT5L3ZUGntBmHQrWCqnRmncXXjAGOwHx8nwhzh59dWNz5qLhrmA86ezgHpa6o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098868; c=relaxed/simple;
	bh=mD1dKSaDbFABDNdxhBOrHC0pI1BKnXyc1MHH71Bb614=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNEumxcBBJTWBpMBAkrXxIlmoI/qzlyJKVVLN01yCAkQR54eA639KvfNMe2IqjouBA6fxvw4B1hx6ViuX7tmOCta1GlT9i/ZTkAPAFoTdiBSz4J6WmAXRhr2MXM7DNpSOMnztTRK+4iV20zUGOwV1zANcm5t8iL7p/Qu4LeqBLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nMFHz4rL; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-7799a118b87so30939206d6.3
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 01:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758098862; x=1758703662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSQBwTY7x8IQoxtsTDFfPaHwMvtropOKYFv/BGH9LuE=;
        b=nMFHz4rLjW9HxACLfiGmFUDToCY8xwg3npc15bK5XMjrlNTdzc/sYKlZNyYjkiJfGV
         04709FfI9hX4IQyLJ7g988v3DW+ZR9dju8jlw3jQkKIhABgqSomLxrvzNVlNclndI92e
         c58nFVIiq2itPPGMNki0u2UyFSgm03ZV5JC7j7UrBDtHRldm691Li1IU1NevcMlG+Q0r
         T9ioL2PauUpuY3pdIHhEoGaT3I3lNRfrShFnPUBnQ9xnlme1deOG7y2l5Km5miG10rZT
         Sw7KaDM/c7b4xNktgKwB+rMrN8eNbu28K+KoBe0GdhmPot3yrgFcifmKnCOIdEv/dyts
         l9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098862; x=1758703662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSQBwTY7x8IQoxtsTDFfPaHwMvtropOKYFv/BGH9LuE=;
        b=iq4l3MLnGEbangvL/F7c6UfVt3pf+SUCYAarOPCa6TBQd+8VTCF59VhO9Ogo2SMhZ8
         Zt47Fj4q5Eq+wMhhUCHjarZEFvsKERb+ujJ/4Xv0WDrIjp53Dn3OQ9f+HMY+Ior6iJmW
         T1MZkwGalK++BUDmU/nuzCX7fs+wuafJn6mZsrtavAwemjafCLfha9fgI+arCh7wK3GS
         KaZpiT4RzNLIB0TIBBnFIEvRW/o7F+3TxvVF9HvQQiOkgAjSEuDUx9ILigdufd6RLfJt
         8o7DT7LFFFY6CS6DKkNJ2CqgmxHcq7HG5ycpbChnMPjKW3ZMfVgTksohouXtdzpjkSev
         LTwg==
X-Forwarded-Encrypted: i=1; AJvYcCXg4ueTiWSumI6ydG73QWVYKU2Fb55trhxJ38q46Plzpue9AmC5tdVbzbOlYDSaYQHl5uwD/4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZx3X/oQCJ5w32kW1lPR1Ph5bL6aqZzeoUB0mBCq8Gbgjebahl
	i8YDxB/eD9dOX6m5hq8qs68ZjCZ70YGtC3yYZyqOQCI+3TV4QDtBI/IEl/AaH2oGvmB9ALeQLkh
	dV9ypOQmqMLsHxxoQ67mBEHkEzrAwAosuwgnkzzjW
X-Gm-Gg: ASbGncvA5CdyBQZdGsIC6+lsh7ln35L8UO/QebhrYlei5/8dhYcohkYQ4CdsU+r2Ouh
	vcbQZT8NQiyft4ozfyvZd8FFx90GXpp9csIw60ez5Orv4/KwGNgwJiXoYBKNFvhhnc12n2E9tWw
	rXb17WTKYyI27TVznUR25IPloH8H9Ltfos+yYwchm3VVySwW+MK+64v3fOWa6uE+LIH0L5IKwcy
	s7NTkC3gQ69pSyPJbKMFa1oT8+P0t54jLtDutaQGBA=
X-Google-Smtp-Source: AGHT+IHQqM5a49OQaZzq5NlAj4f7mo4PVwkO0Od/qpE6zKcTcL2cYsdQMpOPx7K+APxdGyrFaBcGHMy5truFRbrqA1M=
X-Received: by 2002:ad4:4eab:0:b0:76f:6972:bb91 with SMTP id
 6a1803df08f44-78ecc6316d3mr11179046d6.10.1758098861793; Wed, 17 Sep 2025
 01:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911195858.394235-1-ebiggers@kernel.org>
In-Reply-To: <20250911195858.394235-1-ebiggers@kernel.org>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 17 Sep 2025 10:47:05 +0200
X-Gm-Features: AS18NWCHIE1dESGpN9uvlB5H-Nyc3e2nakhbUlwz_P_LJD2Kd7WI7My-Di8UNK8
Message-ID: <CAG_fn=UY1HxmxpkM_YFGbr8W272F_bZgZHKiuvbsUjgFCs1RcA@mail.gmail.com>
Subject: Re: [PATCH v2] kmsan: Fix out-of-bounds access to shadow memory
To: Eric Biggers <ebiggers@kernel.org>
Cc: Marco Elver <elver@google.com>, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 10:01=E2=80=AFPM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> Running sha224_kunit on a KMSAN-enabled kernel results in a crash in
> kmsan_internal_set_shadow_origin():
>
>     BUG: unable to handle page fault for address: ffffbc3840291000
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 1810067 P4D 1810067 PUD 192d067 PMD 3c17067 PTE 0
>     Oops: 0000 [#1] SMP NOPTI
>     CPU: 0 UID: 0 PID: 81 Comm: kunit_try_catch Tainted: G               =
  N  6.17.0-rc3 #10 PREEMPT(voluntary)
>     Tainted: [N]=3DTEST
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.=
0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
>     RIP: 0010:kmsan_internal_set_shadow_origin+0x91/0x100
>     [...]
>     Call Trace:
>     <TASK>
>     __msan_memset+0xee/0x1a0
>     sha224_final+0x9e/0x350
>     test_hash_buffer_overruns+0x46f/0x5f0
>     ? kmsan_get_shadow_origin_ptr+0x46/0xa0
>     ? __pfx_test_hash_buffer_overruns+0x10/0x10
>     kunit_try_run_case+0x198/0xa00
>
> This occurs when memset() is called on a buffer that is not 4-byte
> aligned and extends to the end of a guard page, i.e. the next page is
> unmapped.
>
> The bug is that the loop at the end of
> kmsan_internal_set_shadow_origin() accesses the wrong shadow memory
> bytes when the address is not 4-byte aligned.  Since each 4 bytes are
> associated with an origin, it rounds the address and size so that it can
> access all the origins that contain the buffer.  However, when it checks
> the corresponding shadow bytes for a particular origin, it incorrectly
> uses the original unrounded shadow address.  This results in reads from
> shadow memory beyond the end of the buffer's shadow memory, which
> crashes when that memory is not mapped.
>
> To fix this, correctly align the shadow address before accessing the 4
> shadow bytes corresponding to each origin.
>
> Fixes: 2ef3cec44c60 ("kmsan: do not wipe out origin when doing partial un=
poisoning")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Tested-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

Thanks a lot!

