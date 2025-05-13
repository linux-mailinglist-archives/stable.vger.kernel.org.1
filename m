Return-Path: <stable+bounces-144203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E95AB5B59
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 19:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C133B3A70B6
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 17:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991502BF3C7;
	Tue, 13 May 2025 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iVtTAc7B"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB7D2BE7C5
	for <stable@vger.kernel.org>; Tue, 13 May 2025 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157465; cv=none; b=NLmazNegeMy1GsmpOqLjxeJ6/jXgpvzKUCXO5YUJErL4PBAH6/2M2GE4zNUS6hW2zG+EOEQIsqKwlX2+PZTcc9otVrY1Gst3tyOIsfQmRJ+8qQ2GxygVs5TwY7TRQ4ZU0nCrDbTpG4/UDFe/2wyXEItt6y4/LqrXJiH7ZIRdxCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157465; c=relaxed/simple;
	bh=EKZGO4knTlWgvD7ViYHkL4Rd21IweRpy1rbhQfQGqWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mM8dCI2oJ/rY6sEGZNXQbYpPK9dH6XNiNo+neaSqvrCq88GwxKceqlE9k/1Nf7SFwdeWFimAgPAhNuo5v3Hao+wLIx4Qzibxqz5lZ7bL+W7uWjE/oPa8Th2xsl9UFsCO/KkjWRNu3EbcpwSnA3gjal9sLlvnqL4FkUpYu9+aum0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iVtTAc7B; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3da7bfdef33so48084725ab.1
        for <stable@vger.kernel.org>; Tue, 13 May 2025 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747157463; x=1747762263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lBntU9Zb457F3v0HGH06DfYXgcqKhRbeHf7CeDFOHkY=;
        b=iVtTAc7BFnhzR5qOwpJM3dUN68Jx7ioWB+IrMRBoz6Z2HLiHgg8qjLuVZefCfQ0Lrt
         6+hfgIPd3Cpz9kpVNC91a/HRaOjXtg4F8qlKh4HGl4bEH2KmNixr693OCalrNADKwSzu
         AtXo8JwHO9y20vVEXjhfrZSZj+sL64yL5JiZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747157463; x=1747762263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBntU9Zb457F3v0HGH06DfYXgcqKhRbeHf7CeDFOHkY=;
        b=kyyzBNJnTb/2HmdtTv+0obOHFpKK8Dyv09VKHRryfMq6jm4fTJb9/0ISkSECEBpM+k
         5Ek+amMZ21lRSW4Ok180qJwlwbwv3F1Rh6ugxCCuvUVCnnihUKj7PCTtw0kpY8N3niGB
         8p8rX4TLbEXDz2gmf5EPgtkxwaZ4E9r8ovygei/em3bfXYPoM3hyUPPjwnU5O00lYyYb
         tRDnm9cmX9ps0HcKr7HL72KJ8/8C4ZLjrjlqxuxANF9DmU6xGtq2FARvPuy++KOu3656
         4snKdaiDnANM1mML3/Enog2VQvhVg3K1KV6LfJ5B5q0PPo83mmcCTiBWqq0g0o+OBcPx
         kk2w==
X-Forwarded-Encrypted: i=1; AJvYcCWhB7cIGhOMkwz344wAIA25uNBAa3m1ul/ACJWD3KdUIKwyz7zoDyNHJ1JRtFni3436gyhLNKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGn18WGGqyhFBr1aS8fhvUkh9JVvmrWAXxTlVfFC2qiqNV9bzd
	YquQ4RFtuL+zkgB9v6MRnRsEguTR47np5GtKXhM15rjuD04GYsLUjgDXwrRuuMY=
X-Gm-Gg: ASbGnctfptdj9XDsqvlR1+RgS6SJUeTH4cn8xSIJIEhTvKhEncGpyEpxPPZiLWS3MrZ
	XPFY6yj9jFAEpdUj/dvW38KioEz+EzjJ7G40QyhIE1j67up6Ty7mJ+TEqMn/BX6p+nvSPSb45Ul
	/Z496a+psa7M4zUiKKGh18IX7BCBvPZNxtNp3lpkqb3KzAGaSauri/8HU9op936YgtoMwpAfsSM
	P8cgyxQkFpQzKez4G0uqCrCeh/QUfvTBydvOnApumjyV6a5/qNxj/5FjpVCJWF46HCJAg8Zzs1Y
	08gmUt4XL/65StTZTPlnAOlX1VlzMrm5MHYemsvvqB+eKLs9o5ZQOSJQIoTHu+29gqQ8b3k0
X-Google-Smtp-Source: AGHT+IFfXGh5EzpevJ90lLPFiR7gOTOcforPZ1I0Vvr8Lq/brdcUSs21qS3Q2pEIsSdxIfk2vUq18w==
X-Received: by 2002:a05:6e02:194b:b0:3d0:1fc4:edf0 with SMTP id e9e14a558f8ab-3db6f7f465dmr3573645ab.15.1747157462597;
        Tue, 13 May 2025 10:31:02 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3da7e113335sm28971905ab.31.2025.05.13.10.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 10:31:02 -0700 (PDT)
Message-ID: <3f88e8e3-1c8b-4ce4-a5f9-4c9646b6c28b@linuxfoundation.org>
Date: Tue, 13 May 2025 11:31:01 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/184] 6.12.29-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250512172041.624042835@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250512172041.624042835@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/25 11:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.29 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.29-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

