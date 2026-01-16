Return-Path: <stable+bounces-210112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 537C1D387A2
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 21:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FC543065A9E
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 20:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4801246778;
	Fri, 16 Jan 2026 20:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IpMueGc9"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527964502A
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768595635; cv=none; b=RJjg+Js7m8XIdqVuNTnlhCmiuYLWWVUsqjcIzfVAsQndkxwxaREBx7/ya+QUdXoFKVdgMcDqUuCAXYqUcG6QNrVq2nMfgmdwmSdCJJm0Dp1DZ4KYqMP3ue3Db1s5FSn66B8lYtnyaxUSkDu3noTyDhhYY6a64NqN7yTCzqApFa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768595635; c=relaxed/simple;
	bh=u4fF39S7Us2Q3vQJAPNsEZLLzA9mGZ7GyE76NaJoRHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CAU7zRg51b9wEF+8eXjmtjohfot4Pk6cgW5ifY7MhOQiXHAtIUBung7XqODYYq0ABeyZR172gVwKQVCK8KZnMcRUlnF83kZxXWDbEi6aM/yFbb0FAXV56VtoVP9qV964IntN7dBlUgAR0ACvp2wQeJPjVnm7FsinxFiBO7kLXPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IpMueGc9; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7cfd9b4e3f8so719619a34.3
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 12:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768595632; x=1769200432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CbhrvKb7Fr8u7hAx3MxjikhAp17dM7W/k6oJclqAYJw=;
        b=IpMueGc9dRvng+grQa+9RuaQ5zIgoTirSlLSNYUGwZeI5SgbS/yegCULy+L5g+VZ7R
         PW/UQlWGINPIYTYKQ2LipH9815SUU9NiUEC8FjQJ35vdOAqFzDWejxqdKjOdQtXGRIN9
         +lKzmyUhqQJE0lZx2NnkxAKou9fvL9WxpL4zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768595632; x=1769200432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbhrvKb7Fr8u7hAx3MxjikhAp17dM7W/k6oJclqAYJw=;
        b=ndiOyrOyUU3/t2qzR/TekNTFYYHpXVtojP8F4uoIBH7OoYp6sB2oP5tnpsBFBw/bNR
         lyfPckKjHAnBAD6FeMOmmii8twMoOll7GjZmnvmic0713O3Mwmqs92up5ONjQ6R+WB0s
         FZPoHZhHGdVsvaEqvPWUUiGVap4D95IQwJSygdBVnVQjZpvXcj5WNSDB69rx/Z3Gl0a6
         IGg8TFM2dDk5jxOZ1BIwWMirZnziLq1Sm5puiZ84Gt3BzTEUxs3jghvD6EOucEyohmlf
         oJrjkSeyyHrou5peV1jfg3hfL1DFW1nXNi3dsXTv8o+lFx2n4AuR51HU2nuepH80ernv
         Ap8g==
X-Forwarded-Encrypted: i=1; AJvYcCUdmOMr71KY3snJpltcvW8T6plE0KoSSPrJQZyUZbjYI476JPwx87oK3P5fhAuzvzZ338UBok4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZBN3uQ0NjVGRMrOeE243HBoVvGGVd9KuBTdQyFapkfcjW4b9g
	31XuPWDPbB8qgyjYry3dJrgazl3USzBXi6Jz45P/Mi7HHzVLMvn+eCEVVK6FFNGN17w=
X-Gm-Gg: AY/fxX4+HPW9EL3YE3KyPbIO8UjZxJIX3bcRlfkOb1PyJPTo/nUAzRYp0E5qO+xTdaJ
	oeF0nwIVzbUdWS5EOSRUwOJoJH0tzxL58auzd7PwtVIrVEQgBC6WE7vX2Ts2VvVfOKdozeLSoln
	d3F17PU8cBANc+dRDppvXSkLNtPvSFxSanu5QwR++2b1Rseq3qzkyWGD4R5B3Lt35e5orxXdy7Z
	v9EA47mgpY4sYl4YFxKDXFbGoGjiQzcxdnuQISwCmzvTawIKl3Y2v+w/HUyahds4GtDJZ9XoUrw
	2fNGOF4r9dLY3zmIDp0bd1KX5jcchRRgJnFnjmF5Lg/Qm2z8hci8Ok1RwzPaggnvP5PzofEAecW
	81bRczGXbf8s4O+FsJHlCIOMS6gM/THlcM4J7nyKqYyiKD6fU7cTwwnpAXQVTTjI9hqkDUCqrkG
	9OfB/2CHXoVO4mnbjLXmf4rZ0=
X-Received: by 2002:a05:6830:3bc3:b0:7c7:da3:ed22 with SMTP id 46e09a7af769-7cfdeeab584mr1781007a34.32.1768595632233;
        Fri, 16 Jan 2026 12:33:52 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf2a5f02sm2255511a34.25.2026.01.16.12.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 12:33:51 -0800 (PST)
Message-ID: <f1ea1fea-a804-469b-b3b3-a25ca693eecc@linuxfoundation.org>
Date: Fri, 16 Jan 2026 13:33:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/554] 5.15.198-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260115164246.225995385@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260115164246.225995385@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 09:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.198 release.
> There are 554 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.198-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

