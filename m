Return-Path: <stable+bounces-144488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E25CFAB8023
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 10:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD93A7A17CD
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 08:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15E42AF1B;
	Thu, 15 May 2025 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7ecSAX8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D89F1FFC59;
	Thu, 15 May 2025 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297118; cv=none; b=hCB0/6L0OZO0VsalWFje2pY4PSrGLIwhd4JQSEWNGsh1F8VlaPiiCOwZ5CHrnzqRbPeceXuZw0kchhq1cJ0g2PnFHQ9ZgHHwP5i4/+8Nr2/ib4uL9CnIi5Nvcj4yQB8VuBOD2gEnbGVA+KqvKPhe4vk8cfVSKXtrlT9nUr/NTuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297118; c=relaxed/simple;
	bh=kARTLmU5kuLFfhOtdN/ZSLfUtl52NOdzWPJwjF3ngTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e60DAlUNtQv1NVQmzIznfB7QGSx7b9gDsfJ1MJGK6lujArJoMOkqgXtCh0pVBorhr3MUHaxn7gDJ9i6icW7Pn0nYbrEUlEojsCOtRisimZZcmCsQfM/LYIWIuIOEu96uvjgH3AtAh0dwdOsmXNePD2vRUvcz/gze0Yv2NQ38N1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7ecSAX8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-231c86bffc1so125685ad.0;
        Thu, 15 May 2025 01:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747297116; x=1747901916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=488WlQhNXKWBMBMiHUKNjpxHao5V1ORTjyvAiWEOJDg=;
        b=U7ecSAX8Zv6/kzxX0G9t5pauYnRFtaIaLSq6qc7oi9Qrb2rzrp++sqO4NF8bDybRMD
         edDaEsCQUa7eHUzSyyDdojCFf+nBE//Xj+G0Cgf59bpHtLOyGDsZ0TFuiJyySokpB6+a
         y9JQ9nxrvb3Bd6Kp3FHVaE+ejecdZISaVnCJo8SBQMVTNfCmlRpZAkLxv+rgsK+oVILP
         F6OIscBbbzh/yEZrA5t1jq2XMMUgg+zEY4GsmYHcqXaEb2jtkYVWzi0q1vUQtYoiw/Vj
         cREP/R08dqvGQPZOOHwNdef5zmOVmxCjFwth6LiwRhKbHoxQjSDinQs8xAIACdNi1Nu1
         542w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747297116; x=1747901916;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=488WlQhNXKWBMBMiHUKNjpxHao5V1ORTjyvAiWEOJDg=;
        b=SE/BCJuF7zgVUKLJqejDHsALHoh3i0kJ0pEbue810d1Yle4mLO9s/GYS/DWgyLmPD/
         SA7Lu7iIkGIcbpcNBWPq0GRsiKV0SVnpsimyUPZZscqE1oSIs10j9VyAYfyOND+n10uo
         aCbHJkNNxB6t8ueVThhzmC1ixJtt95YnjmARuhmCIvRkHMWI5BVOmPQt+NFmDWDeKFe9
         BVYYxBk5Q1WUfbPxPHk4E5/PvLpQ1JFPuuz7lrz1g7hdPlpAvcSf46n137mO6ujNCVw9
         o6dE1F7ua15smpYcw/B2kvR53kqCeZOfpakoOgvnA4pkejPcyNIm9w4HAPbYpiDpiaB6
         0mFA==
X-Forwarded-Encrypted: i=1; AJvYcCURBQxl9bOVKlXLwv/68bQB4eqTELuxWVJu6WtciJ3cOhYrT7W8RIl/SolFGd+OiHSoHnXlqLJC@vger.kernel.org, AJvYcCUzFHBMNsAbuQafdqgElelKm7sRYshiYE++NEgtIFx9eRMm02tPhX5HNTFq41X26oM/qZ99+rFkWg34Zs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrEfBwUIiAyWqrp3DnV5ZR/e92psDS8O5RVYI1H/BVirwN+d1p
	HJllAJF7KAAbu0eaq6QzQgH1D+sALZhVF0e/ctBBMy0HYP/iKPVY
X-Gm-Gg: ASbGncs1wplKTxMCjC2JK8g1iOwaA3AlNY+hp8bHdBKzM4nw7eraExqxDIhct10YBJC
	Tew3a8SWUJwWpBoeDromcT09H/ytPfJoMn8slTjr3vgdR+6im80F54diZabV7JU2/hoVpswXMkB
	SnxqvfXrI8iFgWewCwqqzx8ILLW0dAEn+BHjyKSBMZZzk+ykM4x1D7UmK1tq9649JbwBNh96ooZ
	qonxtv8YDy4Oo+0BU90Yt8cJ+KE0t/TB0zq5+ypUz6kc5ApX0ETr2AK1+mWl9/TnwDyhuG56fkj
	gKWRz/wWlE6YWtbWIXAVB35j5WfCyTW5SiFp/15780xvXcs52YtR6giQJc7oVjtSK/pxJGYar8o
	j2uLPM/QPvfAVGPvhpubfSE7YK4nwnu9Zs9QqkQ==
X-Google-Smtp-Source: AGHT+IEmHYGzIw5wI4zfX6bwzFtPTL6OX67lRx08pliFgQuw/ue8uTDF6c+KrkOx8EmMyB5MZh2OzA==
X-Received: by 2002:a17:903:22ca:b0:22e:7e9d:9529 with SMTP id d9443c01a7336-231b6073bbbmr17655425ad.20.1747297116247;
        Thu, 15 May 2025 01:18:36 -0700 (PDT)
Received: from [192.168.48.133] (mobile-166-176-123-50.mycingular.net. [166.176.123.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231b92e1c3bsm5755665ad.252.2025.05.15.01.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 01:18:35 -0700 (PDT)
Message-ID: <7c2c06c6-d1b9-403a-a7ab-ac879a3fa08c@gmail.com>
Date: Thu, 15 May 2025 10:18:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/184] 6.12.29-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250514125624.330060065@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250514125624.330060065@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/14/2025 3:03 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.29 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 16 May 2025 12:55:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.29-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernel, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


