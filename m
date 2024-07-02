Return-Path: <stable+bounces-56905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 953B7924C41
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 01:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B761C21530
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 23:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D6217A5BD;
	Tue,  2 Jul 2024 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WO4au7BM"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFEE15B0FA
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719963817; cv=none; b=ufEEzSbZ2RRp/bT28t+NhHtaVVWAaOTBAttlOPaBVRFl4T8zxYc87ROe2KaukGj5pJsyPOcmy9/PzBTE03SNSey5rdZtDPJkKnj0os1m9R3uNO20nAyYvWoNK5i8aS/amQXKgx3rqYNmD23hGtGbQJmdybvOuUGicyAf6m6XSCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719963817; c=relaxed/simple;
	bh=3rHOtTtX/eBgobiyISQcQyKnKhcM7dv4HpFKtMHXTD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvapIyi+3QtGIaTGNshH0Z0MnuG1215k5jnXWYyNnGbBtQ+0HGyCi2yX/JigFAZeTBV7fXXUA/xGj9sVHvwjhpZrgvPQiA8I2HyUJSkoN9PDLhGBEKwmucuBHoMGj0qF0f9pwc4p9qtDOioGKKM1e1EmRzW8qmPwTCebQq0fm6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WO4au7BM; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-24c582673a5so627632fac.2
        for <stable@vger.kernel.org>; Tue, 02 Jul 2024 16:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719963815; x=1720568615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=exqubn+2LOYZAY1f3ejUa6v9hn+LU2tgQrcCMEUOeSI=;
        b=WO4au7BM/h/8Abur7V+l9m3SFOecICD/RLbC+q5Dd1jv7nx1fyhP2R5LMvizCerw5F
         qNYBcRjWq0RAPlHTLByReFWrhl0/vWsNxsoZ03j69jUtkMDRtjUYsDy4BRcXTpyXPa/t
         0KNKxNqL/BnkjaRW/C710g6IfSI5+SBdj4pz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719963815; x=1720568615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=exqubn+2LOYZAY1f3ejUa6v9hn+LU2tgQrcCMEUOeSI=;
        b=t176DEYZaPpoQZR4i5M5p6ug2kxKsioR/jR/3cXICVVEpLNWrmSn3t9lfgoXhYRRQc
         yTMRttSxJ8vvf3lPfHzPFRwsTHP4Gd9L1omZx07ot1cPVBya7oAY2hrCjUFuJYHLe3/C
         rKsFZOIbrFGffIBO9pbQNEWHG0eTerETlEp2ACzbIFr733l6/jt7jy6OUQ7YUnCssrfH
         g14MOprgfoPhYnDgYaG1XR1IB0HRs3rE76SOy/ryFjbO4Hn/eyNNg2kCOnZqfZCTapyY
         T6UKEj1peLZAikCpm0PsQSVc8L/TSvvapaUt1xuy57i/+Qp4efo0Un7g/E9XTNVUSXdV
         6a9w==
X-Forwarded-Encrypted: i=1; AJvYcCUHFWIhmufcmlOxz8a89kP/vlQe9P3ti9iNJpynYyzL6XhJUiutfnWNh38THGI6isvkkuzXzGpeSLCwF54dbemZc6WGYA0/
X-Gm-Message-State: AOJu0Yz2BKC8y6gem+LJUwvc0VpUHsZvNHKykp+51jItVscuB+75V67j
	YdTmK5nhCJwpiPR2L9e7kXeGM9X6wdp44RqM/KJhI4vogvs/WwDdFTA74UkhStA=
X-Google-Smtp-Source: AGHT+IEsQU8oJU5zEmQD4zGi0A+8HyFsrUfkPPf+gpNjRM6jiN8rJ10aPicdU+U6OYHOdUy8GK4Vsg==
X-Received: by 2002:a05:6870:8192:b0:24f:e599:9168 with SMTP id 586e51a60fabf-25db33732ffmr10377174fac.1.1719963815229;
        Tue, 02 Jul 2024 16:43:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e0b696ec8sm118546fac.11.2024.07.02.16.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 16:43:34 -0700 (PDT)
Message-ID: <948e3cca-c590-41a4-9805-fc8f6b43643c@linuxfoundation.org>
Date: Tue, 2 Jul 2024 17:43:33 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/163] 6.6.37-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240702170233.048122282@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240702170233.048122282@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 11:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.37 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.37-rc1.gz
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


