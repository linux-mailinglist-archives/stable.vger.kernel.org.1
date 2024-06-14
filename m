Return-Path: <stable+bounces-52242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDDC9094BE
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 01:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BEC1F213A9
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 23:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9B518755A;
	Fri, 14 Jun 2024 23:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lu9W8PVB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C4D18410E;
	Fri, 14 Jun 2024 23:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718407284; cv=none; b=Cy3lx2Qh7OxJ/+xUAwOfx2sThZWi/YvU9ED8Ud6VJ5sQhOq/eweDCIbSXVdvJPD5c4cyC1i/7Uj4efVQmO6thhwNXz2nkYJjdK9nR3HYTrVbyJqIYx/ip3HI9PtHMZDQcyBFIpdhQpsef/6wbjKjVw3LxjHLGE7zY4bSlRCH2wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718407284; c=relaxed/simple;
	bh=JlwKIzdDc2gilccjbO1/bZmedm07qgXPguzxriJ3hi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrpFtSDRIoY2t6LQSMIHvAQdxqW7DQ3mKA2vcghvfyWqXfpd9sAPPL1Cp/BFYaBS8jkiSWgayF5IoiS41B5cGCDnUd+mwocoVJLSDXXSZOM03ix1VfVxgGS794zmHVwxAICH/n4RUrHPCTDkL9z9iLprlcdMBYIPdzR90pXLCTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lu9W8PVB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57cad452f8bso3005557a12.2;
        Fri, 14 Jun 2024 16:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1718407281; x=1719012081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fXu7k1QKS8vI2uwVYNkcYSTHvjBL0gY7WbM8/Ozvj/A=;
        b=lu9W8PVBGlZIMXf0yBVijg8SK/q8Q0qNZfFYF872mDJe1K+zLVc/2duxIqPtx+VfB4
         Xnno7KKB9NYkZKZFMim9JGMsoH2OODOL1dYTdXx0WUWl146lae/b0oWJBYT12FnZmq3F
         INXuCHQYNpBoKKmKWPJDZ51HuKEpIXTxG1qrTETtncSDYxdBE1mgVTwXjB3Z0QKBJfg7
         f/fC8/m2Fkrq0yHv2g584wLauPLP21CYel8L2czOtlzCwkthkH1aRbhlGJNjWVyMttad
         iyuHerz6XbWRVdnHms9eVhFYTwEQPym6082tIynmhiRmiHSI3cKgtE8cnVdEU1cyKxlD
         /G4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718407281; x=1719012081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXu7k1QKS8vI2uwVYNkcYSTHvjBL0gY7WbM8/Ozvj/A=;
        b=eZtmL9+yh0RQQX8XGgcFzXQr7ugsJXzRbthXzANcUmU+ySz6At1jVmKuqlOQ9mWr2R
         hXgyNPUOBjuZ9j59QXwzagLdnvwq0n3FNBetZrfaBx/jvgwJDFkC3i8Jdg/LhoJ+bm32
         Kxz2lM3oQExEucMmxA4RtX9gLLbIjXCWLnzItT4DRxHYih8qeHxM1ROKRbzZfZfWebfx
         j+YOFwL4V5mtH2ua6F2l5880tQemgBrl5wjIgcQzFA9tWbtca+MfCFo2MygOuhTOxWEA
         jZDwbao7Jaj/0w4FDyq6GsOocwyVukZSeFA7iD5y4EHo3HWL3TP37d2+CArFstMzgDth
         QarQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3q5QU7302bMXD7W8vRgRDa0BDvrq9+xieyj0qd9w+46Yb2kQ7mXy8WhQCFawQhp9SluOcCpbcgOySa28Y1PMST0LUSsWSXP8QMWr4LqtC1yvVPskujIYUMjQWTXbsElompv0H
X-Gm-Message-State: AOJu0YzDO3InSEvzKrsJEikJ6L2dwyKcplSWcjrlwgPfeSzvbW1DwitB
	ygxO2h+vDCXhiFdAFlOuG6Wf6t+CWgKFoqVZoGrblRbRq4uruzU=
X-Google-Smtp-Source: AGHT+IGhHA4QPh7/6Dd6EnaARY+JdOci3GUIQJT1ngUwmjquFtmH0GCsJTa8YTNcfm0uCQTQVMLBsg==
X-Received: by 2002:a50:9b04:0:b0:578:60a6:7c69 with SMTP id 4fb4d7f45d1cf-57cbd69e7a0mr3017216a12.30.1718407280589;
        Fri, 14 Jun 2024 16:21:20 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4225.dip0.t-ipconnect.de. [91.43.66.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb743adacsm2856765a12.86.2024.06.14.16.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 16:21:20 -0700 (PDT)
Message-ID: <0fbe98f5-584e-402f-b50a-0438515ead7b@googlemail.com>
Date: Sat, 15 Jun 2024 01:21:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/85] 6.1.94-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240613113214.134806994@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240613113214.134806994@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.06.2024 um 13:34 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.94 release.
> There are 85 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works w/o regressions on 2-socket Ivy Bridge Xeon E5-2697 v2. It runs 8 
VMs with some load for an hour now, and I don't see any problems or hiccups. No dmesg 
oddities either.

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

