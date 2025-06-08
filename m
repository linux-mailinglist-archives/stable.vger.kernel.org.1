Return-Path: <stable+bounces-151951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5179AD1370
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 19:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4183AB92D
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AD918FDA5;
	Sun,  8 Jun 2025 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Hev+vqy6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D99716C850;
	Sun,  8 Jun 2025 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749402053; cv=none; b=YhPQVKTX77u2zb3Kw5/HIJBBG1OljzvbNSuw0dvpjYP1C2w7Ed4CmvCkgDvC5A+M6oxw8n4Ve4yFVP6mPe5ABWEsA3GIKgvvHgwWOhg5OBSIxZiDQf/johDtve61hifOyhqlIcnZB4CPwWICZEl9ctB39rx++WSSuv8Ok6yfYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749402053; c=relaxed/simple;
	bh=/bNsoVxYwacpXDiayNGuTxJkwc5QaeWgyzPErTnF2F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ln2dcau0r70Tat+T19YGPkdgGLLjs5NXNcx6cAOlJEbxfzZve707EBthzn3b4E2jIkafHnDMmmf2+jwauNvtmR9qqflQGjWGVAHVpB/yFKPp9/0hFRiw+vLgAzaj/vruSmZrH6MCr3zLOfvPi2Q3kDq347UNsFShfn7anYnFp8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Hev+vqy6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so28648885e9.1;
        Sun, 08 Jun 2025 10:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1749402050; x=1750006850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jemnm29QAMqI47V/wtphWNl1AmFUucMDlLmAcMnzjkA=;
        b=Hev+vqy6UkACEt1y9JswPuOPN2PeDrur+xo/GSLgEfuv6e4hzGSE+9abYa/erJ0y9C
         CWsaI4HCpG6sjMFxzDSdh99L8lr+ngq+E+bxN6vMcj8oqIPdgEE71fOf6Xc9GCupUIPV
         qg92CG/fZ1KOOvRILqrnvSgMndN4E/G0SWo6emCwJLJYOWu+1PneXr70UqqeW+LN+Qjj
         179805LRQzUXTFtws9axZHhrSPT5P84fz8QulgeZenJzmS/G5fM19tDHnLWcD4rdayWx
         eNcTNvcUHQh09HU/TVG3PiAZKgCSdLMRtp9HSMPr4OArb4itYyJuKtQJhDZzzc3thicv
         6sjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749402050; x=1750006850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jemnm29QAMqI47V/wtphWNl1AmFUucMDlLmAcMnzjkA=;
        b=IHqfazcNLQijq9jN/GlqAHhQ65Y6NhNnIvTLY6Fg7H4B/oxuwK8aSdyr8gaNGYw37n
         fo1SVNGiGiTX6vg8gaiAIt0wsSOJHLd5QYXI2+nIbsiQaSd9cMPCORRtQ2PdlcMomgI0
         LsH+kBHdw+vRh7RGRYsBt32WARS9RKXrv1w1waA4Wcb0DDmExuCVBirwMLSXyh1eker2
         1vRz1gppm4m3s28IOqq/RC38AudBtV3OXUmUsN/uhbCDcXTeL+8aBrXQzGaj/XT3O+ro
         04Xa+6xNwKn57QVWHM5Hk6meaaxHkX+0dZRommm30ehJd5gryzKyLHQGMfPVHfXzHDp4
         SDqw==
X-Forwarded-Encrypted: i=1; AJvYcCU0SYYblqDt/QhBuhPeYuBhwzDt+rtxXj5pSx3O2JqfXDeldrlsNxg3elJKqJk++bYRbdxxGdm+J1Eaba0=@vger.kernel.org, AJvYcCWcS9fx7s9A6iEkEudSDR1JRbA2SsRGU9tz1G42vQbba3C/x3xVc2+pDUbbSRFL35AiELpSyaIl@vger.kernel.org
X-Gm-Message-State: AOJu0YwnMz8W8tt2N00QJ1o6c9HLYPRIsWCJJXdHLF8Nu26+xhzbmMp1
	e6xD5snZjSXH0YQv6dDbBL4vv46zHnN7YO0Gkryiw33u5c6dVPyAAV0=
X-Gm-Gg: ASbGncupr7MsXqfkksIhpI1Xdg+V94GW9lfysbBH7q8k5NLraLcA7k4AbB1h323TFHc
	3A60TN2Fs6+Ia3+x83UOpTQ6ETDJeWS/pgqrGEHlanMciQDTo5E7Z/7TLnwnoiUYZJmTHxzdb2A
	2rBIg8Igs7TJPKOm8iXtV7s0ZmWOu52/2SIkZi1gLYcFyyaG5tVEEDtK98XLdpXhvnFUtaC13X2
	9gkr+BGvmUkzoZpDjq4+JXdjJh7O9GiBzEVsqJJIuKyvGOMGR4D+OSOGXFMSgjUppaLQ8Bpad3z
	oXzDEvEwI8WsypQdG4PoN7lGYWG9I4cUHaXraRVxU9SfAc3C3tmlBQRab+WNnPH+hfXPBy0APY9
	zMYf+FmGiNRaC4JfYfU+E9jL9QEk=
X-Google-Smtp-Source: AGHT+IGfm7A3on/2DFqoXs5ImVx9+eoZZRrYHo6As+KPSTRBYhewMFv05457onPfASBatZL1COyvaQ==
X-Received: by 2002:a05:600c:518d:b0:453:78f:fa9f with SMTP id 5b1f17b1804b1-453078ffb67mr38485195e9.11.1749402049484;
        Sun, 08 Jun 2025 10:00:49 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ace02.dip0.t-ipconnect.de. [91.42.206.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452730d161csm85257225e9.37.2025.06.08.10.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jun 2025 10:00:48 -0700 (PDT)
Message-ID: <7634f9af-c3c0-4953-be8b-4e8395c4bcb3@googlemail.com>
Date: Sun, 8 Jun 2025 19:00:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.14 00/24] 6.14.11-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250607100717.706871523@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250607100717.706871523@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.06.2025 um 12:07 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.14.11 release.
> There are 24 patches in this series, all will be posted as a response
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

