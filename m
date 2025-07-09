Return-Path: <stable+bounces-161496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA157AFF441
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 00:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A114E3BD3BF
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 21:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118B0243951;
	Wed,  9 Jul 2025 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PiiIY3JS"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22681239E8D
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098408; cv=none; b=RmCaGYHkDXj5tzt1V2Rh0eeivHXNr99L0G5W9Jinom9/y0eV9czgsuznrqdvS2/XXy9JxDs6AD3ZT88lhoPc1t9UThjHNgmf+aJ6axMh7WLNjzAsTUndhEqsYCuWB3MLJEtYz4QM4Ecn7pt5QfSxYha0zIk++hSYZ2qTLKzX0T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098408; c=relaxed/simple;
	bh=E9Q5ZD8hLPIv4GGP/IuhXIhHJdD5qFjRVobn8MvJD5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iVD0cN/3EHZHTSyCEUTgv4aa9Pj1lHPj1y6yKGaK0LnDOniiCUayoC7hrqFiHfU/PXIzb4uiXpv6AkL9cAd3C8TkQ6iR/gpsSiLmaHdCPW0b1h0FoSazXOnlJ/4U4SxOlKv0mafqUHovZpWqo0gunPFwg8zkQri1+TXiPi5M85o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PiiIY3JS; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-875ce3c8e24so18770739f.1
        for <stable@vger.kernel.org>; Wed, 09 Jul 2025 15:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752098406; x=1752703206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85sUwqG3UTvSBY9eq2mbMCJ2LiIG5KRrSnwcZNLE650=;
        b=PiiIY3JS3/nkBflAUTf3CZjgfOR64VnQPY1aWFq1BpIDF+3yiJ6/hNw1aplN2hSLmK
         EmepSd60nhM0U9GfjpJyNPFWHJ/AS/WIn/ofZhmfyhfqf7EH8mu2yVj5c0fygN9BE3tT
         V+z+WVUhTa5k5vfdfP+rX8Vg2b1jAckYBaSho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752098406; x=1752703206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85sUwqG3UTvSBY9eq2mbMCJ2LiIG5KRrSnwcZNLE650=;
        b=sTADZn9tL0ohmu4Ttza9gTpMSa9ssdhonm5q6op8nwFeh4Pa0I+w17YLlODeC75rW9
         wWes1T+YSBmQRb86ZNYxpnQSRMC0zbmKM/4nw1qGHBWCLneM3slelqXDQymkN5ErR1Ta
         ndy8rz2vtiKRfnMrJ05QZnWQOjQsYLgiZgJAtMTQBI7QN6YPkEmHPnRZECvktfMScxJ1
         UNzGGYcZUBsRJwn1ru6hXIG8gLJtlTc7zfApDx72hjpxHuf5f/IvpgvB01j2ujEtUdI6
         bNk2JBRsil6HLbAMKxDusTYSmD+LpGjL1fc+TrAdf2g2q2ZHAUKQ8lzb3dQgxQ/L+Ksn
         a8qw==
X-Forwarded-Encrypted: i=1; AJvYcCUIfaAeSn7iUP4Uh10fGAU/euKWIYJ6aA2haeLNQ+8qOuMixSgvkHNh81F3n41kHXPPrAv1kRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYBYEwqvtQmD7CmiNU7409qCSaIB0ycnqy44dY22js3m3k5Hyz
	DvEs7KEKWgw61+NmrMr8f2DPSB/nK8HOtQ3oDXOyNRIjpifjL1lC4TqEmJLioRBaiil2DB/WjB+
	fN08m
X-Gm-Gg: ASbGnctyE4qUFB2iHrsvIr7umFPLx0kxXJsRlfHujkBKA5+icFzwH8jGW//Th7TlMWB
	2VgU1vIiGZroh7eX4VMuj5ZIBNCHtCmzhZkLK7Q/7hl52redIT8xTiEtBQIbJx19r61+Sgew0mz
	u1cUcEIqhT49OGwu1Vf82ozjnSzW8rSQ9/qx8akV2HHTZBzByQ1moeIsH1MO1E31fqCbh8+YsvA
	sc3dylX9r9GCQXcPZyKU0Yw76uAus3okwEBNo/9tmxHTDEBRhvEB9CBKl4cpOOwHhhAanFNgSAB
	yS87M8dE2VSCW0OjznwZtCHdr7yb7qIH7wLNzQtzOIg+2jR2YZeyttDuzi4Kjbx4FkRUPLN5XJs
	pA/7tAHTL
X-Google-Smtp-Source: AGHT+IHun6TfsfnEv/6FmCADt8kyWi0Ooqlkv+w+GZgNdAI9IkWYVqmqHa88dkbi68Y4nRcRs4o3SA==
X-Received: by 2002:a05:6602:4c82:b0:876:b001:2cb0 with SMTP id ca18e2360f4ac-879663b35b9mr178724039f.11.1752098406062;
        Wed, 09 Jul 2025 15:00:06 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556b25536sm33365173.133.2025.07.09.15.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 15:00:05 -0700 (PDT)
Message-ID: <903f7d9b-74dd-418d-8016-264d60cf6af9@linuxfoundation.org>
Date: Wed, 9 Jul 2025 16:00:04 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/232] 6.12.37-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250708162241.426806072@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 10:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.37 release.
> There are 232 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Jul 2025 16:22:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.37-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

