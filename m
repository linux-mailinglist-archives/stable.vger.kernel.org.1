Return-Path: <stable+bounces-191954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C73C268BE
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 19:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141943BCC8A
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 18:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB145351FAA;
	Fri, 31 Oct 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdIBg2fT"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7A12F1FF3
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761934927; cv=none; b=IQySwvpcaiw+eUimxeqNKlWflStEtP6azuw9xBFO71H28Pn8rSeAD1c/tw+gcTsKm/rFNtR06h8+JuZqCxvrUVdZJV7qE4gk7CKsrNBEt8mX8ARz7WXI4+jlrXBcWkeou1xmIdFFsvZeo4glv2EG560aU5HwCbXkdjOujq+7edo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761934927; c=relaxed/simple;
	bh=v1UakN9jsJPX7yNaZTbgyP8GASSXUsSW6o8Zsu1ouC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGe8D7E5n705nTNKv7O4CDIOdNdJQZu/XNPsbyUzkc8QelHaYVyv8JS+ruVBBNaypPol4j0oZfsLR1ch4/y0Y8LOUx/+H2H7IlL1kbBPhul3X2KZ5JGr0IlOh/nyvk4Csya4GQ7LeoUMnN0t3z1o9mpyIICk/m2FVB/PzkM3GIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdIBg2fT; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ecef02647eso20709221cf.1
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 11:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761934924; x=1762539724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WNg7rFgur4Ks9J4kEGe6V9kXX8sEbPHDJWbUh7qSANQ=;
        b=XdIBg2fTsyB6MmtTo+yrX1t28QOJAQ1pKH6y8hRe+N6k8M/SkISeoDivWrmoKeU90Z
         QqC4Dpj0vFdhYzvJj4oOaqnre2UCj/ps30NNrBkWrbtEHxNlzkmqs77wKwTSVmQG/Bx9
         2PchN7iOPBURnsWdZRnP2J6Y6nRZgS7dz2V00MSMfcu69gzgazzKzUi64sp5hLgl5XaP
         o8CcRbVAplkb5edY1bR7OYzzV94F5aNkf6CFBFcEReUtZNSUxp8WvDrW0kqrjvpBohob
         4a805RH5aybh00MdtGh7yz+jsCsbeUDpXtWE7XGds0wglqZqKUNzxZJAVJBfXYjLUjb0
         pNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761934924; x=1762539724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNg7rFgur4Ks9J4kEGe6V9kXX8sEbPHDJWbUh7qSANQ=;
        b=nadEmZEc0sGqs0OI3wnLO7+eG5Ad/83GV6Cr4cmfFCAfMbVmBp+In+H/6SFTmffCBr
         8XQ36a+eUc5BRFApOSrxhrBp8rZpETDPq1IuUzSDQ9KeYIEDurYS3U3K3ITl3e/UHzgz
         5rZd+ogfPJ7sfH5i3AsbEvQzBLA5qwEu8OEezliTMxcFeqybUlSrYjA4WqLB29J8rx8M
         GU6UXOTM/pEliYHIi9XreJ7yrZyqqXLnZVUFui5ZmnZHnQVZlyPiZS+VwILwK+pEmZIv
         FxQhE/1q+oobLUWDx1w0/7xVICUuMEfRAUzhekKd5yClJfXIGmkGlfVbsMRSSL1dwJoH
         lkIA==
X-Forwarded-Encrypted: i=1; AJvYcCVx4poihvTTpYfq9Q4XU1m07Ht2PFpcE8kiKaI+k2GS5Y704iJQXWe7Wb7IUfp1GTctgQM7EBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzwyA6vNsb/DLyreFGFlR/19h2Ypb2dAe6a0iKmG7hUB5bqexz
	ImWWzQSiNQwqA3QxEGwKixlIkoofKifL67Nb9wQGTfk4oXw6LT5c3ZFC
X-Gm-Gg: ASbGncuF4o/1gwacTECqCfhe3TTz/AZmkUt3fFVpFgFqQkqyz2FM821ZtNpg7G1hlPx
	SBfd8WR6XMpq+EfDoBx564yFAOKJBBNbCMaK+vwFDuVX/1ZhjWq5lh0EsWuaTaaqeP8ipS8m+gj
	PR8xX3OrCChUHAAvJRtuJN9fR9mRet2cAYDAF23QbjUV5hp8iHVacx0RsHYWnP0RflumMP+3bfJ
	DfiBSTkAYQX+G1IgsUE4MGFpwgzbpis6Fc5ikCSGI9c7NJmbuLcdPBM0u7HjTUvFC/R4UxN93Bp
	lC8j/LN5zJuZ/jlOKZgk/onU4x09QDELmMFcg6NYiDMOFyUMvKQbQVViYNpwVhFROMhpuv1lBYn
	jTREptCFOd8m+AgWCOvCabpfyll34GqQEOkJLVIIMVJfJO0z9F+KGdHet9gFu4SzPZFCZxmJp0S
	2G13JCpTJsOkJIlQtH+RtnS+AZjVvBlRhpWSnR5w==
X-Google-Smtp-Source: AGHT+IE2Y4cl4HdAmAnO0Nju4hog4gnzrMfHzCSqMbr0G0SdGHuWH2lYj4xE8ZKGSbOxQrsimKrLbA==
X-Received: by 2002:a05:622a:424c:b0:4ec:f285:4256 with SMTP id d75a77b69052e-4ed30dcaa9cmr58851571cf.25.1761934923830;
        Fri, 31 Oct 2025 11:22:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ac00a9a851sm153268685a.20.2025.10.31.11.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 11:22:02 -0700 (PDT)
Message-ID: <3305be28-849a-4892-9f62-706d6faf0f55@gmail.com>
Date: Fri, 31 Oct 2025 11:21:58 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/32] 6.6.116-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251031140042.387255981@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251031140042.387255981@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 07:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.116 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.116-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

