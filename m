Return-Path: <stable+bounces-86850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4960A9A4293
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 17:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784121C21DAA
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 15:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7242020127F;
	Fri, 18 Oct 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DYLvcRuY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8792010E6
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729265681; cv=none; b=u+TNj6TdiWx+xwk6NAdCWLla5IpD0K2h3egcqHu+5HKuUc9MoXxvGQeqP3G60AnyRW52AJXPJK/Wa0q9WVU+IVqRIouoNCfm6n/aWGAq5yTS7lUEGi93Y4r/73jhZACK3mCzOpALymbsai7E1oJ4rlFtSw0nRGndkb4iYn/GcQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729265681; c=relaxed/simple;
	bh=Rsl/+rmUsRZyTV/yOr7ZDuAQ4ehPeoqD5X6n1qkfCiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8dXwstin5uIHjEMr76Mp8b4u7c9Pl7AMtgkolqOh8V2iKPzdRKKk1dHOPnGv8+lt03iqWr/7qYBAplD+h6YFVw4yJlEiuwPF6D+/Bs703Pw4KYGQnGFmpFMehztwbs68BgjdMzHASyEFCQUyvhI1lNZF+m97dac6Hey1i+cmgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DYLvcRuY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20ca03687fdso225135ad.0
        for <stable@vger.kernel.org>; Fri, 18 Oct 2024 08:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729265679; x=1729870479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oD8cL6A8pVV6TNK9IRplss3H1rOZ71jX5TjVA70Dq4=;
        b=DYLvcRuY9DmH5SXFTW3yP+R1Dm08eAe7G+1MKnDZN+RKBCe8PF/fkmn1EZIsE5rnJB
         2AUKTvvVlJH5MuQBgREZz1PyLCLy7axrO+oKKGe+SeVzjZv4NXBvmR81vLjQhcQu6Z9v
         TrIQfMrYBR+rxFAuex/td/N9CBXU5rH+4qVbnoVNvTrxHWAiBBWyvVzmP73/Jrel4Shj
         aMUK4WkKkRv09f+2y/Qx/RxhMIUWSCWI3+vXHHpriI3/whkMX4+5eHLjLqofxK22Dx3Y
         zT7aWghYQRuSVCcZewOyvQSITYGOOSLCPxcjK8qHtJf0xPy+NVyj6/XhzRnRbHFJtMiG
         V+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729265679; x=1729870479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oD8cL6A8pVV6TNK9IRplss3H1rOZ71jX5TjVA70Dq4=;
        b=hbHSkZbYGqRkpGXNvllF0g7kL8Db7gN3wYNpdwQjTtkXz4rMm6z0ZluTPgtWSqTCxX
         ak7xYcGnipGfFdm0BrfEFb9tHyd1bvf5xMCyYbm7y2rSjnNPvfUBhcg4nHtN+TZ4LhjT
         Kvz9o+StvTzUD/4ca+Z+k3X3e2+i6rA8rJ1BnTCV4hHR2cKzpEwvJcufovOvnbWeZIfr
         aZJGQu2vpyAycHJuraWE+D2B1ESPUSsxqUj64ZHlUFuhc99kt8T69Mmv9QSWocsh959H
         yjbjmM9KueWGRaPn19xJJHjPMyK807uu4DoVXVec2oXcM7qHfwoddjoSgVyhNgr0krwn
         pxKg==
X-Forwarded-Encrypted: i=1; AJvYcCWl4rXrlCGlMnoUsYzS9Nsso7DO7tj3kpDvt4k5zMhydUfgl15DpTauDz6f/AlVMzL2iz4TXYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAz4Y/gCqBXXl1yK1vv129tn7hn4Rb1buHRbdMfQBPDN8ix/gA
	E5eto9R8j2+H1kLuf05L0hfFpYqNHKLaqJh8A728Qv3RqiuMyAtsvISBH68bQb71BwIA6MLXRXY
	bBJwIKvRj/lxeh5E4OWHj7JdKo4HpoL8dtVJ4
X-Google-Smtp-Source: AGHT+IHhKTMzeQ7vmaIpKtKNALFiWaxQPnshDSWhztzeoa847jArAub8S17GiDD/T3U8yxCmCwRFUEnyCdj+G6KNKik=
X-Received: by 2002:a17:903:2447:b0:20c:a659:deba with SMTP id
 d9443c01a7336-20e579af530mr3267745ad.4.1729265677858; Fri, 18 Oct 2024
 08:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017-comedi-tlb-v3-1-16b82f9372ce@google.com> <10f30e5b-dbf0-4f7d-9688-5ae256e2c252@mev.co.uk>
In-Reply-To: <10f30e5b-dbf0-4f7d-9688-5ae256e2c252@mev.co.uk>
From: Jann Horn <jannh@google.com>
Date: Fri, 18 Oct 2024 17:33:57 +0200
Message-ID: <CAG48ez3oaXHQ=7Ys+-RkAaUTsPofKr13RbGrAkxOLGqQrrDf4w@mail.gmail.com>
Subject: Re: [PATCH v3] comedi: Flush partial mappings in error case
To: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, Frank Mori Hess <fmh6jj@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 1:35=E2=80=AFPM Ian Abbott <abbotti@mev.co.uk> wrot=
e:
> On 17/10/2024 20:07, Jann Horn wrote:
> > If some remap_pfn_range() calls succeeded before one failed, we still h=
ave
> > buffer pages mapped into the userspace page tables when we drop the buf=
fer
> > reference with comedi_buf_map_put(bm). The userspace mappings are only
> > cleaned up later in the mmap error path.
> >
> > Fix it by explicitly flushing all mappings in our VMA on the error path=
.
> >
> > See commit 79a61cc3fc04 ("mm: avoid leaving partial pfn mappings around=
 in
> > error case").
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ed9eccbe8970 ("Staging: add comedi core")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > Note: compile-tested only; I don't actually have comedi hardware, and I
> > don't know anything about comedi.
> > ---
> > Changes in v3:
> > - gate zapping ptes on CONFIG_MMU (Intel kernel test robot)
> > - Link to v2: https://lore.kernel.org/r/20241015-comedi-tlb-v2-1-cafb0e=
27dd9a@google.com
> >
> > Changes in v2:
> > - only do the zapping in the pfnmap path (Ian Abbott)
> > - use zap_vma_ptes() instead of zap_page_range_single() (Ian Abbott)
> > - Link to v1: https://lore.kernel.org/r/20241014-comedi-tlb-v1-1-4b6991=
44b438@google.com
> > ---
> >   drivers/comedi/comedi_fops.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.=
c
> > index 1b481731df96..b9df9b19d4bd 100644
> > --- a/drivers/comedi/comedi_fops.c
> > +++ b/drivers/comedi/comedi_fops.c
> > @@ -2407,6 +2407,18 @@ static int comedi_mmap(struct file *file, struct=
 vm_area_struct *vma)
> >
> >                       start +=3D PAGE_SIZE;
> >               }
> > +
> > +#ifdef CONFIG_MMU
> > +             /*
> > +              * Leaving behind a partial mapping of a buffer we're abo=
ut to
> > +              * drop is unsafe, see remap_pfn_range_notrack().
> > +              * We need to zap the range here ourselves instead of rel=
ying
> > +              * on the automatic zapping in remap_pfn_range() because =
we call
> > +              * remap_pfn_range() in a loop.
> > +              */
> > +             if (retval)
>
> Perhaps that condition should be changed to `retval && i` since there
> will be no partial mappings left behind if the first call to
> `remap_pfn_range` failed.

I'll add that if you really want, but I think it just makes the code
harder to follow if you have to think about how the code paths differ
between "we have done at least one successful iteration and failed
later" vs "the first iteration failed"...

