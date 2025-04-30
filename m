Return-Path: <stable+bounces-139200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC41AA50FC
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 17:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2461890122
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 15:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3330A2609D0;
	Wed, 30 Apr 2025 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hboNLRR7"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370302550B3
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028672; cv=none; b=puVcEE5pPjOoh/voitGisgeOoqABMu9juLidSxK0N2sI7SjZ6xgPfcFrdX3CCNn//X5TBWijxYFegJvSitmpLch+nYi3N3oHMzSJSJFS1O/FmC0uU9oBvcfTe4cGTHjjoOqNiPDsrWoU/Avb8RkQuYbeyfssQ3kdY8OHIEmb/hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028672; c=relaxed/simple;
	bh=icooOvG1MON2fuybzZe5mX+3Hn69WjdTbAsnDAWzhG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1n9QopUqc/fhdpe+6qNiWUwborFzCMLF50vp+DN2OeGSu2yS4/Vjp/Dt7/IHRgN62Lo6FYW071+iooowvp0IUvKUYHbfouRfTnGpNlaZNzoLAM+hLnhn2lofGCV7n9NixaZfsnc8cfv2D8/3VHwS9LrQcd5r6xVUM0zq8x7KKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hboNLRR7; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85df99da233so815569639f.3
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746028669; x=1746633469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=in+6deFjqSfAc1zu7tlNRMCOyeC3LE1Gyw7rsr3duwk=;
        b=hboNLRR7Izfk1ounpUeXUkcdKfplJJiUj12JXKyxtXmlWVXlkTPvzbDRCHEu4ByWuo
         lnJQrHLtbZzxx8rL2tP+pPTEAzTk4LjYgh6bIEXIa+5zhN4viLzOhIWwSPvczWEVRyGM
         lb4PtKzV1bMwYfKr7OExb62dw44Thld66FhAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746028669; x=1746633469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=in+6deFjqSfAc1zu7tlNRMCOyeC3LE1Gyw7rsr3duwk=;
        b=YrwG5llJY6eTFPF1YRIMiSwjQHD05cdpD89v2t8ZvIvROgWgWqtkVJQnW0vYjwGiI4
         jqIJgg+XibmviHqplurJor70FEGaZ4EPijr+ARDkZL1sVGUj9aV0qtKEvrfrigxsHzNo
         ihQncPr5IxjkkGv3G3kFw1L6ZEBpRm7/ePnUP3TO+QQtTVa8m1Y6ELbbggHeIRl6YoFU
         oqzKiSTGWdmPSPOwUdcJQFB97BJx2OVu0hMroOUDufaCcy6kWU4OGAyFDT8AETpXeqxH
         +F4KHwtUVV4xabZ1AAWe3Srp48zMxpjMKVJ4a3YOgrLQUV41m7FkAM9XsYpOxfCrc/oo
         ENBg==
X-Forwarded-Encrypted: i=1; AJvYcCWDMfwSb2BbEFh09AckrDF1o4uH8ngndVDoFYCJLHHWoG7RA0w/+PqLz8PBFQRs++1cHOV8Cc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqu2wNehrNyIMisrV89IvxbOZjbkWVpU74k5o4Y0bPytBaitp8
	xaGRIQcQ4QfaRnIX8V+04qjs+QkFz64Pr3WsXbgNhsdYTrGDS89sxMOGI/qTfHE=
X-Gm-Gg: ASbGncuvFFmSuCAdeXf4NlxwJWjJv7wxLvQVO2v6cdbu0wjKvpXZD2EXKUOk7ypOr+3
	kiZzV9GWMGwkVrEOzlK+JEO/6bPm/p38kNYyPiy+Eg/232ykcZmKTROsjpOZ6rlSGbsuw+epxgm
	aTWsgpzzKzEKnFJz1BE4mGvtexOgvXoUh+oi6WFr8SpfmDGcX9Fdy2Yhox0GcOAHGqnTOouu6HT
	I5N14SIj40XUNZiqnFcICjUuslr8Mqn+R8+5yQh+kV8dsUFVU7HxSnClgAzl8D+CaYdjidJJinm
	sQtzC+TNz/ORppFCznW7/5xghn4LZ1fGkhXPAtiVzU8+4h7Ah20=
X-Google-Smtp-Source: AGHT+IGYNWe6JaNQWYYAzHPd9GJwHWYQBcIrp/Fmzu3Vd7QqTXMxBqlXe2nDlYYI8grBym/KiaLjMg==
X-Received: by 2002:a92:c267:0:b0:3d6:cbad:235c with SMTP id e9e14a558f8ab-3d967fafbf1mr31807335ab.6.1746028669266;
        Wed, 30 Apr 2025 08:57:49 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f862e0eee0sm809734173.25.2025.04.30.08.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 08:57:48 -0700 (PDT)
Message-ID: <b40593ee-e527-48db-8e53-6973b3b94858@linuxfoundation.org>
Date: Wed, 30 Apr 2025 09:57:47 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/311] 6.14.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/25 10:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.5 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
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

