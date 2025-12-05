Return-Path: <stable+bounces-200098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96326CA5D2B
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 02:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53CEC3083F9B
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 01:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97FA2192E4;
	Fri,  5 Dec 2025 01:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5csv8oW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n6AmSGfH"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E621D21767A
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764897724; cv=none; b=o0h8R3YWyjqX4dCh5wI+OaPIlFPi5jpW5mowD4usg4jXHptyULNqf8kRh56zFdfPqlVsh7g0hU+MqvKi7RLZ8CE8nzNDMF90WBkUBb1/GNyzOshUBsMd0lRXfHYSyexKpSwn0bejYq+VpxkYx4xYIC4JIUCYEJBlytQ2rF9Xjso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764897724; c=relaxed/simple;
	bh=moXJy1ndyc8YAWeLaKyiIjfpRubjyBmv4THSzKELYCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkV/6KYkVRmE/3i/xGSJlOj8LEqsd23C9dhcabQu+k0GRaCHz0C+ohFEYH/w02dEopiH2vEviD3+WoTj6jv9gNn8b5vu8VWwYsuYeYDGO6EuIP3Bj4LCGsY3eEJFxvxyEPED0dDnJPxNjfUaRCogeeIs//kz9KDnI3ooAmr9poQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5csv8oW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n6AmSGfH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764897721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYiaCMznb7Jh7gyLxXu/TY8tpQriPJlFFUBGVN8VVpM=;
	b=A5csv8oWj9u79MzAjW2HozTj3V12NdsH6Wq+fkk5bBxZ7s8ld3Kliky8lRnaFS9grAh6PG
	WEGdpm+b8qDq9n/3rt9Coon6ddBmK2GLPf1uki0KM+79ffodpYdzzhrRZuJ5IPUIMdAKQ4
	7fvsXdRi2ZrH+ocRXhhlPyUUNETkTyI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-bCaxmGcMPhuiSgkMv5N_hg-1; Thu, 04 Dec 2025 20:21:59 -0500
X-MC-Unique: bCaxmGcMPhuiSgkMv5N_hg-1
X-Mimecast-MFC-AGG-ID: bCaxmGcMPhuiSgkMv5N_hg_1764897718
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297dfae179bso31807865ad.1
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 17:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764897718; x=1765502518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYiaCMznb7Jh7gyLxXu/TY8tpQriPJlFFUBGVN8VVpM=;
        b=n6AmSGfH1xKuImCVj5KzJQS2/3REaUQCEnh3ghMHUUOSD+1OJo3HTDzNsLvXSl9Xep
         39Fdbvh8rsGPoMxLVsI6SzB6fwHBXuJdCVuuY3V5zDlzy9fUhtD6VNyp2QFQc2RfAiv+
         CXhxCCVNXEQH+RQwt5seYyLFdHkY7TSD4ZgCdIfsr2kffbZkDCe8XpfUBtP/ER3l/WuG
         czIoBuqedW0H4EMHBLAAlO6BXfLFuYlbIyRNhMwNeZT/ZxzoPSgpUOogBRlytF7rdYjU
         1WN7Qw6Nx2l8fOu9wiqytAh0TSu5ffZZf+OfEgF5ewOcvqDhot6OK2kKGMj8DaVzAH/P
         Zjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764897718; x=1765502518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fYiaCMznb7Jh7gyLxXu/TY8tpQriPJlFFUBGVN8VVpM=;
        b=qZ9AyCAempbXVXJYPCnSmzRzj4fZC0mlBL+B2aMg2T/3C1sBAUyUbvbzYa6I9VT5GD
         8vjhn8bQo+C3lzTIF9zjFIuVsy6omi469DkOigmj2YEC6PBITIhiRjWRNFcQ9gv4l2oo
         WaJRjIHw/KgI7rQXleu2rfxSzY4bCWoce85A6+5Hlcv/5nzUloB/8twdTd9JbBqfBBwG
         cDVwCSTE7uYbrs94VUNP42b1l4USAhLw0TQAxyIpcDVbC6bSA9cABa/DGwHxxLjO3H20
         mjplmWlb1/rWxuO/ChW5DwYZVMJ5SmfSEoPepCA7Vs7jxSEatauuBwg4TS9pM/skA00p
         hqRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfZZQKd0WOwyup0y8O1PDNHbYyxnm+8PI+y9cheezvXK4QQ7r17AAFkKWN1i1xjc5WSgdxKis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7GB98JbrtM5F07BAu7wQO1+JTf7A1eF8hS3BMbI8ZBKLSGXQ2
	uMCE//IOkMtjIPNpXLEuk9QPTpdcC0M56ZiVPqtcqecKMUfMb8KZONbch8N2MHDvRXrawwRwzK6
	NQTtPIbg4uZBUL9GaI0optfImZGFPCKrYQq1b9BGwYb7FFl+FT0119usL3DBklXLwd7llhlcv6M
	bHkOX6qmPA+YYntXs6jMEKCdgeAFT+HnXo
X-Gm-Gg: ASbGncumP9zv0F4l00o1y4i2TM0J76VoBBi9SLsM8kp/vukMKC5WxQJhjNl79/+P/Vy
	tCA62OZLbm4nY1tkKf/YOwX3DQeyIuG/wY1dDqgDUw24jlDPlw9RjYOuk/s/6SdM4l1lKmjsU45
	wRc5gBCcnKTl+RvAxd4BoO3OjjJuG9Lg8t2FPz6Lym8L/yNUB0V4uzRVpNTViu8u3kcw==
X-Received: by 2002:a17:903:1a90:b0:295:7b89:cb8f with SMTP id d9443c01a7336-29d681c5ff8mr95179555ad.0.1764897718168;
        Thu, 04 Dec 2025 17:21:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEz6UQheUOskXAPVFiyJ31BXhLmKjKvRKhbFz9taEXKwU/ReS1/visXCISoRNqAu5RAwOmGVEMng+JiImGULU=
X-Received: by 2002:a17:903:1a90:b0:295:7b89:cb8f with SMTP id
 d9443c01a7336-29d681c5ff8mr95179235ad.0.1764897717759; Thu, 04 Dec 2025
 17:21:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204112227.2659404-1-maobibo@loongson.cn> <20251204112227.2659404-2-maobibo@loongson.cn>
In-Reply-To: <20251204112227.2659404-2-maobibo@loongson.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 5 Dec 2025 09:21:45 +0800
X-Gm-Features: AWmQ_bkFuyGkNmhfuUOM0G1Rk65Kgzdae-EzAbpNlnvQLHxjomxthjfe9VjMPoo
Message-ID: <CACGkMEsjhw2=XCFH6qoYu60NjTf-DJ-oaB89qjaeWpsk+5t6JQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] crypto: virtio: Add spinlock protection with
 virtqueue notification
To: Bibo Mao <maobibo@loongson.cn>
Cc: Gonglei <arei.gonglei@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	wangyangxin <wangyangxin1@huawei.com>, stable@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 7:22=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
> When VM boots with one virtio-crypto PCI device and builtin backend,
> run openssl benchmark command with multiple processes, such as
>   openssl speed -evp aes-128-cbc -engine afalg  -seconds 10 -multi 32
>
> openssl processes will hangup and there is error reported like this:
>  virtio_crypto virtio0: dataq.0:id 3 is not a head!
>
> It seems that the data virtqueue need protection when it is handled
> for virtio done notification. If the spinlock protection is added
> in virtcrypto_done_task(), openssl benchmark with multiple processes
> works well.
>
> Fixes: fed93fb62e05 ("crypto: virtio - Handle dataq logic with tasklet")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  drivers/crypto/virtio/virtio_crypto_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/=
virtio/virtio_crypto_core.c
> index 3d241446099c..ccc6b5c1b24b 100644
> --- a/drivers/crypto/virtio/virtio_crypto_core.c
> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> @@ -75,15 +75,20 @@ static void virtcrypto_done_task(unsigned long data)
>         struct data_queue *data_vq =3D (struct data_queue *)data;
>         struct virtqueue *vq =3D data_vq->vq;
>         struct virtio_crypto_request *vc_req;
> +       unsigned long flags;
>         unsigned int len;
>
> +       spin_lock_irqsave(&data_vq->lock, flags);
>         do {
>                 virtqueue_disable_cb(vq);
>                 while ((vc_req =3D virtqueue_get_buf(vq, &len)) !=3D NULL=
) {
> +                       spin_unlock_irqrestore(&data_vq->lock, flags);
>                         if (vc_req->alg_cb)
>                                 vc_req->alg_cb(vc_req, len);
> +                       spin_lock_irqsave(&data_vq->lock, flags);
>                 }
>         } while (!virtqueue_enable_cb(vq));
> +       spin_unlock_irqrestore(&data_vq->lock, flags);
>  }

Another thing that needs to care:

There seems to be a redundant virtqueue_kick() in
virtio_crypto_skcipher_crypt_req() which is out of the protection of
the spinlock.

I think we can simply remote that?

Thanks

>
>  static void virtcrypto_dataq_callback(struct virtqueue *vq)
> --
> 2.39.3
>


