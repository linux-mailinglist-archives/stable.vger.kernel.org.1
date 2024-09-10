Return-Path: <stable+bounces-75771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09054974645
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 01:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355A61C2546D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 23:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920421AC439;
	Tue, 10 Sep 2024 23:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TinxxfrM"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D951ABEA7
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 23:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726009997; cv=none; b=UcJ2QpcuAobzUsNqcQbbrX+njjwBwlfbF10o1W4OVcITOGgeIAJEdriwkUKmBjueFPS6cnxfdahKnYZFpBIF9r8G7xhrvwk5lZa3dZS2/yg0/QxIBs5dpipF+90+FT+pxuiX+8rZfjLswPPwYWJA8nJaG6fz6ci1d0+P9lYqIxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726009997; c=relaxed/simple;
	bh=skkOgOVrk2rz6JTfzyf0B9szj/KCPd4ttv8afMLEVBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nV/HvzG91VjK4cZIEInbE/6ukN6j2V+ChrbRju7t01rsxqKnCdrLx83kCc1KGaWFnxNVCLCkcRaMqWMYD6cHmtAczcS/9E6pW7IBZDY7Qe89pMVwdi+Hu+SoE/X6cIziU0QKhNf9O8uB/pan6JbdrW5byYNcaRWnQEadwASOtdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TinxxfrM; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39f37a5a091so21629345ab.1
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 16:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726009994; x=1726614794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NB2gEKUnRkYZypGTHLojoU4Xifb8ehPDDVLdPZ1Wimc=;
        b=TinxxfrMLWZRjaYgK0Fer54VAxyRzxNaZKPHX4H+m0v2OQusuvM1ByN4mTbcVWTntV
         MxPZlx41U3i3atPTg/xpc5aYQXMdiJgJWV83TGZrCvWnXxn4WgAqYw1bo32KKcciBuqd
         4mTRFUE7UyQSnX7m+Cx5Bm6FI4ymDZYL7Yayo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726009994; x=1726614794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NB2gEKUnRkYZypGTHLojoU4Xifb8ehPDDVLdPZ1Wimc=;
        b=XNw/ZsKW5R59pSReRlV5Rc23TfaEcBHQsQ0siPAItPMJxXJ2Q97f2CjmD2q1OpFuZh
         k/SpYMMw5MyG1DIEUXyQ84+p1jbI4hUYME+PZp+ZFIJmWNnnyB0tx+py69POAgHTxCg5
         VGnUcdm08Qyx3O06sgRAEwjdnvahGYU8elaYm+p1Kpd/4jQc8oCkq88g2F7sJbTmOPSi
         MRQeSGcE+jdbKfJkB4trNlKC9cuGvhLVLbFaXRrl0UKxMNDcMVrx+B25E/BR7J+7iuuQ
         QVt8lTTxbDFFCbg/LiDDrERXcMYNccwpYSyc9ri49OSsjpKapqHQIP9ztZNQToEdq+X5
         beYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTAMBXk++DH0r0ppqpmHBVIio9qOmDCCm7Ril93TXTR+8J9mB5wkW/1awVFs0bx0s+bqJ2m5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjSCgAmvniukJcnD28HgEXpyoipc7UjrCcmw/frYOg3olZTPk/
	bezvY2cc9CdvcrbkVkFwJ0CXR+y4g30psoA4f7+i4p9WjpiLx1LfqJP91t+YUKc=
X-Google-Smtp-Source: AGHT+IEeEWIUJMqZZjwDZ2RP39n9JJ9BSDpALYkvcGOf6VmhkOy+w1lJvYj/0k3BEF9J+t5LDNTr7g==
X-Received: by 2002:a05:6e02:1fcb:b0:3a0:4c4e:2e53 with SMTP id e9e14a558f8ab-3a04f072f13mr158108345ab.5.1726009993733;
        Tue, 10 Sep 2024 16:13:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d09451da2csm1860392173.27.2024.09.10.16.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 16:13:13 -0700 (PDT)
Message-ID: <2c086ba4-c7bd-47e3-bf12-d3c99a5edcfa@linuxfoundation.org>
Date: Tue, 10 Sep 2024 17:13:12 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/375] 6.10.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 03:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.10 release.
> There are 375 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.10-rc1.gz
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

