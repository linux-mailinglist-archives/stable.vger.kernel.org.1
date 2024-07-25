Return-Path: <stable+bounces-61793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC7193C9F9
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 22:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672DB1F215AB
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 20:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9867172F;
	Thu, 25 Jul 2024 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GU34/1Pb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C4513BAE2;
	Thu, 25 Jul 2024 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721941032; cv=none; b=N772N0vZDyGh+JC0uWegH7EWf7Sn1EzLDTmayFUnWMR7AEA3kRgrpbkqFd0EQlKnbfcedVjvzvzOK7dG9JdGgcSUBZirBc0dCYxPGYt7FoXJlprNJBAYKEWei+8cNI5uXL6l9qDEyp2WiM1pvJP3sjrlUpinhj6k8Qenw8gjFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721941032; c=relaxed/simple;
	bh=reOOWCtPXHtudVyvhtpVFQaCkI0eAVibR2zDwbghal8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIK1VPWOydDR/N1AePruu3vznSVveh+7O4z/O6NiUhlEXjpSEswgYJV73+VLHY/604wUdtVlF7u6pIaFUfR+n09jhDy3TYYiD4Vb71HwhyS5BOH0X9qAqEC8oNWx5EZaEb/TUHTXRZLDJg/wsyf5ef5i+70upz6Qd/V3ixU35To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=GU34/1Pb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so174394266b.0;
        Thu, 25 Jul 2024 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1721941029; x=1722545829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ITLRKgsFGJ1CBYARQ2ugrkuk06dIpFRf6Suyurskfbg=;
        b=GU34/1Pb4TUyceGHZfTxiJeOy3i40RcrR9euGlVb4szjRdVAC5+6e54qfKRnif2x8/
         tHTdY9thB4O+YtLr4EzC073DTHakbmmrTXAsngEr/JIldLD3l63a7ZY9G4FCTNBH8Q/z
         zS1zCkLfyccaVESZ0YiDX+VVZJ128NubavQs2exUdEiDU53FRnEe+UvDkNXpmrUgwvqq
         /jdLDvFUhtnqLdG2yT6Zs+bkvvDsJi0iUjrFf80ZzFzSjbE6iH5989oAeKsSahY80LFR
         r2qP6LvDv3xr8a8Sn00EaO0wNcC+2DAUtJY+yr15SHE14/H+9b5Za1JgTvP+FRPMhgAK
         wGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721941029; x=1722545829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ITLRKgsFGJ1CBYARQ2ugrkuk06dIpFRf6Suyurskfbg=;
        b=WJ/p/8v0T5YTDCwiMAqgC2Nfv61/wBB0Vb/xUwJNo+/HVyGc9c1ev8+2CFW61K9SkX
         twhB9LYA6aCcJZYvydksLo2gFDfgYEftIu8064IMQleUDqIgA6mrwcKBOyhYITry9MgU
         rzPJyTzq1u13nP7K1DO6KtKU8AXrnOFjWcwQCg2TDhpvXSbzPqkFO39YQxNqFVZIVrJ/
         tVgx4O4XOFd+xpzpSCX3chfb1BfkCwyshHKxlQYDWV9CYsQxhKJJ+vrwDIXpaeNeq4Cw
         42Rm1KfrAcjyPcQvWFDSD0KKeV8XQ2+5IO2AmN+2SzbzdQe9k+89nzRpG/Wa1MaN/iKj
         5iSg==
X-Forwarded-Encrypted: i=1; AJvYcCVJAN45k2I88cVPyHGP+uvPtX8e8zFCtdx86EzeVA+EElM6JSXMTLJpYTWqrNyr8f1XaZY5pQb+w0oAZdFLp2hQA/Kfkr7gK51obs8uRJCMHiYxfoxaqSgLbtmbi5095h5Pt4ds
X-Gm-Message-State: AOJu0YzVhZVets3UMZ9+pB3p2CSwV7QJz6m6zGmAjVGUBbwbHOOHYCpo
	r+DunJuw99tuuPZIH4vCvQraghqXuNaaCyzSc/3/9rZFVzWTAnE=
X-Google-Smtp-Source: AGHT+IGZYxgmpffCRJ6OnzywU/FMC/AL5aA+XJHC6Tx5WDw/6vkELco3NUcaJSTEAl8rrmgCXbdxlg==
X-Received: by 2002:a17:906:7315:b0:a7a:b561:356d with SMTP id a640c23a62f3a-a7ab561632bmr661063766b.26.1721941028724;
        Thu, 25 Jul 2024 13:57:08 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac836.dip0.t-ipconnect.de. [91.42.200.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4dd63sm107078366b.55.2024.07.25.13.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 13:57:08 -0700 (PDT)
Message-ID: <871137f1-d889-40e6-838b-8522575a3fab@googlemail.com>
Date: Thu, 25 Jul 2024 22:57:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.9 00/29] 6.9.12-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240725142731.678993846@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240725142731.678993846@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.07.2024 um 16:37 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.9.12 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

