Return-Path: <stable+bounces-207952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA47D0D447
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 10:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89DC2301F24D
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 09:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1D135965;
	Sat, 10 Jan 2026 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="dizv/ttv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6292A2BE655
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768038843; cv=none; b=e6yQKLqNBJMkHYGHtF4++a6RzeM8sxJWBQAsPvjbyu2GK0Qv9wxiKvFBlnN5+HwxcXAzqNU2zr8GmetDgGOQwosifocVOD9pJIMFU5e++Wp/1wcWwlv2U/FQIdeOV918/NKjkqZCqXIt2aXfSg8JhT5YIZ1Oa9ZoM1vguURN0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768038843; c=relaxed/simple;
	bh=yL+5nDlRuP0DDKJR6kMiVZMt2mnQsVcin+5neQ6LxoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfRf1P4QVKgNyClvrP7CJ3RGYGK9TtUGEEIB5nVcXh/AEaCBScrsJZK3llqKEfy/16q7DOFazfikPfVSErg4PTpg+ckw4BgCaq2Hbhj53/gj45RkEV7OuR11Oio4anajl07AfEnjZogew3ZKvWLe30PX2lwy1CuEyD14g8sKRq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=dizv/ttv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b9230f564so7148568a12.1
        for <stable@vger.kernel.org>; Sat, 10 Jan 2026 01:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1768038841; x=1768643641; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vpheX/ey9FdByEahZt7dUCBS3OYWKh+3lgetnYEvmao=;
        b=dizv/ttvUpwm/Em1Bp7CmdLbz07rlcZ1PAlOshDCdBg5LdvlgEvRdh6qoYE2CRpseG
         iHXIM4aErZRzadBBAGcdApE8mSlY9Za7FJch8tInKWAr/gLy8d91uSxbfS26ufKYF2uU
         dogJ+qssWbF+l9d9hOOcpFTok70bRyrQ8aghqmKNi+3sCXidm3eJUiLz7zfe6RiM3Jmj
         Gh+BwfTQUKpN/+dY9O7cgWY4uiySqXHanqhx2yR5I1b7ayehCiswlxsPeAMtIK/pmSFK
         2IiWYnVsUrDv/T+rA1w31JgSP30A/wGRD2tj5mJkGuJ1k5dsOzLV/qdGQVhtoBw/76YF
         Qbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768038841; x=1768643641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpheX/ey9FdByEahZt7dUCBS3OYWKh+3lgetnYEvmao=;
        b=eUHpJM7KEzmcirFqDBQhbD1iDKS6d9jDK4dQKRJ1OPyslqum5W5fAxGQJ2JYrP1j/0
         cbVcwIdUMDGFu8VWpOg5Oy+xECQEfe7q1OpmnM3zH/JM/r/nvW8qCOmN8N+a+720VuGb
         qjIn03vSmYeTEyG+FrGZxy8WFKonDy0Ha+HZCOlZKiVoPIJqcSZfV6tPb6foZqAfMJri
         uWzVHUmHIJFJ5N5P90Fc6wjvUUhm0o4rqwjDmIpTMgj+T4I/KVypvy2u6EEXrMIN13/c
         S+uCCR+ideKRgEyl8wsZ28wrjB6OC+IR1+R6otAwieakvajjloZtJ5OHYeBCXYqApFjV
         NxjA==
X-Gm-Message-State: AOJu0Yy12KQKCCxbBBiE/R8crIF5I057fN544B+6VkcitMEFhJCbN97P
	omJKvlNfKK41gYi1wgo4omdecmeavlY5JiB/0Wz9irSHmTcxt9UP0Z7a9rMm2ixSGK1JqJNF/mq
	d4xXouMNdSirY2rKmXIbJuL9FIJgtGX43okJyEhSLLQ==
X-Gm-Gg: AY/fxX4hIdvPNHz5/GdwpK6XmfMAIVzZM8LU1rpNpuvLd69olxfVo8WCoLj0UWzZ+S+
	48jbGC/3aZHYEsmwlrxLqFNVNEdev6t4bWWBthh3eTT1St0tT6hlO0XuWD1c410deDg6xW3+7Xw
	xk4rTutJ3/DQjN5ObNmCf5sdAqCb7npz9F5Dv8NgHjsRfYeOIQfUO41t8rjVbzYU55MHsG6TY1r
	9KewJaKaE4MDlsD7bSpWKpTtQCohkxhguYB/ciL12zUPhBbPxGcjCwYmBwdQDwmeaCdks+J
X-Google-Smtp-Source: AGHT+IGURXNNrj3WuTa9P2rOK93sGBZtBFjkgl0j2ENrDSP0o8OmoRnsi+DfVENA1fiY6l84H5lQQwXnfRapuUaFCQ0=
X-Received: by 2002:a17:907:7fa5:b0:b73:8639:cd96 with SMTP id
 a640c23a62f3a-b8444ccea89mr1181718666b.24.1768038840793; Sat, 10 Jan 2026
 01:54:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109111950.344681501@linuxfoundation.org>
In-Reply-To: <20260109111950.344681501@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sat, 10 Jan 2026 15:23:24 +0530
X-Gm-Features: AQt7F2q3IZTmlvbj4-K7nkwEjAM9xMP_OSy0LpooJtrgBLok0IruzPdn15OyjPU
Message-ID: <CAG=yYw=UXQHH4j2vaPcMu7XsKRLm6HVuTHZW_aS5d23bLpSE1A@mail.gmail.com>
Subject: Re: [PATCH 6.18 0/5] 6.18.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"

hello

Compiled and booted  6.18.5-rc1+

No  typical new regressions   from dmesg.

As per dmidecode command.
Version: AMD Ryzen 3 3250U with Radeon Graphics

Processor Information
        Socket Designation: FP5
        Type: Central Processor
        Family: Zen
        Manufacturer: Advanced Micro Devices, Inc.
        ID: 81 0F 81 00 FF FB 8B 17
        Signature: Family 23, Model 24, Stepping 1

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

