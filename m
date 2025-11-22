Return-Path: <stable+bounces-196594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BAAC7CB15
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 10:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8480D3473E1
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 09:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D94F2EBDC0;
	Sat, 22 Nov 2025 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="itFbhJu8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC1526E6F2
	for <stable@vger.kernel.org>; Sat, 22 Nov 2025 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763802313; cv=none; b=Zir89ANHI2LJeWUfBUi1ANzm/JNYTmq6Z54GIgP7uZKVMmZ1qkrLPpge8z0ZOzw6XcEN/tvHeVtKz1UNbtbUbpuYp9RU641UuIulmDEuaK+uLAaqAG5PZgozAgBfi5xUokZrkCE31bm92lJc4xQpQX6l8qD5DF4mpQUxTBSZQ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763802313; c=relaxed/simple;
	bh=+o58sTORT/xBJ0WeE+q4xtcaupkwBqq7A8fMCMaSfDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Prds0e4pZ78sjAJ03pgvWQLFe5rRpUdcpZeNZDkWBEy09uvhrKmn2tEIAgWkOoVJ683R2VBiC9vpl9WA2dT6ckjmM8jD/tcDOANXkjkTHMfHRTXW01z6Qkv7I6zIqDC1CCVL5c7T94tsRyz3vw1U0H1Lr2bktYL+I5Ew5jOZaIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=itFbhJu8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477aa218f20so17833885e9.0
        for <stable@vger.kernel.org>; Sat, 22 Nov 2025 01:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1763802310; x=1764407110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itmDZMIfZPUUazRjkC+XGSwKghDLDLe2dKB4qRZWduE=;
        b=itFbhJu8E9duCg2E2R3rryrd/BHj47qOu1vKYvldX7NsZhOY4yfkLTrSpyfqqgb8SF
         3GdcK2SGqBjsxdLYrpyjye3IwE+2wGaQpMbvAyL1UDa5hpevMOh2NyGE2koaPD18GAyP
         l4EG0V52xPUt22PdLb/OZBYuWEDcARgJfnHnmjUlcZ67Yf4aCc0CALNd0GPcHT5ExaIy
         RRyYWQrfpWwMJoL6gVj+zQPFXQDX+L540gUKsqNXvKo6OHWfFZ7ChE0Db0tRbKIH2m/a
         R/PMFXsjqJ5mblPkvnBm1sW6vXFBEb17mIPkDLKZdIGkKkXMShtzcZ5HeCDVc7FLtoDb
         WsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763802310; x=1764407110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itmDZMIfZPUUazRjkC+XGSwKghDLDLe2dKB4qRZWduE=;
        b=c+EsxAOwi7oj3aehZeXqlBcsTCxlhWSqPbKe+36MQKcv9J3t1yQccvcix+0rK7fBuX
         buMsRg2oFC6d9ime+EyR/O5rpPiDWZN6QucGAiagJwbj3EylVysHiQT2KvdorkSZVM2i
         NIaluBZobgSE2xD0Rtw2uduzHqJrxJ+qrJymFkLuX4GRy6wDflJo/aBAYh25Q0QC09MC
         qe5qGAxiHTJuAZxMb+SK0dwD4XtYy1xTK+tqyL7NChryPPLSfURGjViynkbhS9aN+TKd
         n//FXmB57eGJG6d0AuO7m7L7N09crg2dd/WKWA0f9/xAUE8uEZ1NU+12MzNRhF8xzokD
         essg==
X-Forwarded-Encrypted: i=1; AJvYcCUbeIlPqeck4wiTnVaZITmYeelyMbs2sy7PUxEijYgpKGkBi44pPA2lWAFw9r2ApJco1Lglf0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp0b9giyBIBpbMN+Oy/6Z8vUHTjF/3w5aTNUecyAR7wczMPQaF
	udLE8wZznS+loh3YaOc3kUva0ld07CMzGBIBADkeGOdGvh0iMLGyaOA=
X-Gm-Gg: ASbGncsfAocRBbDoiaEGh1YtqBxmXpmN00ZQQgFXTAdhQUG5Bg9UvpAvXfeRhRKIMr1
	rDB4QfxwiFuTPVE9s9DRfxBr7Alw+taTJEl0Cyxzg0+PUwLqzWYIGkU/Z9biNng6kp6ybaKpM5R
	KotPn0gNkGw2NpCwqdtttI3A+dURmN3HZ97gVhixW8uuBEWo2rPBSDOGixJ6GmvRcjY0Pxd+wqM
	Em1YPHoxbvphNrUh81V1ffn0Pm6CRWrGSeuzi2bTrLlGAb1RW6Gf8mqwxbJLH29BoxWGpwwSKsi
	0Cmt1TpwOOPA+mds9hiZ2ZAA6Z0zBlQOY+4n0TCueOLhIJo2r+/OodZZSDKbR+EUQDnrF99ChUq
	dujNY9g6V7TfR4BLTRTvpnHuEDcIhrjZAunCbRBEMdsOEL/Z4QKSGJ7NkeAXtWZSBGZIn/MLhdB
	m87dRpXkI0A8WWrhNkZd2gaTSLLF01axi/Axpk3wEHSRXczpF7ZgS0lusQ8rO2nr5m4R8Jd/Db
X-Google-Smtp-Source: AGHT+IHuK/MNIwFGtsGOTl3BFzuHhyADVeHagZinDoohoIknS711qVlmVrtu7NTaglvI0Y7Lqm/mwg==
X-Received: by 2002:a05:600c:4e87:b0:46d:a04:50c6 with SMTP id 5b1f17b1804b1-477c01ebc76mr51757965e9.30.1763802309757;
        Sat, 22 Nov 2025 01:05:09 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac108.dip0.t-ipconnect.de. [91.42.193.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa3592sm15114665f8f.21.2025.11.22.01.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 01:05:09 -0800 (PST)
Message-ID: <0291453f-516e-4df3-a299-142f719dc3d6@googlemail.com>
Date: Sat, 22 Nov 2025 10:05:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/185] 6.12.59-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251121130143.857798067@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251121130143.857798067@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.11.2025 um 14:10 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.59 release.
> There are 185 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

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

