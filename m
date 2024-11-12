Return-Path: <stable+bounces-92858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B49869C658F
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 00:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 436CAB2CC49
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 23:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38F521A710;
	Tue, 12 Nov 2024 23:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bDIRETe7"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE7E21A4BA
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 23:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453472; cv=none; b=jJD9Rqt223BD1cH1afyStRleWGD2F/59uMHweBeuxKya7yZmfHn6hV7oaGdCAnXNRWtj0WLOUYvFfkfWzCPctqSHe0WVgkJP3D4Tf+Lx9Opu+0Bdzf7P/XoNlxapqvXzF9pjMsIm945b1ta+PHJ5KgHIYCNXqPC/yilaQi/oCGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453472; c=relaxed/simple;
	bh=VwyYqkS3N/QjnW0vZksldckPPxfHxG3zUF+szflZ8ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RH+wWfz3amBT1Ffa+NnxTJVZsW15vLm0A7iERVs/NtrFoGNcj37f8XB/BjYPnIryhQg6yKmI3R58ZBUUdoXTBg32TU2JIhmIOcEtwn9htdkud9KH4ll2mggk4VP2FeL0ZM4siGrjGHdFRzh+p8jjSdKCqYuVqBPEvTDTF0Bg/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bDIRETe7; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-83aad8586d3so254594339f.1
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 15:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731453470; x=1732058270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jg+8FCqQQeTI+kkgg2xiv/CC5PJnPxPy/Rfo2Miy/VA=;
        b=bDIRETe7OOB36G0z2kxzzyMvAmY6tfHGcYZ2AmuiOpTq1M1yyQSAB7DXMT3xHNR1s9
         bjchUFUsz76o7Gqh7Eq1npGfe31zIBP0mEEbugnvtlxpZyzseGTqw2yxxZb/+odDgY6C
         JTN88qpdp7pw0YA/cAMyUTaFFQmAnsSRSx+28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731453470; x=1732058270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jg+8FCqQQeTI+kkgg2xiv/CC5PJnPxPy/Rfo2Miy/VA=;
        b=ZGeNfflEnouRD1p5arEClqh3PRLAHz1gZ+95oq55Ud1EjGUXszfBGyL+0hGL18oG3a
         tsDvf4WFsqbgw5JMNOrXGhG6W8cxIiYQ+uLkKNCpExXo+8ClFWkkQZCydrMAbBnhTbw/
         YnHdCs3JUbdNtS4ibDnO2loQD4t+ryuo1L0j40v8kjwEDPvSGW1z0FI1VpzQ7lvpXgQI
         FlXikhC1t0oB0Ucj+ChTIELZTN/6uIFq748yIalE6rhiRsE1gs9Is916gLmY5EzleHq+
         s9SfD8m6dCTqEDMQ6G3NFdfgceoXvCNMqmmcqKYTUTUpzdm3lohl6U/YVXTqYQUTmSvS
         h7zA==
X-Forwarded-Encrypted: i=1; AJvYcCW+OqrsC36QMJM7MaZ+T8lMuqI/kGq2aHX7fyXb3agtJkR8sNLp8wxdSWJyktLGsZDW9nRQHEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLq+M2kENl80RnpOS7U6xDmuvl/zqH8QM3bAGzdhU1kCTwADEA
	vC6KDt9vf013V4ljUN5jViQmJR2cnPueyK5IYRrU4luJ/UDMpLpOt73ge5+5JrA=
X-Google-Smtp-Source: AGHT+IGDDkFwwg2/zttut58lVKiIkiYza/7Gp8YG5837TiDyVtX80hpZSUMi5PN+Sb0hb3v5jWEsNw==
X-Received: by 2002:a05:6602:3fce:b0:82d:13ce:2956 with SMTP id ca18e2360f4ac-83e0335471emr2056094139f.10.1731453469958;
        Tue, 12 Nov 2024 15:17:49 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83e132561c9sm224942239f.16.2024.11.12.15.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 15:17:49 -0800 (PST)
Message-ID: <45a9e5ff-ca1f-47fb-96d1-6200f26b0ac5@linuxfoundation.org>
Date: Tue, 12 Nov 2024 16:17:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/98] 6.1.117-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241112101844.263449965@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241112101844.263449965@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/24 03:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.117 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Nov 2024 10:18:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.117-rc1.gz
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

