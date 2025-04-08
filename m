Return-Path: <stable+bounces-131843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7311A815AA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 21:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A648A2D3E
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 19:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53A52459D6;
	Tue,  8 Apr 2025 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OZAJNks9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB37722A814;
	Tue,  8 Apr 2025 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139342; cv=none; b=OE8gVRnf3IVZWSuoxxoNPhMW80OrE6GnuOXUbsZsf8cu1IWj/XOcwz2Z1fK+qwKNq3TFvHKvNoI/QxWFQMZLvP5ym2qPV91UT2/D5Dsp4uZ0nIhyly7vG+NZKQ8zLH0HjbqLEyQTgZPidwL63bCofPAJ4oNR+lCJdkvfI2AONFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139342; c=relaxed/simple;
	bh=8A4acg57zaaXvB4L/di558pqfuX3mjReVzFTVKTlAzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPhDeJvhPT1h2oFBtjYzFHC9CwCTDZ6RTUy1ILHWO/Gx2C3e0okBK6xLFOKHS1ajzUmBzK7zK2AUOJXdLjWpbs0Lr2B5JPdHjDSQtNaWCfOsBOLiKKFr1aYPJUycy7KKnpsHZMtY5DdTvLUD9MWIK80tccSUJjhqjYJBp26WHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=OZAJNks9; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso4390550f8f.2;
        Tue, 08 Apr 2025 12:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744139339; x=1744744139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KxvEQKikAl3w73dRH9r3+dRotJi8XhMnm87jGgxr3Lw=;
        b=OZAJNks9a+FekisscXveri7Pr2xw/7aQ7pU1rcAW/Ps+VXGQZNZmWVuZ6igTknHKU5
         fhyg0oOJiSszerbQA1DzlRr1ho9KkqxRl0u8WPHAMgiyT1z1zx0Lrkt23vaL42Utg2Cb
         W2tEQdQRvNIHaY1So0CmUvFkgMYqyWt3FDlmdHMpw833Q1Ro3eAoRmJRdrH3DkJhNARY
         oP0I4p3zBfB7FX0TVazg1jQYh84u7nthlrR34EyqeXQGwl2dLl5BF4miT3SAirqHwPhy
         7MjznohyFgVEmxKF7S97TCPP5T0i00JXjKUSASKXUzpe2JDvO1EMkAEIyakK8pEm60ke
         +brQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744139339; x=1744744139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxvEQKikAl3w73dRH9r3+dRotJi8XhMnm87jGgxr3Lw=;
        b=PLc41Qsi8al5DjIpicLB9I+oI1MJ3ZmQurP5jLyU9wAaAjZWRf92BCfqnmuYfXP6aG
         I2B0CaRt4ItDTM/O1NmdyLG6wLm59jKzrg3ozRwA4SNXQ4s0pl2nR8MDZUiwpgJhmJ7w
         ylPwSFVOMqI8xZrkxs8pG1gLlcvGUBP4RM9o3FOI35ynJ+eYNDh/ZSX1ZsR6I1Qu6gHp
         b0Q2KRiJj58p1NuXjBKDtC/pNbOUO4/TbXty5Qfo6v/sWW0CEdsNPj/gZyi9qd7b9UwF
         /dZ2mVKmxKCglIEkZRz4oRHLvonan6gPQGa4Iy6RMhLykdUhRRPuyqvvWdEwQ4ocLXpS
         3trQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGTdaXaX7b+OBPP0twgKt9LVFSbr1M6nTjqnVU7XBe8uel//FupcSWgx6aYooxV3tqUXWfAeUw@vger.kernel.org, AJvYcCX0d5EHqRkfUSCapYGlJM5h3dz2Nm+t0JA7j1IiliQLFz8cUq45OrB+rUKxZoknZCCfdO5Ihj4mw+SDEfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsHCd5GPqhBcIK3osKIXlvJfou9qymTGmN846AXqRpBVV7ubPr
	5hz4hiC/6hFW+t3Z+NcL8rGdEKBMSntdVc0eRDhbxGRQEfB+4I4=
X-Gm-Gg: ASbGnctL+X8rMePBS6hcXmmCj7IqxznNm4+cDXU8aMN4PgSxEj53n9RL2dycOg7zZXU
	ShkstW6ltHvPyBT1H5podr6N+VtZQJFypLWqVQ14lGUj66d1u6UwS54VwfZo0hWl7WUZ3zo3d7+
	oBcIkL0Gjntc8tCDOemP4sKvEh6IzJ461LXwVtmGdyleLEcBKpMBVXObAACmcCMApDPT73g4BBW
	p0F1SeiaOH8jCZW4pq4jYp93xKi6usxCJ3Ur1vylnyRRE1uMUUeoFSkKVpezDmXoYNgUvmwR8ZE
	SJIiK9HShUFktBpNw2IoAao/WbmIt/ZkV+GB8X4Lq9Q7vqVlnG/krfpWK9QMbevDHorM68v0iXf
	ryax18OLU7gqWPcFy7QRxgA==
X-Google-Smtp-Source: AGHT+IGudv+3ownp5u5XRlhHUkQ0JXvgmmZ0RCo/VKmjLTeyr5vDN95Gz2ym3PFbFmPip890LIgotg==
X-Received: by 2002:a05:6000:248a:b0:39a:c9d9:84d2 with SMTP id ffacd0b85a97d-39d87cdcbccmr305984f8f.46.1744139338705;
        Tue, 08 Apr 2025 12:08:58 -0700 (PDT)
Received: from [192.168.1.3] (p5b057de8.dip0.t-ipconnect.de. [91.5.125.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301ba17csm15856242f8f.58.2025.04.08.12.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 12:08:57 -0700 (PDT)
Message-ID: <10bc5f7d-a385-49ae-a805-becf46318fb7@googlemail.com>
Date: Tue, 8 Apr 2025 21:08:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.14 000/731] 6.14.2-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250408154144.815882523@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250408154144.815882523@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 08.04.2025 um 17:54 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.14.2 release.
> There are 731 patches in this series, all will be posted as a response
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

