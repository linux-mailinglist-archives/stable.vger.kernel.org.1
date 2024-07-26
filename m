Return-Path: <stable+bounces-61890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 681B293D6E4
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 18:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B39E1F24769
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 16:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB9317C7B1;
	Fri, 26 Jul 2024 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CXZ7rdFh"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B269C17BB27
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011333; cv=none; b=Q9mHTW3koEQ95DFGhW4PoLE4lMNOn3+usKBl4sMEf3mdJcFdou11fmo/uDF/8j/NyW4G+eJdTrjOZMU292qUTmY8IOzjoXk53lLYvr6w0wrsrED//HNpA0JIbozfzuMWRBNoGBQdNsdWsSPO0ohJDlGYxYJeqomHA77yTYs8MHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011333; c=relaxed/simple;
	bh=mquU6ywnjz4JDQ/DDkE2Uz2Wzsol6GCYyxCGq3HowUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaFYEifobR9pdX2bPBtlpgnBXlqpkhMMvYb1VnYxzzUTfUCn/JuKFaGLO9aermCXzS5gB0938qZHuiOoHUATmCZzcaGVWgUlyjOj829davBstJzNBsDenVAHRowYcH7UToyDLYb7nuHAk7dGB9WzSzbQunowIguW0+Snhxegt3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CXZ7rdFh; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-81d05359badso10411439f.3
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 09:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722011331; x=1722616131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6LSLb+GcNXv5+p/rTuMG1Nke3iHiL3wBoVAeG+q1+uQ=;
        b=CXZ7rdFh43IE0rWnIsXK4kJUHfz2DzXMDuh3YQ/2FWFiFknTrBRgs0IgHKjywsEANd
         yU8rQ0tLMi0Y+1uuuAa+2/qLYH7N9KclJ9IKlfD7OYdW2JpYVrQC6zrDq73ZKLIXIuhU
         Soo9EyrBZs31kqEv+jdK/1khlNRjcWeGc7FcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722011331; x=1722616131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LSLb+GcNXv5+p/rTuMG1Nke3iHiL3wBoVAeG+q1+uQ=;
        b=qrg0xxDikCdXXm6OnoAQLAq1SoL4DOcK0rABtuThbxH6ZBBC1yJwvO1cx4oeq1q59d
         fnzDKMPogSFF9mSavK/fu/0Ra8iB+Dxh4YUNE7+wjJ1MLUEF6xhxIh89NwhYYtt2rMxf
         CsomyTjWSmGozROY2Ypax/WP/lMipNyTSLFWavQvuAELMZEKETdqD8DnSpA1FgpEuChO
         DtTS/xzmtfwpE5aK7bxSLkMM9M4OVjUlTWN75xExbPOxgNT9eO9HSjtP4gRKZJmOOJeP
         JruDV/4twwouZlLATTfs+ZqWaFnFOQ4GEpWVjqFHigTRtax/zn3dHqQAortJEDfmZUWb
         us4A==
X-Forwarded-Encrypted: i=1; AJvYcCVNl8N353mxVlegFNX/JrSf/oQegiLf6ggcEFvtxAjBAlz67Db8P0YrmZwjB0OG9mSbADjW+uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXuJRNcpUCioViUOVXFyUG7hqJ5c6hPX1yCYAYfzP78Almvioq
	0RNAiGPYzWmtAEAdJQbV6kpVZ8QWi3/0GmCUolRwjJBy6Lci12SdVPsZs2EvwCQ=
X-Google-Smtp-Source: AGHT+IG36a6KJseR67jskiTVIquUkz1PMahA2GURB1GVgedlRkR4qMbhMAV7SV+PVwv0fsN/5IOfpw==
X-Received: by 2002:a05:6602:4f88:b0:81f:8295:fec5 with SMTP id ca18e2360f4ac-81f82a54258mr357558539f.1.1722011330710;
        Fri, 26 Jul 2024 09:28:50 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fa40509sm905994173.7.2024.07.26.09.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 09:28:50 -0700 (PDT)
Message-ID: <bc28c629-5710-4fd4-b477-1fb9eff21cef@linuxfoundation.org>
Date: Fri, 26 Jul 2024 10:28:49 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 00/29] 6.10.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240725142731.814288796@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725142731.814288796@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 08:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.2 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
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

