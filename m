Return-Path: <stable+bounces-139479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C871AA7363
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 15:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56AF169547
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 13:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CDFDDAB;
	Fri,  2 May 2025 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThqIa25W"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D43254AEE;
	Fri,  2 May 2025 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746192120; cv=none; b=ap9HdLmS26P5koFmoxnQK8XQIaZVtQxSKIZGCGK2EiI7TOB+hqMWATMgkkLYd+v3GxyErBcSW7Ep7mo0bb+JrQHy5egvYlhX4IP3QhsZueweE/iAwJT1RN3hBNxKPBrA8Q66Huhac7+moL6vZMrNDBe+E0xy28WxhRg4z648lv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746192120; c=relaxed/simple;
	bh=wnUujzmKG4Pa/20bmQrN2uMRlZovHcJk4wNC5IxAQDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Asfikfg+S5NNH8MHi2yR7+j+u00iN50ofzKuNBnHPbAbEgj01FXynZEaLqDpf84K/PnbRbk2fKlN9selRnu4PkoRd4r7kkOrTi38k9dlg93EROaUyFycUs3JQa134BZg8M8eQz788QsL1gL7f2ZDc7NW/K+KdxtEnYCdi4TUYRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThqIa25W; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22c3407a87aso30022825ad.3;
        Fri, 02 May 2025 06:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746192119; x=1746796919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KlOs+JdgczwnqRqh26B7JXmHNWrTs0TwsZfXRpF6SjE=;
        b=ThqIa25WZ2O9spN+scYzfdgAdu2khswhDhBOBfuJBRbuEGEgsmskZdliy7ZNr/WAyF
         /NVeK1ogN9XjEbg1UVL08b4VU/s4OrrtQVqFNvtz5kf/o8218NeRgXkVcC91iLP4I/VV
         VLZOh1oNT/O66k0slcki4xerbU01SqF4XedqwexXRDyHLjhV6haxER5qMeX+3vA2yUEX
         9PtVlG1gJmv6cinsr4mZtkfgpYw+H1eskD2gqRwVdLpKk0L0ZcwNfwdZS0Tb6hoxwqjI
         oySToQnbYK6cFjcPK1t5lCofllUbqlLQgK19XJwCYmVDmoxfL7g/esQoq1MB253namXC
         eCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746192119; x=1746796919;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlOs+JdgczwnqRqh26B7JXmHNWrTs0TwsZfXRpF6SjE=;
        b=p8Zy7dwFKPT8Vrl4Sj9QR6j5AM+JrqAgwpBqV6W7zMMvxjC1HeGbXzqqU1zgX2yXOE
         m3/X1nwl+Z6URBCf0pG24asICaYbJE3mR2BXQoB8oqlWCmL4bCugHJFqSwrNK3P4euf7
         ZsyC4hXigUl3YxMd2OoLt7r1egxKyzbsAe5vA1F/+AXyfgpd/4byaucBCBwYnrw1P3sk
         wHPUBYgVhsCUNcxQY+2UVzWBbaFQuSkH7tgkSgiEiEa5eSeCeUyodDpOUTNbJs9ty4Ve
         B/ageMDpeGf+Bm2uMY1VNMvFEMbOaKQVOa9Pfmc2UerT4BQCdHrTKb508ri0BfnSTeU0
         dMlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVapwScYTgN3i+fdfIIPcXNSINE4n05mlA37rDRtutcdkXiGRorAskXhrIqv4wSv6vGdg4sF5jK@vger.kernel.org, AJvYcCXiDh+HWAnUU7EFG7j9SyhhoUTsgj5VIX6GOn+rvWaZpAFNEpuR1v6nBZekP8lfnfdLRdVeKJ0yn9LS5pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyJqP9d4k7PguuTEZkMnYIb+ONwzE91NEhIR7rKn+AtJqu5Di2
	AyCzhPHZOuIoq4lGrsjIlrxVubvjPsrBrk54IklZljkJfyyzUQxt
X-Gm-Gg: ASbGncsOVLek6zPdm4KZ+5clq0Xm3yUij4pY+tWnTdI0+i60WGzEcy1Gl+LQAqL3mz4
	JsBv6LJMkgXiGUfYtWZTNDDMtg5UXlacg6CsDlihpoMsyQ7k5Zt1vUvbZWEqAouxwx3ok7G4VfR
	EDfeK+Rs02Mpyn/5aAO/U2tUzgX9otGW03xbd2RoFXlitjShTKbEJKOaZg0E6aVS/lJQ+sNt3uL
	a531EGzc/KDsBCTOJYdrK1/Z03nx6WpothVc92F/FDsSTBW7IQjLlu0DbBZN4FGg0EVjTqj8hK2
	ARmnYt6/37URts9e65uzHhj5YG8zRG35B0n4CLYLWbcHXtgl/5IJumXYHHs/SLqlaR0=
X-Google-Smtp-Source: AGHT+IFQaU2Ld4AF+aXA4jhHHsJli7dq7Rb/NWePPLliWMF5FtCiT7mNLPcemvCWWe2r8PJl12T90Q==
X-Received: by 2002:a17:902:f551:b0:223:6254:b4ba with SMTP id d9443c01a7336-22e102cd0femr41105765ad.13.1746192118660;
        Fri, 02 May 2025 06:21:58 -0700 (PDT)
Received: from [192.168.0.24] (home.mimichou.net. [82.67.5.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e152320c5sm6455825ad.245.2025.05.02.06.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 06:21:58 -0700 (PDT)
Message-ID: <c1de7468-9225-4cdd-a281-a95bcbd365c8@gmail.com>
Date: Fri, 2 May 2025 15:21:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/280] 6.12.26-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250429161115.008747050@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/29/2025 6:39 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.26 release.
> There are 280 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.26-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


