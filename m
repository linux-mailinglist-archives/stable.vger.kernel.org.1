Return-Path: <stable+bounces-74623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5FA97303F
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F2F284769
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A6918B487;
	Tue, 10 Sep 2024 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwWsWYAW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26017C22F
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962345; cv=none; b=GBuhpLXJIaO4R4EYc/kgZo4SL8hBEy8s9WiknfiBl+fpoVJ854en7h0svAxdZswFSsGzrkgE6ZSeZH2CQ3uNTxOnDo4vvVw2zYrlhzZ7q7KmpS8wVu1fkbxlQuw6e5gu3BcRzzRm6L7/1OKByuPgUfmpblVQkk1xWTi7Fezt4oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962345; c=relaxed/simple;
	bh=bQLe2pUIEEyUZE+/EAglMsUr+F12sN/BLUBijDrXSac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Edm8PuLhPW51UhCtboq1nSTm9bvkuZoUVhcA5QVQ8mfieJZt/y+aYpa8hWXrOXXbwVpisCxPhFgafFgdQaGNmY5jQk2JPuoaeIat1auWIlb4X9kQiEbf5Po2PcsmqpxBwkkWDr9DIVxHxZog1+zurs2mnI2rDLTgBaJki8H7qXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwWsWYAW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725962342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jiUkwL8jiwz5bb5LLszsrQRqvrS9SIKe3P1nTjcI9RU=;
	b=dwWsWYAWI/uWKosgUnEVQj3alAgbhDX8IzmuB/v7r4TuiF9tZaQXwUkrlfOfL1C6N1t5H4
	GsCHCa/o7ldPtApcIbMHzwyooOO6OrXSOCux99ZTDSvuF46vwsb9i+zYKNqYpobLGGWX6f
	1b9JMEO7mjwZk8jle4DOmYdhLFk8VPQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-WQ09XKM2P86HquDCSj9Onw-1; Tue, 10 Sep 2024 05:59:01 -0400
X-MC-Unique: WQ09XKM2P86HquDCSj9Onw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8a877c1d22so253861966b.1
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 02:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725962340; x=1726567140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jiUkwL8jiwz5bb5LLszsrQRqvrS9SIKe3P1nTjcI9RU=;
        b=DLUAGO3RQTBtphRtasn8QJl55J4MLImm2JZIDdCeoAT6loA+O8RWxjC6wY9BeNWrVO
         qbb5qo2y4XjAcvn+ObyLqgATLQWojKZ11qAhj2nZg8VMGxoDyDh/v1nZus6EXVvxK/by
         M/ATBxFuizB2yfXfbIuzS31+/gg5EAzOAXKSZwSCDHEoszVffYGguWi/A/Nym1m0QIZp
         /jJfOTgumFX+TMs2ffIqdMv17RfHfZBnbXLH+Zjzwl98ZMal3dJW/ddLcEFJIqZScHqo
         w6/qAfwudP/deGShSX3MyoIQbGkDPI/PWKVgeJ9ksZUDMd4wjUCvJ43dmPg1lYUnCOSy
         Z5+Q==
X-Gm-Message-State: AOJu0YzJOZBdH4f3TRDDONL6VasV+pgq/VUhcqPYxl5M9imSks1VCDvi
	MIqxwy4bW9OgG2BxQpxPF5ai1Q8zTGTzoSk7FvT2t3cbn9o982GIjUv882aFhFxznPhWVhwubhC
	WZVH06pjgeG1Q8BgWAV3oC0H0W+dby8rmNVaajnwRo5Bn8OcJq4gHEw==
X-Received: by 2002:a17:907:268e:b0:a86:8953:e1fe with SMTP id a640c23a62f3a-a8ffadf3c37mr21982566b.47.1725962339864;
        Tue, 10 Sep 2024 02:58:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERbuGqTbebYxtwPp+Ofxmyy5JzHR+T4dmVYSq8mepeZfuhvqFtrdMXLyJgC2KYWCtRG3tCIA==
X-Received: by 2002:a17:907:268e:b0:a86:8953:e1fe with SMTP id a640c23a62f3a-a8ffadf3c37mr21979466b.47.1725962339290;
        Tue, 10 Sep 2024 02:58:59 -0700 (PDT)
Received: from [192.168.88.27] (146-241-69-130.dyn.eolo.it. [146.241.69.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25830efdsm459314066b.41.2024.09.10.02.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 02:58:58 -0700 (PDT)
Message-ID: <ff23bcb5-d2e8-4b1b-a669-feab4a97994a@redhat.com>
Date: Tue, 10 Sep 2024 11:58:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net] usbnet: fix cyclical race on disconnect with work
 queue
To: Oliver Neukum <oneukum@suse.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240905134811.35963-1-oneukum@suse.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240905134811.35963-1-oneukum@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/5/24 15:46, Oliver Neukum wrote:
> The work can submit URBs and the URBs can schedule the work.
> This cycle needs to be broken, when a device is to be stopped.
> Use a flag to do so.
> This is a design issue as old as the driver.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> CC: stable@vger.kernel.org
> ---
> 
> v2: fix PM reference issue
> 
>   drivers/net/usb/usbnet.c   | 37 ++++++++++++++++++++++++++++---------
>   include/linux/usb/usbnet.h | 17 +++++++++++++++++
>   2 files changed, 45 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index 18eb5ba436df..2506aa8c603e 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -464,10 +464,15 @@ static enum skb_state defer_bh(struct usbnet *dev, struct sk_buff *skb,
>   void usbnet_defer_kevent (struct usbnet *dev, int work)
>   {
>   	set_bit (work, &dev->flags);
> -	if (!schedule_work (&dev->kevent))
> -		netdev_dbg(dev->net, "kevent %s may have been dropped\n", usbnet_event_names[work]);
> -	else
> -		netdev_dbg(dev->net, "kevent %s scheduled\n", usbnet_event_names[work]);
> +	if (!usbnet_going_away(dev)) {
> +		if (!schedule_work(&dev->kevent))
> +			netdev_dbg(dev->net,
> +				   "kevent %s may have been dropped\n",
> +				   usbnet_event_names[work]);
> +		else
> +			netdev_dbg(dev->net,
> +				   "kevent %s scheduled\n", usbnet_event_names[work]);
> +	}
>   }
>   EXPORT_SYMBOL_GPL(usbnet_defer_kevent);
>   
> @@ -535,7 +540,8 @@ static int rx_submit (struct usbnet *dev, struct urb *urb, gfp_t flags)
>   			tasklet_schedule (&dev->bh);
>   			break;
>   		case 0:
> -			__usbnet_queue_skb(&dev->rxq, skb, rx_start);
> +			if (!usbnet_going_away(dev))
> +				__usbnet_queue_skb(&dev->rxq, skb, rx_start);
>   		}
>   	} else {
>   		netif_dbg(dev, ifdown, dev->net, "rx: stopped\n");
> @@ -843,9 +849,18 @@ int usbnet_stop (struct net_device *net)
>   
>   	/* deferred work (timer, softirq, task) must also stop */
>   	dev->flags = 0;
> -	del_timer_sync (&dev->delay);
> -	tasklet_kill (&dev->bh);
> +	del_timer_sync(&dev->delay);
> +	tasklet_kill(&dev->bh);
>   	cancel_work_sync(&dev->kevent);
> +
> +	/* We have cyclic dependencies. Those calls are needed
> +	 * to break a cycle. We cannot fall into the gaps because
> +	 * we have a flag
> +	 */
> +	tasklet_kill(&dev->bh);
> +	del_timer_sync(&dev->delay);
> +	cancel_work_sync(&dev->kevent);

I guess you do the shutdown twice because a running tasklet or timer 
could re-schedule the others? If so, what prevent the rescheduling to 
happen in the 2nd iteration? why can't you add usbnet_going_away() 
checks on tasklet and timer reschedule point?

Thanks,

Paolo


