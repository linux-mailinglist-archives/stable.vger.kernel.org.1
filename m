Return-Path: <stable+bounces-124109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB50BA5D2A4
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 23:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C42189ABF4
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 22:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E121E264F9E;
	Tue, 11 Mar 2025 22:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ax62DSMb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A91F1E7C2B;
	Tue, 11 Mar 2025 22:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741732848; cv=none; b=QY8pm6R2RbOk8gbabABV2Jj/eWyE+Cq49R9mwIuOHaaYF1fVCchGzsvNxQbZcbDY8F78DLnOjPkkkeGeXJ3jfW+Ca/zk7ZLfIzyacqkKOidWJott+A6kqTn/d1v2YCrN8C+BWWblTHP2bhNWAglkptLfM+hONMomwalod04qnu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741732848; c=relaxed/simple;
	bh=T4AmMPVFHy4fO3oFe7eoF2Y1+Qwo3p8w3QJ+kd/k+ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i5WLhn4rQZDgCs1KTYYy1U3r9p/xH0YIEDQ0Kyo15/IiNOb/5uN2ZyLFOg9K1Ou/hWBz+3UxGBdU7Ani0qYFCidAh0sa/iu04bdXAW0gkFfPg0akrd7d+k0zD8dHTs2sBBS7/Ff4UaDTN4ljinfk0ojxUt21IiKzO5f34hVtVVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ax62DSMb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so18472615e9.2;
        Tue, 11 Mar 2025 15:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1741732845; x=1742337645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEGPWOgVfNQ1ZfxDumHE60ajETskqInTxO4liQoGmRQ=;
        b=ax62DSMbG6pJrytHBRJMr3I/Rn9VLm+XGniWqd2b49inp7OPAHDBJfutkglAu05TOx
         +aEClzb9KTPu/Kf+ZCXjjl2aSqU+hWC0H88vwMNNQM3+qN/M/2yordQdfWp2khHr6Xhj
         FXcwQeloi47ZblfrXZOwmRZLGtM2qDfhKGXZiEalg1wU+niVtYAV5gqxgtSdwxA6ECLz
         VNm8kSqHECVRlt31pPd1vQuDAjjy2/iIFeyJmSY+XT9ctFx5xE4zcJnr6gmeQPGfqA9q
         aMbbu0H2FwfLKbXF6gJw0pW+RvMmBjVUeFeCntwqELTgTL1EfqtFiTwDH+I7/CKSAZz3
         WERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741732845; x=1742337645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEGPWOgVfNQ1ZfxDumHE60ajETskqInTxO4liQoGmRQ=;
        b=U5+Yte/lvkiYZkKu8S6ogRjrvUTRq5EXym13xVjotpjNZ0WqXuB7hkRgS6DH5G0Mao
         IHkjAkFMjRaaDRB/2vecocIp9o4AsGjRRO+sCBJhdGbyVcR1st/vJziufybqvEDCR/A8
         GFU67XVbqFZfhELxVudPTBsxuf2MQtIiZDu3XBIucr8jIP6FrAQv6hfBITTyTmDIQi8r
         zrjw3RcjFmS1rDsyqyC34z9xU+DuyR4+F0eCJuY04SbG1vwVvhYFburozkz4zqyILNFn
         +odaJdPywWG/v6eu9TDfplsZhrzYodKjjRDZoV51GO9lZTSgymn3HOliRfLlcop/64RG
         gVhA==
X-Forwarded-Encrypted: i=1; AJvYcCX3y9jTz/53pNakvlvHo7BLMuy23zwzUXNQ7qynSyHyQuuRrIhSzuiHsYDJqwtw+1bTv4F1uiJC@vger.kernel.org, AJvYcCXb4zn8GMtGjDw3xK8Hk4SyaEFRhDMUoOTNvf0QHqYmagxM1PRoDBPG5gAc7R4NYGAmM01fuQaW8KBrNks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzZ0HJb4YrXRrIZdrYb7nOwPESoBNPdFXEYvDnFFulTTMi2PgS
	s+Xve+vJOsk5PILLT0MF0jFG41//Nyl+P2vo2Rp6zfsIqtuGVrM=
X-Gm-Gg: ASbGncsLh9HTdKzEguZHFqok+GUcsgvUzke1+2FQuK+G8do1HCtyMUL17j3VN3+x1oj
	Ou/tlBV4fEAXxVZ/6YlBGwa22bpTyI9uy0ekjM+oF0ZJpePju9PmW19LMxyk+Qk+Anjx66WoEtB
	kIVjeGnJWY7XYvibshE/bWSSpSnYtg2huttU84XJPE17chrNhscMb8okIc7F1irNug7aUbF8BF3
	8IQfguhZ/JkF0c4KaUHf6LqIAT0lO6kh2Bk3NG8EC6POh0AwPsCOj6NRPnUKsWrIdICrBiRqWeG
	xVkUKIgd/fPgXFQAAtE41sEHe8tix1mX9Ix2ekDp83e5tJmOnIzhtG1Jd/edD1kgMTtiwT4nZZ1
	EMm/MeRGbz50SX8bAUwIXMw==
X-Google-Smtp-Source: AGHT+IHK+c/sNBHna7qu4NW4kaABpYfBEx6OtVltunM93j3NtyT0tJyYUqcf5XxgCowA7M74GN4J7w==
X-Received: by 2002:a05:600c:1f92:b0:43c:e5c2:394 with SMTP id 5b1f17b1804b1-43ce5c2054emr139387295e9.0.1741732845302;
        Tue, 11 Mar 2025 15:40:45 -0700 (PDT)
Received: from [192.168.1.3] (p5b05767c.dip0.t-ipconnect.de. [91.5.118.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfdb9sm19168697f8f.27.2025.03.11.15.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 15:40:43 -0700 (PDT)
Message-ID: <77f74bb1-89a3-4982-a937-78b990deceab@googlemail.com>
Date: Tue, 11 Mar 2025 23:40:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/144] 6.6.83-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250311135648.989667520@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250311135648.989667520@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 11.03.2025 um 15:02 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.83 release.
> There are 144 patches in this series, all will be posted as a response
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

