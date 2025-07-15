Return-Path: <stable+bounces-161956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973FDB05731
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 11:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADCD27B96AE
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 09:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197882D8778;
	Tue, 15 Jul 2025 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XovK4NJa"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912E2D5406
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573211; cv=none; b=l6qT0BSymJWRAaMBgyeRhW2XyK3e0MYe/HiMj5ITWabOlwVtfkK4G3WJsVp2f02xwKWR8kkxCPTInMa/CqRcnlf2H3CBzAdfHoFJ6gF3vlCNnorCbplAcILJ4UZ7xcp5m3mV7XBT3z942Y0FCbm/Y9TynNRGL9d/HoQ0Ig6b+Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573211; c=relaxed/simple;
	bh=6tGyBJtvc2RtGieTCJUc7+YbV5rIOi+F+HZmZMgrilY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLk4pIbIHRLDUEV9oRgjs9FhTLFh9c+jre6BzIzDF6TmwBtQmWIUagEJavuvMR0KZEM7QkNqHoCvOWbPkl5QhNuW8Wc3j140lK8z3c4/QgybZ6uuMW0MzpWQdLWNzsYiZuxsRKbcUkVBe3hbFJom7kG6Q3qF4BT+fUkrvQ/u7D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XovK4NJa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4iPXF4gYG8U7aUqDfy3cGUXBvmWO/3o2DGgrJboTKas=;
	b=XovK4NJaeftMCw0JXSCt1n7eBBjaLiOy+I8Txv3PjCUBkDuzwfyX/gKjLUR7FsytXfFJrT
	4cPbL/b4seD4k6AImpXGtHsUihYCB/bn3IeCWS075XnNLwE30HzM4zF4zumhmBqUQcfMeQ
	1YrxwmFHj5T2OcFdnHL4UaxtkbYlk4U=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-DuACAgMmP0W_n0gNmVbY6w-1; Tue, 15 Jul 2025 05:53:27 -0400
X-MC-Unique: DuACAgMmP0W_n0gNmVbY6w-1
X-Mimecast-MFC-AGG-ID: DuACAgMmP0W_n0gNmVbY6w_1752573207
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fb5f70b93bso74999786d6.3
        for <stable@vger.kernel.org>; Tue, 15 Jul 2025 02:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573207; x=1753178007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iPXF4gYG8U7aUqDfy3cGUXBvmWO/3o2DGgrJboTKas=;
        b=L76w7hKp2LeqxK4fn856N3uNWZ+3eoB8hTlYwYKwc5KudkVw5fi/3YG1kEk5df1tQQ
         UlzeI8nvv3tWjzYNGqNvRtu0KQ8KYme0LY2PtHzDctW8xxe2Luchkb550xidoOblAJvT
         dC2lHr9z0venR5Wvlm/kp26t8Yj1nExGdY0hmNn/E7gevbUe7jXrRdIyDjqlj45vJ8vJ
         V2qHcBhKOVynSGqcAnrMKmlT8DSCEX0H/oHyMbNqxjgxzmb2wfcBYuSlFQWufn/+nUJi
         RJJklOJcYO2ntV6XEx/O2YrkSAQp+x/1lf7nGjErpaYUQaoH68IOmyr3BE8Vw7WaXxrr
         oXfA==
X-Forwarded-Encrypted: i=1; AJvYcCUg0/5uX12FWkgxAt1da9lxDZ3rI+kNfh1Ff8or1HMKHQbeTcH4fAU+eRX/7uRocFTblJX4eNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtZx92iOzrRL6FEzX921Mc5GzVN9I5xOF7mNBCcJP/zn3GU7du
	lSSK14R/XZ416EGRv1MyEJpjK/EPk9oNqKdG3LyG36ovFoow5BVzQthMisdzylfEzLQ8oPrKsQO
	uBfwp6kp53Z4HfZYuMvtvPoktGulSeJ5RoHFRm8s0gJlaqojZTOg1FDXsKA==
X-Gm-Gg: ASbGncvygca451oT0LSbKHHJcziUiUEKxEZfHO+RvuU32GibRW196NANeWWYqzWC3aW
	N9/aydeqKVppS+5adnqg/KuqGFdsVTdQFzJsxyqhaK8t6qFVuEK05TpE3tlWGTxTDI2YT0CSy3E
	9xXgeozH9kyzrFUY71BNFqvjQ2P1hAJpJqTeKk6hgRvG3eFXbq0Tv8B9oZ4dE0M7hGSR84m6KJY
	RJCHOl2qfzrgju3flTdEqeo/6HW5YSCTD1pVDsJEF1kOrRfAXWw5jyrO0K4ZQM4JqI3rOoy9Gpo
	LSeJQmiTgo+ueX8blq21nfUDYot9VSGXMjdJ4Iswng==
X-Received: by 2002:a05:6214:5c49:b0:6fa:c31a:af20 with SMTP id 6a1803df08f44-704a353d443mr226990156d6.5.1752573207208;
        Tue, 15 Jul 2025 02:53:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWPMdVgtbcgI78Os5fvtMkQsvRVpbE9a1O27Hj85Ywr6W1l9K18b6noTWD3ov2A5GOpnHzCA==
X-Received: by 2002:a05:6214:5c49:b0:6fa:c31a:af20 with SMTP id 6a1803df08f44-704a353d443mr226989786d6.5.1752573206613;
        Tue, 15 Jul 2025 02:53:26 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704aa850c20sm40166476d6.70.2025.07.15.02.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:53:26 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:53:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/9] vsock/virtio: Validate length in packet header
 before skb_put()
Message-ID: <47gzwbsawomsgitmxcyd333k27qlwoail2k7ivwtqczbxuapyf@2gdxmlwlfsk4>
References: <20250714152103.6949-1-will@kernel.org>
 <20250714152103.6949-3-will@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250714152103.6949-3-will@kernel.org>

On Mon, Jul 14, 2025 at 04:20:56PM +0100, Will Deacon wrote:
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
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index f0e48e6911fc..bd2c6aaa1a93 100644
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

pre-existing: in some part we use sizeof(*hdr) in other 
VIRTIO_VSOCK_SKB_HEADROOM, I think we should try to uniform that, but of 
course not for this series!

> 				     len > virtio_vsock_skb_len(skb))) {
> 				kfree_skb(skb);
> 				continue;
> 			}
>
>+			hdr = virtio_vsock_hdr(skb);
>+			payload_len = le32_to_cpu(hdr->len);
>+			if (payload_len > len - sizeof(*hdr)) {

Since this is an hot path, should we use `unlikely`, like in the 
previous check, to instruct the branch predictor?

The rest LGTM!

Thanks,
Stefano

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


