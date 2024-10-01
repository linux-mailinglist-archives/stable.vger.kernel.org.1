Return-Path: <stable+bounces-78536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC53798BFB1
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F73B2852C
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693651C9B78;
	Tue,  1 Oct 2024 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uau/vZa5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D841C9B75;
	Tue,  1 Oct 2024 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792217; cv=none; b=gD7WUYnHeECpnWVULjjnlgBFq/esDHgLxsWYQJbHumCRW0qOsL62afYCQ2RlKjPJJtfoxd+E7rQawOK6KyoL89upG1LTETL54zUXFrfqT8rCWEcqHkeZ6zpeRt518tTcrFwtaNxsSE4aleN/gjtm9C6o9M+e5VoiuMYT7elxXGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792217; c=relaxed/simple;
	bh=g41OALnsL4wl6u9fk+xYcaWtmMY9YbrmA0fZDhVPSC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXJyxVDt7AJL7hLfawhmZOGFGMco7q6RX4dyyic8s7WCgwOU2D2h9qsPIWglLxBBbgctVlncoybMj6B3CDYMQoPQ5xMBCQh66SJuul01jE3YKdMpZXJ/5vVRLPYirKCMdlbpd5pB4IIOWJPoO/ICTB6Nui1p+yVcO6debODFs6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uau/vZa5; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-710e489860bso2885275a34.1;
        Tue, 01 Oct 2024 07:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727792214; x=1728397014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ph1CXMwrM0Od7OuVQ28Be8BUbBXIPRQeBdm8AFbgkow=;
        b=Uau/vZa5i4+TDBltpxwIMUhw8yE3fQxLfUhmPjNZLnQCchEPnywKdZXRlj+uQKYRGC
         WTb2aJPLq1Ky48sJfVEBuD3MmOZvAht1YdD/uQYwQUULjHkF8LSoYh42QrE5e6Zvu7Qq
         ILkfaYMfrZXILqMX0yRjpLBv7LLibOQ09/K4eM8WawkV7+aF4wEIc7grqV7h9QYz0sEl
         Vun+mPT5jW5AE9oWz7l4Ylzpo3X8jQ4F339beZuDKXPsQrjHtxqoVHY5Bf2K6WKgsWpX
         UR1SlhYLQFr/TwBhxOkZXHC6+kZbrYmjN8Zbl9e68KfMZkO6GXP6nnPLgOrSLclgyfAN
         sd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727792214; x=1728397014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ph1CXMwrM0Od7OuVQ28Be8BUbBXIPRQeBdm8AFbgkow=;
        b=TvMQjNBLAwUEU1guf973cTml38Lgz605lYMwe9WDnnmT7+uGVIQMQ2Kbnw6zqvcL0/
         MFVEr8cfN5oZUTW7BikVePrlJ/T+wxE/JrXOmzGwDcS1RJpUCFNQbdmLCphh3usKGkUh
         DlYe0Sec2B4QuNqyh7WpuUXC5r6NfHnTxa1iiy5KbvI9fDRA2SgnkHaJT1XwOsX3tS69
         MVK7mkd/TlYXfwf6YJprlMYUJaN76LhiM6A4V9nwtMdYWcLCs7AeBp9COi4VM2rRDHMt
         HTMSwqkg9RXgXpl1/+X/jWo0cGeQeZ0Ef/xr8Jg84bH6063kmPzCOcKEAGL93WBLhKA2
         118g==
X-Forwarded-Encrypted: i=1; AJvYcCViiJtgOfEpL7CJ7fgniNHWrp5yY6oO4xyxF03qF6RotWIZMZJ1IfCpwV7/2RtNvnx5HEr+cbC0LanQe/o=@vger.kernel.org, AJvYcCX3jl1EmhdRQhc7zhGnY4GPUS7y65b8tWNsiA+ab6LPfdrjblnTraRwpvlXyjrM3NctM68R6PCx@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ8kuoLFaB9Cfs2qGaOtmRE1/f6EJDGS49hcczWqLdPrc68OAU
	fBwybOjlU4aM6bZLDrHeWnWYgT1M5PLQvalhUXoGDz0n47iI2dxXkk8Q0fy5Km4Ib9XEy61LSYU
	3FBp+ZTQpWksnN9WC6DYhhMT2xi0=
X-Google-Smtp-Source: AGHT+IFfVSlGf0zJL6/ZI6y0JzFNCuskPx0Gyc8YhUaiOcui23/iIxvQOogfzVfOf5Ay4G0kU+eQQi3qHXBu2AsBY/Q=
X-Received: by 2002:a05:6359:7406:b0:1be:de52:97c3 with SMTP id
 e5c5f4694b2df-1bede52a407mr283920455d.5.1727792214436; Tue, 01 Oct 2024
 07:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926211936.75373-1-21cnbao@gmail.com> <871q13qj2t.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4w2PjN+4DKWM6qvaEUAX=FQW0rp+6Wjx1Qrq=jaAz7wsw@mail.gmail.com> <877caspv6u.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <877caspv6u.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 1 Oct 2024 22:16:40 +0800
Message-ID: <CAGsJ_4wfjo2-dnGwybx5YR_o+FEzoVG+V=O1mxQ801FdHPSGiA@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid unconditional one-tick sleep when
 swapcache_prepare fails
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Kairui Song <kasong@tencent.com>, Yu Zhao <yuzhao@google.com>, 
	David Hildenbrand <david@redhat.com>, Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Minchan Kim <minchan@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	SeongJae Park <sj@kernel.org>, Kalesh Singh <kaleshsingh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org, 
	Oven Liyang <liyangouwen1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 7:43=E2=80=AFAM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Sun, Sep 29, 2024 at 3:43=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Hi, Barry,
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > From: Barry Song <v-songbaohua@oppo.com>
> >> >
> >> > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache")
> >> > introduced an unconditional one-tick sleep when `swapcache_prepare()=
`
> >> > fails, which has led to reports of UI stuttering on latency-sensitiv=
e
> >> > Android devices. To address this, we can use a waitqueue to wake up
> >> > tasks that fail `swapcache_prepare()` sooner, instead of always
> >> > sleeping for a full tick. While tasks may occasionally be woken by a=
n
> >> > unrelated `do_swap_page()`, this method is preferable to two scenari=
os:
> >> > rapid re-entry into page faults, which can cause livelocks, and
> >> > multiple millisecond sleeps, which visibly degrade user experience.
> >>
> >> In general, I think that this works.  Why not extend the solution to
> >> cover schedule_timeout_uninterruptible() in __read_swap_cache_async()
> >> too?  We can call wake_up() when we clear SWAP_HAS_CACHE.  To avoid
> >
> > Hi Ying,
> > Thanks for your comments.
> > I feel extending the solution to __read_swap_cache_async() should be do=
ne
> > in a separate patch. On phones, I've never encountered any issues repor=
ted
> > on that path, so it might be better suited for an optimization rather t=
han a
> > hotfix?
>
> Yes.  It's fine to do that in another patch as optimization.

Ok. I'll prepare a separate patch for optimizing that path.

>
> >> overhead to call wake_up() when there's no task waiting, we can use an
> >> atomic to count waiting tasks.
> >
> > I'm not sure it's worth adding the complexity, as wake_up() on an empty
> > waitqueue should have a very low cost on its own?
>
> wake_up() needs to call spin_lock_irqsave() unconditionally on a global
> shared lock.  On systems with many CPUs (such servers), this may cause
> severe lock contention.  Even the cache ping-pong may hurt performance
> much.

I understand that cache synchronization was a significant issue before
qspinlock, but it seems to be less of a concern after its implementation.
However, using a global atomic variable would still trigger cache broadcast=
s,
correct?

>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

