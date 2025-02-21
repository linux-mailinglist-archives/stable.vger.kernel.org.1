Return-Path: <stable+bounces-118568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC8EA3F2A2
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 12:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFAA1753ED
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 11:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F722206F35;
	Fri, 21 Feb 2025 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EMPe999d"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D54520766F;
	Fri, 21 Feb 2025 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740135867; cv=none; b=Qe5O0hP8yGHRHb4ww8hif7ene4ypQWiQfw5rbb1ttOqUMestHbfU1nlMFL4+X0J/zr0MKS/2kRZKAtDCy/EYIEzyuBPCQl2osUJU2dxzf5gcaAPIwQFV6LmRb1lFM3Ps0Dbs2KnoJpMY3UUD5OkIjDsK+QKzV7mtopQppkEz9kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740135867; c=relaxed/simple;
	bh=BxAf41+oMViMRHa0fuPqM32XRr5xamZXfCW+aloR844=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/BmF86GlbZXMc8Fu4xvbltNarVeKW2oLbGCao3NPVlTVRnuHCRAuUGXB8y7xZwCigZgIMbQ2IBhYUBrtTg4NiRT8PrOUhSE8fSBjW1TonxAVlc+AWLJ1r2fSn7j09YmAO+rvHbKf3FAJc18ILAuI5xrZP93DW8uJCi/04iF1VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=EMPe999d; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f6287649eso1487242f8f.3;
        Fri, 21 Feb 2025 03:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1740135864; x=1740740664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oSilo/wdscUK3kV8MsIT8Y7RL+OEB64ml/2oWr697Z8=;
        b=EMPe999dnlWq1heicWsYKn7fkrw2emZSK8cTn9v7QRXWSNE/ahaabAO8zHPLhDB7OP
         tNlTEm+Ch7epGQyY4/wyFi+Z0XBw5CaMgtA1WJwqKo1BHZHR46yCqsQntFAeeFhwSXkd
         fl0N2sKqlNO7fi3nx7/5ABk/cABDFovk1KL/UOkT0Yr/0ZfyeBjs2pEAEDxSm8xLCths
         9/KzlSXbTvWeO13l6w7HuJCdJhMtTZ9X+NowjGcZAE3uZnWy+EARuWaTpn+2afml3ylK
         ykzuoGmYElH2zURxqPMaMP3Rd1Ii2gQbBDPy7CjUcPnTsMZYsR+DNLfGNiCnzeJfKTA8
         B7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740135864; x=1740740664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSilo/wdscUK3kV8MsIT8Y7RL+OEB64ml/2oWr697Z8=;
        b=JaKtHGUsL/4BRafh1vcWFy5dQJNsemJARxFJfV6v8Fjwgg6dBEk1LkDQyRfV6Hoe9X
         +QsJxwAkfaGu1MOh3kKLnp7eAs4AmHE/i0JvWFJYsvtVfj/EuQoglppppXsVacH0/uOy
         WTqtoxVlc3IUxUg7L1/jAbXX4/3z9AC8L2JVuRJIzA5C3NDh3ZBkj23t1kll7jpmtETh
         oXJb6oGbMgpmZ1puFo13fHHlddQskUtLLyfEEmaWRtIfSJPopgZx0TDuZBHjXZ8RZftd
         Xz2xoo5JJEZvFVtOZJZOOcTxsNM0DPLFWS69RMYghIS8tEXqIPXokiOQSeCw5bfx8RHV
         f/wA==
X-Forwarded-Encrypted: i=1; AJvYcCXR/Abz8hCsiU9Q/WbePyDm51pkedoTMKY7QbrbYUnWReh0OabauKG+mL8FNcmUv+5cD07WhJTYApwHKU8=@vger.kernel.org, AJvYcCXatgvHaNKho/6/Ggj5wO/56k+IGuLz/FtHAtN00wJV9QlefH37zSqyOoryHQjmnZIOhv9e4fN8@vger.kernel.org
X-Gm-Message-State: AOJu0YzFQr5Q4CT0ATP3U3scCP6+0NY+ctClt2MJXO0yBKXLFuGueOXS
	8gBOZxF3216zwcZ7KVmwyBPHUVNk2nyR2Uu1pZnxdxzMLlILhek=
X-Gm-Gg: ASbGncu++eCuIRS3LJeDexDvjEIrRT+xuOXstxI2DDu9LEQ7SZ6ENVPhc0anW47uYCc
	5eoHKKPzg8hifsNhBvTpc2NTSp/eTLd7YPb6CUq8T2nMAhVaARygeYxjLJ5ZYAsMkJ2qePUuQof
	pWGZ2MF6K1Gtpa1aOffv9QYIp35xhT28dndsulXhTrHcaXVX1cI74CMMK3FL33UOj3Vnak3Fqne
	9St4b4dQeoPXOTpII/Lj7+z1CAr0K3aulvH3zNn5259wbyWXdbbLfque0iVQ0sBuQ5U7qB4syL9
	TaX/yUYlXz87bnZBGKg8a3vSmlDNMmwqEJtr0WfjOjyU2NN066ZcL/HB5xUV9uqtQFo6H5/3JDA
	WFzM=
X-Google-Smtp-Source: AGHT+IGhDg9gKTPce4JVE2GBV+POBxVmROByI8CH4RKxLnv2pIiFDXeep3kM7yKxGhiLRmGUNjIHpA==
X-Received: by 2002:a5d:64e6:0:b0:385:f6b9:e762 with SMTP id ffacd0b85a97d-38f70825ff6mr1942837f8f.36.1740135863548;
        Fri, 21 Feb 2025 03:04:23 -0800 (PST)
Received: from [192.168.1.3] (p5b2b437f.dip0.t-ipconnect.de. [91.43.67.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25915785sm23758697f8f.58.2025.02.21.03.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 03:04:22 -0800 (PST)
Message-ID: <702f4288-6afa-4c8a-9095-fda1a476afec@googlemail.com>
Date: Fri, 21 Feb 2025 12:04:21 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/569] 6.1.129-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250220104545.805660879@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250220104545.805660879@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.02.2025 um 11:57 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.129 release.
> There are 569 patches in this series, all will be posted as a response
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

