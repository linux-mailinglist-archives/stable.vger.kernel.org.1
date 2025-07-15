Return-Path: <stable+bounces-161954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D69BB056FE
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 11:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B778D189076E
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 09:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB929238C06;
	Tue, 15 Jul 2025 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkUYhLk0"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7433922DFB5
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572848; cv=none; b=De60XKEBlv567nZk5RbLPBKqqAWrJeORPCfnZnuA3+heDf+wSyrKn9qnv4g5sb9WsY9ytYDhu2um3cqWcTSSNaRocsG8q7btuufwI8T7dJK5bWVR3LW4vxTqcVKZ+aHrjeA36tsl4ZKpqYJaf6SsExzBsg1fokEf6HjKj2u54xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572848; c=relaxed/simple;
	bh=9lxLx87i+PuaUy4b5HDvysuGPPM11GdUfv0DuiWleUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjPCNPpDyIzwlmYYBrDWmEGaVM2Fjl62xIo3hCPfdMAoJTwpSJp62KR1tRI45NySY5TXGgD/7oYKbRRpGyEQ5cXaMhVan7bWFFT805vwkFp3bYA446oVPq+SJgnegPmLyT7s8/k+pZwQuBJWIq1x4Fd8r8/1k37NJDsmNFWhU2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NkUYhLk0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752572845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zv21o4YQGbJUN8noeML7Ss7jbQevDPMoV/ulGUv/mjg=;
	b=NkUYhLk0OlQEeb6CcSjMuhMO5nu5lYt1nhkW64xwCNlsKvDf6x4MK8rqFxTcaKq7U56aHf
	s9SCtjS71lO39V4X4Pbb1yY5oSrkRZAA/MFBDN7OMr2MxAZUuKb+4Vt/Hq+beua2H1qJgK
	UjqeqwYPQAgt8da9rUBFVwPjYAqhJe8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-RpCFUlTdNdCTx84hJbZJWQ-1; Tue, 15 Jul 2025 05:47:24 -0400
X-MC-Unique: RpCFUlTdNdCTx84hJbZJWQ-1
X-Mimecast-MFC-AGG-ID: RpCFUlTdNdCTx84hJbZJWQ_1752572843
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-234a102faa3so41600455ad.0
        for <stable@vger.kernel.org>; Tue, 15 Jul 2025 02:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572843; x=1753177643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zv21o4YQGbJUN8noeML7Ss7jbQevDPMoV/ulGUv/mjg=;
        b=oMkY5EEOHUk2wqFpCGAY9BTBVIn17/6krnTwRL8kK3aDQ4fmltoRek3e85fmLyLcTv
         X7NQSx3ZhMlXf7itXcJ5ODgLnJsuZ9Sogb/G3bbLCCism2ZKgfCyMJ6GZimhLcUiB+Vv
         SPZFW3LZySsS4kWwXnHirxwPiZoUyadz8hg4EZ3XJaYs4Tpti89kaqrWy3POuCPDPsuQ
         z/wsomQVL9yFfiztLKD3sk87K6pPaEKJvYjjwN9uHfX5ILidm1nQPfTyPGwmNcDIBkWu
         2S9eQrUOGcmch4XuWLeB4WrFNrWWVLrZK2M6UR/sVseRPZEToDd371NHLwKn8QYoh0ix
         xfcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9fHrRbac+SnMhUxvzbx6oPcq+RbRXcI4Dk8PPHVCbEYKOhpAhlxZzIV8yUgFapqmEVwC/OVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfvkumuMtdSudDkENJ5qql0V46ADqJ1THXkHvC/n9lSQd1k0eZ
	EClMDGI1BGfmXIsn3YQpAW7pbnSLleDZ0V17eVPMtEY6pZdnyOBLxQsfd/VFhNIdstXk8hOY6JL
	lD1JilPkEanouVa4jspeX5HYQqTexBhlF6IRTLWZMkZmGUc6Pzu1pCZUtww==
X-Gm-Gg: ASbGnctnFceiCr2dJWfX7PDCWmniQQetLvF3wqsQjh/IoTEpdh1RtxnjIyYKSUUS9Sq
	p65hUQtTKi+UKy4zfzHt3O6IyDRi1WjHUnF+ktLpZN/Y6fYkh/PvVHI7TCMiMIfOw5d7I2fCN9f
	kWen9+cBI2Of290/eqgjPf1bnjHV/Po4J1oQrNGJwOE9Utsry8S2SmqHETCgP5VtF6zPLkyr4m8
	FnAEAVbS7yrTMPVJ3sSs/4Jmzvhp9PGXifgIm/Sh8rsooF6e6TgxyAJEMS18z8da9RA06b0qZ9S
	NHeKqMWJ/gofV4mfXheqx5GFHYQyyFyRdn33wtag1g==
X-Received: by 2002:a17:903:8c3:b0:235:f45f:ed49 with SMTP id d9443c01a7336-23e1b170830mr31658705ad.33.1752572842979;
        Tue, 15 Jul 2025 02:47:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFw6Q76ji3E4T0X070GuEwtmCWmxMCF8YU2BHFI5N2HYUKvQ3kiM+lmllOTIzW1Yz+SYAp4Q==
X-Received: by 2002:a17:903:8c3:b0:235:f45f:ed49 with SMTP id d9443c01a7336-23e1b170830mr31658265ad.33.1752572842509;
        Tue, 15 Jul 2025 02:47:22 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42b3c3fsm113125655ad.88.2025.07.15.02.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:47:21 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:47:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/9] vhost/vsock: Avoid allocating arbitrarily-sized
 SKBs
Message-ID: <h3zu2fsjvuftgv5gmkluyqipcak47a2koh54idqqfmstos44o5@c4so6ajec72k>
References: <20250714152103.6949-1-will@kernel.org>
 <20250714152103.6949-2-will@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250714152103.6949-2-will@kernel.org>

On Mon, Jul 14, 2025 at 04:20:55PM +0100, Will Deacon wrote:
>vhost_vsock_alloc_skb() returns NULL for packets advertising a length
>larger than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE in the packet header. However,
>this is only checked once the SKB has been allocated and, if the length
>in the packet header is zero, the SKB may not be freed immediately.
>
>Hoist the size check before the SKB allocation so that an iovec larger
>than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + the header size is rejected
>outright. The subsequent check on the length field in the header can
>then simply check that the allocated SKB is indeed large enough to hold
>the packet.
>
>Cc: <stable@vger.kernel.org>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 802153e23073..66a0f060770e 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -344,6 +344,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
> 	len = iov_length(vq->iov, out);
>
>+	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
>+		return NULL;
>+
> 	/* len contains both payload and hdr */
> 	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
> 	if (!skb)
>@@ -367,8 +370,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 		return skb;
>
> 	/* The pkt is too big or the length in the header is invalid */
>-	if (payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
>-	    payload_len + sizeof(*hdr) > len) {
>+	if (payload_len + sizeof(*hdr) > len) {
> 		kfree_skb(skb);
> 		return NULL;
> 	}
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>


