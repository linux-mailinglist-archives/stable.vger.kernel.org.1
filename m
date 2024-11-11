Return-Path: <stable+bounces-92151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8199C426F
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 17:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2EC1F21709
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 16:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24457189BBB;
	Mon, 11 Nov 2024 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEe4Z9CL"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF54C66
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731341668; cv=none; b=IZlSdkMlCNNDi7rz51YgNaw0jU/Q0WklDm4FbgPY7Q7BmBmdz6ZW7xeHwVrJDu+e7nNPljoRJW6JONF3tU0nPrk7Wzssq8DOIrXaXS+LT88UaAt692kyUPOjFCq6FGiSSLErmjPkybF01wooZCKUjy5/AgYOaARL4LYV3aMkjZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731341668; c=relaxed/simple;
	bh=iA9MiUAz7LGQ5QcK8Ndke6XwLJ3Zy/5kUiIcsuBJ/mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqVra+0b36YJOp51IForM5rTJMJasIrxSYDyTgE/2FL5yTW8Nd7LNsxubkBy/kSGk3E7u4sy4xI4/7YJ/jHw0SkVITAz1styAqGX7LM0AjzW40CyoJ8E0a6u637oLA0cZ8GUHEluOaykclJxOrbRfo/gxWv8XgU/aU0sSrm4ASA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEe4Z9CL; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-288fa5ce8f0so2181651fac.3
        for <stable@vger.kernel.org>; Mon, 11 Nov 2024 08:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731341666; x=1731946466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvQwAnANsgT0rajCHw82xTSaXxa0bUKaVNBhRNEXLCU=;
        b=HEe4Z9CL+ZPwR1n/ZPWJoOCsNrqdBHdwQEEZXQ1SmyvBlagWMEQR7OpYQOP6ePbONv
         AieID/UjgclldlY6uAeoDo3dlkAy6urFSBmBL35fd75+3x1bHXTQ9qrlrt9GPhKrzEd1
         97j8i7gXxxjOfFzzNZMjPsKCPvSrTc/u23vJ980eB3LxEd+94LqslA/tYT8gK9Rwxea1
         PDxcLakKAoJtN2xSYowxfuwOOaZUj7WZ0JiJp/AN/FQTVqFcjN4mNYwYRNrP7QtjOv61
         2JWVnE4akrCqEk3E1jZnba/to9nYofU02ZMfYssMMwzLR/PMvp2lHeAO14Pd6s766wPx
         gaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731341666; x=1731946466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvQwAnANsgT0rajCHw82xTSaXxa0bUKaVNBhRNEXLCU=;
        b=nlRytC5pGgsy5ihpCWG5uJqwf776ZrfIiekR4mDwKnyhfXlxXPwxFD8wdAIP4mfdT1
         HlYrIQgP/mkDve1uMAN42PvNKgkJ7q1TudBhhpPPTAVMHPVTr3JRkLLl95PUlGiCU21B
         on81654Uk69GZd9I02yHoNzXxtaw4hJCBHN9YNPutM3T224NX4ZA1jt7GSUF9eMrv6L/
         TrpshYxW6Jrb/TWmdv9cVCVjustqYYoCeB9jD9tCicul2lWKEsYg/X6rK3OTsw4A6owH
         DRCHG3Ei1ptwLAARFQP26hvFeVc/k/PIQuLiQEo6rhL/dScFiKOCkqvvJU3WAwfFe+0f
         l0PA==
X-Forwarded-Encrypted: i=1; AJvYcCXOyKuE3NoaQ5AOgWhg9rUW4dAiwFo8NfzwHxp5RcqCyt3Z6sAAhFzo/76HHW05+tRDYtxKDGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE8Tulb/ltJuBYyG6Xw7PB96I9PE68MEwWTvEzGuRJVITBLC9w
	PWVliDHWp8mrQW3sLov4FTKPL35WQjFMtlWskmKVKs/tg7gvzd0TtAiSdlTdF0QvyHhXWygYeI/
	nLzg1J/y41GSK7csaeFrcyLOhXbc=
X-Google-Smtp-Source: AGHT+IEwboN3F4v7Tb9v6ZFHVXW3p55ehp66PGhfnbo0jrt7Oj7p/zFq63iGXb3GfzDVUZr4Jmwm+dsle3sfvbml7tw=
X-Received: by 2002:a05:6870:7028:b0:288:3c6c:ca with SMTP id
 586e51a60fabf-295603dcbe2mr10152037fac.41.1731341666337; Mon, 11 Nov 2024
 08:14:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108141710.9721-1-laoar.shao@gmail.com> <85cfc467-320f-4388-b027-2cbad85dfbed@redhat.com>
 <CALOAHbAe8GSf2=+sqzy32pWM2jtENmDnZcMhBEYruJVyWa_dww@mail.gmail.com>
 <fe1b512e-a9ba-454a-b4ac-d4471f1b0c6e@redhat.com> <b18d9e88-efe3-4051-b7de-6390a699fe30@redhat.com>
In-Reply-To: <b18d9e88-efe3-4051-b7de-6390a699fe30@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 12 Nov 2024 00:13:50 +0800
Message-ID: <CALOAHbB2mE_PT8hQKAusMj-N2Fi0FD7vu3Of9Xnuq1kACueGMQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/readahead: Fix large folio support in async readahead
To: David Hildenbrand <david@redhat.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 11:26=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 11.11.24 16:05, David Hildenbrand wrote:
> > On 11.11.24 15:28, Yafang Shao wrote:
> >> On Mon, Nov 11, 2024 at 6:33=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>>
> >>> On 08.11.24 15:17, Yafang Shao wrote:
> >>>> When testing large folio support with XFS on our servers, we observe=
d that
> >>>> only a few large folios are mapped when reading large files via mmap=
.
> >>>> After a thorough analysis, I identified it was caused by the
> >>>> `/sys/block/*/queue/read_ahead_kb` setting. On our test servers, thi=
s
> >>>> parameter is set to 128KB. After I tune it to 2MB, the large folio c=
an
> >>>> work as expected. However, I believe the large folio behavior should=
 not be
> >>>> dependent on the value of read_ahead_kb. It would be more robust if =
the
> >>>> kernel can automatically adopt to it.
> >>>
> >>> Now I am extremely confused.
> >>>
> >>> Documentation/ABI/stable/sysfs-block:
> >>>
> >>> "[RW] Maximum number of kilobytes to read-ahead for filesystems on th=
is
> >>> block device."
> >>>
> >>>
> >>> So, with your patch, will we also be changing the readahead size to
> >>> exceed that, or simply allocate larger folios and not exceeding the
> >>> readahead size (e.g., leaving them partially non-filled)?
> >>
> >> Exceeding the readahead size for the MADV_HUGEPAGE case is
> >> straightforward; this is what the current patch accomplishes.
> >>
> >
> > Okay, so this only applies with MADV_HUGEPAGE I assume. Likely we shoul=
d
> > also make that clearer in the subject.
> >
> > mm/readahead: allow exceeding configured read_ahead_kb with MADV_HUGEPA=
GE
> >
> >
> > If this is really a fix, especially one that deserves CC-stable, I
> > cannot tell. Willy is the obvious expert :)
> >
> >>>
> >>> If you're also changing the readahead behavior to exceed the
> >>> configuration parameter it would sound to me like "I am pushing the
> >>> brake pedal and my care brakes; fix the brakes to adopt whether to br=
ake
> >>> automatically" :)
> >>>
> >>> Likely I am missing something here, and how the read_ahead_kb paramet=
er
> >>> is used after your patch.
> >>
> >> The read_ahead_kb parameter continues to function for
> >> non-MADV_HUGEPAGE scenarios, whereas special handling is required for
> >> the MADV_HUGEPAGE case. It appears that we ought to update the
> >> Documentation/ABI/stable/sysfs-block to reflect the changes related to
> >> large folios, correct?
> >
> > Yes, how it related to MADV_HUGEPAGE. I would assume that it would get
> > ignored, but ...
> >
> > ... staring at get_next_ra_size(), it's not quite ignored, because we
> > still us it as a baseline to detect how much we want to bump up the
> > limit when the requested size is small? (*2 vs *4 etc) :/
> >
> > So the semantics are really starting to get weird, unless I am missing
> > something important.
> Likely what I am missing is that the value of get_next_ra_size() will nev=
er be relevant
> in that case. I assume the following would end up doing the same:
>
> iff --git a/mm/readahead.c b/mm/readahead.c
> index 475d2940a1edb..cc7f883f83d86 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -668,7 +668,12 @@ void page_cache_async_ra(struct readahead_control *r=
actl,
>          ra->start =3D start;
>          ra->size =3D start - index;       /* old async_size */
>          ra->size +=3D req_count;
> -       ra->size =3D get_next_ra_size(ra, max_pages);
> +       /*
> +        * Allow the actual size to exceed the readahead window for
> +        * MADV_HUGEPAGE.
> +        */
> +       if (ra->size < max_pages)
> +               ra->size =3D get_next_ra_size(ra, max_pages);

This change doesn=E2=80=99t apply to MADV_HUGEPAGE because, in cases where
`ra->size > max_pages`, ra->size has already been set to max_pages.
This can be easily verified with the example provided in the previous
version[1].

[1]. https://lore.kernel.org/linux-mm/20241106092114.8408-1-laoar.shao@gmai=
l.com/

>          ra->async_size =3D ra->size;
>   readit:
>          ractl->_index =3D ra->start;
>
>
> So maybe it should just be in get_next_ra_size() where we clarify what "m=
ax_pages"
> means and why we simply decide to ignore the value ...

--=20
Regards
Yafang

