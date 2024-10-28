Return-Path: <stable+bounces-89116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 563FB9B3A53
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 20:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF89C1F22A20
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 19:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A64918F2EA;
	Mon, 28 Oct 2024 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Wpn2gb/e"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C221618EFF1;
	Mon, 28 Oct 2024 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730143261; cv=none; b=GyEO3ZM0Ow93CNbv0y/DfHrfKs+bISbe6Cz8znH3mRLaQmud+LUQuz13oOrA0d8jZtmv+fUjsj8fA5kDnJEYlguwdiPdLkaJR+PVkHkAlI6ECMDNTeOSNrxGm/dC3dKgI7LA+4x6nZdp2aGwaq+SgM1UBg/kpRtDkZzrlFaVlRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730143261; c=relaxed/simple;
	bh=F981mQfK+GakF4x7z8yIC7+kOIceY26cwCoUqATTl8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RyyfNb7qRD+9pQP+1UA0B5Hhqjn9ut8AVYTZ+xIFpyXYUUeq3fMMtKmAJ3srwjInZRdmexllE+luQqWG9yCbLuj26W/nRV+nai/SywjFX/7quwOtmphRNWKTUgMttUL/tPgH8yR+HMYs265n0WZ2MIlD+ZCPAT0fgfMTjrVOCEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Wpn2gb/e; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so43418875e9.0;
        Mon, 28 Oct 2024 12:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1730143258; x=1730748058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmyfLhJgqZpTB9dOyWQs56gLuQycztkSBu1M1yDh9Ag=;
        b=Wpn2gb/eAMB/2+wEr27/rIg8p2Fcs/6Oa9bTzcrgaEMMCzI61J1wV2K/o09HTcf6Ob
         n9j/IYOO2dDoiz1XQB23QDYJdcizG9L5VzAcU0TwPRBdAipsL43SWdSpTIKUqjwtpZnD
         zhbODrRiOxUrXMQMZpPuf5pLocBC4PoeLCoSsjs3GNbs+zi77sObU3vdszZDYPsMB/Oo
         UFAASlUtEgPW9LWbJoZvz/glRMeID7i9YPWji80qUN/6c9n5L3r3uOpb9foNRaUG3yYs
         brHtj0/HHiPzb2S0DjIkAI3C55aPcSjJDeYiRb19aTQPg4dlsxsaPyb4HSAAzJFtU3/v
         IJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730143258; x=1730748058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmyfLhJgqZpTB9dOyWQs56gLuQycztkSBu1M1yDh9Ag=;
        b=V3N5Tcd9WbLWT8Kw83EzV2Zalr691laGzHO98xC/Bdso+fmEXFYAhq5/2in+t1LLck
         mGDdsRiQGCQJ+qOQiRUuBdWRlpLexyYnZr+3dQ9Fe1oriqwtGciOTfPuZlPrdWCzR14K
         f37s6KqDwhv/hBrVoEN1GNXQY1pqqTv3az0yN124g/I/b6ujppICpgUDiNt+rmPFmWIl
         7RvbwFKipqiGtsqIDduZGqG20PZ26ay+eonJCMI+oTr+zJRk5XhFz2r8gECwgIJ4qIge
         ShkMFgxJL8v3kKveK2rvHjJqrlNp14C4GGp/2+an7cc2+ifnIYg0J2JC29cVs55OqO3Y
         YNMA==
X-Forwarded-Encrypted: i=1; AJvYcCUP3Y075nJy2AfwDHUwkgweRcz3sY8r+YKlkTAf315drP2cetJSyg/wqNzbLfpJunoBWr5Kdw5u@vger.kernel.org, AJvYcCVmDQRrDqQcFlo2ODIG46s/b++RscXLVOLrTmeEM/u0K66YUV4S745vRqeUyzQ2NqemrSQBtXuIPNrUcSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFN2pOXKxKZV3AWU59Y8w57ijkVFhXZ3m8NUb2q7JE9QvOBu9T
	7QlwZTLG/quXjvQU7kZcYCTtGR42FcN5wc5I/ka5pmIK6wYul2ukvqYlNUo=
X-Google-Smtp-Source: AGHT+IHdJPH8eCW/evibf4e02yyUQeiLZFkHgIBy7hWOQsM3sVPbez5w+tlVulpQhfUSmgb2F6Wm7g==
X-Received: by 2002:a05:600c:1d15:b0:431:4a83:2d80 with SMTP id 5b1f17b1804b1-4319ab94761mr79671595e9.0.1730143257909;
        Mon, 28 Oct 2024 12:20:57 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ace6d.dip0.t-ipconnect.de. [91.42.206.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b8c394sm10322778f8f.90.2024.10.28.12.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 12:20:57 -0700 (PDT)
Message-ID: <7d6ae25f-0ad4-47a4-a155-e3efc6d9ee1a@googlemail.com>
Date: Mon, 28 Oct 2024 20:20:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/208] 6.6.59-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241028062306.649733554@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241028062306.649733554@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 28.10.2024 um 07:23 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.59 release.
> There are 208 patches in this series, all will be posted as a response
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

