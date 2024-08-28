Return-Path: <stable+bounces-71366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E4C961D8D
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 06:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF673B2146F
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 04:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC11C1411DE;
	Wed, 28 Aug 2024 04:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CSfx0Vtt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE51249638;
	Wed, 28 Aug 2024 04:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724819056; cv=none; b=C0vfWWlIVVoyOZL+OEXQweMV0cuuCgCUbh8QuU0MgCBjQJl4FRwiRPgyi3JPPgLdhXxJGG846vlpkz/A7KYJKhxL8MbYNr4SfAXwGneskCSlxoqTR2BskzqdmfIGOdFxIKym4wTNaygkz0zltDKf+yDJXqLypBiUqESG5dFxCY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724819056; c=relaxed/simple;
	bh=iSeEtXxbuAC+6rlIpyEzQw5/FyLhOZ+VSNh8g3YqTnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPMPT5kQbPDQGlbXnDuFo6V93kvMU040OgrxjlFPyRu2UmOgVnb+FV68TFYkV+M+x6GHo+gwoCz6nIl5hohsDgz3IX1pvR204nox4uSLUTVaU6TpsOBdoHmCduZoOYatyER7QLBr+6eP3BivmndkHsnIca0oj0uufEUi/bS7fiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CSfx0Vtt; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5becd359800so6911921a12.0;
        Tue, 27 Aug 2024 21:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1724819053; x=1725423853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gEp2WWF6uAzjFpYV8RUuP3nwjzanyudW6qAn5FJB6WI=;
        b=CSfx0VttF80XEh4mHk+j98hFwROYvsocl7ijYiEK2r8SU7jxuhLNVCHWZYU1jFfk6S
         ql2/FszngQrb8BSmDDDsqhdG+Xo28UMVdtra/clUTulWewNnsn+F9HX5C+6NBt40/PmY
         CfkaXd45RdXqyXVwbYB1M079PuEnIkJzSBN6WAD4Lh+aEV6uKJ+6rr2iPYHeWp/XrAMY
         FYopCGxjjP+96W2ThTvjrG2yr+WjR8l0JndrjJuDHmMeI0H75DfXPOMrC2+KL7Bax4as
         Gvthb4FHQI8Gl5X8XMeZvlYGfuV7C/SCglLmWFwLn0iEYvyOvRz47ml8SYVxQiJBVOwM
         imXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724819053; x=1725423853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEp2WWF6uAzjFpYV8RUuP3nwjzanyudW6qAn5FJB6WI=;
        b=YPK+UJCt8J8LiCRou2PdtFYZ9ejJOxf3eAPpmXi/xpoUuRjD3Jm3juvXitt1x+MTpY
         j+t1v6Nm2bE5CqtO/IqChuilSvewET/Nhy8R0aXnXFWzUr66P9cXvi3+G6vxC9GY7I3D
         34+DLY5lXk0ADuL4nzJagWfm5X1WEsiOWENkixbl4uzJZ9FwVTHOrrxyFh8cmXuoBBY2
         hBY/g422NTaN5iU38TYP0WpJX5AHKqf7BA59bLPWne6qG0m2KY1eDxAcooDOg4vpa2qw
         LVOimLp2QaYG+6euJfUFNoJa7IpSluX/w5GvwQtASKTLZgg6fkF6DL/4518y33Mm9wOP
         slRA==
X-Forwarded-Encrypted: i=1; AJvYcCUH6ubmvdQ+1KOvGtyRXgyfzFL3tkdGO1hCHG8iq3DxVspmSpIJkyp/3kggy0pP5i8j4RduNLbW@vger.kernel.org, AJvYcCV2sG1QXo88xB54WN9FFY+5IoNWdgKuMlI30WTmDFEl5NR4aYa5N23iEM4SQnbXv5avl1fjlvykHHAAKrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsYmDCqnXdo2L8pV/WYswq0qOwFvndGC6fyP0mZaCx36iZni9s
	8SfG+FVnwnS1sTTMFJV+cuRdkVSdyM41GCTQ6Qhm2TdGlFTHbZk=
X-Google-Smtp-Source: AGHT+IEyaZZUdpDX4j1cUEdZP3kE2zHGP4i7DiZMfhzfMv4yWPXAK/wgq1Wo3eQ8OlE6Hy+UaWG40A==
X-Received: by 2002:a05:6402:348f:b0:5be:cde2:861d with SMTP id 4fb4d7f45d1cf-5c213dc0aa7mr469172a12.13.1724819052764;
        Tue, 27 Aug 2024 21:24:12 -0700 (PDT)
Received: from [192.168.1.3] (p5b057ded.dip0.t-ipconnect.de. [91.5.125.237])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb4722b0sm1703477a12.69.2024.08.27.21.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 21:24:12 -0700 (PDT)
Message-ID: <fa59f2a2-a8c5-4d73-9819-f7ac6350dc8b@googlemail.com>
Date: Wed, 28 Aug 2024 06:24:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.10 000/273] 6.10.7-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240827143833.371588371@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.08.2024 um 16:35 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.10.7 release.
> There are 273 patches in this series, all will be posted as a response
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

