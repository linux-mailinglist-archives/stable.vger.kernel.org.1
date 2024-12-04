Return-Path: <stable+bounces-98204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213AB9E3188
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 03:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96E4DB232EC
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 02:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBD1824A3;
	Wed,  4 Dec 2024 02:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVyMHb86"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424546F31E
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 02:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280308; cv=none; b=GklcSNF3WRZKDA7L9HcTHEBDEyYvg8EcZKUZWIkoIcDztd6vUFYdznC5vDnEVgKXDwkIkoCcDGux+iLe/bRpSarMUGb+4n7FiikTcIg4mpBNc5VImCc1W3Ir/crkiCMB3N1l3AXGV0ls3MJt6UeqcVn1oULG9aSwIU6bDxE9oiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280308; c=relaxed/simple;
	bh=XbnQOq3MesemtOcTeCYxeKP2DW43Br9wh3sOMpJ7Mmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENGoHRf7wL1rchUoGclWNggWb6+24uIbvWREZmPJa9t8uoEeu0fxvzT2BjnO72zRA4t2aNb80ziT5Yr8gxbzu37JFayEvIIpOcmEQSIPLFTxJuEfSbJs5bJxcsGPUVVsCauzxvw/rpo+vo2NoLHsF21G+ULNdvMkwIYocL6X2yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bVyMHb86; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733280305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbnQOq3MesemtOcTeCYxeKP2DW43Br9wh3sOMpJ7Mmo=;
	b=bVyMHb86puUYx2QRKQAD5W6hVOmByQITnkJsMbt820NT9xMwRO3g1OhdhxgyCqvpRV4GAF
	iUqYLwJQ3Q26noP7MLH9J8qpsquNS9XX3L7WQi39DJX/GiVRAY1VJ62oTbwDZxNk/8eScP
	3hdoqj5NjfSaM9116ilGD9dWYXbd61w=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-lcWOakRUM56hOKQDl6vnew-1; Tue, 03 Dec 2024 21:45:04 -0500
X-MC-Unique: lcWOakRUM56hOKQDl6vnew-1
X-Mimecast-MFC-AGG-ID: lcWOakRUM56hOKQDl6vnew
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4adddccac28so856085137.2
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 18:45:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733280303; x=1733885103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbnQOq3MesemtOcTeCYxeKP2DW43Br9wh3sOMpJ7Mmo=;
        b=eso+QSH/hUAmVWGhd7Q1NUqp8hIyKRT539MKTfFXoa+z87iHZk/qKl9TorhKh99g/f
         L5TEhRDciS7r4hjfo4P5BO4eyscqe153z4NXtvTpv2B6XEVn6sutQFQAy/8JV5RjlFiV
         Ruf13HFW4+8eWCT35AjAhD0v5eLvJr8qkR8p88OtVg3b24OGJW5aZJCrkRsEzKt8VyMF
         offjsDu+ObcJtWtzcEtKTWhmVjh7ifqBPGig4U3XOaEm8vKtKC8lwq9YBjt+Br11rOCV
         +LqkRUJAFki0Pg/OLJTe+OKHyP6mzdEb4vO8ztK8mjzsQfj1bX8f94Waasbfplykq4vF
         Wt2g==
X-Forwarded-Encrypted: i=1; AJvYcCVLSSy3ez99pnM3JqRLM9icC8iPMXdCbLdi7YoeDXHD6uPTj9dXX0zKHrmFgcocITL13WJuxp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzVLGwxl8A7//fVB1fui4v1mDUIfvFko8sI1ayxTob2rhv6GJp
	THeLb+75cFL6tuqm6lL6pFe5TK44+qYvDsxV0Llj/5pmnb3yq9JndPqLym4fsec+Ca1BO7HQemZ
	oFlq0gHcHRGoONCz1c66xnhlVWpF4mVEscj4wUnwPm7xUQ0ip6uHQD4AgeZrt33J+2mP5CevpBX
	3rLtzzY+kIEkv1HY1xV53vApsBdfHj
X-Gm-Gg: ASbGncux15czUg92br9fctSu8gBZgkbUhyLOVVxelQVFNcT3QFBLUPW9HC2dtPT2+QX
	7MJ7gjady9nsOkY+9MLXFiw8VM9VIt8jl
X-Received: by 2002:a05:6102:5489:b0:4af:aaa4:dd9a with SMTP id ada2fe7eead31-4afaaa51842mr2184621137.10.1733280303456;
        Tue, 03 Dec 2024 18:45:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnv582pmJNRSCddpQRIMLUIrhRF1VM316y4CUO+jOhzMa7TrksbE6s7FhVZ/bBvYjjr0SiWjodQSlPoQUf1dM=
X-Received: by 2002:a05:6102:5489:b0:4af:aaa4:dd9a with SMTP id
 ada2fe7eead31-4afaaa51842mr2184605137.10.1733280303130; Tue, 03 Dec 2024
 18:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203073025.67065-1-koichiro.den@canonical.com> <20241203073025.67065-3-koichiro.den@canonical.com>
In-Reply-To: <20241203073025.67065-3-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Dec 2024 10:44:50 +0800
Message-ID: <CACGkMEu=zjbnyLGLESsSUx_J_KkcKHYo2dBDuQ_evvkOuJ=bEw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/5] virtio_ring: add 'flushed' as an argument
 to virtqueue_resize()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 3:31=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> When virtqueue_resize() has actually recycled all unused buffers,
> additional work may be required in some cases. Relying solely on its
> return status is fragile, so introduce a new argument 'flushed' to
> explicitly indicate whether it has really occurred.
>
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


