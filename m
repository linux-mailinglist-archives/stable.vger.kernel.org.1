Return-Path: <stable+bounces-150737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395EDACCBD1
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 19:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB54E167FAF
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 17:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30F61C861B;
	Tue,  3 Jun 2025 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JTx8qfys"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C77155C82
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748970805; cv=none; b=Tg7DsFsH+0wfAF3Ff8dhOzBtnUBqoTRPrxZVod+n3LrJu+ahzH14FHYueJUpzNgxHy1GFuo2Ukl5krCTzcVqCYVFfQtKWx4PhcCfOLk6H9z/czAcehJhrihp8USaEO9QbKKFJgXh/NV0UxTx5iSELJDKELwnkxysxk4IRJqDnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748970805; c=relaxed/simple;
	bh=sBXM3gHgjvKEO8hWEaFtjRYI585AMHNix0vtsLpfcVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9hwBq+JaleS2S4ukvChpSi+QJMPnBwdGEWYK+V+RVUAJOw3njkTTwpsAXjE85BTOvWY2u7S2QNvZUrj3AQFYFq3rP2eQtMwtqY64/6JX00EBHq+AImgUa7sn2A0tb4BtJSH91XWv6klGMFAhk7ut84w49z2dxcBnAa34DzCyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JTx8qfys; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ddb635bc2bso5046455ab.2
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 10:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748970803; x=1749575603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4A/eTuTh2X5YBHZFcRJOaPXK1QUqrMPM1Unydtq2yn0=;
        b=JTx8qfysD1+QjrReV+uUoCXtOIu0DGYhuiC6+dmjhzKqQL5sm6nNK6EeVF55jf5rry
         TjDDMB/EtKaEg5b7793w3ApG0QVIy6pE4ucUe3ev7yCWSfNBbHFpayteZx2F/UtU1Pu4
         eBrPhOGeNRqJCoLMgx1ncOVKJeaQvT/GdFC1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748970803; x=1749575603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4A/eTuTh2X5YBHZFcRJOaPXK1QUqrMPM1Unydtq2yn0=;
        b=BmMIewyDjh4jQuDyqeYgvATFzAQt22hp7lMYUZUtwdgXO7yIeY6qBLPtu27xsWBAkj
         /TPSouOsxplSKcK1tB+MFoGbuqIZ1mJxjXbO1XWyiCsjToFSl8D45ZB18f4bMLaehNEL
         +HRiW/PaJMGSbGmoObe3V4tVTOzV6p20ExcpuACpbnpA1I2r2/iXOzi+rPhwfnjXZnpd
         lUkb++bytT95Xfc/N6Ty9LNh5mADePPYaZJ0bIIGj9ihONHSWo92uiXJJ1tJO1DD/sr3
         r2jmSeY+g37PqUjmNgfxYAi2JQvr5tzINyToqT9zFhFLEwBUHUqWh4IuN71+9t8znIu8
         L6cg==
X-Forwarded-Encrypted: i=1; AJvYcCWIWLIYA1+LMaTIIK8KaypUtxEpCAJs+JVBAA7X1i4jLpe46TLwKe1X0iFWIdS0/Tx+aRoD9Us=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW/hIhRbLFUxBS0cxKBZ1e+7wVDFfJ7BBYCzqqG7SvvyM96jUa
	P2QsS6kCEu8HOcFvt82p1ffCWza3vFOgEHHY7EwhDtS4I4Qe+s9HE4UKQXnWFXEuRdg=
X-Gm-Gg: ASbGncv9tKeU+eZW8lNnWvdHTz6L4pyR9jmGnArAbp04t9Ubl3ZMaCmubm+7eMEBQaR
	Qaq5onyU1TrtQQdYnurraiIVHgxu5gq09mPsGhPaq92rMVd4CbVA+6Ve745DPyE6K+AXnaDlPk7
	jvKCJwp2Xzvlp7XMm8/GaXiIN2oW81iqRVRpVp9H5VnMQ8AcVa1mmIeBqNSE/3RNHEKPTmxa0qs
	UX0AzLYCejBDbbx2PSwn9AbKqq7InaAHK4zWcK4YOIxlMQ1VpRdBicehPBjEsR/6rEYcSyUNwya
	C7y1UKz8/plF2SnCEg9gS2C8GrnnD7guMLwVFXhWJCcm8yvy0tW/bOjwvTif+g==
X-Google-Smtp-Source: AGHT+IHIw1R3UTJPgqPx+MyExssPYvY5omY+CdwwyLuqJPu3o2bPRg5Ahq3s7i1xBS5XVSTi+FsSGw==
X-Received: by 2002:a05:6e02:440d:20b0:3dd:b556:18c5 with SMTP id e9e14a558f8ab-3ddb5561a42mr50229445ab.21.1748970802790;
        Tue, 03 Jun 2025 10:13:22 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ddbe2cec9dsm252565ab.10.2025.06.03.10.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 10:13:22 -0700 (PDT)
Message-ID: <491ec349-54f8-49c4-a740-b89a7b79da72@linuxfoundation.org>
Date: Tue, 3 Jun 2025 11:13:21 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/204] 5.4.294-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250602134255.449974357@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250602134255.449974357@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/25 07:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.294 release.
> There are 204 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.294-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

