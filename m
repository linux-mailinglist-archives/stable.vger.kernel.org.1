Return-Path: <stable+bounces-100535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C5B9EC471
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 06:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61C6283F38
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 05:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D451BBBCC;
	Wed, 11 Dec 2024 05:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAAb+HOn"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A794C97
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 05:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733896212; cv=none; b=ZBFiQx8vsM+kao4zlJuh75X6wZCQwdliaLmwxMQPJxNOmCHVnwI6cqPoa49QWpztOg16dJlPJhetT+tDevgVafGhQ/zqHPg/sngMY47i1zBGR52x+b+2SX5ugYNazHn6XHelTkxa3G4l4vFt/H2/J/HW1HkVU/RATzZN9SIjvIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733896212; c=relaxed/simple;
	bh=pTw6+HXewQVV4V8HC5eH2eUX2bdmmcmJFKzFd4Ir55k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rESuWhLdptfmQpVNFbYo9O+8hv+fLKBL/8hEO5Ow1zRTJ4NY1z7VU+MuXy/872/TRd72JcWDJ/RsIKDyfYJDNt6QcrAFRKwABa4vychoa+GTvdNJ4bivzhvIeGgjcMK5YvqWm6YU0Cm4KIUhvbH3gZwGWPQpTYPlTr7IIZaumjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YAAb+HOn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733896209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZKzAJOTVUI2+3jv44AVXBEr1V6z3Mv6Ud2xQd2hF/E=;
	b=YAAb+HOn9W98+sMigt5SEtA41c9cdmix21RyPLMpWpTVkcBkZZGjrABbYrWbMG5KmdPtPB
	N7v1jF97/xW2UT5MZX0WNAHTRrMmfZw2+ZGaCHw5kdQr0KyYrYhuZT6ItoGuiAbN9D6n7C
	FV7PPj6MJoul4RnwI03P0JHv3x2FKKY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-b8tA85jjOcur8zTLtJrKOQ-1; Wed, 11 Dec 2024 00:50:08 -0500
X-MC-Unique: b8tA85jjOcur8zTLtJrKOQ-1
X-Mimecast-MFC-AGG-ID: b8tA85jjOcur8zTLtJrKOQ
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa68952272bso12303666b.2
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 21:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733896206; x=1734501006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZKzAJOTVUI2+3jv44AVXBEr1V6z3Mv6Ud2xQd2hF/E=;
        b=Qq5oUmQ6eEzXFenVFqRtJ52C5zvJLlI+cMPkR2RZtp+BL4CqizlYabSf8w5jZ9vNBm
         WtViecaYZLniQ4EjcJ5IuxrQ8sMFCirrdKpbp4tzxVCjw0Nx/EijDRHKWzkn/rl0Xr8U
         3huzVZ+mJTzk51BnIFI2jdjekPY50wnyXqSIOOjCc/JpHzH7WRzA29Gk/eHHC+Up0jUL
         2XXSOtYU4ROB8GfMrs40OtRPSGVCJB9SMkQ7DJtYsnH0++ty2zUSGn0I2YeyYEX2kGuv
         VTn0AzEipOtrX15oufcrp4RFfd3RYkuhGXZw53l/T5WCjdwjgJpq0QEUNfJ/ADMBSLB4
         3llQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdFFihxRvKTGskfsSoyoDCTimHxTCSeBTDpB6rPSF4iA5OwEzeTxxTNjKNhKsrGXdkbjWNk0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCy1Sjakq0U2OqLXMMDX5JsXo42YbdLpeICmcgPIoOu6xC3YoO
	jhzV5VnkdAYfE4xPKZfXTUDhJhZHquTsyxFy4U6hKR0QivUYlGnLMKIAW97NNLafRAQwpyZTQkC
	x8UX7Or47Qbr43rLv5xbZo9I2MAFOfS8EnJ216SJ+hcisLWfCt+R71rNK2S7HchLegDVb8Z0lxn
	oX3/0HHnZZa7lqlYRuXLotqdyq0fFT
X-Gm-Gg: ASbGncsxomkWvTqnQDKjvfH38LN6rZWF6Srh+5GEsjHZRws0588I/TgYwfKC5k5cFz3
	4InJQG5QFE0Cccrr0JOaRIujH3Wb+e++9QpEy
X-Received: by 2002:a17:907:7702:b0:aa6:acd6:b30d with SMTP id a640c23a62f3a-aa6b1396eabmr113659666b.48.1733896206574;
        Tue, 10 Dec 2024 21:50:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpDct7ZNNOFQqgGk4S0pzIyNtjEkcahpRAQ25cSBOXT+i/S1uQlOHn7d+0GcNwBJsWFR2bkTyTMTH2AqxqVS8=
X-Received: by 2002:a17:907:7702:b0:aa6:acd6:b30d with SMTP id
 a640c23a62f3a-aa6b1396eabmr113657466b.48.1733896206265; Tue, 10 Dec 2024
 21:50:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206011047.923923-1-koichiro.den@canonical.com> <173382722925.756341.2427257382387957687.git-patchwork-notify@kernel.org>
In-Reply-To: <173382722925.756341.2427257382387957687.git-patchwork-notify@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 11 Dec 2024 13:49:29 +0800
Message-ID: <CAPpAL=xJ9_-TU=9rhtdR78g-SVSn9vOMBr0vaA8VbP+eLykvFQ@mail.gmail.com>
Subject: Re: [PATCH net v4 0/6] virtio_net: correct netdev_tx_reset_queue()
 invocation points
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patchwork-bot+netdevbpf@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this series v4 patches with virtio-net regression tests, all
cases test pass. But I hit a bug
https://bugzilla.kernel.org/show_bug.cgi?id=3D219588, only judging from
call trace info it should be a CPU issue, and not related to the
current patch.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Dec 10, 2024 at 6:40=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to netdev/net.git (main)
> by Paolo Abeni <pabeni@redhat.com>:
>
> On Fri,  6 Dec 2024 10:10:41 +0900 you wrote:
> > When virtnet_close is followed by virtnet_open, some TX completions can
> > possibly remain unconsumed, until they are finally processed during the
> > first NAPI poll after the netdev_tx_reset_queue(), resulting in a crash
> > [1]. Commit b96ed2c97c79 ("virtio_net: move netdev_tx_reset_queue() cal=
l
> > before RX napi enable") was not sufficient to eliminate all BQL crash
> > scenarios for virtio-net.
> >
> > [...]
>
> Here is the summary with links:
>   - [net,v4,1/6] virtio_net: correct netdev_tx_reset_queue() invocation p=
oint
>     https://git.kernel.org/netdev/net/c/3ddccbefebdb
>   - [net,v4,2/6] virtio_net: replace vq2rxq with vq2txq where appropriate
>     https://git.kernel.org/netdev/net/c/4571dc7272b2
>   - [net,v4,3/6] virtio_ring: add a func argument 'recycle_done' to virtq=
ueue_resize()
>     https://git.kernel.org/netdev/net/c/8d6712c89201
>   - [net,v4,4/6] virtio_net: ensure netdev_tx_reset_queue is called on tx=
 ring resize
>     https://git.kernel.org/netdev/net/c/1480f0f61b67
>   - [net,v4,5/6] virtio_ring: add a func argument 'recycle_done' to virtq=
ueue_reset()
>     https://git.kernel.org/netdev/net/c/8d2da07c813a
>   - [net,v4,6/6] virtio_net: ensure netdev_tx_reset_queue is called on bi=
nd xsk for tx
>     https://git.kernel.org/netdev/net/c/76a771ec4c9a
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
>


