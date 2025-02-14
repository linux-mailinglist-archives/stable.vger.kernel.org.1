Return-Path: <stable+bounces-116461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F285A368A0
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 23:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61040173139
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 22:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C8A1FCCEA;
	Fri, 14 Feb 2025 22:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2zenFJUY"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F3F1FC7FA
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573004; cv=none; b=ANwZIg4jmmbZjd9lnq+Lt6uuu2m3NUgvEVRgC6DHCsqsRyjaqt1eyd3eUFedLAzsZuVATia4NqFp7slmPTpI5+Lyg/5OVGfhgFK1jA6kJpkultAWWxywfdn4znerk/adFcSfBgpthmXk9p+iqeL+hdv0YYfgN2fMO5sAHwzxjT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573004; c=relaxed/simple;
	bh=fG4VEG9vUa1eYYGrVKUHwc8QSjhKAXFfO4zv39sxpVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLs/NLigdS3BxEBsPp3wsWjh74i0zNC0LBTyV8HVjklOqlXgVDmr4ILDHkI54eichP6hEmimUMxpTrAAIDafbx1l+O766j04DN39UnpFO6eXirqDL54JmtvYqsEfun0pkODZYfW/B9IfJ7auRFhfzrtrTEvCLCENVNh0EX1SfPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2zenFJUY; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e66a7e2754so6230566d6.3
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 14:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739573001; x=1740177801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0S7kDMXAD8gZoPUu13HV3B7jZz26znSFfxWBW/aLQ4=;
        b=2zenFJUYgPMbz8pI7ioAxSUXZyiDSkelXq8W2jZmPasG8vfCzP+OkA1Az3kkg7/3qu
         Zso2kj1PgUrDWJJWshxPuvhgS90rk8BueTTC0FyaI/mSRGIVbdnFHLUXrZSDBRLQjKXy
         I6tvx6LwzgmaDperMswSkmYGzOmlvqmicLvpqAJGh9yc4vOevJ2CQDxmXOp5HnDQJ4eg
         eC9D+pPz/SKzKADbrwSDhL3pjyjFBGvz2l5PqQtgEM0Unla1SutIx8Yhr2ORP4O7Cxw9
         UXK8kdGx/zyxwakAH5dHxgWNIT51eSr7HgrGwP7GIFzmvGCLla0Hj6gLMbhwq+Gx2kys
         1VZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739573001; x=1740177801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0S7kDMXAD8gZoPUu13HV3B7jZz26znSFfxWBW/aLQ4=;
        b=AWvP6TKtuFKHnxRV4VLIjjFicStsseEy5YFKC/yd1ZgrJK3Fw1ZJw1bMnPtQYSvy56
         OEGRREEWmE1typOy+0eQnweiHohmtlCWz21lu9I+YxRHDg7P0sz0r6cEB6rXwG+UILEN
         Y/+E2FIXMZt1W7ctS3ncNvYqS5KjOPfNo7yIfkAXol7hhUt2miYC2lVpiWTaLahUpCGX
         nScZQE/wuCcXWZgCtM6CG2KQmzLz6BPf+5LI97Gdyj+MBGIHwNamUJCUxJkJaw1qvVCh
         21DwWUNRCS0FUFeyu33KwXXAUbpeYoq/ZSdVQfZV86vhMNLU6tToCP4+SJ7d0YJp6ndS
         ZxxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5HeVhq48Cwmwq8rZuyYqg28CEZ3r9UOwG9ZCIkKkLsEOYIpnKs8SODp8ouqh9ZqxU+gnoY5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPD/1adDodXVoz59QBVgnXk/jiOekxo9O6DcgAdMnCfwonTdcp
	piuRXbg1HxI7Jig05gTrrkuCA7n4zZ9kLjYPyI3wHDCekqy4gGYqwBlqjuma3elVcLyF6YRywh1
	ePlJcg3+PbRmlvQWVDOzjAbxi6kIyqu2S0SQE
X-Gm-Gg: ASbGnctY77dU9AM+qvEfADc4DxF4bC+ohMNQJSTd7vP7iaZdRWT0uSDbePRG7Abge3g
	aOQYuNomvkd1ZImaAYhZl0wni6XKWXRT/EucpmMQLzNLZs0Xu1XF0IwEP+gWWqAF9Zuubk1Rte/
	Gi9wu4qU2eQrK7/UeFgTJP7qy7VQw=
X-Google-Smtp-Source: AGHT+IHYqfptmmKo8lT6PBWLeXoXId9NyT+ZtdLFcjFAi7Rl22vhTrLDj37vJjqU8TkMj7zaYOm83pLPCt+oQryKieM=
X-Received: by 2002:a05:6214:5019:b0:6e4:3de6:e67a with SMTP id
 6a1803df08f44-6e66cd1a6a1mr15910146d6.30.1739573001346; Fri, 14 Feb 2025
 14:43:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214223829.1195855-1-joshwash@google.com>
In-Reply-To: <20250214223829.1195855-1-joshwash@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Fri, 14 Feb 2025 14:43:10 -0800
X-Gm-Features: AWEUYZki233-dvPVdAXEocTl6XJ7iKCHeu9CVkeYzMPq5AFv9Ux386N4VE9mzTg
Message-ID: <CALuQH+XN5VBc3kMyWCRg8-=01gXWWkYbYEJLvCX==nhqSXxsCA@mail.gmail.com>
Subject: Re: [PATCH] gve: set xdp redirect target only when it is available
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, stable@kernel.org, 
	stable@vger.kernel.org, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>, Shailend Chand <shailend@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

This patch is meant to be destined to the net tree, I forgot to add
the prefix when generating the patch. Please disregard this patch; I
will post a new version soon.

My apologies,
Josh Washington

On Fri, Feb 14, 2025 at 2:38=E2=80=AFPM <joshwash@google.com> wrote:
>
> From: Joshua Washington <joshwash@google.com>
>
> Before this patch the NETDEV_XDP_ACT_NDO_XMIT XDP feature flag is set by
> default as part of driver initialization, and is never cleared. However,
> this flag differs from others in that it is used as an indicator for
> whether the driver is ready to perform the ndo_xdp_xmit operation as
> part of an XDP_REDIRECT. Kernel helpers
> xdp_features_(set|clear)_redirect_target exist to convey this meaning.
>
> This patch ensures that the netdev is only reported as a redirect target
> when XDP queues exist to forward traffic.
>
> Fixes: 39a7f4aa3e4a ("gve: Add XDP REDIRECT support for GQI-QPL format")
> Cc: stable@vger.kernel.org
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Jeroen de Borst <jeroendb@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h      | 10 ++++++++++
>  drivers/net/ethernet/google/gve/gve_main.c |  6 +++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index 8167cc5fb0df..78d2a19593d1 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -1116,6 +1116,16 @@ static inline u32 gve_xdp_tx_start_queue_id(struct=
 gve_priv *priv)
>         return gve_xdp_tx_queue_id(priv, 0);
>  }
>
> +static inline bool gve_supports_xdp_xmit(struct gve_priv *priv)
> +{
> +       switch (priv->queue_format) {
> +       case GVE_GQI_QPL_FORMAT:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
>  /* gqi napi handler defined in gve_main.c */
>  int gve_napi_poll(struct napi_struct *napi, int budget);
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 533e659b15b3..92237fb0b60c 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1903,6 +1903,8 @@ static void gve_turndown(struct gve_priv *priv)
>         /* Stop tx queues */
>         netif_tx_disable(priv->dev);
>
> +       xdp_features_clear_redirect_target(priv->dev);
> +
>         gve_clear_napi_enabled(priv);
>         gve_clear_report_stats(priv);
>
> @@ -1972,6 +1974,9 @@ static void gve_turnup(struct gve_priv *priv)
>                 napi_schedule(&block->napi);
>         }
>
> +       if (priv->num_xdp_queues && gve_supports_xdp_xmit(priv))
> +               xdp_features_set_redirect_target(priv->dev, false);
> +
>         gve_set_napi_enabled(priv);
>  }
>
> @@ -2246,7 +2251,6 @@ static void gve_set_netdev_xdp_features(struct gve_=
priv *priv)
>         if (priv->queue_format =3D=3D GVE_GQI_QPL_FORMAT) {
>                 xdp_features =3D NETDEV_XDP_ACT_BASIC;
>                 xdp_features |=3D NETDEV_XDP_ACT_REDIRECT;
> -               xdp_features |=3D NETDEV_XDP_ACT_NDO_XMIT;
>                 xdp_features |=3D NETDEV_XDP_ACT_XSK_ZEROCOPY;
>         } else {
>                 xdp_features =3D 0;
> --
> 2.48.1.601.g30ceb7b040-goog
>


--=20

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3

