Return-Path: <stable+bounces-105142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7729F64F4
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 12:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2E497A1309
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 11:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EFA19E97B;
	Wed, 18 Dec 2024 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BVH9WvQz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A6B19C56C;
	Wed, 18 Dec 2024 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734521709; cv=none; b=i5eZ28AF9VLsh0cHGdoqDK6tbNqpkOiT9G/zofOV7wv3gwMhBmRdRZcRqJertN1H+YujkYfvPK6mAR3hjYhXZ31UHv3dBmtVCF20ufQcO0R9DGy0xlEDbk+XyL4g0KAelNI9brx20GmJxLAJOQqyEbEUbo/jsAEdhKfs++gakuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734521709; c=relaxed/simple;
	bh=aHiM00O9sPVhnjzBa4T39lrpaPQJh67gKCPtQH6GivA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CT38eBIifD3Rwom5i1uZUWi2JXPHqRQ+wkbVN9LCQkd6QTwNI3BC7x8utcKfF1Qq4aYZnqBEST6RAIny+OjwJUxmsF7BGGclGztmQvHfR2QeY5mgrJtYEQNU4vbLum5pzPISUR0DxFaIDtOPWxhuSca/OWf3Wg3+aaClFKzv5Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BVH9WvQz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3862df95f92so3240157f8f.2;
        Wed, 18 Dec 2024 03:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1734521706; x=1735126506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BMQcE2ZZYoXW5jzc8/Xpxt/ECmuhV6utjqLaahp++GM=;
        b=BVH9WvQz0Ug/JB39qM8/xlWQ2c3ei+Is6sNPQcWtjkvOyS3kYEoVS5INVS+g+9zMaQ
         80H8oKDTaH5ZIub2mvv3rbUKMjxFEk8VqEmNrkJCUazewfwszsCXv4A9pMadORQ65jz/
         yBSidY1SSKltFpeud4TdY0enV+WsxYH+WiEaARBZEvU847aYSG8clTgxO6MtdTD4yYFP
         4/+fsDbPyHqXuxQ9nM7RFb03TCGO/f/5hCq9qftvhWgpSGOOfCQ0ljjjlbqqYQ/BzgPU
         EU72IPrLPts13RDtnkG3CH+V2fxVBZ2n3UxYqEPLmPKvejVnF4QgEtAdAs48jVqJFsjh
         V2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734521706; x=1735126506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMQcE2ZZYoXW5jzc8/Xpxt/ECmuhV6utjqLaahp++GM=;
        b=oWOGaRgRuOIhdXz7kgd4HVmXIr1FYBVfPj1ifehuYMnAryLCnYMqZEWs5l/miei7bs
         h3VunaJdYiMa+b+aQavk16+B7pLHs1Gxov2BE9n3EqmLaV62bwden+J10+oOZYHr68PX
         PJsJdYTfJX9aYKRBWvLAI6bd4ivnWwboDD4/eib6Xqwl6mSX5D5L8rVmDhRuhdH2nmy3
         tzDf/glZrlGgPTSGlAJNqZ4LSjuxVlOb24FyKbawEzwCYbSkt3+ablpz7aIQGlzQBnS0
         9u8rS/0qoBWJ6D/8Eu7AP3EH2dFgjhxWYpp7DXSS4w/BxFNiz1YkX+1OpuDl+xf/NjrU
         kygA==
X-Forwarded-Encrypted: i=1; AJvYcCV6WUkoHg2FoFkIRwM3pbKtZBfZEbbfpbMvGEJHw3d/QwSljot+nBlm6ZUHTzKhITT7Gy+cU/DLhU595z8=@vger.kernel.org, AJvYcCVxfPBJweXrszIRyl8m0IOjJT131zH3xdnB5Cji29/HK5d5xPqCKYNPeqhH2b13t62A2gWSa2ID@vger.kernel.org
X-Gm-Message-State: AOJu0YyRq1YNhXWpyNh4Eg3lePgadWnU5fYWZyP3P6Uqgfo7YEdqxv+w
	n8sHVctcIff5DkWAIhJxkh3ZnaeYGaYnoiA21OFeV1yiStYJPF0=
X-Gm-Gg: ASbGncv6b0ChYza2OlCm34/HjjVFj30Vu/m2q87jk8pWRi3ZchuZ1pVhFvQ9ueR2NB6
	Vfjyb9W3I4gSuU0h+XfXZMpuwpN8aotU3mlfr6XlnjsSs/71JXxulYXfbnqzqDBTpBrwFQXpoTE
	UJ70BfSktPocJmxmLNtGmrK0AIMIvGU7S+4gM6+ZQ4bQ0GT+AmIFq7xNsXo5r/14S6WFGtDzw0l
	jPkLIlVJDyykLspwcjfRCGY5ifkXyEVXPUrqni2zZP+4/Xe+pDSgy84zdx/3/YqGogArF0RmuE2
	lXnKVR4KXNcYfmzOFVHZ+UHBzwTeZozzsQ==
X-Google-Smtp-Source: AGHT+IEXoh1wmiHthWNkV9UXzrTxdGT+QidElNDuBN2fzcUvvTta1ivTlP6H2EY2/C6UZGeIDzwKyA==
X-Received: by 2002:a05:6000:1568:b0:386:4a24:1914 with SMTP id ffacd0b85a97d-388e4da5fb5mr1965645f8f.37.1734521705645;
        Wed, 18 Dec 2024 03:35:05 -0800 (PST)
Received: from [192.168.1.3] (p5b057eb9.dip0.t-ipconnect.de. [91.5.126.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8012249sm13666576f8f.10.2024.12.18.03.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 03:35:04 -0800 (PST)
Message-ID: <8931ed88-11ed-45ca-9b8c-0a3c605c172d@googlemail.com>
Date: Wed, 18 Dec 2024 12:35:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/76] 6.1.121-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241217170526.232803729@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241217170526.232803729@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.12.2024 um 18:06 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.121 release.
> There are 76 patches in this series, all will be posted as a response
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

