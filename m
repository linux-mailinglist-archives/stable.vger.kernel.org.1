Return-Path: <stable+bounces-206326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BDED03FAC
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E69ED3030E13
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB1347203C;
	Thu,  8 Jan 2026 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YawHteLV"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE1A4735D5
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767872407; cv=none; b=Eil1yFPBWAYAoeZPMnj83TqPbjvRTDNvjObcx3JPymVwrx/cJVQyBB2+1VLE4UqI2RPAIhK9u0geRpE1UpNoSsBGIbLvb+GR0kDGfRlCSQsGcPGUB6WpuIdG1/8rETnfC+GD4DIQlfpEdfvcCD+u2uDoxEOC3AtztXQO/rRxRrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767872407; c=relaxed/simple;
	bh=ezvnqHz57gvkldOznzeZCMww1jUfcQ7xappaEfnvzZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxTvoEWOr99SYoMrQ2RyphORkPxiL2tQsHAsDfsolFcBfMEtUhCFoLH6sOhOGRnqydwalMmmnpZcBNkieqClaGFgukQ5eDYbZp6tJzSBAg7yIyiwd5z5IfocAD1qVPJzK+5nb5gCqUloBDtXfLjiKOTTUKhKxB8mcSGyc52ooiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YawHteLV; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8907ec50855so32942536d6.3
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 03:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767872400; x=1768477200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=De/F7GrZ3a7XQW11zwFhVMyznAHPN5+HCcRNv17+1Go=;
        b=YawHteLVrnHK3lXXOFIIgMvlqbUWb1l2jMcI7SZhdlee5Hk49JnqZPZHuqm+TVpzZz
         4RicRRov650HZEdbMMi3ueF/cXYISxpVbPE3M4WZVRsxHM53TZnDdoRJiva3rFqsnjTV
         GwOZxFVa5V0hxW/DDbqvAXSnvAQLvH1evxeMNUpFshLrEWEsFXmo+o29w3mve3mIjfPW
         lBrdOYalCBklb+kcFbqrC1c0jeb6nOYkmKKQMNaEkoWGHs070V9YKA7TKkSYwaBRL/b5
         e+ky/HkNZclcQoKMLxzmqhmjvq57wXiaiGu2KK7noDOY9rdvSGbmVPMYab+QmIgXiGUT
         zHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767872400; x=1768477200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=De/F7GrZ3a7XQW11zwFhVMyznAHPN5+HCcRNv17+1Go=;
        b=fyYr3PfZi97gLk3DjfkqB+TTz1BRLpMTCACtNAg4MJz4osxHZkv8GW8i5aSwwgMxNx
         IS/gzmKZKyOhgiiU8iePrtDExFXr3nh88dr7AkOtlP0OUBbIqwZot25LcOskG1nOxNxI
         P11bAlAdX+cr3vHiHHRRpqpFaL5+AI7JZm6uh3kwJTaLgOQQwZfDGIWDqf40jMIHWudb
         F9pp5/BqIq6JxvOh1sFVRyICNUKIXpsrdIFipgII/zKB3vB9DZo6Z042cqrhG5oUUtx2
         qPbfhuqKe3cu2Xyp7oHayBcParPv4duv06I4nvsNilKMU3mxsGqK0Qkp9L9UoNidXlrp
         EJcg==
X-Forwarded-Encrypted: i=1; AJvYcCUK6PW/dUNBcfMwCk19yCmQ6UFrTY4xLje/scDKn5JQsFXv7OOSbACqsElZ3wAP16oBXlLz3Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcrupVz99PMqMWJP7E+m7EVfXiy5CWh9h5MD8SKOeDA2lIYd0p
	NpkUjlIFSwRSu4DmaVsCZdfEhICKO7Fc8ciIGe1CBGKsWoEhukOfzebIR1km4LF54iKoFp/dSzQ
	xjYUa6dPSBlVCFemm56+SxnYmTLtLbJbMG6vm8gxw
X-Gm-Gg: AY/fxX4IUhtcX2d8TUbg6fcHfaqQBRFPcRElY27l/iy19gkVfD1jeGZw03UlBxJhpT1
	+GOOgty1d9bgTIh/pTDWybjkStWu9RUBQJEkj1c17rGPzkFtXvx5GlivZpEE8N7nANg3+pOkN8s
	bbS8QAZkfbiJX+4eIn/keWlm7RXrbVIxczgRPsMx7eYH36WDqHhX5UPaaVnlI0ynea4S/+yt60L
	4e+QlhU6lZRxH0sw/s0XkUm9HhPuGQ/2jPrxVd6fbyvi4M/amii+IW1kRxt5IrbTrLFHJt5uyqa
	zGUSZ8lVr1MLur5SrzkmlD0yyQ057SR9PCGu
X-Google-Smtp-Source: AGHT+IEtTsutQpO25KKJJxkwWclrV1NkoOFyJBOS1res7lIatKk2McpUxH3uFSbvGt+LR+VAYJv6MCV9dzQjj1c4j+4=
X-Received: by 2002:a05:6214:20c4:b0:87c:152c:7b25 with SMTP id
 6a1803df08f44-8908417a83emr85986576d6.13.1767872399549; Thu, 08 Jan 2026
 03:39:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105080230.13171-1-harry.yoo@oracle.com> <20260105080230.13171-2-harry.yoo@oracle.com>
In-Reply-To: <20260105080230.13171-2-harry.yoo@oracle.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 8 Jan 2026 12:39:22 +0100
X-Gm-Features: AQt7F2p4_VUyRgHz6qqEM5-JBZ5E2KV2nkrPg5vKNyZeCt2rwmq1SfsxSID667s
Message-ID: <CAG_fn=XCx9-uYOhRQXTde7ud=H9kwM_Sf3ZjHQd9hfYDspzeOA@mail.gmail.com>
Subject: Re: [PATCH V5 1/8] mm/slab: use unsigned long for orig_size to ensure
 proper metadata align
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com, 
	cl@gentwo.org, dvyukov@google.com, hannes@cmpxchg.org, linux-mm@kvack.org, 
	mhocko@kernel.org, muchun.song@linux.dev, rientjes@google.com, 
	roman.gushchin@linux.dev, ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, 
	surenb@google.com, vincenzo.frascino@arm.com, yeoreum.yun@arm.com, 
	tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, hao.li@linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 9:02=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wro=
te:
>
> When both KASAN and SLAB_STORE_USER are enabled, accesses to
> struct kasan_alloc_meta fields can be misaligned on 64-bit architectures.
> This occurs because orig_size is currently defined as unsigned int,
> which only guarantees 4-byte alignment. When struct kasan_alloc_meta is
> placed after orig_size, it may end up at a 4-byte boundary rather than
> the required 8-byte boundary on 64-bit systems.
>
> Note that 64-bit architectures without HAVE_EFFICIENT_UNALIGNED_ACCESS
> are assumed to require 64-bit accesses to be 64-bit aligned.
> See HAVE_64BIT_ALIGNED_ACCESS and commit adab66b71abf ("Revert:
> "ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS"") for more details.
>
> Change orig_size from unsigned int to unsigned long to ensure proper
> alignment for any subsequent metadata. This should not waste additional
> memory because kmalloc objects are already aligned to at least
> ARCH_KMALLOC_MINALIGN.
>
> Suggested-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: stable@vger.kernel.org
> Fixes: 6edf2576a6cc ("mm/slub: enable debugging memory wasting of kmalloc=
")
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  mm/slub.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index ad71f01571f0..1c747435a6ab 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -857,7 +857,7 @@ static inline bool slab_update_freelist(struct kmem_c=
ache *s, struct slab *slab,
>   * request size in the meta data area, for better debug and sanity check=
.
>   */
>  static inline void set_orig_size(struct kmem_cache *s,
> -                               void *object, unsigned int orig_size)
> +                               void *object, unsigned long orig_size)
>  {
>         void *p =3D kasan_reset_tag(object);
>
> @@ -867,10 +867,10 @@ static inline void set_orig_size(struct kmem_cache =
*s,
>         p +=3D get_info_end(s);
>         p +=3D sizeof(struct track) * 2;
>
> -       *(unsigned int *)p =3D orig_size;
> +       *(unsigned long *)p =3D orig_size;

Instead of calculating the offset of the original size in several
places, should we maybe introduce a function that returns a pointer to
it?

