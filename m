Return-Path: <stable+bounces-131867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38741A8191E
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 01:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13EDF4A5901
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 23:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7436245021;
	Tue,  8 Apr 2025 23:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPdKMcNX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE101A7262;
	Tue,  8 Apr 2025 23:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744153543; cv=none; b=naLK4uiCZvQLuTcrNJDc1dVy7cm+JY2C4WW5GUEc8eQ0JK5YSpPyZwBcqSv0O+vndxujvYuiWJX1PN+TakpovCbkRoS92tdtz1vXPClmbboKb9sYX5/UhjzgHESsbUJNI/+yl/0tdEzmc3MuQMz8PCRJ7qEBN8z17j2y925lKnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744153543; c=relaxed/simple;
	bh=LVaRNYh6WMVe5PCaDela1SyPvvoOx30n+RRZDnS3rNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWLjS9JDKNrpm14Dz4+XIIEeirt95cuo3Qlkubi1tFSP1C+s8XL/Bxlvqariohoyb2AmD+G9VnutRExrpb8g2DwpVdY38+ve+0Wi0Th84X+FOfB+pZdpZY5IiTHCy+2RmtMVzXKp4KA20jOenteXVWtbCC40ZmhzvDxoRaqfaFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPdKMcNX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22548a28d0cso87289325ad.3;
        Tue, 08 Apr 2025 16:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744153540; x=1744758340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KgDaWD7pBfobOcPiH9eCDq3XorE+3xfuNlgtuPHnMwo=;
        b=SPdKMcNX0S0wJZ4TK7q339Iks/xJq+YXRvAHNVVIFd7hricZDZJk/1FXlnfnxdGPR+
         hpYQZy98l5JhztPhXlSsrevoSB9kDVSRn8SY/L6BpX3PxpTqwL7YWeYLr7mXLD97s7Hz
         ZV5/xT2HehG0IdFpLThTUz1jdrvWnqW+92S67xfToNOKt4DxrYFNElM0meb9nzfRPZml
         fx85nLZyqtDLimzNbyiPKquFGBTxhK1w+gq/5hLIAVoc+LUx+GgVXDSMYTIw06/eSKmV
         jJHNPb5Bke+51AYtK+Q0r963RvCg6Rq7cUSxD1QxJQdLkE0rzJVnORh3ql0+qUH9Ip1i
         p1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744153540; x=1744758340;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgDaWD7pBfobOcPiH9eCDq3XorE+3xfuNlgtuPHnMwo=;
        b=ip/0D4KC3mDT3qdV0QQPqd8cocqKY+Rm1VxIjAoB7lGlZDMPM+ZtQ2mtHxnYfiOcaW
         DftrGHgbYyDa24TwFbUvh01aoL1WfYVGIVZlh7bLvZMaqCiajk45+UcyxC+aMhNW1nBB
         PtC97VthNjbVdysPqhYzdw6rEdvNwD5LUQugkqaJzurZITBdCmh8YyCoRbJhBJPGBHwO
         jy3bISVv4al27dK5yj28l++v38ojMC3l0lhLudvAgpwt4o4+xVJo7TL2lXMMSEemoFoA
         YRSUg0PKKMhYYhPvz/m4MYCjmLnNlhncowbWYRE97f+UNNq2v/V/m6mrT+DmXdC7cQG1
         KGTw==
X-Forwarded-Encrypted: i=1; AJvYcCUGSNpENrnjGRgWBTTT+tc9Lk6Lte6sCh+waBg90QTNsPZAFCzwAuMLg7x1zzoXGlTMnyzFPfu8@vger.kernel.org, AJvYcCXNyyQ73ZDDy2a7MNn/QD2Tx+eJllw7/Z+YIMZlTnaXzV0olMEE7/Y/hXbj73JcrmeY8pC05NxSqiqgNjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP4oJKclHGQ6YaoCE78RkMbQbNdLUCNq7eHpJ4JODTXz6r2Eef
	3Qi4umHs+PS+JyNL0LC3Nrp+bdrBrkZo1FtWKABgofkVV6EamLy5
X-Gm-Gg: ASbGnctILUEQ8ed1xpCloC1GNorw3D7yyJd1wIPU7qF4R5nR0pkqpME7s5zOLdW6DJD
	z7bFdbXo0dJmLSRba6Q2DbDqRtvma71JI74NAsMV5ocdDs5s3z/aDgR6+fXPTo70V87IxzuoLYG
	vI5VWY7u8mSU5/oRp21ZyRpOAwkZxyWxP25NVp8ozsqJTQ2mOal670vYOHJ2y1fwwRH3D7xfGRA
	gciyiS9Z/674A/p7HlUvGUCLbxD+YcPpBeW7WAMDds4QCFgckbUuToUVKCXSRPPpz8qEjiVTFpP
	R+FAuQIIJOe6HrumeblFF/1sR9OIboa3lK8sKH2wzt3W8/zLSnhJMoPPuWxqEbIb9sCUxUDi
X-Google-Smtp-Source: AGHT+IF+qqPKnrQM93G0gkP/m6WyZu8TD1szV6n/zNvLwqFHhzCeyrLFxiZpJKo+0FnB7aiPGghkkQ==
X-Received: by 2002:a17:902:fc85:b0:224:f12:3734 with SMTP id d9443c01a7336-22ac29b52bamr14842315ad.30.1744153540347;
        Tue, 08 Apr 2025 16:05:40 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865e491sm106573935ad.153.2025.04.08.16.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 16:05:39 -0700 (PDT)
Message-ID: <929581ef-cc54-4619-8f4d-0e0f3369a38c@gmail.com>
Date: Tue, 8 Apr 2025 16:05:38 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/728] 6.14.2-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250408195232.204375459@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250408195232.204375459@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/25 12:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.2 release.
> There are 728 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Apr 2025 19:51:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.2-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build with:

util/hist.c: In function '__hists__add_entry':
util/hist.c:745:37: error: 'struct addr_location' has no member named 
'parallelism'
   745 |                 .parallelism    = al->parallelism,
       |                                     ^~
make[6]: *** 
[/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/build/Makefile.build:86: 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/util/hist.o] 
Error 1

-- 
Florian

