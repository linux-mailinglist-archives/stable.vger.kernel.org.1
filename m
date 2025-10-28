Return-Path: <stable+bounces-191554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 282BDC17276
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 23:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0A094E45C8
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 22:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFC33563F1;
	Tue, 28 Oct 2025 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="GJ+TnnpW"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FED1D27B6
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689526; cv=none; b=KZTU2iebUFQF0UDNnTiy3y9ga8NE0bcmSFh8mEBYhfT7SlCnb9Vt3zWw5LYWmEqaoEeC8Qq12X6bhJPhWDTQYJfgvVGUJW1p/p6vpKokYQlJvcTjOm+qPqNHamY02I+qxdnKV4EMQ+QSiwFqITn5QF56iJthoa5EE7E1ijfism0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689526; c=relaxed/simple;
	bh=Qx1dpR4Z5VFWuR4pe3KjnkMHzfKUXq4FOnh7HstojfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t0hznaNC5Ia2bhO+fzIXFcsVeVSaV0jPnrkgZl7W8p38TrMGt/XKf8ReH4Z/sC4SBxpjICsPQBiAeEDuMWIBqlTwmHVSfyLhOWdNzMm0h9IrIC87SRtkji9sV5mirDIvlKa8mMvnbHHCEHrK2rxPRZPsTvnt6fOemrIgSmV2SQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=GJ+TnnpW; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-89f3a6028a8so453706085a.1
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 15:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1761689523; x=1762294323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yxf4SgMlhljxRfzO4HwJ4G6Vr60VuBp1eH0raIEYlEY=;
        b=GJ+TnnpWJECo8on8a0EzEyNI8kQM3p9yFbaa7njuGNHSdMpZWESbpQeHkImzi4MUCl
         gGflV8QZ5KziWsONsxqgiExYx+U64FQf5Ja4R7uVrTEbUIY5dHM+069MUl/696YdkMFc
         7GFQFrmekKKjAvNR/Ax3TW/+xM6clTxslehW4KHiiF3lWozd4rwcGp+WW5vjqLEZZA9b
         hJmsh09tpTERCvIWl61/lBu28EQPPOG3ABOA/gKfuvN5PhSM0iKadJo61d/p2U7A+6UH
         by9+msMeV9ekPFFqsqifJZ2o0NIRCzv0UcLkLLqdXXrIN7pRTNXhpiiAkgIkOlCK/RBY
         X9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761689523; x=1762294323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yxf4SgMlhljxRfzO4HwJ4G6Vr60VuBp1eH0raIEYlEY=;
        b=Ie+zHo8OT3DAVtmxV1P/EHXCzl1ZajHacqgdqS9AYxjKBK57Up9FrXOyqgZ7cEeySM
         qGOo1oYvOAMmlk4thuQLLU+07sJkdtp5ml6465ukt5bwV8WDNrUHmgp4Z84g4xlt2BuO
         X2elgifSaCPFzbirORT0k25FUJPS71OaaqcWZZzyxsc8rbGPIIBbiBDtUQLR2/UaPsue
         08MP0WAS/mGU7ABtcRNlaD+/FNwETWxWkPYps8vM29xlC+wqidthkCo4YzODE5VRFYPz
         4N2M5+7/iTyIou96518kT/vhmCCWwL2i5RVXyQEVMLiOrPYng3736din84QEUJGgGQx7
         sYoQ==
X-Gm-Message-State: AOJu0YwZLpcKfIQ8YocqFjXETKrzoWe1mUw/t5b2l6JnatYtfSiFYZZo
	QOXSre860zGoGclqw9QEJqf4OpYOBt45HJmrZ4OOF3uRAWCXE/qz1t+2IATHnPXye5s=
X-Gm-Gg: ASbGncvDGW2m3VrKduizk9D7iymKTBRmrCM0eF+ZF+CQ3vAWHhKZ9k6QZrwCFuAGb4c
	CoSlwFl8IAp/ETwGGZDQiOgJuf9KHc1kqrMB2Npokl+YrIK9RMhe5nZd50BVeQOYxsFd63ErM0m
	Rubrbo7EAj5QT9TcYoYOt1/+YNByFLS/IVscPVktT1ZbjCGUYrQcs0MfydsYTRZ6xq2s839l+yh
	TTTD7s9BoyXWdeOYAPaBy/2XsglyLCVvwmNEPqW73aa/N7frN6vV7qtwIQwWHn69YFWiHoEq7De
	q2x6wCmKr99pZySnoCm9n0dd/WILXUy+tQhvPqsxFxOmugLP7Sr9/7XxbHojvTvn0EfHGDo7d5+
	QURGMc67GxvwcQlrz3vvLSXoVK1+Hobf8okqv82nuesRlIE7eXO/goEYc15Sz/ppswIz+qbLLjv
	0OG5B2yJMsKzv9UQ==
X-Google-Smtp-Source: AGHT+IEuxLZFeeurzwWASjRayjwc5R+HDg5nYPnfTfXlcqnJxlxd958na83WIBclidyoi5t/YfRt3g==
X-Received: by 2002:a05:620a:45a7:b0:8a1:c120:4620 with SMTP id af79cd13be357-8a8eab66367mr103423285a.45.1761689523165;
        Tue, 28 Oct 2025 15:12:03 -0700 (PDT)
Received: from [10.10.13.73] ([76.76.25.10])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f251b8a24sm892468585a.25.2025.10.28.15.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 15:12:02 -0700 (PDT)
Message-ID: <2242a1ea-d6bd-4593-a884-3c28d8037e1b@sladewatkins.com>
Date: Tue, 28 Oct 2025 18:12:01 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/117] 6.12.56-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20251027183453.919157109@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <sr@sladewatkins.com>
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 2:35 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.56 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.

6.12.56-rc1 built and run on x86_64 test system with no errors or
regressions:
Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade

