Return-Path: <stable+bounces-139467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 470CDAA718C
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 14:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257083B6281
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 12:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C762550CA;
	Fri,  2 May 2025 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnYS7sBx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E324C664;
	Fri,  2 May 2025 12:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188326; cv=none; b=KtSXBrij+dBo/M2rYQEG+eRVWi3TIKDfqiJ4C4xouAUlmCQjzBfIme1Zv9OMGT0pewtYLnVCp5H7ZssC123p5/ADgrIMYrQbXFswWz/8c/NJeagA6wFnUJIqgCPd2JvvaczUq6/KIFGEhh2j9nLho52HXdHT61VXMJlk9W80BBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188326; c=relaxed/simple;
	bh=vzeqzdihZfJ29dHxGOfCFHdhn0c1Frm1BG7wrEBZI5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEMxWuiVeCQVSEOEBCww0RGIsrl/3KGUHqmV2fX6R+6lyIH2N2Zm1EbLcHFg7PFlSAWVQT1qQf8q0RqSwgFNkszYbHVX4oNq0quveIE7zmcrSHoJc8kQju1W0o7HhdzQVIXEjWiURCYiGQ81wak9hXmwYkEtDh+5IfaKg71G/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnYS7sBx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2240b4de12bso31406745ad.2;
        Fri, 02 May 2025 05:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746188324; x=1746793124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rkSTa7ThJt+JWw9VzO8UzWG/hQR4MSa+GAV/GgpDZn0=;
        b=XnYS7sBxbXPI5kmvApHjw17vgzMwsQpo87D2qVCMTm4jWiHu2p6SEbFPLpJn09+yzj
         Z6VR3BLczj0bnIdRgYZSd3b3rPw3PDQ4ZiOuV8TK45MXQnHEXy9rcOUofrpjBh1dTP9w
         uX4bkMjeDgIbkuAlQW3XqXau89yZ6BUADSoZqW2THaqt7ffXjXI6qGFre9e+hGWLcKuH
         9AC9A7voL0J2Sfamqto5PGsrRRYQVeT0LOeUSfUjc8V7M0/ZSma7Fh4wY3o2Nck4HWLI
         QYXINpukFgeLCxm6ie7doCWkI/0TwSM3Fxdi9jop+JKiDYLes+k7K9Mo1IP8ZSGFDF13
         M73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746188324; x=1746793124;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkSTa7ThJt+JWw9VzO8UzWG/hQR4MSa+GAV/GgpDZn0=;
        b=HhxTcN//lVSVeqGq3D05zBqES3ZZHctH10LUSIQaB6ydiCEPxOFdrHaeNreTieXb/B
         RWreihu9r3RgyNJ+1ZH34NxhIBR84Bq4QtLRxqrjusP91yFXCaat1A+zkWKW4FNp6e/8
         +Y7Q/XOvJ6EtHI5ecv+2d8HJ55roLLgcvQ9bq6XqW4DEXz5dRXwICbDTTAtSFmShXoWU
         fQGrZR6Z46P/aLpwNQA1yXicLag1hlZyHSyCFazdHGBjo4Vcv8EQt7YyhU+T9pL3Dh58
         P62SJyw1l28MZiQL8PuQwUzl9/3FqLiGpBTmFr2LryJEFtkOMNTGkpx+6o58A2R9245M
         u/yA==
X-Forwarded-Encrypted: i=1; AJvYcCU+d+QwmglpUrxzQfQpx72gE/E3BmoayMzr5IFs8dvO0bag1VSV9K8Xu5r7Rl88eYWGKD4aGVyfzDhA1x4=@vger.kernel.org, AJvYcCWcgnTGZA/hZ4UdPoUIPjgWaqt3ellrqSy1UBfIRhh6PoM1kwuPZIzPq2mbadkgE/oMHe0lhvha@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/UbLuYLKXIcpE650Dhi9Eal1EVKnas6aN2roajfuIVOmKKSBa
	9YLm70Ga2fRzWA0GKY/dUpVeOTrn7z78DBEicEQYsn1nrSpU+v16
X-Gm-Gg: ASbGncsKaI36y1PmlytgeEsT35QYNAWnKyb9mnfQMafWFGtsciy1LOfdNYUFM3u0JRg
	pWRT3+It8r7AeB9NtxH4aPa/6fjBBuuIh3FLiW4ecpQfSJeOaZUBFz6giG2r+AnfnTKW4EEPpED
	NI1gv5I3OPk+10ckmoz5jpNgq2tf/xE2Wa1SkP4sFJ6OYkf2BaC70VcjEpyMVSTT0Ytg4dyC1VO
	hGo+zPjWpELJIaOvrCM667P4TbRw7wznjuFGA+fi0rl6dln7E2wSycNX3IMXeALbBx26daqZjdc
	RPwL/Xeb+eZwSzvhL4XJu1Ne4hzCc1q3lRowkE+8bVviyptH1L8fWZMbri8MA6T3FpY=
X-Google-Smtp-Source: AGHT+IGvf5rL1bhZcVoNWjVw6BzYAOWv9eWKSRLxi6IAz69NjllJrCdxJNXLmBfkaGV1iXK9XzxMzg==
X-Received: by 2002:a17:902:c40b:b0:224:1ce1:a3f4 with SMTP id d9443c01a7336-22e102ae033mr40185425ad.1.1746188324106;
        Fri, 02 May 2025 05:18:44 -0700 (PDT)
Received: from [192.168.0.24] (home.mimichou.net. [82.67.5.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e150eb007sm5704145ad.25.2025.05.02.05.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 05:18:43 -0700 (PDT)
Message-ID: <49ec5aeb-16a5-49df-8f90-3dd91918f645@gmail.com>
Date: Fri, 2 May 2025 14:18:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/286] 5.10.237-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250429161107.848008295@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/29/2025 6:38 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.237 release.
> There are 286 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.237-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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


