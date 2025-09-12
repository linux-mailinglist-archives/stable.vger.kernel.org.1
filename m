Return-Path: <stable+bounces-179332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57ABB545F2
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 10:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69739563D0A
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 08:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F329226FA77;
	Fri, 12 Sep 2025 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dw7lbyV1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC22326E701
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667044; cv=none; b=YLcEJkX+Vt82Lv+rBU3qwf4pXyhXA2JeTxPRoDaBRRUYEjyL/rQupPW9z00RxBG1VoPrG/Q1DtitNbZjhk7UbKv1iT5rcNJ89xbcMMT0miuuIqGkILAn+oXpIELAd9BWfQ89FB33RdL0r7O3vMHlSoiTEcplpLO9H1ubDoILvUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667044; c=relaxed/simple;
	bh=eIehRNox/dG9Q/NjSvCbhxAAOwBQCzMl/Y+73D6b6cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIrWDAfOpV8fHzrQJi1n9e+XJW2kfzGY8b7AsJGix3r6+Gdlkg/7ffPijSJY/oPTb9ibAdzsLhzSaK6B8zmg8aLHW+6erHmQGnu4XRtG0EuEBzH5klxE7qqeaiYqg7ulWsotZCFP2+gmaTOxjgm8cafUJq7Vr+NQNdnu8+JQ0q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dw7lbyV1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757667042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bGhSd8CvNyRTKzq49MHrvoxg5fRG/+TgxZE8XqY/Z/Y=;
	b=dw7lbyV1uAyUvQeBntax1lqec9je/V7K4z0hn4m+rei4jme5QqeFr5bG+oLLrRnKnxsbic
	7dkcHCag5IQEPQgn1An8VEF7XuPUaK30wcATMnsUoiOTzicV9fUFbG6TiGg8aMlTB5g4j9
	Y9n49vofSTJyfeOMcJ6W5hjFAp01uu0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-9NHcSGlnMdi-wtWsZ5RS9w-1; Fri, 12 Sep 2025 04:50:40 -0400
X-MC-Unique: 9NHcSGlnMdi-wtWsZ5RS9w-1
X-Mimecast-MFC-AGG-ID: 9NHcSGlnMdi-wtWsZ5RS9w_1757667039
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3e7691b7dfdso224547f8f.0
        for <stable@vger.kernel.org>; Fri, 12 Sep 2025 01:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757667039; x=1758271839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGhSd8CvNyRTKzq49MHrvoxg5fRG/+TgxZE8XqY/Z/Y=;
        b=plls2ZXiGZZV8EiopSTbKaV0bpZNU9v7xQgNlOSGt07EcbwLYqTnU5J4w9CYwhxafC
         3VIxR0dNp3LSri68PQ3f3s12/vbN2xLaEtP2fgkh8vIrGVZ6jz3Ku3YhxIgvTKFFUmkk
         1ktPZCdeJwi+FLOluyb6DUCe+SJKSvABXcxXvDRQvtP1oRhVNaJAvu49JVmvzx76/pDO
         xvtQoGHYrlf6eLu60ki2BbJGsebiuNp5hJ5leDk64Cw1kjtnAuGO8Vdag9SKLfybf9YD
         JD/mgJ3boqfkM+Z50NJmXY7qFs6Kah4ZGU6wBsXJk6UwdPuRqGTc6cAf4KPrVNa+7rPZ
         UodA==
X-Forwarded-Encrypted: i=1; AJvYcCXEqmlJMYoAWF3LNivh7PnrmKsPz3OA38aSzm/nItu9Po4CQIwxgRsMMiH8p+BzzB6Hb5+C2MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ30K7Jq4ao6+maUsvQ78mfrcwg77IxWKkhUB/+HdxAG8ndYhO
	p1D+wzhiiqKMakSzVhtJuYxTKNyYjPc7wK3nYHqhm4vbUhxK8KdEtm+0JweVObF8S76/F+sUvfl
	+ptn9CizCJ7JZpgeuc08e/E1gN6peNeObKnK9xwg1yu+niSAGiyGj2TR1yg==
X-Gm-Gg: ASbGncswqoOVCwtRI/xikCSKV9ZiqdtbjELnsxh/aLqq26sEnFnBrBtzU5vdHwIGd/H
	BwYDzRCRymaT2EZp3vk9F9T9IKo7zP180EQQqz67UtMen5Ukf3Uv/QSAocv5l3xkNzoaSi3b0dw
	RGGvhT44xMfDMTPiRGx88C+4dSr9S4VFQtDC4vkoIfR3RYAtLOKHrltiO1zjBnPv+xdTjXk+RyH
	0Qzzwda0ro9W92xNf65O4IKEi5UBuWRy/odDBPrk1yjBwbgGuGxdfheYl2HVunH469970phCSYl
	9IJqwxtgQhz5t86JeOZeKZAVq3bkFZnd
X-Received: by 2002:a05:6000:178b:b0:3e7:5f26:f1f3 with SMTP id ffacd0b85a97d-3e7658c0f20mr1991855f8f.25.1757667039439;
        Fri, 12 Sep 2025 01:50:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS2Tz/SulTKIR1f9nSWXhOdRDsMn29o7jRrHZHGh4hg8LiyfPRYgIJgThyJhmqJvpcfuVOUA==
X-Received: by 2002:a05:6000:178b:b0:3e7:5f26:f1f3 with SMTP id ffacd0b85a97d-3e7658c0f20mr1991827f8f.25.1757667038953;
        Fri, 12 Sep 2025 01:50:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:c800:2952:74e:d261:8021])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7b42bdc5asm321061f8f.21.2025.09.12.01.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 01:50:38 -0700 (PDT)
Date: Fri, 12 Sep 2025 04:50:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org,
	jon@nutanix.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] vhost-net: correctly flush batched packet before
 enabling notification
Message-ID: <20250912044523-mutt-send-email-mst@kernel.org>
References: <20250912082658.2262-1-jasowang@redhat.com>
 <20250912082658.2262-2-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912082658.2262-2-jasowang@redhat.com>

On Fri, Sep 12, 2025 at 04:26:58PM +0800, Jason Wang wrote:
> Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
> sendmsg") tries to defer the notification enabling by moving the logic
> out of the loop after the vhost_tx_batch() when nothing new is
> spotted. This will bring side effects as the new logic would be reused
> for several other error conditions.
> 
> One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> might return -EAGAIN and exit the loop and see there's still available
> buffers, so it will queue the tx work again until userspace feed the
> IOTLB entry correctly. This will slowdown the tx processing and may
> trigger the TX watchdog in the guest.

It's not that it might.
Pls clarify that it *has been reported* to do exactly that,
and add a link to the report.


> Fixing this by stick the notificaiton enabling logic inside the loop
> when nothing new is spotted and flush the batched before.
> 
> Reported-by: Jon Kohler <jon@nutanix.com>
> Cc: stable@vger.kernel.org
> Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

So this is mostly a revert, but with
                     vhost_tx_batch(net, nvq, sock, &msg);
added in to avoid regressing performance.

If you do not want to structure it like this (revert+optimization),
then pls make that clear in the message.


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
> +			 * unnecssary virtqueue kicks.

typos: virtqueue, unnecessary

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


