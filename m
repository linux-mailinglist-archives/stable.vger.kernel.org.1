Return-Path: <stable+bounces-131991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB18A8307F
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 21:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F883A700F
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 19:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C341E51E3;
	Wed,  9 Apr 2025 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU1I7nyd"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97491E503C;
	Wed,  9 Apr 2025 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226767; cv=none; b=Cdq4940b9xoa/HhX1oiFu+0PNyttmXBGNhgaIrKFVVcRimHKca5kh1cj6H6v5UnzZwOOCnjooI7mSVZTqEgrm6165fNkX01MaeoljDcy3mI3W/P3DTLR0wO9HR4FrFUKQWuxmtyNMzVRQzy/1ZUKgMGNR0CUjZo7DyjDC+GwXks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226767; c=relaxed/simple;
	bh=3SBEV8MZfMBjCqYFLD+ArNUi8Y61hUNgzgmis3D/R0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVO4i/Kg7nYFVmaHvthWe/qQeaCd6P0BTwFaUSwm0CtpC9mssVMR4SNdWMWcA3k/fHpotWIojQKKiGdDHzPUFnGBr3+E3LQKhpR0uixv6cmmbUOjC71QvuIAISNSX6LQW9kqjwgqL13z6JPdxlLCON8ZHLbjWF4doeLv0YRsADc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU1I7nyd; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3f7f7b70aebso4267710b6e.2;
        Wed, 09 Apr 2025 12:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744226765; x=1744831565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i8uCw6ZP/r7CK+ezW/oHT+okn6HNIqDAYmxKjHPCBPg=;
        b=IU1I7nyd7YL4nibi1kYJ+jRq75Bt8owzVBp6LOOQlUivuh0QhB8wO06Vksw5fbfMKd
         B8GxUoL7ywoyNQ9Nu3mHlW7m5jFzFnpyxQVbLVRYaZRfzNMhxebnbQx9tEMuOTs+jHKE
         6o0hUropsKtZuhvd8BQAym/Z+mpQYSL4ZQfXMoLgyBLvBQoAAlX3/mrUKkpN8EaHnR3V
         muhRmn8kJv+uTmkJt2vmSQJ2NEQ11x2TDxOv0qVjck6w8UvuP+9UQ6cN4tDPgjfhgNVM
         Z7OePSEdbbIsqxtPrAeoVjufsL4RFhRxy8RJDpkuSpd4ZmaMSXWR8Uo6/3ZkeCuc3n/c
         1rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744226765; x=1744831565;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8uCw6ZP/r7CK+ezW/oHT+okn6HNIqDAYmxKjHPCBPg=;
        b=EvUxk6T350Et0xWIjU5Xef7qNHrLP1E6xvT48d5eKZzXwognjuViYR9orCSxCxh442
         Tji2k69FQjRuN7F6345Ekovfc/EEP5MDEe454LYEiJL8EhN1UE1PHNOGo+xFQsO3bPco
         brwPK1HMoNBUkyRYAZhFL0jFlH+ZlKihsBWY2etM0UsBF0/fb7FoTd9Cy7XIu96o2uEq
         K0l8KKsUycjujc7b7ad5lzlFR/kAMuR0y4lgf2KkEAM6Bsz525fjg5XSVfQeIUB6Pyfk
         JmfsNvXMPzFhEwGU/TOc6J5tSmbRDUQe58qlN/zrSyONTf4InyuruA5B+EkCg8FUWhKe
         0ZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR7V/w2kp//UQwkKIUHmAdixma39SwssYluDX10dLUExGnrut3YEdMweB92lr6YuTpw8Xx0kjo@vger.kernel.org, AJvYcCW/xQJll0BUpyn5Thbj8CfuBImT0RNbyC7/niYoo0HrksrgmkqOyfO3pkpCYHe/6/POkCyLvkNtfjbJ6ac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz06GsBy7PeERUXdW811O7IDH9nKRMdnHuXBsgwz5A7gD0gyV8r
	tfbAJMCjv//xSN7xfEHDXPwODQnjFy3Z7XxFCmQatTfc51bA76jh
X-Gm-Gg: ASbGnctSXf/P7vBHsxtn4PEmQxZYOV3CVgk/k84j61Olm4YtYkHb1ZDiQOSLLZiG79c
	gnyXpVTOh80F0AC3kY0Kc6Ea30Kaxq/JLd8fJf1QMYT9XVsr1bTIl/StVWh4sVwaO67u6ncG88k
	88OlrTeXf0D4KyXC1gvn/2o6PJmD+rhO4uwK2gr1sn+cilQUXrc9wLje3Tzp66eqWcKvFr+ufic
	7nhWXAPsgTo1ugbt5PWRsB7K+EPI101S5zis1iUd0v7ky11KAR0FBpSGuoq8rHMUf+jQvJT/JJk
	axK6jOjDqZd9facaaTdtlL9CaXwTN8iQbVKgwMnBaOZrXlKM8DKN98FGY1DLxE5zfo/m
X-Google-Smtp-Source: AGHT+IF9qtLTL7Dndec2tinFOG4yDv6dWa6r35oGFtyju8MgFEtnsBNPWP88QJSq7xaJtwUlJFiInQ==
X-Received: by 2002:a05:6808:188a:b0:3f6:a6a8:d340 with SMTP id 5614622812f47-4007bcc3f63mr49436b6e.16.1744226764630;
        Wed, 09 Apr 2025 12:26:04 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40076282682sm276833b6e.3.2025.04.09.12.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 12:26:04 -0700 (PDT)
Message-ID: <f43469f4-9a92-448f-84e9-66ee85127bce@gmail.com>
Date: Wed, 9 Apr 2025 12:26:01 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/228] 5.10.236-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250409115831.755826974@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250409115831.755826974@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/25 05:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.236 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Apr 2025 11:57:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.236-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

