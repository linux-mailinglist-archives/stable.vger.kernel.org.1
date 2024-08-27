Return-Path: <stable+bounces-70363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31098960BFE
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA6D280E69
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 13:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D7F1C579D;
	Tue, 27 Aug 2024 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Udj1fjaq"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2E11BFE07
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765087; cv=none; b=bmAJ1pnFNwXXAYrS9Dl5wiD+jP7KCp4vd8EKfgSmWwMRdRKRq9xOPK8cg0IAEjG0NYnwWdAUCVBvzOZF0HgQL3JWoRUJBWED8A/3qR2GCGCwkSJAAz7sXnz14J0RzJachUEi2nhHvio0KtVab8DNAF/R2bcw+0d1GjoBl2iH0nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765087; c=relaxed/simple;
	bh=C1Psij49NxzQQVs/fLfKOjdWLfmrzStbUTmG4qlgoDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeTh6wneubHDMCtnMcpaPMvuNSd49F+M1V7k4cqaSYS9g3cfcWM92CVB4jxiCaHU8nPi1Mh+hltKH2ogij+pkhPnwzK0LraYVpZ++8+IfHOPHtafJbeikZ9zXX3Xh6i2dTGlarRb/eVAi1ymdDPsaCD+dkM6GIERyxtGud0aiOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Udj1fjaq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724765084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ca7L2Ypf1IuSrNf2s487D4RaOYQ0VQUUHqLQBFjj34U=;
	b=Udj1fjaqf9+otj6J/nodPA7HFRGwEtwLXLfuY0Q7u2WtX9KaCf55fNWJ2Wvb6kF8PuMvxW
	6wD25uKuoOm5hhweg+wHNt7fJtZXwlfd7M1y9/Jr0cJxv4RGb+zhvWDOPkI0U1PkdAulBm
	IR14/h2USuLSHPPCpPyUSjY99gtDKrM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-15vKzajhM5OfR5tG72w6TA-1; Tue, 27 Aug 2024 09:24:43 -0400
X-MC-Unique: 15vKzajhM5OfR5tG72w6TA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428fb72245bso28767125e9.1
        for <stable@vger.kernel.org>; Tue, 27 Aug 2024 06:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724765082; x=1725369882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ca7L2Ypf1IuSrNf2s487D4RaOYQ0VQUUHqLQBFjj34U=;
        b=XNavyxpH0OXjXteXbxq4oxmkMN3Jks9B8tocHbHzMNQ1+5BwYI2f1xKzYsu6dsmq9e
         EGJV7R8Qx+usWtaELBMeGEapqEZHe3PzKp9HCEyox4HENo1AOuaGjVsbaK7ZeHAGS0j/
         A0SdtSo6jyM5Ky4sdiJWTwjBGK5Cqv4uig/gI3XRtOCEGdPAkdRItRlYAhuL/okVQBeK
         72qiY9mdSwsc2VXQYZGZ85xxPvkB3HgdXkFlWSF0pr1ZlVJWTHzrlPzY29l9pzXV1oqm
         FuoXocgYEX14Uh0u863cu2DZZhipUpQRbo0bi8w8lvRfaeeWA1dYHOOJgo5HyT2ro2gh
         UFYg==
X-Forwarded-Encrypted: i=1; AJvYcCWHN/9YoltT60AYHbOKpXK5+2J5uTR0Z1VWnf4w6t1VW35ZcqYiitC/caolVLnljwnjS1XaYm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9lNTInnLJUKWWhrg0e/HLtuAm+otZa3BJwuUaDzb2kndecSEO
	mi/tK7wdkInnBSN7G5PdRIsdI/BathU48DyACjKElV4SkqkqG5J0Eslbx2zJH74aOFwIti2Hnqt
	1KGxMFYrylpZLciU22Mk//4iNS0/7CneseyAUkdsC2dW0Ue/7mNeywA==
X-Received: by 2002:a05:600c:4f01:b0:424:8dbe:817d with SMTP id 5b1f17b1804b1-42b9a46d558mr18972095e9.10.1724765081987;
        Tue, 27 Aug 2024 06:24:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7rF2xZXsNit3rnRpHiOnC7cRxUpFHU0F4taw8YckE22isH+1s8w1ewwo4oiz7G7HWJwsUVA==
X-Received: by 2002:a05:600c:4f01:b0:424:8dbe:817d with SMTP id 5b1f17b1804b1-42b9a46d558mr18971815e9.10.1724765081469;
        Tue, 27 Aug 2024 06:24:41 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b67:7410:c8c6:fe2f:6a21:6a5a? ([2a0d:3344:1b67:7410:c8c6:fe2f:6a21:6a5a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac51622b6sm184917205e9.22.2024.08.27.06.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 06:24:41 -0700 (PDT)
Message-ID: <43c572e1-11bd-4fb6-8463-7940f57b8c7d@redhat.com>
Date: Tue, 27 Aug 2024 15:24:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] i2c: designware: add device private data passing
 to lock functions
To: Jiawen Wu <jiawenwu@trustnetic.com>, andi.shyti@kernel.org,
 jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com,
 mika.westerberg@linux.intel.com, jsd@semihalf.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, rmk+kernel@armlinux.org.uk,
 piotr.raczynski@intel.com, andrew@lunn.ch, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com, duanqiangwen@net-swift.com,
 stable@vger.kernel.org
References: <20240823030242.3083528-1-jiawenwu@trustnetic.com>
 <20240823030242.3083528-3-jiawenwu@trustnetic.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240823030242.3083528-3-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/23/24 05:02, Jiawen Wu wrote:
> In order to add the hardware lock for Wangxun devices with minimal
> modification, pass struct dw_i2c_dev to the acquire and release lock
> functions.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2f8d1ed79345 ("i2c: designware: Add driver support for Wangxun 10Gb NIC")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>   drivers/i2c/busses/i2c-designware-amdpsp.c   |  4 ++--
>   drivers/i2c/busses/i2c-designware-baytrail.c | 14 ++++++++++++--
>   drivers/i2c/busses/i2c-designware-common.c   |  4 ++--
>   drivers/i2c/busses/i2c-designware-core.h     |  4 ++--
>   4 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-amdpsp.c b/drivers/i2c/busses/i2c-designware-amdpsp.c
> index 63454b06e5da..ee7cc4b33f4b 100644
> --- a/drivers/i2c/busses/i2c-designware-amdpsp.c
> +++ b/drivers/i2c/busses/i2c-designware-amdpsp.c
> @@ -167,7 +167,7 @@ static void psp_release_i2c_bus_deferred(struct work_struct *work)
>   }
>   static DECLARE_DELAYED_WORK(release_queue, psp_release_i2c_bus_deferred);
>   
> -static int psp_acquire_i2c_bus(void)
> +static int psp_acquire_i2c_bus(struct dw_i2c_dev *dev)
>   {
>   	int status;
>   

This function is used in a few other places in this compilation unit. 
You need to update all the users accordingly.

> @@ -206,7 +206,7 @@ static int psp_acquire_i2c_bus(void)
>   	return 0;
>   }
>   
> -static void psp_release_i2c_bus(void)
> +static void psp_release_i2c_bus(struct dw_i2c_dev *dev)
>   {
>   	mutex_lock(&psp_i2c_access_mutex);
>   

The same here.

Cheers,

Paolo


