Return-Path: <stable+bounces-192430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6168CC32565
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 18:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303F818C12BF
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 17:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B539A334363;
	Tue,  4 Nov 2025 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDh4omAh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiUvoRHC"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916D423AE62
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276933; cv=none; b=TvQoQCDzldyP/IWuGIPGOhFf0qF+tm5cv2NT0g/wEuf/g5fmnASGJaojjSyEIW9p2lMAbBfXgp0ZqM04qZZtmC7Gy2ZGaDpePL05y/KWy9JuUxWpadPZ8cK54CTY5Yd7RhQeOlSCn6DCUiBRQSi1qdTOtilPo0APajPo0slyi8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276933; c=relaxed/simple;
	bh=RN85k6AHL2pQ5CqZYH41YO/5F+DbetbZxo60cWxsByA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXApkGVwhsNJ0ippXQgMqKwj+VMjWDi1ZG4nEr8lR1YZHLInJCO9Oj8ywDu2YEdy0pUc1FGYVhUeQpamFzqnvurYwuK9k7RmIb29RgVY/imAaCIgYELZyXfJfPcg1itF6mPrNLv/0irhea+USNntxEDgg7BU2ZSHElPvqetkwbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDh4omAh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GiUvoRHC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762276930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXDflPqYnW7EZU/LpvY0qXtFQSuEG8JnIwAlz6RqROg=;
	b=bDh4omAhIT2QQRnVQP8OWq3ud31C1hox/xcSWnCEYAcQV7Cs6A/N13NXEqoU6yvzBoSqIW
	LEfYXwHmLMmdOT30Waw26EqWj+awYstZMT5ZzNp2f74qiC6lkurIhJPv/yfNk6VKdTTRf2
	RySQlf+kHHxbkVDT4/iY0yiEaZMLc/8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-p_HDgFYmMiO9c0SRykbf2g-1; Tue, 04 Nov 2025 12:22:09 -0500
X-MC-Unique: p_HDgFYmMiO9c0SRykbf2g-1
X-Mimecast-MFC-AGG-ID: p_HDgFYmMiO9c0SRykbf2g_1762276928
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b4813c6cbeeso540012866b.3
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 09:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762276928; x=1762881728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXDflPqYnW7EZU/LpvY0qXtFQSuEG8JnIwAlz6RqROg=;
        b=GiUvoRHC8afr/zm8vjTDvcuc/OQT30EV921gX48bxlt7xRVABCzalh4tayiN58E36U
         EVg45xWfTs0MRaXmxnGzKIrj+IBbjNxW0TWOHS7Zzd4riCjIvUegXE6o4R9eSC0E93j1
         U0XcAs/hZeetRbMPXr7jBNY6fOmxeOd6iXIjbA4ETtkds/9PVwqKi//xoovH94kraoXR
         JXjpbIuGwbtpum74rQwYQ7Ruv52ox3GqnMpzIXeqee99OI4RcPVTE0k3864HuZf15ANm
         XBInL8qivKepvpq9mC3I38Go49LwKL3O5giiyN2wSjpNamJi9i2vqGF8sYkGX8enqD9f
         KcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762276928; x=1762881728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXDflPqYnW7EZU/LpvY0qXtFQSuEG8JnIwAlz6RqROg=;
        b=F93DZhDBE+6Kfl55sge6v1qamo/6V/JslNT5NMfFsyozyHBNDA5qwJ/ljVucmPKCZr
         AjqPGYYYnCv6q+VoPIh786ICpeq1Y4ZR87li7KKBFWM45veuB92k01ocWXVgKL17Y6kv
         +C0rc1lYguCUohhNvFDQHIWEO++dcTeeiF3NKPTBxbdmzqRkhrvO8I7Vi5m/bwomnGYn
         Uj/fdOtbByxEuG81I6h1B1nErB8dpzT0WDNDSAfUGmq3iLDT2oTozBjpMaCkYr698Frc
         pEhifrcTG7/vw4sWom/ZZBAF3jL3Hl5QGWn7MbojE6WV6sh6I7/NsS0eARMwJ61nTs1L
         6yOw==
X-Forwarded-Encrypted: i=1; AJvYcCXtEEE7D9/y4YlBDTuKkOsbdCRWYYo5wDNALxUoG93ke4/mO+a+1ZoCW5o9vQ9TU2x9Cs4xGKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrygxkj1JI8xjIPq/211H6pWIDjTbM9J0mqaIrqFsRXiWthLie
	ojq6JIxK5YahJSMnZS2nvs1+LrHDrFUp/FcgHGhzVP7bbwVMBb2Ilu4xMwrm0dUVUj0No0AdSVk
	SJEtoFQm9m1mcbGN0RnY6H+8RRMgOmEtizWa5CnvWSDiMefxvBDGc0c+po2CkbflSY4BlHkPAR0
	QOC2a1rtjlgvcV6Mw8sq69exvw9WqNY2bX
X-Gm-Gg: ASbGncv5QrA8Yw7oQ4cb8R8X8xAerUD/03QzXO/E+sKPD1aZhLhIFvhw8e+7Ghfq/xo
	H2phq+PM7IWa1NM88hXO6tpFJ3fqn7mcniiD6XjqagDW9qW/ZXd+MJegJoSHtaUS47VRSLOSyq/
	AeI8UA0PlR3Sm4VM1Td3Qb8YIT8+Ym9ncjaYNRhfOm/l25xsSfiiIpqmXn
X-Received: by 2002:a17:906:dc92:b0:b71:88eb:e60c with SMTP id a640c23a62f3a-b7188ebf492mr614834866b.44.1762276928043;
        Tue, 04 Nov 2025 09:22:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmS15xkBQlo46WUljLA50Fixrdz+Xfp9YJOuOn440rslgPxVsSs5bO8JGYSwoCQVGwl9vZDe3sCRPYTRWVVjg=
X-Received: by 2002:a17:906:dc92:b0:b71:88eb:e60c with SMTP id
 a640c23a62f3a-b7188ebf492mr614831566b.44.1762276927657; Tue, 04 Nov 2025
 09:22:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031060551.126-1-jasowang@redhat.com>
In-Reply-To: <20251031060551.126-1-jasowang@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 5 Nov 2025 01:21:29 +0800
X-Gm-Features: AWmQ_bmCsEsZ54yScl_2yysAyvg-JGUKJB9xsSDFcnkTf1mDrO5lo_hg0ahm2LQ
Message-ID: <CAPpAL=ybrp2kBCLivWpX_0NpV7tiCS26o6tzeDea6RWsAkS2Hg@mail.gmail.com>
Subject: Re: [PATCH net V2] virtio_net: fix alignment for virtio_net_hdr_v1_hash
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Fri, Oct 31, 2025 at 2:06=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> From: "Michael S. Tsirkin" <mst@redhat.com>
>
> Changing alignment of header would mean it's no longer safe to cast a
> 2 byte aligned pointer between formats. Use two 16 bit fields to make
> it 2 byte aligned as previously.
>
> This fixes the performance regression since
> commit ("virtio_net: enable gso over UDP tunnel support.") as it uses
> virtio_net_hdr_v1_hash_tunnel which embeds
> virtio_net_hdr_v1_hash. Pktgen in guest + XDP_DROP on TAP + vhost_net
> shows the TX PPS is recovered from 2.4Mpps to 4.45Mpps.
>
> Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes since V1:
> - Fix build issues of virtio_net_hdr_tnl_from_skb()
> ---
>  drivers/net/virtio_net.c        | 15 +++++++++++++--
>  include/linux/virtio_net.h      |  3 ++-
>  include/uapi/linux/virtio_net.h |  3 ++-
>  3 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e8a179aaa49..e6e650bc3bc3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2539,6 +2539,13 @@ static struct sk_buff *receive_mergeable(struct ne=
t_device *dev,
>         return NULL;
>  }
>
> +static inline u32
> +virtio_net_hash_value(const struct virtio_net_hdr_v1_hash *hdr_hash)
> +{
> +       return __le16_to_cpu(hdr_hash->hash_value_lo) |
> +               (__le16_to_cpu(hdr_hash->hash_value_hi) << 16);
> +}
> +
>  static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr=
_hash,
>                                 struct sk_buff *skb)
>  {
> @@ -2565,7 +2572,7 @@ static void virtio_skb_set_hash(const struct virtio=
_net_hdr_v1_hash *hdr_hash,
>         default:
>                 rss_hash_type =3D PKT_HASH_TYPE_NONE;
>         }
> -       skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_t=
ype);
> +       skb_set_hash(skb, virtio_net_hash_value(hdr_hash), rss_hash_type)=
;
>  }
>
>  static void virtnet_receive_done(struct virtnet_info *vi, struct receive=
_queue *rq,
> @@ -3311,6 +3318,10 @@ static int xmit_skb(struct send_queue *sq, struct =
sk_buff *skb, bool orphan)
>
>         pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
>
> +       /* Make sure it's safe to cast between formats */
> +       BUILD_BUG_ON(__alignof__(*hdr) !=3D __alignof__(hdr->hash_hdr));
> +       BUILD_BUG_ON(__alignof__(*hdr) !=3D __alignof__(hdr->hash_hdr.hdr=
));
> +
>         can_push =3D vi->any_header_sg &&
>                 !((unsigned long)skb->data & (__alignof__(*hdr) - 1)) &&
>                 !skb_header_cloned(skb) && skb_headroom(skb) >=3D hdr_len=
;
> @@ -6750,7 +6761,7 @@ static int virtnet_xdp_rx_hash(const struct xdp_md =
*_ctx, u32 *hash,
>                 hash_report =3D VIRTIO_NET_HASH_REPORT_NONE;
>
>         *rss_type =3D virtnet_xdp_rss_type[hash_report];
> -       *hash =3D __le32_to_cpu(hdr_hash->hash_value);
> +       *hash =3D virtio_net_hash_value(hdr_hash);
>         return 0;
>  }
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 4d1780848d0e..b673c31569f3 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -401,7 +401,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb=
,
>         if (!tnl_hdr_negotiated)
>                 return -EINVAL;
>
> -        vhdr->hash_hdr.hash_value =3D 0;
> +       vhdr->hash_hdr.hash_value_lo =3D 0;
> +       vhdr->hash_hdr.hash_value_hi =3D 0;
>          vhdr->hash_hdr.hash_report =3D 0;
>          vhdr->hash_hdr.padding =3D 0;
>
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_=
net.h
> index 8bf27ab8bcb4..1db45b01532b 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -193,7 +193,8 @@ struct virtio_net_hdr_v1 {
>
>  struct virtio_net_hdr_v1_hash {
>         struct virtio_net_hdr_v1 hdr;
> -       __le32 hash_value;
> +       __le16 hash_value_lo;
> +       __le16 hash_value_hi;
>  #define VIRTIO_NET_HASH_REPORT_NONE            0
>  #define VIRTIO_NET_HASH_REPORT_IPv4            1
>  #define VIRTIO_NET_HASH_REPORT_TCPv4           2
> --
> 2.31.1
>
>


