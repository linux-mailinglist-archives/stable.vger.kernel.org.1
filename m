Return-Path: <stable+bounces-197966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A4FC989F1
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 18:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FB9A4E1840
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 17:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB41D3358DB;
	Mon,  1 Dec 2025 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Big3L5G0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1149B3321CE
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764611718; cv=none; b=Df9vU2YFQXdFlFZZpqE1giPAvk4ymwN/xCYURy5h0Hy2/cNFMxS0XeqK9ybcNROJm6tMPlJYqyvpUbXPA40h03Bh+wvxIZGLRBpBAZr2zZUuuOiqbPNsUTCv5M1cdubecEvvJY52TQVFeAEur0GTzmh4J5Hi1qqQMR82AZfusJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764611718; c=relaxed/simple;
	bh=jjgFSn9FToAfj+GLyLnNwQaq2m7MgQd5i+ucXWDZwIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6RKxSMM5J4wRQQI11BcAZswVqKbAT/mRTlkmMschTx+vA9zC3k5rDCjNPcT6HQS+kLkBbqTds5nSy+mapZXdiTYJ6QSxeK2CZBsUf7Oyiu3xPImt7dpA7DW1GnVDDO3dBiF43hXx4dOs4qa7+M0EiOKU2BZfQpn+8Peyz4pMEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Big3L5G0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7bb2fa942daso529460b3a.1
        for <stable@vger.kernel.org>; Mon, 01 Dec 2025 09:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764611715; x=1765216515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jvI+449vLivDGb9kc0M43N4Mw/9LJ82K1JvJh/IiTk=;
        b=Big3L5G0Rue9CcszT2M597ZRJAF3gAB0KXjqH81MX/rfkVE1zY67DVL/sYQCBCnVB8
         xlCvP3IMBhb65K0iiSfGWvQ7r9e7PMTFWqQZcD+2kaEHZUtzAFrl5dYmWA6XDZawsl/A
         vfm22dLhR/thXDVNQ4S6WuG18kWfWpGADo68Cf2EsjdI2yqPXuIOpSuN1tgGPK/Y3+5X
         VIWzGyQ2V22kfBQqenPiAJSiAkMZ9J+IOST85fM7eHNNj1KLu4ftO5cvRv0BcuQI1Kx2
         VsIG1ikfFF4ikiWIidYcHuBazSbECwXvj1+PWLXVibC2yweFhu2T0BKsEdRw/dn2Fu5y
         o/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764611715; x=1765216515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2jvI+449vLivDGb9kc0M43N4Mw/9LJ82K1JvJh/IiTk=;
        b=n1KC8Q1dvm27F8EDzU41tPRh2KrGFn8H2VTwQs3jGc0js5iS88QnA9BMW6uhCtAhK+
         /RP4azxyL5sN8FWURmUgQcwR/7XDB00tVhhf41I7UVeof0/0lnaFwWnigUEj/0YMKQYr
         ynAwyFJMMm+0qtf9jNVbMD7/ACgtFHO/8Za13o8yzFhemtzTQR7nitQ5ScRUBwfl50o+
         mbwZuwagF4v3Nw287o6Zpmijn63MsTlJ+TpBo7DFATyA0LMJ+hd2Z/XMjx/W4sm+8gkP
         0yMAoXpI1whzm5jH6VWlTnTzgZTKbNeyBk3JBOK6ADk4Z2zAV2qnn4TYchsRilMNI6YH
         N/AA==
X-Forwarded-Encrypted: i=1; AJvYcCWKwrnRGh1sXyweZeiyq4DwRpO8z4MoS06BwrvRZFA6fGbUB6RD0ICCpT2Ag9Y498vtSFb9oNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT1oNAaN9WvateYpiIjGh/cCkkTMgn2Re6a90texPssLzrN4oD
	V1zPpxQRrcg1umpypZEL74yx7thSVtAWzhyysvji3y+/rPpZIiWW8MLMpAnsIR3Td45CtFMJUJP
	l4OEj72xfIK//7jZi1J1Z/X5ZrIWTMkM=
X-Gm-Gg: ASbGnctmcJEGdyYwEvBPe6J1ygeVniuYFV4AGyWdd7629M9f3MWFwXCXtb4TnkVZ8iv
	zUJVVnPT192xkMgPHVMan9cNcF2j3MYJsIZuVYLJbttW7Fmny6CMi4S1L6hPYjGbTjJXWLOFUe/
	edTxB4QZ0YTf7/5CARmLKkB/C9UMWN0e54m4Hylb9Z98rdRsVWhuhNj8uQQTxnWvUDR+fx1OXau
	gQME9ly57fSiKE/ZwTh8tB4gTTqrT8Hw7LO4gbkOX5bsY3EvJvqccCde642AvsvuohwYRI=
X-Google-Smtp-Source: AGHT+IGqIo+9c99gGpNbLe6l6ruO8DNr1glo/3jbVKEzxsnzLuqlOMNs0RPfAUPD0FqpaH0RzqDY7iCXYLdGGD6nGKk=
X-Received: by 2002:a05:7022:6299:b0:11b:1c6d:98ed with SMTP id
 a92af1059eb24-11c9f31a210mr23473013c88.2.1764611715232; Mon, 01 Dec 2025
 09:55:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201140047.12403-1-natalie.vock@gmx.de> <63389a0e-d6ba-4028-9626-c606cf4b95fb@amd.com>
In-Reply-To: <63389a0e-d6ba-4028-9626-c606cf4b95fb@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Dec 2025 12:55:03 -0500
X-Gm-Features: AWmQ_bm-Ad7WHAC1sLKfoIMaf_193awrK2kjUFivVvkw4EsLTc6z_MjtYBTHnbQ
Message-ID: <CADnq5_NKLBfdpC7KnQr9Cyoyb0tsH-=gj4D6X58+vQx=HZrz_Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Forward VMID reservation errors
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Natalie Vock <natalie.vock@gmx.de>, Alex Deucher <alexander.deucher@amd.com>, 
	amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Mon, Dec 1, 2025 at 9:04=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 12/1/25 15:00, Natalie Vock wrote:
> > Otherwise userspace may be fooled into believing it has a reserved VMID
> > when in reality it doesn't, ultimately leading to GPU hangs when SPM is
> > used.
> >
> > Fixes: 80e709ee6ecc ("drm/amdgpu: add option params to enforce process =
isolation between graphics and compute")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 61820166efbf6..1479742556991 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -2921,8 +2921,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
> >       switch (args->in.op) {
> >       case AMDGPU_VM_OP_RESERVE_VMID:
> >               /* We only have requirement to reserve vmid from gfxhub *=
/
> > -             amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
> > -             break;
> > +             return amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB=
(0));
> >       case AMDGPU_VM_OP_UNRESERVE_VMID:
> >               amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
> >               break;
>

