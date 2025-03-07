Return-Path: <stable+bounces-121341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7058BA55EFC
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 04:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657E73A61DC
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 03:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568B71624F6;
	Fri,  7 Mar 2025 03:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QOoruGn/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF979DF59;
	Fri,  7 Mar 2025 03:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319466; cv=none; b=AUVBJXxPC+b/wLlpeXHAWa+Cnm5uq9vwOdizHdQ/9asWhHukyy5tJkKqWKPoh6W18ViWfvM1cWcfJ9nPEabdlQNykwN4P1tbhN+wYVUKSKp0UG+cV+k9SU/BtJL4yB7r/102fWsG8OD/ZM3CfgGwr9c2JQgSLa/xkOedlydCs8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319466; c=relaxed/simple;
	bh=6A6wZPfLa/IRgcrPXRsfSxNs3jDNMzsxLVMMdvEPVwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1F8TQJzdoHAhKBa8VC177ma1340WVxL4Q6OvRDYmJ78MwyeY2COxR1ls4vJX3cJsnEayFhhpgHFvh2QboSsisJ94qwRh7rMGZD/PWYRagCPVrKXGEnjLFtxexh34cqd3p2mR3ZOf1GFire6gE+E1ecUEZKdNb3TeAN+IPH7wX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QOoruGn/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43bc63876f1so11894375e9.3;
        Thu, 06 Mar 2025 19:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1741319462; x=1741924262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rzppPm1nBJImvG0nTyvZg/NFELuZGzODWqCodJYs074=;
        b=QOoruGn/PnztixPkF9taYO66Xdjse5V4M2fgBSGZeU9lO5iDOfS6tj776OlIANezIo
         PyTFcNUti4hFt0pfEoPK9XyjmS2ADjQ0XX4dwhkqeIpPzmXxmSNPY5aMRbibQIv6zzj2
         yWSnGC1t5jx8vedumJ5EmiCCK2gXGiSGex092DqFTpfheIvTlpgTFvOGz3UHs2W74dI3
         +LAnoT+6lVE2Ab7MgJMIB7xlKlr7+fqFmIP/ELWLolLZGuV9PP1st+aBVuhy+HxRh9pe
         iqimdRLMARpibRfMNsXQWsKptSaV3ToFs5G+dwYnQKZE3HWIIL/OOgELRgx4y2txNgfI
         vAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741319462; x=1741924262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzppPm1nBJImvG0nTyvZg/NFELuZGzODWqCodJYs074=;
        b=dN3wEXjm6HNS1wjOmcgxY6YlAzQeGIJJ6MR8Ml/aESRzm9M413JsGapyteLwQ3jBtd
         F1fi41QhY8BUL46knq+cIJKmlwuR6uqP1Yt3TZlIxwUVofzMgjaRC+NeBu8c1IG1pCxe
         YId5mL6ibpDh1NTeBjlCF1HCYUD8gkJHZcQJK//bN+tVwtPGVEYt4UtkeRwDmm4V6/9C
         fLbHKbs9MGA98rW24OA2K5/6p8kktQo/m3rpO11mDPzuQECADSTgeJYe5xr1srIkXtTS
         JHCWwKbKm4ZTWvokTnL/T5Do6iXPwyTwt49oA9VY1HZiilpnnEJUP+jcW8/filUXWimC
         OHwg==
X-Forwarded-Encrypted: i=1; AJvYcCUIVcaJWoQn3uUZw/VDHTz52+5t0v2hWrW6v2Qz7wfKmvgRIpF1poHp+xw7qSi6KwQHiyoBOk3a@vger.kernel.org, AJvYcCUTMVl8+FUvoXQm3U+kmaeg77l9e2NeOHvHYw+Ys/Yk7PGdkRsqtdc+riCl+6FioQsrY9GWgQQLUyWtzOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1RxVPwpYeNtqMELCraToZzSmJGSM3nR1Zba+NP01cMie6OZCP
	Bjlzzr7sizoNGRgY7rwYK7hKyB35FDD8Jn4dCqRxA2hj6J94OD0=
X-Gm-Gg: ASbGncsvUwoSbxbcQHpSXUDkwRjoHqrTzTO0KPcMZBC8VPbvggXGSh9TALE+5yaWmxi
	pXn+UEATZwReL7AKQyxhgl552IAV9fglKlzUbip+ZdBHd6a8ncSmz/tgGX0Ao7zGlPpJc72TL1w
	H1NYreO1wlzmBCFHRmCzk7mhK+8dKNxFNcJMvuaqi4ajUoHtiucSPvafsM1r6ur7l4v5Y8rRAnY
	ZblIWZU1j2LBZo4ZW6qiO0wQYnACWlUXqPtkKcFCazHz/nvj/kXaTgeRyHGTs5U3aEUVeZUhyZv
	bjMqXpDoh6LT+xmQ7SjaA3GiCGLe3afwC3yc+cNNdkfe1T0KUPK/sCqiuKslAol9KjF/RvCvyKM
	s2AehKkzuJw6ILnB8vB3f
X-Google-Smtp-Source: AGHT+IGTSc/ZTKJYPLzz096emF7HgPU2CoDwC5SL9Rk9Z5VgReE/fWMvUgx99d/bXdhOzbX/rGdDhQ==
X-Received: by 2002:a05:600c:1d10:b0:43b:da56:4d57 with SMTP id 5b1f17b1804b1-43c601d9414mr14276025e9.10.1741319461842;
        Thu, 06 Mar 2025 19:51:01 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4f54.dip0.t-ipconnect.de. [91.43.79.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bcbcc53d3sm70512715e9.0.2025.03.06.19.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 19:51:01 -0800 (PST)
Message-ID: <93d5bd26-2896-46c9-9c70-816581a84d57@googlemail.com>
Date: Fri, 7 Mar 2025 04:51:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.13 000/154] 6.13.6-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250306151416.469067667@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250306151416.469067667@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.03.2025 um 16:21 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.13.6 release.
> There are 154 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 
server. No dmesg oddities or regressions found.

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

