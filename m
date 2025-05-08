Return-Path: <stable+bounces-142930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D69DAB04BB
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 22:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346E31BA26C7
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 20:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45CC28C006;
	Thu,  8 May 2025 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4sYyo6N"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFC928BA82;
	Thu,  8 May 2025 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746736669; cv=none; b=eaa2/rdIdvd9AtxfAPxwR3eQqDympGmiNX/kRD5wV0N7+O5s6jKB/lfohsKrZm7EFgd+jxcOB+gbbEYy4UEkU5QDuvf1QzvptAZnFzysgEW+lg6CJ/Fvl+ZyPFmnU9Nb/Fs93s6gJZTn/Wiun1P/RBb+EQFOk398oaskbGXfLVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746736669; c=relaxed/simple;
	bh=IlZ2JgLQeZR//pkXonNxC8ho6MNB8ZvszUYZZkkxipQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jljn6jD741J+HSuupkq/Pr/lBU+440uSGAidmcBYZOehvFELRzG3XaI3WlWYVN+I5HmPeXfqquKVBIQFlMsdSnJo/WtXjU88I8XtPGG3fQWXsgrE+l038JWlChW3HGvKeuXHiwPpQKUrjt+Vnxzu7SkTnb7clxi5ufxGErUFUKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4sYyo6N; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso1802854b3a.2;
        Thu, 08 May 2025 13:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746736667; x=1747341467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ysNlZssSzwU7Kko7fU5Y5VNdzVq6jh3lbTMABCRGORU=;
        b=N4sYyo6NpknHaJi33gxWsGIUkKdJg36EtdIjV5/330rGpK4EPlwKvIgyviRqmkC1nm
         tCrp5iR7fMbto7MAGQDDIT7Npk6FDJtLIHuVczRfiQc94gZU3LR3n/Ut5FhwohLRAR1j
         15pzunRFFHojHQJPgpw5gdF+U46Xq8859Ak6JGVsmHKClTUZ/xCOeJqQPiknSBlXGAnn
         uoOf1ind4Z9VrjKla0jtyUF1REWfxXohXjw/joelgaIZVRpOAImD9PqI7nVn28CxKb21
         9HS+i0bRqp/s2VkmFt6ZNdLxvEJl6lxSp9HJONTN9VYgmvySnwo4jr7KRJBxHazQhu/i
         lKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746736667; x=1747341467;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysNlZssSzwU7Kko7fU5Y5VNdzVq6jh3lbTMABCRGORU=;
        b=hxLB5+eRwjaY8FqQPOpw+HYpZI+kMHmk4alBoXv1zBizWnbnSOYg/+77luisjez3Hl
         Af34Qtlti8nXhCEKdKiGa2U7Js4J9nsQUlG7dv3KGVycrKu8psnBz2rbIHCr8Np1CidM
         inDzDx75kGFBGyHItyZrhPRReu0stGWxjzl/z7x2riiRCqfuoA4Mu1O9X4CYA8bKR4El
         ClDM/bPT88BRGurXhd18SkgUQIeA3YYmVbxtiGwY+A2cwQuXJBiEN35VQ1ZDZ2JWHZHb
         z8vB0x482MB4O8u1kY/Hw64wdQA9b8RgCjTS3EaIGMSBxd01KT4yBwTJLeM4TgRRtVBp
         Wz8g==
X-Forwarded-Encrypted: i=1; AJvYcCUyqtijuMAissSIRQzSwwMaiCamcYR5NwIFSym5FkgNUx5+3rn8EZKhUpqRYEppKK73aAWbXskL@vger.kernel.org, AJvYcCVHkEyBIFj/LRsaObnh0d9hstFEX/VW09+B6PaoyXcMwY2fGC9vV47x8YM7C8BZX21kLu46F+RgqdwpsyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm6+nLftSXbaKhpjtK2bhd7J0sYY/kb0H5Kae7bjSmqN4cyd+0
	VfA4KRMlob2NZmF0uFrceLmJZEnSw5jRPpZ2npAuSVqZx0I8iSwZ
X-Gm-Gg: ASbGncuEM51By+cdYSmo5r8xRNFzJy2QAdpW7UJFC2z1uXlxlOvZkacGeq2+Ri45Hrk
	6HIl7OJUKk04/8i3N/CNV0ZL7tczrwn/pKWiGcLrnksKNEskx49mLhxE2hSonIHtITKwK0eTdE2
	sGlmMfQxrdqDVlEfCn4HKajt72LA8mxpBnCDFG0zY2EdyTfTtAHEX8BuJ3zA7aYVduI9XuWknry
	UkQGDBj/Q/uQlwUzbQX7kH9Fdg9l4BQiMdXvIg/90AO5JwQK8nlx072tHZ/aplz+in1BXWIQxXZ
	AapjF8LKIF1LUn/2To3GwcRgLNcoxwLfRNUYcFZDII7HVLZI/Med8annlTI/E4axTcQmf4QBctc
	R/In0
X-Google-Smtp-Source: AGHT+IE8J/x/3mlye21FbKe7QiKbsMD8WVJ2s7U14Sbz6Lrw05tImS1mJS2Dp9ZcKsHMnpb/yzmtrA==
X-Received: by 2002:a05:6a00:a10:b0:736:6ecd:8e34 with SMTP id d2e1a72fcca58-7423c04129cmr967854b3a.18.1746736667316;
        Thu, 08 May 2025 13:37:47 -0700 (PDT)
Received: from [192.168.1.177] (46.37.67.37.rev.sfr.net. [37.67.37.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a8f520sm454541b3a.172.2025.05.08.13.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 13:37:46 -0700 (PDT)
Message-ID: <3e25aec6-6726-4dfc-9ff1-21a3dc62446e@gmail.com>
Date: Thu, 8 May 2025 22:37:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/183] 6.14.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250507183824.682671926@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/7/2025 8:37 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.6 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 May 2025 18:37:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


