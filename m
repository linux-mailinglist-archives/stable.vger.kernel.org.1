Return-Path: <stable+bounces-132023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0755A835FD
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 03:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199BB3BEDBC
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 01:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CDDBA38;
	Thu, 10 Apr 2025 01:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kw/L47zn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C053596F;
	Thu, 10 Apr 2025 01:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249766; cv=none; b=Iv3qbnLt23FF9CAAcnZagtjd3oQC3xBZLAu/CaweXdXupDjU1EklXZm+BTZJZHlMnG3B+agUSytLSqZA//c79rV6PeTXa6zOacLFFQ0rR0MJpWFCm41o7ZHwanplFLZ91Xc0Rdr29LMPa+9F70TZUmLZSV5Je1AHbRB1j/tyj+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249766; c=relaxed/simple;
	bh=QbOiQ1nYOQfWLCVZ+eyGTsYJcF7RW5gz+uB+G8G57oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7dc4LXrvorIJB1YcCN/hRZ8xgs6Sx2JM27hkmALdtr6Q9zz2e+/n7CAI/AtVcfP1XY4txpR250uF6D5c9l7BQV0y7BaGBXQMNdvTHGP5mt6BGxcy50a3KUgm9AVDeC3ivFrEaJvHXUecD/+u6rU1iwP7x2/0hG01cDFrzrajaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kw/L47zn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so2480455e9.0;
        Wed, 09 Apr 2025 18:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744249763; x=1744854563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=US/93GXeXTgfvTRnA96LVdDtkq6EvdD9QSlkyFzDzNs=;
        b=kw/L47znvNaywKkIz4kBBTTwDKMHx0/BgBgUibWgYVilIncVH6FYnthC9fWNnBO9RY
         aAugNti3ziMFAS+PcIXNM8Wl/xxNdHzJ1oUcsEGF87HHMEBNv7sZRMZvnWIUeOPdjheU
         jjh0lbkSaavQHNZP0gB3eqncxxXVUorEmhNihVp5Kkl5JX3Tw4m1LWy3pk9TLNIx3h/d
         dHCIe95jXVbg0kwsEIx9PHx0QdH0aryFVZZ+SIyCuna5+Mm16KD0KLz/08vhd/gepBWB
         uCZMYPe1R82aFqIS0Yz+bD0aPebUFLAVgqrgoHwsreQjCbtFfmCXyS6mo49zhqqadHhC
         U1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744249763; x=1744854563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=US/93GXeXTgfvTRnA96LVdDtkq6EvdD9QSlkyFzDzNs=;
        b=fOOGBGLxejmSfxDwlmkOlIySq5gZtMzmTxKYqg7De1qqJ1Ob9iw4rBMquwxLiBQcPe
         kqs4b1xsbRFrD+GJuRK1XfIw1gszVtVW0voB9eXgJ2LNhmELoPZ8SyRDReNn5kU1pHK3
         OdA8K2M0FqFialzX0AHkS0tIGPxwxu2hvVHJiBFmfq7BO6Om5+Q5y8ISaU8sWGZ5Ruz+
         WUrtByzICq1bXUQMYuU6K6Q5zLgIrw8FSzidPEgZyYkibiPgwkR16sgiEKPwYifHlrph
         0EWfUUne4rd7iXamwx7vUG5AWyFjUKBgs7cuVP8Ks0r2gtBGlAYl7qlRL0i9Xo/QpQJb
         B3lA==
X-Forwarded-Encrypted: i=1; AJvYcCU0NpXElMlKSFmgDlxVB7xkSyAVNX3mMYFL7oaSkvLUfsfvpdzrMSzdbJs7R9BTMpw7Nw19/DUc@vger.kernel.org, AJvYcCURd8VZ3BRDEl1FuDNz059MBnbeWi5I86uoEzn3nQsmfMbKF4e6pPFksquHkaHQoLaD9EUz93Ti69m22Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm38S4yuRb4XmBBB5o3s47EV8LPRnO9xRklF8aT/c5MLJ2T5nq
	GN4jtJrplqLdXptDtcYeboK2glXAKVD7qpOP9t9pdcvZRQRqzFU=
X-Gm-Gg: ASbGncumBvJEg0zHZ//VnpA8EKtelfIJJfNAifeK2sosqqY/iPS0ayaVymPVFmJKqu4
	QgFGKxHvz6AqWI+hS2mRQJ64FRqTsqz4m6oauJn3YAqiarioc0WUxISP5tLW1MXr2W3Dhk7ASO2
	+VUYz42e+EDo9T80nJpfNYN2cjYweKIQQsTfBut95qhUs+4u1ahwqHHqT0S8nZ1TMkbhuSD0DSX
	BLb73BDFDb6vlpweQ7w4dwdjtyQnoz5nkqhq37lifbBeni0UzSpLvbI4Mx2ZuxFUAVM7N5kAYkr
	3vg/fyS48MNcyL4wpuGXWHmfQcrUyZpezMzyP+PUiC/Bjgd5AMFe8LCrjrZcD2V8QDG+ewiquT8
	lswzvIGMn6obhIAIwrn7Lu8kLgT4=
X-Google-Smtp-Source: AGHT+IGlNmXyMPJq8uAFhXtOWlFS0c3JwRUhEtQRvrZwa6KEaViHMDqUqDsgIaCo9LPwKNENMcQMQg==
X-Received: by 2002:a05:600c:4f4e:b0:43c:fae1:5151 with SMTP id 5b1f17b1804b1-43f2d9599efmr7124165e9.25.1744249762599;
        Wed, 09 Apr 2025 18:49:22 -0700 (PDT)
Received: from [192.168.1.3] (p5b057414.dip0.t-ipconnect.de. [91.5.116.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075a593sm37639925e9.25.2025.04.09.18.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 18:49:21 -0700 (PDT)
Message-ID: <3e6ed40e-85c4-4a10-af2e-94dac834840f@googlemail.com>
Date: Thu, 10 Apr 2025 03:49:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/426] 6.12.23-rc3 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250409115859.721906906@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250409115859.721906906@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.04.2025 um 14:02 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.23 release.
> There are 426 patches in this series, all will be posted as a response
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

