Return-Path: <stable+bounces-25392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D87BE86B52D
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 17:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770641F26DFD
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 16:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC553BBC5;
	Wed, 28 Feb 2024 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EUxnTEKA"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671401E4AB
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138394; cv=none; b=n87/wc21K0CvIxPBhmhKN5dspEx9jRvTNY+wTWSBXwt1f4PvMqRkPUtP3dYfJBoe4T+shrSR8DJ9g8b4rEjNoEQ6Pb0CMokX9rBggPPlM+hgioMrlgOs6By2+W1gKGPnSLHkSuLj6gnH0vJ6XBY7xukdEG5qsBL/FKZG/qC5Tlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138394; c=relaxed/simple;
	bh=PZDf6Z6qf0DHOIC6Adf/nEul4voHVYJq7s+h7EnxYbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMwdSZPeZxARKCPF3Q27K7hQZkr/ZeWkLyUMF35p00VkyxSy1KxpvkO9S2O6WABEjlFWU0CBuhAPbEgRsgkSq8L06L51g3758bqJJXIb5ySKMmpon0jhdtm4e2Ty45/alb+Uv7ffsQeCevg9RWXDMS6ILRcWOSdsZUUO+E5KDfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EUxnTEKA; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso113926239f.1
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 08:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709138391; x=1709743191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3YwFcibZYyn4TURE65NeFWD6oR0EJNbwhkMgk/B8ptM=;
        b=EUxnTEKA1TzZ6A7vYUkJKZHjZnwUKrL8SIpmV8glKkivFOmWN7PqzUagFkf/3aNC08
         dXeL3/KGKfoMvNNbLCJs8160DyazfpKqxdC5pRvZdE/xgdp/WkV+Z9FXmsSSgn+1aqAw
         uFZleNzb7s31ERlYzYcVI5t8GhOltSBmniddQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709138391; x=1709743191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YwFcibZYyn4TURE65NeFWD6oR0EJNbwhkMgk/B8ptM=;
        b=Iki3ceOil7XdPw/9cMS1XhT2PO5fAUqjFplFAV0inDxp/aHAbH9NTYWyTPUwJtNbKL
         1m7bH2ZMmnfqHvlspufIjlWxEzx8RqmjJpXYWAM/nuA7FzQxcZKBpIJbIhoLFBF2wXa5
         JaoDlumuNwQk0D6PHAWDKSf43VexnakMNuHDbwLF1vs9vctQmiYwg21TcZ2YhnMbK2aq
         QTnen3HNmHvgi7cHkk7nvUqCJ3W9aUTJ52McqtGUz+w1b6cTr9eYXygduhbonKH1rwfJ
         zRzNypoG3VKQ6pihxbun09qOf2tnqM/hP7Ip1dlpdzHZWUdkvYhQvwsSRrTpqm9Bmahv
         /8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL14SYEQ7mWffk0e98GgDtMbjQQwJBCkQ8HEBpCnZ2oaRjQdLUV1YmJJXn4VECbjttvkhIyITqtUJ9w0bu/+BJgARgRdPY
X-Gm-Message-State: AOJu0YxnwHqAVQXhMAmVVnx27vNSkuo3p90q8A6/1+MWLTjvXNCuuRBk
	X+EOLFUChTiX41gK8AJhfPC60OGaz5q9zEILaN5ZqGioG0/UULgJo0qVcZ4O05k=
X-Google-Smtp-Source: AGHT+IHiLzT9E2N49Fi6K/4Pl1Twu2MlJpcKH7yo5vXyNT87r4Mo0hghCzsyOdKBkevlIl9igVRSDw==
X-Received: by 2002:a05:6e02:1c43:b0:365:25a2:1896 with SMTP id d3-20020a056e021c4300b0036525a21896mr13469149ilg.0.1709138391488;
        Wed, 28 Feb 2024 08:39:51 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id bs17-20020a056e02241100b003642400c96bsm2891272ilb.63.2024.02.28.08.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 08:39:51 -0800 (PST)
Message-ID: <ef1161a2-8c85-40d7-b8de-8d668f9d8625@linuxfoundation.org>
Date: Wed, 28 Feb 2024 09:39:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/299] 6.6.19-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 06:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.19 release.
> There are 299 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.19-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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


