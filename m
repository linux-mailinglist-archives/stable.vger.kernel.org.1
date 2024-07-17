Return-Path: <stable+bounces-60457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71733934013
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 17:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1B41F22031
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC40180A94;
	Wed, 17 Jul 2024 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JMKb9+E4"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEF0374C2
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231877; cv=none; b=a/HxUqTz22LACdUlebOwRxjBzJ/TRTGvpNh1dcTz2jpxeIzE3EwlXlVjZRxJfogXxF7OhkOiuM7nOWYkeqUH41O38kB/0I+g5EKR4cNHBuHor912WaeYerJQejhnQ4mzrfJx/8ZiUCXZVsUTGDBLmmKj0YKJRKCWonqQ+wNcPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231877; c=relaxed/simple;
	bh=yEDShaU33yVXfWVbkz3WINqO2ujZDBlOOhoSKKzNAfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GirWMCE1b7i9XGUBJCfoRxXPDCouHl7VvJ/AW5bBsy5Kka1cFgAjnvdAJv4TNSubpd3aR52pz2da3A5+t6MZD1G/SoAldIXPjL5QjoIxCNc+VyizLTo0Zmms27RET2m4NqApJrwVVFBFcIiugj2yjf15yn/Tyd4+R60UXdw/uzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JMKb9+E4; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-38b4276d643so625755ab.0
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721231875; x=1721836675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hUZhzpQoP/EpenvVywEbKuumx0D3/HwN7bh1DfuNzEQ=;
        b=JMKb9+E4+jdp6+aAfYFPivNAL+mawodPwr1qEXwPi0OXX7aELQUqFtEcItOChqwkNz
         FTTu+ZjERe6kJP02vhx2V6YbNEh4A4q6NmZXEmt8i0VWzWuj76P52t04ii9+4VNLluVj
         uV45xsBSbIv7TzZEdDKzoWVEysyvVPzH4c3gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721231875; x=1721836675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUZhzpQoP/EpenvVywEbKuumx0D3/HwN7bh1DfuNzEQ=;
        b=hxEeeX/my9YODFv1ZFezlmokGoC+aeCwJUDQERR4q3tO2M7AvFXVaV9voee3UHAEjc
         PDiMJG1SSSBSurnVliBa7l4njnDUuG5i+LQmAJhYXDkZkfWZtVsuhX0KyRSH8KAKXLUz
         sjXPm66DDjhxP2cJanMTo2DLEJ22sr/VWTh5TtbEPuEBbX9pfwyWNhueusmzacn3vKGu
         OwcpcUcH53teGABs4jGFP6jMRYa8WE2rif/PZdcslsugJ8a5Ymn7nXhsXZwfzQtsDhsg
         f/vcAttcXI2xf97KR6oxS67cVyppSpIaQSWC2KGwCa94q/4IivtUwmZ9PZ9zEiIAZb/b
         /4gA==
X-Forwarded-Encrypted: i=1; AJvYcCUrKhXH44js35U4XgqtL9/90pP/RGzefnhck122840YngkI30MsTw8wawsgjI9L5uocxb0DPei+ebcznCbxhS5NOHreU1m+
X-Gm-Message-State: AOJu0Yx8YOR6UELqVFKkmzBwGvK8M5UmMpnjGwWLmhFgZgacn+Cy3bAb
	GYUDpp7OV6zVTewia7Ix1yHX2C27fRI4Nn4YxUuoIstnTGuxhDgK7UC+9BZCWos=
X-Google-Smtp-Source: AGHT+IGfKcUu7NqZz/2YIoRFXDETVLn01TPyAgMyhSeV+4aYuxcyraE1hyGbvp3rovCi+c5AXMIfcw==
X-Received: by 2002:a6b:6302:0:b0:7f9:3fd9:cbb with SMTP id ca18e2360f4ac-8171022db8fmr142626739f.1.1721231875485;
        Wed, 17 Jul 2024 08:57:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c210c2db85sm766984173.38.2024.07.17.08.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 08:57:54 -0700 (PDT)
Message-ID: <67db8d9c-c7a6-46ba-996f-5fc06888fd05@linuxfoundation.org>
Date: Wed, 17 Jul 2024 09:57:53 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/66] 4.19.318-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240716152738.161055634@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240716152738.161055634@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 09:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.318 release.
> There are 66 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.318-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

