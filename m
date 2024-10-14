Return-Path: <stable+bounces-83740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573E399C263
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 10:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D508B1F21C0E
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 08:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9251487DD;
	Mon, 14 Oct 2024 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMRpz+pU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA89A14B07E;
	Mon, 14 Oct 2024 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892795; cv=none; b=bwQwJP0O0A/UAO00Q/3UwdimIiMJUmcInecHgZx+C2dIidV0yj8SottcpQYncVccvKSczAAnPUHzbv84I5NAvBXns32JR667f0uBcge/2AxiVDTodHg0m2q0sTH9gjTFBitVIwNsUw5W/MeaqfIVbwaBTgYqZjmugJuc2mH3B1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892795; c=relaxed/simple;
	bh=9b57sG45FvuDPhVm5+UXFXwSv59mmf+8A6h+o090QbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJUNWiaVvWOAZiN0lJmcWNcA4cl+wmKsQnXi+DfFFrEAAo+Fvugo0mfBslEGbHtp6SBvXPY6BiXUdIa5My2svuIXuJPs3jZLSby2heTJu1WoHu6NaY3oXsPes5tT8ResksA9sIXPjObaKkK4OUu5xVF5+C04TT6QHlObMNkOtiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMRpz+pU; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c960af31daso1993373a12.3;
        Mon, 14 Oct 2024 00:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728892792; x=1729497592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UwDgJJBgVI+rKYRnl0lco2RnJ2B058QDa6wjhyx1u48=;
        b=VMRpz+pUJUyVfL847bjiOCQNbtMUp/11SoFDChfjO5BGexzqA4SRKg15lhYYc+EOmo
         dD+SSFJVQ07O007xv137qrtWp1kkx2ykffAWubpd1Ot/Pk02iQyIFgKghOmBRwnopVHr
         s3LU4NL0xpxC44A7yqgHKkevGb/FEpTWAmDdIU7Pw3hVdfqRMplG/0093S7BPaM7C6oK
         G8ZyZMt1Snfbf9zqN0TIUpbbYkZSoO7dqmWid1tiyE4y9wdQRnh4+rAvMCnebb+DcDZa
         UyjPJ2jl8QBlmCxCch7K74HkyWZDFqtgF59RfVAz/6ClVv9obKcWzMHsL1xxJMzXvijh
         7XDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892792; x=1729497592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwDgJJBgVI+rKYRnl0lco2RnJ2B058QDa6wjhyx1u48=;
        b=Dm6FIa90foCMS7JEu4pk8R0j8m/pCZyvlU46yfyklr8Cy3tlRVWtvp2Yi3ZkfyCP7m
         UDw2aF72iW8f71tD6x99eMQoDHqGsFKrhzaIesnvqqnql5USYhQOTiM253K6sIReV0uI
         Bu4LU9Gpo1q+FlRnwXjmJe2uH0yyDv+ml3PlmdruysVf5wZlV5W7OWxPy7qy1fdljWHs
         reCF0FVvBoHWlC0FE+kTpSBYTGwxZBligd9DSVeWmOWR9Bk1omDBD5tQMLZng6IRyu43
         ayXeEYFItIRBHrDHu9EHx1QtpCnII0ZR/lK3t4tRDSEKSeBARhYhXiWTRJKpF4Kze71X
         WvDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhwvrCY+YYlgpAul3puysH2VEhvI/5xy+GnrsITMYMvBG5f2BvKqZjAN9dXvmOav/ULnOV2QBHi5W5ZB8=@vger.kernel.org, AJvYcCXvGJ62G37NVE3rSstOSRLEtEUZ1hsfUtQE/ThZYIg6XR3tdyQf5apzlI4Sxieujq+oz3erFmHH@vger.kernel.org
X-Gm-Message-State: AOJu0YzNHEge0ciRWFZ8iZkmYclGHFChvkWsIVOX9iqTjp/pvqXSyywJ
	PQ+ZiySMyOQX9ghoTAW4L8Te9hwofG22g2skR7bH5XhB7k5zGWrb
X-Google-Smtp-Source: AGHT+IH6dcjsU6AoshAvJ06MVXKH4KbDBqAVpjet4uHtQ/Iw9N+qN6q/+bdSl3OLiTRxh6au3cNtFg==
X-Received: by 2002:a17:907:3ea2:b0:a99:e4db:4909 with SMTP id a640c23a62f3a-a99e4db4aa7mr780638866b.15.1728892791740;
        Mon, 14 Oct 2024 00:59:51 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f86fa986sm244025066b.92.2024.10.14.00.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 00:59:51 -0700 (PDT)
Message-ID: <47c7694c-25e1-4fe1-ae3c-855178d3d065@gmail.com>
Date: Mon, 14 Oct 2024 09:59:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vchiq_arm: Fix missing refcount decrement in
 error path for fw_node
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stefan Wahren <wahrenst@gmx.net>, Umang Jain <umang.jain@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241013-vchiq_arm-of_node_put-v1-1-f72b2a6e47d0@gmail.com>
 <a4283afc-f869-4048-90b4-1775acb9adda@stanley.mountain>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <a4283afc-f869-4048-90b4-1775acb9adda@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2024 09:22, Dan Carpenter wrote:
> On Sun, Oct 13, 2024 at 12:42:32PM +0200, Javier Carrasco wrote:
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
>> Fixes: 1c9e16b73166 ("staging: vc04_services: vchiq_arm: Split driver static and runtime data")
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> index 27ceaac8f6cc..792cf3a807e1 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> @@ -1332,7 +1332,8 @@ MODULE_DEVICE_TABLE(of, vchiq_of_match);
>>  
>>  static int vchiq_probe(struct platform_device *pdev)
>>  {
>> -	struct device_node *fw_node;
>> +	struct device_node *fw_node __free(device_node) =
>> +		of_find_compatible_node(NULL, NULL, "raspberrypi,bcm2835-firmware");
>>  	const struct vchiq_platform_info *info;
>>  	struct vchiq_drv_mgmt *mgmt;
>>  	int ret;
>> @@ -1341,8 +1342,6 @@ static int vchiq_probe(struct platform_device *pdev)
>>  	if (!info)
>>  		return -EINVAL;
>>  
>> -	fw_node = of_find_compatible_node(NULL, NULL,
>> -					  "raspberrypi,bcm2835-firmware");
> 
> Perhaps it's better to declare the variable here so that the function and the
> error handling are next to each other.
> 
> 	if (!info)
> 		return -EINVAL;
> 
> 	struct device_node *fw_node __free(device_node) =
> 		of_find_compatible_node(NULL, NULL, "raspberrypi,bcm2835-firmware");
> 	if (!fw_node) {
> 
> 	...
> 
> This is why we lifted the rule that variables had to be declared at the start
> of a function.
> 
> regards,
> dan carpenter
> 

This approach is great as long as the maintainer accepts mid-scope
variable declaration and the goto instructions get refactored, as stated
in cleanup.h.

The first point is not being that problematic so far, but the second one
is trickier, and we all have to take special care to avoid such issues,
even if they don't look dangerous in the current code, because adding a
goto where there cleanup attribute is already used can be overlooked as
well.

Actually there are goto instructions in the function, but at least in
their current form they are as harmless as useless. I will refactor them
anyway in another patch to stick to the recommendations, and declare the
device_node right before its first usage for v2.

Thanks and best regards,
Javier Carrasco

