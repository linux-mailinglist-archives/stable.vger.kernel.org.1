Return-Path: <stable+bounces-160100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CDDAF7FAC
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 20:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22EF1BC21E3
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 18:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59BC1D5CE5;
	Thu,  3 Jul 2025 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb0UOsbS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C4920102C;
	Thu,  3 Jul 2025 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751566729; cv=none; b=rGbMoftY/1XgoENEkVTiGUQOkmCtYfgVxzDiVLXdvMVQxPqUrvuuWCxb4Tr1BIyUgHO0HDEd7i0G7XiGtuZg4kswq3e2NOfKg4cxde9xpSnzJ6knyZaUeHymyLUa+BZ2SVdNpFkA4YTuP1zSJLrKc+kcqDAwxQaPZksOTd6btNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751566729; c=relaxed/simple;
	bh=GxNdkH6iQCVxUnWcMd51/S+Cd967xzHQCnfjJ0BAEN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5E/aFbkZ70WeWOytjx6lHxjJwXKGIBNF5CAbqVhla1Q02ZEUUecbXJc6yS2rHEfMoN0iaAirJS106BkcLEj6OwnEYBOKR271Kg2Qa+NyY6w49ltwUgHG8b3EpJUw1oIe3V3VvU6D/C/5wrHsoh7tVkA/7298QjO+qLhqgvK/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb0UOsbS; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so384171b3a.0;
        Thu, 03 Jul 2025 11:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751566727; x=1752171527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pq9v1egaCEmmTn6tGC6wjXjlzVVZKLgrhcUxwPAiILE=;
        b=Bb0UOsbSHdMqiTw3bFB+hyoV3wqrK9ShJq+NEIfPIneG6QJUWaCjTWR2oXnUd+R8++
         1FWs3CPCydvegnIYRrxTrBbU1OCIEmoi9BounIQRdnLTyPo6nwrGQA0sss0PPrDbPstz
         qZbwVmbq+xHwP6DdfzEcQAOlEFEVlZ1hKCnPJqNRp3TYPpms0r5tI4AkaYXuiCfEA3R4
         PE2h9TzgrnzagtxLxZdHHei1cxDSn3ehzDD3xK6P/DLJKDXhpohXbCriHlEXI3XhG+0q
         6Tsm9BX1+WLgKaAGgiapzSCfSOI7r8VvuYWX5uVMqC87K0iWMsybfvlRvn1ujHFl8We4
         veDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751566727; x=1752171527;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pq9v1egaCEmmTn6tGC6wjXjlzVVZKLgrhcUxwPAiILE=;
        b=OOY/lz8pWsY5as24U/LYIPTKQKESiOu4cCYQGnx4Hj7OEDCTGkhEANMbtdX5MAy/KM
         17N8Oy8ry4yljqWTZPMyalxpea5OyZC/kpdIIKYyR/lubI2tenali+fUEib3ASFQ3tTC
         w8GvZc1g2XwH07yeJpSHAPhrAXi9jt0RM84Gs6UjSrLJEHqZphzaDqv6PV+IpoGQmbwj
         nL/F+oZwaagw6fqYP+UOOpiIV2N8u1S0L8zZqGrGypN50/yShgWZt35gO1N22krJuPAv
         dZ5qMYlZTbzTf05OJdOcf6M/6cmRXkLobPU2FNgLrjMyCv3Fja9IsgY4WXzfVGH9ZXu3
         vmTg==
X-Forwarded-Encrypted: i=1; AJvYcCUf0+B4VNtl0P3xMPuDUqk3f1PjAz5ZegCIwBNJhaQYrzDf/DCFD+8Z6jhGsd2Iz3aBNyPPmm/NvMQBo60=@vger.kernel.org, AJvYcCVeiBrkq67Z6EkuZBL/0xloCbFyhZntPnb/TY14mifGnF8QczlS9I6BabncHou1hBan0vwVZN4P@vger.kernel.org
X-Gm-Message-State: AOJu0YyBZ02BMCVewtmI6XcGpDzo8C1XbcqaFLsJFsCjnNqSugcA3PwB
	zqi8uaXB+QwhM0eW7g2MVrlG6A8DCeYPiUQ81Ix/YAxj/SUeHcq7nBmx
X-Gm-Gg: ASbGnctBBzQxoqNqDDRSS8bdukR8DS4XjM6jbuXyhlheBnG0bzLsezaXL0mdcbkn6Ba
	zIKMPNRoy9GvEZmZrErHB9dfnt3fezyugO2tc1yflHAXXgWWoAFmHGRjgjSUCO2W0MGn6UNecgX
	BsEoI4gsthSlCdXQiHo+MNtfdDzldQOU2T3L9L0xIDQZBsIKod1MHTgCg3Jb1l6Hc87w6ydUjn/
	PAd2dzSfrt2+tE5L4ArrrCLP9LsvTZxgpSFYkBRjuA8Gpd127TtaGPV7otzPc5srPcHhPhlx1S8
	KTmrrBpPp82jWxyWHSUakYLw9vMN3EXSbQfr8q/cvzOfpfAXjr492cv1Lg+z/XaKPuXgjNx7fdC
	//Sxcx+3RYmYeNQ==
X-Google-Smtp-Source: AGHT+IFLjwBAdlDd9cJlKxJ/HWzmu1qfhTpB86GtUGtpcDuu6Hmo8yAkYKnsm3qK15sOpO/111juCA==
X-Received: by 2002:a05:6a21:3283:b0:1f5:83bd:6cc1 with SMTP id adf61e73a8af0-222d7c4a868mr12704320637.0.1751566727396;
        Thu, 03 Jul 2025 11:18:47 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cd564sm185777b3a.56.2025.07.03.11.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 11:18:46 -0700 (PDT)
Message-ID: <d7d9fea8-75b8-4b04-ab1c-e879ee3c89a6@gmail.com>
Date: Thu, 3 Jul 2025 11:18:45 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/263] 6.15.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250703144004.276210867@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/25 07:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.5 release.
> There are 263 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Jul 2025 14:39:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

