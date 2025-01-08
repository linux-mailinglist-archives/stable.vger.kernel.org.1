Return-Path: <stable+bounces-108036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 281F6A0669F
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 21:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6428C188A4EB
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 20:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EDD202F96;
	Wed,  8 Jan 2025 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OvIL+BXq"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397B4202F89
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736369472; cv=none; b=BqAPZY5K1+DQhzX2lUJ+9TXRQrlFqq39lsyiQvPlZgj5eOhdccEzSBd1O5nfHA/hUjfXGAOGPzyQXMVcjMTBEmehAo68hs+ILI2h41+0ROA3W/R2WAKNKXY4LZu+xyGmaSJyHX1Xx3PNpjp9+OXBDhcV0u4wSRn+TN5XQHCGE4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736369472; c=relaxed/simple;
	bh=5zmXWfat4tRFnI9XpZbcnO66AWQqeUJUgKEsqaTlE78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzUf/G1DTKkFY1ZjqezVVyjnwQOVLxH3rmFd8mThER0MqJIwlSvqd1f1hpyYNk7z6dtqS/g0C1wVa9jf4y8vt8ftztGOMw67EGF+QnQ5Aj1A85AJN/5JOHehcnU+qFvr/YuM08pR95vIuycKrSvFaOv5fRQaO9dFi2FqN+3c8PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OvIL+BXq; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d89a727a19so11570926d6.0
        for <stable@vger.kernel.org>; Wed, 08 Jan 2025 12:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736369470; x=1736974270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wx/VEGMkeIt5WYq6KEeveH6sAZ8pY1jywkUqWY0DpDE=;
        b=OvIL+BXqzghDdMGh7j9FRQHm7kFzclMUPxzaeiwuk7mwOaZTiKKbXll8Ib47nq8tXi
         KW2zJUhLYGiUXoREnOEqatbilhjTgZJIdrQ9ddoQXdg64Iu9soJLzebfMMMgnFhtdQwb
         WT9J26mO0WM/JWOFHDsb5KRUyjWO+L0xCsoArWSCoarB8mWQwe1R9czW13FrkKlN/OI1
         HwMBwR5ybJq6BSxu0g+Dlg24B/zBlvgnEk9FsPaeBufBTQWt/xR6tcsQZl0U6pL3yPaR
         np/fNq9j4U6YcMR45gqoXJQkAwObC8hFZYZJ18lkwgLwMRPsmiqL8AMu2WhOH88YT/3M
         Uw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736369470; x=1736974270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wx/VEGMkeIt5WYq6KEeveH6sAZ8pY1jywkUqWY0DpDE=;
        b=jNlIvaNV5YmcO+1Om6fjj6oPN5nnWRToRC/wkkH5wh/p4wmT+yqVF4KuFC4+bLVgUT
         JtHAKyuIb3pa2rGTk6hEC71LFK1ryh+QYidt6SE8k/Gw341LFGiI9oT8hr1PQRbe4uJw
         +iA8Y+ByTorjN075jB8WPquEnBbeAz/2dZ5v/3KRxonxKr+UuA+s3SA8rERHkYvUE1Wb
         xSpYWIaVXl3yOt/hOa7RR9MSLYU9ywlCMNRVj/MhCOimOy1mLDwGhafBvjSDdHNAFb57
         pcgblNYZpFPoaJ/ssKM6LNc3zlhLynPbGcAesyFtYjgt6ioyaaYt09rwmIhpIdYAxbJe
         bT8A==
X-Forwarded-Encrypted: i=1; AJvYcCWb5lFumdShyA9oWJIhOCHrgqU9SwzwEQ0DlPbqtp7WzbtjhwQGdZOXZig79EiwwAjoFLx2qK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUYyoYbmZIVj8MWQZzNZuCxN/4EV0XueVjdzXHIH0+G53RQQzx
	MaoAag0TUtRMtYrjYDmnANKngQ5odt+WTQPyZ/Q3K7ZN0mv9AdQe71GqUBl4cOqqsPpYodYsPzS
	nqv3pv8GxMrJ9sAIUwVdsnu9zMpu5B7qMw3h7
X-Gm-Gg: ASbGncvHnMxpzUIFK2KZ/D0IixD4WQza/q3mR02noF8tgzYfa367LoofG45xmBT/vxI
	aeOE9L3v3dmZYko1xmRXhlt06/KI1KqSRwjU=
X-Google-Smtp-Source: AGHT+IFQNnq/INYgA5nBsQT8tp6CMYs66PK8YQLseNJtE/Y8rrYvRne6lKX5fTDj6weDS2lADETm0mU7k4QbQ1lMFYk=
X-Received: by 2002:a05:6214:240f:b0:6dd:d24:3075 with SMTP id
 6a1803df08f44-6dfa3ab42b5mr10878176d6.17.1736369469975; Wed, 08 Jan 2025
 12:51:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108161529.3193825-1-yosryahmed@google.com> <SJ0PR11MB56781DA3F7B94E44753FAB51C9122@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB56781DA3F7B94E44753FAB51C9122@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 8 Jan 2025 12:50:33 -0800
X-Gm-Features: AbW1kvYw9p95QyAd_z1vXO7uv74RqqK16Z8scGAl5-Kxnxx3uwCBPbG6gFr7GQQ
Message-ID: <CAJD7tkY5t96siv10Bbve1W_p7LUkW4iHQj_Gg4cbX0hpQuk7DA@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: properly synchronize freeing resources during
 CPU hotunplug
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vitaly Wool <vitalywool@gmail.com>, Barry Song <baohua@kernel.org>, 
	Sam Sun <samsun1006219@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 12:23=E2=80=AFPM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
>
> > -----Original Message-----
> > From: Yosry Ahmed <yosryahmed@google.com>
> > Sent: Wednesday, January 8, 2025 8:15 AM
> > To: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>; Nhat Pham
> > <nphamcs@gmail.com>; Chengming Zhou <chengming.zhou@linux.dev>;
> > Vitaly Wool <vitalywool@gmail.com>; Barry Song <baohua@kernel.org>; Sam
> > Sun <samsun1006219@gmail.com>; Sridhar, Kanchana P
> > <kanchana.p.sridhar@intel.com>; linux-mm@kvack.org; linux-
> > kernel@vger.kernel.org; Yosry Ahmed <yosryahmed@google.com>;
> > stable@vger.kernel.org
> > Subject: [PATCH] mm: zswap: properly synchronize freeing resources duri=
ng
> > CPU hotunplug
> >
> > In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of
> > the
> > current CPU at the beginning of the operation is retrieved and used
> > throughout.  However, since neither preemption nor migration are
> > disabled, it is possible that the operation continues on a different
> > CPU.
> >
> > If the original CPU is hotunplugged while the acomp_ctx is still in use=
,
> > we run into a UAF bug as some of the resources attached to the acomp_ct=
x
> > are freed during hotunplug in zswap_cpu_comp_dead().
> >
> > The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to
> > use crypto_acomp API for hardware acceleration") when the switch to the
> > crypto_acomp API was made.  Prior to that, the per-CPU crypto_comp was
> > retrieved using get_cpu_ptr() which disables preemption and makes sure
> > the CPU cannot go away from under us.  Preemption cannot be disabled
> > with the crypto_acomp API as a sleepable context is needed.
> >
> > During CPU hotunplug, hold the acomp_ctx.mutex before freeing any
> > resources, and set acomp_ctx.req to NULL when it is freed. In the
> > compress/decompress paths, after acquiring the acomp_ctx.mutex make sur=
e
> > that acomp_ctx.req is not NULL (i.e. acomp_ctx resources were not freed
> > by CPU hotunplug). Otherwise, retry with the acomp_ctx from the new CPU=
.
> >
> > This adds proper synchronization to ensure that the acomp_ctx resources
> > are not freed from under compress/decompress paths.
> >
> > Note that the per-CPU acomp_ctx itself (including the mutex) is not
> > freed during CPU hotunplug, only acomp_ctx.req, acomp_ctx.buffer, and
> > acomp_ctx.acomp. So it is safe to acquire the acomp_ctx.mutex of a CPU
> > after it is hotunplugged.
>
> Only other fail-proofing I can think of is to initialize the mutex right =
after
> the per-cpu acomp_ctx is allocated in zswap_pool_create() and de-couple
> it from the cpu onlining. This further clarifies the intent for this mute=
x
> to be used at the same lifetime scope as the acomp_ctx itself, independen=
t
> of cpu hotplug/hotunplug.

I mentioned doing this initially then dismissed it as a readability
improvement. However, I think it's actually required for correctness.
It's possible that the CPU becomes online again after
acomp_ctx_get_cpu_lock() decides to retry but before it unlocks the
mutex, in which case the CPU being onlined will reinitialize an
already locked mutex.

I will add that and send a v2 shortly.

