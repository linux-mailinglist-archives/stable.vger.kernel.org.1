Return-Path: <stable+bounces-176398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6068DB370D3
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 19:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5E8366F29
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 17:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171E231A571;
	Tue, 26 Aug 2025 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+fhu6EO"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CBB85C4A;
	Tue, 26 Aug 2025 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227677; cv=none; b=TpnYTWC377tLGpVZGu8stymlFiDxGKy2UchqFq3fSs5qkdjUWY/s7Bdam0nFR8OWuz/stYukRZbyAvNKHB4XPw3UV822qP2w9acQoRFgVQ7p/EThg2jB1FeoG2o8kUrO4XPtWOIp3BRvQpKNWCA6gHLTnf0XIhW13gB89ezlwm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227677; c=relaxed/simple;
	bh=HRifJIP/Z9yEEq8qLSuxjRS6ewHNIcIRi/KyeKw5kpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xa6i44oy7PTq4ODGpjmztYQrBnjvLYodq4tbJr+ocRnVxP0mecvissPZSxsrPbzcIaV8tPqHH6CvYSOh0jXoZkor53ursxY2jxbG67QB80zhXur2bEC/70nX1xZ26T3W1Ar8brTI9B2pPuaYNHaIFWvKPuL8tdefjf+il9Ibppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+fhu6EO; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e864c4615aso8781685a.1;
        Tue, 26 Aug 2025 10:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756227669; x=1756832469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bRKzh8DIPbKcCybC/7E+dyvw8PR5kUzlHb1wJjTVXtc=;
        b=a+fhu6EOUkkssIFnz64LMNPclSvAiZrNsQJiNHqNHYh0B39AxdrFMdu341GcHFnSY7
         IbuWZLk7+yT8hor1VzhdlVQvbrFPw6Q9RF6+ohq4E8j3tr/ARqu0KyQfM0Lg5yMxiiLJ
         WI6WNgoGPiPOFXRnQs4ADNo93aS37jh0+P0IyX3W1apEkVzVTDjIBdqNP6DsMZb+dmbS
         lKlf3IAHhVYpNjQNG0xDsG2zTxGyalaJbUBQdQ7alh8KynI48mWOD/Z4bISPgP8JGi2W
         2enfNaQHI45wS8GdZQKQOBhzrOsGaSZs9WKMBolFSdYLLzuKgbOrNXqzXagCdFecqo1a
         rYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756227669; x=1756832469;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRKzh8DIPbKcCybC/7E+dyvw8PR5kUzlHb1wJjTVXtc=;
        b=SqDDlQtZfyeCG5QNnvbSXlychxgbBTq7ay2hQgQ+hkJcrNiJB433LhLYn7t1qI7VE+
         dKvwWz2MgoAi7+tHksa70mH5nDTRSHGHKa1xZ0mHcpIoVvST1F9/xpvm1P1ySl2TBMuu
         7FnzRnzNw8C2BL6MYItfoiP+XImM9bIinO5hKyZ57D/B6QQnvAX84xHFPeoh2bQdt5et
         stFoSS1S7OIFvZ64D+yA5WzHhn9EIG4UTziqsxT8iNZCcIT7/S++TMeIZfdCDXOmdGGi
         8NBG+LY3hQOvZzkWWh/GLVZ7K8CN+SOWD5XwBy0w2ki07eu8li8rTMpjaszTPxMwTTmM
         qGFA==
X-Forwarded-Encrypted: i=1; AJvYcCWaWt0cUyx1mkEHOLfdZt8Z1R0zELqvDWpqnW0pAF3M7rfYcVlRdP4wZ1nqpr0CoIB6VOrPGykE@vger.kernel.org, AJvYcCWun2HC6vS5JYTZovlg8qa2bf+dh6WBBiKQ7vJ8++ziIdl9VvFQm5osEAKdbLs/jn8kWLYEOoV4T0gBO24=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoHFApYGjOZZFwEsk7mpiQUGYsmnuqwSbxDiEZBvjfKHovXowW
	aMRdDjYyg39L9GSag5FGU7PNlg1/yeU1FBYnJjMLdKbmuLQ0q09L7JBT
X-Gm-Gg: ASbGncuhuFwHhwm2s4So4RlsWM6jXVuXHNb2AfHXSl/EnCf7oBqtXOZ2YS50ZYuc+/D
	m6kc+NzZ6jbh+JcInInBxJjaOHL99wVjEGLo2frRW9v3KDj9QYiD2h3DmVkbkRzzPX/uXGhnMH8
	By7cWNkE+DNxxF2SNLN/1Ky4fceMMJIOAi3iW+k5eO8FaS2uXzGGiPDj6FdoPYqiuzQ1/6704Ng
	ZwqRoyh/n+9YwDcl4DD41HOuXwBb4gcbK6PqtrrKqBx1LISgx90HhFmfu9/rVJWyDooKp78ro3K
	aPpSBQvLWP608CaJmpEsZiODl+SB0qSF/n7maSOe+LSjYgJY+07+d+fa3PHsA1S3irtNunKw+vb
	pTpTqLdolRUNMSTa2lLWQgMxuVfXn2Jkte/YVRZe/UDDD3QcGGw==
X-Google-Smtp-Source: AGHT+IGS31cqYP5qKxZxREBI9B65V6SJqeHAo2pQrB62oGzvSihthY+MMIVPs9uAGaBgVXdtGCuKbA==
X-Received: by 2002:a05:620a:7101:b0:7ed:92c8:7d16 with SMTP id af79cd13be357-7f58d941f59mr264859585a.31.1756227668309;
        Tue, 26 Aug 2025 10:01:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebee415f6dsm719225285a.27.2025.08.26.10.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 10:01:07 -0700 (PDT)
Message-ID: <7415b3ac-cff8-4dbc-a4a4-a483e1435564@gmail.com>
Date: Tue, 26 Aug 2025 10:01:01 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/403] 5.4.297-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250826110905.607690791@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/25 04:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.297 release.
> There are 403 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 28 Aug 2025 11:08:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.297-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

