Return-Path: <stable+bounces-200729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D197CB327A
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 15:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DACC9306B532
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 14:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD881E5718;
	Wed, 10 Dec 2025 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CvwwZkg5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65824611E
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765377163; cv=none; b=rbBTlmQJnayxoxI3RRLEVEEwaRvtTmg/W2bQD28UoEqiRlSh8cbIni9cWELNs5ontpajE9IEUMS+p0sOhBLFzPQIBbd9kcg3cXFjbq/p1U87aBIACNXdYbPBvYFOFYFzh77RcJ0bdvc7w2PwnhYZwS5EBjIEKcKU915vQdq9QgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765377163; c=relaxed/simple;
	bh=fAmHI50/waGR3z7XY5kpd2brU2wCsvTvGmBEwVhQqtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Spq7HUUtD2+tH8NZ09O0BVsPKI9+0/MsmgrK1ILkt8a4L10Ond/ZYZBLtBWcz2xpAk5lxNedLq4/4/c9WQL6Sx1saxzMS6z37WMCv/qsBU3NCMslejqymiXCHe13csZr2KgLvPe0ekJ/fH8gOTSX9GgEiKN5/wFMfq8sASTURWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CvwwZkg5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42e2b90ad22so2575533f8f.2
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 06:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1765377160; x=1765981960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+dq+Hyfal/ZttuoO9xr+RdC3/nhUjFhoCMQdO6MBKw=;
        b=CvwwZkg5HNLR4VIHwIZo5feRkQvNssld/rL0kMUkTwX938TY3FQ1CHjPbqlRZTfJ36
         +6X1XIUHMiJvjdr6uRb85KBu0p7+7U40HB93B/qK7ZA/1JiPaHcQZN3WCjUnD4/52pt5
         +g/ZTwytQNCYfo/69GAVq6e3bSB/VAdCb/aT+ojPSzV2afk8oXWxmAEmwUgWxHxj0FdB
         ps2s4hcQ2iJ8zD+QbKyDw6+CTg6dZCXB2Z4GhOe+Gda/KgX7avp7xmOlu1vL+lZC8Gh/
         3ghCMLBT5rH90y7I/ZXJ4oKk7x69MttqhllDeUxhmj2/+C+drgP5sYA1vZpiTHX1dzgw
         2fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765377160; x=1765981960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+dq+Hyfal/ZttuoO9xr+RdC3/nhUjFhoCMQdO6MBKw=;
        b=FcYQudtpp2RicWUM0/qYdrc0YSpcfYlP7EmTsxMv5glal9dlFlMKsljTemIF5IH6SE
         73EqRXNMcN7l0GE6gu1Dqc8hNB8h3s2ghk5L3vyCVMuIzEBOJQX3X3vQkHVywlDNbNOa
         TxoUhX8hvFTflRKucjNFUhMghNsmTYRgMBjdxU5UPdmxQ+5pB7YGvr8XB6UAa2/NCwaK
         u//LihO3oJK6QpDAGlmYdMqE2cL8ReXrB7D7QdiqqVOoKOHO0p1PwwD/to2qaroFLgOP
         HhCrDrdiN9zdyqK94EfpKYr34+ENjVrHNIRmrNxBXQrvyOoTX0NDieER2+/bj58yn9A9
         pwDg==
X-Forwarded-Encrypted: i=1; AJvYcCV/tYB+MfTLlailPvFEE6A04+xU9nMfasN646ImrqRmqMIE/SY4/RoJhpAL1MaTyrOPR8PZN4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1OkR1V7mFeeDZRVvn9yLlMKE9UNMEVSIVJFrBpllmnTjo+s5P
	BtyDWStV0BWAs8nJeNl53RNqB+ub/kcRVeUHo78QBLOO3OSiz1XOHCE=
X-Gm-Gg: AY/fxX6XEuR6H75GlRTryDwEN7KUpHPejdHohv3CvNtDavkpjngkJJKGnPZ5P/sEan0
	pKhVpAsoBboKGtN9XLkNr0kg1euTpA6iiE9Mb8dfQdWzgpYddhL9hLzxUBq9qzZ93tSBt0p0WfD
	2ocxoDCPhHVW6Dm7mEK81JPpHrJSkulf0gxmNOKlsB1rQpD7L25qyKdGNf+aQPUGHM9TIjSm5Y6
	Ze6CTx8bAKJ4u3HsphTm6zbJZUk1kk4OiZtKfFRYXAF2hHZJFrh3hf7wTNzulI2/Dn+G7RdOmsQ
	xVpXuK38En1X+SS6dfi9PQrCA9jFSbb2bHuPzIOmnvnm2D+rZPjd9Nh5xfRONuW0qjspd3vIMsG
	0pZzNd1Sm5AK5+fIExxevTqNIrcEYyGc7VYPQW7GOR32J7uS8Dif0nWUQcoIFWgeqCDYfEITh6s
	LQmWc4aNFPKHNHNLiOmiXYSeoj0Es5aE/o1urm6hC0Hm/zlhcc/dI1nTc4BAVTog==
X-Google-Smtp-Source: AGHT+IHd9MBXT6aAV6EneO53yAWXLISadeliQ7pHB3VOO1sKMQzKla0za+YrPjcFB9b9tqA+uscL1Q==
X-Received: by 2002:a05:6000:603:b0:42b:3bfc:d5cd with SMTP id ffacd0b85a97d-42fa39caa5dmr2639118f8f.1.1765377159473;
        Wed, 10 Dec 2025 06:32:39 -0800 (PST)
Received: from [192.168.1.3] (p5b2b444c.dip0.t-ipconnect.de. [91.43.68.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfee71sm38244056f8f.15.2025.12.10.06.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 06:32:39 -0800 (PST)
Message-ID: <6050cd73-c869-4bdb-b445-9c910a7e2caf@googlemail.com>
Date: Wed, 10 Dec 2025 15:32:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 00/29] 6.18.1-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251210072944.363788552@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251210072944.363788552@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.12.2025 um 08:30 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.1 release.
> There are 29 patches in this series, all will be posted as a response
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

