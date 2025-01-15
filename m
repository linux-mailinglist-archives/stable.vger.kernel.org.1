Return-Path: <stable+bounces-109176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC28BA12E46
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 23:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033C1163207
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 22:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17E11DC991;
	Wed, 15 Jan 2025 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgECRHyp"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAABB35944;
	Wed, 15 Jan 2025 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736980185; cv=none; b=sLTcNUasIITN3uLTwVFBgZw44lAAseLniX/eR24/9nCClrALiimn3P+JUKQJNsY/bnq6V1OEGMiJedX2ftk2JV3dIfSkz/6oqw9U3bf/vL/7pxuOGcFPUGgrOIW/tPPBa4ZxsLuSdvxnUkjb8BPi5GneOd4+P27gNF6jG6e/kco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736980185; c=relaxed/simple;
	bh=s6gPntiD2V4UBBYGYif33c6UrOWCARmxQUAYkpyH0tI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZzIGkE/KExv9xrQRq3J8U2LW/UIHPIj/ta51/utyDIUfbfxJ/hhUyJnEAEtkqZGSIU1TkXIumSKjWeDU/pi1dYQBu1LajmR8Ol5viHlUXnQ5quUD8lgds69wvH92HvdZz9hqHLLBJkub7A3iVYJisBNmhvl3h26C2WZsOqwUN/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgECRHyp; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eba0f09c3aso130988b6e.1;
        Wed, 15 Jan 2025 14:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736980183; x=1737584983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e+tx07dOac3+JSVRvB25jEPEiAu7gK7dIEvYFm2GHvU=;
        b=mgECRHypwHKcdBAMacyHYYTg4yuQyaU4kr+/8NGUjgdVCBadNDpgzvEfzqdh2d04jQ
         KaCN95+7p/HwxSM53zOj5lH02rNr2Gw92ERMIzLcgzbma+osm98GmhTZHuVSEtSu1Y71
         wO9BOCbkY5FLrFIAqNPjWAoyvKWN1Y/VM3a2ISXRToO3lzIXJRCQP8aixPYHI7aRl1lN
         YptOJ2DlK7/+IRxenbCJB9T7Tfi2rl8alWtFWo+O9NYYXjrAhO7lEI4Zfy04AEyZH2eO
         efPRFweJKfPiNSLw8NmufzQfPZrhXu8KVbJL5qDqW0Gic7q1I7t5p9Wh1P25Msq/KJ7x
         9Whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736980183; x=1737584983;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+tx07dOac3+JSVRvB25jEPEiAu7gK7dIEvYFm2GHvU=;
        b=MnBVMIjTQ9CFjW3GP1Qh7j5MglBnusAs3EMwywdfuQBDmkBgx1SK/mlRB7z6eAdfhR
         BQaZDWrrkyAjsJYrkKqUUr8dfq57qwv1Zew1afmoLJoZYXk3dBGL4Y55JZT9WatgNuUq
         08tR1CscFL4WWhUxJ+tAbPJ6H3EAFTN81WCkzR5GKAV7Z2ZUAozuk+q+eU8Vzcwv+Eq9
         Xjhk/oAAU1njVzJ/0ARqPq8aFJx2RucTkNo3PaUeVNx1D/kYgjDVNrOXVPwD0eg5mGbq
         JXsc2nVza1KqA6gSc18F62FXlta7kIVjIUiknOd2WPJ7HwVHacoNtRCiXCFWeuY6PO3a
         sVgg==
X-Forwarded-Encrypted: i=1; AJvYcCXML7mcGrCf6nCHf6fMrGOydS26drebZCEfmbCCiXagJd4MVRzQmaQNNz68E9fMwRSZ+NVYrhE0@vger.kernel.org, AJvYcCXsswLRoCE2DL5qLUo+tnEoDo8cOppbWZWZKxJxwYjlES7G3oMZdzYZurgFiOTx+581aupFmjkkmprggcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0FM3clCmUWGC1K73ahDG1AA6SYyRcPK9hSKytI4hpGJDnp9+z
	m5Rk7eo8AL9dUNOfZaaW5Jc1mSRWWE/1AiQQaTzkFY8JNA0igchR
X-Gm-Gg: ASbGnctFWVoJOc+2LtqQVW6FKn199v5BWuwA30xAkTcOf5/1hi8gLh7oqwa6c6UAqtY
	DMpH/lDLIZL9R5s1pjHv1dcnVj1/uu4Jc0Gq2Thqw4sqNq7dXeSIYgYomLtqQxYnVGsoDq1gV3d
	gwIpWrgKFMVacs/LxU9vVghaAPNiBMUr+6y7XSKiyBVnxWA7vBX0ujJ0q4CBOlyd5lE/2P0/hQL
	tp9Q5p5zifkCMc3F57XSe9ZLaxRBKlHh9tOXu8zlfOopKMz25C4Qck7DKAW1vO+/PJLcbUhgO1l
	qLDOjw72
X-Google-Smtp-Source: AGHT+IF6Z2zaqIuM/+qVEJuL8p+glT9tcj3C4U7sfyyCfNbZnYWMdH+DaFrkgRSRXjtK3xSDmdnJCw==
X-Received: by 2002:a05:6808:220e:b0:3e7:bd97:759a with SMTP id 5614622812f47-3ef2eeb0d61mr20256311b6e.39.1736980182947;
        Wed, 15 Jan 2025 14:29:42 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7232698f926sm5432040a34.40.2025.01.15.14.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 14:29:42 -0800 (PST)
Message-ID: <d0f81c10-7d78-4673-acc0-d9101310d9a9@gmail.com>
Date: Wed, 15 Jan 2025 14:29:33 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/129] 6.6.72-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250115103554.357917208@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250115103554.357917208@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/25 02:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.72 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Jan 2025 10:34:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.72-rc1.gz
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

