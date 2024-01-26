Return-Path: <stable+bounces-15912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE68083E1DA
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 19:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3F1286FB4
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 18:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6911822314;
	Fri, 26 Jan 2024 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H50aZHU8"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DE6210E6
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294567; cv=none; b=AuZIXIHUTMcCPZqNs5LvdLAmFXkMZNgeaGHlYUKKFbbwsQwPm2EDLXRTNWB7t9VBRoisD+sCzx949fbe3z9D/t1O9vklNI8Lvga+F02m6CEDP4m3yAWByyfM/hweCrN80E/FgesOBKAlrpNCSCn/BYNWKxJi4fu6RcNULY657qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294567; c=relaxed/simple;
	bh=tndbYW1o07P9euhl5LaLRhCJkrvd7S4MGwfSeNSBl8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAB88giRZ0s/VEgKZVaXYLIdUUd3CGUeyrSJYzm3zUVhlwZUYLzSeVLIrxBJEeOkkflcVB0VRDR9Z9l//F/cYyOyMiVNULqI7LBb5I/UJmxeoHAF65OcoIotvFSQoHzPr+2jUhQti3k3xpIzN5lqKkA/IwVfv2rlkMdtxc2EXMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H50aZHU8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706294561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zzJ3L1O92NF7We+W/4dmvV12p9eM32JiTpI49AhcxhI=;
	b=H50aZHU8TYkvl5ujtSysRNTEcyxfxc4zM68qr0nnvhUkl97eZUt/8j2a7MttVhJ0ToQk2D
	l5qJBoX0DKDWXN21V9fLnwrYY0aS9K2DoqSkolYAsKJXJldAUHqJ4CE+jcENg7AodL7L7e
	ULFaOXnChIhLCXQFmRzpVNmbWb+D5Lw=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-JHKBmz54MOyZY6yBC_Emew-1; Fri, 26 Jan 2024 13:42:40 -0500
X-MC-Unique: JHKBmz54MOyZY6yBC_Emew-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7d249e66ed5so315164241.2
        for <stable@vger.kernel.org>; Fri, 26 Jan 2024 10:42:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706294559; x=1706899359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzJ3L1O92NF7We+W/4dmvV12p9eM32JiTpI49AhcxhI=;
        b=r3a8haG7XoeR+s0aENJhP1tPATqOsgxav+IDYH5W7/2nlMsNOpSuufuqbasRIMfFb/
         yCf+u5Cfb7k+DesKuvQ6UxFACBdJemp8EYahCVYV4KVK9vYIrgLaxyAXJtU3CuHKyAZI
         RqEjqfXOFgKwoKibE/74ApuO2zo7SDbdh1OVdk2QAikdsD/wbnSHYLn3bS1Hh6QEODm/
         0T3a36cqJeH+bM/5SzPDqiEAqeax2ix3/OttMoGXBVK75uvUY+9e98wEtYSeV9rSBA7F
         z98CeAlHyP+1DJKoYVYXUAGuED2D+2QPSKS40tSJby6u66s8jI4Z6YkYWjXRBQPcwmzm
         Z/mQ==
X-Gm-Message-State: AOJu0YzlKrzFyqjcaPsmDWSPhFYff2hYePbz0rneFadf1IwNyDXg2/Uu
	6UVqSsQ060U3cI2dgiWaSN9GDSTNI2BmK382F7N8lXtOqr5megKd0jm1FBiYeJDNyOkT9Yu24jv
	NdXEFknddqd0URhMeB0ErJokpi9yd/TTKOv+Le5G65IXXhWs+kpgvNEkSFMN5R9td8bQR2DXF8o
	aF+oQs6LNmxs3cvpLODT/02pv/6iJY
X-Received: by 2002:a05:6102:34ec:b0:46a:f85e:46ec with SMTP id bi12-20020a05610234ec00b0046af85e46ecmr278966vsb.13.1706294559313;
        Fri, 26 Jan 2024 10:42:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+t9Kuvuwyn4xRna1bQuJZ1JZtFzYCec090a7bJEl6paIINB1pOVLnZpfbsHSgdIHwOoYstCDRrJhhMyO1bkQ=
X-Received: by 2002:a05:6102:34ec:b0:46a:f85e:46ec with SMTP id
 bi12-20020a05610234ec00b0046af85e46ecmr278956vsb.13.1706294559084; Fri, 26
 Jan 2024 10:42:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126095514.2681649-1-oficerovas@altlinux.org>
 <20240126095514.2681649-2-oficerovas@altlinux.org> <f8efd03ca56c4a52b524beb937a25b57@AcuMS.aculab.com>
In-Reply-To: <f8efd03ca56c4a52b524beb937a25b57@AcuMS.aculab.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Jan 2024 19:42:27 +0100
Message-ID: <CABgObfYZQ3oOa8JaARpnZhb-1ruiQG1tnSLvHVXNtTZkuos-vg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: vmalloc: introduce array allocation functions
To: David Laight <David.Laight@aculab.com>
Cc: "oficerovas@altlinux.org" <oficerovas@altlinux.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	"kovalev@altlinux.org" <kovalev@altlinux.org>, "nickel@altlinux.org" <nickel@altlinux.org>, 
	"dutyrok@altlinux.org" <dutyrok@altlinux.org>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 3:00=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: oficerovas@altlinux.org
> > Sent: 26 January 2024 09:55
> >
> > commit a8749a35c399 ("mm: vmalloc: introduce array allocation functions=
")
> >
> > Linux has dozens of occurrences of vmalloc(array_size()) and
> > vzalloc(array_size()).  Allow to simplify the code by providing
> > vmalloc_array and vcalloc, as well as the underscored variants that let
> > the caller specify the GFP flags.
> >
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
> > ---
> >  include/linux/vmalloc.h |  5 +++++
> >  mm/util.c               | 50 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 55 insertions(+)
> >
> > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > index 76dad53a410ac..0fd47f2f39eb0 100644
> > --- a/include/linux/vmalloc.h
> > +++ b/include/linux/vmalloc.h
> > @@ -112,6 +112,11 @@ extern void *__vmalloc_node_range(unsigned long si=
ze, unsigned long align,
> >  void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gf=
p_mask,
> >               int node, const void *caller);
> >
> > +extern void *__vmalloc_array(size_t n, size_t size, gfp_t flags);
> > +extern void *vmalloc_array(size_t n, size_t size);
> > +extern void *__vcalloc(size_t n, size_t size, gfp_t flags);
> > +extern void *vcalloc(size_t n, size_t size);
>
> Symbols starting __ should really be ones that are part of the implementa=
tion
> and not publicly visible.

This is a patch that already exists in master.

Paolo


