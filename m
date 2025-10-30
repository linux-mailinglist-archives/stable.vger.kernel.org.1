Return-Path: <stable+bounces-191699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 983A5C1EF0D
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 09:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B5A18837C9
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 08:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E03337699;
	Thu, 30 Oct 2025 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCyHLPDf"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F44333436F
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812272; cv=none; b=E4z9sgOWo0plh/Fj8s+b7jP1UuSB4EdQwvbBOhrEqe+JK6qa/iYQcXVk4jKNuHU21gG20y7lj5xEJNJCOp2/g19iqB20V7J9LpksKpNXq9uEciadwzTDh7Ku9dndRXSZ8lsKf+psRbQO0jY9xluvdhuofCc/xJgGyZZjJWWnEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812272; c=relaxed/simple;
	bh=ck1HslZ0kp7J+WUPymd8AWip7MysypRZtLhSaaOAht4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+7i6F7kIME3hzsQqz4ieesKYBzMyVCiAvBWEdpvAdi4ezzqozA8J0CHznHMwL7WcEbHtR7hLMO34g1IR0zZRZ/hkXySPgWuhkz04IjgJSF37qQAqt4AWyXohR78Etdqibaqx/qJllIzqJ4/DTqTqYRATMRxlXMkUu9ZI16Sgls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bCyHLPDf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761812269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62lhztl4PsEx1t/ejtRJFKI6a/pEqBnCixqR/6fg7Gg=;
	b=bCyHLPDfKv7g/b8xvvj/ZiR4JFO6/pqfQ+icQubrr9NjC5+drNLokZnulFrN6fJyBU/Byw
	5kaAb/68+TWv2M2GYEjLuCyjxQydU+gGcDOLtiSp3IpE7PPzCKR69N5MoqCUZzYUYyIPjC
	Z9Zchj1R3ps+DzOiGVA0jGZSPluP/X8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-N-rebLRKPwesZsumngG2rg-1; Thu, 30 Oct 2025 04:17:47 -0400
X-MC-Unique: N-rebLRKPwesZsumngG2rg-1
X-Mimecast-MFC-AGG-ID: N-rebLRKPwesZsumngG2rg_1761812266
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42855d6875fso428817f8f.3
        for <stable@vger.kernel.org>; Thu, 30 Oct 2025 01:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761812266; x=1762417066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62lhztl4PsEx1t/ejtRJFKI6a/pEqBnCixqR/6fg7Gg=;
        b=wvTvy3bsD+tM/nWi++Y39ssaiM1wsE9RjYOQVlvaZrQlTOan66l7gl7drnv8uVDt8c
         OjYCQG85lk6F/wVoAEEk1+dQO4WE3Iu3clJxjMVZ1P/xFKPeaelX9jFZEsrBkYGaf28W
         jZKJXaD31KLNYDrtAbh2HlkG1Vqg4Oi5faF5lJ6rGr5ofFO8PDnLiAM2T8tNH5rTqZtf
         Wx08ZAthIqmlxpzZIwS22jnHZvuQ2xY886DATay+yRpa1dAZqhRvvH+ZOgY9YwCbwfPs
         mu9DxA5iAB08CswPB0G63iNErIifus5gVL6kX8GaGb2urcYUQX2BkYKVVDi1zJaLSPv8
         3ONA==
X-Forwarded-Encrypted: i=1; AJvYcCW7ajvGHEqWyDT/c2r/l7ZLZj6Rhrt5QAddATIVPNVwEard8ICbUFAe6z5BGMsGYmBlgsfTilc=@vger.kernel.org
X-Gm-Message-State: AOJu0YynlEOsLPCuYGWT1AV7qnECS5oyOy18TnBSncd2ZKUo1HGdwfuW
	Rg1pdNqQ8GQADD87lQ9v90qma/3iPI7acZxTJm1omP51uhA32TVaZwGXjuk+VUzVCVGFff+WSbZ
	2DyiWwtCUrAsLceSg+pHZOfkzSL+3PVTTm284tVFAUN4huIwS/2Ugkk/QeA==
X-Gm-Gg: ASbGncuj9B6d0oGyuPBRcpH+VNbfTjxMiZhEDGYIVZNAymYGrJ8SQM7mc/3cWqFh8WB
	HVotKHXkdhpZDE503n2S8xS4d29csrGc5JR92fPF1NzxCR6BsfogQUKaRDmulctU6HIhKlxwFvU
	6M2yuICIJre0AUdB6PRDwWB6nV5yRtxya4PlhmnsWDPKkGH4VRPZjI+p5RfjGxaOw1d9JvYXEwe
	hWh6VmEWPfT5Jja7Fps6owocIdSI+VnXGsTqSSZpgMACPBuYC6ITclbagcKg1U4mRrIrIFrjkWJ
	XupUCev//LqHQQjLWWRFDzYgemzNXW9m2n/ncauioZQyiiQUOKKjRR+pdafP/kLJ+fZh
X-Received: by 2002:a05:6000:240c:b0:429:8a40:e995 with SMTP id ffacd0b85a97d-429b4ca2efemr2051331f8f.61.1761812266304;
        Thu, 30 Oct 2025 01:17:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCC3j3pkeyjV7zwh2zWVtG7xi2X9bxfuD0Q0xhE4+gU6d0C0xhwka/NPYq7UvjEnPJvnZ1gw==
X-Received: by 2002:a05:6000:240c:b0:429:8a40:e995 with SMTP id ffacd0b85a97d-429b4ca2efemr2051295f8f.61.1761812265790;
        Thu, 30 Oct 2025 01:17:45 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:9d00:de90:c0da:d265:6f70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df473sm30541624f8f.42.2025.10.30.01.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:17:45 -0700 (PDT)
Date: Thu, 30 Oct 2025 04:17:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] virtio_net: fix alignment for virtio_net_hdr_v1_hash
Message-ID: <20251030041636-mutt-send-email-mst@kernel.org>
References: <20251029012434.75576-1-jasowang@redhat.com>
 <d0f1f8f5-8edf-4409-a3ee-376828f85618@redhat.com>
 <CACGkMEsTd6uCOCre8HK=5G14zu+xVOPOORZ2xcV_n9Kg6w8F5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsTd6uCOCre8HK=5G14zu+xVOPOORZ2xcV_n9Kg6w8F5Q@mail.gmail.com>

On Thu, Oct 30, 2025 at 10:40:13AM +0800, Jason Wang wrote:
> On Wed, Oct 29, 2025 at 4:20 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On 10/29/25 2:24 AM, Jason Wang wrote:
> > > From: "Michael S. Tsirkin" <mst@redhat.com>
> > >
> > > Changing alignment of header would mean it's no longer safe to cast a
> > > 2 byte aligned pointer between formats. Use two 16 bit fields to make
> > > it 2 byte aligned as previously.
> > >
> > > This fixes the performance regression since
> > > commit ("virtio_net: enable gso over UDP tunnel support.") as it uses
> > > virtio_net_hdr_v1_hash_tunnel which embeds
> > > virtio_net_hdr_v1_hash. Pktgen in guest + XDP_DROP on TAP + vhost_net
> > > shows the TX PPS is recovered from 2.4Mpps to 4.45Mpps.
> > >
> > > Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > Whoops, I replied to the older thread before reading this one.
> >
> > Acked-by: Paolo Abeni <pabeni@redhat.com>
> 
> I apologize, build will be broken since
> 
> commit b2284768c6b32aa224ca7d0ef0741beb434f03aa
> Author: Jason Wang <jasowang@redhat.com>
> Date:   Wed Oct 22 11:44:21 2025 +0800
> 
>     virtio-net: zero unused hash fields
> 
> I will prepare a new version.
> 
> Btw, it looks like there's an uAPI change that may break builds of the
> userspace:

No, I think this has not been out long enough to matter.
QEMU imports linux headers extremely quickly but it can adapt.


> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
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
> 
> We can have a kernel only version for this but it probably means we
> need a kernel only version for all the future extension of vnet
> header?
> 
> Thanks
> 

Let's not complicate things too much please.

-- 
MST


