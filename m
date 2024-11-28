Return-Path: <stable+bounces-95705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9739DB76F
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 13:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F30161164
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 12:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF3F1991DA;
	Thu, 28 Nov 2024 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRGsSDQX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D685152E0C
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796291; cv=none; b=NIX89b8Lvtxy289oeOiIxUN5hoKDGa3+WfU4YPNWFcQZhfDpeAXpy2xBc9hqXTvida6SlKvGonAmbGPuaBRLzWEY06wvGMCr5Nr4HMMtqxQNufjiYSArbDcfWNXh1vV5CvYBDPoCCZ2/vRvF/cwZf/An4+Fmms9bF29bNS3J9T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796291; c=relaxed/simple;
	bh=942roQ/1+TfMOBDOWcXjD8zVhh/75iK+muTdlxjUtbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsKxyO3uay7mMowd0ACZQSGkZ2xKZpjMIKW0FecZNI1oEF6PodnQxIYeNjnHNil3vNIKsy09JZFcb4/1Mo6/FgrJdmgj6BYkJ+49no1vVQwJgUFY9kU6KtqUsd7D+mjJnjB+WNVSa4ZFj7E1x9PU6d3MqF8++4TywBDjsOHAxR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TRGsSDQX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732796288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGyj1e0U3ksoyTpdyLxwMT3YZEpvLvZfOMIvSoDLwpI=;
	b=TRGsSDQXpUPr/NuURnFq+TVQoFIHN1Md2/tdVzeHCTOvQgSWiIJu/x8bNiJakBmBfFO2Zn
	gbBgbUSNUQvN7gzeVbAqulYX4Pj4kM2U2/wBW+lauYcZqWL8GFVRnm3aTepLOnAa5gYehK
	OcNRh9s8feeK1dlchfClO/pHpLHUS5o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-dc52OuWJPbCtUdTn_wYYtw-1; Thu, 28 Nov 2024 07:18:07 -0500
X-MC-Unique: dc52OuWJPbCtUdTn_wYYtw-1
X-Mimecast-MFC-AGG-ID: dc52OuWJPbCtUdTn_wYYtw
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5cfca7e901cso470147a12.2
        for <stable@vger.kernel.org>; Thu, 28 Nov 2024 04:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732796286; x=1733401086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGyj1e0U3ksoyTpdyLxwMT3YZEpvLvZfOMIvSoDLwpI=;
        b=L1JMCJSaB6rIJIyuUH5Y5kGNXXCHUjTk89ykyLta0GUOSUv25UK1q0uHutAPxnUsW0
         Szuqw/TilL4BLZbw1PX80msTrnVJ+ymt+Wd/ogKhW7YkLWGx8SwdKLYHk5e3J8YQILWm
         IcEZJbZxYITz0Lt7xX0UIaD4MVX36gtHEJDL2ZakGNNJ6id2h5TGDxA/FX1hgIyoCdJb
         vBxfqUu39IrIuijE+PBEc+A68pyBKaWeBuL60P4DAYV8BU3rlFTpDDTHBHNWnADJR2en
         sjfRg/ch/hySqB7oa0nn5z4eauDwDYjVY13tyLXONMFJ1lrdQwtocc+b8lR3Z99i5fov
         Hq3A==
X-Forwarded-Encrypted: i=1; AJvYcCUnoJxBzraK598tkg5pcNfANFoFPd94cJbTVfcFI3CecQLe8HJYfJ9q/W+360428AVhC5VhZYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqtqELSUo7yHgcmIKbfP9DiiHFREiONOc7iFbXFH7g0ulfZJQn
	hO/7wtqbrzqN0mnKWS86CT6fqmcz+HhXHK3hjd18FsiI2XMElyIpswqzDQM7ET9jOkK0/3IR2Le
	faT3QQUZ70EHdEwLMFYBJeOZky70jG5Y/UBc4V97yGmdkS2aGt8zqpnRcdIWw38DJyXtAMFiOjR
	g0UlUGK3g0y6EC+ZZ6RgIxBTLhMnxW
X-Gm-Gg: ASbGncudx4I9NV9a+uK3IGYp8Hxr93Cvp47IXsIgn7jheUzqzaMkRmAwftbX3lcXedG
	p7ahU/v6N8aG7a26s9o7SkWJKYys5m5Q=
X-Received: by 2002:a05:6402:368:b0:5d0:819b:3ee8 with SMTP id 4fb4d7f45d1cf-5d0819b3f6bmr5339710a12.28.1732796285800;
        Thu, 28 Nov 2024 04:18:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9T9A68feUeCUZameufi69BcHELHrmj3OzoVEiBlnXaBDzr0EfsijSDW4O9CCtKZGec59PyJncSPWuL5/Z2ME=
X-Received: by 2002:a05:6402:368:b0:5d0:819b:3ee8 with SMTP id
 4fb4d7f45d1cf-5d0819b3f6bmr5339689a12.28.1732796285506; Thu, 28 Nov 2024
 04:18:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com>
In-Reply-To: <20241127212027.2704515-1-max.kellermann@ionos.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 28 Nov 2024 14:17:54 +0200
Message-ID: <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Max Kellermann <max.kellermann@ionos.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Pages are freed in `ceph_osdc_put_request`, trying to release them
this way will end badly.

On Wed, Nov 27, 2024 at 11:20=E2=80=AFPM Max Kellermann
<max.kellermann@ionos.com> wrote:
>
> In two `break` statements, the call to ceph_release_page_vector() was
> missing, leaking the allocation from ceph_alloc_page_vector().
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/ceph/file.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 4b8d59ebda00..24d0f1cc9aac 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1134,6 +1134,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_=
t *ki_pos,
>                         extent_cnt =3D __ceph_sparse_read_ext_count(inode=
, read_len);
>                         ret =3D ceph_alloc_sparse_ext_map(op, extent_cnt)=
;
>                         if (ret) {
> +                               ceph_release_page_vector(pages, num_pages=
);
>                                 ceph_osdc_put_request(req);
>                                 break;
>                         }
> @@ -1168,6 +1169,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_=
t *ki_pos,
>                                         op->extent.sparse_ext_cnt);
>                         if (fret < 0) {
>                                 ret =3D fret;
> +                               ceph_release_page_vector(pages, num_pages=
);
>                                 ceph_osdc_put_request(req);
>                                 break;
>                         }
> --
> 2.45.2
>


