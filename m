Return-Path: <stable+bounces-163245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D45B0897B
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 11:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E2B18885CC
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 09:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4C028A1CB;
	Thu, 17 Jul 2025 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8VaZxfN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DA728C022
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745165; cv=none; b=lhBTEG1J0X2H6zqSqFiS52Q7uI5zdcuPBJfRQiH1yefmoWbwj/2c2ChITkalcgQt4tuSxYDwliNkESEbFxaiP/53WbJxoA9EQgKpeGH6iW0VppXUvXSxvcwh9qUpcdox5JX7uwVsTaiR6tRDFO0wmA1GTMUtg/CufXAjSPIgOfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745165; c=relaxed/simple;
	bh=dXeJz3vwBSLIWWCWuP+elspZU7SI9LsUKQsf9/I2RiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFbNgj4IIVmrIMMPgH67mZ9wl3ktSNE/G8/RlxOaVA+0DGkkoKY0lvwyIhPtZ9O5rA5cfTERGJA77h1roOltsoQwO9JOnLN6pWUSw/56Cp7EImrm1AL2QMS8TZkNikB1RsIQLVPoFtnnB2A6PN2+anFYETrX9lwR4E2fvgiVzdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8VaZxfN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752745162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lKvVQQJMq+hy7WZue3QcEAM5iltBaD3HiRA66HLusuo=;
	b=Z8VaZxfNFkV1AGl5or+bB5GffslxDGGKuUH7zV2GdKS9KvDecs0b5BQYxGLvaCSu8ET5Ch
	xOS6udZjE+wuSCEyoXPC/Its47UYN2mZf8EsAnc2eF//+Dh1+qN/yIIQtrQWv/E3DEgjnz
	oDfFCjly88HDmxTNazUwcDorGIUmavA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-96oHEH69M12rXYeNBExiBA-1; Thu, 17 Jul 2025 05:39:21 -0400
X-MC-Unique: 96oHEH69M12rXYeNBExiBA-1
X-Mimecast-MFC-AGG-ID: 96oHEH69M12rXYeNBExiBA_1752745160
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e1aeab456cso87096485a.3
        for <stable@vger.kernel.org>; Thu, 17 Jul 2025 02:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752745160; x=1753349960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKvVQQJMq+hy7WZue3QcEAM5iltBaD3HiRA66HLusuo=;
        b=vpIFAzQ1aNvx1DuUYD3vk89mWFINUGskgGRGtZEhxGiuSa9SCVUZsfmza00Z7rU7Gk
         jZQdcla8BXkQe7geUsWIxxV1A/IbAvFQQYT4WA4vpV4ikSEom7R78U4aemttqfuLj3y1
         0g8nRXR5fsSSsZm5HKWY0ztineSQCwj6qShUsrs1Yse8v4yOI6nwBo0FECJ9SOCdtg90
         JGi1GmgfwfUauZbN64If5+3O8LgVIuxRwjy0nyNbtbkjrU22FsuKzu+Irzhzv41hzbHt
         R2lJcOyPF1C1TTtKSxg6YO+0EKN37ZxZ2bhnlZFTuykYSWeDLcbXdblw9roZc102siGs
         FAxA==
X-Forwarded-Encrypted: i=1; AJvYcCUDBN/JWCjLQvl8qGQjHAilJicZrDiQIP52iK+i+fNSqQT2Vp1fdrLdxOZ0UFa93lFBgmvZ5zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMm+w1RxPLMBeqon8Cc0VD2+tX492orXMb3Ed7eSvAXt26dTgO
	XjMhwphnBOOdERBlZ0vxAdjxzLuaGecx9u24eFLnPfV0DFMzBbrBxLqhEW6tdK/QOxYMM1PmWDU
	X2g5/9IvyWIuyK64ap9MWFyCq0bVtFpZq5jZSMQ7g/+Rr1KCqtO3dEMfMSg==
X-Gm-Gg: ASbGncusn4ZaDqun6Jsp9DdGQnuBpTWJmfPjCcWytw3X0mL9PCmbp/aPD3vGHLt/KG3
	BAUrEgXsF4euymfbKZMbM25ePT5EJgkmYp7tYQDvFVzqRbQ2agvkI6BkN1k3wbUSEYOLVqfBXc7
	EdApDo1GDvPEO2j+0fve5u6uN1miZ3XS1YNr5WOf0juAXAfjJ1lo8gVhiv98RTTJGiy7WLCaorh
	sg5y0mkx7ILX+QS1b+OZ8vTBOfqSVWgSf6m4oeHPiFvBIbOWgzHLHjFyraPi+ecBnGeGFqc4f3q
	VOnKmSheeh5AoX7IUWmHwP4BT0MmmNhyad6wAL3Qb3F+0JfQ2/ahu5hPkbKF0f/4IGLkiZ/1pfN
	33Qmm72djl5S4rp0=
X-Received: by 2002:a05:620a:6542:b0:7e3:4413:e494 with SMTP id af79cd13be357-7e34413e88dmr561234385a.60.1752745160464;
        Thu, 17 Jul 2025 02:39:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLjVGLBAruZTnyYcI3XjIk2LiSOrCmNEhnAfiMWz9ibsQjoRXzWcmxwJLI++dPE/3qhXbt3A==
X-Received: by 2002:a05:620a:6542:b0:7e3:4413:e494 with SMTP id af79cd13be357-7e34413e88dmr561231885a.60.1752745159997;
        Thu, 17 Jul 2025 02:39:19 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e2635b0b2fsm519799085a.0.2025.07.17.02.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 02:39:19 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:39:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/9] vsock/virtio: Validate length in packet header
 before skb_put()
Message-ID: <y6taqbyskzr4k7tetixgkhdo2z2dgrionsor3jriuo4bxlqdfc@fjnq7tig4bik>
References: <20250717090116.11987-1-will@kernel.org>
 <20250717090116.11987-3-will@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250717090116.11987-3-will@kernel.org>

On Thu, Jul 17, 2025 at 10:01:09AM +0100, Will Deacon wrote:
>When receiving a vsock packet in the guest, only the virtqueue buffer
>size is validated prior to virtio_vsock_skb_rx_put(). Unfortunately,
>virtio_vsock_skb_rx_put() uses the length from the packet header as the
>length argument to skb_put(), potentially resulting in SKB overflow if
>the host has gone wonky.
>
>Validate the length as advertised by the packet header before calling
>virtio_vsock_skb_rx_put().
>
>Cc: <stable@vger.kernel.org>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> net/vmw_vsock/virtio_transport.c | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index f0e48e6911fc..eb08a393413d 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -624,8 +624,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 	do {
> 		virtqueue_disable_cb(vq);
> 		for (;;) {
>+			unsigned int len, payload_len;
>+			struct virtio_vsock_hdr *hdr;
> 			struct sk_buff *skb;
>-			unsigned int len;
>
> 			if (!virtio_transport_more_replies(vsock)) {
> 				/* Stop rx until the device processes already
>@@ -642,12 +643,19 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 			vsock->rx_buf_nr--;
>
> 			/* Drop short/long packets */
>-			if (unlikely(len < sizeof(struct virtio_vsock_hdr) ||
>+			if (unlikely(len < sizeof(*hdr) ||
> 				     len > virtio_vsock_skb_len(skb))) {
> 				kfree_skb(skb);
> 				continue;
> 			}
>
>+			hdr = virtio_vsock_hdr(skb);
>+			payload_len = le32_to_cpu(hdr->len);
>+			if (unlikely(payload_len > len - sizeof(*hdr))) {
>+				kfree_skb(skb);
>+				continue;
>+			}
>+
> 			virtio_vsock_skb_rx_put(skb);
> 			virtio_transport_deliver_tap_pkt(skb);
> 			virtio_transport_recv_pkt(&virtio_transport, skb);
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>


