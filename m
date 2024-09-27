Return-Path: <stable+bounces-78137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33C7988925
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 18:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F4E281D31
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 16:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C9A173347;
	Fri, 27 Sep 2024 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MjU0fhvN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43F51C1745;
	Fri, 27 Sep 2024 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727454899; cv=none; b=Kf/VDCtIfT6nduokXxh8rCcXaUBLYQKCZWmnD0rEH/EpIRsZYYiiKcXhpmR+tt7JNyzqxBP4W3RTSrUXZKwlQbqR/yczmcuy21O1mxTLUSBUQzgWFoJpOmhVYBMQcH6WYS597v/IBOkUpIb2TH9VJMPLBnfbPPQY51VrwvmxdUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727454899; c=relaxed/simple;
	bh=LQoHedUqZJIVDPEPLGQOFF7BgCHqs2L4dazdLhVW6wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuEu6/yTvPllCZ0aydOlbexID1wHJJAnuj/N7nk7//wB9sNIJbZHFlCCblVjGFlkzIeKUa65zIhElBxi2/KrJVrAFkNvASpMdcjVh+e/EsbmlfPsDLZP73PA9pgo4BhuEJ8GqKgORJkDF4tCvTFi5oqBt871BTR7f1bJBDod6jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=MjU0fhvN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so21734435e9.1;
        Fri, 27 Sep 2024 09:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1727454896; x=1728059696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fjW0SfXJHHMpF74jkLxhZJc4kDdjeQmRn27IgEhzY20=;
        b=MjU0fhvNYNylrmw9xCHL8in4CdSAtJR6s7G8+NVPpVmCoui5VdffeRPGdc8SxifIDn
         NxGvmSbf/O2Vn9spdPVpJ/F+eY209409mYfFM3q40GZbyDsD15F4XxESoQ96ECZZcXmo
         pR5RLABqyAg/KsBRsNhdEaP6dpMS+hnqwD+F8BZ4u/NiFmgsLuRn/vgaLmFsZe9ulaV7
         huEaT4M2g6F4PWqcK4QZTVx9u6cZI4uFrqgCn8Z+eqbFE8yFtthD20jfbUNm/I1sjmjx
         yxq177rCaayK7ZkIepetkOXVZfBZY4wGTbjnMFKkQvvLHpTBUsPFqSxZNEM5rPva5OXD
         vL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727454896; x=1728059696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjW0SfXJHHMpF74jkLxhZJc4kDdjeQmRn27IgEhzY20=;
        b=iDsTPLB9ePqLSHeYznbL+Dac/Ql97vpNm/daJ4YUxVsJsQoClytXDVlYSzN7tP0eIr
         yZjKz2n4TuXfFj7vP8th8qWidd8iKCusEKubP2PSnWGpciVpZWwwHhIdrq1YUI/da7dF
         xINagS3p+/sHke+zwL/ZXyICaVRWx38RcujKvtEQ6P3ShJrfTZUxn7qjhfaRXGJM+34+
         d34qOSDDAeFBOTuOktLhh7GMxVTSEhC7kg6SbqUJ+pn9NBrEz4kPHuDMMYdWF00qfnuh
         HuADYf/DLnjHv5CbPMKdFV3us0FAHw0Ve+PXwZWD2XGc0YPkXeLmRjC5+J8RiLoLz1dH
         WqtQ==
X-Forwarded-Encrypted: i=1; AJvYcCViIJVHQHZaufN4m9VhWnUbr4QxYikJxk3FyOpcoMkE0/o1v1vf91I1QRnLFzLmrXFaXCPYR7j4f0OxG70=@vger.kernel.org, AJvYcCX2qFzz+v/ueQP7aC4vwGf8bwfdD/6iy+A7AHu5UY7JA5HSotpW2VsRsyulSYYgCjMXu75djvwJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxKw1mZf5YY/Ypx90GVUW84PIMpyP5eYgPPVmzQEhrJ63oV4xhZ
	lUzkQaPzhOFcXjpnIaQR1UOhP6aDqSeasL4i55xZLCPPpeid9zw=
X-Google-Smtp-Source: AGHT+IFUSNu6KjgVPgBU386pEbCm/OnFQdf54/K7kJsZSt/nXBGa5NuN/1bR2Y85UYvAUiHKqYDdZQ==
X-Received: by 2002:a05:600c:1c04:b0:428:10d7:a4b1 with SMTP id 5b1f17b1804b1-42f58497f61mr29413145e9.25.1727454895930;
        Fri, 27 Sep 2024 09:34:55 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4a79.dip0.t-ipconnect.de. [91.43.74.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d01esm3012052f8f.3.2024.09.27.09.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 09:34:55 -0700 (PDT)
Message-ID: <4f07f599-ef6e-42a8-8b21-b1a69f9cfb7f@googlemail.com>
Date: Fri, 27 Sep 2024 18:34:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/54] 6.6.53-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240927121719.714627278@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240927121719.714627278@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.09.2024 um 14:22 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.53 release.
> There are 54 patches in this series, all will be posted as a response
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

