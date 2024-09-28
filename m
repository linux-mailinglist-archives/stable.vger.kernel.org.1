Return-Path: <stable+bounces-78191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F09909890B3
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 19:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF203281086
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 17:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733B014B06C;
	Sat, 28 Sep 2024 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BmXL/04n"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565731420B0
	for <stable@vger.kernel.org>; Sat, 28 Sep 2024 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727543706; cv=none; b=Cl3EkZYVpReCmVJjgAdKMfICgOGNyZjlfsqo7oHZr+GWgreDKiGXwwWDusqdzzI+4zzBocorawVHtppmLtBEVg+eEYeEIRYl02WKFbaA5mXmxSURJS3x9MEH4MmaLg8jesmnzp3UJzofBKsmudcd2k7AHU4ETH3Eo7cvMey8F2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727543706; c=relaxed/simple;
	bh=Pu1ra73KdXyUjtcpFItrE1RBN62ZbzDM6xOG1WA02fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/fM3cLVKn1P55Z5Vl8laCYnnUNinTREpCKTc80TD5tcoIm4bRQeSXY6t5JQY5Umz0SiEyl1VAOyIrbrOTiFyhZ1xaFtu3Ud46iMJSfT5kdT4KQKpCj31so4Xcvbi6/Y0QGOOkXt9azWRnqLeMxbEBUXeqvMHfCO1U+qqMPB8nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BmXL/04n; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-82aab679b7bso119163339f.0
        for <stable@vger.kernel.org>; Sat, 28 Sep 2024 10:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727543702; x=1728148502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxGPjaFWUVuygqvE5pSQf6l07eOds48beRCBcUthdV0=;
        b=BmXL/04nm/ikEppVxEoOvnzpEafxBZ1w6umeeojTCd2RD4r0+fwWVY713csccXCwpP
         YbL9Yf/Lr0g491yzYBLwfDZZ95IzNyaZfP+VgoryW9kvl0DhT/kbU9ImyvqfM9me5zlS
         Nuvo85TDltP2wTFpHO2GIPiV8sY9mYBxtd6Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727543702; x=1728148502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxGPjaFWUVuygqvE5pSQf6l07eOds48beRCBcUthdV0=;
        b=Fc2Yehf+R2XaXLJNTLzu0N2BwA1PzWnYZdoVJX1P7Rja2//eL0zHP3LaBWMVt2JiRz
         VulBq1Ly59VhQm722+khSwNTGdWaF8GuM2/mOcoVMC36FyVew/kyypM/TNyxGRKWgBTk
         YREMNV/zLIBX2Lt8a0q8q0UHhynmB1+esX/nSBwlg5HLCPs1ZN+2LFFZzmiRglWoo16/
         Soq0tuodgdugFcArlkLAKCzsJPU45OepBLtoJtQ3FiW8DxRuaMMUBUfD4Zpaf5nddY85
         GJftaWzg0z08F/5NydXC3iXiX3v5MYAZJ4hnYp0+QaMp1yxC7FfazkVGwkH7ZFXc6xzN
         LVow==
X-Forwarded-Encrypted: i=1; AJvYcCVgCD4RmJnIOg64m3QX7sF0g6+39Ja/sGz1sS9yH8PaZXtBHIXDfcahGpP4QJPYcstOryMN09c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3da1F8sH1dkTriYnOOW98moy6o5KEivJLdJ0KphFoKYnUDLH0
	am9Qbbi60sW8dd76yEmmbAulVdhPPCD7THOtn5usOj1Ar5P1Ilz6voK2KsVeW6Q=
X-Google-Smtp-Source: AGHT+IENEVcL0X5iIGC/9WTT4qo+F5n851jEdlV2hj5sxqNpjLyeGAHMYcoxghnlDVw8QhJIX+ePIg==
X-Received: by 2002:a05:6e02:1fcd:b0:39d:1ca5:3904 with SMTP id e9e14a558f8ab-3a34517f9bbmr51119825ab.14.1727543702425;
        Sat, 28 Sep 2024 10:15:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888d9b33sm1178093173.141.2024.09.28.10.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2024 10:15:01 -0700 (PDT)
Message-ID: <2189dd09-25f3-4b3a-a799-44626765643d@linuxfoundation.org>
Date: Sat, 28 Sep 2024 11:15:00 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 00/12] 6.11.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240927121715.213013166@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240927121715.213013166@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/24 06:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.1 release.
> There are 12 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
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

