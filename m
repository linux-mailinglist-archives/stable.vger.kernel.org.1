Return-Path: <stable+bounces-98177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE6D9E2E22
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 22:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5266D2839C8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 21:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4F71FBEB4;
	Tue,  3 Dec 2024 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="blkFnL4w"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851AF1F8930;
	Tue,  3 Dec 2024 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733261567; cv=none; b=idOVkn+33XP3fRovqKAMZgWvfF74rDwl8DBCIsBydsu0DgHxVD/hmfvzfw1EoKLF0n71oKKocer3yhBDXH5RbUdkVFzEJUrXG+2Bl9/tpzDIPmf8cjzKqgqmFYmtNOiWJjLtqaTCHDLgFDAIriKbqrwMQ9VEZL7Ww5w9fK7Pe0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733261567; c=relaxed/simple;
	bh=Nc9f1r+bEZooQfYMJa/uD4hIz9ZoF0d6uqNQ2F4dT2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTfFjeMmYBE7ektoNAtc46cZbsz7ZZv4pZixvOqmeIK5sJZwZdyN/ZgYQeWWOEQwqyQrEsEgMm6UGeyltO3kEfs2I5HO0IKlxx9xE9tKoTQxdU7nkRYSUvtjaJI5/szM4fce5WD7bVFVDbtFSj3DcykQQho+euYzLsSAkdhdwIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=blkFnL4w; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385f4a4093eso1831923f8f.1;
        Tue, 03 Dec 2024 13:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1733261564; x=1733866364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jm7bvgrydeqcnLfBFJx4m6yhpLKJYsdk3xGY1CQIBJc=;
        b=blkFnL4wH5tSJG7RtSCtZANTA7so2iBUkDjNTSOqSNI0kpb1honWnZ4o6Axiag5lP3
         RxymAN/9NvjjkNToY1xXArNFfX3kHumZRTq+MHiBRf3GJb3jlhHswVRW2pi/gL9G7pEz
         ZHNQW9+sYj7r0oNP79yLb5U9b581YKZ18iDoNiQLvFRGX67sVzeAVb1++thMx6djYItg
         EGLIV6Mszs6uJSgw9CoghDrLewZJZM1NKvhD/MYJRhyJd/3B/1r9YuankR93x6/FWESC
         JDcMw4FWKJP6yu4F2yVCGIeMxzfeEvVOvxAqEY8VyqKTQn+sLBK6n1h9RK9IQ78PU0nr
         SKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733261564; x=1733866364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jm7bvgrydeqcnLfBFJx4m6yhpLKJYsdk3xGY1CQIBJc=;
        b=WU8qWPQQXWIipXt2SPAUQ4AuW9r6XQatzWm73lUuLApMLCXdF320iircRiABIHUd6s
         23eR50cQLgl0seJgS9hGGoPZZOzxTnUqpqTTGvPeYQoqPzY2HCYv5tmNwEZd/Fq4mv2+
         ptIkFdnSOnMmJjvJEl++DhE5c3mN3yJwc73Nbmcu3a7y4k0FM3+nCOgiZZ4O6xn9xsbg
         EwP3kMVXYnBimPhKS41QlGfEMDYQFNNCYBJIKNn0l1/t/JuxWhxWoPLb4myowXh4XPSK
         KzR9XneaeONFhqvZ0YamILLlPJJ3hPYpDu8RXx4UoKPObSpXB2r1WFDMZ1v0LS1PY8SN
         TklQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG4XPd5A1Imu7PE2yv3a/5i0J2GW+ZYM28W7rQa/HQ/l6QF0kkREuLEHsgZqKqbOkPlp+0L+Rd@vger.kernel.org, AJvYcCWNQNgrQBHxbigPKUgo+Ij4TjUqYkXVdXQxPpufGxejAgc2pamNg879rDKdwymUVCcn8Or+sVx/DwONe8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLosGVzwK0iP0VhgOmLUxfneC5GPuMWjiL1FgB2ke/yijqCXu6
	MM4vblHGuN8cfynrxNnfealhI6dDmA7fAgpkBaw0hpSOPx0Gj3M=
X-Gm-Gg: ASbGncv/GapaPYRMNPEXgebJGfqKuasW/pnSB0bS+NS1yy2wS6BYkIUGs9EGxYUQA+S
	OflxF7ROda7+cC3EnlZZplUf+9RR/brNX590SESRiBXy9AqZsY+jOhztqwoserTOAl+2Ih7M7xx
	eEZ/1uiYdaJ0xS2rB13HQ3acBlkJlJWSamPPhNS4aI+QPdAlBy5iyR+qzG8SdyUW1jSpVsBEOd4
	xGS9j3KTPiKEr5l9MZGfMAdh/RUV3E8giEAXjBM2NqjcJA1EWZK9KFOUOWgkKwdd7r23rF5N3id
	50Aogax/vk3wL8hdX9ZEVDMYlcs=
X-Google-Smtp-Source: AGHT+IH9EQzxJI6HWUpjFSXQvIsxXjZW+yNwguN4EuE1JwjYkgk9AwgKAPomo3Rx8TU9VwjiRH07Kg==
X-Received: by 2002:a05:6000:18a3:b0:385:fabf:13ca with SMTP id ffacd0b85a97d-385fd3edac8mr3127859f8f.32.1733261563603;
        Tue, 03 Dec 2024 13:32:43 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac059.dip0.t-ipconnect.de. [91.42.192.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e49cd788sm10932960f8f.6.2024.12.03.13.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 13:32:42 -0800 (PST)
Message-ID: <1fc1301a-b148-4e95-a1da-862dbab38e8e@googlemail.com>
Date: Tue, 3 Dec 2024 22:32:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/826] 6.12.2-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241203144743.428732212@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.12.2024 um 15:35 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.2 release.
> There are 826 patches in this series, all will be posted as a response
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

