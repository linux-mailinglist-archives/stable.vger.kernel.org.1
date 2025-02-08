Return-Path: <stable+bounces-114363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC96A2D38A
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 04:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13093AB14D
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 03:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB711632D7;
	Sat,  8 Feb 2025 03:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cxAG5M7c"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ACB2913;
	Sat,  8 Feb 2025 03:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738986034; cv=none; b=H1eh7WYEqp2bQ6guaIIWNcoXhIWaqxC/9qwMupRbna0LJWDbuCibPHASPpPpgUfM/oVsBM57rPmFSJJYyS0L0vhWZmUyRwJ2lDW57kGhMfoaK2zHl+BMFVEbOaZkJ+lgDFyjr9WGGNE+YnXQ2E7I2AninAgPdCP7eaxfDu9ym4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738986034; c=relaxed/simple;
	bh=N9kaOwokRwr4iyVgwSq5BDPO0g+y+cdxPnlkd1dmLy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzljm/2HHca9RAGKFqdSH8CJ+8kTbbEMw8xkt7A+ZhJU2oyVZq2TjUhLHnIK1zDZ1kOf6g6Her1yFSzt4WfXV0mw5SR8DiKum99LilFVJUjNJfhTWCuVLRWFNhCyFnm4THLLK2E1OKyt4CbB1kHcjzLoOuwpxs+8dCcUXRv9qT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cxAG5M7c; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43934d6b155so127205e9.1;
        Fri, 07 Feb 2025 19:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1738986031; x=1739590831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/MoU3id3BrwdX1UH0ylVsZ7NUAgFe+E3+3PemD+rI0=;
        b=cxAG5M7cgnRBI6gq0XHkE78DcjsveDo+RIu5Sxm7laxEqZYPn3VojzB6IwafsonPEI
         qj47lxRo/D4czW2CiNEsDCUqR7mjPq68bBldqOSm9DtM/qAXJvQ2IKJZ9AFKxKMtGglz
         xrGJyUb1tGElLkJOapslnSd/il1i667vtdDwXfsbTOX36c9gmt3PhktV+okYfwYe7qDJ
         VRA1dIB9exeCdntcPv/FuXLcR4ck+2tVOxZlewVakwIPhcA1yPO3bEVIj29kfJ1pFbEe
         Jzi0d/CHmj7mJPC15EOTuxjNbhNGX0Mn2ce6aeV8mxeAvlMxi6L/TkIY9uaAx1RzJZcr
         uvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738986031; x=1739590831;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/MoU3id3BrwdX1UH0ylVsZ7NUAgFe+E3+3PemD+rI0=;
        b=sf4MW6LDV94vD00P1ULDhhvYQvK0HvhEDqJ+6NeI6YQ5F8wZrL5G4X1Mkc0XijhGS3
         UTkVcnhi1997r+pRrAdQglbrouzGYSq8W1J0vY27FYekPccmGU9eI449w/pS45grmHI/
         nx/26djAAz/QuWJQwxCrUZZH8SJOAMEZPWgMIz8BkJsfJ6hNRwv7ee9uGxS1uKEiYXTx
         HqboaDxAPFWqoBAr6dcuDFjze9/uhRsBxMnLRljTo2Vh+C2a1ob0wh5bRiioG9aycKs6
         0qICrJHp0SGKVkRNw/6gMOnHMVweYfHxuawPJVACbMLdbm3mAoGex8veGAOxv19IUqHm
         pePg==
X-Forwarded-Encrypted: i=1; AJvYcCWf7BdmmQJ5N36D7ZBEolTC72R7Gvtz53ezZhJOJFF5XiQrVrx7jzaZ/XSf/862PcbsRkEIAE/Aom1+SJg=@vger.kernel.org, AJvYcCXecIy/fD5qGHUl7ZVxbyc1ME+9Ptz2wsS894aLN4YALcAVhRxdmPQ3njOqZWixx1zoEWi2AHdf@vger.kernel.org
X-Gm-Message-State: AOJu0YyPOM5yjeF3l4FqVT2q96GS/y1XVKp7/SdDkefC3DBvvqJLFqde
	Q/h1SPGt6cB+GccNEDNA17izZTqJ6ZK04zPMFQZLCRPwR2Lrdo4=
X-Gm-Gg: ASbGncs4HrzP+Oigdn/rIct1M/FtDRPpJnb+UohbaeAzgN4nI6qtpPYWVMOKAcjkY7/
	jlxx3wgjOhK6Bbpz9nSw78jp1+41WdbaunCYdMktUm4dCwTVVgSnvNrIs02Qnf6CUJfI0c/d9Iy
	VS3sSyjE8OYNP3gNQ7GrnfbnBLrlQV67S+BL29AIBUWnWZU7d2xBqEBurVyBsMZdAYGe8ff6Ke3
	GLqxWxR0blpKMT1tqqeNoI/yBQz4jg2tAhshaxZ4Q8T7aFcmas1G8icNc1FOaW7H3eJxaDAFaiB
	/AdGQxdRJslOBiIg5T865KP0Pi2b97x7UFrvwEd89a2lXJZllkCB1tBNS7VRAWUKkLOT
X-Google-Smtp-Source: AGHT+IFcoWeDsRNdVkwNAsdBuFf9X9aBBZeb+1xqBEK8L6mmiiRZTdSH+s+jTYA4mu5Yzzw+6E/37Q==
X-Received: by 2002:a7b:c342:0:b0:42c:baf1:4c7 with SMTP id 5b1f17b1804b1-43912d150bbmr72193195e9.4.1738986031443;
        Fri, 07 Feb 2025 19:40:31 -0800 (PST)
Received: from [192.168.1.3] (p5b0574a7.dip0.t-ipconnect.de. [91.5.116.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dcae8f0sm71285495e9.20.2025.02.07.19.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 19:40:30 -0800 (PST)
Message-ID: <390d6183-6d30-4e68-ba32-a6cb99ba4083@googlemail.com>
Date: Sat, 8 Feb 2025 04:40:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.13 000/619] 6.13.2-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250206160718.019272260@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250206160718.019272260@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.02.2025 um 17:11 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.13.2 release.
> There are 619 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

