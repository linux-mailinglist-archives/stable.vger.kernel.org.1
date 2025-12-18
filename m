Return-Path: <stable+bounces-202921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E00D0CCA2DA
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 04:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87EB0301819F
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 03:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561EA153BE9;
	Thu, 18 Dec 2025 03:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HZA4ttqS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262E725F7A4
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766028635; cv=none; b=cvWt8xp+afNTkj19HAh4hZvny5W22M18TIIyH4qSgTUSfaYMWvFyuEnzF8tccsAmGAvSedqBjvhwATdFZxtNWUXdI7QmDfYzHIdhOeegnmilPtJAMiaQSkEjbbP687yCSLjbeb6oRnisX5bs6iTWmJwP8Rc1GuuhyCY3B58OuJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766028635; c=relaxed/simple;
	bh=ZuW0HHtMtpR2twFPuMYidJ4Y6icF3skEy3uXtr0ISxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V66UJLw6fg3jeSu92KTW5djLbE8Touq5qKBq8dSAzoJRnpmVMcG/gyQjMas7GWD+6sfZc6v/+aMO4P/YAYGffXU6muNYnxa+qCmvg3dvSjydnFeGsNSAuywM90GYaj9/NOWEjYeVqq7vlYJBzEZlIkPQccwXdhNWHnTZY0JDRA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=HZA4ttqS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42e2d02a3c9so62096f8f.3
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 19:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1766028631; x=1766633431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pFXb8Nk8geIO1ZI7yC9fJXWBAudS/MgVgGUkWrMJh6g=;
        b=HZA4ttqSQ2poQVxI2xggr7FJeGpPiYVrHM3FF0v4ajuflcaAe3X18gs/kxS638ZIhz
         9emcMJIAAUuoa14q6OhgIijX2vYfipAR66dqjqfr/T8HaWFuduf+DlmhwQMD5YvI/lnu
         FJ/mHBwoRdQChJy0A7NK1h8YOshyWGhnVJEWI0hTpe+8coR6RrnyraAxFUH2xmhjeLso
         cg6Oi4+c6XTJHernOp/1JEtTqD1qWMr74GrL182SvQKcsMsd5NcOKsD8W5Vilj2AgxXD
         uvWptydwknTXmYcEVXBY1rSXVCchZegtv+d0ix/Zu17Ao6D4+dVlILzERESDrrEzbJcV
         q5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766028631; x=1766633431;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pFXb8Nk8geIO1ZI7yC9fJXWBAudS/MgVgGUkWrMJh6g=;
        b=pnNQFBsPnsns+qFHNkxWg7NIOXCiaxyg/o48u3+lGbW1xDJ+U54zHmOIIyvfTfiYVK
         nJ/50oEYmvHZlYt8myvtjY98Dx+B1rSLcoynlU5OMxyB+70MCHF1x8eTzFTdTLEFQJ/n
         qUL6nisUGeRF3s1FnbzJS2qAzEe+MtwPgcpMuy0h+JSPlTdDi7KRNa+8WIu84xPHm9T4
         hZW1dmFfZvLeKBybPAy+F8/5KDZtw74CyIvES009OxlGrKeeOD4wMGKeXc1o/gKXoz+d
         9IkTuwgoI+d4CiBi1rJKwCdaoYtxsekDEmx8/QfPoDsAv0mPO3lEOh+QGzap+gCkUlD0
         MmwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJAn8vjmCF4/aJok1Cw6SpTTzlfBG8asK3THS9cwUMQyKZY3fBvSxMdKRu0mhoWZMapUcOLf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4GfhdLJ2i6cEh/D18OdyAxFiXthya1cc8jcb5Iqcx+cTueobK
	Kt0AZWtM+XKlo3Q3hyKLfgtse1ls2RT6XLPvd1ST/k4RL9+lvyROxEJ7CSYe
X-Gm-Gg: AY/fxX54WL2+k7AOkq7pvWCbM3Qdg53kCFOoTOI1IVUBvQ1ZHLrNMOPEUtLxDt5FnN3
	eDBEQDYw4ZOFYEY8TqG7KfMdaC+4iUrDdjiUvQwOhKmNql5ubI+Pe7g94ovfLIse/Zw3JTB6/l8
	bEPvpi+v0+usEJG0k5P6VbpZqUdGvgO61DqP/S28xjIRrwGggj1MkvMJY3kQKjfGgcVLaChFy/O
	tjUtvWWkwRbXY3i5tiWvXHJnRUSP2PHhu2Oqhqqhbr60QSSG2UZhwXKBxrlk2TR6if7GTLjFg4U
	5FxHMm1gcQnlDV6wCX/aQkHtp4nVsTCvFOKiG/EedpwMrDHBYOuTHQjXnho93zyHalxOSeNfOEZ
	Gcf7KW9zhr+6avLSi9qyV8cJhFfyKHOBkhE9cff1l2YPTo+MZxrhCbzK/J1U+Ov7tWUSNnTjqSo
	VmQwfhl7d8cw0MX1gfK1R1x/0AHi8FkBf8e3GoGxkd7gkr34n+rcw+FQtQNlGxDbjxeFFTqeSRr
	g==
X-Google-Smtp-Source: AGHT+IHzHfnDgvekUsL5fXyQMEtNxZe7kspWphA1s8Mqlp4zif0GNcKB26q2cSPVHlHfvTRuhf9hzw==
X-Received: by 2002:a05:6000:2909:b0:42b:39ee:2858 with SMTP id ffacd0b85a97d-42fb490eccdmr21068273f8f.42.1766028630989;
        Wed, 17 Dec 2025 19:30:30 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4078.dip0.t-ipconnect.de. [91.43.64.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324493fe32sm2410281f8f.14.2025.12.17.19.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 19:30:30 -0800 (PST)
Message-ID: <12690fd9-0060-43c0-910a-3dce4e7ac45a@googlemail.com>
Date: Thu, 18 Dec 2025 04:30:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 000/506] 6.17.13-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251216111947.723989795@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251216111947.723989795@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.12.2025 um 12:20 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.17.13 release.
> There are 506 patches in this series, all will be posted as a response
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

