Return-Path: <stable+bounces-191687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67344C1E261
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 03:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB381893E06
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 02:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D5432BF24;
	Thu, 30 Oct 2025 02:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SH5RvpH1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5448D32B9A7
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761792034; cv=none; b=PpkBT1keUrMXB52a1fTGlRa1zWfFTUprNWUEKU4tZ8jlPGJdoALqrIXdnOipwzM1qJxQFqZzSTYQ6bap2kHBEEhIDAnMjYFFdGos8CQe0ICJSML+bU2JC9YU098l7Ju75fwPyI/XR9qJV0EUuwzMFr19je0S4Rq9FVbk2Ou8u24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761792034; c=relaxed/simple;
	bh=dM/PC+xgLDFQa74JGMOEWbPEyQbhx65hYn2Ifshodvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdSSQbZ8157PndF3asKPFNlGIFInP+Ut9EATQKu2YHQKcCOkMRwrjQ6dflUqucLA24qtYEWueO7kj0DMY0Fe2+FAjeZv8BIhH4EHVGt1y2Y/n/Uw5odDKdxHwESET/48Ljrnc0kIX2DQ+FP6vFKjNN77wdbpHqjkccgbX4x/NKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SH5RvpH1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761792030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0s8hKYa9ITmFWQHj91VS7CotRvqtXLR4K9Qz/fibwBY=;
	b=SH5RvpH1a5NPmMjur4nkEBk972zOdX3W9rbddbcCcvqlbkJCv+b0n/ulKaKKIGMF56ncWh
	0ZJs4zV3ALluu2MmkyziPWcphU//Bq7Q3ucw/ZwIHvAjM6x1ZBhpTLckbJcrnFukHMqrAq
	DuOUQdiEHLiCYQHtdLiELht3mSlCheY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-KxZLiqVqMgKvgP2vuUA7rQ-1; Wed, 29 Oct 2025 22:40:28 -0400
X-MC-Unique: KxZLiqVqMgKvgP2vuUA7rQ-1
X-Mimecast-MFC-AGG-ID: KxZLiqVqMgKvgP2vuUA7rQ_1761792028
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-340299e05easo464303a91.0
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 19:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761792028; x=1762396828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0s8hKYa9ITmFWQHj91VS7CotRvqtXLR4K9Qz/fibwBY=;
        b=fnqzYyFfY5l/AwICXFwSkn8mIG65RZHeWyO0SBuj7/tqmcXIvlVcb7TfgXaCARU+Rd
         Ek8PR+jiLZOnm6LEK4JuNux3uT590UJ8Uznt/TvdjXPnggNaKZRk1nmvr3/Pf1p5HAqw
         Xrh9n6H1u2VZMcBhpvOYKjGFteSaey+yhXVDiszei1hJGobBNzFp0HOYEocyHruvHfc7
         fB00yWRDXPq8VlJ39JVD2c1WUzvoN/NOu9zTt9C/Fk0OB9FHG5LXqhyIY+heVkq0NOcg
         V9Nq3Fp1qKmPDkMrbpiZ6fwex9Gnexxve6cQ74yLJ44C6cAi+8dwWxLW79E+KzaU9IR8
         b6DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBYSYj5H8MabGCt5QF61HbzPDqKW9RD4pysqFBp+enF+LGFUWbjwI0UCe8MAoMMPXMl6gaTJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyve3cvoCR4s6J5qKDSQ1rUHgXAYtYjyyQOBRV5FC3yruxSjlYF
	ZQHUXegFKaa9W34qYMaMqr8TJ6xcm7nzUHQzCQyxVH7fVQ8ODMU5KSD0NTmpVr3Of0mmWkGRFFQ
	IFNXTH7vU1YuP9oP8SXrj211HzkFFsxPADYjeaDN0DeQ4gAeEfHj7AyeYPPgFTBvYB8BAzFd9qc
	IHYRPEkbeWSPyRblPznisgx61LD1uUfU7I
X-Gm-Gg: ASbGncuqPc2GmVD2uPlcWcU84RLDzpRXMsZ9F9UQmZy40pcHsznNqvafD5Pq9qXJH4i
	hp0r+4NAVAjp3aDbrgfscTpZYNwhrr7mrpnbBIqI6rG29D2HMHSqHZaCkWank87JTSnuoe7WFSJ
	axv+w0CFSM22BimGr4CYXkwDMujapUazVgFnY37422vHT/I2qNmueno1AJ
X-Received: by 2002:a17:90b:38cb:b0:32d:e07f:3236 with SMTP id 98e67ed59e1d1-3403a2a22a8mr5144783a91.22.1761792027558;
        Wed, 29 Oct 2025 19:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxdZBU+hUTBze+ZZkKwu5UhZkdiKIT5O7KOjW1YBOrYbWd5C2ghkE1vXaxfsDpwDAAagjZ/xZ641rpd3lEA94=
X-Received: by 2002:a17:90b:38cb:b0:32d:e07f:3236 with SMTP id
 98e67ed59e1d1-3403a2a22a8mr5144766a91.22.1761792027079; Wed, 29 Oct 2025
 19:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029012434.75576-1-jasowang@redhat.com> <d0f1f8f5-8edf-4409-a3ee-376828f85618@redhat.com>
In-Reply-To: <d0f1f8f5-8edf-4409-a3ee-376828f85618@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 Oct 2025 10:40:13 +0800
X-Gm-Features: AWmQ_bkmfB-ebhx_3KwfLp1OlCEHIG3UAVOBmcyIQzJgycGoPag4AUi2K5pwkoM
Message-ID: <CACGkMEsTd6uCOCre8HK=5G14zu+xVOPOORZ2xcV_n9Kg6w8F5Q@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: fix alignment for virtio_net_hdr_v1_hash
To: Paolo Abeni <pabeni@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 4:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/29/25 2:24 AM, Jason Wang wrote:
> > From: "Michael S. Tsirkin" <mst@redhat.com>
> >
> > Changing alignment of header would mean it's no longer safe to cast a
> > 2 byte aligned pointer between formats. Use two 16 bit fields to make
> > it 2 byte aligned as previously.
> >
> > This fixes the performance regression since
> > commit ("virtio_net: enable gso over UDP tunnel support.") as it uses
> > virtio_net_hdr_v1_hash_tunnel which embeds
> > virtio_net_hdr_v1_hash. Pktgen in guest + XDP_DROP on TAP + vhost_net
> > shows the TX PPS is recovered from 2.4Mpps to 4.45Mpps.
> >
> > Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Whoops, I replied to the older thread before reading this one.
>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

I apologize, build will be broken since

commit b2284768c6b32aa224ca7d0ef0741beb434f03aa
Author: Jason Wang <jasowang@redhat.com>
Date:   Wed Oct 22 11:44:21 2025 +0800

    virtio-net: zero unused hash fields

I will prepare a new version.

Btw, it looks like there's an uAPI change that may break builds of the
userspace:

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_ne=
t.h
index 8bf27ab8bcb4..1db45b01532b 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -193,7 +193,8 @@ struct virtio_net_hdr_v1 {

 struct virtio_net_hdr_v1_hash {
        struct virtio_net_hdr_v1 hdr;
-       __le32 hash_value;
+       __le16 hash_value_lo;
+       __le16 hash_value_hi;

We can have a kernel only version for this but it probably means we
need a kernel only version for all the future extension of vnet
header?

Thanks

>


