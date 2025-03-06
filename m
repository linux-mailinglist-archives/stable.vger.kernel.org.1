Return-Path: <stable+bounces-121206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F7FA547CF
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 11:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03BD33AB7D5
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 10:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16011A76BC;
	Thu,  6 Mar 2025 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AeBgcNWz"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D63202F61
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257150; cv=none; b=IO4URsFjTRHdO/yT4MBBmSGBFA/Jxw83DAinCbs/7zHZF9wlnleA2IUz9G1LeNlGOY3rG5SxM1q644tiTYdhZXWYQQ6U1cK3dgctp8gPCo/shZ6Oxb4dO8tFQpgpvQNDhYdzdEzvSp6tmc4p0tFFWc17z2ZvaI5u4utiq5WPjZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257150; c=relaxed/simple;
	bh=IGVAuJkuiiv0B8e7SlGUhgx4yCx9vKQqqr7RUi5IhrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gW2gqioEYZbQymncbYx1UEmyMXsLyIBxEB/Yr7KsXyQHW0BxdiFJhwrkmA2QaahqRnkweFmOkajXTrqovGY2n2Z98WBqeDsTD7AvfiJKwdUhZJ1nfAERgLLpkh5Us8fI1OZSQfHHD8UIQkwhUzswZPHnwGWnrCDPX4rQr75Hpdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AeBgcNWz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741257147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMqW1t44N97ihf+A97Lk88vZ7a/tf/Mv4rMOKlQe5oc=;
	b=AeBgcNWzXNbsRfHjimIGUJ4bgrh7YUBpn3Wqc1EtmbCGPSlCloG/xVVHOmIyilcu4g45bq
	xxRTUPYzbfhj+qtX52TS1lFFyQDK0zke/p5o462MI9M/muHaW1DXOAEjlWCARcj8fkGX0b
	VsIBgb2AkKsXAB76iw2dFxjdo/glNBI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-1_aCFfcJMuK2r1STFf1BRQ-1; Thu, 06 Mar 2025 05:32:16 -0500
X-MC-Unique: 1_aCFfcJMuK2r1STFf1BRQ-1
X-Mimecast-MFC-AGG-ID: 1_aCFfcJMuK2r1STFf1BRQ_1741257135
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43bdcdf193dso2122435e9.2
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 02:32:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741257135; x=1741861935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMqW1t44N97ihf+A97Lk88vZ7a/tf/Mv4rMOKlQe5oc=;
        b=Ckz2E4gDqTvMFV2ub2+NUpu0pAnB65CPYRtZi0ug9YF42NEMXZjcU9odnTL/4gxuDE
         KYuG4VkFQJ6+2bnZ+ow2iXzTmzyy1+niy1Dxy4kmDXL3JB6VX6dRSqOQs+CojIdH0oS4
         uaLfmealB6PUQ1GmfmSPGk1XTHkvaXMPTFj6+uFQk2YNTqdsFSHGyeRJFftnXtzwWw4t
         G/tw0ntqAZX7F/ryAcChpwdv3zP1uDZ2wbQrN9GIDQWuBirHhbhz0JYIM7wDRmkECKnq
         9TRye7kbZIuyFGU2oLOqajh0A9MJAJuO2VkiDJ2ZN2fYVCRnf/rObNa1c41L+0Kl4TAP
         JN2A==
X-Forwarded-Encrypted: i=1; AJvYcCX931X8tF386uOEpFgpO0V77rUa/jUmdKkpTTICD4Nmf6tl1GlXYnoFgB+nYmU51SuvL78DmaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcJBtfE62FHbk/y0aeEqLXv5KbQ9WdCGKRPT5zcALxuVS0vcC9
	nrEyj/HbUNDs0lRTQFlxLqmjK0jV/ardQV3NsJf9BM0C+tI+wACH8EdHVaCwFVTy1i3bOwCtDGe
	7LdW4bSSu4EAGyMkJY8iqsh/Z86VmGlE7krz9EV6QkhBMqWkGu/6UxQ==
X-Gm-Gg: ASbGncs4UoxeXTqIQNpuJieq3SDJ7k+4vWabA2wgHNx+pQv4r6CbO2DlpjLyc7xvZAY
	MYakzfhFg7NntxQ5zZScqafo9p0NPmddBKgbpbhqFAVo6P7clREvx6J1EGDUADByRNURDKM+Qt/
	TnDya0SActohR0wdFrTP289LM9uxolFLQEdbSu8EJS1pljk9WkOSByUAwnyxRbQKF80yrRv/5jS
	sC1OhGRSCXEzvTRjTj1rAlan44Xeut7BtWldN9Ltv4jAtugxhQC+8Ets1Gmdu0MesTjx5M07Sns
	VANLPVgbfbOO4v2Djt+Nm0hujfC3eMdRecjtqmNd8fzV4w==
X-Received: by 2002:a05:600c:4e8d:b0:439:930a:58aa with SMTP id 5b1f17b1804b1-43bd28a73f2mr56130385e9.0.1741257133334;
        Thu, 06 Mar 2025 02:32:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjneL1v6mm7CN1Ta5I26BcghZEUJFnb1sJCU6KoCgTgUbp+nI7Nhqiox0FcMr5Gc2xWIH6mA==
X-Received: by 2002:a05:600c:4e8d:b0:439:930a:58aa with SMTP id 5b1f17b1804b1-43bd28a73f2mr56128875e9.0.1741257130527;
        Thu, 06 Mar 2025 02:32:10 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba888sm1639761f8f.16.2025.03.06.02.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 02:32:10 -0800 (PST)
Message-ID: <8ec75d7c-0fcf-4f7f-9505-31ec3dae4bdd@redhat.com>
Date: Thu, 6 Mar 2025 11:32:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qlcnic: fix a memory leak in
 qlcnic_sriov_set_guest_vlan_mode()
To: Haoxiang Li <haoxiang_li2024@163.com>, shshaikh@marvell.com,
 manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 rajesh.borundia@qlogic.com, sucheta.chakraborty@qlogic.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250305100950.4001113-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250305100950.4001113-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/25 11:09 AM, Haoxiang Li wrote:
> Add qlcnic_sriov_free_vlans() to free the memory allocated by
> qlcnic_sriov_alloc_vlans() if qlcnic_sriov_alloc_vlans() fails
> or "sriov->allowed_vlans" fails to be allocated.
> 
> Fixes: 91b7282b613d ("qlcnic: Support VLAN id config.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
> - Add qlcnic_sriov_free_vlans() if qlcnic_sriov_alloc_vlans() fails.
> - Modify the patch description.
> vf_info was allocated by kcalloc, no need to do more checks cause
> kfree(NULL) is safe. Thanks, Paolo! 
> ---
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
> index f9dd50152b1e..0dd9d7cb1de9 100644
> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
> @@ -446,16 +446,20 @@ static int qlcnic_sriov_set_guest_vlan_mode(struct qlcnic_adapter *adapter,
>  		 sriov->num_allowed_vlans);
>  
>  	ret = qlcnic_sriov_alloc_vlans(adapter);
> -	if (ret)
> +	if (ret) {
> +		qlcnic_sriov_free_vlans(adapter);

I'm sorry for the lack of clarity in my previous reply. I think it would
be better to do this cleanup inside qlcnic_sriov_alloc_vlans(), so that
on error it returns with no vlan allocated.

There is another caller of qlcnic_sriov_alloc_vlans() which AFAICS still
leak memory on error. Handling the deallocation in
qlcnic_sriov_alloc_vlans() will address even that caller.

Thanks,

Paolo


