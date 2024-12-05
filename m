Return-Path: <stable+bounces-98735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 695FD9E4E70
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 08:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A5116176E
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 07:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FA91B2183;
	Thu,  5 Dec 2024 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZwpdw+h"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F87619FA7C
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383955; cv=none; b=edGhrpABNm7QbNQPPE/4nItQMVpTbS7HE/9qTyh8e6wxSwy0sy8aGba5X1y8lJDP3yfnxCH1SGSrYYsCD8pQcIDlbn1Da/VXyTXivUKE3NXoGth2maj4tNMN2UFuedTg4E+36zmHWWKPYG1DP3lWPi7BXR+KJcP4/YxtjIsUphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383955; c=relaxed/simple;
	bh=ki6pIKSupwzYj6s/3NRHiuQu5GRhGkrv5KRSIGzJ568=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLmxcPH7GvktCgZrmya4wdmnXXDgrW9Wtu4cp2CKjMWiYWn9B2zMVxrixA3nTzeK/z2jbHdpOj28G6+5uH2utl66rYuFOheKTJQRNocT/BLNzMk52LMxpDUFqpc9PorvgAz+5ZTu4y/JTX2kXtWyZYyT9y6BEAjIyvI7rnmVWR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZwpdw+h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733383953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ki6pIKSupwzYj6s/3NRHiuQu5GRhGkrv5KRSIGzJ568=;
	b=UZwpdw+hxSeMcAegtnmvko+kpwfH5j5SXg2dEyrBf6BnxJjZIA/aGK0vsIZ4GAsuJaiClC
	1UWnyeG5KCAF3hN7Iy6MaewoMLLc5ifgZONonmLt4VkV7i42j85JPdhnt4wS6wc/J7S3Dp
	KoSksl0XJEiDGA66XOaCxKrGqWDwbJg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-rWbLcRfWNzaeMXBUp4Ik7A-1; Thu, 05 Dec 2024 02:32:32 -0500
X-MC-Unique: rWbLcRfWNzaeMXBUp4Ik7A-1
X-Mimecast-MFC-AGG-ID: rWbLcRfWNzaeMXBUp4Ik7A
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2eebfd6d065so806095a91.3
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 23:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383951; x=1733988751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki6pIKSupwzYj6s/3NRHiuQu5GRhGkrv5KRSIGzJ568=;
        b=FxRbrIcYy4dUTKUYS103s7xRSVrKzV/nXGXzKt4S4xtVnDwY2Qtgbt6ft1+VxCf6cb
         7RM6ii7SYOwsXVpnaFtM12AKZDpIzg4tRel0jETXxUv8ogGtFYnwg4ufaHHLqlbvVieV
         HvDjKHNfqvJ0O05/o2eKNkr0Jd2imMtlguXcKQbjkgcE1pQEVn2z4VrgBbI3ug1mFaTC
         qqjgI2kFg8n5c0YSVbhvIgoM6BvhY5PCkfUAkpaJL42K+dyvIVMiCB3gPrBmA3FSZ3CX
         CVudcqETHIknUbIYRi4N7FaMgTVu96WZEqA6AufK6kTSuHg0BXMEucqMdulbyPd771+7
         19Rg==
X-Forwarded-Encrypted: i=1; AJvYcCV17jL1l82f+xSbpRdfeN15TMuDoWjOYYlLh8sr4nTvooHgtQ93SvY4YP12G3Yf7LFORlljBFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznZGVA3HMu63IzwJfuCtyLj9Du+llAjQLDrcdfzuMdd3VjuONe
	9D4YhHOGxCuIdea8n/jFlHhi2tty2x1larqSVYB4Tn4iGbpashvSaACAGZahPtXSSLi5ds064ae
	U/hcOjIKbWe6SUFoymqbQzAh5JlIq8zNkMaxr3si+PRrllcYX8pgYq/FJWQUNlakp/FmBWH8vQq
	Fk004tZSHEaQPm64wUAwS8dSl//UCK
X-Gm-Gg: ASbGnctuadb6AgGgMwuAR3RBoZxRObJJja5kEY/EkD2fz4TRAFdUyJZLnFBxDa40B8T
	GTVsEDBJLRMEmTPzDfuZO/X/xOugE5NQ67Ouq
X-Received: by 2002:a17:90b:4b86:b0:2ea:4c8d:c7a2 with SMTP id 98e67ed59e1d1-2ef012446e8mr12752047a91.24.1733383950954;
        Wed, 04 Dec 2024 23:32:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH00pmkLuLXttemKJiKF9Q/OxhVoQePAQMlOpYi0wt7eK+3w9Uxtm8XqdoXThMNr2b4ra7bR0qWU9AsuFmRg/c=
X-Received: by 2002:a17:90b:4b86:b0:2ea:4c8d:c7a2 with SMTP id
 98e67ed59e1d1-2ef012446e8mr12752030a91.24.1733383950636; Wed, 04 Dec 2024
 23:32:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-6-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-6-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:32:18 +0800
Message-ID: <CACGkMEvHUQDfAjeSBdNd0iotrgyjkbXuZBH7ehs6dZ74prspdw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/7] virtio_net: ensure netdev_tx_reset_queue
 is called on tx ring resize
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> virtnet_tx_resize() flushes remaining tx skbs, requiring DQL counters to
> be reset when flushing has actually occurred. Add
> virtnet_sq_free_unused_buf_done() as a callback for virtqueue_reset() to
> handle this.
>
> Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


