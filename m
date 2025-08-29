Return-Path: <stable+bounces-176724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D83B3C18D
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 19:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9AAE18955AC
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFC22222C4;
	Fri, 29 Aug 2025 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKxTAEF9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57442DAFC0;
	Fri, 29 Aug 2025 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487563; cv=none; b=l3eL+Q03C0azyKz9ghlHzEWFhpbIpZEE2R2u+jkDAxHfm5Om/jL9NZTq+70x+MJ5IO8sHUgqsPfhJFcaMreqztVLKxbNqaPBgkV/JsbZiRPKFAX5aQOJkRV0MY7SYb2wWCUEje9vjUwl+Gu7y88so0MSyKKUjDxaFu3Fu57xLGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487563; c=relaxed/simple;
	bh=EbzgIH1HLu5QD6c59Y3BuxnrHDc/z65s3liPY8u/7Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COMX3ScALn89jmBOMm8oZyvXlwKacGjJd6QlGTle6sW6Ie6ZQ3KGZROpeYbEYdXTeTJk8I8l4t8HR7qhYlIduMoSHGJIpTv+byMmoL6drXuYneddeXc3TE8DVjV4uCFFc5GQj/XRGNW3dNsyzeF+F3Bs26XKnFmB5/a3LgawwLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKxTAEF9; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70dfe0ff970so15724786d6.1;
        Fri, 29 Aug 2025 10:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756487561; x=1757092361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k0QysV9axDS9cZaUS4YxmGTc+usyoo4etlAbUcSP5P4=;
        b=MKxTAEF9PH2unINKn95yBPIf9csnfcVQvqDFm2QmT5GyTEF6/PKPkA9ea4zk2Fy3Yy
         gamyuAUjMnaVPp0ZhRv4bSzo6rLyz2MzgZM6Z5QM0ctSb74TNPSDGghtrrbQV0eEe68u
         BvXlCdMli9NAzbWj2H0GOw+uDpd45JQz7UcydUzHG4xz5ahSzIBs4ZGcHV/534tsL8Aw
         ACJN/aTg4uTTMVl02PClofTc3EwIN3RW2ijUqXCB/jFqS1gBNLOBF5eLjFcYG+ANF7xT
         IuKM5d8UcasjBJ8qAYBHbKKPuLh8vC/XioGmfpi5iWXUfIAfy2bQ2c/kD/ZyoZyc2yC6
         u+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756487561; x=1757092361;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0QysV9axDS9cZaUS4YxmGTc+usyoo4etlAbUcSP5P4=;
        b=R5uEJlHsouu+lh0HUplR2NQxWRXjmH0+hV8PBNsa7ZH95WV4bj8iWc6dotEWmAOSbR
         u4NbutoBkqrrKqMvSg/Puxdhu4ZC3MemtKel8qqiyxB+2cqomEWB6ZJdUqwvqZwnjCL7
         gsWOKaFgh6prOPiieS9xHNydtFKbotlhrkIqFeb86zgjDW5cknxA1UduEjudyVqOY6Bb
         4DMXAg6tRgL1nTUoSIk1G6SgtwjzlCF7rTjqQCKbvHpLGEJG1sNwuYo4lJ85V2VgpgE2
         cEL9dc/DsuOFRnZZOFg1j5uaoKmR7wLNDdq+W2/c86Rsb8qY33ExlZdDJWys4aQdWGdp
         O16w==
X-Forwarded-Encrypted: i=1; AJvYcCWr+GCQzqXimMN+5aFz2MUsUHcU6A34quO2SkQD9FpOgd9llTzdmh6q57CuVYX2/q1utNjfjEFNtjsB9fE=@vger.kernel.org, AJvYcCX6w2tmKKzi0QluIsESM6JETBviK2VcGdfs0g7kFJJYjUDBAhXcmYV7TE3Lq33P5VqBD6Gz6Zfn@vger.kernel.org
X-Gm-Message-State: AOJu0YxxWbuHT+CXN2hUMJkhFcHsYYRx3junbeBC2DRRdmtWmq5/M4MU
	KXsrsJOFX6op4wc0O4sNew6PvGnzPm6rt3NA7/r3W8/FTZmWmVTlz/d1
X-Gm-Gg: ASbGncsGsfWanVodSFThxY8A8WIbDmp0Mq81gy9dxswc/HrpOIuSP1YxiUYUOYG3Xbo
	fiC2muoFLl1m4boSU+6b8Ay2tBtQf1Wt76i95iw//b7SFoagd1kZdovneURfT+7A56eJAQr7CTh
	uLakFtEYKrxmnHhdd0mQycWJVqYFzMUW6QEEL1MfBW9nVVt9EJzHJvVRseggqX9/f6/+W43NRWq
	JnGxoUxkYrpOZ3y4YIYQIjs/r1bQBNtHRcLTOnn4EpdkCkwmXpXA/XuoV0DWc0qT3jfdHbmGFEf
	TQPCnEEsuM21Iy/pG8NFZINn3puNuJexK3uFVk2mJFS632UcqYLTUhvVx9niGCmVFoiBmvGalcr
	CqbaoHq68c9wsaXhtLQvOawgFLkHUsl6/EOl0g0rLdiGrfFBOJ5TLBS0mt69Er7qD+7o51Rc=
X-Google-Smtp-Source: AGHT+IFowHhm/2HgBg4U81syGnLeMLMxCHsX0nYHjmBLkcGfreTl7elFMGBSj/Q3yaeaCdcrjZRhgw==
X-Received: by 2002:a05:6214:248a:b0:70d:f8cf:812b with SMTP id 6a1803df08f44-70df8cf85f6mr69524246d6.12.1756487559824;
        Fri, 29 Aug 2025 10:12:39 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70e57ddcb5asm19719016d6.6.2025.08.29.10.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 10:12:38 -0700 (PDT)
Message-ID: <b3a99b8c-20db-4912-a77b-84670da8afe9@gmail.com>
Date: Fri, 29 Aug 2025 10:12:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/403] 5.4.297-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250827073826.377382421@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250827073826.377382421@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/25 00:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.297 release.
> There are 403 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 29 Aug 2025 07:37:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.297-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

