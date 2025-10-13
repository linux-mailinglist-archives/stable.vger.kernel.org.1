Return-Path: <stable+bounces-185481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02122BD57D4
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 19:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D359A426F18
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF682C0F6E;
	Mon, 13 Oct 2025 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHLQscY2"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D6629B22F
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375385; cv=none; b=joJkhfLloD+gGzi/OIR31OhKHb51aVLnLeJuR60IG91b/negMIePNj8IBm6YGyXOZBc2HZ5E1pNdxdR7t6qy365EF6E9zX1bBkaogqmYBvmfi4gG2BVu44OXRUD79YTcxmm+JkyGVo1DMRsVWBjAvZxtYUlcBxJb34hEqPYXRFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375385; c=relaxed/simple;
	bh=9u0qMy/Cq9gqm/KPJ3Ei6I8Bl+VxQM9WS7DtgkWaO50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uClStXrrPejmqelixm5VxPEHVM36KQi9iHtFvpGaB8m/Y83FD9TvrYc3QuEk0TRFKuLMfmZSfyIU5l47Zs6pnjr5pjHeMhbKe0yMS3Yihm2igc5gxSWC+hJIP32Z1+3PPtKI1TEp+O6oOUrmPuS1/ZvthOjWHyd0idfLmSQVxkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHLQscY2; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8572d7b2457so672256385a.1
        for <stable@vger.kernel.org>; Mon, 13 Oct 2025 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760375382; x=1760980182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zq9D0oiH0XGev2bvZJNS+y4TMnPelGliSASbJ0U8VMY=;
        b=lHLQscY2jSPd6VKhZSx1pFzuEv7MuQQCCj9YK8FJYsrohv5LcFXGQAVcm0YlwU7cmA
         KLzrnflWZNoAhnGC1Qa6lS8wWVQh5dVG0zrModFqiFKhsWhTc/Q3Nsu79ce9R2HRHrXg
         29BGDk7lWrcN/IT0Pn1v8BZBnTNXjeKj4EpOxEdE1iNJxkJTbXK8Nq6xvgUdl6yAJQqt
         ohBGRLG8353+97rIpQZMlmIJdHlgy0QSMkdf57NOBZAGbBj02X1sapKTJZvbmP4AH7aK
         sC0UqviytEeVyxTt+yIR+AtQbUNoLq2zZZlrzNxx63piIlo/JZNKdddwYJ3RjzQu8s72
         i4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760375382; x=1760980182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zq9D0oiH0XGev2bvZJNS+y4TMnPelGliSASbJ0U8VMY=;
        b=R2hb9ZOFClu40SdOmzJY7G7i5pE14EIQVNvSRgdfYeNV0qK57AfrWGTVpQy6sAsT2A
         dbHmnIVz4Pr6cjEKEKVz8PLVCH00MP33lSUkgLNRKg1T2/pOvcizP8YCtcRxiXdqPxF9
         V+AIkrp2F2vfgd3sNyo8b23Rt5wA3hThaC8YT38Obr4clc6T7M5OESEgIKVZ2zBnwQOv
         zt6sBwRxw7B88BXppl92i5rFWMuZMxbQ6CDZt0JRieKOspf3zVBMnfKmzp8D3sB/gc7i
         IxVjL1VeE3LqdO3C9pNjRg4NCexScCDFGJ/Q1/ZQmOpYxKwvrzORpdaNmcf2XpjQ+UcH
         PfOA==
X-Forwarded-Encrypted: i=1; AJvYcCV/A4222wOcJV5iSdTsDXzeRtwuyWbyOAEmr1jd3aCPKgUopIUKKB6q+Jpgl8D1GVUggC83UuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVHIA+JbPB+Za7Hkw5NpWdHt/eDGAR5r9XiQUoq/gOlt9ry/45
	LjCIbSWyokxXMBEKkObXyCD4ow6RGlKXLZ4YD5UKhWAS4oEPySiJ30oF
X-Gm-Gg: ASbGncsX0OKq6kpnKzRigOKiR59PcbH9a1XpBWti//mObuEfv+J8GVve6VHgSbGxUXz
	8dpswHzeIDqEf4NooYQzUgzaHg+/rzeV5OkRYwaaWbVMtFfP+N2Rh/jP5tlag4wTqMFjuvnXZBh
	XEN0iEhzanwm8IX1wbdOYlLYTEKezpK3nlGHgw+P5QmiVNUKSrFTo/mlzjzm2p37g5YJbQRfeUc
	S/CQVm3sK/NQ0B/7vW+uROXEjr3lev6NHflGTnon/Pi4rcYdnsTgI7FgQklJuBh1N2pDRFv5t84
	WT0XndZ8UjxEo50fbb9ugsekfXifzk27S2SI4TQ+TfrwIdohv8EcvkroYox6eNtqLXMmwODwmzw
	a6XYhi6KG2ANN7Nsp8MXgpxYam/PQSy8/gCif5nItDOf9boU09ywyly2kDg94k7tFLroE
X-Google-Smtp-Source: AGHT+IH+yeZp4fthmE6bMZB75N7lU2V9amhOgMmYrKXlYcGZT8jtMuHVCUKmGe6PAoHqnGK3ukeXPA==
X-Received: by 2002:a05:620a:1927:b0:87d:9a55:7566 with SMTP id af79cd13be357-8820cbc5160mr3723625285a.28.1760375382268;
        Mon, 13 Oct 2025 10:09:42 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f3d862csm1029109385a.10.2025.10.13.10.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 10:09:41 -0700 (PDT)
Message-ID: <8bf9a72e-759b-4c98-ab11-6c31461db7f6@gmail.com>
Date: Mon, 13 Oct 2025 10:09:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/563] 6.17.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144411.274874080@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 07:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.3 release.
> There are 563 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

