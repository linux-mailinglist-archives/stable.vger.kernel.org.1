Return-Path: <stable+bounces-27208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB26877233
	for <lists+stable@lfdr.de>; Sat,  9 Mar 2024 17:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441171C20A78
	for <lists+stable@lfdr.de>; Sat,  9 Mar 2024 16:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D52745949;
	Sat,  9 Mar 2024 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwPyDF5Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB9C44C9C
	for <stable@vger.kernel.org>; Sat,  9 Mar 2024 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710001662; cv=none; b=EtoxIk9660SswwD5tWAqr2g35nYCkoC/xocs6UztZ6hg05DSPSCFPb0OrGXWyO5f5tPxjKk1th1qXml8ctwmjjJhPwplmamvj220jpIC9tGY/YzyComZLn4QLvDTXc2ZzxVVrbXA+K1g1Sc4vhvhOLAe3uVlh5QzECEGNRdTZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710001662; c=relaxed/simple;
	bh=0gEYkOpIYZ9Ap+830hqyTJiV4I/XaxioEPsfigh8q6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnSzyKa4lLj6/RQiIjB76HNaTk96y0DgIv7KeAmJ9VWhXOyE6onQfUxGMUkJdMfw1pjFbo02hHXD+FTGTZXL2d402BIY/ikKrm7horQKsDzWjFmFMuaolBEaQhyHZNadQmhugt5JEkXpQ5FAvTi9EV2fvU+nrwn8AfuJNz2iSzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwPyDF5Z; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a450615d1c4so539210366b.0
        for <stable@vger.kernel.org>; Sat, 09 Mar 2024 08:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710001659; x=1710606459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1P1wwMFoY2RUh7Yj+jL9MiMM7Nkvq6eanhZxeCT4jZI=;
        b=iwPyDF5ZH8pi0h4cwQ7gjMar1uNkstZa8TEdNFjCYKPBdREDTj85lTbWR2TliCgzda
         OHvqkLxXO6Y8HzknYN9PV79SeF0QbvGtSuLj2wpAeeC4TvuI+LABj3ATdM46hW7qQ6A+
         9EmgGWHrEleZrdN7wO+BCf9Mo0LaPVuIMakaW3XRStIZEIdDDhZP+H9EQ5UHx/YIi6+b
         lIReiQK9YtFmR/cDQlvTigX26ZkuoBk8jRv8XjQkOdryIlA0TjoPM4opEqB3Wr6/nUlq
         5j9Mh19pF9avLh15oZLbOwtC3g49r87QcXWVNzmRbmnoZF0GfwH3ZnObSp6osSXbOefl
         IkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710001659; x=1710606459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1P1wwMFoY2RUh7Yj+jL9MiMM7Nkvq6eanhZxeCT4jZI=;
        b=IOl1DM1rWKmh7pF6XWXx50tyUVAYgAgTkgS+c/fzaEFKANzfstFn8uhhQYDidDh1m/
         CxxSXgDi9c8+x3qHO8wRq53X8UmXwjL63qpplIxb2hYfXUVc6I2gArp1+D4R+rb5P4LY
         d9KOMmzkXL6eob5ipcas0hGdfDBYTlyZcG40CRLZTjA28+gVljjFy0IGPqsTpG1u8Ewv
         6i0P8iy2ge2X8GNv0hZpq4yHx78d96TU1IwHREoruU5v5G2JBdRUpP26RwOvbU+UZK5l
         pgM+ybo+l+bdPZr2R5svvmbvmKQIyFiwBsj+YcVdIYFpYk0+h/pM5ToE7plBmFIcK8mj
         KIXw==
X-Forwarded-Encrypted: i=1; AJvYcCVWjcqmLLqtIoOl0o2bRDw+rCF0Z1ZDvmbckRE5d/ON0SE6COf5KtD8yuiScob+LDDttiHC/LEt/Pc44CTyolAWddSNI24n
X-Gm-Message-State: AOJu0YzKUSmUp85TmdhoS88S9pVOunCqey4dg6+Ar7zL3v7BfBOnNZV5
	+yEAUUWpLQfn2i8nyfF2mPGh2AXRiDYn+hTnXDOIzq31QCO7gf8rEI0VWe5wQpO10+bSwbvZUuW
	IrvK2uUqiuVcnLBrhcuwjHH9OwcFs94g5
X-Google-Smtp-Source: AGHT+IHHMNeP3+/otXi0qgvrZdjaTaAaOTiIqnN+erSanUTc3T8EWwNBtBOFWRSZpBbDRHpMPmETU7F++zaJ5QPVdQo=
X-Received: by 2002:a17:906:a14c:b0:a45:fa87:b011 with SMTP id
 bu12-20020a170906a14c00b00a45fa87b011mr1606134ejb.20.1710001659328; Sat, 09
 Mar 2024 08:27:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307190447.33423-1-joshua@froggi.es> <d9632885-35da-4e4a-b952-2b6a0c38c35b@amd.com>
In-Reply-To: <d9632885-35da-4e4a-b952-2b6a0c38c35b@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Sat, 9 Mar 2024 11:27:03 -0500
Message-ID: <CAAxE2A7SV2cwBAFKikKDjeHzWQMU+emXG7kR2okt0C9WvD6Hfw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Forward soft recovery errors to userspace
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org, 
	"Olsak, Marek" <Marek.Olsak@amd.com>, Friedrich Vock <friedrich.vock@gmx.de>, 
	Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>

Marek

On Fri, Mar 8, 2024 at 3:43=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> Am 07.03.24 um 20:04 schrieb Joshua Ashton:
> > As we discussed before[1], soft recovery should be
> > forwarded to userspace, or we can get into a really
> > bad state where apps will keep submitting hanging
> > command buffers cascading us to a hard reset.
>
> Marek you are in favor of this like forever.  So I would like to request
> you to put your Reviewed-by on it and I will just push it into our
> internal kernel branch.
>
> Regards,
> Christian.
>
> >
> > 1: https://lore.kernel.org/all/bf23d5ed-9a6b-43e7-84ee-8cbfd0d60f18@fro=
ggi.es/
> > Signed-off-by: Joshua Ashton <joshua@froggi.es>
> >
> > Cc: Friedrich Vock <friedrich.vock@gmx.de>
> > Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> > Cc: stable@vger.kernel.org
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.c
> > index 4b3000c21ef2..aebf59855e9f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -262,9 +262,8 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_=
job,
> >       struct dma_fence *fence =3D NULL;
> >       int r;
> >
> > -     /* Ignore soft recovered fences here */
> >       r =3D drm_sched_entity_error(s_entity);
> > -     if (r && r !=3D -ENODATA)
> > +     if (r)
> >               goto error;
> >
> >       if (!fence && job->gang_submit)
>

