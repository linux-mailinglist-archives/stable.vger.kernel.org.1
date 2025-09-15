Return-Path: <stable+bounces-179640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03A7B5817C
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 18:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5102047A0
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 16:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6D52550D5;
	Mon, 15 Sep 2025 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVZ5gmm9"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CBE2475CE
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952212; cv=none; b=XSinZ/chElVIRZZwp3IIrDxgZ76SU2eIHHltOnIw2zCAyq6bjxG+cDWqsotyK8JDIiyGS2m5i5fw6KVWXXTTbKxwg5YBoHPF1wvcqw7FLvYvc1O3E2ybTWsZz3Lk+OHctbhRQTcGAPrem4MxPxugBRNiPFrq8cLXtp7jycV7tCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952212; c=relaxed/simple;
	bh=BAS0GBMKCDtwydPahpuw2HyfF0E/Y0qQ4Zq/+5p3ac8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKKuZTYo1em/46z+cFU0iLhklzUIc4LSBGDjxR3ni0VPPsqN3G9XcpO7vyFolZxSTrGdrk8Ptjo/398U4acDzc2l0N59NsG2qCoikW0R7zwNfFuIkbj8SJXNUoEymJNRYDNqPYlqLnqVIiuSLGLWmUKl0qFcR2t+K0cvt5enN28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVZ5gmm9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757952210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eMxsZvyoTV3G/hm1yNnpqqa9WqA68QAPsx4b+ZiU9Ys=;
	b=FVZ5gmm9600Jd5Rn5WQ+jC5HpIh/KIoy/u2nEqyUpqX7TdQDJ1gR7vyOMDyQstoz7+MRul
	v0O2ANwNWosumRy/3DhPe3eHwtKZLutHsQALjHX9q+vlTAvV1o3/HobNv5n5GM0vdG0Zwn
	hBSIBekawI8x9/7NBLV+P2r1GixqWO8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-s2qSF69gNgyQrdzfJwWyIg-1; Mon, 15 Sep 2025 12:03:26 -0400
X-MC-Unique: s2qSF69gNgyQrdzfJwWyIg-1
X-Mimecast-MFC-AGG-ID: s2qSF69gNgyQrdzfJwWyIg_1757952205
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b0ccfdab405so231708766b.2
        for <stable@vger.kernel.org>; Mon, 15 Sep 2025 09:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757952205; x=1758557005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMxsZvyoTV3G/hm1yNnpqqa9WqA68QAPsx4b+ZiU9Ys=;
        b=nklWZLqOLGe6bjb1TebioCzUDuWnmxCgNUUqGF9bvAKsDmSZRviK5S9CLMgbFI+YIj
         ZOavjBiJdBmBnOhjzkH85t+Cj4145U9T/hu4gjI11vtZDbFtSgEW5Jyn5EWR8IXv6H/c
         H2c5S3xT70vD8/a+6w6hEKKhLctnEamFeb1p66pcXuT+0f84v6hejvDBHAz2qEoOxpLd
         70kKH/mO6rKfvjDsWu4usxu/k/BQ4WzvnNvZ9qh3EO2tOK8D1kx/u4ZNp1RXsUzdjFlg
         nCna8y/HP5IlEOl30iOCUU8dcNmirjw8qiz1xunW1dpe/3gMSMD+kt0W/XpqPQZxWLsB
         L2wA==
X-Forwarded-Encrypted: i=1; AJvYcCUKRuEYNKGyCViUad4SaLRzIxJu529Co7WaWJIaq0YCLU6mzdf7sqYJK1Eenm1KR2XQY3GA9aU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Otdp+xSVAEcWy5RsdE4ONYJfFS8I3QeTHnZeJKs7dMS8K96h
	+gD42nLqEd6BlQZRqaVBZ0YcSHRLXxv7UGaC85D3dac/4gCOVlaVsw8XC22GXAEbojIqkQ4mzum
	nQvnutzSj0PHu5C089X8UUvcEWOquxzqCSAwwhPs9tAoew326x+hLDozFPw==
X-Gm-Gg: ASbGncuOH3ZrjpEEQST+yirgVg3YwKHJySHP2aJMcaEvoprZhyMGdxhueUWubuq2mey
	ZXHIEvONKoPi3Kk3lNLqoh6FhVDEWHtBgPfk6UA4GsOY71hVZ+EMxupPjk/iqeQVGoBfjM/mUHW
	FrLk0/IRwYIFCMwAI0gcATS55JnNLZZcEXRPL0FUraf0W6gbjSGXxII1qHh9XN1m8VGw/ejrDff
	ZEeLIws93jh0z+F6mTLrSMe3y5P3daM2m4cJa8nvjCEC7OvMZ9tgS5XfPN6Xzj8yxLFnLE8RBfp
	UsaK6FMonWxDQN2xsrXHFZB68faQ
X-Received: by 2002:a17:907:9408:b0:b04:97df:d741 with SMTP id a640c23a62f3a-b07c3867766mr1173785766b.44.1757952205412;
        Mon, 15 Sep 2025 09:03:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMAUdK5dLnmNqeaAzIQ4sLNIVdJ/bLJv6BqI8ieVrFaCmiktbN+iyKUpr58pZivx2Iqu/CNg==
X-Received: by 2002:a17:907:9408:b0:b04:97df:d741 with SMTP id a640c23a62f3a-b07c3867766mr1173783066b.44.1757952204919;
        Mon, 15 Sep 2025 09:03:24 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b2e7a35dsm1001013466b.0.2025.09.15.09.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:03:24 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:03:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>, stable@vger.kernel.org,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jonah Palmer <jonah.palmer@oracle.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v3 1/3] vhost-net: unbreak busy polling
Message-ID: <b93d3101a6c78f17a19bb0f883d72b30f66d1b54.1757952021.git.mst@redhat.com>
References: <cover.1757951612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1757951612.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

From: Jason Wang <jasowang@redhat.com>

Commit 67a873df0c41 ("vhost: basic in order support") pass the number
of used elem to vhost_net_rx_peek_head_len() to make sure it can
signal the used correctly before trying to do busy polling. But it
forgets to clear the count, this would cause the count run out of sync
with handle_rx() and break the busy polling.

Fixing this by passing the pointer of the count and clearing it after
the signaling the used.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 67a873df0c41 ("vhost: basic in order support")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20250915024703.2206-1-jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index c6508fe0d5c8..16e39f3ab956 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1014,7 +1014,7 @@ static int peek_head_len(struct vhost_net_virtqueue *rvq, struct sock *sk)
 }
 
 static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
-				      bool *busyloop_intr, unsigned int count)
+				      bool *busyloop_intr, unsigned int *count)
 {
 	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
 	struct vhost_net_virtqueue *tnvq = &net->vqs[VHOST_NET_VQ_TX];
@@ -1024,7 +1024,8 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
 
 	if (!len && rvq->busyloop_timeout) {
 		/* Flush batched heads first */
-		vhost_net_signal_used(rnvq, count);
+		vhost_net_signal_used(rnvq, *count);
+		*count = 0;
 		/* Both tx vq and rx socket were polled here */
 		vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, true);
 
@@ -1180,7 +1181,7 @@ static void handle_rx(struct vhost_net *net)
 
 	do {
 		sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
-						      &busyloop_intr, count);
+						      &busyloop_intr, &count);
 		if (!sock_len)
 			break;
 		sock_len += sock_hlen;
-- 
MST


