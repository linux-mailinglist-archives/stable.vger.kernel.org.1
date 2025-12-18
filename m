Return-Path: <stable+bounces-202926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1E7CCA3FA
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 05:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A4BDE30143C3
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 04:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDDE2FD1C5;
	Thu, 18 Dec 2025 04:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aMIrmiuY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46019284B26
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 04:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766032059; cv=none; b=dQloWJUgB0+OB46y1nGjmx1635hK/VIFP+MS309ceV0QrP48D+U+xHkLxo98J6dkeXd7hQKBFi9MAAhGhYF7LwQCcik2Zj32xOvoo3r1cxmnZFX3WYldlPYI1o50WwAuu0wm5tsc9lNxysyV7h6QTe3Yr7Vj2m58OHGRreg0v2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766032059; c=relaxed/simple;
	bh=A15OPCRGZIJerJ1BpTiMy+M5eIcexW7rO+e7dVJ2RlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VrvYOh7XI7xylDspq18FQTkrchzfo1Fh1+XdkNbqv8luL4i2VPRG8QkU8oaOLqo0SUrAYRwQIBDr/z6t8QX0LAM6CZblAFPYlekO4Ls9hkdHvwyqyB1Q7LO5Y0XqcYtLAVwO/oqdHvGKZ2I15h5xVNBX8GbFVu+oBK/nUctNlBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=aMIrmiuY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47118259fd8so1571715e9.3
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 20:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1766032056; x=1766636856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gtZ7fSurlnkVytJ59b1f3UpXuglou2FwKhDHbnKcqSU=;
        b=aMIrmiuYsJ+a6DCMUYOnoofNodl+J7XbtJh/dNdJK23YePcYXkIU7czjxT14fxJbJY
         fEQUUcM/KlmNCLeQg6W5aoiKmsIRqJDWdqWQhJ/z6n7bPX0pKAPFoOHiCKa8ODv/HylH
         xOvSL+8twxPT0ZuadibWdGuxeWlSSh9BbQ8HCMk42hoaAnjZPnVX0vdCR9OO35KA/Bdg
         3+T2KArkFUUU43CX47XfbfLaBFA84PP+Q2kaYMgMhd/mIs5UFN3ysSwpoxfibocJVxov
         TEpiu9lS1y8l1NR6gDIGmfPiSGu2tI9RIyOsA23/WTsr6QKpQDqw1UzFSKXm2SXu2Smp
         Vdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766032056; x=1766636856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtZ7fSurlnkVytJ59b1f3UpXuglou2FwKhDHbnKcqSU=;
        b=HQolNA9LtaLWSxEuT4RfPk5+YysfINS9tn9uaCdcQYkxGCatDZg1xzXtZXmHmlSfjH
         nuXV6CIqgiZ+oEu/4TttJ2hL8BSBdVULECle60e0DAzsDrUvNzThzMtxT1eJbGCd+pDA
         9gfugzfRz7IN53Dvua2CGwZTiaMLSPuTl9GDLw9YY2vovtfRAPLDihVvOP3UUoHttdB4
         gTK/160N/3KtlzNNC3bFanaSrzPO+fHn3MU+Rr5CET3ITN+D9ewX20j/RL85AjEdfmxH
         NfaSMHaKHUtD/CyahrlroE5LkUcAx4Gg74nhOAFhX/kD0U8N3p1CE5vq+jbu2rurrYJq
         hnuw==
X-Forwarded-Encrypted: i=1; AJvYcCWW9VJdsrT/oNtbZlwtSH+j7+xf51mzj8YipX9DX6638vjpFUQCTTLItguuAXpZRx2wSE/Dcok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU1gI+PNA7z91AkIx7AW9I6RgSRXYfa2pwUNiKtx6uDQ0pIcCk
	43tw/B0z+XsnQN4+Fw38BakwU0YXVmOOKmeWGe7xQM8aFdQVG2XB8vY=
X-Gm-Gg: AY/fxX72BmYD+DhyvUHjvNQqSvxupy0BbABxClsOfmO8ICPR+HfPVkZ0sTZIffUHAUu
	Aatzv5XhD2W+61zkCoaEMS62BP9Q+TZlGHddkUr+jBPhTEeDMcBs6WcsXVGJ5MvhSuwH4rgOGtD
	YEWs3+C5r7KxVVnI9hgKm5Hb5RuAdCAaVPylxc8DdlWBhBKV76XDpWDVvJYSDw1uvWhDi+Stxib
	XpLFiHMIMftuf7uPcCEKgWorenceTR1wXN994rt2Y2wsdm7aLsC1NbcL1dVQWty4hRx3/O9LeEQ
	IbGbyXY87NR8oxYVASn/HeM5KcASBoR8nv+z7YuXJHPjGtaGGV1fr9wnpsSju1m35bfSe4rmzDV
	v/B70C70j0qXe1BQGH/Oe9pT7EuZ2cuwthiYADYNbbmZLn4xal2gS5+bmh0lroyniT00RHfbIzi
	rsjAX6HFVgWRs6vtncVKjAsd9vvmfK8E66g7NpygpszM7CLn7C4X+gY0eKv5MZH/A=
X-Google-Smtp-Source: AGHT+IE004Pthl97ocz41xl/+e+FDIlGp7UlU0Ni94x1OIGlN0RVzcLlxRTwcBzPg/cyfw8gcodUTw==
X-Received: by 2002:a05:600c:190c:b0:479:33be:b23e with SMTP id 5b1f17b1804b1-47a8f907d4cmr230638775e9.17.1766032056406;
        Wed, 17 Dec 2025 20:27:36 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4078.dip0.t-ipconnect.de. [91.43.64.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a541d6sm5534185e9.8.2025.12.17.20.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 20:27:36 -0800 (PST)
Message-ID: <79c6617f-6ed8-4bdf-b44d-aa2086a8c5b0@googlemail.com>
Date: Thu, 18 Dec 2025 05:27:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/614] 6.18.2-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251216111401.280873349@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.12.2025 um 12:06 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.2 release.
> There are 614 patches in this series, all will be posted as a response
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

