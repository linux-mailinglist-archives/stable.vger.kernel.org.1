Return-Path: <stable+bounces-200106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD5BCA6062
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 04:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0BFE31A5E7A
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 03:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEE21F7580;
	Fri,  5 Dec 2025 03:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A07dJgtv"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9DB18DB1E
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 03:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764905922; cv=none; b=FrMLT2l+d42dk1m5/SXukeAQXWL7+mPl1hNM7vlkZvVF9/R1Tc7VT8UZGja0OICCPGRmXVoBP5zwL+UPuHX46Rf3MOVB/mTv2W+mBNYU1pVH0vKLLXYG05Q9WSYEWrMJj5TCaxA8Kwo3LnmY51iZDtgCqyRYS0wNafZPNgTdN5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764905922; c=relaxed/simple;
	bh=eW/YtLuM2UUzYzSHFqhs/ko8bA3Co6m2PyRiA1ibHis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQTOSz8GZSpCINP15eiPok0lxfy9X+kA6Rk1gunEzcR1beenk1CXiWkJt3uJaS2DkoQLC7hOGwfCLfTSPGsti1JDzDAtAGMMORj6T690jAnnCenmwlHRqMTGLfUwKEkrinpdZ22MLocRTPwIeiKk5XYqZYIM5S3i5MYRp0/YKa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A07dJgtv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42f762198cbso1077764f8f.3
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 19:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764905919; x=1765510719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fl+caqWL5n0dvFbZchH+YmZ4xMTXCKbX5vTDeE5p1t4=;
        b=A07dJgtvejiGazXNfGLajYep3jmpJWpcLHnU2okbhKfV5BLlPr4KMUnufunRd5sV4f
         ZU9RzNNqVGwKUxsq1TpHNoa19f6D8YP4i/OkGXh+M/GzOFCE9+TflJjIcKk6OOzRma3u
         i32Cr4+LTt+CACwKpfddZQgXyWOYP6ObyQYVQkjZha910pWH78ToiSLCPIYyf15kb0R3
         +8dEtxqkhvfb3DPcnmMCObVF94qHf+7Vs5U/riH3TTzVLUhPkzytYtPiHexzTyrXC9RC
         6aBDjkEHLFx27Oh1NUAC/eP8gQt3U5ug70ViINBtqvoLBva2Fa9qLpUYAbCV+fyJSgOu
         BJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764905919; x=1765510719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fl+caqWL5n0dvFbZchH+YmZ4xMTXCKbX5vTDeE5p1t4=;
        b=G+J2pIzAI+cgrLF2sqipJ1MX32cNE7s2iTlGJmG7rTsESCTndZWs34qX2ZP0HsHbNN
         jYAdt03QM/IqALpIdFnp82tygKe3PpDjlAmoWydb8DFkMCjgbZcHaMnV9F6Y9RC24kcs
         dIrpaaPJ7Pmut8/0dQzpfBhdnxJYPxt0cPPRJNNSNOgEo/Y5gOcNS1dRiRILgi9K/3dl
         /n1NneAGMCatSrrATkMKFD00+noW4Af/Kb3j0jNWaGiEEqskMVpvc+/DhDTPVmS/sJa3
         YxjcOglMnwMrBZpFLVBZCmTqyBB4q7heIKHgvmzr76P3oandloan2T9iOa8DAtoHOnkG
         1fNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6OzjxZ1IajyqGcw7Nb22DVOd/dnAMFiMQKON3YhImM1PJ8XatH3kjcLQ7Egjbdc7Hd4NlaFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuuAoeSufcbKLL7QXKwnY9LgUvHYcFCida6Jx1q5KzeXsCY+dV
	mQe43ZkpJeAMSPhAuuMu4bEMrXrx6Qxb8HDiWNtJA6t2PQHJoXoVrYptHvnHRsNWRgJ8o4O551V
	ye5k+b159nGS5ZAQoV7D6/1NjoD2XV7A=
X-Gm-Gg: ASbGncummZyQNsOI2bupv4rUVWwo22CG9c/6OoRehKS1VNIinBxIIOuOCwmTCcet+vQ
	NG7VtWY/ZJWq6GE+t3BrE+GhFV697b0J5PSjkKbDu48K9JboHcssbiHCMVN9SSgUb0sWws61XBd
	iVsYqgK9IzqYKUTvt3nibPA6HHKnQ0Bh1ZIrztw390M/x3gJyFZjH2uiaCIQs1JEqa09dIyssVz
	h/kN4LNxBdoZR4FVv7iUn0mC9OMAHOBEpAhCMhulKvd69Q9gp06ruNjBcIXqV6wWLQ0Qpg5beG0
	ySJXGa2z4F48ZCr1Y3b6sxkFvaZNCIJLC0LV5MA40+U=
X-Google-Smtp-Source: AGHT+IEb0cv8ajRkhP7gPEE04bA4LbLhiR6KMPX5vUsECmsEKi+k2NDEA1RGG2g6E2/gLEUu60VXhRWF46TPGjbxI7g=
X-Received: by 2002:a05:6000:18a6:b0:42b:4069:428a with SMTP id
 ffacd0b85a97d-42f79514c50mr5364434f8f.12.1764905919003; Thu, 04 Dec 2025
 19:38:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1764874575.git.m.wieczorretman@pm.me> <873821114a9f722ffb5d6702b94782e902883fdf.1764874575.git.m.wieczorretman@pm.me>
 <CA+fCnZeuGdKSEm11oGT6FS71_vGq1vjq-xY36kxVdFvwmag2ZQ@mail.gmail.com> <20251204192237.0d7a07c9961843503c08ebab@linux-foundation.org>
In-Reply-To: <20251204192237.0d7a07c9961843503c08ebab@linux-foundation.org>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 5 Dec 2025 04:38:27 +0100
X-Gm-Features: AQt7F2r4SDeGe1uHCJN0ZI3Zd_JW0xi9yGmGe6DkXMc4yWVA8HXcBjqiziEEKSE
Message-ID: <CA+fCnZfBqNKAkwKmdu7YAPWjPDWY=wRkUiWuYjEzK4_tNhSGFA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kasan: Unpoison vms[area] addresses with a common tag
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Maciej Wieczor-Retman <m.wieczorretman@pm.me>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Marco Elver <elver@google.com>, jiayuan.chen@linux.dev, 
	stable@vger.kernel.org, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 4:22=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Fri, 5 Dec 2025 02:09:06 +0100 Andrey Konovalov <andreyknvl@gmail.com>=
 wrote:
>
> > > --- a/mm/kasan/common.c
> > > +++ b/mm/kasan/common.c
> > > @@ -591,11 +591,28 @@ void __kasan_unpoison_vmap_areas(struct vm_stru=
ct **vms, int nr_vms,
> > >         unsigned long size;
> > >         void *addr;
> > >         int area;
> > > +       u8 tag;
> > > +
> > > +       /*
> > > +        * If KASAN_VMALLOC_KEEP_TAG was set at this point, all vms[]=
 pointers
> > > +        * would be unpoisoned with the KASAN_TAG_KERNEL which would =
disable
> > > +        * KASAN checks down the line.
> > > +        */
> > > +       if (flags & KASAN_VMALLOC_KEEP_TAG) {
> >
> > I think we can do a WARN_ON() here: passing KASAN_VMALLOC_KEEP_TAG to
> > this function would be a bug in KASAN annotations and thus a kernel
> > bug. Therefore, printing a WARNING seems justified.
>
> This?
>
> --- a/mm/kasan/common.c~kasan-unpoison-vms-addresses-with-a-common-tag-fi=
x
> +++ a/mm/kasan/common.c
> @@ -598,7 +598,7 @@ void __kasan_unpoison_vmap_areas(struct
>          * would be unpoisoned with the KASAN_TAG_KERNEL which would disa=
ble
>          * KASAN checks down the line.
>          */
> -       if (flags & KASAN_VMALLOC_KEEP_TAG) {
> +       if (WARN_ON_ONCE(flags & KASAN_VMALLOC_KEEP_TAG)) {
>                 pr_warn("KASAN_VMALLOC_KEEP_TAG flag shouldn't be already=
 set!\n");
>                 return;
>         }
> _
>

Can also drop pr_warn(), but this is fine too. Thanks!

