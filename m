Return-Path: <stable+bounces-180470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50848B82A96
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 04:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008D51C01879
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 02:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41CA21D00E;
	Thu, 18 Sep 2025 02:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Qqk+obC9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E51F582A
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 02:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758163042; cv=none; b=sToyQan01quV1Mxrv4sZoVzQghUVLm6tRoUfeWeTzveDzzwmM3Ic1d6XDRpGMwt27B4cBQI8fxpWyv1mP0r2MbuaksCCndBRDtZ2eC1HhcEn8TlL4dMKckLda0zSg5PnADpoPU5VU25G7fACkNAypNwHRYfHiFbhVC4wq4iyJs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758163042; c=relaxed/simple;
	bh=/RmeVzKahHtJo2SWCXkMHvjzkXNAmF+g49TikYNX4e0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzYJ/cCNz5cKh9e71oCU57EXd/LqWOFZZ0GPxu/qvuBACQbrOHMyfrXknkugemXQz/05yZP+ji7PKTu7qfHgyWS49OxxblO/q4MTcbvBvk4vB3OvgHHfo9BLg4wIM/liyMc7bvxpEOeEa6hNwZVv+4KHYmHcfZST8/++jxZhiSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Qqk+obC9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45f2313dd86so3429295e9.2
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 19:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1758163039; x=1758767839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fjmfvrARMUerFTF/Av0OXp1QJYcVrIvm8qLnxUg6tnU=;
        b=Qqk+obC9lavET/uOebLQ0S9F0XgctGJrj4XtMn2rQSDjgkSHnJaeDA2MqLzOvwqkp5
         A5xvn+RoH3XUL3wiPgaezzXhr5v3tG8MhdUztJND7sa28tdCl+ytdG6jc51WVcOyYCwM
         bfXgivNKcFw9LqRpoz9k/O3zCMVLE8KDFda2FupqmX4oNSowFOddnNxpNfXxg1pVnejJ
         5+/yaNvYBuPkS1CIAerI7qSIrpWz0qetZYBKD3VEiMKg8NKHF5LYzI8Ab1cvJRZOm334
         oCLrvJu6m/Cc8d7llmquPU6yyaxZYhEdIGyZT5z8I9cDvDq7kr9LjhznZ1blVEhHMri+
         fwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758163039; x=1758767839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjmfvrARMUerFTF/Av0OXp1QJYcVrIvm8qLnxUg6tnU=;
        b=imqn5gRuqm+M0/Mo94Vr8jUlv716BrEVd0clRE420Ld8UYC8mSbJBwnchia36iez3I
         s9RT1jfl4ptnul9wMN3xJCZY+a23wUyXw75p3wfGzvl0fYagxULGXp5fw+nUW+5Ij0cO
         HLPTSHroB4xAm0xaHPiGU9uy/UvhgCnIaQVhc79PDj8GNdYkOcDaCiql5SvPHK//Pa8j
         UDxO7Jh6x24aULeQ7DoqOjVhfFplgjtGrXk/HKdDzp/kJHbsHPfnnIybu9FvsAJmQsxi
         LnTyRu7069mgWuHPPcvDnJeeNhFl9m7ZRUp/bIK1dJmgD+usyk0qIrOmWOnqAGwlqg20
         lR6g==
X-Forwarded-Encrypted: i=1; AJvYcCVUO6ew3CFwEm8UnVHrOpkuTjsiRV1aaLxj/Ih/howH3L+BHIowOUGZOwZKz6nnAnEc9KFmsY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhpiC+FYyO+cg3IQo18UCR+ML4bHHE9XIAxkENTkDTQMz9nkxj
	8kOFotT+qZQ04ekktNs6aCTgfU2reOWdUVPBm/qDHI84oWJU/fxK1lg=
X-Gm-Gg: ASbGncte0N0yHQ5GvTBcfPxsC4sHL0fGFKbG0CbmpQZqDxFizE0Rs/A0nxRXuZddT08
	nnJ1HDG9s9J56WLHU+SMQa/KgGRxOK791kWRkdMchAMJ1wGpWU0kMUp3qqeo7sSIJd1mmIwo2WB
	TAgmbWn1I5ohp8N5FOngymMwVN8bHg4NDTc2l6PccY9n0Px8kNRNOFsUAg68cqYh43S3VI5lHhU
	baUXwd7UxgaGFw1fn0VPV0ob9xm20irmqr9gJRxn0yLieAZ/h2kTDllYjcEzC+VWhRtTSfhqxv2
	d49IaaN10ZI2TskjzC9kkwnEvlORY4ZJ4XtFJCWQhQ8xPytF5pnnP4Fjg94X4oEjm4FHuwD2F8F
	J9ZQEXx8+HwFMG+O117J/GjRnpV9r2EsX3ZXmh/6gHUqIW5sgo9vkwQ3TivDvOKegCHPnT8IBxX
	ip7W0LksPgBkDQgL1mXg==
X-Google-Smtp-Source: AGHT+IGn6j1aWgeloupj38mFaiQ67C35ZVmcCQIAnn87KrIGpYLIopHIpRfJigBwx5QOkKjktWdsDA==
X-Received: by 2002:a05:600c:4686:b0:45f:27de:cd22 with SMTP id 5b1f17b1804b1-46206099d94mr45865045e9.17.1758163038940;
        Wed, 17 Sep 2025 19:37:18 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b40d8.dip0.t-ipconnect.de. [91.43.64.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f64ad30csm19916375e9.23.2025.09.17.19.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 19:37:18 -0700 (PDT)
Message-ID: <4ec95f82-da65-4764-9a06-b2de6f06ec00@googlemail.com>
Date: Thu, 18 Sep 2025 04:37:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.16 000/189] 6.16.8-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250917123351.839989757@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.09.2025 um 14:31 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.16.8 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

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

