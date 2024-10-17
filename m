Return-Path: <stable+bounces-86715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A87B9A2F17
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 22:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF3A1C21155
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 20:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FE9229103;
	Thu, 17 Oct 2024 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U61jhv/B"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EE3227374
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729198657; cv=none; b=iaNXjI8VfP2xYiXXZT3SVXLpZQ8KWdvZyDxDZxdwxkZmGF82LFDIDoBczEcSDE5DmSYZx9NHtyA35v6nhBkcLVIFnqZjlRuDm3wfljzKn3lFNH1x4Q8jgSkCPBH+Y8LWmUWDWPF54XmG7eKaKd5ieQXm3qJJmKwaUIFbshCT6mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729198657; c=relaxed/simple;
	bh=/F6YSLte3edSGWFheOgCWVPP3+prQu0BiAqqVtVwz34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WR7a5HtJUjt2p9ieRtqKZIhxO915M+VG0VwdY/8oJa+cB4X9NIqyupCdrL0/yuf6R8rym4HhEKzPIR0+wAewvmXYf2eOZblEnq1O2lae4jWM1iGY4SyWW7zSW3NxLI2kYH1HF3Y4DkH7QIKvz7V93dK/9wpZaMPV7u8UlNERbCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U61jhv/B; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2888bcc0f15so186035fac.0
        for <stable@vger.kernel.org>; Thu, 17 Oct 2024 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729198653; x=1729803453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/F6YSLte3edSGWFheOgCWVPP3+prQu0BiAqqVtVwz34=;
        b=U61jhv/BL2stVyitQBLV730XQP3c6I70twh+RVuNGBrNXweE0RHsrAb4hFMDs8zPK6
         d44C/EbNr95Y0n8C28mhVhsdBEju0+kI+VuOmHOpYh2dpYd5abdhEyjkjCvj/QZb4uvu
         3BahPcxTxsiwo8i56OTsZ8ekIoY+/wBpfErbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729198653; x=1729803453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/F6YSLte3edSGWFheOgCWVPP3+prQu0BiAqqVtVwz34=;
        b=g5AM02R/2/C6xwZndq9LZeO1JGaJ8hV8uvvGsFqvMgbxn3ixOklAS8j1o0XZhlzC1m
         eHNNWBbiByhGWLHjuPv8y7fV1cnLDXApTfG+828AT23bGQ/xe6mTPOrfAS5gFEi+yHub
         h+Q71cFuJlW91DhJ4puxpsqEJf6eNSfyL0hnSqpd+KZoJ2VscdXud1ym9Hyjp4zyQIeI
         TP3FoabuUdav15GDbzC/AzQn+2K2NW+DK1PVtB3DbryPd2K+0Eybln7GS9l/G0sK9HDk
         +XR0834LKKuB2LCM/kVLbfnTmIfcPOzka2RyDbiMC32zZSOwLv2Cg4V1ImyeA2h78DEu
         1J1w==
X-Forwarded-Encrypted: i=1; AJvYcCWSFirY+AhzIDihKZDDOY43gmCicJ4K69rT2lFXxePBaiHQCvsq8qCLh8OrBwM2Y9zwEbm5UXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzxPdhz1Daar0a3nEGDkOcXGCeOclKSrYE77Qx8A/VkIRYbM0p
	Z8V36kbVM/X8KG6EHlPBkVOWDNiRL0TenYmIAWOrsHSx72/pYcowTooZzE7xavug5soX1Fa2ZXo
	POAjFNHnYhXY2YqlDZPVFL8whRnrCPRGWhhFJ
X-Google-Smtp-Source: AGHT+IHHUuQFxa/zQxSDrqiQJJZOsss48H0nptMvzFPNY8+qKBTv0db1Iu/UCYTZHYAYX2E0/f1IhYkLDQtjkPBNtko=
X-Received: by 2002:a05:6871:3a12:b0:27b:56b1:9ded with SMTP id
 586e51a60fabf-2892c2df315mr63608fac.5.1729198653583; Thu, 17 Oct 2024
 13:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017005105.3047458-1-jeffxu@chromium.org> <20241017005105.3047458-2-jeffxu@chromium.org>
 <5svaztlptf4gs4sp6zyzycwjm2fnpd2xw3oirsls67sq7gq7wv@pwcktbixrzdo>
 <CABi2SkXwOkoFcUUx=aALWVqurKhns+JKZqm2EyRTbHtROK8SKg@mail.gmail.com> <r5ljdglhtbapgqddtr6gxz5lszvq2yek2rd6bnllxk5i6difzv@imuu3pxh5fcc>
In-Reply-To: <r5ljdglhtbapgqddtr6gxz5lszvq2yek2rd6bnllxk5i6difzv@imuu3pxh5fcc>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 17 Oct 2024 13:57:21 -0700
Message-ID: <CABi2SkXArA+yfodoOxDbTTOpWCbU5Ce1p1HadSo0=CL23K4-dQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mseal: Two fixes for madvise(MADV_DONTNEED) when sealed
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	sroettger@google.com, linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, deraadt@openbsd.org, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 1:49=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Thu, Oct 17, 2024 at 01:34:53PM -0700, Jeff Xu wrote:
> > Hi Pedro
> >
> > On Thu, Oct 17, 2024 at 12:37=E2=80=AFPM Pedro Falcato <pedro.falcato@g=
mail.com> wrote:
> > >
> > > > For PROT_NONE mappings, the previous blocking of
> > > > madvise(MADV_DONTNEED) is unnecessary. As PROT_NONE already prohibi=
ts
> > > > memory access, madvise(MADV_DONTNEED) should be allowed to proceed =
in
> > > > order to free the page.
> > >
> > > I don't get it. Is there an actual use case for this?
> > >
> > Sealing should not over-blocking API that it can allow to pass without
> > security concern, this is a case in that principle.
>
> Well, making the interface simple is also important. OpenBSD's mimmutable=
()
> doesn't do any of this and it Just Works(tm)...
>
> >
> > There is a user case for this as well: to seal NX stack on android,
> > Android uses PROT_NONE/madvise to set up a guide page to prevent stack
> > run over boundary. So we need to let madvise to pass.
>
> And you need to MADV_DONTNEED this guard page?
>
Yes.

> >
> > > > For file-backed, private, read-only memory mappings, we previously =
did
> > > > not block the madvise(MADV_DONTNEED). This was based on
> > > > the assumption that the memory's content, being file-backed, could =
be
> > > > retrieved from the file if accessed again. However, this assumption
> > > > failed to consider scenarios where a mapping is initially created a=
s
> > > > read-write, modified, and subsequently changed to read-only. The ne=
wly
> > > > introduced VM_WASWRITE flag addresses this oversight.
> > >
> > > We *do not* need this. It's sufficient to just block discard operatio=
ns on read-only
> > > private mappings.
> > I think you meant blocking madvise(MADV_DONTNEED) on all read-only
> > private file-backed mappings.
> >
> > I considered that option, but there is a use case for madvise on those
> > mappings that never get modified.
> >
> > Apps can use that to free up RAM. e.g. Considering read-only .text
> > section, which never gets modified, madvise( MADV_DONTNEED) can free
> > up RAM when memory is in-stress, memory will be reclaimed from a
> > backed-file on next read access. Therefore we can't just block all
> > read-only private file-backed mapping, only those that really need to,
> > such as mapping changed from rw=3D>r (what you described)
>
> Does anyone actually do this? If so, why? WHYYYY?
>
This is a legit use case, I can't argue that it isn't.

> The kernel's page reclaim logic should be perfectly cromulent. Please don=
't do this.
> MADV_DONTNEED will also not free any pages if those are shared (rather th=
ey'll just be unmapped).
>
> If we really need to do this, I'd maybe suggest walking through page tabl=
es, looking for
> anon ptes or swap ptes (maybe inside the actual zap code?). But I would r=
eally prefer if we
> didn't need to do this.
>
I also considered this route, but it is too complicated. The
copy-on-write pages can be put into a swap file, also there is a huge
page to consider, etc, The complication makes it really difficult to
code it right, also scanning those pages on per VMA level will require
lock and also impact performance.


> --
> Pedro

