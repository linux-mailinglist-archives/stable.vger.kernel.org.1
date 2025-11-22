Return-Path: <stable+bounces-196595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AA5C7CC18
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 10:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A179A3A86B7
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 09:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAE52C3248;
	Sat, 22 Nov 2025 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NKYvSKC0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062FC2DF6F8
	for <stable@vger.kernel.org>; Sat, 22 Nov 2025 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763805431; cv=none; b=JaIBEfBZvWLh7C6nu2uy4RmFt8FxXWaJvJPKi1YPrr0Gj+F/OqQpaCO8U2LtDDexAfusHnocGWI2GWzDM+QdHS+g68kLy99yBEiQxjU2Irgrpg8e0DDqRTJVAVL0hNjov97/sE7RNEe1JvHFQu1kJh4fwOvY1kHjHpX/njSIwt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763805431; c=relaxed/simple;
	bh=jNSg5IwqslMSi7flsNhYhvjFu30bVkFbwI2qkNAVHWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jk9Olo+wKtW25X98dtazdQEXW3aXzNvMvcfg9g06GXwMjEfBtC+jJN3GbFvINOiDWhpTizdPPE6dv/EzVBmBfZ18X+c1+FQYR5xTqbHmIisEfTCP7cgnIUuOSWeaxRac6RXdW5jFxDLVO4R9ImvwoI7ZF5Bi5hYjmxHLia2uepE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=NKYvSKC0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so20343465e9.2
        for <stable@vger.kernel.org>; Sat, 22 Nov 2025 01:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1763805427; x=1764410227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jz9kXapfXThQBJmIvVtPBo1fqBtdPm5tbxV+npzEXp8=;
        b=NKYvSKC0xOUQnuBl43pn62dHiaTsmJXlllg+Sl2fNN/z4osOiBGs+AhPgArniCU4Jz
         UQ4PFplHNPgEXGsef5Br4FvnBjFYAE2mmRkNE+RJRkIqLBXNDFPlHJRR5V62DVxc3qDc
         tOuyVNuld8mwizbpvMlSnHrNGglCWgo7wx98UKYT89wXh2/kKohLPU1gQ0q6I1nRk3o9
         CwrBrjblCy8TkdsdHRiIPaAhRiJMI0WwdS13P+Yt9PPL3VlTWWWaTY0KmMR24GUkPkDH
         K4Ogws6P1AC5vRM7pqG+HaSaGRvQ+Fc6g/npO8eZHqY4fUB4RkjeBwsdh3XrpA29jkyw
         Vz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763805427; x=1764410227;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jz9kXapfXThQBJmIvVtPBo1fqBtdPm5tbxV+npzEXp8=;
        b=Jy65ZecW494lJPWECtM6GIJnSRqoRhjK0A97db9dX45baxS10SBb4KCNBF09ZgcSoz
         mZsXYzE9DOcaLrZq1NhflEzvH1IcsTJPLyK18JDdE7/SVJlqdSEyzCcWJH2aEtjkRPdU
         WdkSsUDcc6862Dch/3Nm9pdfiY2AYcMPrnFUOrFnui/5Irte5Gv0hzcoWkKo4WPFtQRn
         LaXxHHsvySyGuMXtxSVHT/FDVK/ODK51jx5cUbQaxw0HUxnqozb5jS/BjWz4E0mF6in2
         y0hpl1AZELqewwAuqcpT0Adl2wBa2v4hzNpw2Lgds9EalyywCmf0deILt66Y1IE7NV9a
         d5aw==
X-Forwarded-Encrypted: i=1; AJvYcCUHbnSdA8hA26m2DXi5ChzePFzLeG9RWjAh/gb3qNdn10HnKSR2YTVkLU5+BvhI3IiXN+F1v0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3KHdJDeaKOhbvWtSpe7tu69Tc0NSjMSLjaHHlBl6lI3V9s1QY
	e6mt8IrmmIgWsX94EWusc3hqQaC+8lLaKOmT/OJQ41DQvvyoY/38bY8=
X-Gm-Gg: ASbGncvuZ4didaogo9YiqbPSJOAOomiZ3FqUZFQPhbTR0KjPzt3H1FT1DCpM4vRxMnU
	3SPZQHlBA3TNCZPHt8l00N1A0RQni28qT1USBTLvzHIRPs/KVUACbKBjseDgFkYNxT9l2RneOBV
	916P0gLCZxixZGlvQw+beLLwMEWqwJ3WjG0WKtM7HkiV2oJRofQ41iUvntax2Q+KkWTB+4BElxB
	dSIdyi8GPqHApbBJCB+eRz52zfL/bnn7UVqqPzj94qPCJp8TuwKpDG5lYsfXMpXtb082ycbcdUT
	W8h12Cm22tr+UPaLTYf45tcxNIWxY7EJ5tRlW/ff6b59pEFq/QxeTjYYv94YwLV63uFs4w2LyPI
	mPT7S2ll3hTxOvW9cahF6mJ1TGV/RJIORCzNvpEzX0aYYjPZJBY1Kh9XhYqgLQRel1+dOY7boIN
	4SB0z8VCG+qhSMkixc//M8kb9Is78DGL2b3JgECbOXmN4nLl/vZBqDwDgeDB0vRw==
X-Google-Smtp-Source: AGHT+IEF4X4a2a0VmDD1A4naVFLH+o5kC9UOh5bWGAlH7UrcD7UF2ip4OdVzuxLdO7IUKVhFQ/S5Dg==
X-Received: by 2002:a05:600c:1994:b0:477:a9e:859a with SMTP id 5b1f17b1804b1-477c01c0073mr48228515e9.22.1763805426989;
        Sat, 22 Nov 2025 01:57:06 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac108.dip0.t-ipconnect.de. [91.42.193.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dcbca9sm103393785e9.6.2025.11.22.01.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 01:57:06 -0800 (PST)
Message-ID: <0dc36230-e5ef-49b4-95e2-e9d76d7eb871@googlemail.com>
Date: Sat, 22 Nov 2025 10:57:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 000/244] 6.17.9-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251121160640.254872094@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251121160640.254872094@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.11.2025 um 17:07 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.17.9 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

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

