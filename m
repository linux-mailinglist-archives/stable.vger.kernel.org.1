Return-Path: <stable+bounces-121131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A628BA53FBF
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 02:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A0116749D
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 01:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8B4156F57;
	Thu,  6 Mar 2025 01:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="abzSbyzY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B959156F39;
	Thu,  6 Mar 2025 01:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741223987; cv=none; b=hJ6B8QGo2GRVUqruWJCLkoMN/39PyT1EJvv3gSMJTNeNtGk6ZrkrXEQjm+IqDVIQFRXJBUMXx5cBtOaAiRnUtndAVk+TQuTMQDUY8jtlkM9ckC0hYBANC9X/Y3JjS+1V1PdGAYFCRXIAo83E2nPO6y4eWNPgDW2XncxJ8AxI0vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741223987; c=relaxed/simple;
	bh=NQ9JaqO7/f8BskH51rnOv+3ZlwJ/qLixzYb9yoPjjUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CT7P2p6ARmCqtrC8CpI/I164maOXAqhjSTkjIa7ARuum6YzAuhJVTtv+//IjP15TOhG67Nszf/L34LVoePZbfr7mmvJsVl7+DfBd+aK2cAzX7/zE3ehV+JqnaPpazU8r4FO1r9+o1mbWY/krGiWPGzQli4Yj7YOwKbaclLPIba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=abzSbyzY; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso991314f8f.0;
        Wed, 05 Mar 2025 17:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1741223984; x=1741828784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tKo26csy1Wj+Q6iZIefqxzUixDxkCmTqOW6lRWj6/Ho=;
        b=abzSbyzYDnm8/9ejYYiPd6EHiAQ9ihyZUG4ndrjgmo5GyoHlYUKiSMArfCU5VPSCOy
         XxWDchAlUsfDj5V/mDdZm1yMTHjr2/CqcHBA+ymmMHJZcv7KWcoFXGNWQzBmgUb8ytyH
         T4DInLmWHf9vObJaXGcWAH6iFFbPFk3NyCiGY9G0kKLOkaJIfXpgZiCRBqO9e99BEbU8
         nttgh1lTWZiX+hxFxTXdHgxzPKevyOcXs/SNjxHhKJCVZyaLI6/AG81oEz+GegACC5aP
         DUAURzfRHQMpKz0kyDafAQWudV82nC3epkRU4KMOIrx8quvjUfZp2MulKvSMIK7aIZyI
         VEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741223984; x=1741828784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKo26csy1Wj+Q6iZIefqxzUixDxkCmTqOW6lRWj6/Ho=;
        b=HBWlBeAQbx6TjAfx4I9Im8a3NpvIWvNcxrCTSUzFn6igB/VF4yntNgwYWbwLiK4IWc
         JDwa2Rs1+ljONATfCscK+ZnOGOKzJbEYRHjhQyvMZQmE1NSGTSM29HpnueLSrFlJzY8o
         IbubLvYoO7dHp81c+kyWSk6+qzi35Y6dwkItn5HRH2gb/1F5fvDNgX2KYgfQHz7G2KIO
         V7g8vXe7x+bvfYdgik7hWsGv+dUlm6/3ctWpaMlY7WYYftDZ+mNEbfVfHSNNLgmVhk1n
         rD0ll6FDHi8wfj/0mGJlspdaNz1GPmv6TrBubsBn27yV60pNVDsmXdQIiz/QmRRo9qa6
         G1rw==
X-Forwarded-Encrypted: i=1; AJvYcCVjZJTbKLe34HRiUGdyoZpw8vU0uclBMEb6EExYHh+dGkak5SIUtUPPXBzGCkwpnJtyYasWRwqt@vger.kernel.org, AJvYcCWFhrvxJ2EqNpVbseIorGQMwBvFFS6O5DxG1zIykcvDg0aT2WAPww3HL9LIJS6KoLYpLY/Ptq2N3BsQWF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPnwHRyukKKekbd1vAah6TCXQtNCCSm5dY4YeFoBU6omeJjWDx
	xcmhNPCjoOcKaG+XRlHCyMHxAwkbBLHoDFRFmo/lTdbiw3xov0g=
X-Gm-Gg: ASbGncsq1AH3KkgziRdZHV58zNt9+Ve5D3gp+DSbQBCDpYBtlLdd/shNtQkcXHQG9yY
	QcXZk33/yEg6DIh2hAWgqbA6usc7C8mVbaWu9j81A6W/oCybNDl6mMRDKw7h7sMz03q0EZ90yYG
	zNlrSbfdTCBfgcCHvESrhtlSd3mqa2YbEeXhcLc9NRi7Dm/E7aF/AU79R7TAY5lc6CXXSXKokE9
	xZtMUvJqVtc/RAD9cOI4Lkcx8WyuJYvHsjUDJvgg4egldFFktl3L1YVtGpGWzLKbldq+mSdIW0n
	ZsNKI+rN++G26gD0BbgtiYug5v+PG1jOkT24tip0KhJxby9VKbjb2rPlqT4eyjU0HvBkCtVwrve
	yeWv/KcT7eAr+zxGiUS2J
X-Google-Smtp-Source: AGHT+IFpPgTvwRArsdAwnNWcjZHo/WphvoPPh+mSd9cE5f54PpLp9KMuL1fBCvQFKa40509uQgVZ8w==
X-Received: by 2002:a5d:6c6e:0:b0:391:952:c74a with SMTP id ffacd0b85a97d-391296d8a65mr962184f8f.8.1741223983547;
        Wed, 05 Mar 2025 17:19:43 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4217.dip0.t-ipconnect.de. [91.43.66.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8c3d61sm3465675e9.15.2025.03.05.17.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 17:19:42 -0800 (PST)
Message-ID: <5b7bcb84-5ad8-46d2-856d-38e3081026bb@googlemail.com>
Date: Thu, 6 Mar 2025 02:19:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/176] 6.1.130-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250305174505.437358097@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250305174505.437358097@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.03.2025 um 18:46 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.130 release.
> There are 176 patches in this series, all will be posted as a response
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

