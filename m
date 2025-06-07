Return-Path: <stable+bounces-151864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 920B0AD0E89
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 18:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5927516BC1D
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA1E1E7C16;
	Sat,  7 Jun 2025 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joF6nFwO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500AA1DC9B0;
	Sat,  7 Jun 2025 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749313350; cv=none; b=iw911hCbct8SHjulWnab1KMO9ruMG19esEJSI/+iYxHJrTn6rElqN0LScxjfXPBHD7ShnPSVxfyOfZ2MB1HQL4XvQeNWqCJ42YNxl2jW+m0O5gv8dl/Ngt4lZkfGeTycb7ve0sED3ppYXjIg0eAWgWTkf0YBe8vNag3GJNPABAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749313350; c=relaxed/simple;
	bh=KGjFQ/pRR7uWd+NfvBCbk6R62Q+qLv3QFPVcmJ4Qiyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bh5s3XBlvxRriH/gmd6MzG6OWUCVrP4vqlWjtGUAVaoBQwhCArbyqGY+UKW2CpOAui047tKf/hhXGsJ32MAPbtdvbIQ7Eaq5gBStP9mWpH2YiKBLm+h04yz0k8P/H+0Ujdp96w+xUBFB1F/5P7bmQ7sQZrdVCfuRVFgXBsMjUfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joF6nFwO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-747fc7506d4so3026724b3a.0;
        Sat, 07 Jun 2025 09:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749313348; x=1749918148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pKfAycSgHm+wEJ5QfR9KpLZ1HuBkOI504kMToFFmoqQ=;
        b=joF6nFwOIZ9YjsZ/i68pFjgO8Dp/mmIcLah5BjdHjjHnAlAM4jBaoWvDRGVvckRXbn
         o7+scRRHWiUAJInOe9/rIBfZO3lVNs6ixSdiIu/6nhpvJnSmO/rROEeHxfJfei3tXyb7
         bT4VY0lXhJENarosNkD/8acpXOwdZXDYvw5rm4IkZXJPsPlytgl812Z9kzjEOUiOsVOl
         BOI3ikbGwkbi9LV7LEwMdLAPPw5T8Q76G7GtYHbik+uxjoZAI1MehgeMEwnC2BoEwRZD
         6HLNDih1Le38pZnY1F1HyjakQ77cBjHwgCSk/bWgPfC5FIWR1dyHmsJaZ89iVmVxPxAw
         Mwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749313348; x=1749918148;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKfAycSgHm+wEJ5QfR9KpLZ1HuBkOI504kMToFFmoqQ=;
        b=tU6FX5O8w54Pn8Nw+Sk1QH++FJQIroNcu59RKrGwy/vtyhiGamiGGNj3fX6uxNqlDc
         VnGuTtpaFmbk2BGFzLDUpCwfk4WaWZEBBKmtO5OElVkA6hMflZwMlfmlqtU1TuHu+C0u
         UNqCLLFxb8z1gS963mU4Zu6SfkMIWyoEcGTcGMmFBcqETT8ExXJePUOPQ1qR0CBuYINM
         Dtuldvwtl+S3fS1ZvlHjV29ouKSn1AG2A7DMtmAY7LerPKyH9i7wiVPuSt95MSLJbugk
         folxQ6lNufV/qiygVDrMaIr1jhOnXyI5EU0WugpEQc4HdEKla7S4pwmHZ2ikFt+utKuy
         CEFg==
X-Forwarded-Encrypted: i=1; AJvYcCUufco8t3tHAnct0yb66QNqw9NnH8SRIjtU1QdjQSp9/uyuWOqyXiAsMI49NMB5IfvqQUIpi5G9@vger.kernel.org, AJvYcCXsQrDY0hG3FSwYXuWrBtUU7DxiiwWFe4Noj1ZBkRvKnMdY/gp9pVpu5RzqrGj2Cv61bUtyGyBndcnvdA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGNmuwGJUaz/XQMTpQCeXiJgiZaTmwhp9b1ZkDl+fY6giiK9/g
	+WOqKmBshpDF+ikRGxch0i/mospBsU3twMre83/Y4SIQTM43TG6F5V8p2YVKP2OI
X-Gm-Gg: ASbGnctEQfzmPitKaQBliPXrHtQesBFDsuZzNJ679zIq6cibfFNHTJz2Q9Qidvf0ATV
	hLS+e3b4pLNf46ZAYjUGangNshjMdgfile76pZqQak2aP04ea135ivfOSmmKMswRXKhn0jPb+NF
	vsMyr/O4QcF9lxBEQjhqctMsKkj0tIpspyUE90M5oMMaYzdYzku+dnoUgyKRDh57437hrDJOCDK
	RyL/2XPni9gE0xW8pW0KM4XAWKqpb9AHIFqRBNuHn3zOTXf8FPdPI5rLI6xHVcHxIe/sQJF8mO4
	l+UA5Ed4gC7TyNYPeALXT8636nJwhKwDVSiW4WeMXc8gZuRzz/DWMQ/sNce9ZGxVkHS5HAhTCss
	CoSnKAZMzO0Tb6G4fNCLygwS5QCj2k9ksjFuoxPY=
X-Google-Smtp-Source: AGHT+IF63664Y3gN+/MlOX5BvUkOrFm0EXw1m/KIP7dkCwfMPu5m2ABq7UUeg3PWYRW6opIPQPsKgg==
X-Received: by 2002:a05:6a20:431d:b0:215:d28e:8dc2 with SMTP id adf61e73a8af0-21ee25d8ac0mr9432279637.31.1749313348481;
        Sat, 07 Jun 2025 09:22:28 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b084f60sm2996981b3a.101.2025.06.07.09.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jun 2025 09:22:27 -0700 (PDT)
Message-ID: <32828e1d-86a8-4467-842e-32cf4ad5a371@gmail.com>
Date: Sat, 7 Jun 2025 09:22:18 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 00/24] 6.14.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250607100717.706871523@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250607100717.706871523@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/7/2025 3:07 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.11 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 09 Jun 2025 10:07:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


