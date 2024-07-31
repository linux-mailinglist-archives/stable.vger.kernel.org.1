Return-Path: <stable+bounces-64792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E5694345E
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 18:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF33281F23
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 16:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998341BD030;
	Wed, 31 Jul 2024 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JDQX3qN5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A1D1AD3FD;
	Wed, 31 Jul 2024 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444564; cv=none; b=mNkwDsKRXwlJTtYGzOmzqNWJJ24Q08v0z2Q3unR+sJf1U9DKkUyvom2rbPJ2wqYlekErjNy8DPnIU9TfRr3AL6IXd5gfe8D1p87I1+y09s2ehkAJlVTjVWecoq3jgk6Ow8BStOYEM+EtxuC2CXax9wwP6QYEkQ9IO27efZCgNuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444564; c=relaxed/simple;
	bh=kYhuRlBIHE2C2BGNHl65saGX5jug6Fvgp8uENCU/95A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/fw79Dglm7O7MgD4Mq2OfyxRLhFzIgF+71oDe+KfvPx9k6dsteglRBFkURTYsn+zCa9MMIbV4rk/pqx73iHa+i6ym5gjMxdk8CFA69nF+AxYGD3fTrTjQryvYlopjhcnmHCCr+Ajxx0ovgUTZg48BZeot21QcLNX15PIElxEJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JDQX3qN5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42809d6e719so39758665e9.3;
        Wed, 31 Jul 2024 09:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1722444561; x=1723049361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CqywH6oDZ0Pg2uThezn14v8tEMSUBnXkuuYXTy0OHaE=;
        b=JDQX3qN5Xemt0Gsb7L+n1Sl/UrpNgAznGGmFvD04wIlp3ySPryDoQwvILNlay02qXl
         BR2XKYUhR8MoZ/YpWRNAmQNQ9wDAfiCabUE0oVALL+LIDbEkPKUKgnWkY5bL8RAL3Gxz
         P6vySsjPseoDmtSBXKhYJYfF+buv4QAVU47uW7XBJMKzFNEC0dYWieIvsrZV8g3WIwEW
         fil0BMAscZ7VTHv3YP0uWr92/w9UFIqcWxYkCMlPVU7OL4ZLLnj+Hw+DEInn3xYImXI5
         vZPcglHzMDK7IARlprp/mqqAuAkMq/EZVlZWYMzhK7heLfHblVqA/SOgXcRDeFawn5d0
         UYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722444561; x=1723049361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CqywH6oDZ0Pg2uThezn14v8tEMSUBnXkuuYXTy0OHaE=;
        b=L7Qq1qPgxh/ROQs868tJ1sRAnAqdrLBS9uyqe6pK5oBbiAi9qA436Bd/QehtRZ40eV
         58Co/Zg7mJ0zbTzSd2nrszeH4c19tUY6083rgZtjZk7VEjKMhmO+11pas8tVODazr4xS
         OwowgukWsMMcYb+y2NINKoXcVLt4smYZfWqwWFKWFIDrETUxAGjHamRdS65zoYolD8mk
         XwYWZlCfCXflJcOnAd8/xP+nh69TxRONvOjeJ2ajdcwRAkgAgEBYVqjzQt1MQ3rdKLaF
         DqEkbmJ4QbXeOYG15IR6oYvBhtJ01wE+9F0VdHAFWwd5NmHsJdfE3wDGaRNos3nO+LDJ
         kNCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9+zLztK/0tseEU75uUKALVufS9b/cmYshugDqDoTZ2fpbiGvDXHnw+Dah0yW8OsD1Bpcv3sVF7msHW2XjDdCzIBI0htzUr1L1HgT72YKDf4CE81BUdsF0SX0yMV7t1auVSZ8M
X-Gm-Message-State: AOJu0Yx9yZvbwcUk5GYNQfSsq20ISjxQ360ijAIpxYyXIQ8Og+sAWgAO
	Cy/0w0DEZmJzNd/PzWqyiaNohixqDaMLuAyvm5dIuBxFA/TA8jI=
X-Google-Smtp-Source: AGHT+IGuJWa8xAruiaapYBX7B7MdSHSVFVm+KasuIfU5vMNaKG6ayFpUc7LtLI2Bd5DFGhcv/r1RfQ==
X-Received: by 2002:a05:600c:1f92:b0:426:5f8f:51a4 with SMTP id 5b1f17b1804b1-428a9bdb7demr213775e9.12.1722444560767;
        Wed, 31 Jul 2024 09:49:20 -0700 (PDT)
Received: from [192.168.1.3] (p5b057724.dip0.t-ipconnect.de. [91.5.119.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367e515fsm17505284f8f.45.2024.07.31.09.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 09:49:20 -0700 (PDT)
Message-ID: <87ae754e-44f7-47bd-9b9a-6072d23ad165@googlemail.com>
Date: Wed, 31 Jul 2024 18:49:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/440] 6.1.103-rc3 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240731100057.990016666@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240731100057.990016666@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 31.07.2024 um 12:02 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.103 release.
> There are 440 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Now -rc3 finally builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. 
No dmesg oddities or regressions found. I'm building 6.6.44-rc1 with it at the moment...

Tested-by: Peter Schneider <pschneider1968@googlemail.com>

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

