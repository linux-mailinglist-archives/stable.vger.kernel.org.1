Return-Path: <stable+bounces-180698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8FBB8B0C9
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 21:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296E0563654
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 19:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0FC28312D;
	Fri, 19 Sep 2025 19:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hXCxHh8N"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D18D280309
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758308959; cv=none; b=qg0Mu/6rYJxHJtDZIDZnjST2jxRsTJ/EG/g16j8xV6NWqi7glQoLwQ+FrJeZD5XrNQNNinlJcQzVZLsA3w4G5slJUMS5RQQ0x2wCM9MzJy/QtAwvYHb2xAWw+Txb1JBKeWk6zXXjPsrR0i6gs51SIaqfO0lzCRO2XXo1Z/hzYt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758308959; c=relaxed/simple;
	bh=I6jtwFO4rLlCn3Qr98wO3TZ4R5zgDcuCAtGJjeBz4KM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZmiPn+K+N+wA86itTToMlGxQxY73osvtrSLMQnhRdxksXuPn8ja6hKCdgB1vT6+lWFZeZXCwJbShBb776qsF5hLqUNdVdOpHarz5R+cxVJOV80usXbFDiLbt4nYn9M7hVciIRDT+kD+6zWfrZw9iPZf7cFc6QwYHkPpNAYt9q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hXCxHh8N; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b7a8ceaad3so22356891cf.2
        for <stable@vger.kernel.org>; Fri, 19 Sep 2025 12:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758308956; x=1758913756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXbAvw5kkLVhGfc5Ze9Jc+p6148kul0m6ybt6DGydeg=;
        b=hXCxHh8NCbn0JujoChJPSy9bcSl39TyHyq01HV0SDhHBu7LAbEyO0uK6HQv37Vf4u5
         gTFIwC+mQPrRHmp9aFFvHoI2xnkjDkrOlh+LS1DAbqAhwFnGSO8j/OaFD3zb7NaAJ4Jg
         oYKmkGEadimwVh8bZt0Hqf4HvM2CxGJbe7rXnMEsDRoZayvKrnZHOo6V9KkE14wPApax
         DbJJ6/NFnHYqqhUsosZFrRAV6srW7rDQA7aixuoYnjHso4RQ2PVLmNaACIBB2E6yP+1Y
         ySyUcDJh7P2qyrcSOCVoGuTqIzikYH3/f6f1NRFlfJldjzNGOc1P+MjaMdea+WytqbNj
         otZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758308956; x=1758913756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXbAvw5kkLVhGfc5Ze9Jc+p6148kul0m6ybt6DGydeg=;
        b=FkLmzu1Ha7RInV5MstPz7SWo4CkZw7pZD7wmPjrsRyAjH68noR2th+EXu3hxDwwKva
         v7BZLS9EOEJuHcdj30OMNuaDjIWxEmiNgL0b7S4aOgJSo8MKaFUv75gsqqrHzFJde2Cg
         PaiZR85VIsJLpOZosBuLswrT7L05pMbjVBJiooZP+NUwwPe8mddduK45bAGiuQFgb5R1
         WNmMKj/QW0EM3n2WAisfeSTTzp81qY9tcz9AXJ4kWhPp6h97qZeo5w1xCrOwzaI5mEBs
         SMfMYIFLyXlcUa7Bf9kg16zU/MSS5FJmMmTG88nXHSWWpMwTBRFdPCSP7vT2VwtEUMS7
         mrZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz8rkgkdVarIqcZc0yHdszlqgsZh9LlHNu+nCS28g66xuIzWcnN8lycW4DeTQm2wd01ghluKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/DMIIoT2IvtcUrHcoMhUaIoOIaaqQa73bwo0sPzj0b++njSfu
	8e9/MqwZ7IUH0FDPUNp8S508BiABgDyo8/S4VsI9ZvmUrhqlWIFvy/GYQLcbnmatVxuWr0COqKM
	ENuQI7bCoGvFEUVCnZN03lSpqm958Vie+zwoKYwJ7
X-Gm-Gg: ASbGncubNB3is1Z4CRJH4NMJj6WqlD6110ewuR+qVP+2kZhGN4e9U2wAKjNoOKuKseq
	R/HOV85bqk4bDgQ46IB7PUElLGEdzbrmgzFxTXerMy7vRiq/MhBnGw7puYQpnmbnUo1rmjPTvde
	IHHpSYZjCNR+ww7wDTjJUcSkImzVx4DYqe1fsv7No6/4JUYWxxXFY3R2iMr1rRs5Gd56qPbOHGw
	PEJ0A==
X-Google-Smtp-Source: AGHT+IHK4rrWt8hd+ehEHrqlcbzDHbyFpcHelDgbKsL1PGeJzPjV9eDyf0iQYAEDXEKf6jxfMvTMc1pEz6lgz1mBp/E=
X-Received: by 2002:ac8:7d01:0:b0:4b7:a62d:ef6f with SMTP id
 d75a77b69052e-4c072e26929mr51253261cf.64.1758308956080; Fri, 19 Sep 2025
 12:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919180601.76152-1-hariconscious@gmail.com>
In-Reply-To: <20250919180601.76152-1-hariconscious@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Sep 2025 12:09:04 -0700
X-Gm-Features: AS18NWDU8qkSN-NhK9yhAi1bjWHatilGj8aec2jq6okG1y-abKQuoQiJV7Jupu0
Message-ID: <CANn89i+ara1CeKOfuQgZ+oF3FMv3gF2BLP_7OSEEqytz-j9a-Q@mail.gmail.com>
Subject: Re: [PATCH net] net/core : fix KMSAN: uninit value in tipc_rcv
To: hariconscious@gmail.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, shuah@kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 11:06=E2=80=AFAM <hariconscious@gmail.com> wrote:
>
> From: HariKrishna Sagala <hariconscious@gmail.com>
>
> Syzbot reported an uninit-value bug on at kmalloc_reserve for
> commit 320475fbd590 ("Merge tag 'mtd/fixes-for-6.17-rc6' of
> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux")'
>
> Syzbot KMSAN reported use of uninitialized memory originating from functi=
ons
> "kmalloc_reserve()", where memory allocated via "kmem_cache_alloc_node()"=
 or
> "kmalloc_node_track_caller()" was not explicitly initialized.
> This can lead to undefined behavior when the allocated buffer
> is later accessed.
>
> Fix this by requesting the initialized memory using the gfp flag
> appended with the option "__GFP_ZERO".
>
> Reported-by: syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D9a4fbb77c9d4aacd3388
> Fixes: 915d975b2ffa ("net: deal with integer overflows in
> kmalloc_reserve()")
> Tested-by: syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com
> Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
> ---
>  net/core/skbuff.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index ee0274417948..2308ebf99bbd 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -573,6 +573,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_=
t flags, int node,
>         void *obj;
>
>         obj_size =3D SKB_HEAD_ALIGN(*size);
> +       flags |=3D __GFP_ZERO;

Certainly not.

Some of us care about performance.

Moreover, the bug will be still there for non linear skbs.

So please fix tipc.

