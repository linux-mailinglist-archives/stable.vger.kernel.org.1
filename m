Return-Path: <stable+bounces-209960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC9CD28C04
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 22:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 150CD3002D3F
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 21:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6A530E0F0;
	Thu, 15 Jan 2026 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dA1oFCHh"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533729B79B
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768512965; cv=none; b=oGmzEBTDnWU9tVcJkjQrOLIQDFKJV60cLw+xUSl6Es1ol2/Z1Ol1YGq461nTc/wLEe7O8ZUuIZsVRXQwAda/7oLugtQxC6haJZn0VgDogmQ/WgST2Push1qeBD0XZdyYUwZ06r/UgWydJnAs1mPL4ux0znY6W1nyAVqVe9ugLa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768512965; c=relaxed/simple;
	bh=0sQoRqfSY+hyeYi/0+boEYgQ1XLwmvKzG1pYcjamd6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qccgDtCVUJLyf2Ki7oyXU3p2ZSJvQuppjoc7yT+GMfsZQ0b0VBnpHn2J/rc7O5IlPLdqTSdu/l3CwePSEIz5RVTYI2H+PfEtftNPtUqXRPvm7oAWXm8ZxwS0EuHfqlg1Q6tmP/GXgFGSpU8nRNefWj+b8pcyRronZJYWle/9QgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dA1oFCHh; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1233b953bebso3456429c88.1
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 13:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768512963; x=1769117763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oOX/JJI7Q1z1KP+63QYnKl74UqM6Wtg0qo85jQYwjQk=;
        b=dA1oFCHh1W8+j2b0IffPOqLibUvz3So43/bDrYHtds0j2m63/ltPCeZXkV8cJ5xrml
         sA+XMq3t0HFW0C1E1cr+ep4aY1mEKXRdORVN7UhHNFSIoRfgWGKMSrg7sWjM8j/1ibKN
         6i4ozJ8Y8IPfVk5Zqkul/gisHJXq088aixD9K2YnMNjF7b47d3g/OznkdYCvccBDM7R3
         NtZmvF4uWt+YEKdelizwE7CYIZD40ufFTUHpeGYVK8YbAPIdvQnCL+8FUdU63Tg2FYlJ
         k45mgh9AyZE7GF8w3CtgKJ2G4KAHjJLWcoVUR7gpZJRawLcFguMfZ5UIlB054QlMJE8S
         Xk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768512963; x=1769117763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOX/JJI7Q1z1KP+63QYnKl74UqM6Wtg0qo85jQYwjQk=;
        b=YnHjiUmJMwX7m/xQ7bwsEPQicdcrzitxr7Dk2JfzSU2RzLBchWDgCucYOgahhBtyY1
         4bTNGxrjQC2H0Bz7Pr19pRscOH85prLrrPpjPq8VwoZ9eaWh7CP4TKaOv9YtgDPcb/9h
         +WohwAgSdKnp/sRCF6d5LLkj29OO4+wNUsDtbjnDBB2jFpXV2x19ZHsGFZ1YBMsH5Qvg
         bPmElWYDCrl6Yn5irscmK+s3yy36dDvM3WD53x1bKUZvcJx+t1O6h6fPQuiD0RSIJzp9
         MbXybHT5VfHN4rc3j9bYmDmtQBwwYKwzOtUG6zij3z9T/5CwGGNCtUH+VizVAjjDdJAr
         711Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBY2LGdbOyM2riVv5JteosMRZ+bF/fe/nAwXvpNa3o/1gU9bJ3721iA5aWrhvGgDN6SsLOUpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7SRX09qhL+JOf8/8xTAnzsUxyei2KlJK9EbTUgkxflvW3/+Az
	SWqqGzEhZCCxZMm5Cz2IFZkZCQ4Ak5+vkBGvhlz1iqdPw42/310T/w2e
X-Gm-Gg: AY/fxX76Uigg6/JvFC5ofL5B4Lp+s+ToCqvmr3/J1d7PkNbDl2KUgV512yaYQVphaCp
	zTCqdOqaEpblj7EBA5MeL1DgYxsREPmdYI2eOyRobPs4GUrhVnIC3PrKyewcsitdQJhfoA13G4O
	mMuL9qJwjCOU+bsZcTLm4DCx1KLXtn/zKXpy8rOUSH7iCh3Mk8/zGL7z2uycWSNLznW3sXEfUuv
	2AMZKkig2rbccfDwo4l0b8s57L5FMoY+gjvCC4vEnbLBBwWINwNQUA423te4ASYBBFdR8ei+94r
	zEQosY8lFF9rAGqzxSDRg5asAVKNf9SVPPoOjrHcB/DTcIfufMtBqYHwX/aGKqM6U9gvfi2FfGl
	eWc3t2HxM9l5aYI9CEsJq35SE4Fr2h7mfzR81wBP/hfaa5KRy/HvR2M9RrgmsZnqLlZF6m9CorN
	EyrNtSQDh4EuXjtsa9OQ1eHyifn6rpELGxGRt71Q==
X-Received: by 2002:a05:7022:619d:b0:119:e56b:c752 with SMTP id a92af1059eb24-1244a73c91cmr1270516c88.23.1768512963424;
        Thu, 15 Jan 2026 13:36:03 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad72063sm763558c88.6.2026.01.15.13.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 13:36:02 -0800 (PST)
Message-ID: <9092c7be-c691-40ff-a1dc-561662feb56e@gmail.com>
Date: Thu, 15 Jan 2026 13:36:00 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/451] 5.10.248-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260115164230.864985076@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260115164230.864985076@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 08:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.248 release.
> There are 451 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.248-rc1.gz
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

