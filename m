Return-Path: <stable+bounces-45463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4B08CA1F8
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 20:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFCA1F22199
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 18:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B791384BE;
	Mon, 20 May 2024 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O1P5SsLy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B3D137C3F
	for <stable@vger.kernel.org>; Mon, 20 May 2024 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716229502; cv=none; b=QnLdKFDpjEQasx4vcV4tgoX4+H0X2Rv8JIPm5PibSVJWvsSO3isd1v9h+lDwmX+lbk/0uv9uK9FN0BifZWhi+mncFrceyXTsfdAOCc19QBTW0OC/bsdTe7xtHdKnKOvzBOjH7r1aGAkzKiLifmLy6iFJrZCgipayjG2/PfOWpgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716229502; c=relaxed/simple;
	bh=dDm79kFjTMDwIZyPH0s80xpUacie3sx5J6V+kXbGlEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mD7BVZtQioxqKf4wW5+SxoSMAWjVPyGs3ANLORGvN80x0+sgbHiDzWJwK8mcwp9R/g8cCsIpnscf6kavHfaCXjUfMXESOfdWtd0WziMPZea5ILI8v2AJjLlmFxH+Z55ZmSIT6a5+YuOHgEiC4oY7bAqAHFXwklUObqS71qUU2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O1P5SsLy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-354cd8da8b9so180555f8f.0
        for <stable@vger.kernel.org>; Mon, 20 May 2024 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716229498; x=1716834298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdzEvfu1PEpJBwHmOIv154V3jtL1pSQeI6RYwYyKYZk=;
        b=O1P5SsLymRYGLPFOcjsjAoXv1AyUYOanpGavuKQdgbB5XRlKjs2LOhw6sOBKDNUpRb
         QMObBMZUpOq6QV5adlV3ByK4g6y5bPzMW5Wp6KgOhgGy3vb/z21CjjCq7H2Na3FrpN6c
         06FLyVsMGjzMchlnY/wa/vfsMyqs9USGCJtyo7ygYImJenbLFDsdYDc11PoGAvErFIxy
         mF4MxRas+83zfZt3uJ1SDgq8GfTYVw5y6RqFzoTfrTAGSUaq5Cw49PHhFXycICb5xuqg
         VM46Xa5cagy6ZYrJlOGvL/9KpcQn3QxzuYsfngiXn2Cb+8VpGR5F0imwFXVaMUWSjxoi
         gGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716229498; x=1716834298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdzEvfu1PEpJBwHmOIv154V3jtL1pSQeI6RYwYyKYZk=;
        b=wkqalbHkLZW/c7bLdOkAxKVbmICqzjWTcWTf8uIRkzAAAAk3UHtfOGYqqGEPskz6Sm
         /fRzL+ukVv392MU1c+makLWdDo0//Q1HcafHL7+lyMOgrfchWUNcvyeSWPJOGTOw0q90
         gnPpEzp3j2nryPkNUR5lFK34JecTTefGkxVDV2nxM1BwlWVccS+vZtC+lA/Hrwk+S1nT
         WXy2jIoaUrDbUqefBqJBksiPW4qvNWJ/J1CCiey0vGNwF9lACqix0J7UpVplnOcDvEUY
         gAo/dHJtf/uPL+tYNDu1i6pqClzrm+8JrkXdXV/WEBJCktaIGyNFL/uIajLOqnOgmOJU
         sATg==
X-Forwarded-Encrypted: i=1; AJvYcCVRtFI7/vGw3JIWrnxrhpSXF/N9LfSuPjEDFChKEDPLdsnheX8XeecSuI0QyeogE7TNqCPOTxjcsnJgIfqUF5txbktIH3MZ
X-Gm-Message-State: AOJu0Yz0sSI8rSjaNTzqVNhXhzU4nSpY7xFFdVcImqowJYWriGYxQlBV
	Iyhp066HavAUCNVV/tprAk8GL7lIGg5TehJxyFJmR2BahEpgQmbaVUf8VYYwB7nX/Kjees6s5Mj
	xlsHJmZ4VLkQ+7fB3LSRdh2Uus2+oNLQJhR0P
X-Google-Smtp-Source: AGHT+IHip0D1CwulZkUqzgTRHd4h9KDYjqLHoifTqfHumIM8JPr9kA/cIoKnvUx1OIyjr1GSqMOBTklaXEOXcjT5FEw=
X-Received: by 2002:a05:6000:1a8d:b0:351:b882:4e2b with SMTP id
 ffacd0b85a97d-351b8824ef3mr21104096f8f.63.1716229497450; Mon, 20 May 2024
 11:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520090106.2898681-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240520090106.2898681-1-hsiangkao@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Mon, 20 May 2024 11:24:44 -0700
Message-ID: <CAB=BE-Qr5mukXPPqqduH2Rr3cBrkP_WUiJ1udhtfmmrHFmObcQ@mail.gmail.com>
Subject: Re: [PATCH] erofs: avoid allocating DEFLATE streams before mounting
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 2:06=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Currently, each DEFLATE stream takes one 32 KiB permanent internal
> window buffer even if there is no running instance which uses DEFLATE
> algorithm.
>
> It's unexpected and wasteful on embedded devices with limited resources
> and servers with hundreds of CPU cores if DEFLATE is enabled but unused.
>
> Fixes: ffa09b3bd024 ("erofs: DEFLATE compression support")
> Cc: <stable@vger.kernel.org> # 6.6+
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

LGTM.

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.

> ---
>  fs/erofs/decompressor_deflate.c | 55 +++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 26 deletions(-)
>
> diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_defl=
ate.c
> index 81e65c453ef0..3a3461561a3c 100644
> --- a/fs/erofs/decompressor_deflate.c
> +++ b/fs/erofs/decompressor_deflate.c
> @@ -46,39 +46,15 @@ int __init z_erofs_deflate_init(void)
>         /* by default, use # of possible CPUs instead */
>         if (!z_erofs_deflate_nstrms)
>                 z_erofs_deflate_nstrms =3D num_possible_cpus();
> -
> -       for (; z_erofs_deflate_avail_strms < z_erofs_deflate_nstrms;
> -            ++z_erofs_deflate_avail_strms) {
> -               struct z_erofs_deflate *strm;
> -
> -               strm =3D kzalloc(sizeof(*strm), GFP_KERNEL);
> -               if (!strm)
> -                       goto out_failed;
> -
> -               /* XXX: in-kernel zlib cannot shrink windowbits currently=
 */
> -               strm->z.workspace =3D vmalloc(zlib_inflate_workspacesize(=
));
> -               if (!strm->z.workspace) {
> -                       kfree(strm);
> -                       goto out_failed;
> -               }
> -
> -               spin_lock(&z_erofs_deflate_lock);
> -               strm->next =3D z_erofs_deflate_head;
> -               z_erofs_deflate_head =3D strm;
> -               spin_unlock(&z_erofs_deflate_lock);
> -       }
>         return 0;
> -
> -out_failed:
> -       erofs_err(NULL, "failed to allocate zlib workspace");
> -       z_erofs_deflate_exit();
> -       return -ENOMEM;
>  }
>
>  int z_erofs_load_deflate_config(struct super_block *sb,
>                         struct erofs_super_block *dsb, void *data, int si=
ze)
>  {
>         struct z_erofs_deflate_cfgs *dfl =3D data;
> +       static DEFINE_MUTEX(deflate_resize_mutex);
> +       static bool inited;
>
>         if (!dfl || size < sizeof(struct z_erofs_deflate_cfgs)) {
>                 erofs_err(sb, "invalid deflate cfgs, size=3D%u", size);
> @@ -89,9 +65,36 @@ int z_erofs_load_deflate_config(struct super_block *sb=
,
>                 erofs_err(sb, "unsupported windowbits %u", dfl->windowbit=
s);
>                 return -EOPNOTSUPP;
>         }
> +       mutex_lock(&deflate_resize_mutex);
> +       if (!inited) {
> +               for (; z_erofs_deflate_avail_strms < z_erofs_deflate_nstr=
ms;
> +                    ++z_erofs_deflate_avail_strms) {
> +                       struct z_erofs_deflate *strm;
> +
> +                       strm =3D kzalloc(sizeof(*strm), GFP_KERNEL);
> +                       if (!strm)
> +                               goto failed;
> +                       /* XXX: in-kernel zlib cannot customize windowbit=
s */
> +                       strm->z.workspace =3D vmalloc(zlib_inflate_worksp=
acesize());
> +                       if (!strm->z.workspace) {
> +                               kfree(strm);
> +                               goto failed;
> +                       }
>
> +                       spin_lock(&z_erofs_deflate_lock);
> +                       strm->next =3D z_erofs_deflate_head;
> +                       z_erofs_deflate_head =3D strm;
> +                       spin_unlock(&z_erofs_deflate_lock);
> +               }
> +               inited =3D true;
> +       }
> +       mutex_unlock(&deflate_resize_mutex);
>         erofs_info(sb, "EXPERIMENTAL DEFLATE feature in use. Use at your =
own risk!");
>         return 0;
> +failed:
> +       mutex_unlock(&deflate_resize_mutex);
> +       z_erofs_deflate_exit();
> +       return -ENOMEM;
>  }
>
>  int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
> --
> 2.39.3
>

