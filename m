Return-Path: <stable+bounces-163152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F013B077EE
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 16:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6160F4A758D
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 14:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7B421C18D;
	Wed, 16 Jul 2025 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Fz6Sxe3U"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC8521C19E;
	Wed, 16 Jul 2025 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675834; cv=none; b=jH8BcpjBxq9amBU603qSSK+tig4d9HECHjE3UXSj3rhq//WfXQeziuSMNiZPZxywN1NimQ6ZoNJa3fE/lDjra0hW1OgRt4m1w2D544eq6UAOWUx9SavcbaXiA7oxi5N9/YCx6oMUK1dujbKZt2x+blssVCgl5y7tBhLA4a2qp7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675834; c=relaxed/simple;
	bh=1J6amv1Fd0K9TpjyRnFTXnqh/TlH+R9j8mzvr2ELGNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKrsLNKbRIsrIEG/c7RWGOqm/GQE9uPO2d9nE406/EPVt+bSGAi4kJZsIWFdNcuMnk31pdb6Q4J0boSi9LV+lq2wZKnb66K2lhcbnA+LzbJ31aoMnqqAdaehkfU218L3bKj57z/0DUFpUSLLwqZay1w/52bRSiUlWXvEHxFWQ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Fz6Sxe3U; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so5310692f8f.0;
        Wed, 16 Jul 2025 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1752675831; x=1753280631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MEG+ijLUVxzyNdcTcHW8K0Lled6rbXTk5ryewZD9R5I=;
        b=Fz6Sxe3UKS4xL1zx7Prxl6qmT39vmzpm1sbGJURqIx0e30ubMxKhIT/1xbuvTV++Gq
         RaetxkDvmCxFGL+aHjJBl20UX/LHaWQlW0H9yer5K/YgAWOEQvpN8MMY7Pi/i4st5tl6
         EfbvJHiLaG1PeYpS6PKF766HikzhVY42+1qyf0C2Gl2u7VUuNU1J1+nb0vp4fZ/l+jn8
         miK90Ye3Oak9jNCCchrdOniQDMz7YE71oVW9pOcFNjB7F8G2Xy6b8Yb2pi4QwdCgScx8
         hdd8g6ZUoEMC5wV3dQtvKf8IO1MjVB1Jcj+Zzk5JMjOD69xMnT8D1vF/aKivqzSghUIA
         cvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752675831; x=1753280631;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEG+ijLUVxzyNdcTcHW8K0Lled6rbXTk5ryewZD9R5I=;
        b=Az4lPuIib3DdNT1ytRg2ADb/fwiAfTcQZYLRGWo5IEyYOCIA2U2Onwz3H1ZCZY6ELQ
         PlGxefi7hDdTbllStCd/ltKbB5JdKbOiwE4MGUvkFNXYW19csdAhX3yVzC6O0rqmWqcu
         bdSe6rNfMkV9tiZwu1IalgpdNfOVXhxY+FvIm6w+RVTWpxGbZXqOeyWkMh5aaIBm5JWC
         bw8TB9dSenS8z6Fo1YHjODLtSG8E2UwmJBHSzJJBCkU0mOqtT/sO3FSU5Pu4lUpmOvTI
         JY6B/YBf7O7M7J2VQr9ltiSBOZ9l+jaO7UW/ocP9O7KB0tSqXqVvK7WsiP8wlVcc4ahK
         xWEA==
X-Forwarded-Encrypted: i=1; AJvYcCUbiraiwdg/sC4mfLXR0Z5ubthFfCFHI6ycw9cdmjR2oSk1q38fXMG4wVA6/lngsDmm2lKpuj+jPpH56JM=@vger.kernel.org, AJvYcCViPA1xBh7b5nbSmrzPMRNXJoyQLvzKuEQ09lV8lD06os7ASp3/YTrHhPg6gbFdSZzdb3KaRKQs@vger.kernel.org
X-Gm-Message-State: AOJu0YzoDwhbXKLw3eIzghYzLoCFGU3MD+x+VXHhgFcGqtfgzMjTanhf
	itByDJU43duf+PeuEYhFnEnlDwaqhAm+YMOd34FmZj3Zqnd+SjpnMes=
X-Gm-Gg: ASbGncv6MzXDwY86SsCc0B9VD3OLJ9Gj7y3q++pqvfq2jE6Oj6ey3sqbEKncZ851fBF
	bDAHtvc8HEBy2/nCB71qM/HKr4pnfPGU4DPGTs8p8vmzs70xTbWppLVQD8bFC5Ca3IbIjrCEVWj
	97KNdLuqLiOpV4+MNNnudXrFwzCIHUctog1B0AT+qEENdsGWhfFpPDPSC0cHzVY54Juw++9XzNl
	/s8ZFaXE1OCLa+cKqJtsD/PxOG0biC22INSCOl14Gk2f/AFOLoztMjT9EzUfb08zZm3wPhgbfKH
	3dOoESeh4CBscwZ7eJIEKN+Da0nmcytI98OQsfMI+bciArB8HwXAqiu5O0NhanCi9x6qzRrbNr6
	QIZvcrIZJlPVqsU29FonRZMe9XPnHxTp1EL+spY/2YnMXjsz/io4l0MBa8uQERlLwaSAS1JWIAp
	Dd
X-Google-Smtp-Source: AGHT+IHhI/TIUUhLDO0rMmK1ovj4+fKSuaVjP15PQzbpaq+R3tp3ljl/6PzIZn1AxYKV2l5nahwdNg==
X-Received: by 2002:a5d:5f86:0:b0:3a4:f7e6:2b29 with SMTP id ffacd0b85a97d-3b60dd4aa83mr2830495f8f.5.1752675830522;
        Wed, 16 Jul 2025 07:23:50 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac571.dip0.t-ipconnect.de. [91.42.197.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b600a39281sm10326796f8f.73.2025.07.16.07.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:23:49 -0700 (PDT)
Message-ID: <d992fe14-c5a5-4d21-9a24-0acde9492576@googlemail.com>
Date: Wed, 16 Jul 2025 16:23:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/89] 6.1.146-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250715163541.635746149@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250715163541.635746149@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.07.2025 um 18:37 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.146 release.
> There are 89 patches in this series, all will be posted as a response
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

