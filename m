Return-Path: <stable+bounces-107766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF4EA032B1
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 23:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B598188282F
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 22:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB4D1E0DCD;
	Mon,  6 Jan 2025 22:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="c853UHoW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877221E04B8;
	Mon,  6 Jan 2025 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736202383; cv=none; b=B663mKryYzUrH4PmE7DZVL5hVv5SW4xIGUGjDxWOuOtPwCS9Vj8Ivuu+Cl90J9u8g5CFfLXL7ME9A1VfCMUkOSUxTWEwE8yjpvFALnMLJr8R3kKLJM3cd97urYegjo89+HB1h5aQXJdTBdYUooPiJoG7vImqjvyyFxP5PIC28G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736202383; c=relaxed/simple;
	bh=QPketlUGoogrO6gvcVI+FDNH7XIiHg7ZiGSC7pjyZuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lf5iS8ckkQMc1Lg9oSPPouJ+endMSJqi/QXJ4+ZKYClq3jyHtrqnMiRFBkSh2Ox7RSS6VqrA92e+nXI9N8DJrLZhNFVzaJM4BvTGtLYn3rzQPDqhlu06Xc0hXzd1JH1io8HneK7YUrzinvPCnHgtlrSK+yusFH9FmdF6sfkg0vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=c853UHoW; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so27483743a12.1;
        Mon, 06 Jan 2025 14:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1736202380; x=1736807180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Z3+/T2NHIGuIM+e3D7sraUWaBgJ/Ro2wWDhtiomaBU=;
        b=c853UHoWMF+uQed8MZrWXnV6oC3q/FQMZTNcui3pNyfLsthFRcfV4obvnkFfdv8d40
         JEVSqKh26hyPzWLz/L92Zh2laGZxyf+PZmhKtluNg5L1k7OUr7bvQPeszMGVqbck+Xzf
         gWsEfP/vIanywe1vuRI6VhaMOWRcDdyBm9X4XHeuj1We7hzCFus0zr4EGzfAcXIzvw+g
         gQgHkHJybBDzNU0bDAakVB9fvT2JIrF9oKtaWsW3THvJ6cweduTMZu5vI4sgGP30qq40
         PiW/YcmXPgSvqa+2ncTyn979Mkq3S2HD8yig9IlAOv/YwPmqU2fOU4yEvFwaNYJcsDNL
         WQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736202380; x=1736807180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Z3+/T2NHIGuIM+e3D7sraUWaBgJ/Ro2wWDhtiomaBU=;
        b=TyTidoDr7/kGtYvEjdD4PzwpOhHB02dzHIbOB5zcaJiEg6r1O3neQxnj42txA8+Ns1
         +YvHEfNxH5mdV2hN+3fgKi3hcXKyZ9j2kw2viGbpsH9cJbNMa5UvIZWDODsIFaGqfb1Y
         pXbR8tE/VFOOa9uB72GjJnX1WGEU8sOJhV+p9Ri3YXRAvSeIhKR+zydD96VZ3ppkA68R
         amTfPXm3OOspIOcKz3wspvF21dlh31fQrZMnuV0Ti1JkCwAhAwm6nLsXA/c46FnXp3Vx
         r4eJzBx3s9ExPiDc8/XcUdawBMInDh8kgQG0ymWaNCg4x3dLHqnd2JI1iYVX4E5lL7iQ
         ERuA==
X-Forwarded-Encrypted: i=1; AJvYcCWSM/x0tyBanLxjBf8V9zllexR4RPluKG619JN9DZmP4dHB26/6iPTkEBXtrkXPqXx3420HktOX@vger.kernel.org, AJvYcCXrjqdf7g6Isifxd57CjiV7wblxQcGSRrevVQg0auiQALCC3yI46CDOKLCAjZWPjJxZqHw3zz9siBpi3kc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx/zYP+AtWokQmW/zfqrDyWMLAa7biS8BU36ifqz2zFLvMIv0k
	4Kpqp5qRWgePsS9vMDrdzI8jUtXnI4VRF2OWl8+cXhsz2ypyDco=
X-Gm-Gg: ASbGncugDcWxspxIsr7INr9tyjsh/dxICQK7QPxGaJC4FjppukFqkIkd2ufR7jWQD4U
	4liQCqS8egZTd2h4SJuQfYQWe60aqZZFWrjQbZ0D9QlmZ9jt4PsGoAgCg4kuvHlKTFae2BsQ4P3
	Moy1rE8tqpjdK1ux0ftcG9OprQDAiKb38GQByQ0DNmZRH8SgxBbwmUziDPwLnVko6STykcaIejh
	gnGS/CdjGaofqs+3+zT3xFJSzAaY0TNLmS1TZ1mzMPhFONBgOnMHu552pvhH61FmrzQQMaiCY+G
	Id78tmJwr1b+P1qRxQ9Sp++/zul3FV6x
X-Google-Smtp-Source: AGHT+IFaOV7bYOqku3p6kglihfNLiGCsNO9e9smxJHrIGlbUaipg5/cpBSDu8juWzNus67twom/IAg==
X-Received: by 2002:a05:6402:3206:b0:5d1:2290:c623 with SMTP id 4fb4d7f45d1cf-5d81dd83dc9mr57270688a12.7.1736202379632;
        Mon, 06 Jan 2025 14:26:19 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4110.dip0.t-ipconnect.de. [91.43.65.16])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80678c8dbsm23417043a12.40.2025.01.06.14.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 14:26:17 -0800 (PST)
Message-ID: <3111ff33-f859-4487-b5a4-00996e971360@googlemail.com>
Date: Mon, 6 Jan 2025 23:26:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/81] 6.1.124-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250106151129.433047073@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250106151129.433047073@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.01.2025 um 16:15 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.124 release.
> There are 81 patches in this series, all will be posted as a response
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

