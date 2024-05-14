Return-Path: <stable+bounces-43755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D443D8C4AD1
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 03:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88DBF1F22FAC
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 01:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9331869;
	Tue, 14 May 2024 01:15:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3C6EDC;
	Tue, 14 May 2024 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715649347; cv=none; b=W6kG5pBzcf1FfEVeqes/69ds/Qc+1jk/Wc5fENVe+8HRiCCcN8q5DNu0u4Eo8/gmYJ4ZEamNFMpFqCu+wZzwzH78jmaLQ1YDtGaAmOpLHcmQwcTZOV/WWIkZ8gEhm9x13YPVRTU3Q92lAqutoMJRJnqDOH6iYdP19FKWaiWBgHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715649347; c=relaxed/simple;
	bh=0g4t4jn+4E1si8A6H6w8IGJTK/A0udZy64us43YP3A8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wyeijc+Uiq5r9vk5zse4kfcngpBfQ5oYZ62mNnqHww8g3BBBvOuovpLyk4EHkwMeJk+tSmG4uAddu27zY2y24h6Tzlb+q2aTdUZXVAlL7GW3kRnl7tNpBoGgxC47Uykxg5quKcYjaCC834P38z9kAlSlXbwnVthS3S5X7F2oUoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2db17e8767cso72115261fa.3;
        Mon, 13 May 2024 18:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715649343; x=1716254143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RnPvnmbVp/k4BkATtYCJhVJdOKpdPbSZG9RJRPJ5Zw=;
        b=cKm34J0GindgjwjjWm1cbf/VEgC0cti2Tmbo/7uK4mfzaez8jiQRVlrVKGAF7WF4/2
         csz8Q9XhpfEs3uzNl9+eNPbvUCLh8TQRF42H/3wBbA0SO2g8FkToQbq3uiTzIPzM7c2K
         Y0MExXaULqtXABksH40xLvYjcxZzgLxR7f2MeLCo/ARpIx7W2JgaXhISM+0HAeDCUh3r
         pN2aFuzI309rQqGmXPaMZXyYDPGeDMqzafZZxHHygz5B/4n4bSA8wvjRTcs5uf/RBj8p
         ux28IYHGU24QemusJ5DrcUnoo9UVP+I68bGQN07v/2rDTNm+wja8mqY7oioBRd/hNgcH
         5+aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkD43T8c3FeMiJ00Y6PTDJ9yTo30jzRTa1CH3cp4WqZIx/ggcv0Lb9Iol4jeBFrmHmiXmT9iTAWFRTG1yPA9Br3kA5d+7WV72DmrAqBrfzHcmMhLJwgZBjGNVRAD6mFbFA+DaPIpYgwcxK5THrj7pAYofAAdD/xBJo8QOkn1saFg7y7fF+
X-Gm-Message-State: AOJu0YzjI0LfVa3ZaPwAaY3tPy44vs/Ex0IJJSkwO/JAES2/oIen7Now
	9fqht8vap8VuVU5j3O9Hi5m9scMzCsGUDxqut2afUn+eTxu37V+8EVtCf7p0SmM=
X-Google-Smtp-Source: AGHT+IEiALkkjxd+IHTRVdiFHfy8XElQWHsr53fcF61q2QypE1VYUTi8DGFCg0+OoqjQ1RP159LEJw==
X-Received: by 2002:a2e:a991:0:b0:2d5:9703:263f with SMTP id 38308e7fff4ca-2e5203a44f7mr77817351fa.44.1715649342783;
        Mon, 13 May 2024 18:15:42 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c322dc2sm6881713a12.88.2024.05.13.18.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 18:15:42 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59c0a6415fso1353921066b.1;
        Mon, 13 May 2024 18:15:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2F0UuxCcao8qkMix51eDNVSBQrIL+FPQLpLt6SXs4NsQ4X3ACGScEEBDXKcymQGjsYVPibf/0DNMt8v2VJipvspeU+UtV6/dJR/tEvJ73CALhLEiHNQiBDI1rsvsDJrnRdzeeQ33AQTU3HMl6yiKZwwcbQG5xWzL4iq55NCByJR/0RFfV
X-Received: by 2002:a17:906:1992:b0:a59:b359:3e14 with SMTP id
 a640c23a62f3a-a5a2d5356d3mr774515066b.10.1715649342335; Mon, 13 May 2024
 18:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240512-btfix-msgid-v1-0-ab1bd938a7f4@svenpeter.dev> <20240512-btfix-msgid-v1-2-ab1bd938a7f4@svenpeter.dev>
In-Reply-To: <20240512-btfix-msgid-v1-2-ab1bd938a7f4@svenpeter.dev>
From: Neal Gompa <neal@gompa.dev>
Date: Mon, 13 May 2024 19:15:05 -0600
X-Gmail-Original-Message-ID: <CAEg-Je-eOMyKzEVhcTsipRyoZ1GD1JvVTjsX3=NPzNKJ3Vsx3Q@mail.gmail.com>
Message-ID: <CAEg-Je-eOMyKzEVhcTsipRyoZ1GD1JvVTjsX3=NPzNKJ3Vsx3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: hci_bcm4377: Fix msgid release
To: sven@svenpeter.dev
Cc: Hector Martin <marcan@marcan.st>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2024 at 6:12=E2=80=AFAM Sven Peter via B4 Relay
<devnull+sven.svenpeter.dev@kernel.org> wrote:
>
> From: Hector Martin <marcan@marcan.st>
>
> We are releasing a single msgid, so the order argument to
> bitmap_release_region must be zero.
>
> Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 =
PCIe boards")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Sven Peter <sven@svenpeter.dev>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/bluetooth/hci_bcm4377.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4=
377.c
> index 5b818a0e33d6..92d734f02e00 100644
> --- a/drivers/bluetooth/hci_bcm4377.c
> +++ b/drivers/bluetooth/hci_bcm4377.c
> @@ -717,7 +717,7 @@ static void bcm4377_handle_ack(struct bcm4377_data *b=
cm4377,
>                 ring->events[msgid] =3D NULL;
>         }
>
> -       bitmap_release_region(ring->msgids, msgid, ring->n_entries);
> +       bitmap_release_region(ring->msgids, msgid, 0);
>
>  unlock:
>         spin_unlock_irqrestore(&ring->lock, flags);
>
> --
> 2.34.1

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

