Return-Path: <stable+bounces-118294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F7BA3C305
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 16:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58EFF175714
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659281F3BBB;
	Wed, 19 Feb 2025 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebUuG9Hx"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590501F3BB4
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977449; cv=none; b=ASH9cMeivUdzES2AmLG3L+DUjkPIt0vxEajHrEQTaxzOcWJwX4k9iYGwwF2utl7OxfGjB/igxP0qRwyxCTZQXf+mc21CqnFB/TvRS9FVxKZE0CoBOqPIaraPuAiRFtwxlwIaT2V23CEyVl6AMn2n/+qq08Bi7GCa/XjTSInDg5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977449; c=relaxed/simple;
	bh=Rzeh4ZO20HAiLLGtVAkBFj2NDUf7ZgkWV4g343YrPO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNujb8/OLC29jQbPNcTnuh8N/YRoqt+h/FDtYLSdewEZt79WjGG5Rp0VmwxIOKGcmGKhXrsqcyOAznWRxog6N9GFTPHLx8SwgJ52f+B+jTVC8XYHGT6gvUzqWDSK+TionBG7fv0MMETJmi55vmd6PtHoNmKr9yB2GGM529+G3ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ebUuG9Hx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739977446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rzeh4ZO20HAiLLGtVAkBFj2NDUf7ZgkWV4g343YrPO8=;
	b=ebUuG9Hx6PFKZ9Sn/Qp9drtOX/VNiwRA2mI4eLxPUX1+VTAAwTyCFa9bDRu3dny8LoTEj5
	K6PQww94yJwcrRVP0xoYJ4c1xKqQxSWOHLZf8A4BI0YF3wOo6rpRGsdPVKIq62k1a2xWQn
	Ehy3nt84R01EJmMgJHhKtPZvcu3Npgk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-rswohZwCO_-afV9xdyiXYA-1; Wed, 19 Feb 2025 10:04:04 -0500
X-MC-Unique: rswohZwCO_-afV9xdyiXYA-1
X-Mimecast-MFC-AGG-ID: rswohZwCO_-afV9xdyiXYA_1739977444
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abbaac605c3so405455666b.0
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 07:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739977443; x=1740582243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rzeh4ZO20HAiLLGtVAkBFj2NDUf7ZgkWV4g343YrPO8=;
        b=OKmMLolnoqFOcoDR4hckBxIunnB6tW/1F6bbIV8LOWevnIwQJby6qQEYtTCY6/w2IK
         4V5doqTOXmddKR8aUHCLOvbdAABf6qo0P5zqKlghtVfHZ5lCbC80ekUbkejXrM+JQH/M
         kL6Pvr0kMvP7D3DZaJZXjkbmXvRZyYaEt3i351fP6tAcAoHjKimW1ZyFmrcWMWiG3l3Z
         OJAy/Nqx/saQIq3ARchsQt+NBo7zMg762gnJ/It0+LwTmNwfU35K+mMGz+EyNy+RbiaG
         5Pv7RT+CQk03doneIG5s3hau/3jS4F6arJFpXpO/iS9RdmvtNPtkjh1m2LBbkijyPyYz
         zk4A==
X-Forwarded-Encrypted: i=1; AJvYcCWMuDnqLtfghFh9y9QmuIiozORIFtkDYSiCr7fZ9mp/6dMzokg2Xe7caz8mWPDfX7V5/r+O6Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTOHy5JZtGhrysquos6iPRSH40DDYUmiysEgBsC87IbNNSI1ca
	Ioq8BmxAxCHWG1KxMPXgSeMleI1TgRgTFNmnFsF/KWP0fnWe5NCujdxVX1wKHKCGoo7qTgSkNV9
	jPJ305j8K3Kiw7Ozoqd7MmHVIHB8Eli1IbV6PTwT5Bw2NkuCa1tyY+UpGhb4OiGUAYBv4vIWk7/
	7va7flj/6ESmf9mvBl3qOe34+1TSBp
X-Gm-Gg: ASbGncvPDyNzoPdTLjHdNzs8sIEzAp3WSOt67CQo/kvn/Jgz7GPwZnGqG9bYkD7C5mo
	7IkG8rMvIDYn4gIVLDi/ni+C68d1a/5KUdLI4RkfyFNwY9m+lG8I+9uJ2lyy9RLK4FyltwJHc2B
	ECbMe0sZce7CvFjKQX
X-Received: by 2002:a17:906:6a03:b0:ab6:b9a6:a9e6 with SMTP id a640c23a62f3a-abb70db017amr2120721166b.46.1739977443359;
        Wed, 19 Feb 2025 07:04:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2KCSMI15B7/6Vd8v64zfd3TydXkt/kJn950x4db0OHY+2Z1ocKwnLa47Qx0OIdDdcIpTMdFZ7dRaMd7ukX8k=
X-Received: by 2002:a17:906:6a03:b0:ab6:b9a6:a9e6 with SMTP id
 a640c23a62f3a-abb70db017amr2120714166b.46.1739977442865; Wed, 19 Feb 2025
 07:04:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7XtY3GRlRcKCAzs@bender.morinfr.org>
In-Reply-To: <Z7XtY3GRlRcKCAzs@bender.morinfr.org>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 19 Feb 2025 16:03:51 +0100
X-Gm-Features: AWEUYZkLdnlfopiYwr4BgHsVlA0Qyu57D1nmh8THevG_rpMAwTYyYOH6_8STydM
Message-ID: <CAP4=nvQ2cZhJbuvCryW7aTm4FcLSGLyDnhZX1wHNLxo1b3q2Lg@mail.gmail.com>
Subject: Re: 6.6.78: timerlat_{hist,top} fail to build
To: Guillaume Morin <guillaume@morinfr.org>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, bristot@kernel.org, 
	lgoncalv@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

st 19. 2. 2025 v 15:48 odes=C3=ADlatel Guillaume Morin
<guillaume@morinfr.org> napsal:
>
> Hello,
>
> The following patches prevent Linux 6.6.78+ rtla to build:
>
> - "rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads" (stable
> commit 41955b6c268154f81e34f9b61cf8156eec0730c0)
> - "rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads" (stable
> commit 83b74901bdc9b58739193b8ee6989254391b6ba7)
>
> Both were added to Linux 6.6.78 based on the Fixes tag in the upstream
> commits.
>
> These patches prevent 6.6.78 rta to build with a similar error (missing
> kernel_workload in the params struct)
> src/timerlat_top.c:687:52: error: =E2=80=98struct timerlat_top_params=E2=
=80=99 has no member named =E2=80=98kernel_workload=E2=80=99
>

I did not realize that, sorry!

> These patches appear to depend on "rtla/timerlat: Make user-space
> threads the default" commit fb9e90a67ee9a42779a8ea296a4cf7734258b27d
> which is not present in 6.6.
>
> I am not sure if it's better to revert them or pick up
> fb9e90a67ee9a42779a8ea296a4cf7734258b27d in 6.6. Tomas, what do you
> think?
>

We don't want to pick up fb9e90a67ee9a42779a8ea296a4cf7734258b27d
(rtla/timerlat: Make user-space threads the default) to stable, since
it changes the default behavior as well as output of rtla.

The patches can be fixed by by substituting params->kernel_workload
for !params->user_hist (!params->user_top) for the version of the
files that is present in 6.6-stable (6.1-stable is not affected, since
it doesn't have user workload mode at all).

I'm not sure what the correct procedure would be. One way I can think
of is reverting the patch as broken, and me sending an alternate
version of the patch for 6.6-stable containing the change above. That
would be the cleanest way in my opinion (as compared to sending the
fixup directly).


Tomas


