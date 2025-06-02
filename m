Return-Path: <stable+bounces-150609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BF9ACB9F6
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 19:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4EC9188C905
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F3E1E47C5;
	Mon,  2 Jun 2025 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mxZeGWPV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6780F1474DA;
	Mon,  2 Jun 2025 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748883845; cv=none; b=RjaL6QS+AjX04qkcYM74Jy3QYz0AnHr+Zi3U2hz58zA2sSvs1dvJXhUat5E39x97F2kTw09MNBXeeybp07tPwxB4me3+cg4Vf3dFR7SRRdUJ0Ynm+pLGZe148G0yt1sYL00mvbq6EYRYdtTAVhogHL5pCzikDwwrLFH0HwwtJnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748883845; c=relaxed/simple;
	bh=hUM1rSueXNPG2z4TbKpz+yyrCnJRj9xQ1ucUnrafPqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STTETMPGxhqZ0CSrnWlAHNrXW38xcdtrZLuYSCch9/wjlRu/CowGEhfyTIbDb47VQPbb7E96bH9jpz5lx66BZDbXGqR0WGkY5mJjNmxj6Yy5lT6OTqQcr+L8w9phT+zlfqY5eObYBzVhO/vYWUjAEKnK4yqSLqTONOjQa8N2UVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=mxZeGWPV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso31933285e9.1;
        Mon, 02 Jun 2025 10:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1748883842; x=1749488642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uBzKhGymnueQy+IcY/pv2XM4m2UQRAALtJoAmfofrhA=;
        b=mxZeGWPV76thUots4eN0eh13bKj6bHpr9Nk35W5Z213rKYEq8dQ9eZSqmmQVUc5HFF
         ustwLRo3FjWKaUwdJkzVZjZRJKhjwutttBdlpml7jSxlxG4rKSS2cxOfeY3riITHl79y
         vsjaGFvSmW8/DIWqkiebYQTb2k0/xKG98agkJoymgxePRfRvqBnPw6oWENasPu8bD77m
         v+Xob+cQefsEX6CmScqjNRzQmhxRJHnOJx8YJ6V2DGGsj8axQ0NCXfKoXhVoSH5v4Py6
         dNCa0YP4gj+8uuSO0tQhMFgw4SM00WebYKQaU/m0XIn50F8Wwm/F6xV7KVgtx3i6lXRD
         7Heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748883842; x=1749488642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBzKhGymnueQy+IcY/pv2XM4m2UQRAALtJoAmfofrhA=;
        b=kqJjAVkkG4FIs25ojm9lyEroIjGkwXWvUjGU8QYKDn9fS3TVvXDEIyo56Gf60CXNXc
         GUvHc/Oa3HQHCzHlz4TiqwImICJ9EFJUXu1i3uqQk2GbqvMJZMrzGpqzfyOlcGOYXtRB
         2z9PYvlq250W//fvTllM4h46sLiZyR2GTxgYLpMkiVbwu2KANV6z7gGei6fRQYJO9JMV
         cbrR/OaoHtzve5KpHhgsEI6lWtk7TgoMKyE/cqsoJxa4z6DHAusm+dNm4y9s+kgLzRJn
         /OsfTcI2AYysBBXW0oFgD1noZvjq9inysuDJr6k5Ciwjg/wO+t3cztUJRbakjmBjP/HH
         9oWA==
X-Forwarded-Encrypted: i=1; AJvYcCUrQRF6NHMqj/bdji2PVl2nWrVAfcUO0ILekOrTRY7dYGop89wYwNa085hiScprGtJSsAp82Eie6E0DrHY=@vger.kernel.org, AJvYcCVXDs6+n1FAhk+mWT5SIfTUmaO1ftKD7ZuJw5FirYPTRK2XKV4Z+tBBoPXLHsr4ieD8OCbYNsmZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9/qR7+q/UMxFntN1Ty6fdeXDDCNYK0YOB2Ky6Sm/jJ8FmplQ3
	eVBvQUZxHyt5agTv2mzimxSdkImlPX9wYXvPLHJ/fN7t2g4x8xuw6ZPgl+qmQB0=
X-Gm-Gg: ASbGncu3tkyQlx5wMVOaQu148JubC753Nde/VWEDbufUupOoje68wptlIZleSD1Z10N
	wuiFi1DGKIYyCBn31XnA2p3AlUiKaW2vs4Yq+UoHKQLIQkv/ZjQnmjoqT4alA6M1swgI1Sm4bYh
	Zdiob3p9Q09lB8itePtT1NuXzPAhyZeovsz9n4Vg/ysGl1WFVNWaV3xiE3+cHiVhohnzFJCQdkw
	04k/Y2TkFw1C7ZuaOSmnt0gVaI7HlHGbWJ4cKXYGfNeFlBhhjENk4RIJJZKgHG6HHkrPFqK0kWB
	Ie65h4WAZVX8PESJ9Zw25qtJV00JQBIiKEyut4sNu7wpG7wY1BM5VPM5spgHQjTOrgWlpDMHWyy
	xf17NuaJEOUzPiyyZgoTUHM4YAkc=
X-Google-Smtp-Source: AGHT+IH7SmdQdTke/iNV9OEY4o5/+ktSmtUZjFNUZxLLAQyiwAywABlWq3JZnjJ1zKSFEC4KOQi4Sw==
X-Received: by 2002:a05:600c:35ce:b0:43d:9d5:474d with SMTP id 5b1f17b1804b1-450d876ccccmr143184155e9.0.1748883841515;
        Mon, 02 Jun 2025 10:04:01 -0700 (PDT)
Received: from [192.168.1.3] (p5b057d53.dip0.t-ipconnect.de. [91.5.125.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000d1fsm129253745e9.20.2025.06.02.10.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 10:04:00 -0700 (PDT)
Message-ID: <2cb76b77-2052-43ec-96c6-31cbc93cd2b0@googlemail.com>
Date: Mon, 2 Jun 2025 19:03:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/325] 6.1.141-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250602134319.723650984@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 02.06.2025 um 15:44 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.141 release.
> There are 325 patches in this series, all will be posted as a response
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

