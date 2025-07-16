Return-Path: <stable+bounces-163166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC7FB07964
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 17:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19FEF7B9D2A
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 15:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D4526E6F4;
	Wed, 16 Jul 2025 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DSPExOo6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DA1199939;
	Wed, 16 Jul 2025 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679017; cv=none; b=K9RfHrC8bz6JKh+9jxuCtcAN0rKJloWWm18+CsLNzEA/YxkcxuU8hXDy2VMxdZGwwFTZyiobDyfOwL/HIGDvgroQMT8QJs2TSe+RHWGYxaXtgdRtqchael/th9quCzjAH+uFdYGX77EWQ5m25mfRGe6NpPe2JggYBX2OSR5zkp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679017; c=relaxed/simple;
	bh=MAPCXd746dLBijiuAG9wc56q0nopYPabJGjrqlYl2NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjykyJTUp7ejM5x6cm/AmIBukA01XuHDkuoras6kRJ2pOt8boG2XKqaIX3/pDvRi+E+XOri6Jb715tXIq0l8wnAR4FOzo08jIn8KYoEZ+gWdFXgTKhfH2IHwgF6ZcOKR/QVc9SnCTGJxHdvWkoA2zxHTOB8k7kUx3DQ1QSmy0R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=DSPExOo6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a575a988f9so3964247f8f.0;
        Wed, 16 Jul 2025 08:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1752679015; x=1753283815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=avBWJ25ynfi1WXdhKE1sihofZACgr0iOjzJgTGpVu4I=;
        b=DSPExOo6+PXB2D7J0QBHoD2dE3oLCVUhruyPM+Ii2V0pSrRn5c0xA5OAATll9w5G/p
         u11RwOSl9bgkb/cy8nzE4eINEmdF2aLumQxru8FFHqK3OnjnRVMbjRO17uY/5PT6ll0c
         AVu3cv7nqLVD8jqA68E+JY8aNji12EZmBquc+tRRLvHDxPfg10jvCxfkIH0wJwsmtMKi
         IEWCVQgP5I7Y0rGULLYkGjgLGNJo7AjLRLZE6ULgMnGJ6HUqYcT2DsjEvFgkJo2JjNA4
         lMvQ5ECqAiRt8Ui4/q/TzRO/c4kStnj2amFnYF5+QqKKRt5hM9pBHWSjlDn+2FinElSk
         6Ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679015; x=1753283815;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=avBWJ25ynfi1WXdhKE1sihofZACgr0iOjzJgTGpVu4I=;
        b=o3E2/HGqgCV3SY+uGh9le8SWcuZZe2Reoq2UFxn5BatIDMg7rI+OtSo5241S6eYE6q
         bIxbBqau44TY9C7S66CfiV6h7nUmeKhXgdhmz2MsCWHqCVPzlIHusLLHd+Rvjs26aWuy
         tRfynK3ZN8npS9XhQu+ZWQY1KspgpQoAMv6tGY6AcNKXbnVjAC6AW23r9WKKkRBYz1RI
         flBhClV4BKGcL2szkM+LAmkiiDnc7jWIGHmGH0tBwnG7cuknWOt9UeHT67MKGvXeSLpL
         ie6JiuJnwv+Ub37dgGVMhpeSjwqStN2EwUjbCu4/aQxIv+Pnly+JyPH3FQKDuPM3TMiy
         1vvA==
X-Forwarded-Encrypted: i=1; AJvYcCULkwOxPviu4f4Ny60epOhRi/eQT1bic4OvkK5GnAStVmfqGvOvj/YsPdRnYLOYU/OrNeJtFHeTvVArx/s=@vger.kernel.org, AJvYcCVDiFc6sZ5BHh5ljgnHvwTQyDJid+kfo5bKuow0xVjVmATKf8yqrBjqrEUaMPH91nLq4FdI9epB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw49gtT8qzZKPWG/Y1nrruVftsYmJ7K4wFf7lkmDIjpfrw5amcM
	ePkV2lBsfwGtwguptLfcZntBEDiUWhbz/GXR0rUGLddlN6YBjZsSVcg=
X-Gm-Gg: ASbGncsFKWaK6wdA0u06cadaM6RtLgFnyexhzjumm0x622eWXwTzUB06dcos/MIDhza
	G52un1onwnjV+HSui/6/Ip9IeCEP5ec72aWA9xCe6wNSrnwnQr/XP5J4TnLIlRVOUCbtweCrykw
	GSDOpGaGKvIfx3dUT89FD92CZ5b6RGw/xwB4X6IYE9yRgd4AQg3uY7vvv+pQ+oRhyXjfP04uQZm
	H1SThN7ptrVcj7mgh+A0A1fiFtb144OHMlr7VSK5j6mrrWMa710N6QhGjyfPIpuWRwOMAQQqOhU
	SBxU9Abnv3w9lOJW4YgtXxHnWcVHOLxNh9wNX2tT3+0Uwwo4sDKPMfxMp+8woddpTJNiiHlLGIX
	Zz5m5PMea3st4LAxef1awcImlGpxghQDjdxrzWobqyG3+XeGO7ejpwQGYXLdgUTFJKPHgpvfGyJ
	Ci
X-Google-Smtp-Source: AGHT+IEEwF9/Vt1NN9RTGjqLRAvAvAprCYcNaMdoOJjP5OOWxXTAo0qCZRqZKCsXUdsgjQgLX+bBVw==
X-Received: by 2002:a05:6000:4a06:b0:3a4:dc32:6cbc with SMTP id ffacd0b85a97d-3b60dd53fe5mr3490110f8f.20.1752679014473;
        Wed, 16 Jul 2025 08:16:54 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac571.dip0.t-ipconnect.de. [91.42.197.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e25e75sm18016432f8f.87.2025.07.16.08.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:16:53 -0700 (PDT)
Message-ID: <da83a1d7-3609-4fda-932e-0a4e41be890c@googlemail.com>
Date: Wed, 16 Jul 2025 17:16:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/111] 6.6.99-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
References: <20250715163542.059429276@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250715163542.059429276@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.07.2025 um 18:37 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.99 release.
> There are 111 patches in this series, all will be posted as a response
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

