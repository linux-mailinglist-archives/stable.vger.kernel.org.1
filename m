Return-Path: <stable+bounces-139094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C45AA4137
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 05:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE231679DC
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 03:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B09319F11B;
	Wed, 30 Apr 2025 03:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jLwogkoR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C720126C02;
	Wed, 30 Apr 2025 03:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745982232; cv=none; b=c8MGzPUhkt/vOR5XYs1sW7BSjqFA4Rc97XGLhn4FAhDBzRa9ROK0QcwcGTUqjTNiFaptG0zmFmj/NWPx+h3KFmtZMnnnGGOZWJM+Y0vJjFBjudKybRhbmm3E2t5KPUYRuFSmF1SZytHcyxfGHusLMAbAUhXVY62T2nQLjtBRDGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745982232; c=relaxed/simple;
	bh=flJyldUPUjTdxfP+ie4pglwXh2rhaGbocVUL5PwSRPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kp8+NorbUNH0XH9OqDo8hRaiOmwIot9T0MO6FeAZb7omoMvKgwmNlZCiscMqkiXLUKQQDl8PFlIRnE33yWRqa6w5J9RD4h1royAcoH/N3LPs3iWIW/YrAECGQdtrINwEqPb3PeMba88YkUDe1VN2RfR97zxC3c1JxP/HBZsOJEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=jLwogkoR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf257158fso38164495e9.2;
        Tue, 29 Apr 2025 20:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1745982229; x=1746587029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gE8L88GgBMGbh45ODSYqjl77s9d7K6gsG0j9QpojvBo=;
        b=jLwogkoR2MhH6PMNs5jhiORaKfDwzATEOFKklQ8r6UNVKTEodcLtac6++OmKecoP76
         FcyVoKVi992EpxMKOQYw9lJFb5XA11Om9r5+N55AvbRbypBvZGaTH4q4UgbGR/syTpcQ
         /SRaVfjUxEs7phHpaCRXGtLbLCOJNliBQtZ4RRFHB1RSmiayhQg/p03jhKMl1UJ71gmC
         aVuM4c3PcHxou9zRpi0bctohMRtO7R6FzT4e+Fk+cSIf4BqJFLFuI8vk8gnLJSi1J3Pn
         4A5pzSuSn2Q20G1Uj+GpiIkNvMFQ/rY81HnBKgonT8tMTUujAPnX3KWEQZ+Binv1yXKk
         W5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745982229; x=1746587029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gE8L88GgBMGbh45ODSYqjl77s9d7K6gsG0j9QpojvBo=;
        b=ELwfV7BVsTIVLyoqcw/nMNNXdLMSfL6Hl2KTKxf5Wm1c49gE0X4ZzCW1F5G527Nq54
         0OJP9tA8a1pfLmF9W5+ql6mCMtokfDmyl+2s9KbI7Go8fK8ckdFfMgYA8dSGx6O3lj2o
         Ci40RchPuzl0317lTRsXzrUhkLSrwetcm3t6gW4xsqoaubpGqIQ/i/UO9AArBCwyfKFp
         LaQEmiqkVaRwVkmXfiUEt7PpwamL38fVBJdCMrzyilMw6s58DGZIZc+hk6ATX1WDcqtP
         5ZKKNdedLfDZdYhqe/vvR/w0NrprHN00YpjtDmH0uGSDjDW9/GwSYIdn/1obcNRAHd58
         ShTg==
X-Forwarded-Encrypted: i=1; AJvYcCUQSevgyPnzVL3WIfuJVuDcRiyXRKlwP8vH1gnbnYtyn8yWz82mYmklse6xY9ZFR377frbnFyIE@vger.kernel.org, AJvYcCVgdQQWIUBWNVwVGXQ75DA2fPPY6FardnxAYrnD94UQtA93mbruMHxNkrx1pv6KMNZeRvPUzOB5h57Zi5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcI04XMyxfFICQWEXuJIlNSA7p2TurfB5FqODUWsGOwhf7sPvI
	iajaTjrHIS0oSHNmwfEqveIHz6jdK5z8LmFa4FxbpHqMLI3Xp/s=
X-Gm-Gg: ASbGnctZRPTtuc8YI0xdB3rh9B0qOSp7V982REnhV9FmwUi23viYLCoJe0rAqSB6nFR
	2L04qjbXBQF+vTAOTcU1hOgXmJO/BO0Xwdpr0K+IjzUSO1EQkPW+fJNv+R5pDb8FHjlStc9aB7+
	LlY6gV4IJN60dKFotWZTGbIJVIXCeUX6zSubhx6JOruy9WYi/Pkvp1njpl6WfnfA8QZih+fmZFC
	TfCo0Y+U3WmAIqwAlPyTMWbCfxjlSTuJnh7k14UHM6O4PzZvJbEUy3qbitKalLPRzMtlKrdmfHN
	Bd0gTzWTyuTL+ojVl3XRvWW2rqCZNTIFyKIgx74+bdSjTMnSik+41pT2T2QkFjf7X8bC2Oc8TfM
	nN2qOeFzniFtdpYGfq/s=
X-Google-Smtp-Source: AGHT+IFuSFCMk2NyOA+Ab/UGUF2QS2kK1ZDDDW+pqr1XFieTUQv3rWtf7EKj7LPcGoSe4pwrbjCwhA==
X-Received: by 2002:a05:600c:3d18:b0:43c:f629:66f4 with SMTP id 5b1f17b1804b1-441b25dd103mr7939065e9.0.1745982229350;
        Tue, 29 Apr 2025 20:03:49 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac6c7.dip0.t-ipconnect.de. [91.42.198.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b972casm7710135e9.3.2025.04.29.20.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 20:03:48 -0700 (PDT)
Message-ID: <8427fad9-8c45-4fd1-9675-bfec041d3028@googlemail.com>
Date: Wed, 30 Apr 2025 05:03:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.14 000/311] 6.14.5-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250429161121.011111832@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 29.04.2025 um 18:37 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.14.5 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

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

