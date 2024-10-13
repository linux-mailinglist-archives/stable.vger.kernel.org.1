Return-Path: <stable+bounces-83618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C502999B970
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 14:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCBC61C20B35
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 12:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E66143723;
	Sun, 13 Oct 2024 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqLEetsD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE5E36B;
	Sun, 13 Oct 2024 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728824138; cv=none; b=XliEUHno8MV7zYdwfUQ0we9j4sH9y9gCLRvzsjjxazvlzWAB0ZFIpyPCL3H7/xqA2VIBVD2qAD+Ifdg/m4GeewReoFcup8jm91mO9qErU6+fV0gABY9ARIKpvG4JWb++8QWpPsN9zQ+FUl/N2pZWkAYAusdiyK8BaxhMJRSSKoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728824138; c=relaxed/simple;
	bh=PGHjAbYs47V3IL/rq2kwUEzf4WBrICwxIJb375H0MdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2KK3QdxoMn45M6UVn1f1TCwvLezDHF+sQjXTV+YrW0WUmqomJS99TLwO5VoUy4XwiT97EIRS+xFWIocH3AZYb1Z9Aqup1G+a0LtTBteY5jcY6zUZjCrrDGA8e1iWq16c0ebkDb9bvuiuv4RN3kEieBMK/nNPYPE68c2uDtr8FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqLEetsD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43115887867so22440155e9.0;
        Sun, 13 Oct 2024 05:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728824135; x=1729428935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWMT5lNGu1xTshtgdsecoS6+Z5F56R0HKb2/GtovXRw=;
        b=mqLEetsDTIr1UDulA9knxy8wOnqTaBU9RpAYqASbYFKA/CAeCju37qzyIgO1ySvQ3B
         M+8SzI9TX2z/1H5ABdqjmQ6szv3LwL0T/rRbMBSisjbONKZ6T0Gb2RH6mEvGcVDl4+je
         XMo2Bx2ISfxfG43cWnXWycyPcPf9UYXOxYr38MG/T3liF/RZI8mnlfsV0rPSdfaki+/K
         6PpOOV4lLNe3qXfnzOelS4l5mfrOAPA9v7VYpex6gIZSyzMSkBaH95MJZCg74wB82as8
         Ifv9tpGnGqUY9RYREZoyhx6XlemuM9MK0r7brdOQbGxjcnSyd5MidIo7cvxMe5b7nbIc
         J0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728824135; x=1729428935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YWMT5lNGu1xTshtgdsecoS6+Z5F56R0HKb2/GtovXRw=;
        b=j/gpj2gAIazo/mj/P4Y73MOFU53KdqCCfVyh6+JB1eQHJBWzTG8RPM1DeaYs9lNLtb
         JEVW1SE1zmAFd2Yd9ZpH8kkpnSu16wyXG6JEE2IcfkwkmEnzr/S3a5IjcuA3udS6VJvf
         xjErtrqly47FoRxpQ0gi1S/qsvX0HlhylfLMtgqFSrEhv22j0GBgU1XWxxxltBP7FXm6
         ZmF9EZ/T5QV6/GhjE96e2fg3GOVbQPRQLwQUO1GkCOAZWtWsIDlr1pQd/pxnsqgapFkD
         YxB+J6emi37BekY7eC9aVhhXzzgkzSGbQNpTs+/sWaHfl/AH/lhVjtAbuJ8mXbgZfr2e
         JVeA==
X-Forwarded-Encrypted: i=1; AJvYcCVfB4Dpo2MM5vRaxCpsnXCXDJqDXNFZkj8LGffIec6NUD3mC7VQzCnJhSZhoN2307OzxaXgsUC9@vger.kernel.org, AJvYcCXLEa3t6QHIjgbRh1+9ywS769/w7YBksgVG5jPqNzDFLUqY8hKCGhJo8BCJSG5SfXoJv9dWkIsv5q22kWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS1GQrdRmC41uW0rapVkaL28kQKo5zzoVk4bfSFiDTieQo6iiS
	OZbsBF+q/tcIXlXZSosDEXlNkbRRLvT+5KOk1DdCOvqe6JcP08as
X-Google-Smtp-Source: AGHT+IGx9lvPuk/IEYQT+CiW4c6HxwiL9K8/Y3t0ehXw4g7CKJ3aTbBceq7YmC9Lx1M/KpvT7OODvw==
X-Received: by 2002:a05:600c:b9a:b0:42f:84ec:3f9 with SMTP id 5b1f17b1804b1-4311d884328mr70492185e9.3.1728824134850;
        Sun, 13 Oct 2024 05:55:34 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:a034:352b:6ceb:bf05? (2a02-8389-41cf-e200-a034-352b-6ceb-bf05.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:a034:352b:6ceb:bf05])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd3e7sm8582567f8f.39.2024.10.13.05.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 05:55:33 -0700 (PDT)
Message-ID: <4c190f41-eac4-4dfa-8667-368f57b9f445@gmail.com>
Date: Sun, 13 Oct 2024 14:55:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vchiq_arm: Fix missing refcount decrement in
 error path for fw_node
To: Umang Jain <umang.jain@ideasonboard.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stefan Wahren <wahrenst@gmx.net>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241013-vchiq_arm-of_node_put-v1-1-f72b2a6e47d0@gmail.com>
 <e88e5faf-d88a-4ce9-948a-c976c2969cad@ideasonboard.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <e88e5faf-d88a-4ce9-948a-c976c2969cad@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/10/2024 13:36, Umang Jain wrote:
> Hi Javier,
> 
> Thank you for the patch.
> 
> On 13/10/24 4:12 pm, Javier Carrasco wrote:
>> An error path was introduced without including the required call to
>> of_node_put() to decrement the node's refcount and avoid leaking memory.
>> If the call to kzalloc() for 'mgmt' fails, the probe returns without
>> decrementing the refcount.
>>
>> Use the automatic cleanup facility to fix the bug and protect the code
>> against new error paths where the call to of_node_put() might be missing
>> again.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 1c9e16b73166 ("staging: vc04_services: vchiq_arm: Split driver
>> static and runtime data")
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 6 +
>> +----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/
>> vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/
>> vchiq_arm.c
>> index 27ceaac8f6cc..792cf3a807e1 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> @@ -1332,7 +1332,8 @@ MODULE_DEVICE_TABLE(of, vchiq_of_match);
>>     static int vchiq_probe(struct platform_device *pdev)
>>   {
>> -    struct device_node *fw_node;
>> +    struct device_node *fw_node __free(device_node) =
>> +        of_find_compatible_node(NULL, NULL, "raspberrypi,bcm2835-
>> firmware");
> 
> How about :
> 
> +    struct device_node *fw_node __free(device_node) = NULL;
> 
>>       const struct vchiq_platform_info *info;
>>       struct vchiq_drv_mgmt *mgmt;
>>       int ret;
>> @@ -1341,8 +1342,6 @@ static int vchiq_probe(struct platform_device
>> *pdev)
>>       if (!info)
>>           return -EINVAL;
>>   -    fw_node = of_find_compatible_node(NULL, NULL,
>> -                      "raspberrypi,bcm2835-firmware");
> 
> And undo this (i.e. keep the of_find_compatible_node() call here
> 
> This helps with readability as there is a NULL check just after this.
>>       if (!fw_node) {
>>           dev_err(&pdev->dev, "Missing firmware node\n");
>>           return -ENOENT;
>> @@ -1353,7 +1352,6 @@ static int vchiq_probe(struct platform_device
>> *pdev)
>>           return -ENOMEM;
>>         mgmt->fw = devm_rpi_firmware_get(&pdev->dev, fw_node);
>> -    of_node_put(fw_node);
> 
> And this change remains the same.
>>       if (!mgmt->fw)
>>           return -EPROBE_DEFER;
>>  
>> ---
>> base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
>> change-id: 20241013-vchiq_arm-of_node_put-60a5eaaafd70
>>
>> Best regards,
> 


Hi Umang,

Sure, I am fine with that too.

Depending on the maintainer, the preferred approach varies: a single
initialization at the top whenever possible, a declaration right before
its first usage (not my favorite), or a NULL initialization first. I
will send a v2 with the latter i.e. what you suggested, as it keeps
everything more similar to what it used to be.

Thanks and best regards,
Javier Carrasco

