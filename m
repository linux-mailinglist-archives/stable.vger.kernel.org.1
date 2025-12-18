Return-Path: <stable+bounces-202924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F305CCA3A2
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 04:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1F3E300D40E
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 03:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317AE2F6900;
	Thu, 18 Dec 2025 03:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QK40YqQ3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k+e+s4HN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159CB2571B8
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 03:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766029980; cv=none; b=qxtCs8Bmcdq18N9tfb/Jc1xugEvttv5P+Hkb/xGqM8KIFKV+6ZjI65fsYx16nk7CMOCb+uIi+4tOooTmpYEEuj2dkEfimowcm20yy01Te9Mi4VkRQMgirkYZefmMv9XhD9aUEnRWMsn+epNGNrQmN+KfgPOX03rH+FXDT2zPnc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766029980; c=relaxed/simple;
	bh=QMWBJBUexqbwWDfCPvN8knkhyI690YN3Qu8L+4wssTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbxXy/QYrkeTpvneVStwMi+lpuVGoKngc6lf8jx1bGVUdnlKoSL9W6pxyaukoNU75vvb4RzpShUQeGAp0DOtofVJRBfpEBU72uUV/ewd3cm0bucdOkRaXnYakPWnAahQ25A0cB7XiJe+iPUFFryUFbGGRO4Qp70rHlKtzVEnAtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QK40YqQ3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k+e+s4HN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766029976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMWBJBUexqbwWDfCPvN8knkhyI690YN3Qu8L+4wssTM=;
	b=QK40YqQ39mPPKK0GAiQv6RT4DB7A0rVH3wbASKq+8q3cUBfjuMhLXQrAIwlBF08HaJnm9r
	oZYJZ6y+jZyp11E8QTt9CdWIRoWeJ8OWHY7KPbO7kJvy9xtcjhUWsm5P4MBz5iSd7IJE2Y
	X2NeFlBHPquo6qDCrgNCIQeyG0lX0EI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-wRRPJxHvMH6qygAC3qzD_A-1; Wed, 17 Dec 2025 22:52:55 -0500
X-MC-Unique: wRRPJxHvMH6qygAC3qzD_A-1
X-Mimecast-MFC-AGG-ID: wRRPJxHvMH6qygAC3qzD_A_1766029975
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0f47c0e60so5263155ad.3
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 19:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766029974; x=1766634774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMWBJBUexqbwWDfCPvN8knkhyI690YN3Qu8L+4wssTM=;
        b=k+e+s4HNnZewU/pX5QWpphFgZNQnFcYBTaNVpMVZctsfx918Jny2rX2lMe07sh93w7
         MNZxOWBt3AH04y6Yw5MgM73QcTXHs3UwqQUZ5l6UZo3V2LrBMTHgjb8rkAjrsD42Hoh4
         THK8dAXe3b9kwMoyunySKb0qOwyKjyocY1SxzIL8jDn8NAtfmQqpFNgcWHNeM86aSSkd
         gPw1y7hh82DYhbfUM2fDCLITX28gqLwwsSP8eTnN82a5+WDTsAeVnWQUs+/8LBZFXG+J
         KsgNbtQTwOhubNL2KlJQXo1nzdcQI1IjnKVHFrxRvhcSabSiFvE9rQMX/AXIkKuwwckj
         Q+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766029974; x=1766634774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QMWBJBUexqbwWDfCPvN8knkhyI690YN3Qu8L+4wssTM=;
        b=MDqmsmQNxZAxLoCyLPWbpqvVbQVDEkK0svmmh4J+DM8lO9k/vV4uRz8cjDh+GyT6hm
         ddEXpdYxbntImAhL7S8KpF+HNfQieySagumu/VlMZ2cUFMFLAj/VI7hfvtwNcgyDfALN
         KyUTIEZePU/EdiASzzm23l4JsN1Z9JAJy4FqQMBDo8/MoBgfbN3sEBU02yGaWylJIb2U
         Qj2GEopTIMAVb6guJ1Q0xgJ8E2RPmkajp2oLT2Y70tfUa5VRFxhlaiwty0AWLaW5X7sC
         MBoU5WRFdPnd4N4mf6NmUuseaZoVHMPvp7i9TV2QoHN841nuU6EMd6X93NQ9Ilh87j+k
         3ZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPKXl4K7LBZsYDy8KBhnAbb7q7KcRXBSgBb9XR5Y+7IyU0MUj0h9EYoNtb196H6vOT4Gu+Tck=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd623Rh+liZXOpI+JX2SMFO0q13+T0u7dzrgkW6pWS49BBpHhd
	A2Ud323dMsey5vm+lYZ3Fut8gwYtzswxOv1yUT82grI2KL1u+GcCn/cueEFJefgmml4ciT+2gNA
	EKpXQ5Nue93bg7/lQ/PLBw+JSSX5gmW/z8ibg4OAUYWM6OCjE/WQEeY8HZQuZAEZC5ZCQArTGxF
	KQkakm4aJY1c5JsVakgJebSr2QRT6SoN7r
X-Gm-Gg: AY/fxX5m5WqEdfxuKZB5jfNfE6g4Gk6+0TcVUo+wYsQqxTRdqZYi8Dg77j+JKrBfXuN
	yRwT4wsp8AwQ/YM05k+kQQ0wOs05625P/590vthADihxY1nbj5Vvf4X7gx9w4o2zabuoNPBEhy5
	L2pT1MY42LvS/hA72aAZRHmLUgLorzNbOtOMKtQrmR9c65Uh90Y6eJEv4R0tO3knVfnGs=
X-Received: by 2002:a17:903:1aac:b0:298:5fde:5a93 with SMTP id d9443c01a7336-29f23c677edmr196912265ad.32.1766029974603;
        Wed, 17 Dec 2025 19:52:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHw9DNEwmWjxWfi+F7K4n2BB/diI3M5uZKNjbX0bS9zDqcVCQPXZbRoNc0uTilQyHet8P2VB9LVOiFRTvTgn7U=
X-Received: by 2002:a17:903:1aac:b0:298:5fde:5a93 with SMTP id
 d9443c01a7336-29f23c677edmr196912045ad.32.1766029974179; Wed, 17 Dec 2025
 19:52:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218034846.948860-1-maobibo@loongson.cn> <20251218034846.948860-3-maobibo@loongson.cn>
In-Reply-To: <20251218034846.948860-3-maobibo@loongson.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Dec 2025 11:52:42 +0800
X-Gm-Features: AQt7F2qn7yrgQLTm-jx-zOUUwaHI5CYNjj2jNdNQeouWQKRiXmdxNRu5gCHge8I
Message-ID: <CACGkMEv-zTNkyxQHx5v5FGZE12SHib_73Lf10wF50_7B1WrPbg@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] crypto: virtio: Remove duplicated virtqueue_kick
 in virtio_crypto_skcipher_crypt_req
To: Bibo Mao <maobibo@loongson.cn>
Cc: Gonglei <arei.gonglei@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Eric Biggers <ebiggers@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, stable@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 11:49=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> With function virtio_crypto_skcipher_crypt_req(), there is already
> virtqueue_kick() call with spinlock held in function
> __virtio_crypto_skcipher_do_req(). Remove duplicated virtqueue_kick()
> function call here.
>
> Fixes: d79b5d0bbf2e ("crypto: virtio - support crypto engine framework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


