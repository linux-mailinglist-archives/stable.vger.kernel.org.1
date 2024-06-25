Return-Path: <stable+bounces-55766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E271E9168D6
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 15:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E317285BDB
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 13:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A0315ADBB;
	Tue, 25 Jun 2024 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kqMV6DWA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33051E4BF;
	Tue, 25 Jun 2024 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322263; cv=none; b=AqUDnYteBLRt3rkr0sg/E2j6v5mCgoJTThYqcWMY7naHJb9JHChYHpRgvyujBXzYIsxz8p8zjV/ormrMYs3LMGaQnJ42qC/shuzhU78KMssvRgsLBNJ7TmS2pOhJQTe06VZrra9Az++UuKg8CSHkaZq9TodrGb1Zb01NgjUDJ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322263; c=relaxed/simple;
	bh=o0udTKHZEk0pg4zJtJ33LRzt+kH4A8KT9v6IDXkPB14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNkYU1EjJTrmlUEBqMdIw2/XLnDPqNqC240etUqI1RvYZZ4h3pVIhb+FLt8n4WFQeOU65bcoBLlZgF/jWI7WLBa61r1PWUEOisFSHy7H/TZTTufuYDIwoRhDTb3Q/iNPx/v12draWB6g7o20APKJNNVhsEHPybFfxM4YQ0qlTcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kqMV6DWA; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57d15b85a34so5812939a12.3;
        Tue, 25 Jun 2024 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1719322260; x=1719927060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jCPI9zmJcO9n3warYFnR4HzozQlCIFB1YY1JSHQ5z7I=;
        b=kqMV6DWAZevNI3A6+V4WJL0snrrcutWJw9cuMxRFPUMp7ZxluYZ9SHScjH9rIo6awj
         p3egBkIJMqnqxsrJjaQd4kJacpJtUzakTRCdu2B9Eel28DpYjvXVLTb+sGtAEjk1vD/R
         Xp3lSZW4M0mczAEKPfyZwGJBbpV66/3+uAlY67ec9ejQ1YSewND1oLzCNhpVT/iwSyRT
         1H2qR40nU89XOpfDLb5yXIIVBTNa34J3ffjB/OiMpeYtPZ4UrrkRZaLWXTGLYPwT8ETu
         LsBjKuxssIaoRj2fmFpbK///EM21EcfUoe0i2AhWDsl8KO73to/g7lsZmIR8h/BZsPPy
         oKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719322260; x=1719927060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCPI9zmJcO9n3warYFnR4HzozQlCIFB1YY1JSHQ5z7I=;
        b=C6EVnIA3W/uBTPd60lnXZ0W0FjwwjLwIhk9gJJKWfV12Fw1LZn1JP6JlzdBoolpKO0
         64vKHcUYaiS7WbqcWbVvf4b8dn6sE6ple/5eJeLu6CcSpBU7aiadDYd5tLwIlDxsKrhh
         kRI+9yBi465eRQup6fShU+anan8wzCXkce0lZ2h2T+K27E9qfo6KN/bTIrl8Tmwnc8F9
         aZb76gYsMfSX64+ngDEniegt3sqmoLprtpn/1HJDyJ21nhp6MFApZHRFTyl2aQ2TndUo
         17aT+BpwblOVXJRMM4jo3ZnZc1G84HxdUuzjYepPBCLNMsTime77RJSM21szK7PcQRXH
         qNwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/6eFRagx6cPcQISNDfxzSmLtpjCxTeYeA/zZrPQe4Od2eSHvlFtG4AdPlJejZvUNtKAcxXZ2inBcWCRSmFvJBQjZfmJ9sNZPn4WzhymHxZiEuhqRNEbyNZhTVnFf/Q1zX53M2
X-Gm-Message-State: AOJu0YxrETMjr90MOVibFSNqc2gHQrppkY+sZulbcdymp7b/eATKTRz5
	s9rnadaGSmkk1hu8WSjOCJjCUnCqgiVgVygLjFdH/bMCUECYG/M=
X-Google-Smtp-Source: AGHT+IG8IvhbNWQyXNXBiabqfJKUTBxylBnGUaRIv/YzGLRkZZGtz9/ovU3Wq+9nBRyusriSfRd5Kg==
X-Received: by 2002:a17:906:c096:b0:a6f:86fd:72b8 with SMTP id a640c23a62f3a-a715f97972bmr535116366b.42.1719322259708;
        Tue, 25 Jun 2024 06:30:59 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4a32.dip0.t-ipconnect.de. [91.43.74.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72452140e0sm315467366b.217.2024.06.25.06.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 06:30:59 -0700 (PDT)
Message-ID: <971a36d8-b774-438c-a4a2-e2d35ae9495b@googlemail.com>
Date: Tue, 25 Jun 2024 15:30:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/192] 6.6.36-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240625085537.150087723@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.06.2024 um 11:31 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.36 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works fine w/o regressions on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. 
Nothing unusual in dmesg output. Running 16 VMs in parallel for an hour now, and am 
starting to compile 6.9.7-rc1 which I will boot-test too. Everything works as smoothly as 
it gets with all CPUs at ~100%...

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

