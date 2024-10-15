Return-Path: <stable+bounces-86379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE3999F545
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 20:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0520E28483E
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 18:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776F0227BA8;
	Tue, 15 Oct 2024 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNTRTKPY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732F722911B
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016860; cv=none; b=U42gXNk5zDZWoF7gVXkAKxeFnxtz1PP0sv4ROJc/EDZrtSqRw0Wu9mxi4oINxkKb9kJYAvCKVzUHKAYGVvNQt0he+zHvhEvABGuEzPwWamGGniwJeHGy9wfLBU4k2btbxb5pk8tU5BcTPJrvsIrJsMMTn8Jd8G58hC/zn4GvyEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016860; c=relaxed/simple;
	bh=7P5eDtewB/XXvdIouhuiVrA5JcIwFJRwjUeMhlF9l9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8ACOesXR/QCUAAPXlEiAXo8lLp6rCMVmssKrofQvUpchku/NKh+Oeclv9mYmbqE4jz2yW7JmUWq8qeB3X/GwlrojDsgB6gzriBkc+DBEoKKvLwZMsd98yxXwefrayNM0mBqcYqWUkeAqPvn+1qnE8vZBx89UD5f/zhd35eZ1qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WNTRTKPY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so56953a12.0
        for <stable@vger.kernel.org>; Tue, 15 Oct 2024 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729016857; x=1729621657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0XGeskGBljrZ3o31WnXq6th/S7en+muGJ/z0yASC/c=;
        b=WNTRTKPYFIpRuwNY1DpLWfDDWo0pvvytPyV+2mJOChElnm0iXKKwaEiR5n76yR4f0J
         5mdfTlC4bsIN69mAn1kKUJp2aW7Yop+1RS3Se3dUoFGKWRiDhV+qDiQAOEEJ2IRcL2AX
         wUXCw4pJP9Ie3D6MycCe6MCPFSnJaJ6E60n4iCrtdOSFYx8pw6YPETp7Bj9KYwIdnkkE
         T19Njl3nCxKRwXdZ3xDMjE9xRrPGElzPkbZTJXMsb1+URsBvLoR8F93XiAWbMb1pHVJi
         +gorPnsEKuXGoymP3Nhxin06dThzmtNEIgSvLNRfvDdEagXVzPHJi8WRWdbXjqcoM8OR
         BjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729016857; x=1729621657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0XGeskGBljrZ3o31WnXq6th/S7en+muGJ/z0yASC/c=;
        b=VuFN6xobgdvEjSnPEukdZI68dz1QIind31CSsp5/UG/pkbErAQY6eTXeoWTBGWYYsK
         hrmtw8yRFaxsKp9GIdoAcmzpHsXzqMC4YFman1kTOZd7Pdf4cGu+jJokfHJAO+4hcu0R
         +D7vwpNgmZuU7QnMBFY4k/ai7B09L4MYi1AsyvZPrhcAKbfVOZvCSwjeL6s2D/7CrVBg
         E4dPFgSjv2WS2S5x04h8LGa/HqPnXGoJ02ltjXNUl+TXyrnFSQFSwuXGTV4NDvToKwja
         aNQbT0Vo304q/4O9i/QO3hgEO1eN5oVNGVB/1akd2PgheSoI2diRaRJWOoj9HZ1RrGGo
         x7Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWFNPj7apRsshto6dhzPNpKl3Zu3ztgwUi1vXSo55WJnVr40wTFLGcZzoz+3Ss6vzRc5i57zFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6o+vVomaj4/egT248kVnvvdri+s3cWMmLipzAXrI70YG1MY5
	pTIgnosWCj/fDPap9jUcPRe/GQh09X6nkYCpZLrPHEhoIBCN+Orzjefu7pi7uBfU5psKvBZrPAc
	RbSBxeHZ2tWKxeEpx3CNcrFWy4pDCXEzuOo5P
X-Google-Smtp-Source: AGHT+IG4vFTd1o5zCc770+Uz/qc/CsRimYoCsoJN/cKl8KhAFmwiLaJcjOltJw+t0AxqekveFNe7U+xaHEYwjMReqAE=
X-Received: by 2002:a05:6402:35c3:b0:5c5:c44d:484e with SMTP id
 4fb4d7f45d1cf-5c997ab0ca9mr35635a12.1.1729016856288; Tue, 15 Oct 2024
 11:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014-comedi-tlb-v1-1-4b699144b438@google.com> <4f531d06-9802-4086-8463-db4c9b6ba11c@mev.co.uk>
In-Reply-To: <4f531d06-9802-4086-8463-db4c9b6ba11c@mev.co.uk>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Oct 2024 20:26:58 +0200
Message-ID: <CAG48ez2_86QrYnDe5xKxbngqF7OBQ3=HDF55bDP0hKvbasNCQQ@mail.gmail.com>
Subject: Re: [PATCH] comedi: Flush partial mappings in error case
To: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 12:19=E2=80=AFPM Ian Abbott <abbotti@mev.co.uk> wro=
te:
> On 14/10/2024 21:50, Jann Horn wrote:
> > If some remap_pfn_range() calls succeeded before one failed, we still h=
ave
> > buffer pages mapped into the userspace page tables when we drop the buf=
fer
> > reference with comedi_buf_map_put(bm). The userspace mappings are only
> > cleaned up later in the mmap error path.
> >
> > Fix it by explicitly flushing all mappings in our VMA on the comedi_mma=
p()
> > error path.
> >
> > See commit 79a61cc3fc04 ("mm: avoid leaving partial pfn mappings around=
 in
> > error case").
> >
> > Cc: stable@vger.kernel.org
>
> Your patched version won't compile before 6.1 so you may want to
> indicate that in the Cc line.

Ah, thanks for pointing that out - I can just use zap_vma_ptes()
instead, which is available in older kernels, that way it will be more
concise and the backport will be easier.

> > Fixes: ed9eccbe8970 ("Staging: add comedi core")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > Note: compile-tested only; I don't actually have comedi hardware, and I
> > don't know anything about comedi.
> > ---
> >   drivers/comedi/comedi_fops.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.=
c
> > index 1b481731df96..0e573df8646f 100644
> > --- a/drivers/comedi/comedi_fops.c
> > +++ b/drivers/comedi/comedi_fops.c
> > @@ -2414,6 +2414,15 @@ static int comedi_mmap(struct file *file, struct=
 vm_area_struct *vma)
> >               vma->vm_private_data =3D bm;
> >
> >               vma->vm_ops->open(vma);
> > +     } else {
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
> > +             zap_page_range_single(vma, vma->vm_start, size, NULL);
> >       }
> >
> >   done:
> >
> > ---
> > base-commit: 6485cf5ea253d40d507cd71253c9568c5470cd27
> > change-id: 20241014-comedi-tlb-400246505961
>
> I guess this doesn't need to be done for the path that calls
> dma_mmap_coherent() since that does not do any range splitting. Would it
> be better to move it into the branch that calls remap_pfn_range() in a lo=
op?

Sure, I'll move it up into the branch.

> Note that I have no commit access to pulled-from repositories.  Greg-KH
> usually commits them on one of his repos, so could you Cc him too?  Thank=
s.

Ack, will do.

