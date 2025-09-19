Return-Path: <stable+bounces-180593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EE2B87BE6
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 04:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BB77C8319
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 02:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607FA248F73;
	Fri, 19 Sep 2025 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="X67I+gOr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7A62512DE
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 02:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758249970; cv=none; b=A7t9tyMiTkTrNVMkorCFGsgr2iCPoLkJtsEDDX0Rx1znkOCb0+O0BuboxjgvabwGXw48COv8S84TcPoFNYvQT7ZG6PMoD5ZKCBgUKvFmbLhBg0I8K0jHjNRz4NUA70+4t1JlYxJ2b5nJ32um49hKkmtshijhb3RTt9S1ShpNG0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758249970; c=relaxed/simple;
	bh=C3rJlPeakNHxNeSRxvndvY3Bl2Okug10Y6PTrK8S7+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJp0t9v6DUIKKQXePiaRQEc4H/N2/JMzwsnaTfSbq1OeSO1wrnSREejWmCJFlZhXIHjLVe+PxnlIbzdzw1rXi59m7jIpYGk14dePUnZ+5HErqSkFGEB0VMqOvNM4LYHyJzdWR7SO5ij6haAmFI2g8/H2NuJAG7J6FWGUWwS6R+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=X67I+gOr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45f2c9799a3so11422505e9.0
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 19:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1758249967; x=1758854767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RV82iQeoL7J45auwt67Jr/9GlmlJe4+A69CPPiwNB4U=;
        b=X67I+gOrOUE2WkEHBXwSjsVAYvlPAiClyKC/J6H6NO30h9gCaP3ur6FkV8L6Jwf0PR
         KuFBZNpMN9PcRecqvnFfD5hHQUj74fwUDzXQnxOgurvjyg7I4HqwRJg2IUlzm6hP3TXO
         NEYM95kSDlHXxNWV6Q8lVfyWKxQCM62IFDfDrm93767l+uLHwnu0GM9RufzckHn9Hl5u
         qLkrd/atKIYyzc2NmXrMBaoBtO6XxLdyMTSNLwwp46/l+HyTHtVd0di8T/EvYQPuw1he
         F4wz+ahcso1QbcG/GjkBdCD/QH5fSGqbM2hQIkGHvr9L/xZm3AsCuUf3XiJEbJQ4ezMG
         siCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758249967; x=1758854767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RV82iQeoL7J45auwt67Jr/9GlmlJe4+A69CPPiwNB4U=;
        b=vrdAVQiz2h6TdzdUGvve0MnN3lY+PO+GqIHYTS+rKe7Byb9Q8U+YWHw5pyD7q2rP0z
         hlimYwTp9vXn8pFYX/dcAdzqUSaCsJ7r1fes8x074xUBj2ukR5IyiAAOg5EAADUKE4t1
         ZqIX2ocRoiokm/uPPM03blwHQoW6FpC50HKTkdnJFONEhrxdIodMb3VRKDsA6GOW/mQB
         YhjpLjxJojrK8qP0ffWDVIaJJfmgk79RcjWLaF1x2JnnUsvefW2WGHwQZ46dT5camOQU
         hcyE4xJQC4RKcAHcxuLewTZY9CmCCnUo7Y1qY5W6tvJbbt2x5Py9V4wL+miaw73O9XVO
         oIQw==
X-Forwarded-Encrypted: i=1; AJvYcCX9h7fz01riFB49tVi6PqbBS9W03TpycZzaMZoPY/+JDtvedxH0t5H6g+F11iXa4mk8fA9INrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQyVOuhNmAsiMOWtImZWefOAp/5/UrthyfeFowXbcraQatOCK+
	EontPAAlOSXetDc76cAMCr9x0bYVntsh4Fu77t68bHdB5o5ewUXS970=
X-Gm-Gg: ASbGnctdEBvdjXjS0cdtlZcudLBjMa6RY3LZSaEAbLSD1PdyhAK7FT3iEv8yoU8rHC+
	vDH0cN6VIn4bGPZBb025SBR4prhgEX07WRSl8g+33pSNlI1tDnzOjBWClDJkkZhzAhy3h2gb1ll
	GRJdQY8bg/ZKuP7Ywidll+CZ8Tn7jy2YYiC8PR6UjlP3X+QADohzkuRy6p3tQCu8nnUH6heESuD
	PsPtG9+OhNPOd0buLBh8sEkmEtamkDkLZKmGuTB9pjx3VCJD1AeAhOPm3AxZu1fLouTNv8l6/MW
	iawimyyDNzUUoSusf+P2ffIujSs2EqPEKLbgwr+kY4LJ3gO/ZVhMNkXW9NMSKBE36jfAg1eKk1I
	XO6b1NEumq34FZt1q4rQhrCx2Q6uHvBUgziEyEvEIRyPm1xAhGdJwnTI6dskpr2iohnOTJqD5Uw
	w=
X-Google-Smtp-Source: AGHT+IGgQuGA3pdRA6O9frETa1wvqCMUipxJgFmb0Z1HCL/sLjXWcSHn9dqNe7Zf38rm77aViWLBYg==
X-Received: by 2002:a05:600c:1910:b0:459:dde3:1a55 with SMTP id 5b1f17b1804b1-467eb0454f8mr10603065e9.24.1758249966425;
        Thu, 18 Sep 2025 19:46:06 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac915.dip0.t-ipconnect.de. [91.42.201.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-461391232e7sm103225465e9.6.2025.09.18.19.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 19:46:06 -0700 (PDT)
Message-ID: <f7a654dc-aac0-4898-b07d-c6b46bd4dc1c@googlemail.com>
Date: Fri, 19 Sep 2025 04:46:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/140] 6.12.48-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250917123344.315037637@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.09.2025 um 14:32 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.48 release.
> There are 140 patches in this series, all will be posted as a response
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

