Return-Path: <stable+bounces-37915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D4989E6D9
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 02:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59161C210FF
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 00:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B7264A;
	Wed, 10 Apr 2024 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ceQgYR5F"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A13C391
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709003; cv=none; b=Jnn4xtrrLUJEXO4QbtRI+G+MO47H++wdB38UEVc9ErM7r/aQhxsor6tJsrUkHQ3BM72xNb1itWV63BsUK2M18UwNrQNvrUJsuiguLbsqn5dHXphHFw61HdOJedDY6kshXq+qo+8rkxrvl+wjtp2rn/HbS3ueXT8HX6ljveU4mK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709003; c=relaxed/simple;
	bh=Aohoo5m436ATY06E6fE2TkDvoVmQmitw2MESEWpP18s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpSjTk2sPmF0XdsBw1/GVFkROBsOWbjz18+J4dl5SV3+l13/hz7xq+KkXPEtFq0xYoCpSd5EK1QcX5FV7IFFuOH7gUBH96vMm1ZfGLIvMKuOrzAfN/nkC4Wt+qYakIFp/B2oqVTAoLPf0U8Anvyr3VG7dkHuOCPkvoLCVrMLcuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ceQgYR5F; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so138093439f.1
        for <stable@vger.kernel.org>; Tue, 09 Apr 2024 17:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712709000; x=1713313800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E0mPzJYDDs9NjRkVwk8PAW+ML3/n48vFMOCW1SPs8DY=;
        b=ceQgYR5FETQPBankUtRw22T7xG8JP64BXw2NpD1bhAyweV1wg2R6kdKTa7AkI+fRi3
         hLCreG+brzvnKv8fnRawmjrYGkcOYVF9ksTEDyMR4MGGy62XaNSIyQQN3anu4eLr/PD/
         g5D9cnYFTAfi7mo3tsXOjs08SF9BNeXgv0R8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712709000; x=1713313800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0mPzJYDDs9NjRkVwk8PAW+ML3/n48vFMOCW1SPs8DY=;
        b=L4RWXMz57sqY2kzWuWDkDhSYt2YN8534uX10htaQUBh1X/ux79YB0njh9xgfj4cE1d
         kg77LzLts6VknIgyi0ZTJq7YYW8wLknk0yZveW7EpffiBujwMw28XkSNFwF/WpzCZHdp
         erdc+dIatOy35+dkzNIvyBkXHcSDuM0RosY4FKcQMvKcSY5bgecXMYg5bd+zrW3Izf5l
         pPwVqvsz4W8ly42xLbhJio+zzOUmbOsQowAJ+EovbjrR+jV28Qbum0REdL1sTEZqJ4aH
         PYFiYEmIJ16zEgIfBpGXPCxsBVXGsGeMLPpIOvcpDDLGVVwOb7tP3zIxmI30zddXfkNd
         YoRA==
X-Forwarded-Encrypted: i=1; AJvYcCUX+vreQFb28P15au3t+lwpvQ+xagRSp1fClcnaG5RwzRj7cp5EwFLVgtzKleLAswik/R3UdGVsuXPsiJglv6Kl4eS0Qdr/
X-Gm-Message-State: AOJu0YwbtRiwBa9RvAdvwUafGPl9+k6CsgiJFEuRMVrX9vhrSHV6kpSI
	PDzhCpFgofMN75Cy2m/K7SNclkYajufguENdL6fL2znzzb4wfwoJFTuRxK7ZWHU=
X-Google-Smtp-Source: AGHT+IGyUInGdc0DiRUYiPJpwVzrArmK5Ss4VpPR1wgMi7o4wISsmAZTzTzpqZ+Stn80wxBkyrIwvQ==
X-Received: by 2002:a05:6602:120b:b0:7d0:c0e7:b577 with SMTP id y11-20020a056602120b00b007d0c0e7b577mr1407387iot.2.1712709000699;
        Tue, 09 Apr 2024 17:30:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id k2-20020a056638140200b0047d68340fd9sm3564684jad.32.2024.04.09.17.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 17:30:00 -0700 (PDT)
Message-ID: <2dd6255c-ae7f-48d9-bf7e-ffeec074cab1@linuxfoundation.org>
Date: Tue, 9 Apr 2024 18:29:58 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/138] 6.1.85-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240408125256.218368873@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 06:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.85 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.85-rc1.gz
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

