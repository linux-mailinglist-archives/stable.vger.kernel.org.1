Return-Path: <stable+bounces-192590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E70C3A014
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 11:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1856E1886F32
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 10:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6E42D8379;
	Thu,  6 Nov 2025 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlxyrlLe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSdWMr8A"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E15272E41
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423318; cv=none; b=SLsC5g92t7WC7Xo5W/mfcg14GBYkk0uMtJcv0WSL1J87FCNxgIwGz7mcjA8sKHjZ3IjGMMRc8xqxcwldL/802kh9EnMBAt2VqK9GjKxAXUbM3jV7Nx5unNHzWPC6CpuJEIHUewt/2PUnlsyVsoeFCsRjqijtwpAuC2FtolgfJbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423318; c=relaxed/simple;
	bh=8IDSztejrxf1pgSwvL7JvMJvidKceNfTqZOuRERcjzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVl3js9ltRLEmwJqQufpJCbX9cjGVp+76vEEIsUNVmiLqCfW9GrWg2Fa9CRMXaHT1caNCMav4w4ju2XOGUyWkImg+V0pg12uElORlzyzsOJ5f5C5ND4j7TJOMJHrz0w16jV2FZBy/B6QgH0m4vl41zKtNdUKoFZdNSr9hXIksHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XlxyrlLe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RSdWMr8A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762423315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hr+IrPZu54jtoYs0y4pJPw8+metTYxP5F0Z/JHnlZZI=;
	b=XlxyrlLeGbKxLSNsaCRYfOqC0rpmOMmXtwNgeNb+a0HCqhGPlsaie/MKU5PxjmLxYaPPIr
	1vsmFYARLp6jABC061BfLfimuv92QlAE+tXw3d9pYovNr27RabHs5K9mR+oPaRM99Zj5rP
	ZC6TJT4jeI1KwTPwZTH0jFiJNg7gwVw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-PuoUfR2CN5GqeEbwXNbRdQ-1; Thu, 06 Nov 2025 05:01:54 -0500
X-MC-Unique: PuoUfR2CN5GqeEbwXNbRdQ-1
X-Mimecast-MFC-AGG-ID: PuoUfR2CN5GqeEbwXNbRdQ_1762423313
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-295592eb5dbso11435635ad.0
        for <stable@vger.kernel.org>; Thu, 06 Nov 2025 02:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762423313; x=1763028113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr+IrPZu54jtoYs0y4pJPw8+metTYxP5F0Z/JHnlZZI=;
        b=RSdWMr8AF/eyo7J+DiEeZHnRi1bxSGERVeQpzUaJiSc2uaQZX2kueHoveLE6xaUo6Y
         1guGw8cLirJ8FjuNgjaXeqH2/fi2MLXsNz1jeseBTeJue4AirXQs9W+up1EuCAj9LMpX
         QcfzO9v10UF+zMIu2Y74Wvs1kgBC5gJJt6T2zOvsYs9r5I9OurdTJNIx+mL9g5sgsf1T
         oAvFTzWVnoK3nCDDMpH138nVJKEluuUKwNbwtFhj59eKEhimftyuJdLxsl5cPdGgD6tP
         YRaB1k8Fd9+uCjnA6a4f3fqvtEicxdn4Fkggmkdw0UNRHuNkGVCN3d+MLI5MtY+dAHGZ
         OAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762423313; x=1763028113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hr+IrPZu54jtoYs0y4pJPw8+metTYxP5F0Z/JHnlZZI=;
        b=YC/1z44GCFCniwX5o4i02gRDM+lmdXtrnNMVzIrvkDvIs1ATzTFVb5JMXLglPgjxqo
         jvNNj/w7Rom52WES1DQXM8kO5xFX4CmIe3T2MrLdb/ui4213l7Ex6dRHm+FvtqUNjQGH
         lHYVZLWp2jGGy3uwjUQCqMtdAL0Kg3QVvWxvM2wBG73zwA81YaxEh35uLfvj0j33W3jf
         gmx47rymxaDje6V3G+Y0WYd+LtAoOJWMtON+feynHLkiW7v3Y4Fc1Jy56AtNd68ZPyF8
         uD/M8+WTcU9qSGcnlYdG4CMevpl5p0dGDUszsEcF/F5He+c5t9IryMv7kSq0Jl1qir6a
         sVxw==
X-Forwarded-Encrypted: i=1; AJvYcCU1ujokCkZ3gGdLJ1p6kPEb0ZIa8IdrbLLXD9rAxlyuew+hjTQUQtgfkZfCtMm6UY4tAWZ/aFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5z8tRUGmSWLlovnP+er8myYmGb1dhFDHVj+5qIzZUceR4b56T
	1xxPXqLmjo26KJm4XvngZkTOMwGRIC0iv9gkoUfC+osTdWP9rqRfYdS5T9eLliGLvmM7QKbyJeS
	Cp97v66+95MgsbLxPx4vdCL1S8Ux05Kf7WOLy0mEWrgspQ1YryEb8CHbRGiKOkAK/Gh81+oxF8x
	T62ZmjxdvTxodADqP2QIZWi6Y/dXC/3dLW
X-Gm-Gg: ASbGncu+ijAl2bq5ar82J3ZAeiFh6SXYhhpK2xeRWp6W5874S/j4oKUG76h4OQeB9Tq
	VlGZ2h4uO9KWSeXwoKKphOMFiQgsyXlYptx83sm7xRB6KK3QySjB401SYGnsBBOvDX99Kie/wm/
	DQdz39AJQsW4xLb6ugibrXwPssU6UTn8agQHWyzjuUvoVOJbDTynUTbcIe
X-Received: by 2002:a17:902:d48c:b0:294:ccc6:ccfd with SMTP id d9443c01a7336-2962ad1bdffmr91649405ad.24.1762423313121;
        Thu, 06 Nov 2025 02:01:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGW3KVhLVq482NdCe7C1dgbyTYFG/2bSxtBHpewavKdNS1gj51nLasKmnsU0eaoXCfCFgVktlKV3Z5WRrEjvJ4=
X-Received: by 2002:a17:902:d48c:b0:294:ccc6:ccfd with SMTP id
 d9443c01a7336-2962ad1bdffmr91649025ad.24.1762423312666; Thu, 06 Nov 2025
 02:01:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106065904.10772-1-piliu@redhat.com> <20251106065904.10772-2-piliu@redhat.com>
 <aQxV2ULFzG/xrl7/@MiWiFi-R3L-srv>
In-Reply-To: <aQxV2ULFzG/xrl7/@MiWiFi-R3L-srv>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 6 Nov 2025 18:01:41 +0800
X-Gm-Features: AWmQ_bkaQwEAwJSjgkaHYwD9xdB2_CzxgOPAM8h5-6gfOG4JNmJZCcRMLtwCKcw
Message-ID: <CAF+s44TyM7sBVmGn7kn5Cw+Ygm02F93hchiSBN0Q_qR=oA+DLg@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] kernel/kexec: Fix IMA when allocation happens in
 CMA area
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, 
	Steven Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 4:01=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> On 11/06/25 at 02:59pm, Pingfan Liu wrote:
> > When I tested kexec with the latest kernel, I ran into the following wa=
rning:
> >
> > [   40.712410] ------------[ cut here ]------------
> > [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 ki=
mage_map_segment+0x144/0x198
> > [...]
> > [   40.816047] Call trace:
> > [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> > [   40.823221]  ima_kexec_post_load+0x58/0xc0
> > [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> > [...]
> > [   40.855423] ---[ end trace 0000000000000000 ]---
> >
> > This is caused by the fact that kexec allocates the destination directl=
y
> > in the CMA area. In that case, the CMA kernel address should be exporte=
d
> > directly to the IMA component, instead of using the vmalloc'd address.
>
> Well, you didn't update the log accordingly.
>

I am not sure what you mean. Do you mean the earlier content which I
replied to you?

> Do you know why cma area can't be mapped into vmalloc?
>
Should not the kernel direct mapping be used?

Thanks,

Pingfan
> >
> > Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Alexander Graf <graf@amazon.com>
> > Cc: Steven Chen <chenste@linux.microsoft.com>
> > Cc: linux-integrity@vger.kernel.org
> > Cc: <stable@vger.kernel.org>
> > To: kexec@lists.infradead.org
> > ---
> > v1 -> v2:
> > return page_address(page) instead of *page
> >
> >  kernel/kexec_core.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index 9a1966207041..332204204e53 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -967,6 +967,7 @@ void *kimage_map_segment(struct kimage *image, int =
idx)
> >       kimage_entry_t *ptr, entry;
> >       struct page **src_pages;
> >       unsigned int npages;
> > +     struct page *cma;
> >       void *vaddr =3D NULL;
> >       int i;
> >
> > @@ -974,6 +975,9 @@ void *kimage_map_segment(struct kimage *image, int =
idx)
> >       size =3D image->segment[idx].memsz;
> >       eaddr =3D addr + size;
> >
> > +     cma =3D image->segment_cma[idx];
> > +     if (cma)
> > +             return page_address(cma);
> >       /*
> >        * Collect the source pages and map them in a contiguous VA range=
.
> >        */
> > @@ -1014,7 +1018,8 @@ void *kimage_map_segment(struct kimage *image, in=
t idx)
> >
> >  void kimage_unmap_segment(void *segment_buffer)
> >  {
> > -     vunmap(segment_buffer);
> > +     if (is_vmalloc_addr(segment_buffer))
> > +             vunmap(segment_buffer);
> >  }
> >
> >  struct kexec_load_limit {
> > --
> > 2.49.0
> >
>


