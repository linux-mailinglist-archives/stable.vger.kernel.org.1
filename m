Return-Path: <stable+bounces-27242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AD4877C74
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 10:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8683E1C20EBE
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 09:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4278134CD;
	Mon, 11 Mar 2024 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TftKX9AU"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00C2E407
	for <stable@vger.kernel.org>; Mon, 11 Mar 2024 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148621; cv=none; b=m/6I1fxdzvLyBRwOD2IyoeP+/6FvD9+2pj0VEgLfGuA92+pdYOtZAT00nrKInMBh6QIL37q/AT4eeo2CVJnpHazcCc/oeUtEl9RRI46QlMA8u5jZ4sjJCgI26+w/GgGPv59zzGUj5Q/3G88zyBe23BI8UuFAeJZ3BU6BcBIBErk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148621; c=relaxed/simple;
	bh=YhVl++BZOeI6zwz1aTmXNBeQhgXKmhmPqQVXenLFTfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMRn9DkvfKr19KtliPRxmvlc8WKykFTwG85V8JIyqV8m1IJkOqyOkafHc0knsUZTFsPLi429vSIBkpuKCEg/HhqwCcJ87NZrqQgaurtTCE64h10X8kvkOyb//n1WAkENpcJ8HT2Q8pSK8RcTdH+vjabnr1eapD9n2uLQNBaDzks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TftKX9AU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710148619;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1Ri9kDddSL5LEfhUJzNl9VSoQTVKWDORtXZoaQ46AI=;
	b=TftKX9AUg4jn7uO3FXZeqbOFNo47EhiNX011zC58QaRDU/xkc9gXfJl2ANp1wORqSQtt7U
	ddln90BDXmUC/pLM/RzZzerrjIeDJ0eDCecDl9vhERZNEk/8UEWKnSI1ldMqdj9yL1p+y2
	YsA+RJb5rN9IFl6Z4eUXAzkAsoESIQ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-RJWqEjpOOUCyDW2CIwJjNA-1; Mon, 11 Mar 2024 05:16:57 -0400
X-MC-Unique: RJWqEjpOOUCyDW2CIwJjNA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-412db0e24aeso21798695e9.1
        for <stable@vger.kernel.org>; Mon, 11 Mar 2024 02:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710148596; x=1710753396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1Ri9kDddSL5LEfhUJzNl9VSoQTVKWDORtXZoaQ46AI=;
        b=kZQz6j347jePXAV0/KHOYdkrdErC11yeOwl6BXuZbu842sR9TyMktcN+1QdBgZfuyQ
         6vj0HiSaZdyQW2yOQf6j7KhsuUDMB1jakaKFowuv3MTdvIdk2bflRZNBg+OeoTOuExKt
         C9fCXpZY1gUcrWwo45/4nn79LXUFE1p8nqopBzpsHBnaw05liidx5KKPuFFbxtdd2Hv0
         uBFMHPBdK4uL+ZdIHnXd7obo8ucrcwK2L7WJuOmtDutzESen2N8MXFNNVhumHbsixyJ7
         mUrkS/+XASxPKmzF7Wf7QU6a4Rk0LWq6ul6KLPHXskpqj4Qo9meTmBkG3bLG0oiIaYR6
         89TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFfbIVKPRSdCm0j2PYGzuesiwyrOGwhI3YZ7Q/aBZEyYllLiuQqnfgWurOePP6ikU5NGiByFnI+L+jOgjFNEe/hTKtDTN9
X-Gm-Message-State: AOJu0YzbTpxXxIp6tootO3qNmE+l0I+vTigmhlajASqzrz4cHOmzOQ7O
	hFDKRd0MNpwdVZZN8FTEf93KhR6YTTFevsYORzJ5BRxbUmOKJiEaQPAEt2wl35sTXrL2tf3JFZi
	Ff3BJGBl9HEqNt3CNP0cYk1+X9UPwDcE2aRuw86Kd27TIWpPtA4JhhA==
X-Received: by 2002:a05:600c:35c8:b0:413:14da:a9f7 with SMTP id r8-20020a05600c35c800b0041314daa9f7mr4558895wmq.0.1710148596652;
        Mon, 11 Mar 2024 02:16:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq2xtSDxKyoXCZ4290qqGUfXEXDNrk4RQV0BmYu6hnCQ4RqLN62Fs5tQRIZAVlJsCDhIwRnQ==
X-Received: by 2002:a05:600c:35c8:b0:413:14da:a9f7 with SMTP id r8-20020a05600c35c800b0041314daa9f7mr4558881wmq.0.1710148596305;
        Mon, 11 Mar 2024 02:16:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c4f8400b00412ff941abasm14934328wmq.21.2024.03.11.02.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 02:16:35 -0700 (PDT)
Message-ID: <70d2114b-0b72-4065-b70d-c31cbc70291a@redhat.com>
Date: Mon, 11 Mar 2024 10:16:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v2 5/7] vfio/platform: Disable virqfds on cleanup
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, clg@redhat.com, reinette.chatre@intel.com,
 linux-kernel@vger.kernel.org, kevin.tian@intel.com, stable@vger.kernel.org
References: <20240308230557.805580-1-alex.williamson@redhat.com>
 <20240308230557.805580-6-alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240308230557.805580-6-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alex,

On 3/9/24 00:05, Alex Williamson wrote:
> irqfds for mask and unmask that are not specifically disabled by the
> user are leaked.  Remove any irqfds during cleanup
>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: a7fa7c77cf15 ("vfio/platform: implement IRQ masking/unmasking via an eventfd")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/vfio/platform/vfio_platform_irq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
> index 61a1bfb68ac7..e5dcada9e86c 100644
> --- a/drivers/vfio/platform/vfio_platform_irq.c
> +++ b/drivers/vfio/platform/vfio_platform_irq.c
> @@ -321,8 +321,11 @@ void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev)
>  {
>  	int i;
>  
> -	for (i = 0; i < vdev->num_irqs; i++)
> +	for (i = 0; i < vdev->num_irqs; i++) {
> +		vfio_virqfd_disable(&vdev->irqs[i].mask);
> +		vfio_virqfd_disable(&vdev->irqs[i].unmask);
>  		vfio_set_trigger(vdev, i, -1, NULL);
> +	}
>  
>  	vdev->num_irqs = 0;
>  	kfree(vdev->irqs);


