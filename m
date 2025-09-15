Return-Path: <stable+bounces-179614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AED3BB5789E
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 13:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D1A188C6E7
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 11:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C4E2FFDF8;
	Mon, 15 Sep 2025 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmCzp4G5"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011BC2FE59A
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936293; cv=none; b=U1BlFi3Q7Bh35QVU66qHQ9ZQKgDzxRDNwjB0W2I6wdQLkeurgYZT5LlENVo6QrlOuJE36hQlfnzh8Ee9tolBIHLY99kh3px+o1cRP7n4kqQ4bHLIVWJ6ob07XOZedjcqIuXb746hBul0/3hJyqoYY17UM0NynJocyC4HjhdnLEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936293; c=relaxed/simple;
	bh=DtpYL1MzMO59HaNPliuxasN+81gY5KxCeSX8joTRWjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0mtEWb+CpwGq7n6pYmiaT59iu0NnaLeJqPI1QbvSEWFdNhUncyrovmfPExzhCjOc7tj9mM411xCPFEOeaYrMMDqK3bqhWff/536FNYK5234eovnSzj88c+8lTPui4EycsUeVfgtWu/e1NQun2swfu9Dme1J7ILAZfhtgxtki9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VmCzp4G5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757936289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=39jZ4OPAPIvuhnUtLzb8a5ybFIk25brxp1aIYN08MjM=;
	b=VmCzp4G5p57b9fCYR2V5gYcAZ7UJj6CZduh92eVcj9usZfZTK7at7iDo6hH6kdjSFxNqkd
	QCH21v8TJPIC/qCCwHOb6SlNDLnIuOTArStWiRDA89EGmwLaSlBq2qlM88MzuAk6fNQ5sC
	uYPNe5uu0iDn1Ian5TmrYXbSLWyYVxQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-rotxGCvHNFi_WJo29eXFxA-1; Mon, 15 Sep 2025 07:38:07 -0400
X-MC-Unique: rotxGCvHNFi_WJo29eXFxA-1
X-Mimecast-MFC-AGG-ID: rotxGCvHNFi_WJo29eXFxA_1757936287
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3eae0de749dso484986f8f.3
        for <stable@vger.kernel.org>; Mon, 15 Sep 2025 04:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757936286; x=1758541086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39jZ4OPAPIvuhnUtLzb8a5ybFIk25brxp1aIYN08MjM=;
        b=b5EDg2kruBKyVRgkGhdgkLp6Cj6KEni16DSCTb1vAQI1Yof2Z2fsRWowWsKeUhe0Px
         sDFHAakkNXZSL0SiG0g5sRn8gI70sI0g20rAQr7o/HF0opJNrXB+/XVHOQc+IJLE0hEi
         v6BBnpo/UEcMBO/eZ1u/EFZvCNvH3qb2C35F361ILaTyQBv225Qv2HEjXTWOtejGpzWc
         nOq2fJhicYx5Run7LR8qWSIFxNZtigHUZgD8+SuZVHOHSE5jVyXDqnhA8Xk70szGYLUA
         aF/pG6Fs0l/x2Exy+8R1sox1tWluotGHgBR4U57Ri5Ek5NfnSp+lPFFoU1uPIkcDepiq
         04Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUA26K2RKCRWQ7rT/Bv9/dJRxHGlyp0sPBJ5xuDRUr+WWdDcEkoSBR43nilysAW+hpRcgqilnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaXi0K3BT+K4vnsFmYnR0MwPREyOdQuAAZQgkar2WIH9PUuVxk
	9N4Y2OKpwfpXKCQ7a8JaF/W0sDTBhkoOR0J5mPpybwnii2z1jiANbPH+bH1BJwDSttx6dcHFvP+
	pekktK8z8/jxcEb6duZzf2kG7SwK3FiLmCEcB8/j7WA0Ale4RXV65pMm9FRIHYuC/ag==
X-Gm-Gg: ASbGncvVq+Iyekx1hESWUMvQwTSFfpR32Ad0CbEC6Zyi5YdqMfrrosLtOTnte3gI00p
	Q2O5i5syH1MVJz0ZGfQsw5NUgLGMhWI726kGgHFphDCFw6gHCqyn2zJwFRf35HJoyVtSd/Nd7hg
	X0xDX+DoCXiLlfW4955sDFRSaB3EhcI5c3aMWHYy16HINV+kf6TUB9W+rWNuimojd6pDDEc55du
	eCexcwgAeU0sdQ66It07jQJutpjszYrY4CJDfSAjBAPiKKBhSG9dDFhxcUKUVnCAVs3WpYXEsCI
	ZewsUnO0YvK3LFjeNAHOunPyPjrahvWtzQ==
X-Received: by 2002:a05:6000:4011:b0:3ea:9042:e67e with SMTP id ffacd0b85a97d-3ea9042ed5emr2860200f8f.27.1757936286384;
        Mon, 15 Sep 2025 04:38:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvNoI1D/uJWt4h3s+V0LcUEucReRdXNza2d/QlgTnZdSjXQ7v/FZ9grJzMVk85TQEVfXoE4A==
X-Received: by 2002:a05:6000:4011:b0:3ea:9042:e67e with SMTP id ffacd0b85a97d-3ea9042ed5emr2860172f8f.27.1757936285881;
        Mon, 15 Sep 2025 04:38:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:151b:1100:901d:65fe:87c2:7b22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e8892afc04sm9667404f8f.13.2025.09.15.04.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:38:05 -0700 (PDT)
Date: Mon, 15 Sep 2025 07:38:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org,
	jon@nutanix.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net V2 2/2] vhost-net: correctly flush batched packet
 before enabling notification
Message-ID: <20250915073616-mutt-send-email-mst@kernel.org>
References: <20250915024703.2206-1-jasowang@redhat.com>
 <20250915024703.2206-2-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915024703.2206-2-jasowang@redhat.com>

On Mon, Sep 15, 2025 at 10:47:03AM +0800, Jason Wang wrote:
> Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
> sendmsg") tries to defer the notification enabling by moving the logic
> out of the loop after the vhost_tx_batch() when nothing new is
> spotted. This will bring side effects as the new logic would be reused
> for several other error conditions.
> 
> One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> might return -EAGAIN and exit the loop and see there's still available
> buffers, so it will queue the tx work again until userspace feed the
> IOTLB entry correctly. This will slowdown the tx processing and
> trigger the TX watchdog in the guest as reported in
> https://lkml.org/lkml/2025/9/10/1596.
> 
> Fixing this via partially reverting 8c2e6b26ffe2 and sticking the
> notification enabling logic inside the loop when nothing new is
> spotted and flush the batched before.
> 
> Reported-by: Jon Kohler <jon@nutanix.com>
> Cc: stable@vger.kernel.org
> Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
> Signed-off-by: Jason Wang <jasowang@redhat.com>


I still think it's better to structure this as 2 patches:
1. the revert to fix the deadlock
2. one line addition of vhost_tx_batch(net, nvq, sock, &msg);
   to get back the performance of 8c2e6b26ffe2


Not critical though



> ---
> Changes since V1:
> - Tweak the commit log
> - Typo fixes

but you didn't fix them all :(

See below

> ---
>  drivers/vhost/net.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 16e39f3ab956..3611b7537932 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  	int err;
>  	int sent_pkts = 0;
>  	bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
> -	bool busyloop_intr;
>  	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
>  
>  	do {
> -		busyloop_intr = false;
> +		bool busyloop_intr = false;
> +
>  		if (nvq->done_idx == VHOST_NET_BATCH)
>  			vhost_tx_batch(net, nvq, sock, &msg);
>  
> @@ -780,10 +780,18 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  			break;
>  		/* Nothing new?  Wait for eventfd to tell us they refilled. */
>  		if (head == vq->num) {
> -			/* Kicks are disabled at this point, break loop and
> -			 * process any remaining batched packets. Queue will
> -			 * be re-enabled afterwards.
> +			/* Flush batched packets before enabling
> +			 * virqtueue notification to reduce

notifications

> +			 * unnecssary virtqueue kicks.


unnecessary

>  			 */
> +			vhost_tx_batch(net, nvq, sock, &msg);
> +			if (unlikely(busyloop_intr)) {
> +				vhost_poll_queue(&vq->poll);
> +			} else if (unlikely(vhost_enable_notify(&net->dev,
> +								vq))) {
> +				vhost_disable_notify(&net->dev, vq);
> +				continue;
> +			}
>  			break;
>  		}
>  
> @@ -839,22 +847,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  		++nvq->done_idx;
>  	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
>  
> -	/* Kicks are still disabled, dispatch any remaining batched msgs. */
>  	vhost_tx_batch(net, nvq, sock, &msg);
> -
> -	if (unlikely(busyloop_intr))
> -		/* If interrupted while doing busy polling, requeue the
> -		 * handler to be fair handle_rx as well as other tasks
> -		 * waiting on cpu.
> -		 */
> -		vhost_poll_queue(&vq->poll);
> -	else
> -		/* All of our work has been completed; however, before
> -		 * leaving the TX handler, do one last check for work,
> -		 * and requeue handler if necessary. If there is no work,
> -		 * queue will be reenabled.
> -		 */
> -		vhost_net_busy_poll_try_queue(net, vq);
>  }
>  
>  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> -- 
> 2.34.1


