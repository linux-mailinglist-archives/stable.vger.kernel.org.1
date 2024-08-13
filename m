Return-Path: <stable+bounces-67443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03863950152
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 11:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283351C21B12
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 09:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9C217C7CC;
	Tue, 13 Aug 2024 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BFeCMpYF"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6618BF3;
	Tue, 13 Aug 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541832; cv=none; b=r/nNn26vNdz+ZKZEyUy5np2/nMWKoBkSENyk6ZDDD+Y/JW8Q1SdhqnKL/zU/Qmzjr+NmwQzERlhlooZ285QnBEuN7/JBQkvqyrCEAkhzsrLG6pYKnJnDQp+VVL8nNh5l4dSdz6K/uYMC2WJvn/KkyQonUo9pnUgonTLlLRgp/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541832; c=relaxed/simple;
	bh=wCyOeoKe9u+sJD0iMFdk6GI4anN9adrDopq3IECouso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNAMEVgDllZn2LeWyGOUyL+0WltZNbpdpRMbKWEvVp/00BLcmqrkJR1UFYb/mn9hGw90P1XW+F8kLyuUbk+XjiJtJqDr/L2o1wbCcQ2Fx0d6+akGVWJFq3JqwgQBNfdCfnKg/D9D84wH94pmLuZm7uRYHGrOVaBIx/xIPsvMCeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BFeCMpYF; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f04150796so6807060e87.3;
        Tue, 13 Aug 2024 02:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1723541829; x=1724146629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JE37tF2wmw4c/jkkN2/rwSonuOgWb2m/+qCDds7vhx4=;
        b=BFeCMpYF3amveCphQFdyxt2OymtYc01Y/+XQubhgfaqDz0qXyV+Vcq9Vy//uBSPHaV
         18Aorp63zpIKnHqokwRwW64CukcZRhgyVXRMIMjRttScytAYZtI6w2NxlHP9uj/baivV
         RIQz5B2cBMrjEbsOU8xeUfPzCmK4yx4A4Fl2dsUUQFgBOVt5C7oCB58Os85eg2Zrz2jF
         MUcdTafkrH9VXtQn3MTVepa8dLWDK7IXeaKaDwOkRvq7GTlP/zBXAJpN6u8/I+aBl12v
         lZtQrp2n6UmblrLHRljrPNuCCeW12xDlOmDtNwGUw//3AniLbXj3z9h4C977wAcMvDCG
         t7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723541829; x=1724146629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JE37tF2wmw4c/jkkN2/rwSonuOgWb2m/+qCDds7vhx4=;
        b=nmTqwrlKGYt8vknv0ySXOZllQWorfn035auSMonUrdzV6vgDaG0u6pCXxbleXsGKAR
         7jkOIBLFqhldOsAagKwCmXXxX8sCQkMoL9qAJhE0pO4EhmyaucHI0UZUL5ruYp1mlexA
         iO4b05QPJb2u6JnCrngsDlYRshOqx9osX5Q/q6CapAeeTS2Wj4hsNq/Gb73uQzVQj+xK
         SxcZpMGR+yI9AwyFHhY+JSrQnWDB871RLeFFGsL8ycFvIJIpiHUdx3fONc6qL6enCrZS
         lRsFtppQDYK/ZXIwUGgEA2mX8NqvMGjzKFiyBuOTeMTX6+V9mYRiy/70fodATwv7ywOh
         MbEA==
X-Forwarded-Encrypted: i=1; AJvYcCUhjLtLR/14f6CAYH383UN56b4wcgnaWhXJWZXxEHttuYFPDreidGMrejNhTS2wltE3bI4ppKJEOHQeMAlDtnLDQLNJt0tok3Yyzsp1MOUzOv6b5XGd5O08TpWG3XhXhOcdEOfL
X-Gm-Message-State: AOJu0YxN2hgEUo9u4XS4A7Eu8A85Q8eh3zrDQ9MKhU9nM3dstkKTzOPj
	ZCNW/F09OPFHudhexpjA9vHmi/t89G7Zq8SrA1lL8o/aYQ5nomE=
X-Google-Smtp-Source: AGHT+IFBMdzCkN1pfeNXsSOgKOTPTbLurD1G96vui642G+9uzDO80cyO1+j8cXtp04kUD3RJI3658Q==
X-Received: by 2002:a05:6512:131b:b0:52c:df6d:e52e with SMTP id 2adb3069b0e04-53213657bd1mr1976632e87.16.1723541828126;
        Tue, 13 Aug 2024 02:37:08 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac34a.dip0.t-ipconnect.de. [91.42.195.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c777017sm216251795e9.35.2024.08.13.02.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 02:37:07 -0700 (PDT)
Message-ID: <8114fea9-74e2-46e8-bece-9118fffd3983@googlemail.com>
Date: Tue, 13 Aug 2024 11:37:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/149] 6.1.105-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240813061957.925312455@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240813061957.925312455@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.08.2024 um 08:28 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.105 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

