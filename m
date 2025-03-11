Return-Path: <stable+bounces-124097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7734A5CF98
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 20:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6283AF52B
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A277B2641F5;
	Tue, 11 Mar 2025 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UdLwz+qC"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A531C2641F0
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722087; cv=none; b=g2YePZ7bmVCLPYcQuw3ZyODO5En6jbD2NBjGa8WLdgq3v/gQ+GeePukEaW2MMzvVvFPiImL6Yka78489bP1gw/dXTYNVixXZplArgOfoZtWqMRufCFXihxp71xfxGD9/xo2rO3msynne893BwSv0NzKwsVxQFC6Z4qIgX8882Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722087; c=relaxed/simple;
	bh=er+9jjdFTitNlebJQVzJd8lxcEmN5HEy0TqS1l7wvJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJScIzY7DAsS1GccgF7mZjOX6fy3RIz+BFZ8+YkxMObCB4GqlwBpIH6KyLpJ44xsDusSPKXqmEYM/i9vQB0tP3TqhZKswz87C2BlbLZTv73c+5bRkCgZX6lI1KeIazKBghWCCwYNK0X0iaR1XKdFy7Zcj+tJ03sO6PAkDuGuqu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UdLwz+qC; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-851c4ee2a37so373922139f.3
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741722085; x=1742326885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ry9akgKcOnrDWDxgZkeI6/C0nkDIdOIWsdgWlSMcY+I=;
        b=UdLwz+qCr3qaR0TXiZl8DuKxkS0+h3OgIBL4r9OVVTqONvYpb6s9YrTGzMWz53sF0Y
         YPccOLKxMYheOd+9Nvux2zEvfK5ndkjUpKYPlVITnjhsQ/Osc4at8Vzoi9+XDRITYbNk
         1arL7k1U6oZIl+RlZkz5szB2m2Kg7OgGqpItg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741722085; x=1742326885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ry9akgKcOnrDWDxgZkeI6/C0nkDIdOIWsdgWlSMcY+I=;
        b=CrIkE4hFJo40QqrWGT80TsmhcSPcnmu/iArCCPA+e1X/qKrwH/lYcEh+Wgd+HJGJzU
         Pvg9NpbUVpohwHxf7mSqhQC3HCviE4aHPnWFz4cnUyO+svVM6PKFXWi9r6QQjnL5EAYz
         9QVyxWJHUToml6c3JTFYXcmanq3dlTFawgjxDJPMzfu8EiWaQQPapUgZPWtF+MBXQutt
         65Yi2kLG93jTt/BDMCJLnkuTeZ+zi/TUg0ahsylVbMmbKfZhos58ckA7Lt4IEzuNQm7s
         8HQlgR2e72kZ14L65ynlHSWekIjQWkxC8EGbBcOkxxcPgd86Ty11+jBtJtGjPkml1sl4
         U8Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVLKARd/viCCK9KR9d4XuvJNUbR+1YQbZV+tke+Xq1PnuUsjp26H91WLSFMIxqnMqhC29J8YIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsoxGw4OsoZiiOsM3snGtCXmGbEXqeWEr1AXi6pidyB+IRzUG5
	wN9BpgBZ83ib0L+9YaJZ6VMx0yUjEQOM63Aoq/0Pgk1QKZ4m6LmY42QHvXlHK8c=
X-Gm-Gg: ASbGncsQ/7F8m3TB9LFaFfQHiGana7ZjXTUoE7rUOfY24i29KRMsO1jqpqXPsKXE3FU
	gXnCqoimzqSdToK23hUgiKR2zeshlrx7WjE+8JUr414TL/bidnY9yCymTNgrzD84SCp9wY1ch8j
	LROObTgSvwg76jFOrtmcQBZV8cjz1kRUQ7PqIveyfR0wFN+wkJMTTMUVGiczBIGZlc0CDml90T1
	opoRzFn0tjooGl9aQt3g4Xxkmx9hY9HQ2IJ4mlwp3awf0zoqIR/ZFKK3wcb0wJKriecLk4Sq2N8
	sv/Y2/WYs7B5ZaGb4AFdcxwvioYZfbLEpbR7kzlEqYdv/x1h+pgQ9EQ=
X-Google-Smtp-Source: AGHT+IE0dvgigbncy4JGuinRK+9BYgcnzpI1ilanDSCUJgDoIPF/Qbfo09x1YmeA3PCfK6PhoMafpA==
X-Received: by 2002:a05:6e02:1706:b0:3d3:fdcc:8fb0 with SMTP id e9e14a558f8ab-3d44196231bmr217352935ab.20.1741722084502;
        Tue, 11 Mar 2025 12:41:24 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d45dc58885sm10179065ab.46.2025.03.11.12.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 12:41:23 -0700 (PDT)
Message-ID: <3d2699c0-895b-4c78-8ee8-ed062c2eb9d1@linuxfoundation.org>
Date: Tue, 11 Mar 2025 13:41:23 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/109] 6.1.131-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250310170427.529761261@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250310170427.529761261@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/25 11:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.131 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.131-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

