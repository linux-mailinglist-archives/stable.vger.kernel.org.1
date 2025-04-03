Return-Path: <stable+bounces-127710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2790AA7A854
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59BC16EA6E
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8C12512C6;
	Thu,  3 Apr 2025 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="Zms8i2fm"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFE924BC0F;
	Thu,  3 Apr 2025 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743699643; cv=none; b=Mlt1Xe2Ot+r6/Jof6qaeuYaeGvSvRfkdS8kXrOkfEQ/ya++7amZQbeEzRZMPJhazTT8NPmZheUQ7eis8malQ9kgoqKLBaoeaDLXqRK1GAPkI6eUlFdvFCp901rAf9Kzwo3hG1WUl95j/1qZgPXz4s+ztQFPJnbD+I1Ik8CdJKP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743699643; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBnNoWRmH/ihnkk6VMVnm4QD19pVosnGRINvBEwPp4+tEzhOOGUOu0tF9iEeGRqHU/7Klf21GoVQLRnSPvHcyI+Y16pbZA2bxkbxLveL4Q5+RNtVMS6rgFLC1T7VUC//9LR8NYAUwSn9OizzLb3aYtgmGMYvZYpHrei9lyjzp/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=Zms8i2fm; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743699630; x=1744304430; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Zms8i2fmEVHkNLvOVC772dTfq4BPp1GxXFZMDDzOPcpca7FDOEoKMR4PbKX5uSts
	 a25CQrp1mrhEjmyTNu3T57OROnd916mp83UbQfiCs+41qzvOIG29Q//xW3JTdOWzk
	 ZCPzhIYZkTypcKsrzC/fnfwCVMBIVh+4qQdRKqUg5hliA8lPF4FLSJPHpjC6/9n1L
	 xT/lG6KtPTzHrJGMcFySOUlUEPxMetciwvovixi0Ag4bkh0N7esPFazbE883hDF1F
	 w5mrssR8H5/NXR4kGIs5IL++1mrAaPAeyGXPmPyJqZodKB0SS2nDaBiir4wqSP6b6
	 YdL1qfSqFcN6TtvW4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.33.101]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhlV-1tqAe10XAt-003MNp; Thu, 03
 Apr 2025 19:00:30 +0200
Message-ID: <a97032cb-a7ab-414c-90e5-6873c93b20a4@gmx.de>
Date: Thu, 3 Apr 2025 19:00:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 00/21] 6.14.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250403151621.130541515@linuxfoundation.org>
From: Ronald Warsow <rwarsow@gmx.de>
Content-Language: de-DE, en-US
In-Reply-To: <20250403151621.130541515@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Ork7G4DgS4w4ErC+0ebWd9FpEJ4Mmay2DPjVYMfJ1Hk6RzLrriU
 kFg07LBbIMaYKm0lzskbYGYO0woOCLPutmHSfditdNZ5GgwQAfE/O5DrqDwOkQpinUfaxtR
 kwlNAOkCVxJ9by6b2/DVw7sIgbXBdZ8Qf+KxQpS/lEv1C3f4YTejyjiffQHIPw4MP+jaJZ9
 Z1Ha+FtjgFKsH3e3to7wQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RyaGdigqWao=;rS2JsGpWwfC1mXnhqpc5Ff+d5Kf
 /aFlpbhBVUekSUamhab+Dv58n1cg/1NVtA5Gq6UhW6UL5MpxwuG6OQqipe2vVnVKOB+vpzDsz
 qzVfgpedgnOLcpefC9LBPCN7Qs+zbR0461t6RUKo/y/8KVAF8ei76GSGYAWQL4kkibRC2wpTC
 9AbsyuqOUHP7SrRODL67LX+nt9umhegoWoG0jzZ5GKv2RgN2HZBlVo2orObWThcO6nblXjSPw
 xXKUozHWi14sa0bngBA2ZVp2VUcxu2+5OvPRM3PaztSBbW6VZ/GdC6074iM29AiFxkUwMoLsJ
 MXia/yox0bKkoGmGHhtwCiDkEbNCz/NKk71HuP847a7FATUTyNuQdEO6ON7DiaiSWlX0+e8KX
 QlT0lnKEjB3Wf137v+TC36qz5PN6W8ihGbAR8vlhRTpgcUMCv5JtKd6Yfxq6Itb9CMm4Tmwyc
 ODfyVcJHIJ1C10B9Pajm0Cv7URFc8fQ1QlYwNRkOlZ0KPboYMrpmIAuavwHfFhYdSz2RVT0BR
 GTXzvUJ/ngYdjDiB40nnvTGybnMFdQLEsa7lrd7pfR/RL/1Sl4A9dYP33pTHcdlJOEFCjL13L
 GW/W2V/c7+kF6otlqZPd0qfhokRxp+Hb1Frjv7jow5xltUj2sL6PEUDSLI/znQNY2Mg2dTps6
 MSpHYV3iLFpG15y12mGOmzamTGhBj6UcEVaNlFTPFOFUX3x2+JL7HoUqrnxsozewBkdqRUq+X
 SgP2ZZunWQ/KDVlPN4Ry2mb+cIrY+b+qstEzE6V0TtWMJcHkSFVDLPg2/egk23lEpoMeH8y1X
 1yOL2DkUZVn9hkpsDQq6j8Lm30TAouYFZ5R/rBEvwAyNrAx17vC8pRZBrgypmdtjhOW/cKarB
 UzTcRbwbrKCf2KUz1wgYlQJB1vJ37J5znG6+vfLL+hTYj7WYmr6gjF0z/uOj3XxEcLIpQ/YcT
 HzQB7UWJkeLiaCOjshX9T3xHCMdjJ4UBcJqoYXT4JHNnuNLA8iw0ckN+Y9v2BYwWbsSGmTrQ+
 yYDxp7xVnyir2h5HA1CzHQ9LiTBdXm1JA+uoVKakBEd1DQO6w6w5CnJsovxRYQKgEVwiTh0hr
 b2kH5qBesYcDxKlaEvMuiVUAEKNw/JhgVes4Mhh+3JRzzbgDZ7A/Ykf83U8bEUdbh9j8f8rci
 bNaSrvyp20FfLrhgGjsMtg1uHXZlfDfak/SV0OM/0uMwtikGbEpjyfc4Ur7vLkWE0Bt+06JKm
 +OV+JrKEpzlwKBgjJPvegRHxsFEad2eJK4LFXtbndR8aSXtp09cd4TAwMM32D4H6PbIzi7nQk
 +1CvL1GSpMuLrlzh+Zj1HFcXOu6a9wDOUM/Ftj2sdZX4dXGjor3WKCW6z7pk/3MWjqmHoR/68
 SubqHcqEUCRCZxrd80P/aOHBskC2YUZHwjuvA48KRqHc6+M1D7W1ey88J8rQDPx2+VgGPKKPp
 nM6yKMbt19p/ThKd1miGuPPv+wHU=

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


