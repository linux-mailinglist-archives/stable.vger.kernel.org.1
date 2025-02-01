Return-Path: <stable+bounces-111886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFC8A2498E
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 15:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8C63A7730
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 14:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833121BEF91;
	Sat,  1 Feb 2025 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="E/IqrOJ1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E469156885;
	Sat,  1 Feb 2025 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738420771; cv=none; b=aGQRcLvs+bRFdg9xOjPCcaBaHZmQw3jx54y3fr3B0XVLCOh2YHh5Xdn6bhchLO+vRK4vJr5bVyK1/0DRQzvYdYEGapBMzz7MPXXmxTEsXf5cqozRo+vleowa7RtMWwVIoJp5D2qQB5mmCBbUiAAQhWYoGfFsBnDgYQ+mVg4Lmog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738420771; c=relaxed/simple;
	bh=MEcjYjOqPa9vjrEET5puEAOgzRJHK5aUL9+E6N8/G+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9QtLTD/Y+M31cXvz6JA8VuntaA50WO/M/DZbKgOY9dtblPABqQt8UZdIGywUA8dav6yjsgCY/sb9ic9ruP5euhA9OwBcx/3PTWE57r7ID2J9jWAn6J0p+Jt+pQNiEf1vDQHcEIn5kKhIx7iI2yM1cIq/N6LgPfyXYOPuS7NMN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=E/IqrOJ1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43621d27adeso20447405e9.2;
        Sat, 01 Feb 2025 06:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1738420768; x=1739025568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6hnx+/tNpmWLZW9Rhhbh206Hg2Zd1A0pWkkU4yP/J0=;
        b=E/IqrOJ1KGHAe4gee/TvfTLW7vec4vlocmL7mBrFXaLH117tDK1ZhGC3JR0PRLyJCn
         miRCay9A1MevzLwml0aUg7UrhHFsTDI3Q0pUt0I8rscMFQ5jnSkuYHk9mWUFn9LeyVDx
         /BvaRcEermjQSRtXmA7dV2xMI0pD1jjbiJjKDe5mo5u6qgz73p1An4V+GuJG8iIv1wPq
         uDxUO7e3ywcCY9gUWDCmVWVDMiAVN/QIGHLHi84AgC8quuLkOxrBO1eLjpoeSsIbrA0h
         zl/VunJxbXGQBaQIryeAqHIu7i1XWtsp3wvZxg1EzCn5D9EHW+D3+LwErxg/YIpzmZvt
         gjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738420768; x=1739025568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6hnx+/tNpmWLZW9Rhhbh206Hg2Zd1A0pWkkU4yP/J0=;
        b=jVgQga9fRIVwdYlboc9RBnWQ47UOYqarRWjEH6o4A2hvQV0soPxBX5F9hO+A3y6H2g
         Wesd8fi41+aiXGTJJpx4r2zrsRF+VI3xAF56Ktjf3G71uvnzXmlKpJ0e1WXWMVipUQe5
         yyDcu6V1VFmOV4uhHsjd6rviJcCzeEFwVs1a00+XiqZ2egimiCmFD3PwyupqzUpOuyKs
         JRhWxfuRwE9w2Qivtx2lkr4UQAUb+Qqsw23Z65HsCZQ++Qfwwet+CFqH37ZYIDFsgDBk
         9QEnkxdhnB8EmtYcl546QPrOyxK32rw4o/wmoYw8HcPp4MS4flFo3BL1iwZgwe5k8alG
         SyAw==
X-Forwarded-Encrypted: i=1; AJvYcCVfAR92dd7rv748Mj1P05i+88TziU+W/RNf8LFqFO29t/GpEiSdG2PsGyVoB68mK/t/LBdzBcpK@vger.kernel.org, AJvYcCXFnvoCxtTPU1tJABlq5CQBZj7G6KkLXE6UzcW4g9NmuJ7h3zJvURSZdd3vDS9NCkO6cO1HF6MuF3bTZmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf/IqMO79DmCU4vbmHW4FG3neS5AOvolymKUqKI3beT+VQZ6wN
	1g0mCJ9K1zk6J4hXB0ZEouuBp6lb+99g88diIiW37gujaiRuuFs=
X-Gm-Gg: ASbGncs8WGCJVSHBDxrkLiphsXgvqW+GFqEfuVpi2oA+WlgeZKFxHs6ES5N8A9p3KtJ
	M0pFQC2v2r0kWPpoqdQgPaoz3OtmIxWEyEFTYf8uKrqyOlUO54UrZdTR8hU00If1OMR22lD5P+b
	ZjHYcW1DwKJ2rWfvja1ELoMlxFOYe6EuRsxXX3vmLbrOOYHzm+9rGCh3zMJFJXLiRSIUAzA5T7r
	E6Fwj0RqwJTsQkYiuPocA5tHbeDKooi+u3wsaIq8sb0CW4rN22foFaqWeyoeesCFzA2ZgCmxFGo
	I/VHWZarvVAaNwX5TO3BR3zYIW8kidcgkeUchu8uCCmc2N99MWPwrtcmvEUqzEmmBhQ1
X-Google-Smtp-Source: AGHT+IGm7vkxAZkYSTFDa4NiuVf23NintTcjcAqBgVN7dN+jbTT3piuvuN1OOhgxg6aSccATYQhpPw==
X-Received: by 2002:a05:600c:46cb:b0:435:9ed3:5688 with SMTP id 5b1f17b1804b1-438dc3cfab8mr135468995e9.18.1738420767413;
        Sat, 01 Feb 2025 06:39:27 -0800 (PST)
Received: from [192.168.1.3] (p5b0573ac.dip0.t-ipconnect.de. [91.5.115.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e23e6a4dsm88565935e9.21.2025.02.01.06.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 06:39:26 -0800 (PST)
Message-ID: <72e0568d-85ef-48cc-a33c-46e0bd35c24c@googlemail.com>
Date: Sat, 1 Feb 2025 15:39:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.13 00/25] 6.13.1-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250130133456.914329400@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250130133456.914329400@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.01.2025 um 14:58 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.13.1 release.
> There are 25 patches in this series, all will be posted as a response
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

