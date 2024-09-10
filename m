Return-Path: <stable+bounces-74112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6C897294D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 08:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB49B1C22214
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 06:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75604175D36;
	Tue, 10 Sep 2024 06:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXDVv/ra"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCAF47A7C
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948756; cv=none; b=K69WYcqbKNdcCH+CmkB0+fG7stqYxKaFVy7sGEyvJ0il/88HKMTtmnBmp+QEWHmBXe8SVNGjxjdUl18psW6bbhftZu90LY5BQd9WpQrwAWNhAadN76iburaPOSDML9GAm/uNSCxGR/3IwUWyVzFLM6gEJGYcPL4Vz80sGwdwgp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948756; c=relaxed/simple;
	bh=KBK4L/Svs+SSSpRYgQ+SdhJybVIfGkMRnwWz/7TOsag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgaFXBHSXCqA104QPdyengqVDXCyNgBHJvVJi0PXYOJY861M1VDIv8TXITNWrSjxc6J72+HkiP7Fj1ahrxLUuDOAipF4XqAC7lkW9WiRE9g+b2VOS1U5FYOH1aNT3wD0qOMvv7AcGd34d/KYw+2SfFSiEd04q7wI2vKqt/gy+aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXDVv/ra; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725948752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLRmJNCG3oc9HHYM4SM+SbDTwZxDhWCFqUUuzaavTuQ=;
	b=VXDVv/rarYfdCqpAlK0zRL5qG2qibohQDM65B5SSA2ry2urmr2osckMwwmZXjgNG3tY+M0
	cl/7d01L5gWvf7g6syChOZ0Bet9W132SO1k5u9XxAXndHESPpuQ6UHgH3xDDr7Unhj1Htl
	Q5+MoJJtWoXRpb7M4PafPywvNCHgeoU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-ttqEXn48NwWX2wj3URMsBg-1; Tue, 10 Sep 2024 02:12:30 -0400
X-MC-Unique: ttqEXn48NwWX2wj3URMsBg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-207332f7c17so4225195ad.2
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 23:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725948749; x=1726553549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLRmJNCG3oc9HHYM4SM+SbDTwZxDhWCFqUUuzaavTuQ=;
        b=vfSEdAePJed9nA3NdNhXHOF63GMwNqzKK2hSDMBPeuDjckpZ4OtvM0eCZ+rd7rBWnv
         YN66pnnKhRGEiUdNg1FEVv4tkrUX5RTwvLhgqG5uStqg7WgHvF5zouRlFP3VcZ4Gpcig
         P62wFbh8F5+ySkkc7kLb9FsfZprnBVVb69g9yXNp9FLLBZo4cJu78pu8UlctEOX+DInR
         /+eVncdHru0DErzhC6KAneDY7XaTkqdWrJ5zdblzbQRDNWjCLP1prY6MIhjHP+XOFLOy
         IiDMGpGNYkpz8XzoT49PwduRJsKRGwaqHq59+JZn0BzSq38/ESFXQgJL6xA2lauJfImA
         l/xw==
X-Forwarded-Encrypted: i=1; AJvYcCU4TSxuVTSMxF6sk1D3RlZSB14EdzLu9rb8y2ErOxTeQ3+TCGrFnmQuHhY3FIB42cOA/nutWeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwDI67LB+NBKhCN+qifHhARJM9sN22FuIB33JBAtym8KXufLIZ
	UR5F5T7Un+iQx0pCTaRSh8UQQfbTRcLMZKPyJjJxMCuFBPBm4GAOEc3TPNfOmdn3ml3dV2trK78
	/RVDdnwA29XgNSfICpvMzKo6IPLeQ3+VCwPbn7NhGKsNbqYAB7iSdFTm/hFtrkWVBiIRRGDJNHt
	726w6Eu9zpsnjVCYlYqVdqcz0jULgK
X-Received: by 2002:a17:903:22c4:b0:201:f1eb:bf98 with SMTP id d9443c01a7336-206f06242bfmr144283345ad.54.1725948749219;
        Mon, 09 Sep 2024 23:12:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl+BiaiPeOGgofe6xERlFpVXbjr7TyIBQ07MZxsXja5EigdLjujvtFMy8RjnNFUh4NnpA+tYEXbWa61qRuq68=
X-Received: by 2002:a17:903:22c4:b0:201:f1eb:bf98 with SMTP id
 d9443c01a7336-206f06242bfmr144282885ad.54.1725948748730; Mon, 09 Sep 2024
 23:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910004033.530313-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20240910004033.530313-1-willemdebruijn.kernel@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Sep 2024 14:12:17 +0800
Message-ID: <CACGkMEsnPmbo8t6PbD8YsgKrZWHXG=Rz8ZwTDBJkSbmyzkNGSA@mail.gmail.com>
Subject: Re: [PATCH net] net: tighten bad gso csum offset check in virtio_net_hdr
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, stable@vger.kernel.org, 
	nsz@port70.net, mst@redhat.com, yury.khrustalev@arm.com, broonie@kernel.org, 
	sudeep.holla@arm.com, Willem de Bruijn <willemb@google.com>, stable@vger.kernel.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 8:40=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> The referenced commit drops bad input, but has false positives.
> Tighten the check to avoid these.
>
> The check detects illegal checksum offload requests, which produce
> csum_start/csum_off beyond end of packet after segmentation.
>
> But it is based on two incorrect assumptions:
>
> 1. virtio_net_hdr_to_skb with VIRTIO_NET_HDR_GSO_TCP[46] implies GSO.
> True in callers that inject into the tx path, such as tap.
> But false in callers that inject into rx, like virtio-net.
> Here, the flags indicate GRO, and CHECKSUM_UNNECESSARY or
> CHECKSUM_NONE without VIRTIO_NET_HDR_F_NEEDS_CSUM is normal.
>
> 2. TSO requires checksum offload, i.e., ip_summed =3D=3D CHECKSUM_PARTIAL=
.
> False, as tcp[46]_gso_segment will fix up csum_start and offset for
> all other ip_summed by calling __tcp_v4_send_check.
>
> Because of 2, we can limit the scope of the fix to virtio_net_hdr
> that do try to set these fields, with a bogus value.
>
> Link: https://lore.kernel.org/netdev/20240909094527.GA3048202@port70.net/
> Fixes: 89add40066f9 ("net: drop bad gso csum_start and offset in virtio_n=
et_hdr")
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Cc: <stable@vger.kernel.net>
>
> ---
>
> Verified that the syzbot repro is still caught.
>
> An equivalent alternative would be to move the check for csum_offset
> to where the csum_start check is in segmentation:
>
> -    if (unlikely(skb_checksum_start(skb) !=3D skb_transport_header(skb))=
)
> +    if (unlikely(skb_checksum_start(skb) !=3D skb_transport_header(skb) =
||
> +                 skb->csum_offset !=3D offsetof(struct tcphdr, check)))
>
> Cleaner, but messier stable backport.
>
> We'll need an equivalent patch to this for VIRTIO_NET_HDR_GSO_UDP_L4.
> But that csum_offset test was in a different commit, so different

Not for this patch, but I see this in UDP_L4:

                       if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
                               return -EINVAL;

This seems to forbid VIRTIO_NET_HDR_F_DATA_VALID. I wonder what's the
reason for doing this.

> Fixes tag.
> ---
>  include/linux/virtio_net.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 6c395a2600e8d..276ca543ef44d 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -173,7 +173,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_buf=
f *skb,
>                         break;
>                 case SKB_GSO_TCPV4:
>                 case SKB_GSO_TCPV6:
> -                       if (skb->csum_offset !=3D offsetof(struct tcphdr,=
 check))
> +                       if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&
> +                           skb->csum_offset !=3D offsetof(struct tcphdr,=
 check))
>                                 return -EINVAL;
>                         break;
>                 }
> --
> 2.46.0.598.g6f2099f65c-goog
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


