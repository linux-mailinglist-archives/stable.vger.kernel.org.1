Return-Path: <stable+bounces-106068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CAE9FBCD8
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 12:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95448161C74
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 11:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218D31AC448;
	Tue, 24 Dec 2024 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RP+BWBpS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2735818B47E;
	Tue, 24 Dec 2024 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735038232; cv=none; b=D42d9bKMQnvjg8qeTNBiYcgnpHTYv8nFW7tj65gJSs4fX4iPArfFg46YilNzxXOk9FPNOYlzjLMFIQqHfj4+obIi1pwtFC/jwjprAulFP2P8AQyRf7n+yEvwh2ZCpCtgGsWEBFzW1BbFqXx+ktioD6eJ2b7uvn5XpCl7Zvv16do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735038232; c=relaxed/simple;
	bh=JYv9O6Z8cMpT/DvONn3axjUUbzsMVDz6wMcWWRdYPQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ziyhk2W+kGb0zy5NkKG+RloH1Ze+GEDmTOuMgmLDnmtzwVdgaSwk6iXC6dgu6oEYjwMAQm5dax5Gqsv7hSCAFZ3YVrpOHR4Zd+KWlaCzcU7c4zxtkXl5R9COSs6CNfv4YUvocTBNg0TwKD9NRvG4S7C/BDMziM+MrRBAyUq421Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=RP+BWBpS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa692211331so943307066b.1;
        Tue, 24 Dec 2024 03:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1735038229; x=1735643029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y+SEVkpBE7XvTYlML0KQpN3wLBrjP4uYD6OOiyWpp/s=;
        b=RP+BWBpS2Gcqk+yd7mKYKv0mPzfj9HU9wr0W1AwubUks33NVlIPQSvbOWN8rGpCEf/
         tTIIrkZ5KBQ9PVerl3vnfTLido9r2ebZEuEdKjjTQsuFkPnYqWeWjcUIPGIA+Sv+AXNL
         m4DRN5tIFLB06D4dj8rkf/BYM37TGuJChh+SbCAW6gN/CDG/VzWS8AdlMGbnOoYwGL9R
         LPVNSqFycIUdyuEn7bYIBTuG99Z7IZ+XIqIcihm927bOpKHomMQ8j4c4mqn7Ec8lt6vC
         NzmWsQ6W5A3t3mnaIgzuB0EqyfOI3U7i8AJ+kEZO6kUMccFL7cjAL59k+l1dt8Psg85u
         kaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735038229; x=1735643029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+SEVkpBE7XvTYlML0KQpN3wLBrjP4uYD6OOiyWpp/s=;
        b=QjYMiCuyw1n+s0uP5Oys6PhWLPcfVK9/f/V10X8sxZri81niQN14iBh22CBzh20A1k
         9Cv6rI+Tzqnn5zhiqQzVLaAgVlOzNT5KE57Qzjc863mE/czvdD1S1huXNmois10GCCDR
         hGpIWO5ykTog4v5F9hv4rscTjjSAhydr8aLL+4F2zdx0TejEMh/PjTcSH19CfwAyJakv
         kpBfT9iE67V/5avf/xW1/x72DtSfLkqOI9/YRNan9RlnZ0eF0p3e9wHJX1oUQDTWhnqp
         674+cBSYeS2m6G2ODteyg7+3hYvynvZVJPW3AIU/f5GVTya5NOp4EJWdhxUm/hHEg9O0
         A2AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUuGghKzrx4K275A8WVxh0B7UmhrrniDMj9O+BsYxBuW+HNFR5Y0fMjiDha3qQY9Q2VdH2coSCCDz1XUY=@vger.kernel.org, AJvYcCUrB+1sftOEwZUPCTk6moyRtk34rDZTQqAzZGZbxGbVvwmVJst++hSK8FW7574d4TI/VgsVKNOm@vger.kernel.org
X-Gm-Message-State: AOJu0YxIVSCgSFeoTZzpzmbbyY9hsfKpphDPtvauCxpJ/Qw412z/D8v2
	SgWVnMWVgVIH/Q7b0OuHZuQ42hWqP7roOTNObl2rXRmZT05AaWPsTlTJswg=
X-Gm-Gg: ASbGncub+rp+rjlXmq1/MZBGQlKTt3b1BPZ+yMxdPWQbALY2ZHPl4Per6B2ilvdnee/
	pkoBSLNJ2ppgypkRcIGBYc1noeD5szmVqJ+8sMy1PSI5zqC9JD6LwJyIuoCLzVPfofEOJ3XAUR8
	+BlJ0P/8lkta6MKYoFfa0eRjldq9GH5YWAYgGx1a9sIKjOmLPvXYS4M35GahLqlKtVtVhjQN7Vu
	QQwm94dvLEhTcmES/2iEYsYlBPwS1emHuyiQcc6d/NOQkJsDs1/IR1LAk91clBLq23IKjzLbsda
	mts1u9h8YPHJbL4AU/V7LQs6u0h0YoqWtA==
X-Google-Smtp-Source: AGHT+IHOZlD9aLeFV4qen4/Q0f+49bAJOVCLjn90LDTVjUwoQ9w4VXGIxcbl7/ApfwYNmOGyM9+gsg==
X-Received: by 2002:a17:906:36ce:b0:aae:bb48:211e with SMTP id a640c23a62f3a-aaebb482becmr746344666b.27.1735038229167;
        Tue, 24 Dec 2024 03:03:49 -0800 (PST)
Received: from [192.168.1.3] (p5b2aca5b.dip0.t-ipconnect.de. [91.42.202.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f01228bsm639522566b.143.2024.12.24.03.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 03:03:48 -0800 (PST)
Message-ID: <69809e40-7a9d-4758-b455-1bb4ec2ff876@googlemail.com>
Date: Tue, 24 Dec 2024 12:03:47 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/116] 6.6.68-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241223155359.534468176@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241223155359.534468176@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 23.12.2024 um 16:57 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.68 release.
> There are 116 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>

Happy holiday season!
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

