Return-Path: <stable+bounces-204226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B66CE9F32
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 15:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92791302355A
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 14:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AB621D3CD;
	Tue, 30 Dec 2025 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bsHhJjbg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F4F217F31
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767105603; cv=none; b=SJp+KR4c54wwDfjKkQJjRDI+/EyZiJ5YPyltaN8HQEEjJSb/KEtcPOM94jdrMjpSPB27AYRuW3khD0ZAHwv3FhaAm4lGK3W0Fs5TTDqJcdeqOYskZIfmjlv4vUWht/szhtORiFT674w2XZK1NY/SQBsnCBaJzHgsFLy50t9YxU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767105603; c=relaxed/simple;
	bh=s0rN/mzkBAPcsmVjyKPNIB5LMIJZ073UG2Q0zmQovXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3Yq4qiF/cZ0wwJgZ6EN2/59cL0LRjnJi9Lbu8J4sarl/5PcfoY05oGCbL0aTfeNUpqlWY2RFSd+FWVGgiYPmk1eYyGDAsVLIjRiQHus0TuzhLq9To3qRlE5g8hT5IHwXRci1Hck9yFJrj5iqXho9u8bX6Q4vvBb17VX5W0iwDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bsHhJjbg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4775ae77516so100251315e9.1
        for <stable@vger.kernel.org>; Tue, 30 Dec 2025 06:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1767105599; x=1767710399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QBHQ6iT252IFB9IbPjXdUzgUocgqNSFN6oDTMtuDLng=;
        b=bsHhJjbgmYlchp7OMOp7PuZ75U5lmRTJeTc7w3A1twK6XkCytJ8VZAawl1hdzkYuu+
         4oKXC0n+OEmKsoVe6PaQTs4AgelWUjYQUYFhQyZjnrpMlUiPSp1XLCmu+3KwyzJgUlZh
         5Oka58LJb4rVle4ZClxvD6ehtA1Vd3GWwIgcf6ZVrdgc9D0HOYN3X17+IsilGl1wI/UP
         8XWPOXYQi5/KOVJwsTMpaolZyhueWtSqDn+KT/PMhI2mIGU0goqMwiHscSw8jjkZXq4s
         r26YQCIpg03SESWCjJ6e5V+c0sPS+riDpwA7/7enRARjPFbucTUGOo4WN9A/EQwCgdyO
         8kCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767105599; x=1767710399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QBHQ6iT252IFB9IbPjXdUzgUocgqNSFN6oDTMtuDLng=;
        b=uHH+Rs3/mwVG/7zyaspVN7zvGS/jNNBzNR/9legFwaBYkzvCon1q/7qKi71ffocimv
         Tj9RJ1yrdQcwLxcbdzMW/6TlqIci9wynittzDW5h+nHqSoXNu6CjjKiWL6Ry0a9/9Koq
         Efsd942qiqSkZ/22CO1oWcUxoa/4RHmzyaZ+jKycnNmCtzx0YudxsIjYlHlQ4tZ6q19O
         uxuC9FV30tUnh7EmZgctzVxLgqYEs9UHOdCGTffrPcydGy5Qw/Z+F6B6E+KHSd+Y7lRO
         YJ/f5rYjOqphDgI3TXM1DoqltFNO4tQNA19r+NkphwlQ7vAf4KKDhX4YBAf9TeCGYYDF
         YcjA==
X-Forwarded-Encrypted: i=1; AJvYcCVfVWgHRKuKCqTh5bRc6I1vMRffMcRBk7zPtZKLQvL9VylLFVhEa4wOZGVevBfnR9ouUXNnrjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5jtzlfxHxAxyw9zpfTl40MYIs52R+RKpcQ0YtNpZHgjV7a+nZ
	Rw9nMoKD9PUuGTnm1tLwrcc5xUDwtH88zQZRoRuUXf5gvse1h2tmT7E=
X-Gm-Gg: AY/fxX40rK/vs5nWiIE3kNsPPyoh8AZGBf68ga6xMAzh3g4QeBMfi1hIFJJrSuuzQG/
	8pgRyeXQktVZJmh6e0UemPqTC6idfL2eO8NF7XSK1smHXarJXBHndr1wFyYhUQHxZqe+0cFYav+
	KEaDX7e0XCCQyoXYL4QucSRq1UjZSm6UUHz+3oInbS4MLBme7RlqQwshRn9vrjsT6JESxWBnYgz
	FndLHyVVVm+g98RKZdsfs64v8bLcvwh+LaNgJZnqGf0L9MllPoZ+5QXrOo9PnojPc+fNT/0BB0M
	o6CDumLiHlcse2qEoJWWslmSJ4zTR1U87cx1ssahYybDMuf3/Apyjffrb53CwXc22CimccOvgnW
	m4PYHOhbcUuMOHeiy4me1AsfjJEsbeDQhmh6nWxNI8dsdweGnhUZCgdIwECU5ttRPFVAuhXhSHP
	dd7vEMcBZTseB5s46uG4rJUQmPieHVEgWMgBuR0l4nU3NvgSJoiSTRKc/4LXHEbuKr
X-Google-Smtp-Source: AGHT+IH1o2gMOevdGKqUazqbPOJHWmg4LI47qP8OVKndiDKp4tRzX6T9r4aK8tE8IPSU9rjjDBQERw==
X-Received: by 2002:a05:600c:348a:b0:477:95a0:fe95 with SMTP id 5b1f17b1804b1-47d195ab61fmr413121975e9.24.1767105598732;
        Tue, 30 Dec 2025 06:39:58 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac5d3.dip0.t-ipconnect.de. [91.42.197.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193cbc0bsm613401235e9.11.2025.12.30.06.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 06:39:58 -0800 (PST)
Message-ID: <5577900f-31af-4a36-946a-fc6a29e8be84@googlemail.com>
Date: Tue, 30 Dec 2025 15:39:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/430] 6.18.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251229160724.139406961@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Greg,

Am 29.12.2025 um 17:06 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.3 release.
> There are 430 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Happy holiday and a good new year 2026!


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

