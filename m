Return-Path: <stable+bounces-105145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4631D9F6597
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 13:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DDC1168D3E
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 12:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884B519D89B;
	Wed, 18 Dec 2024 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bh5LUEtd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995A515957D;
	Wed, 18 Dec 2024 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734523920; cv=none; b=kQs3TR3GCJDpXHHXuuxDherq1K6diH4V7A/XwutwhLdIAE/5u2Y7YavDj75f3UptaDZ1Hff7WVYAqzKuvlMxsY3DCE4q1AVVeLgfDDSvz2g3OghqoNbEGoKf1OMhaIKYMbtLkyRgxch3LjptS1Prf9+m7IKMxN7CIiUMXPAHdOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734523920; c=relaxed/simple;
	bh=/zbA8ekfT6Yg7vwovRTCu2YheY86bmXdbPOLhlF6tF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iNEAe+5nCi3axtVb4M49rhV+A0+H3s9r0mqgbWXIjpBh3TDeMGWBNc1LX+vu7kA6RIdIabcbVX1jE/KNKj5c92lt5Yhx+/leouzvwNacGWK+W+lKhFpmKzWboFQoXdIsAPUtka5wpqC7Mu/5P3xzjMpXkVnhqHMIIo9fwsjG+Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bh5LUEtd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3863c36a731so4609238f8f.1;
        Wed, 18 Dec 2024 04:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1734523917; x=1735128717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IXOgkLY3QEpp5R6E6oIMp3ZgUZIq/BejK1hXGswjBa4=;
        b=bh5LUEtd4LRBgw8bBpg51b+NxU9Bh4v//y4h2iJwPJ1eljsgDUmkwn4Eu84gNhXaIt
         ToBgibG/PbP1AIJF7t+ERHYrayp9OKRJoe6IC78DU+dWijMspUcJ0BmrDiNzryt4Pagj
         gZUxQ5qOwfh+5kAouOChwqIBJK8Ki9aR5BIGPzKSd4lR9aaGcbyLFQkWBumM8ofY3yy6
         5QkjjqEqBdgInT5iQcS6FwCYlD06RowqUjRPV9CFIswig4gV08UFfO1KXsp6Z+hs61WN
         t/BF0ADX3CgukQI1t+udiTt1RaFAPfgzjeEX7ED/xYQaQq0tKIr9wnhNan9/NLL7S8Dg
         uK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734523917; x=1735128717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXOgkLY3QEpp5R6E6oIMp3ZgUZIq/BejK1hXGswjBa4=;
        b=cI2jCmKhc3ARRRz3tJJlE16XzjTNPLeV+zfD3qEwDNNXKvnm6ITSpbpQ7oJQ8E3WJ7
         sMmMQjrNDCw1r/YcePSKrdX3Cy6hVQGAfGr35EDp1ZxETdBFrpY29QVsOAdDzeOp+OGu
         oq2dKgn48q7Q1wpnXCZMjUzd8TdKy/wsh57HkFjs6JgnpHsnqfZPedlM/A3/mkXsQcKJ
         32q45ek6Eu4iKgIIdpsajBYbIvSOEm2ztOw6Bth/4uD45gsur1abvi9kqMMAN1FJ9/sw
         YyRWZfMB7Skb+2fxqY2Qnk5tJpWk8kr/+FGIVahxB60Kv412KfshJ64CJLXn/S5csVgH
         MC4g==
X-Forwarded-Encrypted: i=1; AJvYcCVm2zCmp961Ai5CPPYb8bbPdu9+SezQiVgxXPxLURpDoXuG2/bWcvx1HrbFipVbMsojUQKyPCzR8ETUKp4=@vger.kernel.org, AJvYcCVzlrA2IvWpy45EeA19ExHhu/lUZk5f5qelq6c0dl5VQV4MmvlX1vGFQ+VFp1fI9/jCdXQt6woL@vger.kernel.org
X-Gm-Message-State: AOJu0YyVRxIKbuZsfKYBLJvfGrGsTFmX0x82vHmtldkbH5bgdhclsXkH
	zsz61DS+qWwe3Ea6vuNpzrt4PHoTSe4EaTHhEvoGwnLmCXeW2Zc=
X-Gm-Gg: ASbGncvN0ISnjGvztMglPXwPbtX3C7PD/+1uzulUfSfEANmbzbmpm0GXn+EgatKou0w
	UrhF0qokgA8MkWdo+ZxMBb6K18L3FPoGrq1Ty8Lngeav+E6izxu+lWWPIMgsbKad3DA6Z2ENm1b
	qb6HrQebZh9rwWb3svarrkFYE50uDKF+0ZPUX+U4Y+MagjEl8nih+DyErr0cXTEUHT8UG2Mv+t5
	RFbz3gMNLHfCs7rR3TzUwDXBQsWVOH28fDSlE4Uy2J6xPQN9hBPU1zAoYpJXqqYb+Y14frgI0Al
	wpxd4O9gi9MOGq8VHmHmtaiy15BTPJmCzQ==
X-Google-Smtp-Source: AGHT+IFlWDbq2DywACRzxSiIgR4i5L1qMIy+ni8wBkhorzSVfjx85HF2OOLHbRUAT0vspR1hAVX2bg==
X-Received: by 2002:a05:6000:4615:b0:385:df73:2f18 with SMTP id ffacd0b85a97d-388e4d9c44fmr2410030f8f.51.1734523916237;
        Wed, 18 Dec 2024 04:11:56 -0800 (PST)
Received: from [192.168.1.3] (p5b057eb9.dip0.t-ipconnect.de. [91.5.126.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8046ca6sm14102477f8f.83.2024.12.18.04.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 04:11:55 -0800 (PST)
Message-ID: <e532646c-70b2-45c8-a449-841fb9daeab1@googlemail.com>
Date: Wed, 18 Dec 2024 13:11:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/109] 6.6.67-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241217170533.329523616@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241217170533.329523616@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.12.2024 um 18:06 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.67 release.
> There are 109 patches in this series, all will be posted as a response
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

