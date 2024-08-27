Return-Path: <stable+bounces-70309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD772960432
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 10:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E388282DD3
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 08:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20133192594;
	Tue, 27 Aug 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iFgxyKp2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9671487F4
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746785; cv=none; b=YBhivU6kV6nyGscvVnSAYhUBZhxsYolciqte9j6IfZeMp8sgJc2fbIPSL0K08Ci5VQ2xhS66lwuEt7hFJIhC+XSiAhokpGD2b8vijtlg8AqbVLhtvmNyBgriO0mVIGxwK8k2GGvW/o0OI0HLFC2muq1roKxAROpI+2cBRfCInH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746785; c=relaxed/simple;
	bh=spR3CGSFlcWxd61znYrOMywbunOudD26HRQTshpPnAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtmO1JNxE4/GBv53+lUNxwUotAZvs0Cp+h4Zq6J6D2fQ44K/ZYkjA3stIhpLYPiiOfADDh5yOR6RNbGPCSOg3xJjlX/2Mimv8758dng2ANMkkTPqBp9EuyQd3Ue4+PofFzhYfPmAL22qxpX/MwJWB6klSsJ3/R0ALf+LlKY0VCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iFgxyKp2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-201cd78c6a3so35717455ad.1
        for <stable@vger.kernel.org>; Tue, 27 Aug 2024 01:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724746783; x=1725351583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huD3ev31mLebmA06NYxn0TFHXgDRdCiQozZGR5G/ENM=;
        b=iFgxyKp2Jp1jrjiJCGOqeDCqzu22EdQX5fHSaCaxx7eiu1a4aoJDChFZLTXmQw/Or9
         6CxpdvdysCvmA84B7wSb34K1fZ9JTqLzZW65oIolMqSsvL/V3TTOvdtLffaKnvJwuMCl
         19jUCQn/UThCGdj0gY0K+7cTlIrXlBnrpaPOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724746783; x=1725351583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huD3ev31mLebmA06NYxn0TFHXgDRdCiQozZGR5G/ENM=;
        b=kFxONGREdYVl/6Gk4s7EbpZStZmHliCj6eeKa6vlLt1Fdb/0OYCYtgTGyM6/AWev6C
         9bjvycNSWkl9GY691yOfG/WyG3WyZR7WaRKP0VIzqwx+qLxpHmb3kXzgkblmBhTVAkGq
         uxva5LPKApO7763qfmMsjT/QLFxWrfbKk+bfWkckrsdgGkZoyh6jtWwdzlw/uFFewJX7
         MKf+5TEZ4p5swS0/+/U14+pRUKURr5J4ltcpN7REczB9ian7IVB2rxTcVSEesyofM4wf
         M5UWzroThaljBiGUFATYVVOAOEyIdullD34tKNsFCJBC+uPHm9MjCMerR2x4o900GBYG
         HOtw==
X-Forwarded-Encrypted: i=1; AJvYcCV+x/p8vibG0D7FbaE6QV27H2KdBftnvHqArlt6p9UkyBm4TqJSWp2LIsMg5RwQadP/Zh/3wb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfXcVJT/ktR26dx/Yk6qNZgk6rOT9VZppbR/JD5lsvGQLNbY87
	10/P8mNjGWQ498sQguAzagkIN5YPyG0A0xXKVEibeXv5pbcTcmvIbNYRFMBNfO+/US+O23N15GK
	+wbXr
X-Google-Smtp-Source: AGHT+IE53Bt8Ie6W4k2wrv7t6M+wMLCEnoVX0ol/7CbOoaThPkcxBmB+bt5v7Wvpg0FDOlD1HUZTMw==
X-Received: by 2002:a17:902:f60a:b0:203:a279:a144 with SMTP id d9443c01a7336-204df45d558mr22481925ad.25.1724746782748;
        Tue, 27 Aug 2024 01:19:42 -0700 (PDT)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com. [209.85.214.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae7267sm78558705ad.244.2024.08.27.01.19.42
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 01:19:42 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-201fed75b38so131175ad.1
        for <stable@vger.kernel.org>; Tue, 27 Aug 2024 01:19:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhGCUC+nOrS0Ic0orGzRz8yfMoRAZnDDXAUDi4W6bcF2AAcQLqV8hVd46ETo+7W/0x6+JazJU=@vger.kernel.org
X-Received: by 2002:a17:902:e5d2:b0:1f9:bc99:d94a with SMTP id
 d9443c01a7336-204e4c627fdmr1870895ad.5.1724746781507; Tue, 27 Aug 2024
 01:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825232449.25905-1-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <20240825232449.25905-1-laurent.pinchart+renesas@ideasonboard.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 27 Aug 2024 17:19:23 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DDwFTX48EPksjqQ5bdRWUkQn+ZCBUbKid2H1GeZZSzOg@mail.gmail.com>
Message-ID: <CAAFQd5DDwFTX48EPksjqQ5bdRWUkQn+ZCBUbKid2H1GeZZSzOg@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2: Drop minimum allocation requirement of
 2 buffers
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 8:24=E2=80=AFAM Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
>
> When introducing the ability for drivers to indicate the minimum number
> of buffers they require an application to allocate, commit 6662edcd32cc
> ("media: videobuf2: Add min_reqbufs_allocation field to vb2_queue
> structure") also introduced a global minimum of 2 buffers. It turns out
> this breaks the Renesas R-Car VSP test suite, where a test that
> allocates a single buffer fails when two buffers are used.
>
> One may consider debatable whether test suite failures without failures
> in production use cases should be considered as a regression, but
> operation with a single buffer is a valid use case. While full frame
> rate can't be maintained, memory-to-memory devices can still be used
> with a decent efficiency, and requiring applications to allocate
> multiple buffers for single-shot use cases with capture devices would
> just waste memory.
>
> For those reasons, fix the regression by dropping the global minimum of
> buffers. Individual drivers can still set their own minimum.
>
> Fixes: 6662edcd32cc ("media: videobuf2: Add min_reqbufs_allocation field =
to vb2_queue structure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>
> ---
>  drivers/media/common/videobuf2/videobuf2-core.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/me=
dia/common/videobuf2/videobuf2-core.c
> index 500a4e0c84ab..29a8d876e6c2 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -2632,13 +2632,6 @@ int vb2_core_queue_init(struct vb2_queue *q)
>         if (WARN_ON(q->supports_requests && q->min_queued_buffers))
>                 return -EINVAL;
>
> -       /*
> -        * The minimum requirement is 2: one buffer is used
> -        * by the hardware while the other is being processed by userspac=
e.
> -        */
> -       if (q->min_reqbufs_allocation < 2)
> -               q->min_reqbufs_allocation =3D 2;
> -
>         /*
>          * If the driver needs 'min_queued_buffers' in the queue before
>          * calling start_streaming() then the minimum requirement is
>
> base-commit: a043ea54bbb975ca9239c69fd17f430488d33522

Thanks for the patch!

Acked-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz

