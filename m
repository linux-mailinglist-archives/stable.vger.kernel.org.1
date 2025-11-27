Return-Path: <stable+bounces-197542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B39AEC903B4
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 22:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A95294E3068
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 21:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13912313534;
	Thu, 27 Nov 2025 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MHbSIPfQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C09A30AAB3
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764279885; cv=none; b=b5J1D661XvGKfUkWRLURUBuskXmCaaPfi3darxVvTSpqOIgHEHivdCQxrnxyJj6q0wq3t6qLXIHvIE3+oWJ2T58qEjkKWb/oEbVHPFCBaqyIFbMouMxUsJp9uXON21Jw+ibkz+FYJ7zTZtLtL+2kht4TPXr/sBDSIXlEeEANmRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764279885; c=relaxed/simple;
	bh=kYqUyk8HCuKIoNyqva/RjocXWD2CbFLtw8L7BkLoWBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PicYaLqSDvsNxSUWf28NJVXXjAJpLQ+oIC8kc/Pt0sgpahNeOgfwUiPphe8qqBcHfluS9MI1tio/UO8ZsbZC1CFyTQuTlyMRVZ+iIR99ifxUM4xIsD9X0c2QfWqSQAWX8tmotSkomMAlPOvsYaPjaIp+dndN8ZcSkWTYpJ8EyKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=MHbSIPfQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47774d3536dso10139465e9.0
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 13:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1764279882; x=1764884682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X3vMxogTvz5764QssziL6YxPWQCVFIuzqxor/ZKDnR0=;
        b=MHbSIPfQ3fE2rDxMqXXrRlvL2rAQjd6/aHKITdJiiMAv98bm1Pj/1scXP3oHQEeCfu
         AmVavP/w7YibD0VLtk+7HGdYdq5BARaxKNAE9qukm413Tkg1ZYUilUVu16+9jO9kk63r
         VyYrfd6DhBj7amBFxjcQlkjogAT4SKwLklh+7NKsOO34qTRjCHC+XlZU6HYXiDTnn4jA
         p+DbslVVqIt2LJh1mvO4UP/lITuwXJ2u+qeTBS0EYD312i8ZELQTdxsEgf0x5XLPG9Wn
         izeLyt9m3jcx38XiwSvPqvoW8zNYAVAIr/GV4cOK+XArIV0yPMA0XC5En3cM9dN13seM
         acoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764279882; x=1764884682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3vMxogTvz5764QssziL6YxPWQCVFIuzqxor/ZKDnR0=;
        b=PtdKD20w/Ms369flgFoNSTMTVwtJ8lLExSrwPCxW45fYBTjxIQq6AX12iCuID9v0l7
         MlXsnUhgUmoCrEHyhXybmmSJ/ctyRKFRKa+GZmFTKEusfGjtckd/yHgrQkcw0vU1Sw5s
         cQEAa9ST6oY9GEF8gTFl892OPop5e57e+HTxa2LSWN4iJpDqPsZ037WhBEh3ZYTEKVfR
         XhFCY/l11RfYwvhPYpz9TllRtw/t0xNTt6FI+g545w50WLShl+BTOESQD+cLnsaJI8dt
         ymPBkKHZkPkY8MHsFZY7uWEXTDRFgLvshHqmtV22a2NY7yRysoiy2SV3f44YXig1A+Lb
         nRtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYdYjHxtSDz6KW1v64kTNL6D9NwLvFZhXL+Ep4BlPvkCeaC7PBqVMvLDFQ2bpzMkPVwQcEzAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPJW9OludACCF0tJ+2jRBunkxKWXfJDHxLNTcvcWKO5hHXpsUX
	psUEr0dibckwRo2zHiLXGSs8L43JwEWE3P/WSF4iUOszweQEcxYYB1o=
X-Gm-Gg: ASbGncsi5zb5UUDFNK7iIpO1Z4QHT66xZJKKyVWqCcet1Y/Uft+7bz7sFLj7tG3xdtU
	yQZpWh2IKTduJ7piyLKKYBJtcaEbKca6NJGP5kSxfoEY4XSQYN1A4sC5CFOCKW6t4Jgdy7PgFfA
	vDmLR9eJrrmj+CdZ0Gw/iaQ3ydP36qGsDncdgc/7ctA2W7N4xJWmYwiXAtSH8VqcyBELuAHMT6r
	a9lQ4IFl2FhhMyCKPvUh+X/kmGvhD92/s1dZjK4GnslpT4KAn+eX5Di4YP9GjRNK7UmTCVtXakQ
	3yU7UK/ua9UjnalxEwfoBn3JiTSoSwc8XExrNq2oV6Hqd1mWlJ4pYs/qKPaYYwBVDoTFcyo51+O
	8Ts4buaS0xfVfPGyW6NAKtvbjjEBMZYXMQThOQj4CMiN9NZYERJC7Q58VGgZbHuJWWv9jrDM+Z0
	tR4ofgxW5OfRJ9HKl6hB3ExLWMl3GN6/YcnAZuPqtLiEdLWLZ12t/pFfb5Wvso/OY=
X-Google-Smtp-Source: AGHT+IESv4h68YmFtRIIfRfpstRuuWLD9RkeIBwvQ4RpD8DKrcbS4Olp/eGP7hkYslFJjLJtIU79mw==
X-Received: by 2002:a05:600c:3044:b0:477:5639:ff66 with SMTP id 5b1f17b1804b1-477b9ef4949mr192214545e9.13.1764279881955;
        Thu, 27 Nov 2025 13:44:41 -0800 (PST)
Received: from [192.168.1.3] (p5b057472.dip0.t-ipconnect.de. [91.5.116.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479052def4bsm73779255e9.13.2025.11.27.13.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 13:44:41 -0800 (PST)
Message-ID: <9d2d34dd-1147-40ae-8859-9ef2cd4b7dcd@googlemail.com>
Date: Thu, 27 Nov 2025 22:44:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 000/176] 6.17.10-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251127150348.216197881@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251127150348.216197881@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.11.2025 um 16:04 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.17.10 release.
> There are 176 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 Nov 2025 15:03:13 +0000.
> Anything received after that time might be too late.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

