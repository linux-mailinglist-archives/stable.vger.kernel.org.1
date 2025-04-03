Return-Path: <stable+bounces-128159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3757AA7B233
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 01:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50CE3B7A35
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95F41A8F97;
	Thu,  3 Apr 2025 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kwGRLbJK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD9C2E62A6;
	Thu,  3 Apr 2025 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743721129; cv=none; b=Ps5xQ7ARIhW3slArvvUgttUjrE5pDC8AtyuFX3o/4PZIqz5E4FSNsXM7W2ss7sx2TSypWMI6U+Iw+6Z4OEkcxg1M8jztLY48MNNY48aEGm7X2XUCN6buC59bNDOl+wDRNhgaxcMWRTvp+qzeIGpWcg9ku7Od0Ybi2RFE/+IfCxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743721129; c=relaxed/simple;
	bh=7SIN2hexdpw3G4S6tVVM2oDtFzqOWy0OdfmmHYgNtAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UT1Nu58W/e9543AcOeW4jOtKO1CvgafR2S8EgcTJ+j40EadAfMjdI4Fzs/FdXgJp/84zWfkEHpAtN6d/JoYipPmPVkV5AtUaNE/kbJrwa0ttWxVfvp1UyLDBwXapAVd3zHuTVngw8XAbjW+ypNhiFbJPga1CoO+B0ZZlvwO3n74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kwGRLbJK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3913b539aabso813730f8f.2;
        Thu, 03 Apr 2025 15:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1743721126; x=1744325926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+FFwcvDWoOyMhNi7mQy2ScAulCJ8ZyLMXd6mGjg58s=;
        b=kwGRLbJKRwotox1QX2blQrOsgBTJ9uSTl12IL9kRMDdRUWaHx9qGmLhMRkSgbK7Imw
         ZXcBh//SxdXab8NDAcSdlhAX5KQdu9fkvBc8s8CWfTD4rQ1iXVTtjN8cRK1ihdFU3EVj
         ABGz6F0Uo3VQ4ZFm32EcezpgtvShpKaDCXXB1h0ziwP2Bij1KOknRf51NKzsOyYdf3ez
         Buik2MBwrqeSZvh2xu+9zqT7wanhjXlOMG6cCgWdMcxuZwSEjxwxnSXOw2ULtuXX82Co
         +99gNUj/KxAqRcL+MsPckX2oNdPKFhXAtDgLBMaaYjZivemE2UGNCThYr19Vh8oQISNY
         zg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743721126; x=1744325926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+FFwcvDWoOyMhNi7mQy2ScAulCJ8ZyLMXd6mGjg58s=;
        b=fx1KXmgkarLfNaE0wkNBXZfY/I2/YS9+ANzkadc5IWyCmYzUM784kkDtVb6IE5s52l
         7xHW5tMFquP4stNcEvh29sxxK1n7VgPA0sXRJCuTdhoTYjfUDcqJSQHS8dHdH4etQ/MM
         YiVr968kS0OK48uFq1ubdRTnvvh0yRqDYA7ODhxZQnRca0OTUGyq0stgTyHgxwZ/ENLF
         pMkcgNcwRBw8KE/T7dNE3PmM82m8M6YQU2ceqE6sC9vL1fjvbbIjcitCrHwv4I/aZZJn
         mtUi4vzM15q/b2CrlAHoSlEE0ILchF4/PtU7+JNVzjiw43t1gILzvV97/AhzLJDStuOH
         5dbg==
X-Forwarded-Encrypted: i=1; AJvYcCVHOso0wSirLnCERE8WV2/dSUHepx8s+x3OA4DNOyWuPIAp4IiwhDq9l/43/sOI0GgGYAxrjKBX43ZG2hI=@vger.kernel.org, AJvYcCVvya5cCRhvkkgF77ZkKfFhtSqTvall/1M4Y6GoJRSqUVjkg8JQrNfAZtptSa6CI9XEPe4Zdgo6@vger.kernel.org
X-Gm-Message-State: AOJu0YwOIS5rkJ5d/gf2y5JjtblVJgHknT4mqgu6hgxhbqTpvuvUyYZ+
	Folr7k5NHbYjNWdCcLTWIPJ7Tf6XH7+xm7G26ZxmAikaFEpQUAE=
X-Gm-Gg: ASbGncsyrJ5Ung5ZVTljja+F1VbSDXLUqCrDBhYte2CU4/waabsQ7xtICOvnnictraV
	mQXfIq08vZjSFcaG7fvtsYP5JeJYdOYGQcCoBb4dddn3upUCLVkTB581aihsbkhFe4ogm8HpYLF
	Q/qRJlPTNp7/6W6AqY68iAGePBCdh/gFza1jYS7fsocyAdzYthcCM1LA4NpYFRvW+S6WOJiks8E
	VUHbZWTWQLLqCxETIpv1oUlumd05h7aTKGqr2ZGpSQlbYqaBKF9++x2KMfnPMU9oroUkj4uYH9U
	ANnRwLDFyPqP4AVm0dphbqC/fqvMpwZ+joDeniR3xsH+rWBIM5d6gl6sAFBn6vM6bcRYM1wVf/1
	FYpKrh3QNI+6Uw1eOqSpQhBo=
X-Google-Smtp-Source: AGHT+IHX5qW4P1LyaCQfghxnY+ihaAZCPiVt43gu3VGokfmKB378OdRT2OieZQoMLtHOlr9JnVZoqA==
X-Received: by 2002:a05:6000:22c7:b0:391:29c0:83f5 with SMTP id ffacd0b85a97d-39cba933215mr697520f8f.44.1743721126075;
        Thu, 03 Apr 2025 15:58:46 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac393.dip0.t-ipconnect.de. [91.42.195.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b760bsm2915329f8f.55.2025.04.03.15.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 15:58:45 -0700 (PDT)
Message-ID: <bda845da-63b5-4669-8ca1-f12ef49728b3@googlemail.com>
Date: Fri, 4 Apr 2025 00:58:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/22] 6.1.133-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250403151620.960551909@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250403151620.960551909@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.04.2025 um 17:19 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.133 release.
> There are 22 patches in this series, all will be posted as a response
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

