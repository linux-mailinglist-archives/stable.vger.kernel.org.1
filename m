Return-Path: <stable+bounces-182859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10288BAE52C
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 20:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61CB1925E60
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 18:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8384324BBEE;
	Tue, 30 Sep 2025 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RY02zDuq"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91862343B6
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759257436; cv=none; b=lI+WyK1BxlpLR5+Dpk2Hbcl1EmyTFrleff6hbrqnRkwBzt4InvLrjDjx71jReSB3xQjibStoB+d06eyDy+MuB/dX/QiDHvJzsX3uKI2aDayheAGbV2HO4IqidrdLlHW4NRt85vmOacggX0TrMG3Z53dhnIiU7Ys5M8SkmT3ZsXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759257436; c=relaxed/simple;
	bh=UzISaNqBnr6oPeKPZ/ZMlptaIWSDz7JBW9vqCatixqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oq2x8jb5SDq2E+tO9kaAjCHtjhbY6Ju8hOy1Y2YSxENn3WSBSEXpu9LqAj6Qrqe3MpVEeInkskN4qzanX90IGuCzQWkKUw6r8Gh7JMZSNL+nXzJJQiGfBS54ljs0UmYqhY+7Wf0grReFJ1z2YZL5mLeBtH4nozbyBRDEeAMvyIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RY02zDuq; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-78ea15d3489so51247006d6.3
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759257433; x=1759862233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2QGQGEsrfTFXVfCocwQk/OlKEvR0Qi5M6Cv20Qoyek=;
        b=RY02zDuqEn74SsWRmi5IbfV5gu1lyv1rh2J/LfwhvoT6G+8uaAdTPDH71mfMnapczZ
         +LDOn22BFcJBuncxK7oAqzKSqqGfPso3nABo9jMu+EY7aFvF21Oopa6ex/+EMcINwk88
         6Nx4G9GHqOeH9JMGgLwFi1ZA4LUv17RBcCbLXEzSzY8May7apXLUYykGMwdMZ777YUZ3
         dS5ZmbZbIYjvj88eeDJq3gW0cFYa/a1NWrY9mEstcolr7It1NXS4G2+dJHjltbwSsHaT
         kRHYQTFbvartUtn8cDXou1ajtLby3JDjFiaAK4XeBRKzwpuYw/4gv7drRdpr3v+0SqWd
         TaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759257433; x=1759862233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2QGQGEsrfTFXVfCocwQk/OlKEvR0Qi5M6Cv20Qoyek=;
        b=K0K3vcS9Tv7aXQT97aPETUYvqy2cZX0867ZkwhLCx7XEN4PC1fKOqhInYnGqYfJYDS
         oiv98tHpeQp77vjajUVkDjzdQiuFeLQ2oavGVB4fFMubZjCqXTVZHQnIRzqu+RkrvgCF
         czi+dO5YXt3J3hFqvvSU/xO1o/kyXY9sRSHbfYeb5sYB4jhNnZnUZqiRccTTyIIReC0i
         XC48jRWcV3MywIYM0o4qbJULxT4DHnb52VYttLkuZ3S6KPI/MifFgzNwFlvkU8YsoSaQ
         raykAc/5enjaopCYSrY47C4FAw47SYnlIO9HzI3ZzJKUBTxtp6oI434teyOKLw/4nVn1
         9D3A==
X-Forwarded-Encrypted: i=1; AJvYcCWejyPO9CqrmYBPnlOyFINmOUr8itNkyHQ1312TOOrm8hWnTJLKk3xKSd5LZL9kbXNcSenLm+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1npl8lgprqCSLmDUiu9vASj6pblDSIQXcQ5kc+ulSRfy6plSs
	MWJ+9qfZlC+FxVYDLdkZzbbcAv+5z4/IOJMd4GeXfyu68huZ2J7q2J8T
X-Gm-Gg: ASbGncv8w/5uitVZI1FFo6d5pIL8A9WcHqo93wE8cm6yAGt3GBY4+Lt7g/pQeNBQ3pq
	rZhye1FKLHcz1aA3bcYXoJHSUj4EPCnAkNdgpO3K7HdPTDbaSx5iZL2MKzOO0OuhjF3P3sJ1lwT
	yZtknA8YqlkoEPRtzHEvYMbiAJlqo06xJQxnSDlrIip2XuW0VmmweENCMgJT51oCMC/G66vJyUz
	DBms9BrEv1WxesQ9si8zfP1SE+6nldM+hhghvw6Q4lLZavaGVf/UUBCyaFyQML0tQ5wawLoKot8
	R536RbmTovoD44TkLOWD/IBZZbBGIQVY8uGiL+12XIsxEjOCzZdIyN/QXwjtZhaqF729iOfTHQP
	FmiAkY20xuWvgqlBI/gSKVPoVdqfhAAr4fSlnVeLM1E5Ppo2i6UjDgYyJl2DmEIoAOPmqDh8pIy
	yZ9KHc8Vkf
X-Google-Smtp-Source: AGHT+IG1ZzECb3HDDfSi//Asq0waIXTic0POdoKNFFJPYCDQ78uGhB+aw9swukGFQsfSRdJwVYvYxA==
X-Received: by 2002:a05:6214:1bcc:b0:7f1:c596:e1cc with SMTP id 6a1803df08f44-8739d051ce4mr13159286d6.19.1759257433401;
        Tue, 30 Sep 2025 11:37:13 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8013cdf424asm98541956d6.26.2025.09.30.11.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 11:37:12 -0700 (PDT)
Message-ID: <94f572c9-36b8-44c6-86c6-cc28f90de64d@gmail.com>
Date: Tue, 30 Sep 2025 11:37:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/91] 6.6.109-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143821.118938523@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250930143821.118938523@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 07:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.109 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.109-rc1.gz
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

