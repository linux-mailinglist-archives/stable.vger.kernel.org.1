Return-Path: <stable+bounces-15890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A383983DB67
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 15:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59EE81F21FEF
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E818D1B955;
	Fri, 26 Jan 2024 14:00:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01051B963
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706277634; cv=none; b=Fvk/EJtoAlNGvQ1M64mkj9z13OlEnP+1oeGz3MKuJ4UqGug7u0vZxSjRkT61UeG6lesgE4rjuUT1Yu6RYSpjvDI/TMk9ijsrsi8YwXv7hJzfFMDwWMKAyUGyplR5OPSELBmHqpJkoyQwhqGnkC/JTYNC16XfNbL+a7vrsMmpJIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706277634; c=relaxed/simple;
	bh=9u+pr9ZkYdKjhQhFBuvQDgrHuL5VqpkygdC7LlWT7vI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=D719kqg1zpPXpAHKIPrexbDVu9RAwggYvTvLiYwJeH9wEQJ43SiQw/LHvFTMLQJE13u2wvKP0LIKdnVXSMwHvogVo4CJf1fTG+SJYtoRQPH6kkzxLG+lHqy5n0C4QznW/I9IXBd/Tpwfac7RPb9qV+jd49ZD54BkDFrqIo/VPOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-232-f8pCHKAKOQuBwAtaraPvbA-1; Fri, 26 Jan 2024 14:00:19 +0000
X-MC-Unique: f8pCHKAKOQuBwAtaraPvbA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 26 Jan
 2024 13:59:59 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 26 Jan 2024 13:59:59 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "'oficerovas@altlinux.org'" <oficerovas@altlinux.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>, "kovalev@altlinux.org"
	<kovalev@altlinux.org>, "nickel@altlinux.org" <nickel@altlinux.org>,
	"dutyrok@altlinux.org" <dutyrok@altlinux.org>, Michal Hocko <mhocko@suse.com>
Subject: RE: [PATCH 1/2] mm: vmalloc: introduce array allocation functions
Thread-Topic: [PATCH 1/2] mm: vmalloc: introduce array allocation functions
Thread-Index: AQHaUEF65tKAuHOCpUGZS2C33PHY77DsHuIw
Date: Fri, 26 Jan 2024 13:59:59 +0000
Message-ID: <f8efd03ca56c4a52b524beb937a25b57@AcuMS.aculab.com>
References: <20240126095514.2681649-1-oficerovas@altlinux.org>
 <20240126095514.2681649-2-oficerovas@altlinux.org>
In-Reply-To: <20240126095514.2681649-2-oficerovas@altlinux.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: oficerovas@altlinux.org
> Sent: 26 January 2024 09:55
>=20
> commit a8749a35c399 ("mm: vmalloc: introduce array allocation functions")
>=20
> Linux has dozens of occurrences of vmalloc(array_size()) and
> vzalloc(array_size()).  Allow to simplify the code by providing
> vmalloc_array and vcalloc, as well as the underscored variants that let
> the caller specify the GFP flags.
>=20
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
> ---
>  include/linux/vmalloc.h |  5 +++++
>  mm/util.c               | 50 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>=20
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 76dad53a410ac..0fd47f2f39eb0 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -112,6 +112,11 @@ extern void *__vmalloc_node_range(unsigned long size=
, unsigned long align,
>  void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_=
mask,
>  =09=09int node, const void *caller);
>=20
> +extern void *__vmalloc_array(size_t n, size_t size, gfp_t flags);
> +extern void *vmalloc_array(size_t n, size_t size);
> +extern void *__vcalloc(size_t n, size_t size, gfp_t flags);
> +extern void *vcalloc(size_t n, size_t size);

Symbols starting __ should really be ones that are part of the implementati=
on
and not publicly visible.

...
> +/**
> + * __vmalloc_array - allocate memory for a virtually contiguous array.
> + * @n: number of elements.
> + * @size: element size.
> + * @flags: the type of memory to allocate (see kmalloc).
> + */
> +void *__vmalloc_array(size_t n, size_t size, gfp_t flags)
> +{
> +=09size_t bytes;
> +
> +=09if (unlikely(check_mul_overflow(n, size, &bytes)))
> +=09=09return NULL;
> +=09return __vmalloc(bytes, flags);
> +}
> +EXPORT_SYMBOL(__vmalloc_array);
> +
> +/**
> + * vmalloc_array - allocate memory for a virtually contiguous array.
> + * @n: number of elements.
> + * @size: element size.
> + */
> +void *vmalloc_array(size_t n, size_t size)
> +{
> +=09return __vmalloc_array(n, size, GFP_KERNEL);
> +}
> +EXPORT_SYMBOL(vmalloc_array);

and that should just be an inline wrapper on the function above.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


