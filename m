Return-Path: <stable+bounces-158609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 191BAAE89C0
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 18:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A83987AC37E
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B9B25BF1F;
	Wed, 25 Jun 2025 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7zcnyKZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C3326B95B;
	Wed, 25 Jun 2025 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868852; cv=none; b=GHE2s1cTsQ7tIC660h4EXoh2OmUu0jGvDk7enlc76cUijTJaVprukE2Og1ctk50TBPuB8WMBvzKTqu0ohz9cWzjZWLu5LQzbJcEuApjkOZEXwlvIGB73pFu26uWB8DOnFjSO8rWhTBO5tmAQi6HBPEHMvdxXOFsuS/QigkvzhGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868852; c=relaxed/simple;
	bh=y6W6zPya3lXDxU4cgKvwEtgWuTXgUzRyViA8Bznnolg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJORMp50YDjskrnj7mHEihhUmxd+7QYwonUndT5xhjbxqsUfbbspHP0K96eKthpUOdrENr5pX5ZacW8Z284TiqXkRBcMxBEvn019LzIWZ+S4mlMGZUoacaSnBO5uTwb6mi1pM8bkPQijAcZoG9kRqwWIf3tbg5PH5C8GAbDoScY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7zcnyKZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234bfe37cccso1500465ad.0;
        Wed, 25 Jun 2025 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750868851; x=1751473651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IsFr+1V5iYRWJ75npgS4t1Tq2cZT+LO/CQv+S0XFap8=;
        b=h7zcnyKZb+wFvAM99W42jT8d2hr2RX1bsUjLgWVWdS5l79f133ZYKKxBJ6bEqgLLe4
         yske9mbmHqsPOICRplniqVi9D/WEQ9auil8h1xSeGSiXHFtIqNORLzK4Ln6VBMqn0QBO
         +isKl9/dy/1tnHDwU6H+igEMPNe5qiKko1H0UWlr33UpzO6kleYcniexHP86jPTwlFuh
         HPjvk9he1AHx8GF5Lf77C7xfiThrl4QCBmy4CMxAmx5c2hknB+YRlfHLX16P7y0z815I
         tNPUkSUs9chJ46ZZ+IYEATInAXystgfhYlV65Mn0/Z3Eya6p4Ule0OeKivF2vNuskoae
         QYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750868851; x=1751473651;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsFr+1V5iYRWJ75npgS4t1Tq2cZT+LO/CQv+S0XFap8=;
        b=jtv7kU1JTKc66ObNINlqbOKimtqyaGgN021mc6PO8l4Z5JOMBd9slktGrENAlfJbk0
         4Y/2x45Vqv2DvXgb2xsYebJILEORbSqfe+fbWAFtJE6uKeYGXhnmd/SsWlONOvKjGOoM
         WMgzE88j7qt6QNrglEYBfKo5/yPGDxLrO9IA0+sUqcRxI2aYdZWIgdvNJewmZy7o4vEj
         OadeTvjhWMnH//b7LbljW7sHxTTZiTf9j2RsKeiBvdGACOEm56ioUUUwZW7s9n4y5yRR
         D9VrhFaLQoMK9HtfPdxj2df4lvb9Xn1afc0Vgl1/fK2xFyLBCWM+uuBB1LukFqQ+Cz90
         w30Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdOtVmKnZWgzNw0D42jpu8HQClh1RhzdrEwgB2oOrXX+hvdXrqZU80wNjVcAsjtskPrrRs+eAP@vger.kernel.org, AJvYcCWKgoA48HQMuqAn1ovgSo7jKkxft3XOOblKQFmHMBHmMAcvQISLyE5IkWnNtunYDKjD6uNLeFZSxl6nrC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsnj60Q8L2omnS6wla+6m9A4PfzUg+wKknGKuKqel0ACISbMqY
	bQOWKUnhSVantviKYXiOHW98bhx+o2UU9UXXUOwbkdZ2Vi4jTmtDPrht
X-Gm-Gg: ASbGncsK/8zAc1sko+pur0ozvwV+I/yH84AFPMG93u+vtzFHqhmg15QWqC+kksvFqJV
	JOdAzVWzqjT7O0WJwx6trQ5G30uobBoIhbIJnRvTJGkEwuSEzAXVdgNDmvAIyfCXJINqJe6qsTR
	VPHlN2pfM1cP5mAFos0pVefjdu+jHFZSN4ngtpfmfrzulOf/+d0AnG/RbjyTuY59MbfjiMKdxXj
	5fwZanWVWg0p0lA06xbVIz/aI/j2jlBKEvoHOXuv8DU8PzpBvxplkfrkmOnIkHxjqd++a1Twi85
	wLbNTyUQ9UhEzAv1JSy/qD+wshuAIwwM0030Vncg6h/n/G7t0PmRG24UN8Km3FkwYnwlIjQ9j8x
	QsEHz3pDC4wyRxw==
X-Google-Smtp-Source: AGHT+IE86AQsJvE2y+yh5Jnj3E/rQyqP2WOrtHepcYix36Uok6UizH6CyqqmYlJFBCNYqI5ia+iXCQ==
X-Received: by 2002:a17:903:32c7:b0:234:bfcb:5c21 with SMTP id d9443c01a7336-238240f42bbmr65309555ad.19.1750868850559;
        Wed, 25 Jun 2025 09:27:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8393275sm141959865ad.39.2025.06.25.09.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 09:27:28 -0700 (PDT)
Message-ID: <f57166da-5d59-4398-b011-7166275dda8e@gmail.com>
Date: Wed, 25 Jun 2025 09:27:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/215] 5.4.295-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250625085227.279764371@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250625085227.279764371@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/25 01:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.295 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 27 Jun 2025 08:52:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.295-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

