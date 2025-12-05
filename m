Return-Path: <stable+bounces-200156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD9CCA7896
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 13:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85E78315B88F
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 12:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C3231A046;
	Fri,  5 Dec 2025 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="VzCGea68"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C1632F767
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764936719; cv=none; b=Lysc2DiGfVsOXqZ/Rrax24vLzo9rGMomkO8MnFgBih0gqKCsGuzewCoViUmhkLFHdmec4WhLTJUzmq89mN3py2Rv5h9X+uQ5Phi9y3weMXAOrBS+/Vx4OdIa3bB+OtRpsFOXrbVm3k2iuuLBxttUtcfVIWLgV+8GLgAvBxHruUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764936719; c=relaxed/simple;
	bh=qhWS2Ov2yo+WOfX517AcSfEUE/SzcRZure6/nh2XuAM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FadIAdkME8WnjyTl+nfsXs+Ofqja7CVBvG2Yw7Oycy5uLNidBF1DDC0p9I7gxvXJWV+S7tXpl7hIi3N8j7PrYIp2OSPOlh4QkNHY0yqebXIzGkzMM1OEM0F7kK9v9eFnAUQXFh9PDU2Jmzfw0mY3x+ix0qg0BNK0A1Zf5NG15Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=VzCGea68; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78aa642f306so19739897b3.2
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 04:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1764936712; x=1765541512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+DffUo3SJ7992WJ7Sey4PawC2I2N5kwS1rfUFe0ilrU=;
        b=VzCGea68ZTjnRsHkfk/P//OanasmjXzMBB0s85oIDur75s9WpnkDy+uiCHd2Z9prpy
         DLJ/oSi7USUsYrJsBLKB0Upxh/AgiXecqIRIamXJ82mf3xbaYK8UOMp/YsJGhAgdn+LU
         SO6vKjjy9ldCgDXnSRiYQXTlsgv5Ry5oDYBhqIUoCo3G1Mi7DBu9GWNmLVGsyLNemfiG
         RNqOHr9CtRVnKmX/jkEg/iJMVP0wp40Qdi/Wu8L7iUWNCpGrNtgI/akTIQ75gALcu2Ft
         K6BUPImvsRTzVVpKGTI0pjjarSOAPCEFk2UKVHdALvt7NssMaYIXa/E9sx7hEdX6YYLk
         9vHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764936712; x=1765541512;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DffUo3SJ7992WJ7Sey4PawC2I2N5kwS1rfUFe0ilrU=;
        b=VqFeQO6JEAhG5JgBNvQo1dYTendpV74c0dQKJIFZo7q47BoyRddoC5XXW1DB6rs+rh
         oC8y8KEDB15HSgwGmZb4sIqw5wYx1l35j/C08Tt7YI3fJ/wwz3eqrKrBHbh3qbbrlA1q
         6a7RJzsRjGunlU618vDVyS5HGwC0saSiHzB2BMDF7eFaHwpKSIiIsjOU0Jh9j0l2BVLO
         k1nXPSos+JNk/uMmxta71MxXw//x1NJn/oFNA7ybl6BFOlqJXEkKInUtYyNB6Hkt6MPa
         u3VZVxTIoOUrFYocRI/kOZMIsqJDxcUUEfSR7FkQGOrh7u5VfLniCVhduFynJC0fZ4Qa
         bcww==
X-Gm-Message-State: AOJu0YwBj0EBrYDqKnrZMylo/MpSLWltFeq7g1mCHgLojHE3o4UQJZG8
	wmPAr4U/7GFK0bPWUmoKLeo/dxAAB/FUUN8nxCHnQAIve/yfPGmOms4ROXkrEVeSqk8HN2v5Wug
	xR99VgnbHquN+Gm4OSD7KZcEMsetF6952D9DWlYpBhLc8LLGu3w0C
X-Gm-Gg: ASbGncso9U7vUK2OXaqRn9d+TCbn1o+xjeYG4kQGHUOxgOr3QH0LKVIaKgitedF65vJ
	dF2+sAgGc6oRWfkXYn2W7k23nQ3OuIw55WCpGm3BGaFTwpzLNrEpaX7eUaocOi10g53QCQI9ujG
	9gATEJYpLSxH8Hw1wR74XKFx7411y0nBHxv27QyUwkP/X6iVzW+L4wz+HJ9oWvqZwNZkpbVwaFS
	nK6Qlpe9CCOQt9uYgNBVmAnVcldmEJLDJWp1UmMj9JAPqRu1czhqdNf5aqTCKjIkTeANoVoiKEH
	BXe4DnqpmIrFLU/lU+oAFB6Q1pvcRNPzXMfRuEwb7F+bUNP5dk1dNVMMrzpczEmSTlj8YNnXVrv
	0Q9tjitu+u/3Nm1eM2fvNHjRQaJ5OPPtvExARnKHfXwK5lIbDRbya853yZMQhofzHD/H3E7gwYz
	dQLb+N6Mv0h9Sxu7Mmag==
X-Google-Smtp-Source: AGHT+IHYVc36cpPq5ngmR0YZqgbwnuoCOebtHGfs0UTc3oJvrCemjRMVEE959gySqAQH3Vitb8v5hw==
X-Received: by 2002:a05:690c:368f:b0:786:bce9:b0f with SMTP id 00721157ae682-78c1880c433mr56494017b3.14.1764936712395;
        Fri, 05 Dec 2025 04:11:52 -0800 (PST)
Received: from ehlo.thunderbird.net ([174.97.1.113])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b78e8b5sm15998697b3.43.2025.12.05.04.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 04:11:51 -0800 (PST)
Date: Fri, 05 Dec 2025 07:11:49 -0500
From: Slade Watkins <sr@sladewatkins.com>
To: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org,
 pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.17 000/146] 6.17.11-rc1 review
User-Agent: Thunderbird for Android
In-Reply-To: <CAG=yYwkbpW8KG8ks9QGfOroV44sishtjFwvhnxBpD9O2en+7Ng@mail.gmail.com>
References: <20251203152346.456176474@linuxfoundation.org> <CAG=yYw=7i7O7nLLDQ5hdP03wHFSQ04QEXtP8dX-2ytBmiJWsaw@mail.gmail.com> <2025120413-impotence-cornfield-16aa@gregkh> <CAG=yYwkbpW8KG8ks9QGfOroV44sishtjFwvhnxBpD9O2en+7Ng@mail.gmail.com>
Message-ID: <F776C81D-B1E8-403D-848D-1C6A189E6740@sladewatkins.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SW-RGPM-AntispamServ: glowwhale.rogueportmedia.com
X-SW-RGPM-AntispamVer: Reporting (SpamAssassin 4.0.1-sladew)



On December 5, 2025 6:51:36 AM EST, Jeffrin Thalakkottoor <jeffrin@rajagir=
itech=2Eedu=2Ein> wrote:
>On Thu, Dec 4, 2025 at 9:46=E2=80=AFPM Greg Kroah-Hartman
><gregkh@linuxfoundation=2Eorg> wrote:
>>
>> On Thu, Dec 04, 2025 at 02:38:10PM +0530, Jeffrin Thalakkottoor wrote:
>> >  hello
>> >
>> > Compiled and booted  6=2E17=2E11-rc1+
>> >
>> > dmesg shows err and warn
>>
>> Are these new from 6=2E17=2E10?  if so, can you bisect to find the offe=
nding
>> commit?
>>
>> thanks,
>>
>> greg k-h
>
>hello
>
>6=2E17=2E10 has the same dmesg err  and  warn =2E
>

Hey Jeffrin,

Can you please bisect and find the offending commit? We'd love to figure t=
his out, but can't do much of anything with no information from you=2E

Reading your previous emails on this, it seems like you're using a differe=
nt machine=2E Have you run this on your usual machine to see if it builds?

Thanks,
Slade

Sent from my Pixel 10 Pro XL

