Return-Path: <stable+bounces-160099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF9CAF7F89
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 20:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E2B1BC6DA9
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 18:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50212F2347;
	Thu,  3 Jul 2025 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kwf5FbKz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A03425A2AE;
	Thu,  3 Jul 2025 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751566023; cv=none; b=HXivBI6JxzG0DXjrgfEYf8xesQ+fUXuyBrJsCREDKjoohl2q7XTTndb11E0yFg7rHVIyNyOBYyeIE6aExdPLzryzO10en+591kvqysSTnnwkI1HB4e+JDhShBJIg4WBZwB0bFQ7pa+DJpC5T6cya0xbeA5mgQEAxwPQ2WZpOWvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751566023; c=relaxed/simple;
	bh=BzLWTbMfFsVXo35fRgZVne7Fs3XUj0C1UcQbkXdcTps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2v4C5kUXkk85vPPPpELxC9C9aYzAeRe3Yrc41lnY5+Hr8HypV44o8dP0bN2JiBjkc51FXImBlctqBnBsT7oT+fDdwvj4XD9GKDDaBTbW+0A+q3fbbrCz5wi3/yvM7e5i3GQiWTz+e41jvsv9hN72JbugSQslaOr/ZPURRWj3nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kwf5FbKz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234bfe37cccso3581095ad.0;
        Thu, 03 Jul 2025 11:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751566021; x=1752170821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EHQEYaj+iDUhDrp6imJpYERRC+UQ594YA99inPj/G0s=;
        b=Kwf5FbKzGDto9JziwVYNgp0e8qf5wvDj+auZQOc4+BC9+DONKXwRfsNZIqUWB5rGv5
         9Uu6z15Ox6iI27yBZXurMnEHxzPEGKKZ8TEPNHNscd0fXFyd6+hD1LNXxkzokmBeW963
         qCb508tJmx4kBgRqNiiqMLOIsqDaakW244aNXMjXZEHvX3VSveJriEb75R2DaAsKoalk
         zlPzRygnOxgXBE0o6ElzLqlj06TZxxygVdzhYwwvT2sSPCoDNxmAH3yeTftoXRAN5RPg
         0hpcvEoo6+vzoaUWtMxxJvfhoWalsSA7PGzOI+fwMlWrMXsDdXF5GEn6DNB2v3CBoKr/
         +Yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751566021; x=1752170821;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHQEYaj+iDUhDrp6imJpYERRC+UQ594YA99inPj/G0s=;
        b=oGvzJa8tH8RzhMhftDAyQQO9LvsTRBVmeLC7Jnd+Lp5r+a1lByMAAaXnOd6nahvRvt
         JKb4a76lt8vmp0G2zhc/cewsYUm39iqL5XTuOOyE8WOZBt91WKsvRLoGK9awDOEpTqKa
         OqctEmD1+JjrZu6pC0ulH9fBnXDmMpPx8l9kPO26AwpLMgVQp3r6oG/D41sAtdzDw2r5
         b8pJKYvRxex4/FFeVahe2oW09LaeHwbHXr6lkWfoNujQtBkinY0ZeKCpk/VF3O49mvq8
         Tfz7+aaaZe7rH/LT7dEvEIusGOmj+sce3ImTYdSMg+CYIgZZPprV2NZ2Cxyx+XQlJRvq
         AKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCwu7RCEzNVpXWbJTpZOi2ETug3hdw4cdB1kRRhdue4VPP7GK0832tmgQwXo3df9CoV8EvK02Jd5ikC2M=@vger.kernel.org, AJvYcCXRgQsomEGrsNzYtMziA2OS3+YCASWqdWKL0iSQy06tzhqjkzOeQOFi/3UEKvVUqn4NfgXbN4zH@vger.kernel.org
X-Gm-Message-State: AOJu0YwaIspTC4WKi0xlgz4m4akuoS3v9lbzO5cu2Cmh5EhhEkev/8VO
	fWzSlLbKS/hhoTQ6zQ2rJNGG2GpWsK4EbtFvvALDMG4fvbJYLnLIzNnK
X-Gm-Gg: ASbGncugU5Gpj1s5/GuEG1sYz0KRV3LX8m3YzeXne1E67c4DtRfdDrAO4wM/+PnrzUm
	rbiye56sZijLEXcTBEKc/1CGTSolYAanR5Qu0XpeVzV9ofdb6fiHcLl8fVBYCZqAyEmk3hSurys
	oz06j1RNz6y8zdBYwsmsJJp8isG9msKGWMMqqlGIxSJBGTpwkBeJ5bUfS4vPUmCsB/VnVBtEyS+
	Gah7v6+4Fvso7mUlMWQvBkbUicx2FkDJ7cn0FU79T8VZX28zTkTjW29ZQJ33GmzraqrE2jvUGHr
	/4MgrHUxlamLoIX8iX6u8ZqGDPKHS7ubxh1WlXrb1WidgnA8EOZ4qt6VX/J4uBNzf2OunXFNcFw
	pCwOqIpbyjOVtug==
X-Google-Smtp-Source: AGHT+IHdjnzayRVELLyeO72VCfF1JXbWFHBzzkfpgdbzsLTr369KwCvV4vhvtrZfO7WwzxB3JdpoEQ==
X-Received: by 2002:a17:902:e549:b0:238:121:b841 with SMTP id d9443c01a7336-23c797a76a8mr53916515ad.17.1751566021504;
        Thu, 03 Jul 2025 11:07:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee62c862sm182735a12.61.2025.07.03.11.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 11:07:00 -0700 (PDT)
Message-ID: <e9cf49fe-3cfb-44ba-abdb-e8ce30a960d8@gmail.com>
Date: Thu, 3 Jul 2025 11:06:59 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/218] 6.12.36-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250703143955.956569535@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250703143955.956569535@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/25 07:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.36 release.
> There are 218 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Jul 2025 14:39:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.36-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

