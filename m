Return-Path: <stable+bounces-119553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7710A44B66
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 20:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96EA13B5FA8
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 19:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C155F183CB0;
	Tue, 25 Feb 2025 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWAteAa5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D551990A2;
	Tue, 25 Feb 2025 19:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740511985; cv=none; b=adD8fHYsAaSoYOCnTTP5leYREKd6vx5LqSeIDlTfFjKYQuSMscUBdkvj9KLJdm4Vjottf3JZ2X2Trlm+Gs7nwBMgwEajqQnxGKSKqc3NlsfGi1cBY4wcjew3Lodswvo6RQehC5SaQxz0qIStTEcmywWC2XdZFSqDmOdlZeGLG24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740511985; c=relaxed/simple;
	bh=L1/3SKc8l7iQDSrFmOoDCO3JUgx4ujK+IIIgTIEi5vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAm5OxfIE0NJ3O2KG0h1J7VLnTaFH8e75VcNNylNSci8KLfmqhogQ/sID9Esa8VXClr6/djcmlhNFhKd1C1xwuK23Z05NmlzJmu6o9JajSbSyhY8yAzmR6otmL53TJkoblDvmGNE1oaoGFWkRcCQblyZ0r3y3qCFN/xnNlqSOzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWAteAa5; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-727295a84c3so1631763a34.3;
        Tue, 25 Feb 2025 11:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740511983; x=1741116783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Miko2TmZIyxQH+Gi61JnK9vZXA4QBkP1Yh5ec2O1TNc=;
        b=dWAteAa5e9uybwRQveMo4+ZvveI3KPllLSCvM6sce/oe2s0nmEVUnQHzASy+fFMXRy
         f9g7GeczbHHyhMPWPeBLHhQn6K4kME8OB2iapLRUPnxJAgN2GhmVpP0mRzL5BIP9RK4q
         LmoY7BSluUew0tcKlfXgSfmkrZZDLWk2oQck6JWtfLdVGohN+u2Z+Ef+zXNIrONLMtyD
         3vlT1BRy1k9+8qkZeV7YMf3Abw7kEucx1+KSfxaPx4uLw9unNG5NteGTa29GIwI7GOpo
         +4/FRuk0PzkcwrW24MElOnUhTCzGE0HY8Lv/kKaZSfyV7gpD9YfTNnKmavrj7Yel9yIC
         U3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740511983; x=1741116783;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Miko2TmZIyxQH+Gi61JnK9vZXA4QBkP1Yh5ec2O1TNc=;
        b=GlzOoQV9+4KU5KpEO5dP2YLCaaPGjJb33An2K/p/178BmFRcaUywYu7tIYC/cAOYVJ
         3zM7/A1LNbei7/B/DUi0H3pY5VuovBp6M2GFoEo8UUXmRiGwh+Hrpod701L/sVhMayn/
         ipU/SyvC85FVu0qjHMxGhlIGdy23nYYwrgnoffovGU1rKZM5llc/btivarN3HJPj96l6
         panEYSnUnYTKfoJj08/X5S+L1vTs5F3gAW8W+1bnMX8R6mjwmEmyJ12NHv3+ELNzPFES
         Rbn8wBHBtYMuO7UxovOlBi34r483VaT1hOTIBzl8WpNF7+Pw85Q02QO0n+OpjmPHiKAx
         UO2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjD30YysPI0WNdGVBVYxzUF4+SFurBgyxw02wnqPy5vlkh0qk+DLQwZO+zPzSdvGry4djEwac7CYuzrkI=@vger.kernel.org, AJvYcCX68XnCOWt15blqx3ggRf5r5H76afHIx+lAqTYoA60p9Vll6EYs3OZ+dKUWu7+11Oaai++BmYdW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx05hJ7NjUZWlGFFx4MPk8TrI7yYk/fdN6JGAWSFwRtq/6tuQQb
	8CbaVIK83YEGiOfi6t1UUebrvTjzvffF36T9Mi8dXwFBKcQ7I5dtJjoIKg==
X-Gm-Gg: ASbGncvu5U/Jru2bkoelSS5v9wn7lefBfuS2DCZoTSChpCKS1D73lZmEmtF7bamLPJG
	3fnpQotfJs/gIDM9DIPjou/tUhcRB9gyE3iPzwQzWTVk92q3lwyrZlCJDVd42M9ukCmfAoU6uuG
	jZX55m86eacQUS3wVlTPATWcx6z45RA2YM2pZW9da7JLPCEIvWu4Gpecj6u62lKXfRkyWjzMHIX
	STUx5xEMzBMh2ELx7os+Qc+AG7WE0JGOdAc4Ucd7h9SV7cYkjfIJJnNHDA00jZ9+GwbuwJtETBs
	msoFTGemg1WoqmM5DWghPJJJ74a+mPcscEL65EOxsw==
X-Google-Smtp-Source: AGHT+IHQ3RLf2c8orAvsF44RAiI7PLXG4mCbFCPUQWf5N1ah5oJ3kD0yAmfLigtS2jv5wP03VEOwQg==
X-Received: by 2002:a05:6830:3590:b0:727:3692:149d with SMTP id 46e09a7af769-7289d0f181cmr3630523a34.12.1740511983028;
        Tue, 25 Feb 2025 11:33:03 -0800 (PST)
Received: from [10.69.73.201] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c1111f4c55sm515413fac.2.2025.02.25.11.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 11:33:01 -0800 (PST)
Message-ID: <2dba0ec1-52e4-4ca6-9cc1-14243c310765@gmail.com>
Date: Tue, 25 Feb 2025 11:32:59 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/137] 6.13.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250225064750.953124108@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250225064750.953124108@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/24/2025 10:49 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.5 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Feb 2025 06:47:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.5-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
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


