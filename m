Return-Path: <stable+bounces-183391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB93CBB92A7
	for <lists+stable@lfdr.de>; Sun, 05 Oct 2025 01:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB8FD4E1908
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 23:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32455246764;
	Sat,  4 Oct 2025 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aqo1KiFP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E9C2248B0
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759620928; cv=none; b=IO3FH8P4eM/36GpXe5KIj5Eh7OCXELMYmrUuDuxxHUTe7s/gfqnxh6cKyKfmy2QzRSDGQh2aDOvdhOzqaeQth1npE+fUwhqPRMCTBpMDW62OYrPyurLIIuXDn4KZ9CF3VqhJY19RF0laa4uIs4vG8WlrlhIyM9FAfvoPmKiCPP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759620928; c=relaxed/simple;
	bh=I0RuDAZnK67fDIvuvo7+j5OVjOlB6bei3TOSvnVvfzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPKQTYCCt86icl1b0sVIsjLXJ/HyIB3Vs/MI+LQ8xbouMzV3XSC8eGY8oH6hMqslfv9rsG/415UoJy/QfLE313cCQE57rPwHi4Hv76f/e/yPHtvt/q0M/PI9mSHXBZh8Ihmaycl0BALLeA8+op5S0zK/27weUPwK1cjrQ17U4nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=aqo1KiFP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso24982415e9.0
        for <stable@vger.kernel.org>; Sat, 04 Oct 2025 16:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759620925; x=1760225725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DC/L4mdd1OngyUYeW9NdFnDzBjfqJNLL3d9hdta1f0E=;
        b=aqo1KiFP+mtl1v6qmy0Pcv3Khkd7ksvrAL2vzQxamMe6iiWo4QBGt3LVB0ETrYzezw
         uyLXvDBP+YFOVKV+ahqIvyB3pWES84/iV7kCcVV94rnz0qyubRSEBPoeOSe4g+1YycFv
         pyXSnCtlosKyPoXtjxPYr1GdQryS6mNFPXx3S7RMORVeLyGcaigWnPk7NWkd5j7WDZN3
         nv8VKBKmLBVu1PGLx9gIMUjk8fcpYj1Xm9CF4TUisH/dqFTFAg1j0b/+yyqINI4YrRrI
         1vIxjDPN6YrA/z9oK+iaJFDPW1uUdF1ZDsDuT10XS37XsPt43+BoIFlA3b/q67LlF5Wr
         tnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759620925; x=1760225725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC/L4mdd1OngyUYeW9NdFnDzBjfqJNLL3d9hdta1f0E=;
        b=YMq2I2bNvouMbz4AS5wne/RBNKumQIz63F8LEndn/nZVDLv2P5aPXCWBOHNkwdjS13
         wAINgquRlVN8tfEkt3o7uqI6sxuO+pBr5Ra7CHhtG8KsGZZ2DwHn3UhfYvfVy9neBjMx
         kMWeAdBDTfgqWLYOxxOKuxDERuOAIyI/juGfFgLemyazbU0dljBUKnZKSA4qMz3yP5Kr
         18G+u/5QvakqS/XOCKK6Kr/ZXvlKJkXJnM3uMWUMGMuxN35g3HE2HIATfOXkoLJlUGaR
         24HmiH8AgEWujPmKQmUF9F+GGsF96183Ux6t/vnYXJdGFsqpPJyHniP8iMs1AqPGyRvt
         06Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVOJ/Qfa3XLbLNT+GWmOljrjaBxEYh3gq49tE5Ohspux8K3yoamT1dnV+jslQ4LN+OfF3xWSVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOBAXzwaJf6TBlY0m1xDPVgDAW1Y37pVHxW23AJ+tLg8VT75sd
	D0aJLdbRl1qMwoorxAzlKL84Cd8r/Z+VX4XQoDb0SNG23li27PipEZo=
X-Gm-Gg: ASbGncu6SJ78OcMCVcBnl5AjxaaAMlo7M2eqwQ1w1g6E2su8rlPrezoKfhaQtdszbov
	BMwQ91t/lTqbq5vJx2GtMelN2hor7WywJDfy1a49ATy/IFto54Ob6B+Lw46gmdAp9XVWN0M42OA
	73+NNSI26ZPfIyMeYJrtfQDDEpIMq0GAlzqXG8D0mnA9l17+Os+6K4QGC3e4MVQggLysmr3JAiN
	QOGNdKal10xC1LGfiQdhmPgQl1rNwGMfv/Z4UJgOvphwwt/88qyWAaUibffgwJrFoGddWf6qd7p
	/o8Sb8raXMdmV5vJ9hfgDncYEx6PtoZDkf57Pd5C6fweqhH5EjUVGTQltiqk/trcFzBoUO4HnkD
	onn9EOHQF78XTJTwJIVVUZUxGvYHiskcTjgeaa9iyQTeDfvAecPCxqYxhwQwix1KmlCXifr47Mm
	95lyvJKuUNUduVVPOLpXS/3xDm/U6UNvaceQ==
X-Google-Smtp-Source: AGHT+IEO4DcW8huE1gnQomQOCKiIhr0rA1gJSe5KrVyDYKI02dHKwC1UD1xOFCCF7g3I/MKtVb+GRQ==
X-Received: by 2002:a05:600d:438b:b0:46e:74bb:6f6 with SMTP id 5b1f17b1804b1-46e74bb091bmr25477395e9.22.1759620924472;
        Sat, 04 Oct 2025 16:35:24 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acd24.dip0.t-ipconnect.de. [91.42.205.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a029a0sm186407985e9.13.2025.10.04.16.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 16:35:24 -0700 (PDT)
Message-ID: <74e63350-4ec9-4396-9a00-4e257f987dd7@googlemail.com>
Date: Sun, 5 Oct 2025 01:35:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 00/15] 6.17.1-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251003160359.831046052@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251003160359.831046052@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.10.2025 um 18:05 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.17.1 release.
> There are 15 patches in this series, all will be posted as a response
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

