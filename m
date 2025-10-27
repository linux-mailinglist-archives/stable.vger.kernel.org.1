Return-Path: <stable+bounces-191322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 802E1C117C4
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 22:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E92560901
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 21:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A187A32862A;
	Mon, 27 Oct 2025 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXutbyWa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5305B3254BC
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761599412; cv=none; b=ZxOklGzQKyCyqehE/uN929HVRF1h1sOExTq/RaM1XIU0GVAytuuN4kKFDueCBrwjupNvanSPkkQMakufHqhOYN+6vAU6AIF4RJbR4kcG4dQ9UV1ihtho0k5X2ilgKp5DXpTWM0Zc2fzecXSjPMIO4WG0TdaXTbHYlGxGMMKScEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761599412; c=relaxed/simple;
	bh=DWnX1zOzPhdonNNHjblxPaHF1bDlcTCehEAK+AuBlz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fqx1YYkB8dmjhVNS9woNsk2bLzEMdh3lV+yMW+7fHJmtL2r6L5jmyQeXftx8MYJi9QIGB42DQd+mVknW4eBLq8VHqnsznfATe7d4BqLducVq1MjycwZhdYBAC3mRte5xAW83nQ/Kdp676Y6FDkLieD56MO1d7NYs3pSZO+t87qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXutbyWa; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-26d0fbe238bso37142605ad.3
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 14:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761599409; x=1762204209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2e588IPpQNnTE/fdefFVwu578KcqtJc5SaJtmTlNKd4=;
        b=VXutbyWanvs2QyGJiw7wDAUA6VZmCO21vWXhm/IUoq3GfOzwTAQnRO7/uSuD5Bmlh1
         ETcgext6dChYTGVsqR/rQ6gVx0ToM12yT3TVTDN7f9vY3hskAhtfH4S9HLXZ+pY6ihRi
         dqbmEUfnBXjWmlPIIuOzK+OGBHTPOdAN38arHN+kA52BxYSegTYycfrz/hYtVahntbpH
         Lb96LrgRrTIhqWZF7U5QM44nWjYLqOrDE6eCNfqIHu1Sbrf8eqkdY/BTPYeLP+ceqMdc
         K8IbK+pIIvNvkMWaF1ZUHGykfMg6ND4PICGQtoSGSbELppIWdWCM8x+Z+26zG5wdPtpX
         RFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761599409; x=1762204209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2e588IPpQNnTE/fdefFVwu578KcqtJc5SaJtmTlNKd4=;
        b=gadGVJC03FtAiRLnzSvwBMtVjJUes3W0kMNEEUQbABsRiIZPIlt2q9+Y3j9L2hmj5d
         tgW1F9K9R7VyOhTT1h0tftm3hBgjripspbyyPDgq4l04R4I1ydsNvl0XA2Qto66pf956
         97/7gRy3+BoHxc01X4YEy25tYsDDyalo+6YNpdySXxO7Jd30T4RX4RuVeffA6JaxhC/k
         hyV4TYLieBssk3EJARE+NXwfqjsfjTl4zDV+AAuEuWoYFUx5bgqjSOn/1lGRPCULZl6g
         A2+te4bvY7w/IM9aIe0YfQXTJBhysqbXWAHAFbBSSSPQAxRZbt8lrOJmyMK+u8m6SwGA
         NooA==
X-Forwarded-Encrypted: i=1; AJvYcCWuJDNvuALlF7WLWuFqR/kKRi1sj3XrIeYtr9MfZeL8w7j2iD6zBiRC3vIDfd80+MI5xREvsOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKnu0Fn/WRjB6cFMbAXYaQGnS46QvNY+aGjR4ckiEg6JDC79YC
	Bjlr07R4WoYenVfNXx+QdX989shNC587k/OrPF0fcBKE6+AvZuE4vxMR
X-Gm-Gg: ASbGncv/144Ye7Q6/Ex1p7jjqT7eLC6Cs7Z8IFJ2lG5tp8ISPdLaixAqj9PY5sLPsFJ
	PQGQgUSvovCeyTxaLgUJLOoTr2Q6w4TfzkmlCsZPS9pdKwxJxUaNgtCGiX5eqxH4G4X7cvE9D+7
	EZmnhfp23JiAAwvYMbHF/G6AR1rNLNUhOTMqpr2bW3WQK1kArnf/RpT7uLr03cMv0HE/RyLjh4x
	d7Lzzl8lyEeCZT9IBdGeqHI6a/F+KrEcnOIsPtREee3WErdeDmiYGXS11lcgoPgAqsLfeJQRHxA
	wme57MWAI0531mIeCNKxb0znHoP5vZy2U7Fq3YYouWIE/ugH3/MLWXH0A36QWf49hxTn8W+5qyT
	6TA9wL/R1bw7MiJuru8fAjpEx+7+ZPE6+aX9c/d+5ubBBy9KORQlBaSPTCP1T0ciwxuCzbyBuXu
	DP5JA4wfIq1VaoNNtFeF/iET3+zqA=
X-Google-Smtp-Source: AGHT+IGAcXx8rnRjjfBbyvkfw7eeVqpM0QJvdpLkgNwEN8JNPyBVKydtR6Di4SIU3+wjvCHp1ZaLog==
X-Received: by 2002:a17:903:32cc:b0:290:c317:a34e with SMTP id d9443c01a7336-294cb3dba25mr11873225ad.25.1761599409461;
        Mon, 27 Oct 2025 14:10:09 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e9f9asm9559753a91.11.2025.10.27.14.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 14:10:08 -0700 (PDT)
Message-ID: <70c3a401-3fa4-47b4-b8ea-a8e5ca75dcc6@gmail.com>
Date: Mon, 27 Oct 2025 14:10:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/157] 6.1.158-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251027183501.227243846@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251027183501.227243846@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 11:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.158 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.158-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

