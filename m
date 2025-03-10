Return-Path: <stable+bounces-123123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0DEA5A432
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 20:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AEBD7A6F76
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD62D1DE2C7;
	Mon, 10 Mar 2025 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZV9sdIX"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5071DE2B7;
	Mon, 10 Mar 2025 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636690; cv=none; b=QDmMBRkiuiQeOTmtr8OHpZoMtljIaN+SgjqXPfPO8lNPMaTRUsqLHu0Bdnrx0FANP/53N4U6jWyHRqPT34ys4HsIEt3E8PopDlnB1g9DjtmMkNDH3eQEX9xau/WVzoGYdNKdvWyaU0AdsNBOTswjmqpmLmpFlCibGCSkAOghQ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636690; c=relaxed/simple;
	bh=Uwt2HcHeYuXl07ByeuBJJmznqQ5B2Mc8QdjkAV/iJpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPjmMr9MsN7qY0dd3g1QTVu9V8lhBu7Ge3k/ua+KagTPzqwZATp5qX5j3WJJbQE89fS9Qc2cdaZymqh1pquWRZCzIbmdYeC2OTX2aVHyay93p9FgC63NPcaGajr0IpZAO62vf1XMiexoKzbMkbzVCo/Y0Vgu8X4X/m98SE0CVi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZV9sdIX; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2c12b7af278so2761452fac.0;
        Mon, 10 Mar 2025 12:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741636688; x=1742241488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F8q7Q57w3E8EmZnIar1nUonYbaq0MfF2pBQagYJWkKs=;
        b=CZV9sdIXh1w5snb8iiCIQZqcDzOY2hfFseHKNZqRDSDPfvYtIhepqMikQutIAlgnog
         B1/0wDIi0J8uE7rRv/OF1tVgMGzu6T88JLwv9QMzo5FX5VbykHTDlLbYsL/LG4r4p6f4
         gRNWA10qC3yiBspaPJ0EmMoWpDWSaUwSvfskelf7f6GvLmh/NdRFqT8gR2K3itpzcOi+
         y9vANe/fWBDBTGy5oyy1PAc2spU33uMEE4V7m2FiC12S6EEpLh8LDCxqyLzqcNeZKfgi
         I9ITMtHpG4NOOWtvphk+f+Prwr2Oan2HbKL2mH0aoT7thDL5orGdVaVUa5cY8adQdqJw
         HCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741636688; x=1742241488;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8q7Q57w3E8EmZnIar1nUonYbaq0MfF2pBQagYJWkKs=;
        b=MSZla8k40kuUpxrH9K4cGSPvlnCgSoKKCIC/H8lr6ksIWAxGtQoEzDi4nngwGqNu/u
         dj6y8rfK3pvlGrvn1WWUNRW2hqRD2dSl0xbSZS8h0fkbbqnzFoXsql+737cK0HAMZ7Mw
         CyQoZ1BUK98iNqfkfz/063SrIEviUc/Y6ZTy55ON6dCblvo1Wsyr0vR7YdiZivJJNGTS
         Nt2NNC8DaCschlX7AX26AhmH0ilR0za+Afpqhuz3kDB/6pcqkPtWmeBioVmYytgYy2ge
         X29kgMbFpKYOH3ZVPx+1dryJ/OTP80eK8mxow3c8AWxNB7jett8MNXAK/aQjP1GNblwC
         o+4g==
X-Forwarded-Encrypted: i=1; AJvYcCUly5K8orE0jbYL27D3+l3Hb2uKzGDa6Sv6KSrSM5SsCvmGCJxh4cCKMeZuwbJQ9frvC9oxWSq7@vger.kernel.org, AJvYcCW9INg5QvVJ/wMYFyl/5djeW1LOE06AN+wbFNDrxOQNoF9g0ejJtY5O+ejqLnUhaWSmg8GA1yphhLLN424=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/vPkPC8Wh0G0ksrc/eXGiOf1N1nz/MBkLe8u2GFn4bJq3wWhY
	9Se1z2lvKdrUKlVXQGK/nU/x+7qqIlApHfZpxOrTP/9oARrjstRB
X-Gm-Gg: ASbGncvqBF2GmfTLbZqKSe4oXZndf/hrA4Z0Fys51hC69Gr0DkSv5ecyHYGbh5Qrxyn
	psGdT7cnAZDFEP+VIqiKy2p+ETjkS4NORksA3oy3Ry+xWoCVFSIgAmoKo+nSZX87lTzqcTrX10U
	iabl7nk4SRjxNtm7A0X1d1BhffFuN35YR/edmI8pkyDRYaK1+swBcz0JcgGsHVSRphyvFtAKl2D
	yvwW4K86bEtsVIwahkIhjHkvCUzD490psAS57Lz5EESH3wieebzA2vEFy1EZwDGuaJ6m3gggVIJ
	lJCAAJsf4o/bJNCDPPgf2TTFn0tzwoclXgisu6N77IBteIG+wGMRSPll44TvOE0GFdfjssF0
X-Google-Smtp-Source: AGHT+IGPkBDfscjixObDGict643PDpoKVH4Q2VSB/PRUhcncZXP3lKsubEw4TBfYr302pWA+GFV6rA==
X-Received: by 2002:a05:6870:611f:b0:2b1:db0e:e22d with SMTP id 586e51a60fabf-2c2e8ebe26bmr512522fac.0.1741636688174;
        Mon, 10 Mar 2025 12:58:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c248834c74sm2278037fac.3.2025.03.10.12.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 12:58:07 -0700 (PDT)
Message-ID: <5ec34abf-9e06-400e-b822-cc5e61a2ee4c@gmail.com>
Date: Mon, 10 Mar 2025 12:58:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/269] 6.12.19-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250310170457.700086763@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/25 10:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.19 release.
> There are 269 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.19-rc1.gz
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

