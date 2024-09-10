Return-Path: <stable+bounces-75762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 377AC9744C4
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 23:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04843288682
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 21:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E161AB530;
	Tue, 10 Sep 2024 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QI9mEU86"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50161AB50F
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726003587; cv=none; b=uQWiiwJ599MDPqM6IrB6QItrudCTxKiKqDVCTUAOJWQae1QFSymt09qevbsRQajVhrJAtU+WrgR99tftub0Ptogcl9xV+5V/ulYqswJ55yuIoxXWtnpykvXcCdjxLJv9v8kbadhOKuMbfrVmrAPboWXB2Ub8WBdOLfRu65Guotc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726003587; c=relaxed/simple;
	bh=+l5e/LnCdd8IAh9budhJNcJYEEVRB02TloD3Js8eMos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kc8hcPqxMKv3/lyds1wfhqCsSrmVjLI7ctJl+gAuoUD1qkQW6XsKbLoTC9n6TVtCajo0Q10N7m8t4x5qYpdmQDrwqpsJ06QMNPsGjTuOAoeMHtGZMBjsM/2oRqI2Z5wMqgL8Y7ECLQL+3LJNQT0umi0StEu6+UTGSl2Bx1Rbhjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QI9mEU86; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82ceab75c05so131655639f.0
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 14:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726003585; x=1726608385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IrdxYdiIzLneY1PQkxD+9Iq8WHqwfU8Dic2mnpV1UZs=;
        b=QI9mEU86JsAf+su16Lr+xMPDeRwIqDlGxM7TE6DtDEcdAf1QMjon16MrqiM8oTPK8O
         D6onP2nxrZhtlbqaBUumy77uAsQ77W44hGqEBi5NBiq8Ye4rbRC5acq//r7vJ25yVxVN
         B4jYlPUDIfIo9emHkVMK1F3E5DY7ymfpmmZlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726003585; x=1726608385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IrdxYdiIzLneY1PQkxD+9Iq8WHqwfU8Dic2mnpV1UZs=;
        b=Wg9iPu9DafzLtLJLyndVbDuJgXXnXEfYhw/voFrzMbZObODTVtO+NdDJo0nmj4Sboe
         SjwUifqqA2G7pWVzt60No5yUuXxn3kUw1g0rLt7+Zv1HcjvnUI/SfSyaPHyUqG2REOyI
         qxIHy5mee5LxWuVzr83K8XZBmwtT0uHiGWmNCUWG0qswIxmtwMp+DkxrkU0UNaGkauCR
         unJgByAx+26jbGbbz9yXfReAra10Rtv94VBC5m0QZaGf1vZ66K8zLnMv5AyRCkV23nIq
         UXTwgh68BQwFjWBKGXBaaM0wzegLn6Bj+si0ZEk/lFNOuPe2FEUXq1N5ivVQcKDSXEjN
         0ytw==
X-Forwarded-Encrypted: i=1; AJvYcCW0eZlcVircFXPkru9S93UrXtvHoMtK6vEoUWNXSaP+xqqNrlcAX/OtfP6R/7iIhhlyMI8JK2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFEzr4XcRJ5MCCrjh/S2cX+AuGijYcrZAcF2RuWhRX48GIgYIw
	j4gCmoPtcGVpSzfXCNek+cf8PM83UIk/AL+l4AUbZZh9dhJyD/jvx+mf3iosYAk=
X-Google-Smtp-Source: AGHT+IFGQhVronEsKZ13uyaupXrkLsl0LHSmfNr4fnx1sTDUtu261DIXqt77yBBw8Aew2oRg2s871g==
X-Received: by 2002:a05:6602:13d2:b0:803:cc64:e0bf with SMTP id ca18e2360f4ac-82a96172f24mr2867103439f.2.1726003584725;
        Tue, 10 Sep 2024 14:26:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d09462f370sm1824691173.119.2024.09.10.14.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 14:26:24 -0700 (PDT)
Message-ID: <39d69408-b8aa-4829-b85d-ecae4fa8f97e@linuxfoundation.org>
Date: Tue, 10 Sep 2024 15:26:23 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/186] 5.10.226-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240910092554.645718780@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240910092554.645718780@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 03:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.226 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.226-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

> 
> Guillaume Stols <gstols@baylibre.com>
>      iio: adc: ad7606: remove frstdata check for serial mode
> 


Kernel: arch/x86/boot/bzImage is ready  (#210)
ERROR: modpost: module ad7606_par uses symbol ad7606_reset from namespace IIO_AD7606, but does not import it.
make[1]: *** [scripts/Makefile.modpost:123: modules-only.symvers] Error 1
make[1]: *** Deleting file 'modules-only.symvers'
make: *** [Makefile:1759: modules] Error 2

Same problem. I am building with this commit now and I will
update you what happens.

thanks,
-- Shuah

