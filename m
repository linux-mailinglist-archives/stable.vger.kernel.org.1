Return-Path: <stable+bounces-180568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF43B863CD
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 19:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC10C7E24C3
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 17:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8AD301034;
	Thu, 18 Sep 2025 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2Vjje6E"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F310271457
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216973; cv=none; b=ms5gygsVgDUxHMZB3GxjRdB30JuS05ygE+s8TvADAzoTGv4n7i8P3AQYvaarc0TevgnIt9jGxm2l7viocUP8l/Isp2Rn066yQnr8XL9HYg00HNP1+8UHxL2bKZYvPb75vXk3rD80V+j53suwHke5Ll9KqyAmp5+BjMi5l55iflI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216973; c=relaxed/simple;
	bh=ZXbaHmRM8KqMo9Rpcnfozlk/rnX9FPWIWh/XsK0EWNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NG5ZH7bJR4LxEb0w0ivkvvxalxpyqdYFi5NaW9ZdIVw9tZl9wD7U2gB/xrdnVLAqXeF+zlMJysr6TdPX+JpoPs3P6pMNbPwSGw6bFUlGFAf1lWL4mJ6SnFpvAN0M4eWmR69rQaoCQOGW4iCgIyiYr2wteaTb4Vz+R5XDt3O/QUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2Vjje6E; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77d94c6562fso918928b3a.2
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 10:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758216971; x=1758821771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tsxf+NCfwQTy7IF7OgULgyswOvJ4vCb8Kqu8TwhCbLo=;
        b=i2Vjje6EiZGogEBw5iKkmB/2/hskrhh70+UeJHnj+HzrJyftlmdQ/AP3TBhwSJ/tJ5
         hJ04TpCjv0BhIfZ7S/uybpNQ6AmjErAXgvRd+PSYztOZvvVn21NLOjpc6wa9uKY5lCu+
         P/FAdWVrRDU7QFLYiI93eWHrcGJq9Xo/5UHrtyjwM3eeYWFfkJ//Z6D2rN0WIXg7QX34
         wYFJ+6VH2b4r6SjAfD+IsylBipABp3dcvDGfU9GIoMWKtmrb317TXtYnCVX+2VBqf5MJ
         7osgn/5HqTPY0Ykno/CfKWFlOSDXIGhn4TU+N+MGRq7kmyfrqEYqxPF3ZTjYLnvy/8gL
         xc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758216971; x=1758821771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tsxf+NCfwQTy7IF7OgULgyswOvJ4vCb8Kqu8TwhCbLo=;
        b=VeBbDtQQkVYpVHnDlbuQWoYYD0gDNEdeztXxsjULooH2PGocMS6v6wqTHAW+xGejfo
         ogRjJ7TqRhoTsDcZ4qrEy5OYslHQuI+yc2LO2YqV2epggrwPNJOfx47PCTc+HvV4/6lA
         hbtZb9+ZOsvnUQFoqzixLX5Jqo2Yc7VpVVGA97rs022TMDxdKM+5XSJfE0nKZ826NkIQ
         MXs5wmKgLZblcXI/Inq+WLJMATc+7oZdY2rHtJpVUtboPCV5FDIb1mqBHeF82BSSIDz6
         HiM0JonYcVNzkbyaZbba9ujlU1czWAC+Tx5S/1YXrFQHJAVqKLZy9J6KpHroj2Uh+uuK
         VVow==
X-Forwarded-Encrypted: i=1; AJvYcCXYB1ooWQydDq+MVWcvq/0zyv5FKVkIuPGJ7Gheb2FPG/LIih2gha31EzmpbX5t818YCwmysSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPXkCpMMJPNNNdK9PZIVeZs4d1rmm7LFi96dx6teVijpoqNFeY
	NcNC3eDrhZUSANvYnohz9ySbo8F912KGD7rjgk4JbA4hLD1QS2w1h/1b
X-Gm-Gg: ASbGnctrBE91TjqzgZldFkXoZ2D1inzwBNZON7wq13T+pa0TfeX1N++BMuBQjUo4CDF
	xXfYugDAVqBnEiZNVCVX7BudRFWL0WeyicWxvAq4xc2/wDVcUWIMdk1b6zUq5XuNQTn6WRJH04z
	u0jfI0uQLfeC4heOA//Fft3L/cec91du7x3kgi0sbNV+W7sksF7GP0StCrUoUnq/eeQ/xaifbJt
	3Wx0ZCG9Ev2j/gmqORG1AX8KnAFF1M6FEP4zu1jClMh3Wklg0bJ4NtutmhjBOLrlK60NF/40xVM
	anXLpVhNdLb9cnnUXI3RlG4GA8kSugmlNVdiIbBNMVu5Ile4IJM9PJ2Mkq/Y8+cP/AXkZP54NDx
	JUT/gdGjY51LGAkKouM2Hm6o+iaaieg6igoP1r43tk2LKdPul8r5MgGZLDYn8xqrEEFPJXcafWq
	24Ez552gg=
X-Google-Smtp-Source: AGHT+IG7T75VR3u4XEDScR897hF1pONMvlMSo/qKOoVmTWVYgoLPja/DFLVz8OBuqgW1WDLHm3c+qw==
X-Received: by 2002:a05:6a00:39a3:b0:770:73ed:e6e8 with SMTP id d2e1a72fcca58-77e4eabb491mr208476b3a.22.1758216970917;
        Thu, 18 Sep 2025 10:36:10 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc537cefsm2907090b3a.39.2025.09.18.10.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 10:36:10 -0700 (PDT)
Message-ID: <8166556d-aea7-4e69-bbc4-e8af2f3a466f@gmail.com>
Date: Thu, 18 Sep 2025 10:36:07 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/101] 6.6.107-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250917123336.863698492@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250917123336.863698492@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/2025 5:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.107 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.107-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMST using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


