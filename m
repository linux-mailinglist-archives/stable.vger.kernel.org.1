Return-Path: <stable+bounces-196850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DA3C83502
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 05:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C60F4E1ACB
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 04:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07C027FD59;
	Tue, 25 Nov 2025 04:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CImSIAG6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tPSeuw0C"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D659223DD6
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 04:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764043836; cv=none; b=pWIbr1NkLiuM/pwMsJeV5OooRO0WlvN98TMaNIa0XtHznCVR9o3K1lnGpwh8QTBDoZ1rLU/pQa5kCja9kq7ziBN7OwfMJdyAsVE33qOHNeDuIy2QMfRbMGiQwqDTL1nBOXnEAr7yvz373gZGta/Gsvpm7Zq4g/u2kPaeFnO0aGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764043836; c=relaxed/simple;
	bh=9YYWZrw2E0QMAD9tvplw/ACL4yWRSThe2gJsD4evs+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N43ji+8iPW0s0GUADc93saP2KosgMh+73gzV0Y+VdSIrZcMPn+pnAj0HK3aKPMHbFc0rbVzJuBlH3i9tp2mdP5dkrlzga4AxTEs612osXsZnMNi2rIvYBcGF4Gt27AzCgUnb4xPlJduCJ6X8F/5pJsWCXnC0Us6aMZfiibuhU7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CImSIAG6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tPSeuw0C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764043833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yK36ADvRnvn7Z88J1V2Eb5Oki0HN2SsGScGiByHtlSA=;
	b=CImSIAG6dH66UfLTAIleoqHCQMPMIxLdWumzYoPiau+BvKyknWWgg6FR0a1/+k8zZ4FxEB
	vZCLvyCO8TBnbhcVbQfAR7Km/jVr/MPQ15C+YiIBmE0auAkWmzlXhPh8IoMFTWhblCA9wr
	ujH6lP47o5+3n5QnyiUILXqtM965XW4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-7S4Yhy-FPxyggSwn3PXRwA-1; Mon, 24 Nov 2025 23:10:31 -0500
X-MC-Unique: 7S4Yhy-FPxyggSwn3PXRwA-1
X-Mimecast-MFC-AGG-ID: 7S4Yhy-FPxyggSwn3PXRwA_1764043830
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b993eb2701bso4811899a12.0
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 20:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764043830; x=1764648630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yK36ADvRnvn7Z88J1V2Eb5Oki0HN2SsGScGiByHtlSA=;
        b=tPSeuw0CgQtXtQCIdVJbP7XS+/Kmo+317jQpBT2QdiGZFRKyL69lRfVEXFlzgIIqji
         ZsclyKzcdBPOKoQ5VNa73uC/+QoIouq+pmYyKZia/BAruPjG+HYilYoloL0Ir6iL4peL
         S6jUEuSUzDfBWxMLlWhsE9XPaQ1X0rw0JhNAIlYQ0fjsgfmlD1q4DlWW4jwk+cF1dGLK
         NmiJwHyxYO1OVoOB1pJNwTpnbUc6X5vnWcvJEEEc6flflCg1smWFtVgnfC7DSHA5yHjy
         gwr8ToDR//7hX6WZBvfkEbSKmT41edK6WLAw3ZVfJAjDi05lZPO2EMAnKVSbMlYLcYxh
         gIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764043830; x=1764648630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yK36ADvRnvn7Z88J1V2Eb5Oki0HN2SsGScGiByHtlSA=;
        b=jBmTxLiHtDpMvzhxX30i/IQKiJIbqlaJzuPfNa8opnmtV0gcPvbApX2q6Ur6Bgnv6I
         gMoQmMwpZlL8ieh0TrdLLyHrkyBNfNC8pxrpWKqv43ZGRZU9fAZt50Fb1w4kupquLh9w
         rmYRWzMjoi31eincyjwyCXg/XOK6GgNroYyKGoBe1f94Y2wL9b/vXCttgkIOmBN14Rat
         YRyfaMkb7rqoE3b2DX/qJPYsJ6Szm+kN+qS7EuX1qJzwsSSmxJeWCTutkc7vGn5GhZ9W
         swwyDqshcFvCBRiEtgTbMMdjhZE9vBYbcyomymWnVGjkHWcYYC6OiNKpfumdIrcbvFz9
         fX3g==
X-Forwarded-Encrypted: i=1; AJvYcCXTB56x09K6t/Z+qPV5TkNPP7RSTUaMm4yNEZIe9hfmHtkbXjkZ+3NlW7JEJDMdyuulNiueJIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuLpvsZWD5pV0oSi484QHSd+/4ustNQOiOGpegPCSSs22Lr2SC
	7NYz7XL0bJiNEiofLwcpGbGaEnUC00xSbo/QNe89Ph4y38ofTDvCZsMK6SOSUcZHZJq8MDAlPhC
	+y5NDMTrnMLOe4fLBEsYN0/qI9tdCzXT/IKnmM1SC5/zZ9ZfVw6+Csys0fAkCvVunwgfWDShVAg
	PWLAdlhtsIyyafS5uhl2QzKO467EFdxfKe
X-Gm-Gg: ASbGncsB71emHZzgFsHa8NXt0n2GBLL2PZW5+JUWrgj9pCGTFxy7lpB6NVvavCkE3Xf
	Kcmq+KjeI57idRsGwJ6KoQ1nbKc1XJ1AxQlu0MLT1LkuNfjZOWNmsvD3cr8CV6W0EACcE0J90ue
	Ha2eLgQBruVEoYV9s7hacmcmBSmu3hTU2uOefLMy2JTBy3X2buXABMKOMRig2dXXOVufU=
X-Received: by 2002:a05:7300:3c9d:b0:2a4:3592:c604 with SMTP id 5a478bee46e88-2a94174e0a3mr968010eec.21.1764043830396;
        Mon, 24 Nov 2025 20:10:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgUoue+m7hDF3DbmgObHkl//DmmrJWlhnJcpAhd/7zU+XNPQQveIwUfL2CdEABUBwK3fALWag5I+mmEpqWE4g=
X-Received: by 2002:a05:7300:3c9d:b0:2a4:3592:c604 with SMTP id
 5a478bee46e88-2a94174e0a3mr967995eec.21.1764043829940; Mon, 24 Nov 2025
 20:10:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106065904.10772-1-piliu@redhat.com> <20251124141620.eaef984836fe2edc7acf9179@linux-foundation.org>
In-Reply-To: <20251124141620.eaef984836fe2edc7acf9179@linux-foundation.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 25 Nov 2025 12:10:18 +0800
X-Gm-Features: AWmQ_bls9hRXbIMq8va3xXzXthhHZlNlk1j_k-sv8prZCGat9H5AAgW6u60PH-U
Message-ID: <CAF+s44SPQe9XCopTJcCN-FOfdupc9ZYrj3C+Q3CKfRKFFUYgNg@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] kernel/kexec: Change the prototype of kimage_map_segment()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, 
	Baoquan He <bhe@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, 
	Steven Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 6:16=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu,  6 Nov 2025 14:59:03 +0800 Pingfan Liu <piliu@redhat.com> wrote:
>
> > The kexec segment index will be required to extract the corresponding
> > information for that segment in kimage_map_segment(). Additionally,
> > kexec_segment already holds the kexec relocation destination address an=
d
> > size. Therefore, the prototype of kimage_map_segment() can be changed.
>
> Could we please have some reviewer input on thee two patches?
>
> Thanks.
>
> (Pingfan, please cc linux-kernel on patches - it's where people go to
> find emails on lists which they aren't suscribed to)
>
OK, I will cc linux-kernel for the future kexec patches

For this series, it can also be found on
https://lore.kernel.org/linux-integrity/20251106065904.10772-1-piliu@redhat=
.com/

Thanks,

Pingfan

> (akpm goes off and subscribes to kexec@)
>
> > Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> > Cc: Alexander Graf <graf@amazon.com>
> > Cc: Steven Chen <chenste@linux.microsoft.com>
> > Cc: <stable@vger.kernel.org>
> > To: kexec@lists.infradead.org
> > To: linux-integrity@vger.kernel.org
> > ---
> >  include/linux/kexec.h              | 4 ++--
> >  kernel/kexec_core.c                | 9 ++++++---
> >  security/integrity/ima/ima_kexec.c | 4 +---
> >  3 files changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index ff7e231b0485..8a22bc9b8c6c 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -530,7 +530,7 @@ extern bool kexec_file_dbg_print;
> >  #define kexec_dprintk(fmt, arg...) \
> >          do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0=
)
> >
> > -extern void *kimage_map_segment(struct kimage *image, unsigned long ad=
dr, unsigned long size);
> > +extern void *kimage_map_segment(struct kimage *image, int idx);
> >  extern void kimage_unmap_segment(void *buffer);
> >  #else /* !CONFIG_KEXEC_CORE */
> >  struct pt_regs;
> > @@ -540,7 +540,7 @@ static inline void __crash_kexec(struct pt_regs *re=
gs) { }
> >  static inline void crash_kexec(struct pt_regs *regs) { }
> >  static inline int kexec_should_crash(struct task_struct *p) { return 0=
; }
> >  static inline int kexec_crash_loaded(void) { return 0; }
> > -static inline void *kimage_map_segment(struct kimage *image, unsigned =
long addr, unsigned long size)
> > +static inline void *kimage_map_segment(struct kimage *image, int idx)
> >  { return NULL; }
> >  static inline void kimage_unmap_segment(void *buffer) { }
> >  #define kexec_in_progress false
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index fa00b239c5d9..9a1966207041 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -960,17 +960,20 @@ int kimage_load_segment(struct kimage *image, int=
 idx)
> >       return result;
> >  }
> >
> > -void *kimage_map_segment(struct kimage *image,
> > -                      unsigned long addr, unsigned long size)
> > +void *kimage_map_segment(struct kimage *image, int idx)
> >  {
> > +     unsigned long addr, size, eaddr;
> >       unsigned long src_page_addr, dest_page_addr =3D 0;
> > -     unsigned long eaddr =3D addr + size;
> >       kimage_entry_t *ptr, entry;
> >       struct page **src_pages;
> >       unsigned int npages;
> >       void *vaddr =3D NULL;
> >       int i;
> >
> > +     addr =3D image->segment[idx].mem;
> > +     size =3D image->segment[idx].memsz;
> > +     eaddr =3D addr + size;
> > +
> >       /*
> >        * Collect the source pages and map them in a contiguous VA range=
.
> >        */
> > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/im=
a/ima_kexec.c
> > index 7362f68f2d8b..5beb69edd12f 100644
> > --- a/security/integrity/ima/ima_kexec.c
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -250,9 +250,7 @@ void ima_kexec_post_load(struct kimage *image)
> >       if (!image->ima_buffer_addr)
> >               return;
> >
> > -     ima_kexec_buffer =3D kimage_map_segment(image,
> > -                                           image->ima_buffer_addr,
> > -                                           image->ima_buffer_size);
> > +     ima_kexec_buffer =3D kimage_map_segment(image, image->ima_segment=
_index);
> >       if (!ima_kexec_buffer) {
> >               pr_err("Could not map measurements buffer.\n");
> >               return;
> > --
> > 2.49.0
>


